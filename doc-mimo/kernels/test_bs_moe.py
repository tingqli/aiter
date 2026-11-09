# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""FP8 blockscale fused MoE (bs_moe) for MiMo-V2.6 Flash/Pro TP8: correctness + perf.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      pytest -q doc-mimo/kernels/test_bs_moe.py
    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/kernels/test_bs_moe.py -m flash pro -t 8192 16384 32768

Reference: FP32 math on the quantized operands for a random subset of tokens
(x and A2 quantized per (row, 128) with scale = amax / 448, exactly the
recipe of the kernels; weights dequantized per 128x128 block).
"""

import argparse
import os
import sys

import pytest
import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

import aiter  # noqa: E402
from aiter.fused_moe import fused_topk  # noqa: E402
from aiter.ops.shuffle import shuffle_weight  # noqa: E402

from bs_moe import F8, MODELS, stages  # noqa: E402

FP8_MAX = 448.0
PEAK_FP8_TFLOPS = 2540.0  # hipBLASLt FP8 8192^3 on this MI350X (experiments/bs_moe_tp8)


def quant_weight(w):
    """bf16 [E, N, K] -> fp8 [E, N, K] + fp32 [E, N/128, K/128] (amax/448 per block)."""
    e, n, k = w.shape
    blocks = w.view(e, n // 128, 128, k // 128, 128).permute(0, 1, 3, 2, 4)
    q, scale = aiter.pertoken_quant(blocks.reshape(-1, 128 * 128), quant_dtype=F8)
    q = q.view(e, n // 128, k // 128, 128, 128).permute(0, 1, 3, 2, 4)
    return q.contiguous().view(e, n, k), scale.view(e, n // 128, k // 128)


def make_case(model, tokens, seed=0, routing="random"):
    H, I, E, topk = MODELS[model]
    g = torch.Generator(device="cuda").manual_seed(seed)
    x = torch.randn(tokens, H, dtype=torch.bfloat16, device="cuda", generator=g) / 10
    w1, s1 = quant_weight(
        torch.randn(E, 2 * I, H, dtype=torch.bfloat16, device="cuda", generator=g) / 10
    )
    w2, s2 = quant_weight(
        torch.randn(E, H, I, dtype=torch.bfloat16, device="cuda", generator=g) / 10
    )
    if routing == "random":  # aiter tuner: fused_topk over randn scores
        score = torch.randn(tokens, E, dtype=torch.bfloat16, device="cuda", generator=g)
        tw, ti = fused_topk(x, score, topk, True)
    elif routing == "balanced":  # every expert gets floor/ceil(T*topk/E) rows
        ti = (
            (torch.arange(tokens, device="cuda")[:, None] * topk
             + torch.arange(topk, device="cuda")) % E
        ).to(torch.int32)
        tw = torch.rand(tokens, topk, device="cuda", generator=g)
        tw = tw / tw.sum(1, keepdim=True)
    else:
        raise ValueError(routing)
    return dict(
        x=x,
        w1=shuffle_weight(w1, (16, 16)),
        w1_scale=s1,
        w2=shuffle_weight(w2, (16, 16)),
        w2_scale=s2,
        topk_weights=tw.float().contiguous(),
        topk_ids=ti.to(torch.int32).contiguous(),
        raw=(w1, w2),
    )


def _quant_rows(v):
    """fp32 [n, K] -> per (row, 128) fp8-rounded values (fp32) and scales [n, K/128]."""
    n, k = v.shape
    g = v.view(n, k // 128, 128)
    amax = g.abs().amax(-1).clamp_min(1e-30)
    scale = amax * torch.tensor(1.0 / FP8_MAX, dtype=torch.float32)
    q = (g / scale[..., None]).to(F8).float()
    return q.view(n, k), scale


def ref_moe(case, tok_idx, mid_bf16=False):
    """fp32 reference for tokens tok_idx -> [len(tok_idx), H] fp32.

    mid_bf16: round SiLU(gate)*up to bf16 before its quant (the unfused flow).
    """
    w1q, w2q = case["raw"]
    s1, s2 = case["w1_scale"], case["w2_scale"]
    E, two_i, H = w1q.shape
    I = two_i // 2
    x = case["x"][tok_idx].float()
    ti = case["topk_ids"][tok_idx].long()
    tw = case["topk_weights"][tok_idx]
    a, sa = _quant_rows(x)
    a = (a.view(-1, H // 128, 128) * sa[..., None]).view(-1, H)
    out = torch.zeros(len(tok_idx), H, dtype=torch.float32, device=x.device)
    for e in torch.unique(ti).tolist():
        rows, slots = (ti == e).nonzero(as_tuple=True)
        w1d = w1q[e].float() * s1[e].repeat_interleave(128, 0).repeat_interleave(128, 1)
        w2d = w2q[e].float() * s2[e].repeat_interleave(128, 0).repeat_interleave(128, 1)
        h = a[rows] @ w1d.t()
        mid = torch.nn.functional.silu(h[:, :I]) * h[:, I:]
        if mid_bf16:
            mid = mid.bfloat16().float()
        q2, s2r = _quant_rows(mid)
        a2 = (q2.view(-1, I // 128, 128) * s2r[..., None]).view(-1, I)
        y = (a2 @ w2d.t()) * tw[rows, slots][:, None]
        out.index_add_(0, rows, y)
    return out


def check(out, ref, label=""):
    """Relative L2 error and bf16-scale allclose of out (bf16) vs ref (fp32)."""
    o = out.float()
    rel = ((o - ref).norm() / ref.norm()).item()
    bad = (~torch.isclose(o, ref, rtol=2e-2, atol=2e-2 * ref.abs().max().item() / 8)).float().mean().item()
    return rel, bad


def run_moe(case, **kw):
    fns, out = stages(
        case["x"], case["w1"], case["w1_scale"], case["w2"], case["w2_scale"],
        case["topk_weights"], case["topk_ids"], **kw,
    )
    for _, f in fns:
        f()
    return fns, out


def time_stages(fns, iters=20, warm=40):
    for _ in range(warm):
        for _, f in fns:
            f()
    torch.cuda.synchronize()
    evs = [[torch.cuda.Event(enable_timing=True) for _ in range(len(fns) + 1)] for _ in range(iters)]
    for it in range(iters):
        evs[it][0].record()
        for j, (_, f) in enumerate(fns):
            f()
            evs[it][j + 1].record()
    torch.cuda.synchronize()
    per = []
    for j in range(len(fns)):
        ts = sorted(evs[it][j].elapsed_time(evs[it][j + 1]) * 1000 for it in range(iters))
        per.append(ts[len(ts) // 2])
    tot = sorted(evs[it][0].elapsed_time(evs[it][-1]) * 1000 for it in range(iters))
    return per, tot[len(tot) // 2]


def flops(model, tokens):
    H, I, E, topk = MODELS[model]
    return tokens * topk * (2 * 2 * I * H + 2 * H * I)


# ---------------------------------------------------------------------------
# pytest: correctness (small tokens) and the six target shapes (subset check)
# ---------------------------------------------------------------------------


def _correct(model, tokens, routing="random", nsub=256, **kw):
    case = make_case(model, tokens, routing=routing)
    _, out = run_moe(case, **kw)
    torch.cuda.synchronize()
    assert torch.isfinite(out).all()
    g = torch.Generator(device="cuda").manual_seed(1)
    idx = torch.randperm(tokens, device="cuda", generator=g)[: min(nsub, tokens)]
    ref = ref_moe(case, idx, mid_bf16=not kw.get("fuse_quant", True))
    rel, bad = check(out[idx], ref)
    assert rel < 1.5e-2 and bad < 1e-3, f"{model} T={tokens} {kw}: rel {rel:.3e} bad {bad:.2e}"
    return rel


@pytest.mark.parametrize("model", ["flash", "pro"])
@pytest.mark.parametrize("tokens", [512, 2048])
@pytest.mark.parametrize("fuse_quant,prep", [(True, "fused"), (False, "aiter")])
def test_small(model, tokens, fuse_quant, prep):
    _correct(model, tokens, fuse_quant=fuse_quant, prep=prep)


@pytest.mark.parametrize("model", ["flash", "pro"])
def test_atomic_down(model):
    _correct(model, 2048, down_out="atomic")


@pytest.mark.parametrize("routing", ["random", "balanced"])
def test_routing(routing):
    _correct("flash", 4096, routing=routing)


@pytest.mark.parametrize("model", ["flash", "pro"])
@pytest.mark.parametrize("tokens", [8192, 16384, 32768])
def test_target(model, tokens):
    _correct(model, tokens)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-m", "--model", nargs="+", default=["flash", "pro"])
    p.add_argument("-t", "--tokens", type=int, nargs="+", default=[8192, 16384, 32768])
    p.add_argument("--routing", default="random")
    p.add_argument("--splits", type=int, default=None)
    p.add_argument("--no-fuse", action="store_true")
    p.add_argument("--prep", default="fused", choices=["fused", "aiter"])
    p.add_argument("--down-out", default="store", choices=["store", "atomic"])
    p.add_argument("--check", action="store_true", help="subset correctness check")
    p.add_argument("--iters", type=int, default=20)
    a = p.parse_args()
    for model in a.model:
        for T in a.tokens:
            case = make_case(model, T, routing=a.routing)
            fns, out = run_moe(
                case, down_splits=a.splits, fuse_quant=not a.no_fuse, prep=a.prep,
                down_out=a.down_out,
            )
            msg = ""
            if a.check:
                idx = torch.randperm(T, device="cuda")[:256]
                rel, bad = check(out[idx], ref_moe(case, idx, mid_bf16=a.no_fuse))
                msg = f" | rel {rel:.2e} bad {bad:.1e}"
            per, tot = time_stages(fns, iters=a.iters)
            fl = flops(model, T)
            parts = " ".join(f"{n} {t:6.1f}" for (n, _), t in zip(fns, per))
            print(
                f"{model:5s} T={T:6d}: {parts} | total {tot:7.1f} us "
                f"{fl / tot / 1e6:6.1f} TFLOPS ({fl / tot / 1e6 / PEAK_FP8_TFLOPS * 100:4.1f}% of "
                f"{PEAK_FP8_TFLOPS:.0f}){msg}",
                flush=True,
            )
            del case, fns, out
            torch.cuda.empty_cache()


if __name__ == "__main__":
    main()

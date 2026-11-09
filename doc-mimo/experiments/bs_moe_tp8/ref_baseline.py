"""Baseline: reference (tq/moe_gemm_blockscale) FP8 blockscale MoE on this GPU.

Per-kernel GPU time breakdown for MiMo-V2.6 Flash/Pro TP8 shapes.
"""
import argparse
import os
import sys

import torch

sys.path.insert(0, os.environ.get("BS_REF_PKG", "/tmp/bs_ref_pkg"))  # make_ref_pkg.sh

import aiter  # noqa: E402
from aiter import QuantType  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.shuffle import shuffle_weight  # noqa: E402

from bsref.a8w8_blockscale_gemm1 import fp8_blockscale_stage1  # noqa: E402
from bsref.a8w8_blockscale_gemm2 import M128_QUEUE_SIZE, make_m128_down  # noqa: E402
from bsref.moe_8wave_down import flydsl_moe_gemm_8wave_down  # noqa: E402
from bsref.moe_packed_reduce import make_moe_sum  # noqa: E402
from bsref.moe_reduce import invert_sorted_ids  # noqa: E402

F8 = torch.float8_e4m3fn
CASES = {"flash": (4096, 256, 256, 8), "pro": (6144, 256, 384, 8)}


def quant_weight(w):
    e, n, k = w.shape
    blocks = w.view(e, n // 128, 128, k // 128, 128).permute(0, 1, 3, 2, 4)
    q, scale = aiter.pertoken_quant(blocks.reshape(-1, 128 * 128), quant_dtype=F8)
    q = q.view(e, n // 128, k // 128, 128, 128).permute(0, 1, 3, 2, 4)
    return q.contiguous().view(e, n, k), scale.view(e, n // 128, k // 128)


def make_case(T, H, I, E, topk, seed=0):
    torch.manual_seed(seed)
    x = torch.randn(T, H, dtype=torch.bfloat16, device="cuda") / 10
    w1, s1 = quant_weight(torch.randn(E, 2 * I, H, dtype=torch.bfloat16, device="cuda") / 10)
    w2, s2 = quant_weight(torch.randn(E, H, I, dtype=torch.bfloat16, device="cuda") / 10)
    score = torch.randn(T, E, dtype=torch.bfloat16, device="cuda")
    tw, ti = fused_topk(x, score, topk, True)
    return x, shuffle_weight(w1, (16, 16)), s1, shuffle_weight(w2, (16, 16)), s2, tw, ti


def events_time(fns, iters):
    """Run the sequence fns iters times; return per-stage mean us (CUDA events)."""
    evs = [[torch.cuda.Event(enable_timing=True) for _ in range(len(fns) + 1)] for _ in range(iters)]
    for it in range(iters):
        evs[it][0].record()
        for j, f in enumerate(fns):
            f()
            evs[it][j + 1].record()
    torch.cuda.synchronize()
    out = [0.0] * len(fns)
    for it in range(iters):
        for j in range(len(fns)):
            out[j] += evs[it][j].elapsed_time(evs[it][j + 1]) * 1000 / iters
    return out


def run_case(name, T, down_path, splits, warm, iters):
    H, I, E, topk = CASES[name]
    x, w1, s1, w2, s2, tw, ti = make_case(T, H, I, E, topk)
    quant = aiter.get_hip_quant(QuantType.per_1x128)
    st = {}

    def f_sort():
        st["s"] = moe_sorting(ti, tw, E, H, torch.bfloat16, 256)

    def f_q1():
        st["a"], st["sa"] = quant(x, quant_dtype=F8, transpose_scale=True)

    mid = torch.empty(T, topk, I, dtype=torch.bfloat16, device="cuda")

    def f_g1():
        si, sw, se, nv, _ = st["s"]
        fp8_blockscale_stage1(st["a"], w1, st["sa"], s1, si, se, nv, mid)

    def f_q2():
        st["d"], st["sd"] = quant(mid, quant_dtype=F8, num_rows_factor=topk, transpose_scale=True)

    out = torch.empty(T, H, dtype=torch.bfloat16, device="cuda")
    ws2 = s2.view(E, H // 128, I // 128)
    params = dict(n=H, k=I, topk=topk, num_experts=E, num_oc_splits=splits)
    if down_path == "8wave":
        down = flydsl_moe_gemm_8wave_down(**params, block_m=256, block_n=128)
        routes = torch.empty(T, topk, H, dtype=torch.bfloat16, device="cuda")
        counter = torch.empty(1, dtype=torch.int32, device="cuda")

        def f_dn():
            si, sw, se, nv, _ = st["s"]
            down(routes, st["d"], w2, st["sd"], ws2, si, sw, se, nv, counter)

        def f_red():
            torch.sum(routes, dim=1, out=out)
    else:
        persistent = down_path == "m128p"
        down = make_m128_down(**params, persistent=persistent, is_sorted_bm_256=True)
        st["routes"] = None
        counter = (torch.zeros(M128_QUEUE_SIZE, dtype=torch.int32, device="cuda") if persistent
                   else torch.empty(1, dtype=torch.int32, device="cuda"))
        inverse = torch.empty(T, topk, dtype=torch.int32, device="cuda")

        def f_dn():
            si, sw, se, nv, _ = st["s"]
            if st["routes"] is None or st["routes"].shape[0] != se.numel() * 256:
                st["routes"] = torch.empty(se.numel() * 256, H, dtype=torch.bfloat16, device="cuda")
            down(st["routes"], st["d"], w2, st["sd"], ws2, si, sw, se, nv, counter)

        def f_red():
            si, sw, se, nv, _ = st["s"]
            invert_sorted_ids(topk)(si, inverse, nv, si.numel(), T)
            make_moe_sum(n=H, topk=topk, sort_block_m=128)(out, st["routes"], inverse)

    fns = [f_sort, f_q1, f_g1, f_q2, f_dn, f_red]
    for _ in range(warm):
        for f in fns:
            f()
    torch.cuda.synchronize()
    t = events_time(fns, iters)
    rows = T * topk
    flops = rows * 2 * (2 * I) * H + rows * 2 * H * I
    tot = sum(t)
    print(f"{name:5s} T={T:6d} {down_path}/oc{splits}: sort {t[0]:6.1f} q1 {t[1]:6.1f} g1 {t[2]:7.1f} "
          f"q2 {t[3]:6.1f} down {t[4]:7.1f} red {t[5]:6.1f} | total {tot:7.1f} us "
          f"{flops / tot / 1e6:6.1f} TFLOPS  (g1 {rows*2*2*I*H/t[2]/1e6:6.1f} TF, down {rows*2*H*I/t[4]/1e6:6.1f} TF)",
          flush=True)
    return out


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--model", nargs="+", default=["flash", "pro"])
    p.add_argument("-t", type=int, nargs="+", default=[8192, 16384, 32768])
    p.add_argument("--down", nargs="+", default=["m128", "m128p", "8wave"])
    p.add_argument("--splits", type=int, nargs="+", default=[4])
    p.add_argument("--warm", type=int, default=20)
    p.add_argument("--iters", type=int, default=20)
    a = p.parse_args()
    for m in a.model:
        for T in a.t:
            for d in a.down:
                for s in a.splits:
                    try:
                        run_case(m, T, d, s, a.warm, a.iters)
                    except Exception as e:  # noqa: BLE001
                        print(f"{m} T={T} {d}/oc{s}: FAILED {type(e).__name__}: {str(e)[:200]}", flush=True)


if __name__ == "__main__":
    main()

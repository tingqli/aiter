# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Shared setup for the Mimo v2.6 flash MoE **EP8** experiments (gfx942).

EP8 shape per rank: model_dim 4096, full inter_dim 2048, 32 local experts out of
256 global, topk 8. The rank sees ``tokens`` x (on average one local routed row per
token); global expert ids are remapped to the 32 local ids by ``moe_sorting``'s
``expert_mask`` (rank r owns experts [32 r, 32 r + 32)).

* weights: random bf16 -> mxfp4 (per_1x32) -> standard preshuffle
  (``shuffle_weight_a16w4`` / ``shuffle_scale_a16w4``), as test_flydsl_moe_a16wfp4
* routing: uniform random scores over the 256 global experts (or "hot")
* rooflines: practical ceilings measured on this machine at the 750 W cap
  (``experiments/ep8_roofline``): HBM read 3.6 TB/s, hipBLASLt fp8 1117 / 1002
  TFLOPs and bf16 637 / 571 TFLOPs for the gemm1-like (K 4096) / gemm2-like
  (K 2048) shapes
* timing: cold caches (L2 + 256 MB MALL flushed by a 512 MB read-modify-write
  before every iteration; repeated MoE calls would otherwise serve small-batch
  weights from the MALL), CUDA events around the MoE call only, median
"""

import os
from collections import defaultdict

import torch
import triton
import triton.language as tl

import aiter
from aiter import QuantType, dtypes
from aiter.fused_moe import fused_topk, moe_sorting
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
from aiter.utility import fp4_utils

H = 4096  # model_dim
I = 2048  # inter_dim (full, EP keeps whole experts)
E_LOCAL = 32
E_GLOBAL = 256
TOPK = 8
RANK = 0

# practical ceilings (experiments/ep8_roofline/results/roofline_gpu0.txt)
HBM_BPS = 3.60e12
FP8_G1, FP8_G2 = 1117e12, 1002e12  # hipBLASLt 16384x4096x4096 / 16384x4096x2048
BF16_G1, BF16_G2 = 637e12, 571e12

W1_BYTES = 2 * I * H // 2 + 2 * I * H // 32  # fp4 + e8m0 per expert
W2_BYTES = H * I // 2 + H * I // 32
HOT_EXPERT_DIV = 32
HOT_EXPERT_BIAS = 2.0


# =============================================================================
# weights / routing / sorting
# =============================================================================


def make_weights(seed=0, experts=E_LOCAL, model_dim=H, inter_dim=I):
    """Standard-preshuffled mxfp4 W1 [E, 2I, H/2] / W2 [E, H, I/2] (fp4x2) and
    shuffled e8m0 scales, plus the unshuffled quantized tensors for the reference."""
    torch.manual_seed(seed)
    tq = aiter.get_torch_quant(QuantType.per_1x32)
    w1q, w1s, w2q, w2s = [], [], [], []
    for e in range(experts):  # per expert: keeps the bf16 temporaries small
        w1 = torch.randn((1, 2 * inter_dim, model_dim), dtype=dtypes.bf16, device="cuda")
        w2 = torch.randn((1, model_dim, inter_dim), dtype=dtypes.bf16, device="cuda")
        q, s = tq(w1, quant_dtype=dtypes.fp4x2)
        w1q.append(q.view(1, 2 * inter_dim, model_dim // 2))
        w1s.append(s.view(1, 2 * inter_dim, model_dim // 32))
        q, s = tq(w2, quant_dtype=dtypes.fp4x2)
        w2q.append(q.view(1, model_dim, inter_dim // 2))
        w2s.append(s.view(1, model_dim, inter_dim // 32))
    w1q, w1s = torch.cat(w1q), torch.cat(w1s)
    w2q, w2s = torch.cat(w2q), torch.cat(w2s)
    return dict(
        w1q=w1q, w1s=w1s, w2q=w2q, w2s=w2s,
        w1=shuffle_weight_a16w4(w1q, 16, False),
        w2=shuffle_weight_a16w4(w2q, 16, False),
        w1_scale=shuffle_scale_a16w4(w1s.reshape(-1, model_dim // 32), experts, False),
        w2_scale=shuffle_scale_a16w4(w2s.reshape(-1, inter_dim // 32), experts, False),
    )


def expert_mask(rank=RANK, device="cuda"):
    m = torch.zeros(E_GLOBAL, dtype=torch.int32, device=device)
    m[rank * E_LOCAL:(rank + 1) * E_LOCAL] = 1
    return m


def make_routing(tokens, seed=0, routing="uniform", model_dim=H):
    """x bf16 [tokens, H] and global top-k (weights f32, ids i32) over 256 experts."""
    g = torch.Generator(device="cuda").manual_seed(1000 + seed)
    x = torch.randn((tokens, model_dim), dtype=dtypes.bf16, device="cuda", generator=g)
    score = torch.randn((tokens, E_GLOBAL), dtype=dtypes.bf16, device="cuda", generator=g)
    if routing == "hot":
        hot = torch.randperm(E_GLOBAL, device="cuda", generator=g)[: E_GLOBAL // HOT_EXPERT_DIV]
        score[:, hot] += HOT_EXPERT_BIAS
    else:
        assert routing == "uniform", routing
    tw, ti = fused_topk(x, score, TOPK, True)
    return x, tw, ti


def local_ids(topk_ids, rank=RANK):
    """global -> local expert id, -1 if the expert is not on this rank."""
    loc = topk_ids.long() - rank * E_LOCAL
    return torch.where((loc >= 0) & (loc < E_LOCAL), loc, torch.full_like(loc, -1))


def ep_sort(topk_ids, topk_weights, block_m, mask, model_dim=H):
    """moe_sorting with the EP mask: local expert ids, zeroed bf16 moe_buf."""
    return moe_sorting(topk_ids, topk_weights, E_GLOBAL, model_dim, dtypes.bf16, block_m,
                       expert_mask=mask)[:5]


# =============================================================================
# rooflines
# =============================================================================


def roofline(tokens, topk_ids, a_bytes=1, rank=RANK):
    """Ideal times (us) of the local MoE for this routing:
    mem  = (weights of the active local experts + x read + intermediate write/read
            + bf16 output write) / HBM
    fp8 / bf16 = useful FLOPs / hipBLASLt-level throughput."""
    loc = local_ids(topk_ids, rank)
    rows = int((loc >= 0).sum())
    cnt = torch.bincount(loc[loc >= 0], minlength=E_LOCAL)
    n_act = int((cnt > 0).sum())
    tok_act = int(((loc >= 0).any(dim=1)).sum())
    w = n_act * (W1_BYTES + W2_BYTES)
    act = tok_act * H * a_bytes + 2 * rows * I * a_bytes + tokens * H * 2
    f1, f2 = 2.0 * rows * 2 * I * H, 2.0 * rows * I * H
    return dict(
        rows=rows, n_act=n_act, max_rows=int(cnt.max()), w_bytes=w, act_bytes=act,
        flops=f1 + f2,
        mem=(w + act) / HBM_BPS * 1e6,
        fp8=(f1 / FP8_G1 + f2 / FP8_G2) * 1e6,
        bf16=(f1 / BF16_G1 + f2 / BF16_G2) * 1e6,
    )


# =============================================================================
# cold-cache timing
# =============================================================================


@triton.jit
def _ep8_cache_flush(ptr, out, n, BLOCK: tl.constexpr):
    offs = tl.program_id(0).to(tl.int64) * BLOCK + tl.arange(0, BLOCK)
    v = tl.load(ptr + offs, mask=offs < n, other=0)
    tl.store(out + tl.program_id(0), tl.sum(v, axis=0))


_FLUSH = {}


def flush_cache():
    """512 MB read (one tiny store per program): evicts L2 and the 256 MB MALL with
    clean lines (kernel name ``_ep8_cache_flush``, excluded from the profiles). A
    read-modify-write flush would leave the MALL full of dirty lines whose
    write-back then steals HBM bandwidth from the measured kernel."""
    if "buf" not in _FLUSH:
        _FLUSH["buf"] = torch.ones(128 << 20, dtype=torch.int32, device="cuda")
        _FLUSH["out"] = torch.zeros((128 << 20) // 8192, dtype=torch.int32, device="cuda")
    b = _FLUSH["buf"]
    _ep8_cache_flush[(triton.cdiv(b.numel(), 8192),)](b, _FLUSH["out"], b.numel(), BLOCK=8192)


def time_cold(fn, iters=20, warmup=3, flush=True):
    """Median GPU time (us) of ``fn`` with cold caches. The flush keeps the GPU busy
    while the host enqueues fn's kernels, so launch overhead is hidden (as in a
    CUDA graph)."""
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()
    ev = [(torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True))
          for _ in range(iters)]
    for e0, e1 in ev:
        if flush:
            flush_cache()
        e0.record()
        fn()
        e1.record()
    torch.cuda.synchronize()
    ts = sorted(e0.elapsed_time(e1) * 1e3 for e0, e1 in ev)
    return ts[len(ts) // 2]


def profile_cold(fn, classify, iters=10, flush=True):
    """Per-stage kernel time (us, mean over iters) with cold caches; ``classify``
    maps a kernel name to a stage label (None = drop)."""
    fn()
    torch.cuda.synchronize()
    with torch.profiler.profile(activities=[torch.profiler.ProfilerActivity.CUDA]) as p:
        for _ in range(iters):
            if flush:
                flush_cache()
            fn()
        torch.cuda.synchronize()
    t = defaultdict(float)
    for e in p.events():
        if e.device_type != torch.autograd.DeviceType.CUDA or "_ep8_cache_flush" in e.name:
            continue
        s = classify(e.name)
        if s is not None:
            t[s] += e.device_time / iters
    t["total"] = sum(t.values())
    return dict(t)


def default_stage(name):
    n = name.lower()
    if "sorting" in n:
        return "sort"
    if "gemm1" in n or "moe1" in n or "stage1" in n:
        return "gemm1"
    if "gemm2" in n or "moe2" in n or "stage2" in n:
        return "gemm2"
    if "quant" in n or name == "kernel_0":
        return "quant"
    return "other:" + name[:40]


# =============================================================================
# reference
# =============================================================================


def ref_moe(x, topk_weights, topk_ids, W, a8w4=False, rank=RANK):
    """fp32 reference of the local experts' contribution, [tokens, H] f32.

    Exact mxfp4 weights. ``a8w4``: x / the SiLU output are fp8-quantized the way
    the A8W4 kernels do (x per token row, intermediate per (row, 128 cols)), so the
    remaining differences are accumulation order and bf16 output rounding."""
    from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows

    tokens, model_dim = x.shape
    E, n2, _ = W["w1q"].shape
    inter = n2 // 2
    loc = local_ids(topk_ids, rank)
    if a8w4:
        x8, xs = quantize_rows(x)
        xf = x8.float() * xs.view(-1, 1)
    else:
        xf = x.float()
    out = torch.zeros((tokens, model_dim), dtype=torch.float32, device=x.device)
    for e in range(E):
        tok, slot = torch.nonzero(loc == e, as_tuple=True)
        if tok.numel() == 0:
            continue
        w1 = fp4_utils.mxfp4_to_f32(W["w1q"][e]).view(n2, model_dim // 32, 32)
        w1 = (w1 * fp4_utils.e8m0_to_f32(W["w1s"][e]).view(n2, -1, 1)).view(n2, model_dim)
        gate, up = (xf[tok] @ w1.t()).split(inter, dim=-1)
        a = torch.nn.functional.silu(gate) * up
        if a8w4:
            g = a.view(-1, inter // 128, 128)
            s = g.abs().amax(-1, keepdim=True).clamp(min=1e-30) / 240.0
            a = ((g / s).to(torch.float8_e4m3fnuz).float() * s).view(-1, inter)
        else:
            a = a.to(torch.bfloat16).float()
        w2 = fp4_utils.mxfp4_to_f32(W["w2q"][e]).view(model_dim, inter // 32, 32)
        w2 = (w2 * fp4_utils.e8m0_to_f32(W["w2s"][e]).view(model_dim, -1, 1)).view(
            model_dim, inter)
        out.index_add_(0, tok, (a @ w2.t()) * topk_weights[tok, slot].view(-1, 1))
    return out


def cos_diff(x, y):
    x, y = x.double(), y.double()
    return float(1 - 2 * (x * y).sum() / (x * x + y * y).sum().clamp(min=1e-30))


def fmt_roof(r):
    return (f"rows {r['rows']:6d} act {r['n_act']:2d} max {r['max_rows']:5d} | "
            f"mem {r['mem']:7.1f} fp8 {r['fp8']:7.1f} bf16 {r['bf16']:7.1f} us")


if __name__ == "__main__":
    for t in (1, 4, 16, 64, 256, 1024, 4096, 16384):
        _, _, ti = make_routing(t)
        print(f"tokens {t:6d}: {fmt_roof(roofline(t, ti))}")
    print("weights per expert:", W1_BYTES + W2_BYTES, "B; all local:",
          E_LOCAL * (W1_BYTES + W2_BYTES) / 2**20, "MiB;", os.getpid())

"""bs_prep vs aiter moe_sorting (CK) + per_1x128 hip quant: equality + timing.

Args: model:tokens ... (e.g. flash:8192 pro:32768). Env GRID / NTH: prep grid
and block size.
"""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
import aiter.fused_moe as fm  # noqa: E402
from aiter import QuantType  # noqa: E402

import test_bs_moe as t  # noqa: E402
from bs_prep import bs_prep  # noqa: E402

F8 = torch.float8_e4m3fn
GRID = int(os.environ.get("GRID", "256"))
NTH = int(os.environ.get("NTH", "512"))


def bench(fn, iters=30):
    for _ in range(10):
        fn()
    torch.cuda.synchronize()
    st = torch.cuda.Event(enable_timing=True)
    en = torch.cuda.Event(enable_timing=True)
    st.record()
    for _ in range(iters):
        fn()
    en.record()
    torch.cuda.synchronize()
    return st.elapsed_time(en) * 1000 / iters


for arg in sys.argv[1:]:
    model, T = arg.split(":")
    T = int(T)
    H, I, E, topk = t.MODELS[model]
    case = t.make_case(model, T)
    x, ti, tw = case["x"], case["topk_ids"], case["topk_weights"]
    si0, sw0, se0, nv0, _ = fm._moe_sorting_impl(ti, tw, E, H, torch.bfloat16, 256, None, None, 0, use_opus=False, accumulate=False)
    a0, sa0 = aiter.get_hip_quant(QuantType.per_1x128)(x, quant_dtype=F8, transpose_scale=True)
    for rep in range(3):  # repeated launches check the workspace reset
        si, sw, se, nv, a, sa, inv = bs_prep(x, ti, tw, E, grid=GRID, nt=NTH)
        torch.cuda.synchronize()
        v = int(nv[0])
        ok_nv = v == int(nv0[0]) and int(nv[1]) == T
        fused = torch.arange(T, device="cuda", dtype=torch.int32)[:, None] | (
            torch.arange(topk, device="cuda", dtype=torch.int32)[None, :] << 24)
        ok_inv = bool((inv >= 0).all() and (inv < v).all()) and torch.equal(si[inv.long()], fused)
        ok_se = torch.equal(se[: v // 256], se0[: v // 256])
        # per-expert multiset of (id, weight); expert ranges are identical if seids are
        k0 = (si0[:v].long() << 32) | (sw0[:v].view(torch.int32).long() & 0xFFFFFFFF)
        k1 = (si[:v].long() << 32) | (sw[:v].view(torch.int32).long() & 0xFFFFFFFF)
        ok_rows = ok_se
        if ok_se:
            bounds = torch.nonzero(torch.diff(se[: v // 256], prepend=se[:1] - 1)).flatten().tolist() + [v // 256]
            for b0, b1 in zip(bounds[:-1], bounds[1:]):
                r0, r1 = b0 * 256, b1 * 256
                if not torch.equal(torch.sort(k0[r0:r1]).values, torch.sort(k1[r0:r1]).values):
                    ok_rows = False
                    break
        ok_a = torch.equal(a.view(torch.uint8), a0.view(torch.uint8))
        ok_sa = torch.equal(sa.view(-1), sa0.view(-1))
        na = (a.view(torch.uint8) != a0.view(torch.uint8)).sum().item()
        print(f"{model} T={T} rep{rep}: nv {ok_nv} seids {ok_se} rows {ok_rows} a8 {ok_a} ({na} diff) sa {ok_sa} inv {ok_inv}")
    q = aiter.get_hip_quant(QuantType.per_1x128)
    us_ref = bench(lambda: (fm._moe_sorting_impl(ti, tw, E, H, torch.bfloat16, 256, None, None, 0, use_opus=False, accumulate=False),
                            q(x, quant_dtype=F8, transpose_scale=True)))
    us_new = bench(lambda: bs_prep(x, ti, tw, E, grid=GRID, nt=NTH))
    print(f"{model} T={T}: ck sort + hip quant {us_ref:6.1f} us   bs_prep {us_new:6.1f} us")

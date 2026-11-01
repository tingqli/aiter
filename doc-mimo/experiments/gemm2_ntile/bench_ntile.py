"""gemm2 with NTILE adjacent n-blocks per CTA vs the one-tile-per-CTA kernel.

Same inputs as ``bench_a8w4_gemm2`` (fd2 weights, a_group=128 A scales as written by
gemm1's q8s epilogue, dyn_rows, bm64 / tile_n 128). Checks every variant against
the fp32 reference (and bf16-atomic noise vs the baseline) and times it.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/gemm2_ntile/bench_ntile.py [-t 512 8192] [--nt 1 2 4 8]
"""
import argparse
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
import test_a8w4_gemm2 as G  # noqa: E402
from aiter import QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402
from aiter.test_common import run_perftest  # noqa: E402

p = argparse.ArgumentParser()
p.add_argument("-t", type=int, nargs="*", default=[128, 512, 2048, 8192, 16384])
p.add_argument("--nt", type=int, nargs="*", default=[1, 2, 4, 8])
p.add_argument("--epilog", nargs="*", default=["lds", "direct"])
p.add_argument("--bm", type=int, nargs="*", default=[64], help="tile_m of the variants")
p.add_argument("--ref_bm", type=int, default=64, help="tile_m of the n_tiles=0 baseline")
p.add_argument("--sr", type=int, nargs="*", default=[0], help="stage_rows (0 = BM)")
p.add_argument("--rv", type=int, nargs="*", default=[0], help="row_vgpr 0/1")
args = p.parse_args()

E, MD, INTER, TOPK, TN = 256, 4096, 256, 8, 128
torch.manual_seed(0)
w2 = torch.randn((E, MD, INTER), dtype=dtypes.bf16, device="cuda")
w2_qt, w2_scale = aiter.get_torch_quant(QuantType.per_1x32)(w2, quant_dtype=dtypes.fp4x2)
del w2
w2_qt = w2_qt.view(E, MD, INTER // 2)
w2_u8 = shuffle_weight_a16w4(w2_qt, 16, False).view(torch.uint8)
w2_s = shuffle_scale_a16w4(w2_scale, E, False).view(torch.uint8).contiguous().view(-1)
W, WS = G.prep_w2_fast(w2_u8, w2_s, 2)

for tok in args.t:
    x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
    tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
    prep = {}

    def inputs(bm):
        """moe_sorting at block_m bm + a stage1 stand-in + its fp32 reference."""
        if bm not in prep:
            sids, sw, seids, nv, _ = moe_sorting(ti, tw, E, MD, dtypes.bf16, bm)[:5]
            inter = torch.randn((seids.numel() * bm, INTER), dtype=dtypes.bf16, device="cuda")
            a8, asc = G.quantize_groups(inter, 128)
            ref = G.run_torch(a8, asc, w2_qt, w2_scale, sids, sw, seids, nv, tok, bm).float()
            prep[bm] = (sids, sw, seids, nv, a8, asc, ref)
        return prep[bm]

    def run(bm, nt, ep, sr=0, rv=0):
        sids, sw, seids, nv, a8, asc, ref = inputs(bm)
        out = torch.zeros((tok, MD), dtype=dtypes.bf16, device="cuda")
        fn = lambda: G.a8w4_gemm2(  # noqa: E731
            a8, asc, W, WS, sids, sw, seids, nv, out, num_experts=E, tile_m=bm,
            tile_n=TN, b_cache_mod=2, epilog=ep, dyn_rows=True, a_group=128,
            fast_dec=2, n_tiles=nt, stage_rows=sr, row_vgpr=bool(rv))
        fn()
        torch.cuda.synchronize()
        res = out.float().clone()
        _, us = run_perftest(fn)
        return G._cos_diff(ref, res), us

    c0, us0 = run(args.ref_bm, 0, "lds")
    line = [f"tok {tok:6d}  base bm{args.ref_bm} {us0:7.1f} us (cos {c0:.1e})"]
    variants = [
        (bm, ep, nt, sr, rv)
        for bm in args.bm
        for ep in args.epilog
        for nt in args.nt
        for sr in (args.sr if ep == "lds" and nt > 1 else [0])
        for rv in args.rv
    ]
    for bm, ep, nt, sr, rv in variants:
        tag = f"bm{bm} {ep[:3]} nt{nt}{f' sr{sr}' if sr else ''}{' rv' if rv else ''}"
        try:
            cr, us = run(bm, nt, ep, sr, rv)
            ok = "" if cr < 1e-4 else " BAD"
            line.append(f"{tag:22s} {us:7.1f} ({us0 / us:.2f}x cos {cr:.1e}{ok})")
        except Exception as ex:  # noqa: BLE001
            line.append(f"{tag:22s} FAIL {type(ex).__name__}: {str(ex)[:160]}")
    print("\n   ".join(line), flush=True)

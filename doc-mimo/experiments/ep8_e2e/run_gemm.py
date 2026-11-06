"""Run one gemm1 / gemm2 config (for rocprofv3 --att / --pmc).

    python run_gemm.py g1 --tok 16 --adt bf16 --bm 16 --kw "dict(ni=128, nw=4)"
"""
import argparse
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
sys.path.insert(0, HERE)
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402
from bench_ab import _lit  # noqa: E402

p = argparse.ArgumentParser()
p.add_argument("what", choices=["g1", "g2"])
p.add_argument("--tok", type=int, default=16)
p.add_argument("--adt", default="bf16")
p.add_argument("--bm", type=int, default=16)
p.add_argument("--kw", default="dict()")
p.add_argument("--iters", type=int, default=2)
args = p.parse_args()
W = C.make_weights()
P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
x, tw, ti = C.make_routing(args.tok)
bm = args.bm
sids, sw, seids, nv, _ = C.ep_sort(ti, tw, bm, C.expert_mask())
ss = seids.numel() * bm
fp8 = args.adt == "fp8"
x8, xs = quantize_rows(x) if fp8 else (x, None)
a = torch.zeros((ss, C.I), dtype=torch.uint8 if fp8 else torch.bfloat16, device="cuda")
a_s = torch.zeros((ss, C.I // EP.QG1), dtype=torch.float32, device="cuda") if fp8 else None
out = torch.zeros((args.tok, C.H), dtype=torch.bfloat16, device="cuda")
kw = _lit(args.kw)
for _ in range(args.iters):
    C.flush_cache()
    if args.what == "g1":
        EP.ep_gemm1(x8, xs, P, sids, seids, nv, a, a_s, adt=args.adt, block_m=bm, **kw)
    else:
        EP.ep_gemm2(a, a_s, P, sids, sw, seids, nv, out, adt=args.adt, block_m=bm, **kw)
torch.cuda.synchronize()
print("done")

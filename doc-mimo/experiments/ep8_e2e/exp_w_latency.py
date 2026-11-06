"""Timing experiment: does W streaming latency limit large-M gemm1?

Runs ep_gemm1 normally and with every m-block mapped to the same expert (W of
one expert, L2/MALL resident; results wrong, timing only).
"""
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402

tok = int(sys.argv[1]) if len(sys.argv) > 1 else 16384
W = C.make_weights()
P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
x, tw, ti = C.make_routing(tok)
bm = 128
sids, sw, seids, nv, _ = C.ep_sort(ti, tw, bm, C.expert_mask())
x8, xs = quantize_rows(x)
out = torch.zeros((seids.numel() * bm, C.I), dtype=torch.uint8, device="cuda")
outs = torch.zeros((seids.numel() * bm, C.I // EP.QG1), dtype=torch.float32, device="cuda")
for nw, sch in ((8, 1), (8, 2), (4, 2)):
    kw = dict(adt="fp8", block_m=bm, ni=128, rowv=(32, 64, 128), nw=nw, sch=sch)
    for name, e_ids in (("normal", seids), ("one-expert", torch.zeros_like(seids))):
        us = C.time_cold(lambda: EP.ep_gemm1(x8, xs, P, sids, e_ids, nv, out, outs, **kw))
        print(f"nw{nw} sch{sch} {name:10s}: {us:7.1f} us", flush=True)

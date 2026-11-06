"""Run the fused small-batch kernel a few times (for rocprofv3 --att / --pmc)."""
import argparse
import ast
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
import ep8_small as S  # noqa: E402

p = argparse.ArgumentParser()
p.add_argument("--tok", type=int, default=16)
p.add_argument("--adt", default="bf16")
p.add_argument("--maxm", type=int, default=64)
p.add_argument("--cfg", default="{}")
p.add_argument("--iters", type=int, default=2)
args = p.parse_args()
W = C.make_weights()
P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
x, tw, ti = C.make_routing(args.tok)
for _ in range(args.iters):
    C.flush_cache()
    S.ep8_moe_small(x, P, tw, ti, rank=C.RANK, adt=args.adt, maxm=args.maxm,
                    cfg=ast.literal_eval(args.cfg))
torch.cuda.synchronize()
print("done")

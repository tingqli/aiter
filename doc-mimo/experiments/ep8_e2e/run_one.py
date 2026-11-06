"""Run one EP8 GEMM config a few times (for rocprofv3 --pmc / --att).

    rocprofv3 --pmc SQ_BUSY_CYCLES SQ_VALU_MFMA_BUSY_CYCLES GRBM_GUI_ACTIVE \
        --kernel-include-regex ep_gemm -d /tmp/pmc -o run -- \
        python doc-mimo/experiments/ep8_e2e/run_one.py --tok 16384 --adt fp8 --cfg l128
"""
import argparse
import ast
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402

p = argparse.ArgumentParser()
p.add_argument("--tok", type=int, default=16384)
p.add_argument("--adt", default="fp8")
p.add_argument("--cfg", default="l128")
p.add_argument("--iters", type=int, default=3)
p.add_argument("--g1", default="{}", help="extra gemm1 kwargs (python dict)")
p.add_argument("--g2", default="{}", help="extra gemm2 kwargs (python dict)")
args = p.parse_args()
W = C.make_weights()
P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
x, tw, ti = C.make_routing(args.tok)
cfg = dict(EP.CFGS[args.cfg])
cfg["g1"] = dict(cfg["g1"], **ast.literal_eval(args.g1))
cfg["g2"] = dict(cfg["g2"], **ast.literal_eval(args.g2))
for _ in range(args.iters):
    C.flush_cache()
    EP.ep8_moe(x, P, tw, ti, rank=C.RANK, adt=args.adt, cfg=cfg)
torch.cuda.synchronize()
print("done")

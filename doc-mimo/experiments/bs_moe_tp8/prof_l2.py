"""Workload for rocprofv3 L2 counters: gemm1 of the real pipeline (random routing)."""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_bs_moe as t  # noqa: E402

model, T = sys.argv[1], int(sys.argv[2])
case = t.make_case(model, T)
fns, out = t.run_moe(case)
fns = dict(fns)
for _ in range(5):
    for f in fns.values():
        f()
torch.cuda.synchronize()
for name in ("prep", "gemm1", "down", "reduce"):
    fns[name]()
torch.cuda.synchronize()

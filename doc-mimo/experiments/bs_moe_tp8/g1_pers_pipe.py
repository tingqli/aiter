"""In-pipeline gemm1: persistent workers vs one workgroup per task."""
import functools
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import bs_gemm1  # noqa: E402
import bs_moe  # noqa: E402
import test_bs_moe as t  # noqa: E402

model, tokens = sys.argv[1], [int(v) for v in sys.argv[2:]]
for T in tokens:
    case = t.make_case(model, T)
    for pers in (True, False):
        bs_moe.fp8_blockscale_stage1 = functools.partial(bs_gemm1.fp8_blockscale_stage1, persistent=pers)
        fns, out = t.run_moe(case)
        per, tot = t.time_stages(fns)
        print(f"{model} T={T} g1 persistent={pers!s:5}: " + " ".join(f"{n} {p:6.1f}" for (n, _), p in zip(fns, per)) + f" | total {tot:7.1f}", flush=True)
        del fns, out
        torch.cuda.empty_cache()

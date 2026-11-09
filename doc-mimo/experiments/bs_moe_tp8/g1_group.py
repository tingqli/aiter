"""In-pipeline gemm1 with group_size_m 1 / 2 / 4 (task order: blocks of one N tile grouped)."""
import functools
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import bs_gemm1  # noqa: E402
import test_bs_moe as t  # noqa: E402

orig = bs_gemm1.compile_fp8_stage1_giu1
model, tokens = sys.argv[1], [int(v) for v in sys.argv[2:]]
for T in tokens:
    case = t.make_case(model, T)
    ref = None
    for g in (1, 2, 4):
        bs_gemm1.compile_fp8_stage1_giu1 = functools.partial(orig, group_size_m=g)
        bs_gemm1._compile_stage1.cache_clear()
        fns, out = t.run_moe(case)
        torch.cuda.synchronize()
        if ref is None:
            ref = out.clone()
        per, tot = t.time_stages(fns)
        print(f"{model} T={T} group_size_m={g}: " + " ".join(f"{n} {p:6.1f}" for (n, _), p in zip(fns, per))
              + f" | total {tot:7.1f} | same {torch.equal(out, ref)}", flush=True)
        del fns, out
        torch.cuda.empty_cache()

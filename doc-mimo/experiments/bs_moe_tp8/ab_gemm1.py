"""A/B timing: reference gemm1 (bf16) vs doc-mimo bs_gemm1 (bf16 / fp8 out)."""
import os
import sys

import torch

sys.path.insert(0, os.environ.get("BS_REF_PKG", "/tmp/bs_ref_pkg"))  # make_ref_pkg.sh
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
from aiter import QuantType  # noqa: E402
from aiter.fused_moe import moe_sorting  # noqa: E402

import test_bs_moe as t  # noqa: E402
from bs_gemm1 import fp8_blockscale_stage1 as mine  # noqa: E402
from bsref.a8w8_blockscale_gemm1 import fp8_blockscale_stage1 as ref  # noqa: E402

F8 = torch.float8_e4m3fn


def bench(fn, iters=20):
    st = torch.cuda.Event(enable_timing=True)
    en = torch.cuda.Event(enable_timing=True)
    st.record()
    for _ in range(iters):
        fn()
    en.record()
    torch.cuda.synchronize()
    return st.elapsed_time(en) * 1000 / iters


def main():
    for arg in sys.argv[1:]:
        model, T = arg.split(":")
        T = int(T)
        H, I, E, topk = t.MODELS[model]
        case = t.make_case(model, T)
        quant = aiter.get_hip_quant(QuantType.per_1x128)
        si, sw, se, nv, _ = moe_sorting(case["topk_ids"], case["topk_weights"], E, H, torch.bfloat16, 256, accumulate=False)
        a, sa = quant(case["x"], quant_dtype=F8, transpose_scale=True)
        mid = torch.empty(T, topk, I, dtype=torch.bfloat16, device="cuda")
        a2 = torch.empty(T, topk, I, dtype=F8, device="cuda")
        sa2 = torch.empty(I // 128, T * topk, dtype=torch.float32, device="cuda")
        w1, s1 = case["w1"], case["w1_scale"]
        variants = {
            "ref_bf16": lambda: ref(a, w1, sa, s1, si, se, nv, mid),
            "new_bf16": lambda: mine(a, w1, sa, s1, si, se, nv, mid),
            "new_fp8": lambda: mine(a, w1, sa, s1, si, se, nv, a2, output_scale=sa2),
        }
        for f in variants.values():
            for _ in range(10):
                f()
        torch.cuda.synchronize()
        res = {k: [] for k in variants}
        for _ in range(5):
            for k, f in variants.items():
                res[k].append(bench(f))
        print(model, T, "  ".join(f"{k} {min(v):7.1f}/{sorted(v)[2]:7.1f}" for k, v in res.items()), flush=True)
        del case


if __name__ == "__main__":
    main()

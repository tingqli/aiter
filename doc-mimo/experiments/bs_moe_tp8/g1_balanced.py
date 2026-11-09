"""gemm1 raw efficiency: balanced routing with whole 256-row blocks (no half blocks)."""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
from aiter import QuantType  # noqa: E402
from aiter.fused_moe import moe_sorting  # noqa: E402

import bs_moe  # noqa: E402
import test_bs_moe as t  # noqa: E402
from bs_gemm1 import fp8_blockscale_stage1  # noqa: E402

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
    H = int(sys.argv[1])
    T = int(sys.argv[2])
    E, topk, I = int(sys.argv[3]), int(sys.argv[4]), 256
    bs_moe.MODELS["tmp"] = (H, I, E, topk)
    case = t.make_case("tmp", T, routing="balanced")
    quant = aiter.get_hip_quant(QuantType.per_1x128)
    si, sw, se, nv, _ = moe_sorting(case["topk_ids"], case["topk_weights"], E, H, torch.bfloat16, 256, accumulate=False)
    print("valid rows", int(nv[0]), "blocks", int(nv[0]) // 256)
    a, sa = quant(case["x"], quant_dtype=F8, transpose_scale=True)
    a2 = torch.empty(T, topk, I, dtype=F8, device="cuda")
    sa2 = torch.empty(I // 128, T * topk, dtype=torch.float32, device="cuda")
    mid = torch.empty(T, topk, I, dtype=torch.bfloat16, device="cuda")
    w1, s1 = case["w1"], case["w1_scale"]
    fns = {
        "bf16": lambda: fp8_blockscale_stage1(a, w1, sa, s1, si, se, nv, mid),
        "fp8": lambda: fp8_blockscale_stage1(a, w1, sa, s1, si, se, nv, a2, output_scale=sa2),
    }
    for f in fns.values():
        for _ in range(20):
            f()
    torch.cuda.synchronize()
    fl = T * topk * 2 * 2 * I * H
    for _ in range(3):
        for k, f in fns.items():
            us = bench(f)
            print(f"{k}: {us:7.1f} us {fl / us / 1e6:7.1f} TFLOPS")


if __name__ == "__main__":
    main()

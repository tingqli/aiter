"""gemm1 memory-boundness probe: same task count / MFMA work, different B sharing.

balanced: E experts x 256 rows (every task streams its own B tile).
shared:   topk experts x (T rows) (32 blocks per expert share one B per XCD).
"""
import functools
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import bs_moe  # noqa: E402
import test_bs_moe as t  # noqa: E402
from bs_prep import bs_prep  # noqa: E402
from bs_gemm1 import fp8_blockscale_stage1  # noqa: E402

F8 = torch.float8_e4m3fn


def bench(fn, iters=20):
    # MI350X clocks ramp over the first tens of back-to-back launches: warm up well.
    for _ in range(50):
        fn()
    st = torch.cuda.Event(enable_timing=True)
    en = torch.cuda.Event(enable_timing=True)
    st.record()
    for _ in range(iters):
        fn()
    en.record()
    torch.cuda.synchronize()
    return st.elapsed_time(en) * 1000 / iters


def main():
    H, T, E, topk, I = int(sys.argv[1]), 8192, 256, 8, 256
    bs_moe.MODELS["tmp"] = (H, I, E, topk)
    case = t.make_case("tmp", T, routing="balanced")
    w1, s1 = case["w1"], case["w1_scale"]
    a2 = torch.empty(T, topk, I, dtype=F8, device="cuda")
    sa2 = torch.empty(I // 128, T * topk, dtype=torch.float32, device="cuda")
    fl = T * topk * 2 * 2 * I * H
    shared = torch.arange(topk, device="cuda", dtype=torch.int32).repeat(T, 1)
    runs = {}
    for name, ids in (("balanced", case["topk_ids"]), ("shared", shared)):
        si, sw, se, nv, a, sa, _ = bs_prep(case["x"], ids.contiguous(), case["topk_weights"], E)
        runs[name] = (int(nv[0]) // 256, functools.partial(
            fp8_blockscale_stage1, a, w1, sa, s1, si, se, nv, a2, output_scale=sa2))
    for _ in range(2):  # alternate, so neither side gets the cold clocks
        for name, (blocks, f) in runs.items():
            us = bench(f)
            print(f"H{H} {name:9s} blocks {blocks:4d}: {us:7.1f} us {fl / us / 1e6:7.1f} TFLOPS", flush=True)


if __name__ == "__main__":
    main()

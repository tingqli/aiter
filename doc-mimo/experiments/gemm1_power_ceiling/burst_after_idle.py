"""Single launches after an idle gap (clock recovered from the power cap): standalone
gemm1, port and torch.sum over 576 MB. 15 bursts of 5 launches, median per position.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/gemm1_power_ceiling/burst_after_idle.py
"""
import os
import statistics as st
import sys
import time

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm1 as T  # noqa: E402

cap = []
orig = T.run_perftest


def grab(fn, *a, **k):
    cap.append(fn)
    return orig(fn, *a, **k)


T.run_perftest = grab
T.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=32, tile_n=128)
x = torch.empty(576 * 2**18, device="cuda").uniform_()
fns = {"standalone": cap[0], "port": cap[1], "torch.sum": lambda: torch.sum(x)}
for name, fn in fns.items():
    res = []
    for _ in range(15):
        time.sleep(0.3)  # let power / clock recover
        torch.cuda._sleep(2_000_000)  # keep the queue ahead of the host
        evs = [torch.cuda.Event(enable_timing=True) for _ in range(6)]
        for i in range(5):
            evs[i].record()
            fn()
        evs[5].record()
        torch.cuda.synchronize()
        res.append([evs[i].elapsed_time(evs[i + 1]) * 1e3 for i in range(5)])
    med = [st.median(r[i] for r in res) for i in range(5)]
    print(f"{name:<11} burst after idle, launch 1..5 median us: "
          + " ".join(f"{m:6.1f}" for m in med)
          + f"  -> {576 * 2**20 / min(med) / 1e6:.2f} TB/s (576MB)")

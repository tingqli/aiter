"""Practical rooflines of this GPU (750 W cap) for the EP8 MoE targets:

  * HBM read bandwidth (torch.sum over a weight-sized buffer)
  * fp8 (e4m3fnuz) GEMM throughput: hipBLASLt via torch._scaled_mm
  * bf16 GEMM throughput: hipBLASLt via torch.mm

Each case is looped for a few seconds while amd-smi samples power / gfx clock, so
the numbers are the sustained (power-capped) ones, not the boost ones.

    python doc-mimo/experiments/ep8_roofline/roofline.py
"""
import re
import subprocess
import sys
import threading
import time

import torch

dev = torch.cuda.current_device()


def sample_power(stop, samples):
    while not stop[0]:
        s = subprocess.run(["amd-smi", "metric", "-g", str(dev), "-c", "-p"],
                           capture_output=True, text=True).stdout
        pw = re.search(r"SOCKET_POWER:\s*(\d+)", s)
        clk = [int(v) for v in re.findall(r"^\s+CLK:\s*(\d+) MHz", s, re.M)][:8]
        if pw and clk:
            samples.append((int(pw.group(1)), sum(clk) / len(clk)))


def bench(fn, secs=4.0):
    for _ in range(5):
        fn()
    torch.cuda.synchronize()
    samples, stop = [], [False]
    th = threading.Thread(target=sample_power, args=(stop, samples))
    th.start()
    e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    n, t_end = 0, time.time() + secs
    e0.record()
    while time.time() < t_end:
        for _ in range(20):
            fn()
        n += 20
        torch.cuda.synchronize()
    e1.record()
    torch.cuda.synchronize()
    stop[0] = True
    th.join()
    us = e0.elapsed_time(e1) * 1e3 / n
    s = samples[1:] or samples
    pw = sum(p for p, _ in s) / max(1, len(s))
    clk = sum(c for _, c in s) / max(1, len(s))
    return us, pw, clk


def main():
    which = sys.argv[1:] or ["hbm", "fp8", "bf16"]
    if "hbm" in which:
        for mb in (408, 1024):
            x = torch.empty(mb * 2**20 // 4, dtype=torch.float32, device="cuda").uniform_()
            us, pw, clk = bench(lambda: torch.sum(x))
            print(f"hbm read {mb:5d} MB: {us:8.1f} us {mb * 2**20 / us / 1e6:6.2f} TB/s"
                  f"  {pw:4.0f} W {clk:5.0f} MHz", flush=True)
            del x
    shapes = [(8192, 8192, 8192), (4096, 4096, 4096), (16384, 4096, 4096),
              (16384, 4096, 2048), (512, 4096, 4096), (2048, 4096, 4096)]
    if "fp8" in which:
        for m, n, k in shapes:
            a = (torch.randn(m, k, device="cuda") * 0.5).to(torch.float8_e4m3fnuz)
            b = (torch.randn(n, k, device="cuda") * 0.5).to(torch.float8_e4m3fnuz)
            one = torch.ones((), device="cuda")
            fn = lambda: torch._scaled_mm(a, b.t(), scale_a=one, scale_b=one,  # noqa: E731
                                          out_dtype=torch.bfloat16)
            us, pw, clk = bench(fn)
            print(f"fp8  gemm {m:6d}x{n:5d}x{k:5d}: {us:8.1f} us {2 * m * n * k / us / 1e6:7.1f}"
                  f" TFLOPs  {pw:4.0f} W {clk:5.0f} MHz", flush=True)
    if "bf16" in which:
        for m, n, k in shapes:
            a = torch.randn(m, k, device="cuda", dtype=torch.bfloat16)
            b = torch.randn(n, k, device="cuda", dtype=torch.bfloat16)
            fn = lambda: torch.mm(a, b.t())  # noqa: E731
            us, pw, clk = bench(fn)
            print(f"bf16 gemm {m:6d}x{n:5d}x{k:5d}: {us:8.1f} us {2 * m * n * k / us / 1e6:7.1f}"
                  f" TFLOPs  {pw:4.0f} W {clk:5.0f} MHz", flush=True)


if __name__ == "__main__":
    main()

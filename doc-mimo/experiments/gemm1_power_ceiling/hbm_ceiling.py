"""HBM streaming ceiling on this GPU: read-only (sum) and copy of ~570 MB (the
gemm1 weight footprint), with clock / power sampled while looping.

    python doc-mimo/experiments/gemm1_power_ceiling/hbm_ceiling.py
"""
import re
import subprocess
import threading
import time

import torch

dev = torch.cuda.current_device()
NB = 576 * 2**20
x = torch.empty(NB // 4, dtype=torch.float32, device="cuda").uniform_()
y = torch.empty_like(x)
out = torch.empty(1, device="cuda")


def bench(fn, nbytes, secs=6.0):
    samples, stop = [], [False]

    def sampler():
        while not stop[0]:
            s = subprocess.run(["amd-smi", "metric", "-g", str(dev), "-c", "-p"],
                               capture_output=True, text=True).stdout
            pw = re.search(r"SOCKET_POWER:\s*(\d+)", s)
            clk = [int(v) for v in re.findall(r"^\s+CLK:\s*(\d+) MHz", s, re.M)][:8]
            if pw and clk:
                samples.append((int(pw.group(1)), sum(clk) / len(clk)))

    for _ in range(10):
        fn()
    torch.cuda.synchronize()
    th = threading.Thread(target=sampler)
    th.start()
    e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    n, t_end = 0, time.time() + secs
    e0.record()
    while time.time() < t_end:
        for _ in range(100):
            fn()
        n += 100
        torch.cuda.synchronize()
    e1.record()
    torch.cuda.synchronize()
    stop[0] = True
    th.join()
    us = e0.elapsed_time(e1) * 1e3 / n
    s = samples[1:] or samples
    print(f"  {us:7.1f} us  {nbytes / us / 1e6:5.2f} TB/s   power {sum(p for p, _ in s) / len(s):.0f} W"
          f"  gfx clk {sum(c for _, c in s) / len(s):.0f} MHz  ({len(s)} samples)")


print(f"read  {NB / 2**20:.0f} MB (torch.sum):")
bench(lambda: torch.sum(x), NB)
print(f"copy  {NB / 2**20:.0f} MB -> {NB / 2**20:.0f} MB (bytes = read + write):")
bench(lambda: y.copy_(x), 2 * NB)

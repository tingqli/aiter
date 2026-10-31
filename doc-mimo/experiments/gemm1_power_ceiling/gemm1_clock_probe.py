"""Run one a8w4 gemm1 kernel (standalone or port) in a tight loop and sample the GPU
shader clock / power, to check whether the kernel is clock-throttled.

    python doc-mimo/experiments/gemm1_power_ceiling/gemm1_clock_probe.py [standalone|port] [seconds]
"""
import os
import subprocess
import sys
import threading
import time

import torch

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "../../kernels"))
import test_a8w4_gemm1 as T  # noqa: E402

which = sys.argv[1] if len(sys.argv) > 1 else "standalone"
secs = float(sys.argv[2]) if len(sys.argv) > 2 else 4.0

# Reuse bench_a8w4_gemm1's setup by capturing the candidate closures.
captured = {}
orig = T.run_perftest


def grab(fn, *a, **k):
    captured.setdefault("fns", []).append(fn)
    return orig(fn, *a, **k)


T.run_perftest = grab
T.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=32, tile_n=128)
# candidate order in bench_a8w4_gemm1: standalone, port, tile, tile_fd, tile_fd2
NAMES = ("standalone", "port", "tile", "fd1", "fd2")
fn = captured["fns"][NAMES.index(which)]

dev = torch.cuda.current_device()
samples = []
stop = False


def sampler():
    while not stop:
        out = subprocess.run(
            ["amd-smi", "metric", "-g", str(dev), "-c", "-p"],
            capture_output=True, text=True,
        ).stdout
        samples.append(out)
        time.sleep(0.2)


ev0, ev1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
th = threading.Thread(target=sampler)
th.start()
t_end = time.time() + secs
n = 0
ev0.record()
while time.time() < t_end:
    for _ in range(200):
        fn()
    n += 200
    torch.cuda.synchronize()
ev1.record()
torch.cuda.synchronize()
stop = True
th.join()
print(f"{which}: {n} launches, {ev0.elapsed_time(ev1) * 1e3 / n:.1f} us/launch (incl. launch overhead)")
import re  # noqa: E402

for s in samples[1:-1]:
    pw = re.search(r"SOCKET_POWER:\s*(\d+)", s)
    clk = [int(x) for x in re.findall(r"^\s+CLK:\s*(\d+) MHz", s, re.M)]
    print(f"  power {pw.group(1) if pw else '?'} W  gfx clk (XCD0-7) {clk[:8]}  other {clk[8:]}")

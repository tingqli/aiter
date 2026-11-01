"""gfx clock / power while the best A8W4 MoE config of bench.py runs in a loop.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/moe_token_scaling/probe_clock.py
"""
import os
import re
import subprocess
import sys
import threading
import time

import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import bench as B  # noqa: E402
from bench import E, MD, TOPK, M, aiter, dtypes, fused_topk  # noqa: E402
from aiter import QuantType  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

INTER = 256
CASES = [(128, 64, 1), (512, 32, 1), (2048, 32, 1), (16384, 64, 1)]  # tokens, bm, bcm


def sample(fn, secs=8.0):
    samples, stop = [], [False]

    def sampler():
        while not stop[0]:
            samples.append(subprocess.run(["amd-smi", "metric", "-g", "0", "-c", "-p"],
                                          capture_output=True, text=True).stdout)

    th = threading.Thread(target=sampler)
    th.start()
    n, t0 = 0, time.time()
    while time.time() - t0 < secs:
        for _ in range(20):
            fn()
        n += 20
        torch.cuda.synchronize()
    dt = time.time() - t0
    stop[0] = True
    th.join()
    clk, pw = [], []
    for s in samples[1:-1]:
        m = re.search(r"SOCKET_POWER:\s*(\d+)", s)
        c = [int(x) for x in re.findall(r"^\s+CLK:\s*(\d+) MHz", s, re.M)][:8]
        if m and c:
            pw.append(int(m.group(1)))
            clk.append(sum(c) / len(c))
    return dt / n * 1e6, clk, pw


torch.manual_seed(0)
w1 = torch.randn((E, INTER * 2, MD), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, MD, INTER), dtype=dtypes.bf16, device="cuda")
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
W = M.a8w4_prepare_weights(
    shuffle_weight_a16w4(w1q.view(E, INTER * 2, MD // 2), 16, False),
    shuffle_weight_a16w4(w2q.view(E, MD, INTER // 2), 16, False),
    shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False), fast_dec=2)
for tok, bm, bcm in CASES:
    x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
    tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
    M.A8W4_E2E_CFGS[bm] = B.g_cfgs(bm, bcm)
    fn = lambda: M.a8w4_fused_moe(x, W, tw, ti, block_m=bm, fuse_quant=True)  # noqa: E731
    fn()
    us, clk, pw = sample(fn)
    print(f"tok {tok:6d} bm{bm} bcm{bcm}: {us:7.1f} us/iter (wall, incl. launch)  "
          f"gfx clk avg {sum(clk) / max(len(clk), 1):6.0f} MHz (min {min(clk, default=0):.0f} "
          f"max {max(clk, default=0):.0f})  power avg {sum(pw) / max(len(pw), 1):.0f} W  "
          f"[{len(clk)} samples]", flush=True)

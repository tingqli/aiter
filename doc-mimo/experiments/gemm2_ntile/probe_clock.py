"""gfx clock / power while one gemm2 variant runs in a tight loop (power-cap check).

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/gemm2_ntile/probe_clock.py [-t 8192] [--cfg 0:0 4:16]
"""
import argparse
import os
import re
import subprocess
import sys
import threading
import time

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
import test_a8w4_gemm2 as G  # noqa: E402
from aiter import QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

p = argparse.ArgumentParser()
p.add_argument("-t", type=int, default=8192)
p.add_argument("--cfg", nargs="*", default=["0:0", "4:16"], help="n_tiles:stage_rows")
p.add_argument("--secs", type=float, default=6.0)
args = p.parse_args()

E, MD, INTER, TOPK, BM = 256, 4096, 256, 8, 64
torch.manual_seed(0)
w2 = torch.randn((E, MD, INTER), dtype=dtypes.bf16, device="cuda")
w2_qt, w2_scale = aiter.get_torch_quant(QuantType.per_1x32)(w2, quant_dtype=dtypes.fp4x2)
w2_u8 = shuffle_weight_a16w4(w2_qt.view(E, MD, INTER // 2), 16, False).view(torch.uint8)
w2_s = shuffle_scale_a16w4(w2_scale, E, False).view(torch.uint8).contiguous().view(-1)
W, WS = G.prep_w2_fast(w2_u8, w2_s, 2)
tok = args.t
x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
sids, sw, seids, nv, _ = moe_sorting(ti, tw, E, MD, dtypes.bf16, BM)[:5]
a8, asc = G.quantize_groups(torch.randn((seids.numel() * BM, INTER), dtype=dtypes.bf16, device="cuda"), 128)
out = torch.zeros((tok, MD), dtype=dtypes.bf16, device="cuda")

for cfg in args.cfg:
    nt, sr = map(int, cfg.split(":"))
    fn = lambda: G.a8w4_gemm2(  # noqa: E731
        a8, asc, W, WS, sids, sw, seids, nv, out, num_experts=E, tile_m=BM, tile_n=128,
        b_cache_mod=2, dyn_rows=True, a_group=128, fast_dec=2, n_tiles=nt, stage_rows=sr)
    fn()
    torch.cuda.synchronize()
    samples, stop = [], [False]

    def sampler():
        while not stop[0]:
            samples.append(subprocess.run(["amd-smi", "metric", "-g", "0", "-c", "-p"],
                                          capture_output=True, text=True).stdout)

    th = threading.Thread(target=sampler)
    th.start()
    ev0, ev1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    n, t0 = 0, time.time()
    ev0.record()
    while time.time() - t0 < args.secs:
        for _ in range(50):
            fn()
        n += 50
        torch.cuda.synchronize()
    ev1.record()
    torch.cuda.synchronize()
    stop[0] = True
    th.join()
    clk, pw = [], []
    for s in samples[1:-1]:
        m = re.search(r"SOCKET_POWER:\s*(\d+)", s)
        c = [int(v) for v in re.findall(r"^\s+CLK:\s*(\d+) MHz", s, re.M)][:8]
        if m and c:
            pw.append(int(m.group(1)))
            clk.append(sum(c) / len(c))
    us = ev0.elapsed_time(ev1) * 1e3 / n
    mhz = sum(clk) / max(len(clk), 1)
    print(f"tok {tok} n_tiles {nt} stage_rows {sr}: {us:7.1f} us/iter  gfx clk {mhz:6.0f} MHz  "
          f"power {sum(pw) / max(len(pw), 1):4.0f} W  -> {us * mhz / 1e3:7.0f} kcycles/iter "
          f"[{len(clk)} samples]", flush=True)

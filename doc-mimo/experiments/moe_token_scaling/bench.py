"""A8W4 MoE (fd2 gemm1 + gemm2, fused quant) token scaling 128 -> 16384.

Per token count: sweep block_m (32/64/128) x gemm1 b_cache_mod (1/2), report the
per-kernel time breakdown of the fastest config (torch profiler, kernel time sum,
no launch gaps), unique-weight bandwidth, useful / padded MFMA TFLOPs, and the
gfx clock / power sampled while that config runs in a loop. Reference: the
current aiter ``fused_moe`` a16w4 selection on the same weights.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/moe_token_scaling/bench.py [inter_dim]
"""
import json
import os
import re
import subprocess
import sys
import threading
import time
from collections import defaultdict

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import aiter  # noqa: E402
import test_flydsl_moe_a16wfp4 as M  # noqa: E402
from aiter import ActivationType, QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_moe, fused_topk  # noqa: E402
from aiter.ops.flydsl.moe_common import GateMode  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

E, MD, TOPK = 256, 4096, 8
INTER = int(sys.argv[1]) if len(sys.argv) > 1 else 256
TOKENS = [128 << i for i in range(8)]  # 128 .. 16384
BMS = (32, 64, 128)
BCMS = (1, 2)
ITERS = 20


def g_cfgs(bm, bcm):
    g1 = dict(tile_n=128, b_cache_mod=bcm, xcd_swizzle=1)
    if bm >= 64:
        g1["dyn_m"] = True
    g2 = dict(tile_n=128, b_cache_mod=2, xcd_swizzle=0, dyn_rows=True)
    return g1, g2


def stage(name):
    if "moe_sorting" in name:
        return "sort"
    if "a8w4_gemm1" in name:
        return "gemm1"
    if "a8w4_gemm2" in name:
        return "gemm2"
    if name == "kernel_0":
        return "quant"
    return "other"


def profile(fn, iters=ITERS):
    fn()
    torch.cuda.synchronize()
    with torch.profiler.profile(activities=[torch.profiler.ProfilerActivity.CUDA]) as p:
        for _ in range(iters):
            fn()
        torch.cuda.synchronize()
    t = defaultdict(float)
    for e in p.events():
        if e.device_type == torch.autograd.DeviceType.CUDA:
            t[stage(e.name)] += e.device_time / iters
    t["total"] = sum(t.values())
    return dict(t)


def clock_power(fn, secs=1.5):
    dev = torch.cuda.current_device()
    samples, stop = [], [False]

    def sampler():
        while not stop[0]:
            samples.append(subprocess.run(["amd-smi", "metric", "-g", str(dev), "-c", "-p"],
                                          capture_output=True, text=True).stdout)
            time.sleep(0.2)

    th = threading.Thread(target=sampler)
    th.start()
    t_end = time.time() + secs
    while time.time() < t_end:
        for _ in range(20):
            fn()
        torch.cuda.synchronize()
    stop[0] = True
    th.join()
    clk, pw = [], []
    for s in samples[1:-1]:
        m = re.search(r"SOCKET_POWER:\s*(\d+)", s)
        c = [int(x) for x in re.findall(r"^\s+CLK:\s*(\d+) MHz", s, re.M)][:8]
        if m and c:
            pw.append(int(m.group(1)))
            clk.append(sum(c) / len(c))
    return (sum(clk) / len(clk) if clk else 0.0), (sum(pw) / len(pw) if pw else 0.0)


def main():
    torch.manual_seed(0)
    w1 = torch.randn((E, INTER * 2, MD), dtype=dtypes.bf16, device="cuda")
    w2 = torch.randn((E, MD, INTER), dtype=dtypes.bf16, device="cuda")
    tq = aiter.get_torch_quant(QuantType.per_1x32)
    w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
    w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
    del w1, w2
    w1g = shuffle_weight_a16w4(w1q.view(E, INTER * 2, MD // 2), 16, False)
    w2g = shuffle_weight_a16w4(w2q.view(E, MD, INTER // 2), 16, False)
    s1g, s2g = shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False)
    W = M.a8w4_prepare_weights(w1g, w2g, s1g, s2g, fast_dec=2)
    # bytes per expert: mxfp4 W (0.5 B/elem) + e8m0 scale (1/32 B/elem)
    b1 = 2 * INTER * MD * (0.5 + 1 / 32)
    b2 = MD * INTER * (0.5 + 1 / 32)

    rows = []
    for tok in TOKENS:
        x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
        score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
        tw, ti = fused_topk(x, score, TOPK, True)
        cnt = torch.bincount(ti.view(-1).long(), minlength=E)
        n_act = int((cnt > 0).sum())
        res = {}
        for bm in BMS:
            for bcm in BCMS:
                M.A8W4_E2E_CFGS[bm] = g_cfgs(bm, bcm)
                key = f"bm{bm}_bcm{bcm}"
                try:
                    fn = lambda: M.a8w4_fused_moe(x, W, tw, ti, block_m=bm, fuse_quant=True)  # noqa: E731
                    res[key] = profile(fn)
                except Exception as ex:  # noqa: BLE001
                    print(f"  tok {tok} {key}: FAILED {type(ex).__name__}: {str(ex)[:120]}")
        best = min(res, key=lambda k: res[k]["total"])
        bm, bcm = int(best.split("_")[0][2:]), int(best.split("_")[1][3:])
        M.A8W4_E2E_CFGS[bm] = g_cfgs(bm, bcm)
        fn = lambda: M.a8w4_fused_moe(x, W, tw, ti, block_m=bm, fuse_quant=True)  # noqa: E731
        clk, pw = clock_power(fn)
        try:
            ref = profile(lambda: fused_moe(
                x, w1g, w2g, tw, ti, w1_scale=s1g, w2_scale=s2g,
                quant_type=QuantType.per_1x32, activation=ActivationType.Silu,
                doweight_stage1=False, gate_mode=GateMode.SEPARATED.value), iters=5)["total"]
        except Exception as ex:  # noqa: BLE001
            print(f"  tok {tok} fused_moe ref FAILED {type(ex).__name__}: {str(ex)[:120]}")
            ref = float("nan")
        # MFMA rows actually computed (padding to block_m; dyn_m/dyn_rows halve cold blocks)
        nb = (cnt + bm - 1) // bm
        rows_pad = int((nb * bm).sum())
        if bm >= 64:
            last = cnt - (nb - 1) * bm
            rows_pad -= int(((last > 0) & (last <= bm // 2)).sum()) * (bm // 2)
        b = res[best]
        f1 = 2 * tok * TOPK * MD * 2 * INTER
        f2 = 2 * tok * TOPK * INTER * MD
        pad = rows_pad / (tok * TOPK)
        row = dict(
            tokens=tok, best=best, n_act=n_act, all=res, ref_fused_moe_us=ref,
            clk_mhz=clk, power_w=pw, pad=pad,
            g1_tbps=n_act * b1 / b["gemm1"] / 1e6, g2_tbps=n_act * b2 / b["gemm2"] / 1e6,
            moe_tbps=n_act * (b1 + b2) / b["total"] / 1e6,
            g1_tflops=f1 / b["gemm1"] / 1e6, g2_tflops=f2 / b["gemm2"] / 1e6,
            g1_tflops_pad=f1 * pad / b["gemm1"] / 1e6, g2_tflops_pad=f2 * pad / b["gemm2"] / 1e6,
        )
        rows.append(row)
        print(
            f"tok {tok:6d} best {best:11s} total {b['total']:8.1f} us "
            f"(sort {b.get('sort', 0):5.1f} quant {b.get('quant', 0):5.1f} "
            f"g1 {b['gemm1']:7.1f} g2 {b['gemm2']:7.1f}) | ref {ref:8.1f} | "
            f"act {n_act} pad {pad:.2f} | BW g1 {row['g1_tbps']:.2f} g2 {row['g2_tbps']:.2f} "
            f"moe {row['moe_tbps']:.2f} TB/s | TF g1 {row['g1_tflops']:.0f}/{row['g1_tflops_pad']:.0f} "
            f"g2 {row['g2_tflops']:.0f}/{row['g2_tflops_pad']:.0f} | {clk:.0f} MHz {pw:.0f} W",
            flush=True,
        )
        print("    " + "  ".join(f"{k} {v['total']:.1f}" for k, v in res.items()), flush=True)
    os.makedirs(os.path.join(HERE, "results"), exist_ok=True)
    with open(os.path.join(HERE, f"results/token_scaling_i{INTER}.json"), "w") as f:
        json.dump(rows, f, indent=1)


if __name__ == "__main__":
    main()

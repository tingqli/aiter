"""gemm2 tile order: cost, and when each 512-column output chunk becomes final (s_memrealtime probe).

    python doc-mimo/experiments/gemm2_tile_order/g2_order_probe.py    # ORDERS=m,n,nx,g
"""
import os, sys, logging, torch
ORDERS = os.environ.get("ORDERS", "m,n,nx,g").split(",")
sys.path.insert(0, "doc-mimo/kernels"); logging.disable(logging.WARNING)
import test_a8w4_gemm2 as t
import aiter
from aiter import QuantType, dtypes
from aiter.fused_moe import fused_topk, moe_sorting
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows

# ---- 1. timing (bench: correctness vs fp32 ref + run_perftest) ----
for rep in range(2):
    for tok in (128, 512, 2048):
        line = []
        for order in ORDERS:
            r = t.bench_a8w4_gemm2(tok, 4096, 256, 256, 8, routing="uniform", tile_m=32,
                                   dyn_rows=True, tile_order=order)
            line.append(f"{order}={r['a8w4_gemm2 us']:.1f}(err={r['a8w4_gemm2 err']:.0e})")
        print(f"TIME rep={rep} tok={tok}: " + "  ".join(line), flush=True)

# ---- 2. probe: completion time of each 512-column chunk ----
E, D, I, K, BM, TN = 256, 4096, 256, 8, 32, 128
NB = D // TN
for tok in (128, 512, 2048):
    torch.manual_seed(0)
    inp = torch.randn((tok, D), dtype=dtypes.bf16, device="cuda")
    score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
    tw, ti = fused_topk(inp, score, K, True)
    w2 = torch.randn((E, D, I), dtype=dtypes.bf16, device="cuda")
    w2q, w2s = aiter.get_torch_quant(QuantType.per_1x32)(w2, quant_dtype=dtypes.fp4x2)
    w2u = shuffle_weight_a16w4(w2q.view(E, D, I // 2), 16, False).view(torch.uint8)
    w2su = shuffle_scale_a16w4(w2s, E, False).view(torch.uint8).contiguous().view(-1)
    sids, sw, seids, nv, _ = moe_sorting(ti, tw, E, D, dtypes.bf16, BM)[:5]
    a, s = quantize_rows(torch.randn((seids.numel() * BM, I), dtype=dtypes.bf16, device="cuda"), nv)
    out = torch.zeros((tok, D), dtype=dtypes.bf16, device="cuda")
    mb = int(nv[0]) // BM
    for order in ORDERS:
        dbg = torch.zeros(seids.numel() * NB * 2, dtype=torch.int64, device="cuda")
        f = lambda: t.a8w4_gemm2(a, s, w2u, w2su, sids, sw, seids, nv, out, num_experts=E,
                                 tile_m=BM, tile_n=TN, dyn_rows=True, tile_order=order, dbg=dbg)
        for _ in range(5): f()
        torch.cuda.synchronize()
        res = []
        for _ in range(5):
            f(); torch.cuda.synchronize()
            ts = dbg[: mb * NB * 2].view(mb, NB, 2).double() * 10e-3  # 100 MHz -> us
            t0, t1 = ts[..., 0].min(), ts[..., 1].max()
            col_done = ts[..., 1].amax(0) - t0              # [NB] per 128-col block
            chunk = col_done.view(8, NB // 8).amax(1)       # 8 chunks of 512 cols
            res.append((float(t1 - t0), chunk))
        span = sorted(res, key=lambda r: r[0])[2]           # median run
        tot, ch = span
        print(f"PROBE tok={tok} order={order:2s} span={tot:6.1f}us  chunk final at (% of span): "
              + " ".join(f"{100 * float(c) / tot:3.0f}" for c in ch), flush=True)

"""WPERM sanity probe: which K does each B byte of the fp4 -> fp8 decode pair with?

A has a single 1.0 at column ``KA`` (all rows), W is all-ones except W[:, :, KW] = 2
(fp4 code for 2.0) -> out[t, n] = topk_weight-sum * (2 if KA == KW else 1) * scales.
Running every (KA, KW) in one 8-wide K group shows whether the kernel pairs A[k] with
W[k] (diagonal) for the current decode (WPERM env).

    WPERM=0|1 HIP_VISIBLE_DEVICES=0 python doc-mimo/experiments/scripts/wperm_probe.py
"""
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "..", "kernels"))

import aiter  # noqa: E402
from aiter import QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

import test_a8w4_gemm2 as t  # noqa: E402


def run(KA, KW, tok=32, E=8, D=512, I=256, K=2, BM=32):
    torch.manual_seed(0)
    inp = torch.randn((tok, D), dtype=dtypes.bf16, device="cuda")
    score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
    tw, ti = fused_topk(inp, score, K, True)
    w2 = torch.ones((E, D, I), dtype=dtypes.bf16, device="cuda")
    w2[:, :, KW] = 2.0
    w2q, w2s = aiter.get_torch_quant(QuantType.per_1x32)(w2, quant_dtype=dtypes.fp4x2)
    w2u = shuffle_weight_a16w4(w2q.view(E, D, I // 2), 16, False).view(torch.uint8)
    w2su = shuffle_scale_a16w4(w2s, E, False).view(torch.uint8).contiguous().view(-1)
    sids, sw, seids, nv, _ = moe_sorting(ti, tw, E, D, dtypes.bf16, BM)[:5]
    a = torch.zeros((seids.numel() * BM, I), dtype=torch.float32, device="cuda")
    a[:, KA] = 1.0
    a8 = a.to(dtypes.fp8)
    asc = torch.ones((seids.numel() * BM,), dtype=torch.float32, device="cuda")
    out = torch.zeros((tok, D), dtype=dtypes.bf16, device="cuda")
    t.a8w4_gemm2(a8, asc, w2u, w2su, sids, sw, seids, nv, out, num_experts=E,
                 tile_m=BM, tile_n=128, dyn_rows=True)
    torch.cuda.synchronize()
    return out.float()


base = run(0, 255)  # KA=0 pairs with a 1.0 weight
print(f"WPERM={int(t.WPERM)}: ratio out(KA, KW)/out(KA, far) over one 8-K group")
for KA in range(8):
    row = []
    for KW in range(8):
        r = (run(KA, KW) / base).nanmean().item()
        row.append(f"{r:4.2f}")
    print(f"  KA={KA}: " + " ".join(row))

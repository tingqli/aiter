"""End-to-end A8W4 MoE (a8w4_fused_moe, gemm1 + gemm2) with fast_dec 0/1/2:
run-to-run noise of the e2e output (bf16 atomics in gemm2) vs the fd difference, and
bit-exactness of the gemm1 intermediate.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/fast_decode/fd_e2e_check.py
"""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
import test_flydsl_moe_a16wfp4 as M  # noqa: E402
from aiter import QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402
from test_a8w4_gemm1 import a8w4_gemm1  # noqa: E402

E, md, inter, topk, tok = 256, 4096, 256, 8, 128
torch.manual_seed(0)
inp = torch.randn((tok, md), dtype=dtypes.bf16, device="cuda")
w1 = torch.randn((E, inter * 2, md), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, md, inter), dtype=dtypes.bf16, device="cuda")
score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
tw, ti = fused_topk(inp, score, topk, True)
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
w1q = w1q.view(E, inter * 2, md // 2)
w2q = w2q.view(E, md, inter // 2)
args = (shuffle_weight_a16w4(w1q, 16, False), shuffle_weight_a16w4(w2q, 16, False),
        shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False))
W = {fd: M.a8w4_prepare_weights(*args, fast_dec=fd) for fd in (0, 1, 2)}
o = {fd: [M.a8w4_fused_moe(inp, W[fd], tw, ti, block_m=32).clone() for _ in range(2)]
     for fd in (0, 1, 2)}
cd = M._cos_diff
d = (o[0][0].float() - o[0][1].float()).abs().max()
print(f"cmp fd0 run-to-run cos {cd(o[0][0].float(), o[0][1].float()):.2e} maxabs {d:.3e} "
      f"equal {torch.equal(o[0][0], o[0][1])}")
for fd in (1, 2):
    d = (o[0][0].float() - o[fd][0].float()).abs().max()
    print(f"cmp fd0 vs fd{fd} cos {cd(o[0][0].float(), o[fd][0].float()):.2e} maxabs {d:.3e}")
s = moe_sorting(ti, tw, E, md, dtypes.bf16, 32)[:5]
x8, xs = quantize_rows(inp)
outs = {}
for fd in (0, 1, 2):
    out = torch.zeros((s[2].numel() * 32, inter), dtype=dtypes.bf16, device="cuda")
    a8w4_gemm1(x8, xs, W[fd]["w1"], W[fd]["w1_scale"], W[fd]["w1_exp"], s[0], s[2], s[3],
               out, num_experts=E, tile_m=32, tile_n=128, xcd_swizzle=1, fast_dec=fd)
    outs[fd] = out
print(f"cmp gemm1 inter fd0==fd1 {torch.equal(outs[0], outs[1])} "
      f"fd0==fd2 {torch.equal(outs[0], outs[2])}")

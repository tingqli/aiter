"""Kernel names launched by one a8w4_fused_moe call (probe for bench.py)."""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import aiter  # noqa: E402
import test_flydsl_moe_a16wfp4 as M  # noqa: E402
from aiter import QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_topk  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

E, md, inter, topk, tok = 256, 4096, 256, 8, 512
inp = torch.randn((tok, md), dtype=dtypes.bf16, device="cuda")
w1 = torch.randn((E, inter * 2, md), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, md, inter), dtype=dtypes.bf16, device="cuda")
tw, ti = fused_topk(inp, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), topk, True)
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
W = M.a8w4_prepare_weights(
    shuffle_weight_a16w4(w1q.view(E, inter * 2, md // 2), 16, False),
    shuffle_weight_a16w4(w2q.view(E, md, inter // 2), 16, False),
    shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False), fast_dec=2)
M.a8w4_fused_moe(inp, W, tw, ti, block_m=64, fuse_quant=True)
torch.cuda.synchronize()
with torch.profiler.profile(activities=[torch.profiler.ProfilerActivity.CUDA]) as p:
    M.a8w4_fused_moe(inp, W, tw, ti, block_m=64, fuse_quant=True)
    torch.cuda.synchronize()
for e in p.events():
    if e.device_type == torch.autograd.DeviceType.CUDA:
        print(f"{e.device_time:9.1f} us  {e.name[:120]}")

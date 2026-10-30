import sys, collections, torch, logging
sys.path.insert(0, "doc-mimo/kernels"); logging.disable(logging.WARNING)
import aiter
from aiter import QuantType, dtypes
from aiter.fused_moe import fused_topk
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
from test_flydsl_moe_a16wfp4 import a8w4_fused_moe, a8w4_prepare_weights
from torch.profiler import profile, ProfilerActivity
E, topk, D, I = 256, 8, 4096, 256
for tok in (128, 512, 2048):
    torch.manual_seed(0)
    inp = torch.randn((tok, D), dtype=dtypes.bf16, device="cuda")
    w1 = torch.randn((E, 2 * I, D), dtype=dtypes.bf16, device="cuda")
    w2 = torch.randn((E, D, I), dtype=dtypes.bf16, device="cuda")
    score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
    tw, ti = fused_topk(inp, score, topk, True)
    tq = aiter.get_torch_quant(QuantType.per_1x32)
    w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2); w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
    w1q = w1q.view(E, 2 * I, D // 2); w2q = w2q.view(E, D, I // 2)
    W = a8w4_prepare_weights(shuffle_weight_a16w4(w1q, 16, False), shuffle_weight_a16w4(w2q, 16, False),
                             shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False))
    for bm in (32, 64):
        for fq in (False, True):
            for _ in range(3): a8w4_fused_moe(inp, W, tw, ti, block_m=bm, fuse_quant=fq)
            torch.cuda.synchronize()
            n = 50
            with profile(activities=[ProfilerActivity.CUDA]) as p:
                for _ in range(n): a8w4_fused_moe(inp, W, tw, ti, block_m=bm, fuse_quant=fq)
                torch.cuda.synchronize()
            agg = collections.OrderedDict()
            for e in p.events():
                if e.device_type.name == "CUDA":
                    k = e.name.split("_h4096")[0].split("(")[0][:28]
                    agg[k] = agg.get(k, 0) + e.device_time / n
            tot = sum(agg.values())
            print(f"tok={tok:5d} bm{bm} fq={int(fq)} total={tot:6.1f}  " + "  ".join(f"{k}={v:.1f}" for k, v in agg.items() if v > 0.3), flush=True)

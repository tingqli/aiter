"""Debug: FMOEQ_DBG=trace run of test_a8w4_fmoe_bm64q -> task visits per block."""
import collections
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_fmoe_bm64q as Q  # noqa: E402

from aiter import dtypes  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402

E, MD = 256, 4096
tok = int(sys.argv[1]) if len(sys.argv) > 1 else 512
x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), 8, True)
sids, sw, seids, nv, buf = moe_sorting(ti, tw, E, MD, dtypes.bf16, 64)[:5]
nblk = int(nv[0]) // 64
print("blocks", nblk, "grid", seids.numel(), flush=True)
W = {"w1_fast_dec": 2, "w2_fast_dec": 2,
     "w1": torch.empty(E, 512, 2048, dtype=torch.uint8, device="cuda"),
     "w2": torch.empty(E, MD, 128, dtype=torch.uint8, device="cuda"),
     "w1_scale": torch.empty(1, device="cuda"), "w1_exp": torch.empty(1, device="cuda"),
     "w2_scale": torch.empty(1, device="cuda")}
ws = Q._workspace(max(seids.numel(), Q.TRACE_N), x.device)
ws["ctl"].zero_()
ws["epoch"] = 0
x8 = torch.empty((tok, MD), dtype=torch.uint8, device="cuda")
xs = torch.empty(tok, device="cuda")
Q.a8w4_fmoe_bm64q(x8, xs, W, sids, sw, seids, nv, buf)
torch.cuda.synchronize()
c = ws["ctl"][Q.CTL_FLAGS:Q.CTL_FLAGS + Q.TRACE_N].cpu().tolist()
print("counters", ws["ctl"][:16].tolist())
print("histogram (blocks < nblk):", collections.Counter(c[:nblk]))
print("nonzero beyond nblk:", [(i, v) for i, v in enumerate(c) if i >= nblk and v][:10])

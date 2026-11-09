"""gemm1 fabric reads for the first NB sort blocks only (1, 2, 4 batches of 256 tasks)."""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_bs_moe as t  # noqa: E402
from bs_prep import bs_prep  # noqa: E402
from bs_gemm1 import fp8_blockscale_stage1  # noqa: E402

F8 = torch.float8_e4m3fn
model, T = sys.argv[1], int(sys.argv[2])
H, I, E, topk = t.MODELS[model]
case = t.make_case(model, T)
si, sw, se, nv, a, sa, _ = bs_prep(case["x"], case["topk_ids"], case["topk_weights"], E)
w1, s1 = case["w1"], case["w1_scale"]
a2 = torch.empty(T, topk, I, dtype=F8, device="cuda")
sa2 = torch.empty(I // 128, T * topk, dtype=torch.float32, device="cuda")
for nb in (128, 256, 512, int(nv[0]) // 256):
    nv2 = nv.clone()
    nv2[0] = nb * 256
    f = lambda: fp8_blockscale_stage1(a, w1, sa, s1, si, se, nv2, a2, output_scale=sa2)  # noqa: E731
    for _ in range(3):
        f()
    torch.cuda.synchronize()
    print("blocks", nb, flush=True)

"""gemm2 fast decode bit-exactness. gemm2 scatters with bf16 atomics, so with topk>1
the output depends on the add order; with topk=1 every output element receives one
add and the result is deterministic -> fd1 / fd2 must equal the original exactly.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/fast_decode/fd_gemm2_bitexact_topk1.py
"""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm2 as T  # noqa: E402

T.run_perftest = lambda fn, *a, **k: (None, 1.0)  # correctness only
rec = {}
g = T.a8w4_gemm2


def wrapped(*a, fast_dec=0, **k):
    rec[fast_dec] = g(*a, fast_dec=fast_dec, **k)
    return rec[fast_dec]


T.a8w4_gemm2 = wrapped
for inter, tm in ((512, 32), (512, 64), (256, 32)):
    rec.clear()
    T.bench_a8w4_gemm2(512, 4096, inter, 256, 1, routing="uniform", tile_m=tm, dyn_rows=True)
    print(f"chk I{inter} bm{tm} topk1: fd1==std {torch.equal(rec[1], rec[0])} "
          f"fd2==std {torch.equal(rec[2], rec[0])}")

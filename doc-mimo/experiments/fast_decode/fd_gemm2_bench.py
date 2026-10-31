"""gemm2 fast decode: original vs fd1 / fd2 vs port over a few shapes (model_dim
4096, dyn_rows), with the reference error of each candidate.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/fast_decode/fd_gemm2_bench.py
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm2 as T  # noqa: E402

for md, inter, E, tok in ((4096, 512, 256, 512), (4096, 512, 304, 512),
                          (4096, 256, 256, 512), (4096, 512, 256, 2048)):
    for tm in (32, 64):
        r = T.bench_a8w4_gemm2(tok, md, inter, E, 8, routing="uniform", tile_m=tm,
                               dyn_rows=True)
        print(f"cfg I{inter} E{E} tok{tok} bm{tm}: std {r['a8w4_gemm2 us']:.1f} | fd1 "
              f"{r['a8w4_fd1 us']:.1f} | fd2 {r['a8w4_fd2 us']:.1f} us | err "
              f"{r['a8w4_fd1 err']},{r['a8w4_fd2 err']} cos {r['a8w4_fd2 cos']:.1e} vs std "
              f"cos {r['a8w4_gemm2 cos']:.1e} | port {r['port us']:.1f}", flush=True)

"""gemm1 fast decode: original vs fd1 / fd2 (production std layout) and the tile
layout, with the bit-exactness flags of bench_a8w4_gemm1.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/fast_decode/fd_gemm1_bench.py [reps]
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm1 as T  # noqa: E402

reps = int(sys.argv[1]) if len(sys.argv) > 1 else 2
for rep in range(reps):
    for E, tok, tn in ((256, 512, 128), (256, 512, 64), (304, 608, 128)):
        r = T.bench_a8w4_gemm1(tok, 4096, 512, E, 8, routing="uniform", tile_m=32,
                               tile_n=tn)
        print(f"cfg rep{rep} E{E} tok{tok} tn{tn}: std {r['a8w4_gemm1 us']:.1f} | tile "
              f"{r['a8w4_tile us']:.1f} | fd1 {r['a8w4_fd1 us']:.1f} | fd2 "
              f"{r['a8w4_fd2 us']:.1f} us ({r['a8w4_fd2 TB/s']:.2f} TB/s) | port "
              f"{r['port us']:.1f} | bitexact tile {r['tile bitexact']} fd1 "
              f"{r['fd bitexact']} fd2 {r['fd2 bitexact']}", flush=True)

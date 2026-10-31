"""gemm1 bandwidth vs number of WG "rounds": vary the expert count E with 16 routed
rows per expert on average (tokens = 2E, topk 8 -> one bm32 m-block per expert), so
every WG does the same work and only the grid size (4 WGs per expert) changes.
608 = 304 CUs x 2 resident WGs per CU (standalone kernel) = one round.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/gemm1_wave_rounds/rounds_sweep.py [reps]
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm1 as T  # noqa: E402

reps = int(sys.argv[1]) if len(sys.argv) > 1 else 1
for rep in range(reps):
    for E in (76, 152, 228, 256, 304, 380, 456, 532, 608):
        r = T.bench_a8w4_gemm1(E * 2, 4096, 512, E, 8, routing="uniform", tile_m=32,
                               tile_n=128)
        wg = r["m-blocks"] * 4
        print(f"E={E:4d} rep{rep} tokens={E * 2:5d} m-blocks={r['m-blocks']:4d} WGs={wg:5d} "
              f"rounds(608 slots)={wg / 608:4.2f} max tok/exp={r['max tok/expert']:3d} | "
              f"std {r['a8w4_gemm1 us']:7.1f} us {r['a8w4_gemm1 TB/s']:.2f} TB/s | "
              f"port {r['port us']:7.1f} us {r['port TB/s']:.2f} TB/s", flush=True)

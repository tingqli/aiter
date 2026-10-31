"""Standard vs tile-major W layout (``w_layout="tile"``, ``retile_w1``) for the
standalone gemm1: bit-exactness and time (512 tokens, 256 experts, inter 512).

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/gemm1_tile_layout/tile_layout_bench.py
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm1 as T  # noqa: E402

print("-- tile_n x b_cache_mod")
for tn, bcm in ((128, 2), (128, 1), (64, 2)):
    r = T.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=32,
                           tile_n=tn, b_cache_mod=bcm)
    print(f"cfg tn{tn} bcm{bcm}: std {r['a8w4_gemm1 us']:.1f} us | tile "
          f"{r['a8w4_tile us']:.1f} us {r['a8w4_tile TB/s']:.2f} TB/s err "
          f"{r['a8w4_tile err']} bitexact {r['tile bitexact']} | port {r['port us']:.1f}",
          flush=True)
print("-- repeats (b_cache_mod=2)")
for rep in range(2):
    for tn, tm, dyn in ((128, 32, False), (64, 32, False), (128, 64, True)):
        r = T.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=tm,
                               tile_n=tn, dyn_m=dyn)
        print(f"cfg rep{rep} bm{tm} tn{tn} dyn{int(dyn)}: std {r['a8w4_gemm1 us']:.1f} | "
              f"tile {r['a8w4_tile us']:.1f} us ({r['a8w4_tile TB/s']:.2f} TB/s) "
              f"bitexact {r['tile bitexact']}", flush=True)

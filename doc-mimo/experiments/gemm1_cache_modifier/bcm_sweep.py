"""W cache modifier (b_cache_mod 0 = default, 1 = sc0, 2 = nt) x tile_n for the
standalone gemm1 and the port (512 tokens, 256 experts, inter 512, bm32).

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/gemm1_cache_modifier/bcm_sweep.py
"""
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_a8w4_gemm1 as T  # noqa: E402

for tn, bcm in ((128, 1), (128, 0), (128, 2), (64, 1), (64, 2)):
    r = T.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=32,
                           tile_n=tn, b_cache_mod=bcm)
    print(f"cfg tn{tn} bcm{bcm}: standalone {r['a8w4_gemm1 us']:.1f} us "
          f"{r['a8w4_gemm1 TB/s']:.2f} TB/s err {r['a8w4_gemm1 err']} | "
          f"port {r['port us']:.1f} us {r['port TB/s']:.2f} TB/s", flush=True)

import sys; sys.path.insert(0, "doc-mimo/kernels")
import logging; logging.disable(logging.WARNING)
import test_a8w4_gemm2 as t
rows = []
for rep in range(2):
    for tok in (128, 512, 2048):
        for ag, wpe in ((0, None), (128, None)):
            r = t.bench_a8w4_gemm2(tok, 4096, 256, 256, 8, routing="uniform", tile_m=32, dyn_rows=True, a_group=ag, waves_per_eu=wpe)
            rows.append((rep, tok, ag, wpe, r["a8w4_gemm2 us"], r["a8w4_gemm2 err"], r["a8w4_gemm2 cos"]))
for r in rows: print("RES rep=%d tok=%d a_group=%d wpe=%s us=%.1f err=%.2g cos=%.2g" % r)

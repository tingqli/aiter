import sys, importlib.util, collections
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_gemm2.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cfgs = eval(sys.argv[1]); reps = int(sys.argv[2])
best = collections.defaultdict(lambda: [1e9, 1e9, 0])
for _ in range(reps):
    for c in cfgs:
        c = dict(c); tok = c.pop("token")
        r = t.bench_a8w4_gemm2(tok, 4096, 256, 256, 8, **c)
        assert r['a8w4_gemm2 err'] <= t.TOL_ERR_RATIO and r['a8w4_gemm2 cos'] < 1e-4, r
        k = (tok,) + tuple(sorted(c.items()))
        b = best[k]; b[0] = min(b[0], r['a8w4_gemm2 us']); b[1] = min(b[1], r['port us']); b[2] = r['a8w4_gemm2 TB/s']
for k, (n, p, bw) in best.items():
    print("BEST", k, f"new={n:.1f} port={p:.1f}", flush=True)

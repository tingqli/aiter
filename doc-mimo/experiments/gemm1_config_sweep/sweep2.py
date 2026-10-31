import sys, importlib.util, collections
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_gemm1.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cfgs = eval(sys.argv[1]); reps = int(sys.argv[2])
best = collections.defaultdict(lambda: [1e9, 1e9])
for _ in range(reps):
    for c in cfgs:
        c = dict(c); tok = c.pop("token")
        r = t.bench_a8w4_gemm1(tok, 4096, 256, 256, 8, **c)
        assert r['bitexact vs port'] and r['a8w4_gemm1 err'] == 0
        k = (tok, c.get("routing", "uniform"), c.get("tile_m"), c.get("dyn_m", False))
        best[k][0] = min(best[k][0], r['a8w4_gemm1 us']); best[k][1] = min(best[k][1], r['port us'])
for k, (n, p) in sorted(best.items()):
    print("BEST", k, f"new={n:.1f} port={p:.1f}", flush=True)

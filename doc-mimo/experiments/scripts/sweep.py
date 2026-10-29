import sys, importlib.util, itertools
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_gemm1.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cfgs = eval(sys.argv[1])
for c in cfgs:
    c = dict(c); tok = c.pop("token", 512); r = t.bench_a8w4_gemm1(tok, 4096, 256, 256, 8, **c); c["token"] = tok
    print("RESULT", c, f"new={r['a8w4_gemm1 us']:.1f} port={r['port us']:.1f} err={r['a8w4_gemm1 err']} exact={r['bitexact vs port']}", flush=True)

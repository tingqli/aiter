import importlib.util, torch, sys
sys.path.insert(0, "doc-mimo/kernels")
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
from aiter.test_common import run_perftest
from aiter import dtypes, QuantType
import aiter
tok, H, I, E, K = int(sys.argv[1]), 4096, 256, 256, 8
torch.manual_seed(0)
inp = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
w1 = torch.randn((E, 2*I, H), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, H, I), dtype=dtypes.bf16, device="cuda")
score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
tw, ti = t.fused_topk(inp, score, K, True)
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, s1 = tq(w1, quant_dtype=dtypes.fp4x2); w2q, s2 = tq(w2, quant_dtype=dtypes.fp4x2)
del w1, w2
w1q = w1q.view(E, 2*I, H//2); w2q = w2q.view(E, H, I//2)
W = t.a8w4_prepare_weights(t.shuffle_weight_a16w4(w1q,16,False), t.shuffle_weight_a16w4(w2q,16,False),
                           t.shuffle_scale_a16w4(s1,E,False), t.shuffle_scale_a16w4(s2,E,False))
cfgs = eval(sys.argv[2])
for c in cfgs:
    c = dict(c)
    skip = c.pop("skip", False)
    if skip:
        orig = t.compile_a8w4_fmoe
        fn = lambda: t.a8w4_fmoe(inp, W, tw, ti, **c)
        # route compile through the skip flag
        t.compile_a8w4_fmoe = lambda **kw: orig(_skip_gemm2=True, **kw)
        fn(); torch.cuda.synchronize(); _, us = run_perftest(fn)
        t.compile_a8w4_fmoe = orig
    else:
        fn = lambda: t.a8w4_fmoe(inp, W, tw, ti, **c)
        fn(); torch.cuda.synchronize(); _, us = run_perftest(fn)
    print("RES", c, "skip_gemm2" if skip else "", f"{us:.1f}", flush=True)

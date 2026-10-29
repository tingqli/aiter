import importlib.util, torch, sys
sys.path.insert(0, "doc-mimo/kernels")
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
from aiter.test_common import run_perftest
from aiter import dtypes, QuantType
import aiter
H, I, E, K = 4096, 256, 256, 8
torch.manual_seed(0)
w1 = torch.randn((E, 2*I, H), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, H, I), dtype=dtypes.bf16, device="cuda")
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, s1 = tq(w1, quant_dtype=dtypes.fp4x2); w2q, s2 = tq(w2, quant_dtype=dtypes.fp4x2)
del w1, w2
w1q = w1q.view(E, 2*I, H//2); w2q = w2q.view(E, H, I//2)
W = t.a8w4_prepare_weights(t.shuffle_weight_a16w4(w1q,16,False), t.shuffle_weight_a16w4(w2q,16,False),
                           t.shuffle_scale_a16w4(s1,E,False), t.shuffle_scale_a16w4(s2,E,False))
two = t._two_kernel_moe()
W2k = {k: W[k] for k in ("w1","w2","w1_scale","w2_scale","w1_exp")}
for tok, routing in eval(sys.argv[1]):
    inp = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
    score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
    if routing == "hot":
        score[:, torch.randperm(E, device="cuda")[:E//32]] += 2.0
    tw, ti = t.fused_topk(inp, score, K, True)
    fn = lambda: two(inp, W2k, tw, ti, block_m=32); fn(); torch.cuda.synchronize()
    _, us2 = run_perftest(fn)
    for c in eval(sys.argv[2]):
        fn = lambda: t.a8w4_fmoe(inp, W, tw, ti, **c); fn(); torch.cuda.synchronize()
        _, us = run_perftest(fn)
        o1, o2 = fn().float(), two(inp, W2k, tw, ti, block_m=32).float()
        err = ((o1 - o2).abs().max() / o2.abs().mean()).item()
        print("RES", tok, routing, c, f"fused={us:.1f} 2kernel={us2:.1f} err={err:.3g}", flush=True)

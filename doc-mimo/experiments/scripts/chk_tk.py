import importlib.util, torch, sys
sys.path.insert(0, "doc-mimo/kernels")
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
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
tok = 2048
inp = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
tw, ti = t.fused_topk(inp, score, K, True)
ref = t.a8w4_fmoe(inp, W, tw, ti).float()
m = ref.abs().mean()
for c in [dict(), dict(num_waves=4,n2_per_wave=64,tile_k1=128), dict(num_waves=8,n2_per_wave=32,tile_k1=128)]:
    errs = []
    for _ in range(4):
        o = t.a8w4_fmoe(inp, W, tw, ti, **c).float()
        d = (o - ref).abs()
        errs.append(f"{(d.max()/m).item():.3g}/{(d.mean()/m).item():.2e}/{(d > 0.05*m).sum().item()}")
    print(c, errs)

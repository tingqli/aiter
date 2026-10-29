import importlib.util, torch, sys
sys.path.insert(0, "doc-mimo/kernels")
spec = importlib.util.spec_from_file_location("t", "doc-mimo/kernels/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cap = {}
orig = t.checkAllclose
def cc(a, b, **kw):
    cap['a'], cap['b'] = a, b
    return orig(a, b, printLog=False, **kw)
t.checkAllclose = cc
r = t.bench_a8w4_fmoe(512, 4096, 256, 256, 8)
a, b = cap['a'], cap['b']   # 2kernel, fused
d = (a - b).abs()
print("ref absmean", a.abs().mean().item(), "absmax", a.abs().max().item())
print("delta mean", d.mean().item(), "max", d.max().item())
bad = ~torch.isclose(a, b, rtol=2e-2, atol=1e-1)
rows = bad.any(1).nonzero().squeeze(1)
cols = bad.any(0).nonzero().squeeze(1)
print("bad rows", rows.numel(), rows[:20].tolist())
print("bad cols", cols.numel(), cols[:40].tolist())
rel = d / a.abs().clamp_min(1e-3)
print("median rel", rel.median().item())
r0 = rows[0].item()
print("row", r0, "a", a[r0, :8].tolist(), "b", b[r0, :8].tolist())

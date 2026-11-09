"""HBM read / write / copy bandwidth on this GPU (torch kernels, CUDA events)."""
import torch

dev = "cuda"


def bench(fn, warm=30, iters=50):
    for _ in range(warm):
        fn()
    torch.cuda.synchronize()
    st = torch.cuda.Event(enable_timing=True)
    en = torch.cuda.Event(enable_timing=True)
    st.record()
    for _ in range(iters):
        fn()
    en.record()
    torch.cuda.synchronize()
    return st.elapsed_time(en) * 1000 / iters


for mb in (64, 256, 1024, 2048):
    n = mb * 1024 * 1024 // 2
    a = torch.randn(n, device=dev, dtype=torch.bfloat16)
    b = torch.empty_like(a)
    out = torch.empty(1, device=dev, dtype=torch.float32)
    us_w = bench(lambda: b.fill_(1.0))
    us_c = bench(lambda: b.copy_(a))
    us_r = bench(lambda: torch.sum(a.view(-1, 4096), dim=1))
    nbytes = n * 2
    print(f"{mb:5d} MB  write {nbytes/us_w/1e6:6.2f} TB/s  copy(R+W) {2*nbytes/us_c/1e6:6.2f} TB/s  "
          f"read(sum rows) {nbytes/us_r/1e6:6.2f} TB/s", flush=True)

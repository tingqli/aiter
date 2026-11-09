"""FP8 dense GEMM ceiling on this GPU (hipBLASLt via torch._scaled_mm)."""
import torch

torch.manual_seed(0)
dev = "cuda"
f8 = torch.float8_e4m3fn


def bench(fn, warm=60, iters=60):
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


def gemm(M, N, K, rowwise=False):
    a = (torch.randn(M, K, device=dev) / 4).to(f8)
    b = (torch.randn(N, K, device=dev) / 4).to(f8)
    if rowwise:
        sa = torch.ones(M, 1, device=dev)
        sb = torch.ones(1, N, device=dev)
    else:
        sa = torch.ones((), device=dev)
        sb = torch.ones((), device=dev)
    fn = lambda: torch._scaled_mm(a, b.t(), scale_a=sa, scale_b=sb, out_dtype=torch.bfloat16)
    us = bench(fn)
    tf = 2 * M * N * K / us / 1e6
    print(f"M={M:7d} N={N:5d} K={K:5d} rowwise={int(rowwise)}  {us:9.1f} us  {tf:7.1f} TFLOPS", flush=True)
    return us


shapes = [(8192, 8192, 8192), (16384, 8192, 8192)]
for T, H in ((8192, 4096), (16384, 4096), (32768, 4096), (8192, 6144), (16384, 6144), (32768, 6144)):
    rows = T * 8  # topk 8
    shapes += [(rows, 512, H), (rows, H, 256)]
for M, N, K in shapes:
    gemm(M, N, K)
for M, N, K in shapes[:2]:
    gemm(M, N, K, rowwise=True)

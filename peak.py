import torch
from aiter.jit.utils.chip_info import get_gfx

def peak_tflops():
    device = "cuda"
    M = 8192
    K = 8192*2
    N = 8192
    a0 = torch.randn(M, K, device=device, dtype=torch.bfloat16)
    b0 = torch.randn(K, N, device=device, dtype=torch.bfloat16)
    
    # gfx942 只支持 FNUZ 格式的 fp8（torch.float8_e4m3fnuz）
    # torch.float8_e4m3fn 是 OCP 格式，要 gfx950 才支持，
    dtype_fp8 = torch.float8_e4m3fnuz if get_gfx() == "gfx942" else torch.float8_e4m3fn
    tflops = {}
    for dtype in [torch.bfloat16, dtype_fp8]:
        if dtype is not torch.bfloat16:
            a = a0.to(dtype) # row-major A matrix
            b = b0.to(dtype).t().contiguous().t() # column-major B.
        else:
            a = a0
            b = b0
        scale_a = torch.tensor(1.0, device=device, dtype=torch.float32)
        scale_b = torch.tensor(1.0, device=device, dtype=torch.float32)

        from aiter.test_common import run_perftest
        def gemm(a, b):
            if dtype is torch.bfloat16:
                return torch.matmul(a, b)
            else:
                return torch._scaled_mm(
                    a, b,
                    scale_a=scale_a, scale_b=scale_b,
                    out_dtype=torch.bfloat16
                )
        c, avg_us = run_perftest(gemm, a, b, use_cuda_event=True)

        tflops[dtype] = (2 * M * K * N) / (avg_us * 1e-6) / 1e12
    for dtype in tflops:
        print(f"#  GEMM({str(dtype):>30}) peak tflops: {tflops[dtype]:.2f}")

"""
MI300X
#  GEMM(                torch.bfloat16) peak tflops: 676.01
#  GEMM(         torch.float8_e4m3fnuz) peak tflops: 1146.35

MI308X
#  GEMM(                torch.bfloat16) peak tflops: 228.87
#  GEMM(         torch.float8_e4m3fnuz) peak tflops: 193.62

model_dim=6144, inter_dim=256, num_expert=384, num_tokens_per_expert=128 ntokens=6144
   Average execution time gemm1: 1642.53 us, tflops: 188.27
   Average execution time gemm2: 1256.10 us, tflops: 123.09
[aiter] avg: 2793.1171903515806 us/iter from cuda.Event
[aiter] avg: 2428.0980530351694 us/iter from cuda.Event
model_dim=6144, inter_dim=256, num_expert=384, num_tokens_per_expert=256 ntokens=12288
   Average execution time gemm1: 2793.12 us, tflops: 221.43
   Average execution time gemm2: 2428.10 us, tflops: 127.36
root@hjbog-srdc-52:~/tingqli/aiter# rocm-smi
"""
peak_tflops()

def gemm_tflops(model_dim, inter_dim, num_expert, num_tokens, topk=8):
    device = "cuda"
    num_tokens_per_expert = (num_tokens * topk + num_expert - 1) // num_expert
    M = num_tokens_per_expert
    K = model_dim
    N = inter_dim

    # batched gemm 1
    a1 = torch.randn(num_expert, num_tokens_per_expert, model_dim, device=device, dtype=torch.bfloat16)
    w1 = torch.randn(num_expert, model_dim, inter_dim*2, device=device, dtype=torch.bfloat16)
    tflops1 = 2 * num_expert * num_tokens_per_expert * model_dim * inter_dim*2
    def gemm1(a1, w1):
        return torch.matmul(a1, w1)

    a2 = torch.randn(num_expert, num_tokens_per_expert, inter_dim, device=device, dtype=torch.bfloat16)
    w2 = torch.randn(num_expert, inter_dim, model_dim, device=device, dtype=torch.bfloat16)
    tflops2 = 2 * num_expert * num_tokens_per_expert * model_dim * inter_dim
    def gemm2(a2, w2):
        return torch.matmul(a2, w2)

    from aiter.test_common import run_perftest

    c, avg_us1 = run_perftest(gemm1, a1, w1, use_cuda_event=True)
    c, avg_us2 = run_perftest(gemm2, a2, w2, use_cuda_event=True)

    TFLOPS1 = tflops1 / (avg_us1 * 1e-6) / 1e12
    TFLOPS2 = tflops2 / (avg_us2 * 1e-6) / 1e12
    print(f"{model_dim=}, {inter_dim=}, {num_expert=}, {num_tokens_per_expert=} ntokens={num_tokens_per_expert * num_expert//topk}")
    print(f"   Average execution time gemm1: {avg_us1:.2f} us, tflops: {TFLOPS1:.2f}")
    print(f"   Average execution time gemm2: {avg_us2:.2f} us, tflops: {TFLOPS2:.2f}")
    print(f"           Total execution time: {avg_us1 + avg_us2:.2f} us, tflops: {(tflops1 + tflops2) / ((avg_us1 + avg_us2) * 1e-6) / 1e12:.2f}")

gemm_tflops(6144, 256, 384, 16384)

"""Read-pattern microbenchmark for the a8w4 gemm1 weight stream (no compute).

1024 programs x 4 waves (= gemm1 grid at 512 tokens, 256 experts, inter 512, tn128),
each reads 16 K-tiles x 32 KB = 512 KB of the 537 MB preshuffled W1:
  gemm1  : the gemm1 layout -- per K-tile 16 segments of 2 KB, segment stride 32 KB
           (gate n16-blocks, then up n16-blocks 1 MB away), like the real kernel
  contig : per K-tile one contiguous 32 KB block (WG owns 512 KB contiguous)

    python doc-mimo/experiments/gemm1_read_pattern/gemm1_read_pattern.py
"""
import torch
import triton
import triton.language as tl

E, NB, KT = 256, 4, 16
W_BYTES = E * 1024 * 4096 // 2  # 512 MiB


@triton.jit
def _read(w_ptr, out_ptr, MODE: tl.constexpr, KT: tl.constexpr):
    pid = tl.program_id(0)
    e = pid // 4
    nb = pid % 4
    seg = tl.arange(0, 16)[:, None]  # 16 n16-blocks
    within = tl.arange(0, 512)[None, :]  # 2 KB = 512 int32
    acc = tl.zeros([16, 512], dtype=tl.int32)
    for kt in range(KT):
        if MODE == 0:
            n16 = e * 64 + (seg // 8) * 32 + nb * 8 + seg % 8
            offs = n16.to(tl.int64) * 8192 + kt * 512 + within
        else:
            offs = pid.to(tl.int64) * 131072 + kt * 8192 + seg * 512 + within
        acc += tl.load(w_ptr + offs)
    tl.store(out_ptr + pid, tl.sum(acc))


w = torch.randint(0, 1 << 30, (W_BYTES // 4,), dtype=torch.int32, device="cuda")
out = torch.empty(E * NB, dtype=torch.int32, device="cuda")


def run(mode, nw):
    _read[(E * NB,)](w, out, MODE=mode, KT=KT, num_warps=nw)


for nw in (4, 8):
    for mode, name in ((0, "gemm1 "), (1, "contig")):
        run(mode, nw)
        torch.cuda.synchronize()
        e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
        ts = []
        for _ in range(5):
            e0.record()
            for _ in range(50):
                run(mode, nw)
            e1.record()
            torch.cuda.synchronize()
            ts.append(e0.elapsed_time(e1) * 1e3 / 50)
        us = min(ts)
        print(f"{name} num_warps={nw}: {us:7.1f} us  {W_BYTES / us / 1e6:5.2f} TB/s")

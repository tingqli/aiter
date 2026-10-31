"""Read-pattern microbenchmark for the a8w4 gemm1 weight stream (no compute).

1024 programs (= gemm1 grid at 512 tokens, 256 experts, inter 512, tn128), each reads
16 K-tiles x 32 KB = 512 KB of a 512 MiB weight buffer. Per K-tile a program reads
16 rows of 2 KB, grouped into runs of RL consecutive rows (= one contiguous run of
RL*2 KB). Each run lives in its own "region" holding that run's data for all 16
K-tiles, and regions of one expert are interleaved like the gemm1 preshuffle:

  RL=1  : exactly the current gemm1 layout -- region = one n16 block (16 cols x all K
          = 32 KB), per K-tile 16 x 2 KB segments, segment stride 32 KB, gate/up 1 MB apart
  RL=2/4/8 : coarser runs (4 / 8 / 16 KB per K-tile)
  contig: the program's 512 KB is one region, per K-tile one 32 KB block
  rot   : same addresses, but program p walks its K-tiles starting at (p % 16), so
          concurrent programs do not touch the same K offset at the same time

    python doc-mimo/experiments/gemm1_read_pattern/gemm1_read_pattern_v2.py
"""
import torch
import triton
import triton.language as tl

E, NB, KT = 256, 4, 16
W_BYTES = E * 1024 * 4096 // 2  # 512 MiB


@triton.jit
def _read(w_ptr, out_ptr, RL: tl.constexpr, CONTIG: tl.constexpr, ROT: tl.constexpr,
          KT: tl.constexpr):
    pid = tl.program_id(0)
    e = pid // 4
    nb = pid % 4
    r = tl.arange(0, 16)[:, None]  # 16 rows of 2 KB per K-tile
    within = tl.arange(0, 512)[None, :]  # 2 KB = 512 int32
    acc = tl.zeros([16, 512], dtype=tl.int32)
    for k in range(KT):
        kt = (k + pid) % KT if ROT else k
        if CONTIG:
            offs = pid.to(tl.int64) * 131072 + kt * 8192 + r * 512 + within
        else:
            RPH: tl.constexpr = 8 // RL  # runs per gate (or up) half
            run = r // RL
            pos = r % RL
            half = run // RPH
            j = run % RPH
            region = e * (64 // RL) + half * (32 // RL) + nb * RPH + j
            offs = region.to(tl.int64) * (RL * 8192) + kt * (RL * 512) + pos * 512 + within
        acc += tl.load(w_ptr + offs)
    tl.store(out_ptr + pid, tl.sum(acc))


w = torch.randint(0, 1 << 30, (W_BYTES // 4,), dtype=torch.int32, device="cuda")
out = torch.empty(E * NB, dtype=torch.int32, device="cuda")


def bench(nw, **kw):
    def run():
        _read[(E * NB,)](w, out, KT=KT, num_warps=nw, **kw)

    run()
    torch.cuda.synchronize()
    e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    ts = []
    for _ in range(5):
        e0.record()
        for _ in range(50):
            run()
        e1.record()
        torch.cuda.synchronize()
        ts.append(e0.elapsed_time(e1) * 1e3 / 50)
    return min(ts)


CASES = [
    ("RL=1  2 KB runs (gemm1 now)", dict(RL=1, CONTIG=False, ROT=False)),
    ("RL=1  + rot", dict(RL=1, CONTIG=False, ROT=True)),
    ("RL=2  4 KB runs", dict(RL=2, CONTIG=False, ROT=False)),
    ("RL=4  8 KB runs", dict(RL=4, CONTIG=False, ROT=False)),
    ("RL=8  16 KB runs (gate | up)", dict(RL=8, CONTIG=False, ROT=False)),
    ("contig 32 KB / K-tile", dict(RL=1, CONTIG=True, ROT=False)),
    ("contig + rot", dict(RL=1, CONTIG=True, ROT=True)),
]
for nw in (4, 8):
    for name, kw in CASES:
        us = bench(nw, **kw)
        print(f"nw={nw}  {name:<30} {us:7.1f} us  {W_BYTES / us / 1e6:5.2f} TB/s")

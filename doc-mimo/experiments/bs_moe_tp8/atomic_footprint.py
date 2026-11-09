"""bf16x2 atomic throughput vs footprint on MI350X: does L2 residency help?

Each lane issues R global_atomic_pk_add_bf16 (4 B) to addresses that cycle
through a footprint of F bytes (contiguous 4 B per lane, 256 B per wave).
Small F stays in L2 (4 MB per XCD); large F misses every time.
"""
import sys

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl._mlir.dialects import llvm
from flydsl.expr import range_constexpr
from flydsl.expr.typing import Vector as Vec

R = 16


def build(scope):
    @flyc.kernel(name=f"atomic_fp_{scope}", known_block_size=[256, 1, 1])
    def k(out: fx.Pointer, words: fx.Int32):
        gid = fx.Int32(fx.block_idx.x) * 256 + fx.Int32(fx.thread_idx.x)
        nthreads = fx.Int32(fx.grid_dim.x) * 256
        one = Vec.from_elements([fx.Float32(1.0), fx.Float32(1.0)], fx.Float32).to(fx.BFloat16)
        for r in range_constexpr(R):
            w = (gid + nthreads * r) % words
            p = llvm.inttoptr(ir.Type.parse("!llvm.ptr<1>"), fx.ptrtoint(out + w).ir_value())
            llvm.AtomicRMWOp(
                llvm.AtomicBinOp.fadd, p, one.ir_value(), llvm.AtomicOrdering.monotonic,
                syncscope=scope, alignment=4,
            )

    @flyc.jit
    def launch(out: fx.Pointer, words: fx.Int32, grid: fx.Constexpr[int], stream: fx.Stream):
        k(out, words).launch(grid=(grid, 1, 1), block=(256, 1, 1), stream=stream)

    return launch


def main():
    grid = 256 * 64
    lanes = grid * 256
    for scope in ("agent", "workgroup"):
        launch = build(scope)
        for mb in (1, 4, 16, 64, 256, 1024):
            words = mb * (1 << 20) // 4
            out = torch.zeros(words * 2, dtype=torch.bfloat16, device="cuda")
            ptr = flyc.from_c_void_p(fx.Int32, out.data_ptr())
            stream = fx.Stream(torch.cuda.current_stream().cuda_stream)
            f = lambda: launch(ptr, fx.Int32(words), grid, stream)  # noqa: E731
            for _ in range(20):
                f()
            torch.cuda.synchronize()
            st, en = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            st.record()
            for _ in range(20):
                f()
            en.record()
            torch.cuda.synchronize()
            us = st.elapsed_time(en) * 1000 / 20
            ops = lanes * R
            print(f"{scope:9s} footprint {mb:5d} MB: {us:8.1f} us  {ops / us / 1e3:7.1f} G atomics/s"
                  f"  {ops * 4 / us / 1e6:6.2f} TB/s payload", flush=True)


if __name__ == "__main__":
    sys.exit(main())

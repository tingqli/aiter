"""bf16x2 atomic cost per lane vs per request on MI350X.

A wave covers 8 x 128 B lines with four packed-bf16 atomic instructions:
  coalesced: instruction i -> lines 2i, 2i+1, 32 lanes x 4 B each (2 requests)
  strided:   instruction i -> word i of each lane's 16 B chunk, 8 lanes per line
             (8 requests of 8 lanes each) -- the Down epilogue's natural layout.
Same bytes, same atomic count.
"""
import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl._mlir.dialects import llvm
from flydsl.expr import const_expr, range_constexpr
from flydsl.expr.typing import Vector as Vec


def build(strided):
    @flyc.kernel(name=f"atomic_req_{int(strided)}", known_block_size=[256, 1, 1])
    def k(out: fx.Pointer, waves_total: fx.Int32):
        lane = fx.Int32(fx.thread_idx.x) % 64
        wave = fx.Int32(fx.block_idx.x) * 4 + fx.Int32(fx.thread_idx.x) // 64
        one = Vec.from_elements([fx.Float32(1.0), fx.Float32(1.0)], fx.Float32).to(fx.BFloat16)
        for rep in range_constexpr(4):
            base = ((wave + waves_total * rep) * 8) * 32  # 8 lines of 32 words
            for i in range_constexpr(4):
                if const_expr(strided):
                    w = base + (lane // 8) * 32 + (lane % 8) * 4 + i
                else:
                    w = base + (2 * i + lane // 32) * 32 + lane % 32
                p = llvm.inttoptr(ir.Type.parse("!llvm.ptr<1>"), fx.ptrtoint(out + w).ir_value())
                llvm.AtomicRMWOp(
                    llvm.AtomicBinOp.fadd, p, one.ir_value(), llvm.AtomicOrdering.monotonic,
                    syncscope="agent", alignment=4,
                )

    @flyc.jit
    def launch(out: fx.Pointer, waves_total: fx.Int32, grid: fx.Constexpr[int], stream: fx.Stream):
        k(out, waves_total).launch(grid=(grid, 1, 1), block=(256, 1, 1), stream=stream)

    return launch


def main():
    grid = 256 * 32
    waves = grid * 4
    nbytes = waves * 4 * 8 * 128  # 4 reps x 8 lines x 128 B per wave
    out = torch.zeros(nbytes // 2, dtype=torch.bfloat16, device="cuda")
    ptr = flyc.from_c_void_p(fx.Int32, out.data_ptr())
    stream = fx.Stream(torch.cuda.current_stream().cuda_stream)
    for rnd in range(2):
        for strided in (False, True):
            launch = build(strided)
            f = lambda: launch(ptr, fx.Int32(waves), grid, stream)  # noqa: E731
            for _ in range(40):
                f()
            torch.cuda.synchronize()
            st, en = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            st.record()
            for _ in range(20):
                f()
            en.record()
            torch.cuda.synchronize()
            us = st.elapsed_time(en) * 1000 / 20
            name = "strided (8 lanes/line)" if strided else "coalesced (32 lanes/line)"
            print(f"r{rnd} {name:26s}: {nbytes / 2**20:6.0f} MB in {us:7.1f} us = {nbytes / us / 1e6:5.2f} TB/s",
                  flush=True)


if __name__ == "__main__":
    main()

"""Per-CU streaming read bandwidth: how many CUs does it take to saturate HBM?

One WG per CU (LDS padding), each streams its own contiguous region with
dwordx4 buffer loads, U loads per thread in flight (software pipelined).
Only `active` WGs read; the rest exit at once.

    python doc-mimo/experiments/bs_moe_tp8/cu_bw.py
"""

import functools
import os
import sys

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl.expr import range_constexpr, rocdl

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled  # noqa: E402
from bs_common import _ptr, rocdl_aux  # noqa: E402

NT = 512


@functools.cache
def build(U, lds_kb):
    @fx.struct
    class Storage:
        arena: fx.Array[fx.Int32, lds_kb * 256, 16]

    @flyc.kernel(known_block_size=[NT, 1, 1])
    def k(src: fx.Pointer, out: fx.Pointer, iters: fx.Int32, active: fx.Int32):
        tid = fx.Int32(fx.thread_idx.x)
        bx = fx.Int32(fx.block_idx.x)
        base = fx.SharedAllocator().allocate(Storage).peek().arena.ptr
        del base
        if bx < active:
            chunk = NT * 16 * U
            wg_bytes = iters * chunk
            view = fx.make_view(src + fx.Int64(bx) * fx.Int64(wg_bytes), fx.make_layout(wg_bytes, 1))
            rsrc = fx.rocdl.get_buffer_rsrc(fx.get_iter(fx.rocdl.make_buffer_tensor(view, False)))
            vt = ir.VectorType.get([4], fx.Int32.ir_type)
            zero = fx.Int32(0).ir_value()

            def load(i):
                return [
                    fx.Vector(rocdl.raw_ptr_buffer_load(
                        vt, rsrc, ((i * U + u) * (NT * 16) + tid * 16).ir_value(), zero,
                        aux=rocdl_aux(0)))
                    for u in range_constexpr(U)
                ]

            acc = fx.Vector.filled(4, 0, fx.Int32)
            first = load(fx.Int32(0))
            init = [acc] + first
            for i, state in range(1, iters, init=init):
                nxt = load(fx.Int32(i))
                a = fx.Vector(state[0])
                for u in range_constexpr(U):
                    a = a ^ fx.Vector(state[1 + u])
                results = yield [a] + nxt
            a = fx.Vector(results[0])
            for u in range_constexpr(U):
                a = a ^ fx.Vector(results[1 + u])
            s = a[0] ^ a[1] ^ a[2] ^ a[3]
            out[bx * NT + tid] = s

    @flyc.jit
    def launch(src: fx.Pointer, out: fx.Pointer, iters: fx.Int32, active: fx.Int32, grid: fx.Int32, stream):
        k(src, out, iters, active).launch(grid=(grid, 1, 1), block=(NT, 1, 1), stream=stream)

    return launch


def run(U, active, mb_per_wg=8, lds_kb=96, reps=20):
    grid = 256
    chunk = NT * 16 * U
    iters = mb_per_wg * (1 << 20) // chunk
    src = torch.empty(grid * iters * chunk, dtype=torch.uint8, device="cuda").random_(0, 255)
    out = torch.zeros(grid * NT, dtype=torch.int32, device="cuda")
    f = build(U, lds_kb)
    args = (_ptr(src), _ptr(out), fx.Int32(iters), fx.Int32(active), fx.Int32(grid))

    def go():
        _run_compiled(f, *args, torch.cuda.current_stream())

    for _ in range(10):
        go()
    torch.cuda.synchronize()
    e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    e0.record()
    for _ in range(reps):
        go()
    e1.record()
    torch.cuda.synchronize()
    us = e0.elapsed_time(e1) * 1000 / reps
    total = active * iters * chunk
    return us, total / us / 1e6  # TB/s


if __name__ == "__main__":
    for U in (4, 8, 16):
        for active in (256, 192, 128, 64):
            us, tbs = run(U, active)
            print(f"U={U:2d} ({U * 8:3d} KB/CU in flight) active={active:3d}: {us:7.1f} us "
                  f"{tbs:5.2f} TB/s  {tbs * 1e3 / active:5.1f} GB/s/CU", flush=True)

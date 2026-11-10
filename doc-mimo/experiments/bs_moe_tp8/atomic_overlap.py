"""Do packed-BF16 atomics overlap with an HBM read stream?

One WG per CU streams its own region (dwordx4, software pipelined, like cu_bw.py)
and, per 64 KB read, issues `A` wave-wide buffer_atomic_pk_add_bf16 (64 lanes x
4 B = 256 B contiguous, i.e. 2 full lines) into an output buffer of `out_mb` MB at
pseudo-random 256 B-aligned rows. Compare: reads only, atomics only, both.

    python doc-mimo/experiments/bs_moe_tp8/atomic_overlap.py
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
from bs_common import _ptr, ptr_rsrc, rocdl_aux  # noqa: E402

NT = 512
U = 8  # 8 x 8 KB = 64 KB read per iteration per WG


@functools.cache
def build(A, do_read):
    @fx.struct
    class Storage:
        arena: fx.Array[fx.Int32, 96 * 256, 16]

    @flyc.kernel(known_block_size=[NT, 1, 1])
    def k(src: fx.Pointer, out: fx.Pointer, sink: fx.Pointer, iters: fx.Int32, out_lines: fx.Int32):
        tid = fx.Int32(fx.thread_idx.x)
        bx = fx.Int32(fx.block_idx.x)
        base = fx.SharedAllocator().allocate(Storage).peek().arena.ptr
        del base
        chunk = NT * 16 * U
        wg_bytes = iters * chunk
        view = fx.make_view(src + fx.Int64(bx) * fx.Int64(wg_bytes), fx.make_layout(wg_bytes, 1))
        rsrc = fx.rocdl.get_buffer_rsrc(fx.get_iter(fx.rocdl.make_buffer_tensor(view, False)))
        orsrc = ptr_rsrc(out, out_lines * 256)
        vt = ir.VectorType.get([4], fx.Int32.ir_type)
        zero = fx.Int32(0).ir_value()
        lane = tid % 64
        wave = tid // 64

        def load(i):
            return [
                fx.Vector(rocdl.raw_ptr_buffer_load(
                    vt, rsrc, ((i * U + u) * (NT * 16) + tid * 16).ir_value(), zero,
                    aux=rocdl_aux(0)))
                for u in range_constexpr(U if do_read else 0)
            ]

        def atomics(i):
            for a in range_constexpr(A):
                # hash -> a 256 B line pair of out
                h = (bx * 7919 + i * 104729 + wave * 31337 + a * 2654435) & 0x7FFFFFFF
                row = h % out_lines
                rocdl.raw_ptr_buffer_atomic_fadd(
                    fx.Vector.from_elements([fx.Int32(0x3C003C00)], fx.Int32).bitcast(fx.BFloat16),
                    orsrc, row * 256 + lane * 4, fx.Int32(0), aux=0)

        acc = fx.Vector.filled(4, 0, fx.Int32)
        init = [acc, acc] + load(fx.Int32(0))  # two carried values: no singleton unwrap
        for i, state in range(1, iters, init=init):
            nxt = load(fx.Int32(i))
            atomics(fx.Int32(i))
            a = fx.Vector(state[0])
            for u in range_constexpr(len(nxt)):
                a = a ^ fx.Vector(state[2 + u])
            results = yield [a, fx.Vector(state[1])] + nxt
        a = fx.Vector(results[0])
        for u in range_constexpr(U if do_read else 0):
            a = a ^ fx.Vector(results[2 + u])
        sink[bx * NT + tid] = a[0] ^ a[1] ^ a[2] ^ a[3]

    @flyc.jit
    def launch(src: fx.Pointer, out: fx.Pointer, sink: fx.Pointer, iters: fx.Int32,
               out_lines: fx.Int32, stream):
        k(src, out, sink, iters, out_lines).launch(grid=(256, 1, 1), block=(NT, 1, 1), stream=stream)

    return launch


def run(A, do_read, out_mb, mb_per_wg=3, reps=10):
    chunk = NT * 16 * U
    iters = mb_per_wg * (1 << 20) // chunk
    src = torch.empty(256 * iters * chunk, dtype=torch.uint8, device="cuda").random_(0, 255)
    out_lines = out_mb * (1 << 20) // 256
    out = torch.zeros(out_lines * 128, dtype=torch.bfloat16, device="cuda")
    sink = torch.zeros(256 * NT, dtype=torch.int32, device="cuda")
    f = build(A, do_read)
    args = (_ptr(src), _ptr(out), _ptr(sink), fx.Int32(iters), fx.Int32(out_lines))

    def go():
        _run_compiled(f, *args, torch.cuda.current_stream())

    for _ in range(5):
        go()
    torch.cuda.synchronize()
    e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    e0.record()
    for _ in range(reps):
        go()
    e1.record()
    torch.cuda.synchronize()
    us = e0.elapsed_time(e1) * 1000 / reps
    rd = 256 * iters * chunk if do_read else 0
    at = 256 * (iters - 1) * A * 8 * 256  # 8 waves x 256 B per atomic instruction
    return us, rd / us / 1e6, at / us / 1e6


if __name__ == "__main__":
    print("A = atomic instructions per wave per 64 KB of WG reads (each 256 B)")
    for out_mb in (4, 32):
        for A in (1, 2, 4, 8):
            ra = run(A, True, out_mb)
            a_only = run(A, False, out_mb)
            r_only = run(0, True, out_mb)
            print(f"out {out_mb:2d} MB A={A}: read+atomic {ra[0]:7.1f} us ({ra[1]:.2f} TB/s rd, "
                  f"{ra[2]:.2f} TB/s atomic) | atomic only {a_only[0]:7.1f} us ({a_only[2]:.2f} TB/s) "
                  f"| read only {r_only[0]:7.1f} us", flush=True)

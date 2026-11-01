"""gfx942 write-path microbenchmarks for gemm2's output: bf16x2 global atomics vs
plain stores (+ a separate topk reduce).

Part 1 (ceilings, linear addresses, every 4 B / 16 B touched once):
  atomic  global_atomic_pk_add_bf16 (4 B / lane)  into a zeroed buffer
  store4  buffer_store_dword        (4 B / lane)
  store16 buffer_store_dwordx4      (16 B / lane)
  load16  buffer_load_dwordx4       (16 B / lane, result kept alive)
for buffer sizes that fit L2 (4 MB) / MALL (64 MB) / neither (512 MB).

Part 2 (gemm2's exact scatter traffic, real moe_sorting with block_m 64, tile
64 x 128, grid = m_blocks x 32, constant 1.0 values, no GEMM):
  g2_atomic   what gemm2 does now: 8 rows x 32 lanes x bf16x2 per pass, atomic
              into out[token, n] (needs a zeroed out: + memset)
  g2_store16  same tile, dwordx4 stores into route[token * topk + slot, n]
              (8 lanes x 16 B = 256 B per row segment), no atomics, no memset
  reduce      route [T, topk, H] -> out [T, H]: 16 B / lane, topk loads, f32 sum
Checks: out == topk (atomic) and reduce(route) == topk.

    PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
      python doc-mimo/experiments/atomic_bw/bench_atomic_bw.py
"""
import argparse
import os
import sys

import torch

import flydsl.compiler as flyc
import flydsl.expr as fx
from flydsl._mlir.dialects import llvm
from flydsl.expr import const_expr, gpu, range_constexpr
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

from aiter import dtypes
from aiter.fused_moe import fused_topk, moe_sorting
from aiter.ops.flydsl.kernels import buffer_ops as bo
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.utils import _global_i32_at
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import _gep1, _global_base_ptr1
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw
from aiter.test_common import run_perftest

H, TOPK, E, BM, TN = 4096, 8, 256, 64, 128
NB = H // TN
U = 4  # items per lane in the linear kernels


def _one_pk():
    one = fx.Float32(1.0)
    return Vec.from_elements([one, one], fx.Float32).to(fx.BFloat16)


def _atomic_pk(base, byte_off, scope="agent"):
    llvm.AtomicRMWOp(
        llvm.AtomicBinOp.fadd,
        _gep1(base, byte_off),
        _raw(_one_pk()),
        llvm.AtomicOrdering.monotonic,
        syncscope=scope,
        alignment=4,
    )


def _ones_i32x4():
    one = fx.Float32(1.0)
    v = Vec.from_elements([one] * 8, fx.Float32).to(fx.BFloat16)
    return _raw(Vec(v).bitcast(fx.Int32))


# ---- part 1: linear -----------------------------------------------------------
def build_linear(mode):
    lane_bytes = 16 if mode in ("store16", "load16") else 4

    @flyc.jit
    def body(arg_out, arg_sink):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        base_item = bx * fx.Int32(256 * U) + tx
        if const_expr(mode == "atomic"):
            out = _global_base_ptr1(arg_out)
            for u in range_constexpr(U):
                _atomic_pk(out, (base_item + fx.Int32(u * 256)) * fx.Int32(4))
        else:
            rs = bo.create_buffer_resource_from_addr(_raw(fx.Int64(arg_out)))
            if const_expr(mode == "store4"):
                for u in range_constexpr(U):
                    bo.buffer_store(_raw(fx.Int32(0x3F803F80)), rs, base_item + fx.Int32(u * 256))
            elif const_expr(mode == "store16"):
                v = _ones_i32x4()
                for u in range_constexpr(U):
                    bo.buffer_store(v, rs, (base_item + fx.Int32(u * 256)) * fx.Int32(4))
            else:  # load16: xor everything, store one dword per lane (1/16 traffic)
                acc = fx.Int32(0)
                for u in range_constexpr(U):
                    v = Vec(bo.buffer_load(rs, (base_item + fx.Int32(u * 256)) * fx.Int32(4),
                                           vec_width=4, dtype=T.i32))
                    acc = acc ^ fx.Int32(v[0]) ^ fx.Int32(v[1]) ^ fx.Int32(v[2]) ^ fx.Int32(v[3])
                sink = bo.create_buffer_resource_from_addr(_raw(fx.Int64(arg_sink)))
                bo.buffer_store(_raw(acc), sink, bx * fx.Int32(256) + tx)

    @flyc.kernel(name=f"wbw_lin_{mode}", known_block_size=[256, 1, 1])
    def k(arg_out: fx.Int64, arg_sink: fx.Int64):
        body(arg_out, arg_sink)

    @flyc.jit
    def launch(arg_out: fx.Int64, arg_sink: fx.Int64, i32_grid: fx.Int32, stream: fx.Stream):
        k(arg_out, arg_sink).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1), stream=stream)

    return launch, lane_bytes * 256 * U  # bytes per WG


# ---- part 2: gemm2 scatter pattern --------------------------------------------
def build_g2(mode):
    @flyc.jit
    def body(arg_out, arg_stids, i32_M):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        m_row = (bx // fx.Int32(NB)) * fx.Int32(BM)
        n_col = (bx % fx.Int32(NB)) * fx.Int32(TN)
        if const_expr(mode == "atomic"):
            out = _global_base_ptr1(arg_out)
            m_lane = tx // fx.Int32(32)
            col = (tx % fx.Int32(32)) * fx.Int32(2)
            for mr in range_constexpr(BM // 8):
                sid = fx.Int32(_global_i32_at(arg_stids, m_row + fx.Int32(mr * 8) + m_lane))
                tok = sid & fx.Int32(0x00FFFFFF)
                if tok < i32_M:
                    for s in range_constexpr(TN // 64):
                        _atomic_pk(out, (tok * fx.Int32(H) + n_col + col + fx.Int32(s * 64)) * fx.Int32(2))
        else:  # store16 into route rows
            rs = bo.create_buffer_resource_from_addr(_raw(fx.Int64(arg_out)))
            v = _ones_i32x4()
            r_lane = tx // fx.Int32(TN // 8)  # 16 lanes x 16 B per 128-col row
            col = (tx % fx.Int32(TN // 8)) * fx.Int32(8)
            for p in range_constexpr(BM // (256 // (TN // 8))):
                sid = fx.Int32(_global_i32_at(
                    arg_stids, m_row + fx.Int32(p * (256 // (TN // 8))) + r_lane))
                tok = sid & fx.Int32(0x00FFFFFF)
                if tok < i32_M:
                    route = tok * fx.Int32(TOPK) + sid.shrui(fx.Int32(24))
                    bo.buffer_store(v, rs, (route * fx.Int32(H) + n_col + col) // fx.Int32(2))

    @flyc.kernel(name=f"wbw_g2_{mode}", known_block_size=[256, 1, 1])
    def k(arg_out: fx.Int64, arg_stids: fx.Int64, i32_M: fx.Int32):
        body(arg_out, arg_stids, i32_M)

    @flyc.jit
    def launch(arg_out: fx.Int64, arg_stids: fx.Int64, i32_M: fx.Int32, i32_grid: fx.Int32,
               stream: fx.Stream):
        k(arg_out, arg_stids, i32_M).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1),
                                            stream=stream)

    return launch


def build_g2_seg(L):
    """gemm2 tile scatter with L lanes x 4 B = 4L B contiguous per row segment
    (L=32 is the LDS epilogue's 128 B; L=8 the direct epilogue's 32 B)."""
    SEGS = TN // 2 // L  # segments per 128-col row
    PASSES = BM * SEGS // (256 // L)

    @flyc.jit
    def body(arg_out, arg_stids, i32_M):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        m_row = (bx // fx.Int32(NB)) * fx.Int32(BM)
        n_col = (bx % fx.Int32(NB)) * fx.Int32(TN)
        out = _global_base_ptr1(arg_out)
        g = tx // fx.Int32(L)
        j = tx % fx.Int32(L)
        for p in range_constexpr(PASSES):
            sg = fx.Int32(p * (256 // L)) + g
            # consecutive segments -> consecutive (different-token) rows, so one
            # wave instruction touches 64/L rows with 4L B each
            row = sg % fx.Int32(BM)
            pair = (sg // fx.Int32(BM)) * fx.Int32(L) + j
            sid = fx.Int32(_global_i32_at(arg_stids, m_row + row))
            tok = sid & fx.Int32(0x00FFFFFF)
            if tok < i32_M:
                _atomic_pk(out, (tok * fx.Int32(H) + n_col + pair * fx.Int32(2)) * fx.Int32(2))

    @flyc.kernel(name=f"wbw_g2_seg{L}", known_block_size=[256, 1, 1])
    def k(arg_out: fx.Int64, arg_stids: fx.Int64, i32_M: fx.Int32):
        body(arg_out, arg_stids, i32_M)

    @flyc.jit
    def launch(arg_out: fx.Int64, arg_stids: fx.Int64, i32_M: fx.Int32, i32_grid: fx.Int32,
               stream: fx.Stream):
        k(arg_out, arg_stids, i32_M).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1),
                                            stream=stream)

    return launch


def build_g2_xcd(scope):
    """gemm2 LDS-epilogue scatter (128 B segments) with XCD-affine columns: the
    WG on XCD x (= block id % 8, hardware round-robin) only touches n-blocks
    [x*NB/8, (x+1)*NB/8), so every output element is updated from one XCD. With
    scope "workgroup" the atomics resolve in that XCD's L2 (no sc1) instead of
    at the device coherence point; the kernel-end release writes L2 back."""
    NBX = NB // 8

    @flyc.jit
    def body(arg_out, arg_stids, i32_M):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        xcd = bx % fx.Int32(8)
        idx = bx // fx.Int32(8)
        m_row = (idx // fx.Int32(NBX)) * fx.Int32(BM)
        n_col = (xcd * fx.Int32(NBX) + idx % fx.Int32(NBX)) * fx.Int32(TN)
        out = _global_base_ptr1(arg_out)
        m_lane = tx // fx.Int32(32)
        col = (tx % fx.Int32(32)) * fx.Int32(2)
        for mr in range_constexpr(BM // 8):
            sid = fx.Int32(_global_i32_at(arg_stids, m_row + fx.Int32(mr * 8) + m_lane))
            tok = sid & fx.Int32(0x00FFFFFF)
            if tok < i32_M:
                for s_ in range_constexpr(TN // 64):
                    _atomic_pk(out, (tok * fx.Int32(H) + n_col + col + fx.Int32(s_ * 64)) * fx.Int32(2), scope)

    @flyc.kernel(name=f"wbw_g2_xcd_{scope}", known_block_size=[256, 1, 1])
    def k(arg_out: fx.Int64, arg_stids: fx.Int64, i32_M: fx.Int32):
        body(arg_out, arg_stids, i32_M)

    @flyc.jit
    def launch(arg_out: fx.Int64, arg_stids: fx.Int64, i32_M: fx.Int32, i32_grid: fx.Int32,
               stream: fx.Stream):
        k(arg_out, arg_stids, i32_M).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1),
                                            stream=stream)

    return launch


def build_reduce():
    @flyc.jit
    def body(arg_route, arg_out):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        o = bx * fx.Int32(256) + tx  # 16 B output chunk
        tok = o // fx.Int32(H // 8)
        c = o % fx.Int32(H // 8)
        src = bo.create_buffer_resource_from_addr(_raw(fx.Int64(arg_route)))
        dst = bo.create_buffer_resource_from_addr(_raw(fx.Int64(arg_out)))
        vs = [
            Vec(bo.buffer_load(src, (tok * fx.Int32(TOPK) + fx.Int32(k)) * fx.Int32(H // 2)
                               + c * fx.Int32(4), vec_width=4, dtype=T.i32))
            for k in range_constexpr(TOPK)
        ]
        acc = Vec(vs[0].bitcast(fx.BFloat16)).to(fx.Float32)
        for k in range_constexpr(1, TOPK):
            acc = acc + Vec(vs[k].bitcast(fx.BFloat16)).to(fx.Float32)
        bo.buffer_store(_raw(Vec(acc.to(fx.BFloat16)).bitcast(fx.Int32)), dst,
                        tok * fx.Int32(H // 2) + c * fx.Int32(4))

    @flyc.kernel(name="wbw_reduce", known_block_size=[256, 1, 1])
    def k(arg_route: fx.Int64, arg_out: fx.Int64):
        body(arg_route, arg_out)

    @flyc.jit
    def launch(arg_route: fx.Int64, arg_out: fx.Int64, i32_grid: fx.Int32, stream: fx.Stream):
        k(arg_route, arg_out).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1),
                                     stream=stream)

    return launch


def timed(fn):
    fn()
    torch.cuda.synchronize()
    _, us = run_perftest(fn, num_iters=50)
    return us


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--sizes_mb", type=int, nargs="*", default=[4, 64, 512])
    p.add_argument("-t", type=int, nargs="*", default=[128 << i for i in range(8)])
    p.add_argument("--seg_only", action="store_true", help="only part 3 (segment sweep)")
    p.add_argument("--xcd_only", action="store_true", help="only part 4 (XCD-affine scopes)")
    args = p.parse_args()
    st = torch.cuda.current_stream()

    if args.seg_only:
        return seg_sweep(args, st)
    if args.xcd_only:
        return xcd_sweep(args, st)
    print("== part 1: linear ceilings (GB/s)")
    sink = torch.zeros(1 << 24, dtype=torch.int32, device="cuda")
    for mb in args.sizes_mb:
        nbytes = mb << 20
        buf = torch.zeros(nbytes // 2, dtype=torch.bfloat16, device="cuda")
        row = [f"{mb:4d} MB:"]
        for mode in ("atomic", "store4", "store16", "load16"):
            launch, per_wg = build_linear(mode)
            grid = nbytes // per_wg
            assert mode != "load16" or grid * 256 <= sink.numel()
            buf.zero_()
            fn = lambda: _run_compiled(launch, buf.data_ptr(), sink.data_ptr(), grid, st)  # noqa: E731
            if mode == "atomic":  # one launch on a zeroed buffer: every element += 1
                fn()
                torch.cuda.synchronize()
                assert bool((buf == 1).all()), "linear atomic wrong"
            us = timed(fn)
            row.append(f"{mode} {nbytes / us / 1e3:7.1f}")
        print("  ".join(row), flush=True)
        del buf

    print("\n== part 2: gemm2 scatter traffic (us); payload = T*topk*H*2 B")
    g2a, g2s, red = build_g2("atomic"), build_g2("store16"), build_reduce()
    for tok in args.t:
        x = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
        tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
        sids, _, seids, nv, _ = moe_sorting(ti, tw, E, H, dtypes.bf16, BM)[:5]
        m_blocks = int(nv[0]) // BM
        grid = m_blocks * NB
        out = torch.zeros((tok, H), dtype=torch.bfloat16, device="cuda")
        route = torch.zeros((tok * TOPK, H), dtype=torch.bfloat16, device="cuda")
        red_out = torch.empty((tok, H), dtype=torch.bfloat16, device="cuda")

        f_at = lambda: _run_compiled(g2a, out.data_ptr(), sids.data_ptr(), tok, grid, st)  # noqa: E731
        f_st = lambda: _run_compiled(g2s, route.data_ptr(), sids.data_ptr(), tok, grid, st)  # noqa: E731
        f_rd = lambda: _run_compiled(red, route.data_ptr(), red_out.data_ptr(), tok * H // 8 // 256, st)  # noqa: E731
        f_zero = lambda: out.zero_()  # noqa: E731

        f_at()
        f_st()
        f_rd()
        torch.cuda.synchronize()
        assert bool((out == TOPK).all()), "g2 atomic wrong"
        assert bool((red_out == TOPK).all()), "store16 + reduce wrong"
        us_at, us_st, us_rd, us_z = timed(f_at), timed(f_st), timed(f_rd), timed(f_zero)
        pay = tok * TOPK * H * 2
        print(
            f"tok {tok:6d} m_blocks {m_blocks:5d}: atomic {us_at:7.1f} ({pay / us_at / 1e3:6.0f} GB/s)"
            f" + memset {us_z:5.1f} | store16 {us_st:7.1f} ({pay / us_st / 1e3:6.0f} GB/s)"
            f" + reduce {us_rd:7.1f} ({(pay + pay // TOPK) / us_rd / 1e3:6.0f} GB/s)"
            f" | atomic+memset {us_at + us_z:7.1f} vs store+reduce {us_st + us_rd:7.1f}",
            flush=True,
        )


def xcd_sweep(args, st):
    print("== part 4: XCD-affine columns, atomic scope (us, GB/s of payload)")
    kern = {sc: build_g2_xcd(sc) for sc in ("agent", "workgroup")}
    base = build_g2("atomic")
    for tok in args.t:
        x = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
        tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
        srt = moe_sorting(ti, tw, E, H, dtypes.bf16, BM)
        sids, nv = srt[0], srt[3]
        grid = int(nv[0]) // BM * NB
        out = torch.zeros((tok, H), dtype=torch.bfloat16, device="cuda")
        row = [f"tok {tok:6d}:"]
        for name, launch in [("g2 agent", base)] + [(f"xcd {k}", v) for k, v in kern.items()]:
            fn = lambda: _run_compiled(launch, out.data_ptr(), sids.data_ptr(), tok, grid, st)  # noqa: E731
            ok = True
            for _ in range(3):  # repeat: stale L2 lines across launches would show here
                out.zero_()
                fn()
                torch.cuda.synchronize()
                ok &= bool((out == TOPK).all())
            us = timed(fn)
            row.append(f"{name} {us:7.1f} ({tok * TOPK * H * 2 / us / 1e3:5.0f}){'' if ok else ' WRONG'}")
        print("  ".join(row), flush=True)


def seg_sweep(args, st):
    print("== part 3: atomic scatter vs contiguous segment per row (GB/s of payload)")
    kern = {L: build_g2_seg(L) for L in (8, 16, 32, 64)}
    for tok in args.t:
        x = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
        tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
        sids = moe_sorting(ti, tw, E, H, dtypes.bf16, BM)[0]
        nv = moe_sorting(ti, tw, E, H, dtypes.bf16, BM)[3]
        grid = int(nv[0]) // BM * NB
        out = torch.zeros((tok, H), dtype=torch.bfloat16, device="cuda")
        row = [f"tok {tok:6d}:"]
        for L, launch in kern.items():
            fn = lambda: _run_compiled(launch, out.data_ptr(), sids.data_ptr(), tok, grid, st)  # noqa: E731
            out.zero_()
            fn()
            torch.cuda.synchronize()
            assert bool((out == TOPK).all()), f"seg{L} wrong"
            us = timed(fn)
            row.append(f"{4 * L:3d}B {us:7.1f} us ({tok * TOPK * H * 2 / us / 1e3:5.0f})")
        print("  ".join(row), flush=True)


if __name__ == "__main__":
    main()

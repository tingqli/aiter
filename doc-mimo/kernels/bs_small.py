# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Small-token (<= 4096) FP8 blockscale MoE for MiMo-V2.6 TP8 (gfx950).

At these token counts every expert is active but has only 5..200 rows: the MoE
is bound by reading the weights (flash 805 MB, pro 1.8 GB) once. So:

  * one WG per expert (8 waves, one WG per CU): it scans topk_ids for its rows
    (no sort), runs gate|up for all of them (two 128-column intermediate
    chunks, SiLU * up quantized per (row, 128) into LDS) and then Down
    (256-column H steps). Every expert's W1 and W2 is read from HBM exactly
    once and the intermediate never leaves the CU.
  * W goes straight from global memory into VGPRs in the MFMA operand layout of
    shuffle_weight(16, 16), two 64 KB steps ahead (the steps of both gate|up
    chunks and of Down form one stream, so the stream never drains between
    phases). A (fp8 x rows of the expert) goes through a swizzled LDS double
    buffer; the per-128-K block scales are applied with one FMA per MFMA output.
  * Down writes routes[t * topk + k, :] (BF16, already x routing weight); a
    trivial kernel sums the topk rows of every token.

  bs_xquant : x [T, H] bf16 -> a8 [T, H] fp8 e4m3fn + sa [T, H / 128] fp32
  bs_main   : -> routes [T * topk, H] bf16
  bs_sum    : out[t] = sum_k routes[t * topk + k]

An expert with more rows than the compiled M takes several passes (each one
streams its weights again): correct for any routing, fast when M covers the
largest expert (random routing; `pick_m`).

Status (MI350X, experiments/bs_moe_tp8/README.md): faster than bs_moe only up
to ~1024 tokens, and there still 5-16% slower than aiter's asm 1-stage kernels,
which already run within 1.17-1.27x of the HBM floor. Optimization stopped.
"""

import functools

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl._mlir.dialects import llvm
from flydsl.expr import arith, range_constexpr, rocdl
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

from bs_common import _ptr, get_device_cache_key, ptr_rsrc, rocdl_aux

NT = 512  # bs_main threads (8 waves)
NW = NT // 64
FP8_MAX = 448.0
OOB = 0x40000000  # buffer offset past every descriptor used here: loads 0, stores dropped


def _raw(v):
    return v.ir_value() if hasattr(v, "ir_value") else v


def _scalar(v):
    return fx.Int32(rocdl.readfirstlane(T.i32, _raw(v)))


def _vt(n, ty=None):
    return ir.VectorType.get([n], ty or T.i32)


def _bload(rsrc, voff, soff=0, n=4):
    ty = T.i32 if n == 1 else _vt(n)
    return rocdl.raw_ptr_buffer_load(
        ty, rsrc, _raw(fx.Int32(voff)), _raw(fx.Int32(soff)), aux=rocdl_aux(0)
    )


def _bstore(val, rsrc, voff, soff=0):
    rocdl.raw_ptr_buffer_store(
        _raw(val), rsrc, _raw(fx.Int32(voff)), _raw(fx.Int32(soff)), aux=rocdl_aux(0)
    )


# Byte-addressed LDS (lb = the arena as a Uint8 iterator). Plain functions, not
# methods: FlyDSL treats `obj.method(...)` in a dynamic loop body as a write to obj.
def _lptr(lb, off):
    return fx.to_llvm_ptr(fx.add_offset(lb, fx.make_int_tuple(off)))


def _lld(lb, off, ty):
    return llvm.load(ty, _lptr(lb, off))


def _lst(lb, off, val):
    llvm.store(_raw(val), _lptr(lb, off))


def _cat(a, b):
    a, b = Vec(a), Vec(b)
    return Vec.from_elements([a[i] for i in range(4)] + [b[i] for i in range(4)], fx.Int32)


def _mfma(w8, a8):
    """16x16x128 FP8 MFMA, unscaled: lane l -> out[w row 4 * (l // 16) + r][a row l % 16]."""
    return Vec(
        rocdl.mfma_scale_f32_16x16x128_f8f6f4(
            T.vec(4, T.f32),
            [w8, a8, Vec.filled(4, 0.0, fx.Float32), 0, 0, 0, fx.Int32(0), 0, fx.Int32(0)],
        )
    )


def _fma4(p, s, acc):
    p, acc = Vec(p), Vec(acc)
    return Vec.from_elements([fx.fma(p[i], s, acc[i]) for i in range(4)], fx.Float32)


def _silu_mul(gate, up):
    exponent = rocdl.exp2(T.f32, _raw(gate * -1.4426950408889634))
    return (gate * fx.Float32(rocdl.rcp(T.f32, _raw(1.0 + fx.Float32(exponent))))) * up


def _pack_fp8(v, inv):
    """4 f32 * inv -> 4 fp8 e4m3fn in one i32 (RNE)."""
    lo = rocdl.cvt_pk_fp8_f32(
        res=T.i32, src_a=v[0] * inv, src_b=v[1] * inv, old=fx.Int32(0), word_sel=False
    )
    return fx.Int32(
        rocdl.cvt_pk_fp8_f32(res=T.i32, src_a=v[2] * inv, src_b=v[3] * inv, old=lo, word_sel=True)
    )


def _ballot(pred):
    b = fx.Int64(rocdl.ballot(T.i64, _raw(pred)))
    lo = fx.Int32(arith.trunci(T.i32, _raw(b)))
    hi = fx.Int32(arith.trunci(T.i32, _raw(b >> fx.Int64(32))))
    return lo, hi


def _popc(x):
    return fx.Int32(fx.math.ctpop(_raw(x)))


def _mbcnt(lo, hi):
    return fx.Int32(rocdl.mbcnt_hi(T.i32, _raw(hi), rocdl.mbcnt_lo(T.i32, _raw(lo), _raw(fx.Int32(0)))))


# =============================================================================
# x quant: per (row, 128) FP8, scale = amax / 448 (same recipe as bs_prep)
# =============================================================================


@functools.cache
def compile_xquant(H):
    KB = H // 128
    STEPS = H // 512  # a wave quantizes 4 groups of 128 (16 lanes each) per step
    RPWG = 8  # rows per WG: 4 waves x 2 rows in flight

    @flyc.kernel(known_block_size=[256, 1, 1])
    def bs_xquant_kernel(x: fx.Pointer, a8: fx.Pointer, sa: fx.Pointer, tokens: fx.Int32):
        tid = fx.Int32(fx.thread_idx.x)
        bx = fx.Int32(fx.block_idx.x)
        lane = tid % 64
        wave = tid // 64
        unit = lane % 16
        grp = lane // 16
        x_r = ptr_rsrc(x, tokens * (H * 2))
        a_r = ptr_rsrc(a8, tokens * H)
        s_r = ptr_rsrc(sa, tokens * (KB * 4))
        rows = [bx * RPWG + i * 4 + wave for i in range_constexpr(2)]
        raws = []
        for r in rows:
            rr = (r < tokens).select(r, fx.Int32(0))
            raws.append([
                Vec(_bload(x_r, (rr * H + (s * 4 + grp) * 128 + unit * 8) * 2))
                for s in range_constexpr(STEPS)
            ])
        for r, raw in zip(rows, raws):
            ok = r < tokens
            for s in range_constexpr(STEPS):
                v = Vec(raw[s].bitcast(fx.BFloat16)).to(fx.Float32)
                am = fx.absf(v[0])
                for k in range_constexpr(1, 8):
                    am = fx.maxnumf(am, fx.absf(v[k]))
                for bit in range_constexpr(4):
                    am = fx.maxnumf(am, am.shuffle_xor(1 << bit, 64))
                scale = fx.maxnumf(am, fx.Float32(1e-30)) * fx.Float32(1.0 / FP8_MAX)
                inv = fx.Float32(rocdl.rcp(T.f32, _raw(scale)))
                words = Vec.from_elements(
                    [_pack_fp8([v[4 * h + i] for i in range(4)], inv) for h in range_constexpr(2)],
                    fx.Int32,
                )
                kb = s * 4 + grp
                _bstore(words, a_r, ok.select(r * H + kb * 128 + unit * 8, fx.Int32(OOB)))
                _bstore(
                    scale.bitcast(fx.Int32),
                    s_r,
                    (ok & (unit == 0)).select((r * KB + kb) * 4, fx.Int32(OOB)),
                )

    @flyc.jit
    def launch(x: fx.Pointer, a8: fx.Pointer, sa: fx.Pointer, tokens: fx.Int32, grid: fx.Int32,
               stream: fx.Stream):
        bs_xquant_kernel(x, a8, sa, tokens).launch(grid=(grid, 1, 1), block=(256, 1, 1), stream=stream)

    return launch, RPWG


# =============================================================================
# main: one WG per expert, gate|up + SiLU + quant + Down for all its rows
# =============================================================================


@functools.cache
def compile_main(H, I, E, TOPK, M, TMAX):
    assert I == 256 and H % 512 == 0 and M % 16 == 0 and 16 <= M <= 256
    KB = H // 128  # gate|up K blocks
    NS1 = KB // 2  # gate|up steps per chunk (256 K each)
    NS2 = H // 256  # Down steps (256 H columns each)
    MB = M // 16
    MA = max(64, (M + 63) // 64 * 64)  # A staging rows (multiple of 64: 8 pieces/row, 512 threads)
    NA = MA // 64  # A rows per thread per K block
    assert NS1 >= 4 and NS2 >= 4

    # LDS layout (bytes)
    A_BYTES = 2 * MA * 128  # one stage: 2 K blocks x MA rows x 128 B
    ABUF = 0
    SA = ABUF + 2 * A_BYTES  # 2 stages x MA rows x 2 floats
    ACT = SA + 2 * MA * 8  # M rows x 256 B (fp8 SiLU*up)
    ACTS = ACT + M * 256  # M rows x 2 scales
    RED = ACTS + M * 8  # NW x M amax partials
    SW1 = RED + NW * M * 4  # w1 scales [4, KB]
    SW2 = SW1 + 4 * KB * 4  # w2 scales [H/128, 2]
    RDST = SW2 + (H // 128) * 8  # per row: t * TOPK + k (-1 invalid)
    RW = RDST + M * 4  # per row: routing weight
    LIST = RW + M * 4  # all rows of the expert (flat topk index)
    WCNT = LIST + TMAX * 4
    DUMMY = WCNT + NW * 4
    words = (DUMMY + 16) // 4
    words = max(words, 84 * 256)  # > 80 KB: one WG per CU
    assert words * 4 <= 160 * 1024, words * 4

    attrs = {
        "rocdl.flat_work_group_size": f"{NT},{NT}",
        "llvm.passthrough": [["target-features", "-packed-fp32-ops"]],
    }

    @fx.struct
    class Storage:
        arena: fx.Array[fx.Int32, words, 16]

    @flyc.kernel(known_block_size=[NT, 1, 1])
    def bs_main_kernel(
        ids: fx.Pointer,
        wts: fx.Pointer,
        a8: fx.Pointer,
        sa: fx.Pointer,
        w1: fx.Pointer,
        w1s: fx.Pointer,
        w2: fx.Pointer,
        w2s: fx.Pointer,
        routes: fx.Pointer,
        tokens: fx.Int32,
        ns1: fx.Int32,  # NS1 - 2 (runtime: keeps the K loops rolled)
        ns2: fx.Int32,  # NS2 - 2
    ):
        tid = fx.Int32(fx.thread_idx.x)
        e = fx.Int32(fx.block_idx.x)
        lane = tid % 64
        w = _scalar(tid // 64)
        g = lane // 16
        l16 = lane % 16
        lb = fx.recast_iter(fx.Uint8, fx.SharedAllocator().allocate(Storage).peek().arena.ptr)
        n_ent = tokens * TOPK

        ids_r = ptr_rsrc(ids, n_ent * 4)
        wts_r = ptr_rsrc(wts, n_ent * 4)
        a8_r = ptr_rsrc(a8, tokens * H)
        sa_r = ptr_rsrc(sa, tokens * (KB * 4))
        w1_r = ptr_rsrc(w1 + fx.Int64(e) * (2 * I * H), 2 * I * H)
        w2_r = ptr_rsrc(w2 + fx.Int64(e) * (H * I), H * I)
        w1s_r = ptr_rsrc(w1s + fx.Int64(e) * (4 * KB), 4 * KB * 4)
        w2s_r = ptr_rsrc(w2s + fx.Int64(e) * (H // 128 * 2), H // 128 * 8)
        rt_r = ptr_rsrc(routes, n_ent * (H * 2))
        lane16 = lane * 16

        # ---- weight stream: 8 dwordx4 per lane per 64 KB step ----
        def w1_step(c, s, ok=None):
            """gate|up chunk c, K step s (K blocks 2s, 2s+1): [nb][kbp][half]."""
            voff = lane16 if ok is None else ok.select(lane16, fx.Int32(OOB))
            out = []
            for nb in range_constexpr(2):
                base = ((nb * 16 + c * 8) + w) * (H * 16) + s * 4096
                for kbp in range_constexpr(2):
                    for h in range_constexpr(2):
                        out.append(Vec(_bload(w1_r, voff, base + kbp * 2048 + h * 1024)))
            return out

        def w2_step(hc):
            """Down H step hc (rows hc*256 + 32w + 16nb + 0..15): [nb][kb2][half]."""
            out = []
            for nb in range_constexpr(2):
                base = (hc * 16 + 2 * w + nb) * 4096
                for kb2 in range_constexpr(2):
                    for h in range_constexpr(2):
                        out.append(Vec(_bload(w2_r, lane16, base + kb2 * 2048 + h * 1024)))
            return out

        def w2_step_entry(hc):
            """w2_step + one Down step's worth of dropped stores: the VMEM queue at the
            Down loop entry then matches its back-edge (LLVM merges the two vmcnt)."""
            out = w2_step(hc)
            for _ in range_constexpr(2 * MB):
                _bstore(fx.Int32(0), rt_r, fx.Int32(OOB))
            return out

        # ---- per-expert scales -> LDS ----
        def load_scales():
            for j in range_constexpr((4 * KB + NT - 1) // NT):
                i = tid + j * NT
                ok = i < 4 * KB
                v = fx.Int32(_bload(w1s_r, ok.select(i * 4, fx.Int32(OOB)), n=1))
                _lst(lb, ok.select(SW1 + i * 4, fx.Int32(DUMMY)), v)
            for j in range_constexpr((H // 128 * 2 + NT - 1) // NT):
                i = tid + j * NT
                ok = i < H // 128 * 2
                v = fx.Int32(_bload(w2s_r, ok.select(i * 4, fx.Int32(OOB)), n=1))
                _lst(lb, ok.select(SW2 + i * 4, fx.Int32(DUMMY)), v)

        # ---- rows of expert e: count per wave, then write in entry order ----
        chw = (n_ent + (NW * 256 - 1)) // (NW * 256) * 256
        start = w * chw
        iters = chw // 256

        def scan_matches(it):
            idx0 = start + fx.Int32(it) * 256 + lane * 4
            v = Vec(_bload(ids_r, idx0 * 4))
            return idx0, [(idx0 + j < n_ent) & (fx.Int32(v[j]) == e) for j in range(4)]

        def scan_count():
            cnt = fx.Int32(0)
            for it in range(iters):
                _, ms = scan_matches(it)
                for m in ms:
                    lo, hi = _ballot(m)
                    cnt = cnt + _popc(lo) + _popc(hi)
            return cnt

        def scan_write(off):
            run = off
            for it2 in range(iters):
                idx2, ms2 = scan_matches(it2)
                for j2, m2 in enumerate(ms2):
                    lo2, hi2 = _ballot(m2)
                    pos = run + _mbcnt(lo2, hi2)
                    _lst(lb, m2.select(LIST + pos * 4, fx.Int32(DUMMY)), idx2 + j2)
                    run = run + _popc(lo2) + _popc(hi2)

        def scan_rows():
            _lst(lb, WCNT + w * 4, scan_count())
            fx.barrier()
            off = fx.Int32(0)
            n_e = fx.Int32(0)
            for ww in range_constexpr(NW):
                c_ = fx.Int32(_lld(lb, WCNT + ww * 4, T.i32))
                off = off + (fx.Int32(ww) < w).select(c_, fx.Int32(0))
                n_e = n_e + c_
            scan_write(off)
            fx.barrier()
            return n_e

        # ---- lane constants ----
        sw7 = l16 & 7
        a_rd = [l16 * 128 + ((g ^ sw7) * 16), l16 * 128 + (((g + 4) ^ sw7) * 16)]
        a_row = [tid // 8 + ii * 64 for ii in range(NA)]  # A rows this thread stages
        a_wr = [r * 128 + (((tid % 8) ^ ((tid // 8) & 7)) * 16) for r in a_row]
        act_rd = [
            [l16 * 256 + (((kb2 * 8 + half * 4 + g) ^ l16) * 16) for half in range(2)]
            for kb2 in range(2)
        ]

        def pass_rows(p, n_e):
            """rows p*M .. p*M+M-1 of the expert -> LDS; this thread's A / scale offsets."""
            for j in range_constexpr((M + NT - 1) // NT):
                r = tid + j * NT
                q = p * M + r
                valid = (r < M) & (q < n_e)
                qc = valid.select(q, fx.Int32(0))
                dst = valid.select(fx.Int32(_lld(lb, LIST + qc * 4, T.i32)), fx.Int32(-1))
                rw = fx.Int32(_bload(wts_r, valid.select(dst * 4, fx.Int32(OOB)), n=1))
                _lst(lb, (r < M).select(RDST + r * 4, fx.Int32(DUMMY)), dst)
                _lst(lb, (r < M).select(RW + r * 4, fx.Int32(DUMMY)), rw)
            fx.barrier()
            a_base = []
            for r in a_row:
                dst = fx.Int32(_lld(lb, (r < M).select(RDST + r * 4, fx.Int32(DUMMY)), T.i32))
                ok = (r < M) & (dst >= 0)
                a_base.append(ok.select((dst // TOPK) * H + (tid % 8) * 16, fx.Int32(OOB)))
            sdst = fx.Int32(_lld(lb, (tid < M).select(RDST + tid * 4, fx.Int32(DUMMY)), T.i32))
            s_base = ((tid < M) & (sdst >= 0)).select((sdst // TOPK) * (KB * 4), fx.Int32(OOB))
            return a_base, s_base

        def a_load(ab, s):
            a_base, s_base = ab
            regs = [
                Vec(_bload(a8_r, a_base[ii], (2 * s + kbp) * 128))
                for kbp in range_constexpr(2)
                for ii in range_constexpr(NA)
            ]
            return regs + [Vec(_bload(sa_r, s_base, s * 8, n=2))]

        def a_store(regs, buf):
            for kbp in range_constexpr(2):
                for ii in range_constexpr(NA):
                    _lst(lb, ABUF + buf * A_BYTES + kbp * MA * 128 + a_wr[ii], regs[kbp * NA + ii])
            _lst(lb, (tid < MA).select(SA + buf * MA * 8 + tid * 8, fx.Int32(DUMMY)), regs[2 * NA])

        def g1_compute(c, s, ws, buf, acc):
            """acc[nb][mb] += MFMA(W, A) * (sa[row] * sw[nb]) over the step's 2 K blocks.

            Pipelined: the A fragment / row scale of the next m-block are read
            before this one's MFMAs, and an MFMA pair's scale-FMAs retire after
            the next pair has issued (MFMA and LDS latencies stay hidden)."""
            acc = list(acc)
            order = [(kbp, mb) for kbp in range(2) for mb in range(MB)]
            sws = []
            for kbp in range_constexpr(2):
                kb = fx.Int32(s) * 2 + kbp
                sws.append((fx.Float32(_lld(lb, SW1 + (c * KB + kb) * 4, T.f32)),
                            fx.Float32(_lld(lb, SW1 + ((2 + c) * KB + kb) * 4, T.f32))))
            wfr = [(_cat(ws[kbp * 2], ws[kbp * 2 + 1]), _cat(ws[4 + kbp * 2], ws[4 + kbp * 2 + 1]))
                   for kbp in range(2)]

            def read(i):
                kbp, mb = order[i]
                ab = ABUF + buf * A_BYTES + kbp * MA * 128 + mb * 2048
                a = _cat(_lld(lb, ab + a_rd[0], _vt(4)), _lld(lb, ab + a_rd[1], _vt(4)))
                s_a = fx.Float32(_lld(lb, SA + buf * MA * 8 + (mb * 16 + l16) * 8 + kbp * 4, T.f32))
                return a, s_a

            nxt = read(0)
            pending = []
            for i in range_constexpr(len(order)):
                kbp, mb = order[i]
                a, s_a = nxt
                nxt = read(i + 1) if i + 1 < len(order) else nxt
                rocdl.sched_barrier(0)
                wg, wu = wfr[kbp]
                pg = _mfma(wg, a)
                pu = _mfma(wu, a)
                rocdl.sched_barrier(0)
                for p, sc, j in pending:
                    acc[j] = _fma4(p, sc, acc[j])
                rocdl.sched_barrier(0)
                sg, su = sws[kbp]
                pending = [(pg, s_a * sg, mb), (pu, s_a * su, MB + mb)]
            for p, sc, j in pending:
                acc[j] = _fma4(p, sc, acc[j])
            return acc

        def g1_step(c, s, buf, ws, regs, acc, ab, next_a, next_w):
            """stage A(s); load A(next_a); compute with ws; load W(next_w) into ws."""
            rocdl.sched_barrier(0)
            a_store(regs, buf)
            regs = a_load(ab, next_a) if next_a is not None else regs
            fx.barrier()
            acc = g1_compute(c, s, ws, buf, acc)
            ws = next_w() if next_w is not None else ws
            rocdl.sched_barrier(0)
            return ws, regs, acc

        def epilogue(c, acc):
            vals = []
            for mb in range_constexpr(MB):
                ga, ua = Vec(acc[mb]), Vec(acc[MB + mb])
                v = [_silu_mul(ga[r], ua[r]) for r in range(4)]
                am = fx.absf(v[0])
                for x in v[1:]:
                    am = fx.maxnumf(am, fx.absf(x))
                am = fx.maxnumf(am, am.shuffle_xor(16, 64))
                am = fx.maxnumf(am, am.shuffle_xor(32, 64))
                _lst(lb, RED + (w * M + mb * 16 + l16) * 4, am)
                vals.append(v)
            fx.barrier()
            for mb in range_constexpr(MB):
                row = mb * 16 + l16
                am = fx.Float32(_lld(lb, RED + row * 4, T.f32))
                for ww in range_constexpr(1, NW):
                    am = fx.maxnumf(am, fx.Float32(_lld(lb, RED + (ww * M + row) * 4, T.f32)))
                scale = fx.maxnumf(am, fx.Float32(1e-30)) * fx.Float32(1.0 / FP8_MAX)
                inv = fx.Float32(rocdl.rcp(T.f32, _raw(scale)))
                _lst(lb, ACT + row * 256 + (((c * 8 + w) ^ l16) * 16) + g * 4, _pack_fp8(vals[mb], inv))
                _lst(lb, ACTS + (row * 2 + c) * 4, scale)

        def g1_chunk(c, slot, regs, ab):
            """gate|up chunk c (intermediate columns c*128 .. c*128+127) -> ACT."""
            zero4 = Vec.filled(4, 0.0, fx.Float32)
            init = [zero4] * (2 * MB) + slot[0] + slot[1] + regs
            for s0, st in range(0, ns1, 2, init=init):
                stl = list(st)
                si = fx.Int32(s0)
                wa, rga, aca = g1_step(
                    c, si, 0, stl[2 * MB: 2 * MB + 8], stl[2 * MB + 16:], stl[: 2 * MB], ab,
                    si + 1, functools.partial(w1_step, c, si + 2))
                wb, rgb, acb = g1_step(
                    c, si + 1, 1, stl[2 * MB + 8: 2 * MB + 16], rga, aca, ab,
                    si + 2, functools.partial(w1_step, c, si + 3))
                fin = yield acb + wa + wb + rgb
            res = list(fin)
            acc = res[: 2 * MB]
            out_slot = [res[2 * MB: 2 * MB + 8], res[2 * MB + 8: 2 * MB + 16]]
            out_regs = res[2 * MB + 16:]
            # last two K steps: the stream continues into chunk 1 / Down
            for u in range_constexpr(2):
                s = NS1 - 2 + u
                last = s + 1 >= NS1
                nxt = (functools.partial(w1_step, 1, u) if c == 0
                       else functools.partial(w2_step_entry, u))
                na = s + 1 if not last else (0 if c == 0 else None)
                out_slot[u], out_regs, acc = g1_step(
                    c, s, u, out_slot[u], out_regs, acc, ab, na, nxt)
            epilogue(c, acc)
            return out_slot, out_regs

        def down_step(hc, ws, rows, next_w):
            rocdl.sched_barrier(0)
            # Lockstep: without it the older wave of each SIMD runs ahead and
            # the other four waves finish Down ~18 us later (measured).
            fx.barrier()
            rws, roffs = rows
            blk = fx.Int32(hc) * 2 + w // 4
            s2 = [fx.Float32(_lld(lb, SW2 + (blk * 2 + kb2) * 4, T.f32)) for kb2 in range(2)]
            wf = [[_cat(ws[nb * 4 + kb2 * 2], ws[nb * 4 + kb2 * 2 + 1]) for kb2 in range(2)]
                  for nb in range(2)]

            def read(mb):
                row = mb * 16 + l16
                sc = [fx.Float32(_lld(lb, ACTS + (row * 2 + kb2) * 4, T.f32)) for kb2 in range(2)]
                a = [
                    _cat(_lld(lb, ACT + mb * 4096 + act_rd[kb2][0], _vt(4)),
                         _lld(lb, ACT + mb * 4096 + act_rd[kb2][1], _vt(4)))
                    for kb2 in range(2)
                ]
                return a, sc

            def retire(pend):
                mb, ps, sc = pend
                return [
                    (mb, nb, _fma4(ps[nb][1], sc[1] * s2[1], Vec.from_elements(
                        [Vec(ps[nb][0])[i] * (sc[0] * s2[0]) for i in range(4)], fx.Float32)))
                    for nb in range(2)
                ]

            outs = []
            nxt = read(0)
            pend = None
            for mb in range_constexpr(MB):
                a, sc = nxt
                nxt = read(mb + 1) if mb + 1 < MB else nxt
                rocdl.sched_barrier(0)
                ps = [[_mfma(wf[nb][kb2], a[kb2]) for kb2 in range(2)] for nb in range(2)]
                rocdl.sched_barrier(0)
                outs += retire(pend) if pend is not None else []
                rocdl.sched_barrier(0)
                pend = (mb, ps, sc)
            outs += retire(pend)
            ws = next_w() if next_w is not None else ws
            for mb, nb, y in outs:
                yv = Vec.from_elements([Vec(y)[i] * rws[mb] for i in range(4)], fx.Float32)
                _bstore(yv.to(fx.BFloat16).bitcast(fx.Int32), rt_r,
                        roffs[mb] + nb * 32, fx.Int32(hc) * 512)
            rocdl.sched_barrier(0)
            return ws

        def down_all(slot, more):
            rws, roffs = [], []
            for mb in range_constexpr(MB):
                row = mb * 16 + l16
                rws.append(fx.Float32(_lld(lb, RW + row * 4, T.f32)))
                dst = fx.Int32(_lld(lb, RDST + row * 4, T.i32))
                roffs.append((dst >= 0).select((dst * H + 32 * w + 4 * g) * 2, fx.Int32(OOB)))
            rows = (rws, roffs)
            for h0, st in range(0, ns2, 2, init=slot[0] + slot[1]):
                stl = list(st)
                hi = fx.Int32(h0)
                da = down_step(hi, stl[0:8], rows, functools.partial(w2_step, hi + 2))
                db = down_step(hi + 1, stl[8:16], rows, functools.partial(w2_step, hi + 3))
                fin = yield da + db
            res = list(fin)
            out_slot = [res[0:8], res[8:16]]
            # last two steps: slot 0 prefetches the next pass's first W1 step
            # (dropped when there is none); slot 1 is reloaded after its A(0).
            out_slot[0] = down_step(NS2 - 2, out_slot[0], rows,
                                    functools.partial(w1_step, 0, 0, more))
            down_step(NS2 - 1, out_slot[1], rows, None)
            return out_slot[0]

        def one_pass(p, n_e, slot0):
            ab = pass_rows(p, n_e)
            rocdl.sched_barrier(0)
            regs = a_load(ab, 0)
            rocdl.sched_barrier(0)
            slot = [slot0, w1_step(0, 1)]
            rocdl.sched_barrier(0)
            slot, regs = g1_chunk(0, slot, regs, ab)
            slot, regs = g1_chunk(1, slot, regs, ab)
            fx.barrier()
            return down_all(slot, p + 1 < (n_e + (M - 1)) // M)

        slots0 = w1_step(0, 0)
        load_scales()
        n_exp = scan_rows()
        npass = (n_exp + (M - 1)) // M
        for pp, pst in range(0, npass, 1, init=slots0):
            nslot = one_pass(fx.Int32(pp), n_exp, list(pst))
            pfin = yield nslot

    @flyc.jit
    def launch(
        ids: fx.Pointer,
        wts: fx.Pointer,
        a8: fx.Pointer,
        sa: fx.Pointer,
        w1: fx.Pointer,
        w1s: fx.Pointer,
        w2: fx.Pointer,
        w2s: fx.Pointer,
        routes: fx.Pointer,
        tokens: fx.Int32,
        ns1: fx.Int32,
        ns2: fx.Int32,
        stream: fx.Stream,
    ):
        bs_main_kernel(
            ids, wts, a8, sa, w1, w1s, w2, w2s, routes, tokens, ns1, ns2, value_attrs=attrs
        ).launch(grid=(E, 1, 1), block=(NT, 1, 1), stream=stream)

    return launch, NS1, NS2


# =============================================================================
# topk sum
# =============================================================================


@functools.cache
def compile_sum(H, TOPK):
    CB = (H + 2047) // 2048

    @flyc.kernel(known_block_size=[256, 1, 1])
    def bs_sum_kernel(routes: fx.Pointer, out: fx.Pointer, tokens: fx.Int32):
        tid = fx.Int32(fx.thread_idx.x)
        bx = fx.Int32(fx.block_idx.x)
        t = bx // CB
        col = (bx % CB) * 2048 + tid * 8
        ok = col < H
        r_r = ptr_rsrc(routes, tokens * (TOPK * H * 2))
        o_r = ptr_rsrc(out, tokens * (H * 2))
        frags = [
            Vec(_bload(r_r, ok.select(((t * TOPK + k) * H + col) * 2, fx.Int32(OOB)))).bitcast(
                fx.BFloat16
            )
            for k in range_constexpr(TOPK)
        ]
        acc = frags[0].to(fx.Float32)
        for k in range_constexpr(1, TOPK):
            acc = acc + frags[k].to(fx.Float32)
        _bstore(acc.to(fx.BFloat16).bitcast(fx.Int32), o_r,
                ok.select((t * H + col) * 2, fx.Int32(OOB)))

    @flyc.jit
    def launch(routes: fx.Pointer, out: fx.Pointer, tokens: fx.Int32, stream: fx.Stream):
        bs_sum_kernel(routes, out, tokens).launch(
            grid=(tokens * CB, 1, 1), block=(256, 1, 1), stream=stream
        )

    return launch


# =============================================================================
# host
# =============================================================================


def pick_m(tokens, topk, experts):
    """Rows per pass: covers the largest expert of a random routing (mean + ~5.5 sd).

    At most 144: the LDS layout of a larger M does not fit in 160 KB (TMAX 4096)."""
    mean = tokens * topk / experts
    need = mean + 5.5 * mean**0.5 + 4
    return min(144, max(32, int(-(-need // 16)) * 16))


_ws = {}


def _workspace(dev, tokens, H, topk):
    key = (dev, tokens, H, topk)
    ws = _ws.get(key)
    if ws is None:
        ws = _ws[key] = (
            torch.empty(tokens, H, dtype=torch.float8_e4m3fn, device=dev),
            torch.empty(tokens, H // 128, dtype=torch.float32, device=dev),
            torch.empty(tokens * topk, H, dtype=torch.bfloat16, device=dev),
        )
    return ws


def stages(x, w1, w1_scale, w2, w2_scale, topk_weights, topk_ids, *, out=None, m=None,
           tmax=4096):
    """-> ([(name, fn)], out): the three launches (no host sync, workspace cached)."""
    tokens, H = x.shape
    E, two_i, _ = w1.shape
    I = two_i // 2
    topk = topk_ids.shape[1]
    dev = x.device
    assert tokens <= tmax and x.dtype == torch.bfloat16
    assert topk_ids.dtype == torch.int32 and topk_weights.dtype == torch.float32
    assert w1.dtype == w2.dtype == torch.float8_e4m3fn
    if out is None:
        out = torch.empty(tokens, H, dtype=torch.bfloat16, device=dev)
    m = m or pick_m(tokens, topk, E)
    a8, sa, routes = _workspace(dev, tokens, H, topk)
    stream = lambda: fx.Stream(torch.cuda.current_stream(dev).cuda_stream)  # noqa: E731
    with torch.cuda.device(dev):
        xq, rpwg = compile_xquant(H)
        main, ns1, ns2 = compile_main(H, I, E, topk, m, tmax)
        sm = compile_sum(H, topk)
    grid = (tokens + rpwg - 1) // rpwg

    def f_xquant():
        _run_compiled(xq, _ptr(x), _ptr(a8), _ptr(sa), fx.Int32(tokens), fx.Int32(grid), stream())

    def f_main():
        _run_compiled(
            main,
            _ptr(topk_ids), _ptr(topk_weights), _ptr(a8), _ptr(sa),
            _ptr(w1), _ptr(w1_scale), _ptr(w2), _ptr(w2_scale), _ptr(routes),
            fx.Int32(tokens), fx.Int32(ns1 - 2), fx.Int32(ns2 - 2), stream(),
        )

    def f_sum():
        _run_compiled(sm, _ptr(routes), _ptr(out), fx.Int32(tokens), stream())

    return [("xquant", f_xquant), ("main", f_main), ("sum", f_sum)], out


def fp8_blockscale_moe_small(x, w1, w1_scale, w2, w2_scale, topk_weights, topk_ids, **kw):
    fns, out = stages(x, w1, w1_scale, w2, w2_scale, topk_weights, topk_ids, **kw)
    for _, f in fns:
        f()
    return out


__all__ = ["fp8_blockscale_moe_small", "stages", "pick_m", "get_device_cache_key"]

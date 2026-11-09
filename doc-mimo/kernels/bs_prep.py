# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""gfx950 MoE prep for the blockscale MoE: routing sort + x FP8 quant, ONE launch.

Replaces aiter moe_sorting (block 256) + per_1x128 hip quant (transpose_scale):
  * sort (moe_sorting contract): sorted_ids [cap] (token | slot << 24, padding =
    T | topk << 24), sorted_weights [cap], sorted_expert_ids [cap / 256],
    num_valid_ids = [padded rows, T]. Every expert's rows start on a 256-row
    block; the row order inside an expert follows global atomics (not
    deterministic; the MoE output is, since the reduce sums in slot order).
  * quant: a [T, H] fp8 e4m3fn, sa [H / 128, T] fp32 (K-block major, what
    gemm1 reads): scale = amax * (1 / 448), q = rn(x * rcp(scale)), like the
    aiter kernel (amax floored at 1e-30 instead of producing NaN rows).

Each WG histograms its slice of the routing in LDS (LDS atomics give every entry
its rank), reserves per-expert ranges with one global atomic per expert, arrives
at a grid barrier, quantizes its share of x rows (the barrier wait hides behind
this streaming work), computes the padded expert offsets (block scan), scatters,
and writes the padding / block expert ids of its experts. All WGs are resident
(grid <= 2 per CU); the last WG resets the workspace counters (graph-safe).
"""

import functools

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl._mlir.dialects import llvm
from flydsl.expr import range_constexpr, rocdl
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

from bs_common import SYS, _ptr, gatomic_add, gatomic_xchg, ptr_rsrc, rocdl_aux

BM = 256
FP8_MAX = 448.0


def _scalar(v):
    return fx.Int32(rocdl.readfirstlane(T.i32, v.ir_value()))


def _lds_ptr(base, word):
    return fx.to_llvm_ptr(
        fx.add_offset(fx.recast_iter(fx.Uint8, base), fx.make_int_tuple(word * 4))
    )


def _lds_atomic_add(base, word, val):
    return fx.Int32(
        llvm.AtomicRMWOp(
            llvm.AtomicBinOp.add,
            _lds_ptr(base, word),
            fx.Int32(val).ir_value(),
            llvm.AtomicOrdering.monotonic,
            syncscope="workgroup",
        ).res
    )


def _lds_ld(base, word, ty=fx.Int32):
    return ty(llvm.load(ty.ir_type, _lds_ptr(base, word)))


def _lds_st(base, word, val):
    llvm.store(val.ir_value(), _lds_ptr(base, word))


@functools.cache
def compile_bs_prep(H, TOPK, E, EPT, RPW, GRID, NT):
    """EPT: routing entries per thread; RPW: x rows per WG (multiple of 2 * waves)."""
    NW = NT // 64
    assert H % 512 == 0 and E <= 2 * NT and TOPK < 256 and RPW % (2 * NW) == 0
    KB = H // 128
    STEPS = H // 512  # a wave quantizes 4 groups of 128 per step (16 lanes each)
    E_LOOP = (E + NT - 1) // NT
    # LDS words: local count (E+1, slot E = invalid entries) -> global count,
    # per-WG base, padded offsets (E+1), wave totals, scale staging.
    L_CNT, L_BASE = 0, E + 1
    L_OFF = L_BASE + E
    L_WT = L_OFF + E + 1
    L_FLAG = L_WT + NW
    L_SC = (L_FLAG + 1 + 3) // 4 * 4
    words = L_SC + RPW * KB

    @fx.struct
    class Storage:
        arena: fx.Array[fx.Int32, words, 16]

    @flyc.kernel(known_block_size=[NT, 1, 1])
    def bs_prep_kernel(
        ids: fx.Pointer,
        wts: fx.Pointer,
        x: fx.Pointer,
        sids: fx.Pointer,
        sw: fx.Pointer,
        seids: fx.Pointer,
        nv: fx.Pointer,
        a8: fx.Pointer,
        sa: fx.Pointer,
        inv: fx.Pointer,
        ws: fx.Pointer,
        tokens: fx.Int32,
    ):
        tid = fx.Int32(fx.thread_idx.x)
        g = fx.Int32(fx.block_idx.x)
        lane = tid % 64
        wave = _scalar(tid // 64)
        base = fx.SharedAllocator().allocate(Storage).peek().arena.ptr
        n_ent = tokens * TOPK
        ws_rsrc = ptr_rsrc(ws, (E + 2) * 4)

        # ---- A. LDS histogram of this WG's routing entries (rank per entry) ----
        for j in range_constexpr((E + 1 + NT - 1) // NT):
            e = tid + j * NT
            if e <= E:
                _lds_st(base, L_CNT + e, fx.Int32(0))
        fx.barrier()
        ent = []
        for i in range_constexpr(EPT):
            idx = g * (EPT * NT) + i * NT + tid
            ok = idx < n_ent
            idc = ok.select(idx, fx.Int32(0))
            e = ok.select(fx.Int32(ids[idc]), fx.Int32(E))
            ent.append((e, _lds_atomic_add(base, L_CNT + e, 1), idc, ok))
        fx.barrier()
        # Reserve each expert's range: one global atomic per (WG, expert).
        for j in range_constexpr(E_LOOP):
            e = tid + j * NT
            if e < E:
                c = _lds_ld(base, L_CNT + e)
                b = fx.Int32(0)
                if c > 0:
                    b = gatomic_add(ws + e, c)
                _lds_st(base, L_BASE + e, b)
        fx.barrier()
        if tid == 0:
            gatomic_add(ws + E, 1)  # arrive

        # ---- Q. x quant: rows [g * RPW, (g + 1) * RPW), wave w rows w, w+4, ... ----
        row0 = g * RPW
        x_rsrc = ptr_rsrc(x, tokens * (H * 2))
        a_rsrc = ptr_rsrc(a8, tokens * H)
        unit = lane % 16
        grp = lane // 16
        zero = fx.Int32(0).ir_value()
        vt4 = ir.VectorType.get([4], fx.Int32.ir_type)

        def load_row(r):
            ok = r < tokens
            rr = ok.select(r, fx.Int32(0))
            return [
                Vec(
                    rocdl.raw_ptr_buffer_load(
                        vt4,
                        x_rsrc,
                        ((rr * H + (s * 4 + grp) * 128 + unit * 8) * 2).ir_value(),
                        zero,
                        aux=rocdl_aux(0),
                    )
                )
                for s in range_constexpr(STEPS)
            ]

        def quant_row(r, local, raw):
            ok = r < tokens
            for s in range_constexpr(STEPS):
                v = Vec(raw[s].bitcast(fx.BFloat16)).to(fx.Float32)
                am = fx.absf(v[0])
                for k in range_constexpr(1, 8):
                    am = fx.maxnumf(am, fx.absf(v[k]))
                for bit in range_constexpr(4):
                    am = fx.maxnumf(am, am.shuffle_xor(1 << bit, 64))
                scale = fx.maxnumf(am, fx.Float32(1e-30)) * fx.Float32(1.0 / FP8_MAX)
                inv = fx.Float32(rocdl.rcp(T.f32, scale.ir_value()))
                words2 = []
                for h in range_constexpr(2):
                    lo = rocdl.cvt_pk_fp8_f32(
                        res=T.i32,
                        src_a=v[4 * h] * inv,
                        src_b=v[4 * h + 1] * inv,
                        old=fx.Int32(0),
                        word_sel=False,
                    )
                    words2.append(
                        fx.Int32(
                            rocdl.cvt_pk_fp8_f32(
                                res=T.i32,
                                src_a=v[4 * h + 2] * inv,
                                src_b=v[4 * h + 3] * inv,
                                old=lo,
                                word_sel=True,
                            )
                        )
                    )
                kb = s * 4 + grp
                off = (r * H + kb * 128 + unit * 8)
                rocdl.raw_ptr_buffer_store(
                    Vec.from_elements(words2, fx.Int32).ir_value(),
                    a_rsrc,
                    ok.select(off, fx.Int32(-1)).ir_value(),
                    zero,
                    aux=rocdl_aux(0),
                )
                if unit == 0:
                    _lds_st(base, L_SC + local * KB + kb, scale.bitcast(fx.Int32))

        # Two rows in flight per wave (four measured no faster).
        for it in range_constexpr(RPW // (2 * NW)):
            l0 = it * 2 * NW + wave
            l1 = l0 + NW
            r0, r1 = row0 + l0, row0 + l1
            raw0 = load_row(r0)
            raw1 = load_row(r1)
            quant_row(r0, l0, raw0)
            quant_row(r1, l1, raw1)
        fx.barrier()
        # Scales: sa[kb, row0 + i] contiguous over i.
        sa_rsrc = ptr_rsrc(sa, tokens * (KB * 4))
        for j in range_constexpr((RPW * KB + NT - 1) // NT):
            q = tid + j * NT
            i, kb = q % RPW, q // RPW
            ok = (q < RPW * KB) & (row0 + i < tokens)
            kb = ok.select(kb, fx.Int32(0))
            val = _lds_ld(base, L_SC + i * KB + kb)
            rocdl.raw_ptr_buffer_store(
                val.ir_value(),
                sa_rsrc,
                ok.select((kb * tokens + row0 + i) * 4, fx.Int32(-1)).ir_value(),
                zero,
                aux=rocdl_aux(0),
            )

        # ---- grid barrier ----
        # Poll with an atomic read (add 0 -> atomic load): a plain buffer load
        # spinning in gemm1's persistent loop hung the GPU (most likely hoisted
        # out of the loop by LLVM).
        if wave == 0:
            arrived = _scalar(gatomic_add(ws + E, 0))
            while arrived < GRID:
                arrived = _scalar(gatomic_add(ws + E, 0))
        fx.barrier()

        # ---- B. padded expert offsets: two experts per thread, block scan ----
        def gcount(e):
            ok = e < E
            c = fx.Int32(
                rocdl.raw_ptr_buffer_load(
                    T.i32,
                    ws_rsrc,
                    ok.select(e * 4, fx.Int32(-1)).ir_value(),
                    zero,
                    aux=rocdl_aux(SYS),
                )
            )
            return ok.select(c, fx.Int32(0))

        e0, e1 = tid * 2, tid * 2 + 1
        c0, c1 = gcount(e0), gcount(e1)
        p0 = (c0 + (BM - 1)) // BM * BM
        p1 = (c1 + (BM - 1)) // BM * BM
        own = p0 + p1
        inc = own
        for bit in range_constexpr(6):
            d = 1 << bit
            src = fx.Int32(lane - d)
            src = (src < 0).select(fx.Int32(0), src)
            other = fx.Int32(
                rocdl.ds_bpermute(T.i32, (src * 4).ir_value(), inc.ir_value())
            )
            inc = inc + (lane >= d).select(other, fx.Int32(0))
        if lane == 63:
            _lds_st(base, L_WT + wave, inc)
        if e0 < E:
            _lds_st(base, L_CNT + e0, c0)
        if e1 < E:
            _lds_st(base, L_CNT + e1, c1)
        fx.barrier()
        before = fx.Int32(0)
        total = fx.Int32(0)
        for w in range_constexpr(NW):
            t = _lds_ld(base, L_WT + w)
            before = before + (fx.Int32(w) < wave).select(t, fx.Int32(0))
            total = total + t
        excl = before + inc - own
        if e0 < E:
            _lds_st(base, L_OFF + e0, excl)
        if e1 < E:
            _lds_st(base, L_OFF + e1, excl + p0)
        if tid == 0:
            _lds_st(base, L_OFF + E, total)
        fx.barrier()

        # ---- C. scatter this WG's entries (+ inverse map for the TOPK reduce) ----
        for e, rank, idc, ok in ent:
            if ok:
                pos = _lds_ld(base, L_OFF + e) + _lds_ld(base, L_BASE + e) + rank
                sids[pos] = (idc // TOPK) | ((idc % TOPK) << 24)
                sw[pos] = fx.Float32(wts[idc])
                inv[idc] = pos

        # ---- D. padding rows and block expert ids of experts g, g + GRID, ... ----
        for j in range_constexpr((E + GRID - 1) // GRID):
            e = g + j * GRID
            if e < E:
                o0 = _lds_ld(base, L_OFF + e)
                o1 = _lds_ld(base, L_OFF + e + 1)
                p = o0 + _lds_ld(base, L_CNT + e) + tid
                if p < o1:
                    sids[p] = tokens | (TOPK << 24)
                    sw[p] = fx.Float32(0.0)
                if tid < (o1 - o0) // BM:
                    seids[o0 // BM + tid] = e
        if g == 0:
            if tid == 0:
                nv[0] = _lds_ld(base, L_OFF + E)
                nv[1] = tokens

        # ---- R. the last WG resets the counters (every WG has read them) ----
        fx.barrier()
        if tid == 0:
            _lds_st(base, L_FLAG, gatomic_add(ws + (E + 1), 1))
        fx.barrier()
        if _lds_ld(base, L_FLAG) == GRID - 1:
            for j in range_constexpr((E + 2 + NT - 1) // NT):
                e = tid + j * NT
                if e < E + 2:
                    gatomic_xchg(ws + e, 0)

    @flyc.jit
    def launch(
        ids: fx.Pointer,
        wts: fx.Pointer,
        x: fx.Pointer,
        sids: fx.Pointer,
        sw: fx.Pointer,
        seids: fx.Pointer,
        nv: fx.Pointer,
        a8: fx.Pointer,
        sa: fx.Pointer,
        inv: fx.Pointer,
        ws: fx.Pointer,
        tokens: fx.Int32,
        stream: fx.Stream,
    ):
        bs_prep_kernel(ids, wts, x, sids, sw, seids, nv, a8, sa, inv, ws, tokens).launch(
            grid=(GRID, 1, 1), block=(NT, 1, 1), stream=stream
        )

    return launch


_ws = {}


def bs_prep(x, topk_ids, topk_weights, num_experts, *, grid=256, nt=512, out=None):
    """-> (sorted_ids, sorted_weights, sorted_expert_ids, num_valid_ids, a8, sa, inverse).

    inverse [T, topk] int32: sorted position of (token, slot). grid WGs must all
    be resident at once (grid barrier): keep grid <= number of CUs.
    """
    tokens, H = x.shape
    topk = topk_ids.shape[1]
    E = num_experts
    dev = x.device
    assert x.dtype == torch.bfloat16 and topk_ids.dtype == torch.int32
    assert topk_weights.dtype == torch.float32
    cap = tokens * topk + E * BM - topk
    cap_blocks = (cap + BM - 1) // BM
    if out is None:
        out = (
            torch.empty(cap, dtype=torch.int32, device=dev),
            torch.empty(cap, dtype=torch.float32, device=dev),
            torch.empty(cap_blocks, dtype=torch.int32, device=dev),
            torch.empty(2, dtype=torch.int32, device=dev),
            torch.empty(tokens, H, dtype=torch.float8_e4m3fn, device=dev),
            torch.empty(H // 128, tokens, dtype=torch.float32, device=dev),
            torch.empty(tokens, topk, dtype=torch.int32, device=dev),
        )
    key = (dev, E)
    ws = _ws.get(key)
    if ws is None:
        ws = _ws[key] = torch.zeros(E + 2, dtype=torch.int32, device=dev)
    ept = (tokens * topk + grid * nt - 1) // (grid * nt)
    # rows per WG: a multiple of 2 * waves (two rows per wave per step)
    step = 2 * (nt // 64)
    rpw = ((tokens + grid - 1) // grid + step - 1) // step * step
    with torch.cuda.device(dev):
        launcher = compile_bs_prep(H, topk, E, ept, rpw, grid, nt)
        sids, sw, seids, nv, a8, sa, inv = out
        _run_compiled(
            launcher,
            _ptr(topk_ids),
            _ptr(topk_weights),
            _ptr(x),
            _ptr(sids),
            _ptr(sw),
            _ptr(seids),
            _ptr(nv),
            _ptr(a8),
            _ptr(sa),
            _ptr(inv),
            _ptr(ws),
            fx.Int32(tokens),
            fx.Stream(torch.cuda.current_stream(dev).cuda_stream),
        )
    return out

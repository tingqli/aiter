# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Persistent fused A8W4 MoE (step 3 of doc-mimo/experiments/fmoe_bm64): one CTA
per CU, each CTA walks a list of BM=64 expert blocks and runs gemm2 of block
i-1 INTERLEAVED with gemm1 of block i (one gemm2 n-tile per gemm1 K tile, mixed
per MFMA K step).

Why: in test_a8w4_fmoe_bm64 (2 CTAs/CU, gemm1 then gemm2 per CTA) the CTAs stay
phase-locked across the GPU (all start in gemm1), so the bf16x2 atomics come in
bursts and hit the ~1.5 TB/s atomic ceiling; without atomics the kernel is
20-27% faster. Interleaving spreads the atomics over the whole kernel and mixes
gemm1's MFMA/loads with gemm2's decode/epilogue VALU in one instruction stream.

Per CTA (4 waves, 1 per SIMD, waves_per_eu 1 -> up to 512 VGPR incl. AGPR):
  task 0:   gemm1(b0)                      -> quant to LDS -> A2/row data of b0
  task k:   gemm1(bk) || gemm2(b{k-1})     -> quant to LDS -> A2/row data of bk
  tail:     gemm2(b_last)
Blocks: XCD-contiguous, slot l of XCD x takes blocks b0(x) + l + k * slots_per_xcd
(same-expert blocks run concurrently on one XCD -> W from L2). Always 64 rows.
LDS: A tile / bf16 staging 16 KB + 2 fp8 halves 16 KB + scales 0.5 KB.

    python doc-mimo/kernels/test_a8w4_fmoe_bm64p.py -t 4096 8192 16384
"""

import argparse
import functools
import os
import sys

import torch

import flydsl.compiler as flyc
import flydsl.expr as fx
from flydsl.expr import const_expr, gpu, range_constexpr, rocdl
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import test_a8w4_fmoe_bm64 as F  # noqa: E402
import test_a8w4_gemm1 as G1  # noqa: E402
import test_a8w4_gemm2_bm128 as B  # noqa: E402

from aiter import dtypes  # noqa: E402
from aiter.fused_moe import moe_sorting  # noqa: E402
from aiter.ops.flydsl.kernels import buffer_ops as bo  # noqa: E402
from aiter.ops.flydsl.kernels.act import silu_mul_batch  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import _pack_activation, quantize_rows  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.utils import _global_i32_at, _udiv, _umod  # noqa: E402
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import lds_typed_ptr, lds_vec_load  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw  # noqa: E402

BM, MR = 64, 4
TILE_N1, TILE_K1, TILE_N2 = 128, 256, 128
N_REPEAT, K_STEPS, K_GROUPS = 2, 8, 2
A_LOADS = BM * TILE_K1 // (256 * 16)
LDS_A = BM * TILE_K1  # A tile, then bf16 SiLU staging (BM x 128 x 2)
LDS_H = BM * 128  # one fp8 half (BM x 128)
LDS_SC = LDS_A + 2 * LDS_H  # f32 scale [row][half]
LDS_BYTES = LDS_SC + BM * 2 * 4
NXCD = 8
TRASH_ROWS = 512  # rows past the output that padding rows' atomics land in


@functools.cache
def compile_a8w4_fmoe_bm64p(*, D_HIDDEN, D_INTER, NE, TOPK=8, b_cache_mod=1, n_slots=304):
    H, INTER = D_HIDDEN, D_INTER
    N1 = 2 * INTER
    K1_TILES = H // TILE_K1
    NT2 = H // TILE_N2
    assert INTER == 256 and NT2 == 2 * K1_TILES and K1_TILES % 2 == 0
    assert n_slots % NXCD == 0
    SPX = n_slots // NXCD  # slots per XCD
    W1_K0 = H // 128
    SC1_STRIDE = (H // 256) * 64
    W2_K0 = INTER // 128
    SC2_STRIDE = (INTER // 256) * 64
    WS2_BYTES = NE * H * (INTER // 32)
    kname = (f"a8w4_fmoe_bm64p_h{H}_i{INTER}_ne{NE}_k{TOPK}_bcm{b_cache_mod}_s{n_slots}"
             f"{'_noat' if B.NO_ATOMIC else ''}")

    def _slot(lds_ptr, arg_x, arg_xs, arg_w1, arg_ws1, arg_exp1, arg_w2, arg_ws2,
              arg_eids, arg_cumsum, arg_stids, arg_sw, arg_out, i32_M, slot):
        tx = fx.Int32(gpu.thread_id("x"))
        lane = tx % fx.Int32(64)
        wave = rocdl.readfirstlane(T.i32, tx // fx.Int32(64))
        lane_div_16 = lane // fx.Int32(16)
        lane_mod_16 = lane % fx.Int32(16)
        n_wave_base = fx.Int32(wave) * fx.Int32(32)
        mma_atom = fx.make_mma_atom(fx.rocdl.MFMA(16, 16, 32, fx.Float8E4M3FNUZ))
        lds_i32 = fx.Int32(fx.ptrtoint(lds_ptr))

        rs_x = bo.create_buffer_resource_from_addr(
            _raw(fx.Int64(arg_x)), num_records_bytes=_raw(fx.Int64(i32_M) * fx.Int64(H)))
        rs_xs = bo.create_buffer_resource_from_addr(
            _raw(fx.Int64(arg_xs)), num_records_bytes=_raw(fx.Int64(i32_M) * fx.Int64(4)))
        rs_w1, rs_ws1, rs_e1 = B._rsrc(arg_w1), B._rsrc(arg_ws1), B._rsrc(arg_exp1)
        rs_w2, rs_ws2 = B._rsrc(arg_w2), B._rsrc(arg_ws2)
        rs_e2 = bo.create_buffer_resource_from_addr(
            _raw(fx.Int64(arg_ws2) + fx.Int64(WS2_BYTES)))
        rs_sw, rs_id = B._rsrc(arg_sw), B._rsrc(arg_stids)

        def ld(rs, off_i32):
            return fx.Int32(bo.buffer_load(rs, off_i32, vec_width=1, dtype=T.i32))

        def rfl(v):
            return fx.Int32(rocdl.readfirstlane(T.i32, _raw(fx.Int32(v))))

        lds_flat = fx.make_view(fx.recast_iter(fx.Int32, lds_ptr), fx.make_layout(LDS_BYTES // 4, 1))
        lds16 = fx.logical_divide(lds_flat, fx.make_layout(4, 1))
        lds8 = fx.logical_divide(lds_flat, fx.make_layout(2, 1))
        wr_atom = fx.make_copy_atom(fx.UniversalCopy128b(), fx.Int32)
        rd_atom = fx.make_copy_atom(fx.UniversalCopy64b(), fx.Int32)
        zero4 = fx.Vector.filled(4, 0.0, fx.Float32)

        def swz(row, col_bytes):
            return col_bytes ^ ((row & fx.Int32(TILE_K1 // 16 - 1)) * fx.Int32(16))

        # ---- task list: XCD-contiguous block range, this slot's share ------------
        total_m = _global_i32_at(arg_cumsum, fx.Int32(0)) // fx.Int32(BM)
        xc = _umod(slot, NXCD)
        loc = _udiv(slot, NXCD)
        bq, br = _udiv(total_m, NXCD), _umod(total_m, NXCD)
        blk0 = xc * bq + fx.min(xc, br) + loc
        nblk = bq + (xc < br).select(fx.Int32(1), fx.Int32(0))
        ntask = (loc < nblk).select((nblk - loc + fx.Int32(SPX - 1)) // fx.Int32(SPX), fx.Int32(0))

        def m_block_of(k):
            return blk0 + k * fx.Int32(SPX)

        # ---- registers that live across runtime loops (rmem) -----------------------
        a_regs = [fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32) for _ in range(A_LOADS)]
        w_regs = {(gu, ni, g): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
                  for gu in range(2) for ni in range(N_REPEAT) for g in range(K_GROUPS)}
        s_regs = {gu: fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32) for gu in range(2)}
        acc1 = {(gu, mi, ni): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Float32)
                for gu in range(2) for mi in range(MR) for ni in range(N_REPEAT)}
        # gemm2 operand state of the previous block
        a2r = {(mi, ku): fx.make_rmem_tensor(fx.make_layout(2, 1), fx.Int32)
               for mi in range(MR) for ku in range(K_STEPS)}
        rat_r = [fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Float32) for _ in range(MR)]
        fin_r = [fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Float32) for _ in range(MR)]
        off_r = [fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32) for _ in range(MR)]
        e2_r = fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32)
        # gemm2 working set
        wb = [{
            "raw": {(ni, g): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
                    for ni in range(N_REPEAT) for g in range(K_GROUPS)},
            "packed": fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32),
            "exp": fx.make_rmem_tensor(fx.make_layout(N_REPEAT, 1), fx.Int32),
        } for _ in range(2)]
        acc2 = [[[fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Float32)
                  for _ in range(N_REPEAT)] for _ in range(MR)] for _ in range(2)]
        fn2 = [fx.make_rmem_tensor(fx.make_layout(N_REPEAT, 1), fx.Float32) for _ in range(2)]

        # ---- lane constants of the gemm2 epilogue ---------------------------------
        odd = lane & fx.Int32(1)
        is_odd = odd == fx.Int32(1)
        col_b = (odd * fx.Int32(16) + lane_mod_16 - odd) * fx.Int32(2)
        sel_pair = is_odd.select(fx.Int32(0x03020706), fx.Int32(0x05040100))

        # =========================== gemm2 (previous block) ===========================
        def issue_w2(t, b):
            e2 = rfl(Vec(e2_r.load())[0])
            n0 = e2 * fx.Int32(H) + t * fx.Int32(TILE_N2) + n_wave_base
            for ni in range_constexpr(N_REPEAT):
                wbase = ((n0 + fx.Int32(ni * 16)) // fx.Int32(16)) * fx.Int32(W2_K0 * 64) \
                    + lane_div_16 * fx.Int32(16) + lane_mod_16
                for g in range_constexpr(K_GROUPS):
                    wb[b]["raw"][ni, g].store(Vec(bo.buffer_load(
                        rs_w2, (wbase + fx.Int32(g * 64)) * fx.Int32(4), vec_width=4,
                        dtype=T.i32, cache_modifier=b_cache_mod)))
            scb = (n0 // fx.Int32(32)) * fx.Int32(SC2_STRIDE) + lane_div_16 * fx.Int32(16) \
                + lane_mod_16
            wb[b]["packed"].store(Vec.from_elements([ld(rs_ws2, scb)], fx.Int32))
            wb[b]["exp"].store(Vec.from_elements(
                [ld(rs_e2, n0 + fx.Int32(ni * 16) + lane_mod_16) for ni in range(N_REPEAT)],
                fx.Int32))

        def epilogue_mi(s, t_prev, mi, ks):
            """Atomics of tile t_prev (acc set s), row block mi, rows ks. Branch-free:
            padding rows add into trash rows past the output."""
            fn = Vec(fn2[s].load())
            acc_a = Vec(acc2[s][mi][0].load())
            acc_b = Vec(acc2[s][mi][1].load())
            fin = Vec(fin_r[mi].load())
            offs = Vec(off_r[mi].load())
            datas = []
            for k in ks:
                r0 = F._rnu_hi(acc_a[k] * (fin[k] * fn[0]))
                r1 = F._rnu_hi(acc_b[k] * (fin[k] * fn[1]))
                pk = G1._perm_u32(r1, r0, 0x07060302)
                nbr = fx.Int32(rocdl.update_dpp(T.i32, _raw(pk.bitcast(fx.Int32)),
                                                _raw(pk.bitcast(fx.Int32)),
                                                B.DPP_QUAD_SWAP, 0xF, 0xF, True))
                datas.append(_raw(G1._perm_u32(nbr, pk, sel_pair).bitcast(fx.Int32)))
            col = (t_prev * fx.Int32(TILE_N2) + n_wave_base) * fx.Int32(2)
            F._atomics4_saddr(datas, [_raw(fx.Int32(offs[k]) + col) for k in ks], arg_out)

        def g2_setup(t, s, b):
            """Start n-tile t (acc set s, W buffer b): prefetch tile t+1 (clamped) into
            buffer 1-b, decode tables, zero acc; returns (raw, luts) for g2_ku."""
            issue_w2(fx.min(t + fx.Int32(1), fx.Int32(NT2 - 1)), 1 - b)
            raw = {k: [fx.Int32(Vec(r.load())[j]) for j in range(4)]
                   for k, r in wb[b]["raw"].items()}
            p = fx.Int32(Vec(wb[b]["packed"].load())[0])
            ex = Vec(wb[b]["exp"].load())
            fn2[s].store(Vec.from_elements(
                [G1._channel_factor(fx.Int32(ex[ni])) for ni in range(N_REPEAT)], fx.Float32))
            luts = [[G1._fp8_lut_predelta(G1._perm_u32(p, p, ((g % 2) * 2 + ni) * 0x01010101))
                     for g in range(K_GROUPS)] for ni in range(N_REPEAT)]
            for mi in range_constexpr(MR):
                for ni in range_constexpr(N_REPEAT):
                    acc2[s][mi][ni].store(zero4)
            return raw, luts

        def g2_ku(st, t, s, ku):
            """K step ku of tile t (set s) + 1/8 of tile t-1's epilogue (set 1-s; for
            t = 0 that set was zeroed and adds 0 to tile 0)."""
            raw, luts = st
            if const_expr(ku == 4):  # acc = acc0 * s0/s1, then K group 1
                for mi in range_constexpr(MR):
                    rat = Vec(rat_r[mi].load())
                    for ni in range_constexpr(N_REPEAT):
                        a4 = Vec(acc2[s][mi][ni].load())
                        acc2[s][mi][ni].store(Vec.from_elements(
                            [a4[v] * rat[v] for v in range(4)], fx.Float32))
            b8s = [G1._fp4x8_to_fp8x8_fast(raw[ni, ku // 4][ku % 4], luts[ni][ku // 4])
                   for ni in range(N_REPEAT)]
            for mi in range_constexpr(MR):
                a8 = Vec(a2r[mi, ku].load()).bitcast(fx.Float8E4M3FNUZ)
                for ni in range_constexpr(N_REPEAT):
                    G1._mma_fp8(mma_atom, acc2[s][mi][ni], a8, b8s[ni])
            per = MR * 4 // K_STEPS
            u0 = ku * per
            epilogue_mi(1 - s, fx.max(t - fx.Int32(1), fx.Int32(0)), u0 // 4,
                        tuple(u % 4 for u in range(u0, u0 + per)))

        def g2_zero_prev():
            for mi in range_constexpr(MR):
                for ni in range_constexpr(N_REPEAT):
                    acc2[1][mi][ni].store(zero4)

        def g2_flush():
            """Epilogue of the last n-tile (set 1)."""
            for mi in range_constexpr(MR):
                epilogue_mi(1, fx.Int32(NT2 - 1), mi, (0, 1, 2, 3))

        def g2_alone():
            """gemm2 of the previous block with no gemm1 to overlap (tail)."""
            issue_w2(fx.Int32(0), 0)
            g2_zero_prev()

            @flyc.jit
            def _loop(p_first):
                for p in range(NT2 // 2):
                    for kk in range_constexpr(2):
                        t = (p_first + fx.Int32(p)) * fx.Int32(2) + fx.Int32(kk)
                        rocdl.sched_barrier(0)
                        st = g2_setup(t, kk, kk)
                        for ku in range_constexpr(K_STEPS):
                            g2_ku(st, t, kk, ku)

            _loop(fx.Int32(0))
            g2_flush()

        # ============================== gemm1 (block k) ===============================
        def gemm1_task(m_block, inter):
            """gemm1 + SiLU + fp8 quant of m_block into the two LDS halves; with
            ``inter`` the previous block's 32 gemm2 n-tiles ride along (tile q =
            nb * K1_TILES + kt with K tile kt of half nb)."""
            e = rfl(_global_i32_at(arg_eids, m_block))
            m_row = m_block * fx.Int32(BM)
            a_src, a_dst = [], []
            for i in range_constexpr(A_LOADS):
                idx_dw = tx * fx.Int32(4) + fx.Int32(i * 256 * 4)
                row = idx_dw // fx.Int32(TILE_K1 // 4)
                cb = (idx_dw % fx.Int32(TILE_K1 // 4)) * fx.Int32(4)
                tok = ld(rs_id, m_row + row) & fx.Int32(0x00FFFFFF)
                a_src.append((tok * fx.Int32(H) + swz(row, cb)) // fx.Int32(4))
                a_dst.append((row * fx.Int32(TILE_K1) + cb) // fx.Int32(16))
            xs = []
            for mi in range_constexpr(MR):
                for ii in range_constexpr(4):
                    tok = ld(rs_id, m_row + fx.Int32(mi * 16 + ii) + lane_div_16 * fx.Int32(4)) \
                        & fx.Int32(0x00FFFFFF)
                    xs.append(ld(rs_xs, tok).bitcast(fx.Float32))

            def load_a_one(i, base_k):
                a_regs[i].store(Vec(bo.buffer_load(
                    rs_x, a_src[i] + base_k // fx.Int32(4), vec_width=4, dtype=T.i32)))

            def store_a_lds():
                for i in range_constexpr(A_LOADS):
                    fx.copy(wr_atom, a_regs[i], fx.slice(lds16, (None, a_dst[i])))

            def load_a(mi, ku):
                row = lane_mod_16 + fx.Int32(mi * 16)
                col = lane_div_16 * fx.Int32(32) + fx.Int32((ku // 4) * 128 + (ku % 4) * 8)
                off = (row * fx.Int32(TILE_K1) + swz(row, col)) // fx.Int32(8)
                r = fx.make_rmem_tensor(fx.make_layout(2, 1), fx.Int32)
                fx.copy_atom_call(rd_atom, fx.slice(lds8, (None, off)), r)
                return fx.Vector(fx.memref_load_vec(r)).bitcast(fx.Float8E4M3FNUZ)

            @flyc.jit
            def _halves(nb_first):
                for nb_ in range(2):
                    nb = nb_first + fx.Int32(nb_)
                    half(nb)

            def half(nb):
                w1_base, sc1_base, n_cols = {}, {}, []
                for ni in range_constexpr(N_REPEAT):
                    n_local = nb * fx.Int32(TILE_N1) + fx.Int32(ni * 16) + n_wave_base
                    n_cols.append(n_local + lane_mod_16)
                    for gu in range_constexpr(2):
                        n0 = e * fx.Int32(N1) + n_local + fx.Int32(gu * INTER)
                        w1_base[gu, ni] = (n0 // fx.Int32(16)) * fx.Int32(W1_K0 * 64) \
                            + lane_div_16 * fx.Int32(16) + lane_mod_16
                        if ni == 0:
                            sc1_base[gu] = (n0 // fx.Int32(32)) * fx.Int32(SC1_STRIDE) \
                                + lane_div_16 * fx.Int32(16) + lane_mod_16

                def load_s(base_k):
                    for gu in range_constexpr(2):
                        s_regs[gu].store(Vec.from_elements([ld(
                            rs_ws1, sc1_base[gu] + (base_k // fx.Int32(256)) * fx.Int32(64))],
                            fx.Int32))

                def load_w_one(gu, ni, g, base_k):
                    idx = w1_base[gu, ni] + (base_k // fx.Int32(128) + fx.Int32(g)) * fx.Int32(64)
                    w_regs[gu, ni, g].store(Vec(bo.buffer_load(
                        rs_w1, idx * fx.Int32(4), vec_width=4, dtype=T.i32,
                        cache_modifier=b_cache_mod)))

                w_items = [(gu, ni) for gu in range(2) for ni in range(N_REPEAT)]

                def k_tile(kt, kk):
                    """K tile kt (A in LDS, W in w_regs) + prefetch of tile min(kt+1, last)
                    spread over the K steps; gemm2 tile nb*K1_TILES + kt (set kk)."""
                    nxt = fx.min(kt + fx.Int32(1), fx.Int32(K1_TILES - 1)) * fx.Int32(TILE_K1)
                    luts = {}
                    for gu in range_constexpr(2):
                        p = fx.Int32(Vec(s_regs[gu].load())[0])
                        for ni in range_constexpr(N_REPEAT):
                            for g in range_constexpr(K_GROUPS):
                                luts[gu, ni, g] = G1._fp8_lut_predelta(
                                    G1._perm_u32(p, p, ((g % 2) * 2 + ni) * 0x01010101))
                    load_s(nxt)
                    if const_expr(inter):
                        t2 = nb * fx.Int32(K1_TILES) + kt
                        st2 = g2_setup(t2, kk, kk)
                    for ku in range_constexpr(K_STEPS):
                        g, j = ku // 4, ku % 4
                        bs = {(gu, ni): G1._fp4x8_to_fp8x8_fast(
                            fx.Int32(Vec(w_regs[gu, ni, g].load())[j]), luts[gu, ni, g])
                            for gu in range(2) for ni in range(N_REPEAT)}
                        for mi in range_constexpr(MR):
                            a8 = load_a(mi, ku)
                            for ni in range_constexpr(N_REPEAT):
                                for gu in range_constexpr(2):
                                    G1._mma_fp8(mma_atom, acc1[gu, mi, ni], a8, bs[gu, ni])
                        if const_expr(ku < A_LOADS):
                            load_a_one(ku, nxt)
                        if const_expr(ku >= K_STEPS - len(w_items)):
                            gu_, ni_ = w_items[ku - (K_STEPS - len(w_items))]
                            load_w_one(gu_, ni_, 0, nxt)
                        if const_expr(inter):
                            g2_ku(st2, t2, kk, ku)
                    for gu_, ni_ in w_items:
                        load_w_one(gu_, ni_, 1, nxt)

                # ---- K loop -------------------------------------------------------------
                for a in acc1.values():
                    a.store(zero4)
                for i in range_constexpr(A_LOADS):
                    load_a_one(i, fx.Int32(0))
                load_s(fx.Int32(0))
                for (gu, ni, g) in w_regs:
                    load_w_one(gu, ni, g, fx.Int32(0))
                store_a_lds()

                @flyc.jit
                def _k_loop(p_first):
                    for p in range(K1_TILES // 2):
                        for kk in range_constexpr(2):
                            kt = (p_first + fx.Int32(p)) * fx.Int32(2) + fx.Int32(kk)
                            rocdl.s_waitcnt(lgkmcnt=0)
                            gpu.barrier()  # A(kt) visible
                            k_tile(kt, kk)
                            gpu.barrier()  # A(kt) reads done
                            store_a_lds()

                _k_loop(fx.Int32(0))
                rocdl.s_waitcnt(lgkmcnt=0)
                gpu.barrier()  # last (redundant) A store done: A slot -> bf16 staging

                # ---- dequant -> SiLU -> bf16 staging [rows, 128] ------------------------
                f_g = [G1._channel_factor(ld(rs_e1, e * fx.Int32(N1) + c)) for c in n_cols]
                f_u = [G1._channel_factor(ld(rs_e1, e * fx.Int32(N1) + fx.Int32(INTER) + c))
                       for c in n_cols]
                stg = lds_typed_ptr(lds_i32, T.bf16)
                for mi in range_constexpr(MR):
                    ag = [Vec(acc1[0, mi, ni].load()) for ni in range(N_REPEAT)]
                    au = [Vec(acc1[1, mi, ni].load()) for ni in range(N_REPEAT)]
                    for ii in range_constexpr(4):
                        rsc = xs[mi * 4 + ii]
                        row = fx.Int32(mi * 16 + ii) + lane_div_16 * fx.Int32(4)
                        for ni in range_constexpr(N_REPEAT):
                            y = silu_mul_batch([ag[ni][ii] * (rsc * f_g[ni])],
                                               [au[ni][ii] * (rsc * f_u[ni])])[0]
                            col = n_wave_base + fx.Int32(ni * 16) + lane_mod_16
                            stg[row * fx.Int32(TILE_N1) + col] = y.to(fx.BFloat16)
                gpu.barrier()

                # ---- per-(row, 128) fp8 quant -> LDS half nb (swizzled) + scale -----------
                r_in = tx // fx.Int32(8)
                sub = tx % fx.Int32(8)
                sc_f = lds_typed_ptr(lds_i32 + fx.Int32(LDS_SC), T.f32)
                for pp in range_constexpr(BM // 32):
                    row = fx.Int32(pp * 32) + r_in
                    vals = []
                    for h in range_constexpr(2):
                        v = Vec(lds_vec_load(
                            lds_i32, (row * fx.Int32(TILE_N1) + sub * fx.Int32(16)) * fx.Int32(2)
                            + fx.Int32(h * 16), Vec.make_type(8, fx.BFloat16), fx.BFloat16,
                            align=16)).to(fx.Float32)
                        vals.extend(v[k] for k in range(8))
                    amax = fx.Float32(0.0)
                    for k in range_constexpr(16):
                        amax = fx.max(amax, fx.max(vals[k], -vals[k]))
                    for bit in range_constexpr(3):
                        amax = fx.max(amax, amax.shuffle_xor(1 << bit, 64))
                    s = (amax == 0.0).select(fx.Float32(1.0), amax / 240.0)
                    inv = 1.0 / s
                    packed = Vec.from_elements(
                        [_pack_activation(*[vals[4 * q + k] * inv for k in range(4)])
                         for q in range(4)], fx.Int32)
                    dst = (row * fx.Int32(128) + ((sub ^ (row & fx.Int32(7))) * fx.Int32(16))) \
                        // fx.Int32(16)
                    r = fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
                    r.store(packed)
                    fx.copy(wr_atom, r, fx.slice(
                        lds16, (None, fx.Int32(LDS_A // 16) + nb * fx.Int32(LDS_H // 16) + dst)))
                    sc_f[row * fx.Int32(2) + nb] = s  # 8 lanes, same value
                rocdl.s_waitcnt(lgkmcnt=0)
                gpu.barrier()

            if const_expr(inter):
                issue_w2(fx.Int32(0), 0)  # previous block's first n-tile
                g2_zero_prev()
            _halves(fx.Int32(0))
            if const_expr(inter):
                g2_flush()
            # ---- this block becomes the gemm2 operand: A2 fragments + row data --------
            for nb in range_constexpr(2):
                for mi in range_constexpr(MR):
                    row = lane_mod_16 + fx.Int32(mi * 16)
                    for jj in range_constexpr(4):
                        col = lane_div_16 * fx.Int32(32) + fx.Int32(jj * 8)
                        byte = row * fx.Int32(128) + (((col // fx.Int32(16)) ^ (row & fx.Int32(7)))
                                                      * fx.Int32(16)) + col % fx.Int32(16)
                        fx.copy_atom_call(rd_atom, fx.slice(
                            lds8, (None, (fx.Int32(LDS_A + nb * LDS_H) + byte) // fx.Int32(8))),
                            a2r[mi, nb * 4 + jj])
            sc_f = lds_typed_ptr(lds_i32 + fx.Int32(LDS_SC), T.f32)
            s0 = sc_f[lane * fx.Int32(2)]
            s1 = sc_f[lane * fx.Int32(2) + fx.Int32(1)]
            s1 = (s1 == fx.Float32(0.0)).select(fx.Float32(1.0), s1)
            w_r = ld(rs_sw, m_row + lane).bitcast(fx.Float32)
            ratio_l = (s0 / s1).bitcast(fx.Int32)
            id_l = ld(rs_id, m_row + lane)
            valid_l = (id_l & fx.Int32(0x00FFFFFF)) < i32_M
            fin_l = valid_l.select(s1 * w_r, fx.Float32(0.0)).bitcast(fx.Int32)

            def fetch(q, row_static):
                src = fx.Int32(row_static) + lane_div_16 * fx.Int32(4)
                return fx.Int32(rocdl.ds_bpermute(T.i32, src * fx.Int32(4), q))

            for mi in range_constexpr(MR):
                rr, ff, oo = [], [], []
                for v in range_constexpr(4):
                    rr.append(fetch(ratio_l, mi * 16 + v).bitcast(fx.Float32))
                    ff.append(fetch(fin_l, mi * 16 + v).bitcast(fx.Float32))
                    tok = fetch(id_l, mi * 16 + v) & fx.Int32(0x00FFFFFF)
                    # padding rows -> trash row M + (block row index mod TRASH_ROWS)
                    trash = i32_M + ((m_row + fx.Int32(mi * 16 + v) + lane_div_16 * fx.Int32(4))
                                     & fx.Int32(TRASH_ROWS - 1))
                    oo.append((tok < i32_M).select(tok, trash) * fx.Int32(H * 2) + col_b)
                rat_r[mi].store(Vec.from_elements(rr, fx.Float32))
                fin_r[mi].store(Vec.from_elements(ff, fx.Float32))
                off_r[mi].store(Vec.from_elements(oo, fx.Int32))

            e2_r.store(Vec.from_elements([e], fx.Int32))
            gpu.barrier()  # LDS halves read before the next block's gemm1 reuses them

        # ================================ schedule ====================================
        @flyc.jit
        def _first():
            if ntask > fx.Int32(0):
                gemm1_task(m_block_of(fx.Int32(0)), False)

        @flyc.jit
        def _steady():
            for k in range(fx.Int32(1), ntask, fx.Int32(1)):
                gemm1_task(m_block_of(k), True)

        @flyc.jit
        def _tail():
            if ntask > fx.Int32(0):
                g2_alone()

        _first()
        _steady()
        _tail()

    @fx.struct
    class SharedStorage:
        raw: fx.Array[fx.Uint8, LDS_BYTES, 16]

    @flyc.kernel(name=kname, known_block_size=[256, 1, 1])
    def kernel(arg_x: fx.Int64, arg_xs: fx.Int64, arg_w1: fx.Int64, arg_ws1: fx.Int64,
               arg_exp1: fx.Int64, arg_w2: fx.Int64, arg_ws2: fx.Int64, arg_eids: fx.Int64,
               arg_cumsum: fx.Int64, arg_stids: fx.Int64, arg_sw: fx.Int64,
               arg_out: fx.Int64, i32_M: fx.Int32):
        lds_ptr = fx.SharedAllocator().allocate(SharedStorage).peek().raw.ptr
        _slot(lds_ptr, arg_x, arg_xs, arg_w1, arg_ws1, arg_exp1, arg_w2, arg_ws2, arg_eids,
              arg_cumsum, arg_stids, arg_sw, arg_out, i32_M, fx.Int32(gpu.block_id("x")))

    @flyc.jit
    def launch(arg_x: fx.Int64, arg_xs: fx.Int64, arg_w1: fx.Int64, arg_ws1: fx.Int64,
               arg_exp1: fx.Int64, arg_w2: fx.Int64, arg_ws2: fx.Int64, arg_eids: fx.Int64,
               arg_cumsum: fx.Int64, arg_stids: fx.Int64, arg_sw: fx.Int64,
               arg_out: fx.Int64, i32_M: fx.Int32, stream: fx.Stream):
        kernel(arg_x, arg_xs, arg_w1, arg_ws1, arg_exp1, arg_w2, arg_ws2, arg_eids,
               arg_cumsum, arg_stids, arg_sw, arg_out, i32_M,
               value_attrs={"rocdl.waves_per_eu": 1},
               ).launch(grid=(n_slots, 1, 1), block=(256, 1, 1), stream=stream)

    return launch


def a8w4_fmoe_bm64p(x_fp8, x_scale, weights, sorted_ids, sorted_weights,
                    sorted_expert_ids, num_valid_ids, out, *, topk=8, b_cache_mod=1,
                    n_slots=None):
    """Persistent fused stage1 + stage2 (same inputs as test_a8w4_fmoe_bm64.a8w4_fmoe_bm64)."""
    assert weights["w1_fast_dec"] == 2 and weights["w2_fast_dec"] == 2
    tokens, model_dim = out.shape
    E = weights["w2"].shape[0]
    if n_slots is None:
        n_slots = torch.cuda.get_device_properties(out.device).multi_processor_count
    launch = compile_a8w4_fmoe_bm64p(
        D_HIDDEN=model_dim, D_INTER=weights["w1"].shape[1] // 2, NE=E, TOPK=topk,
        b_cache_mod=b_cache_mod, n_slots=n_slots)
    _run_compiled(
        launch, x_fp8.data_ptr(), x_scale.data_ptr(), weights["w1"].data_ptr(),
        weights["w1_scale"].data_ptr(), weights["w1_exp"].data_ptr(),
        weights["w2"].data_ptr(), weights["w2_scale"].data_ptr(),
        sorted_expert_ids.data_ptr(), num_valid_ids.data_ptr(), sorted_ids.data_ptr(),
        sorted_weights.data_ptr(), out.data_ptr(), int(tokens), torch.cuda.current_stream())
    return out


def fused_moe_a8w4_bm64p(x, weights, topk_weights, topk_ids, **kw):
    E, model_dim, _ = weights["w2"].shape
    tokens = x.shape[0]
    # the kernel needs TRASH_ROWS writable rows after the output (padding rows' atomics)
    buf = torch.empty((tokens + TRASH_ROWS, model_dim), dtype=dtypes.bf16, device=x.device)
    sids, sw, seids, nv, moe_buf = moe_sorting(topk_ids, topk_weights, E, model_dim,
                                               dtypes.bf16, BM, output=buf[:tokens])[:5]
    assert moe_buf.data_ptr() == buf.data_ptr()
    x8, xs = quantize_rows(x)
    return a8w4_fmoe_bm64p(x8, xs, weights, sids, sw, seids, nv, moe_buf,
                           topk=topk_ids.shape[1], **kw)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="*", default=[2048, 4096, 8192, 16384])
    p.add_argument("--reps", type=int, default=3)
    p.add_argument("--no_bm64", action="store_true", help="skip the non-persistent kernel")
    args = p.parse_args()

    import test_flydsl_moe_a16wfp4 as M
    from aiter import QuantType, get_torch_quant
    from aiter.fused_moe import fused_topk
    from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4

    E, MD, INTER, TOPK = 256, 4096, 256, 8
    torch.manual_seed(0)
    w1 = torch.randn((E, INTER * 2, MD), dtype=dtypes.bf16, device="cuda")
    w2 = torch.randn((E, MD, INTER), dtype=dtypes.bf16, device="cuda")
    tq = get_torch_quant(QuantType.per_1x32)
    w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
    w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
    del w1, w2
    W = M.a8w4_prepare_weights(
        shuffle_weight_a16w4(w1q.view(E, INTER * 2, MD // 2), 16, False),
        shuffle_weight_a16w4(w2q.view(E, MD, INTER // 2), 16, False),
        shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False), fast_dec=2)

    def timed(fn):
        runs = sorted((F._profile(fn) for _ in range(args.reps)), key=lambda r: r["total"])
        return runs[len(runs) // 2]

    for tok in args.t:
        x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
        tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"), TOPK, True)
        two = lambda: M.a8w4_fused_moe(x, W, tw, ti, block_m=64, fuse_quant=True)  # noqa: E731
        o2 = two().float().clone()
        t2 = timed(two)
        line = [f"tok {tok:6d}: 2-kernel {t2['total']:7.1f} us"]
        cands = [("bm64p", lambda: fused_moe_a8w4_bm64p(x, W, tw, ti))]
        if not args.no_bm64:
            cands.insert(0, ("bm64 ", lambda: F.fused_moe_a8w4_bm64(x, W, tw, ti)))
        for name, fn in cands:
            try:
                o = fn().float().clone()
                tf = timed(fn)
                c = G1._cos_diff(o2, o)
                kern = sum(v for k, v in tf.items() if k in ("fused", "other"))
                line.append(f"{name} {tf['total']:7.1f} us (kernel {kern:6.1f}) "
                            f"{t2['total'] / tf['total']:.2f}x  cos {c:.1e}{'' if c < 1e-4 else ' BAD'}")
            except Exception as ex:  # noqa: BLE001
                line.append(f"{name} FAIL {type(ex).__name__}: {str(ex)[:400]}")
        print("\n   ".join(line), flush=True)


if __name__ == "__main__":
    main()

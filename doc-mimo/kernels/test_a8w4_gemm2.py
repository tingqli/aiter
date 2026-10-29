# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Standalone A8W4 MoE stage2 (down-proj GEMM + routed atomic scatter) FlyDSL kernel
for gfx942.

Extracted from the a16w4 port (``moe_2stage_a16wmix/gemm2.py``, ``a_dtype="fp8r"``)
with only the configuration the tuned A8W4 build actually runs
(``flydsl_moe2_afp8r_wfp4_bf16_t{BM}x{TN}x{TK}_atomic[_bnt*][_xcd*][_ftz]``):

  * A  : FP8-FNUZ row-quantized stage1 intermediate ``[sorted_size, inter_dim]``
         (by SORTED position) + f32 per-sorted-row scale
  * W2 : mxfp4 (E2M1 + per-1x32 E8M0) ``[E, model_dim, inter_dim/2]``, standard
         N-major preshuffle
  * per-output-channel max E8M0 exponent derived in-kernel from the W2 scales
  * MFMA(16,16,32,fp8) with fp4 -> fp8 decode through a per-32K-group byte LUT
    (+ a sign-mask LUT, so FNUZ -0 never needs a per-fragment fix-up)
  * K (= inter_dim) loop unrolled, XOR-swizzled A-LDS, 4 waves split TILE_N
  * ``dyn_rows``: per-WG runtime skip of all-padding 16-row sub-blocks
  * epilogue: acc * a_scale[row] * 2**(exp-132) * route_weight -> bf16 LDS tile
    (half the port's f32 staging) -> packed bf16x2 global atomic add into
    ``[tokens, model_dim]``

Run:
    pytest op_tests/test_a8w4_gemm2.py -q
    python op_tests/test_a8w4_gemm2.py -t 512 -s 4096,256,256,8
"""

import argparse
import functools
import itertools

import flydsl.compiler as flyc
import flydsl.expr as fx
import pandas as pd
import pytest
import torch
from flydsl._mlir.dialects import llvm
from flydsl.expr import const_expr, gpu, range_constexpr, rocdl
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

import aiter
from aiter import QuantType, dtypes
from aiter.fused_moe import fused_topk, moe_sorting
from aiter.jit.utils.chip_info import get_gfx
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix import flydsl_a16w4_gemm2
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.utils import (
    _buffer_i32_scalar_read,
    _global_i32_at,
    _udiv,
    _umod,
)
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import (
    _gep1,
    _global_base_ptr1,
    _global_i32_buffer_tiles,
    _global_i32_buffer_view,
    global_typed_ptr,
    lds_typed_ptr,
    lds_vec_load,
)
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
from aiter.test_common import benchmark, checkAllclose, run_perftest
from aiter.utility import fp4_utils

SUPPORTED_GFX = ["gfx942"]  # FP8-FNUZ MFMA + global bf16x2 atomics
TOL_ERR_RATIO = 0.05
ROUTINGS = ["uniform", "hot"]
# "hot" routing: 1/32 of the experts get this score bias, so they land in most
# tokens' top-k (a few experts own a large share of the routed rows).
HOT_EXPERT_DIV = 32
HOT_EXPERT_BIAS = 2.0


# =============================================================================
# Device helpers: fp4 -> fp8 decode, channel factor, MFMA (same as test_a8w4_gemm1)
# =============================================================================
#
# W stays E2M1/E8M0. Output channel n is normalized by 2**(max_exp[n]-127-5)
# (``_channel_factor``, applied in the epilogue); per 32-K group the remaining
# 2**(5-delta), delta = max_exp - group_exp, is folded into an 8-entry
# E2M1-magnitude -> FP8-FNUZ byte table (``_fp8_lut``) so each nibble decodes with
# one v_perm.


def _perm_u32(hi, lo, sel):
    return fx.Uint32(
        rocdl.perm_b32(
            fx.Uint32(hi).ir_value(), fx.Uint32(lo).ir_value(), fx.Uint32(sel).ir_value()
        )
    )


def _fp8_lut(group_code, max_code, flush_tiny):
    """8-entry ``|E2M1| * 2**(5-delta)`` -> FP8-FNUZ byte table.

    Returns ``(lo, hi, sign_lo, sign_hi)``: the magnitude table plus a same-shaped
    mask holding 0x80 for every non-zero entry (FNUZ has no -0; 0x80 is NaN).
    """
    difference = max_code - group_code
    delta = fx.min(difference, 11).to(fx.Uint32) * fx.Uint32(0x08080808)
    lo = (fx.Uint32(0x6C686080) - delta) & fx.Uint32(0xFFFFFF00)
    hi = fx.Uint32(0x7C787470) - delta
    if const_expr(flush_tiny):
        # Approximation: drop groups < 2**-11 of this channel's largest scale.
        lo = (difference > 11).select(fx.Uint32(0), lo)
        hi = (difference > 11).select(fx.Uint32(0), hi)
    else:
        for diff, low, high in (
            (12, 0x0C080400, 0x1C181410),
            (13, 0x06040200, 0x14100C08),
            (14, 0x03020100, 0x0C080604),
            (15, 0x02010000, 0x06040302),
            (16, 0x01000000, 0x03020201),
            (17, 0, 0x02010100),
            (18, 0, 0x01000000),
        ):
            lo = (difference == diff).select(fx.Uint32(low), lo)
            hi = (difference == diff).select(fx.Uint32(high), hi)
        lo = (difference >= 19).select(fx.Uint32(0), lo)
        hi = (difference >= 19).select(fx.Uint32(0), hi)
    # Entries are <= 0x7C, so +0x7F sets bit 7 exactly for non-zero bytes (no carry).
    sign_lo = (lo + fx.Uint32(0x7F7F7F7F)) & fx.Uint32(0x80808080)
    sign_hi = (hi + fx.Uint32(0x7F7F7F7F)) & fx.Uint32(0x80808080)
    return lo, hi, sign_lo, sign_hi


def _fp4x8_to_fp8x8(raw, lut):
    """Eight consecutive FP4 nibbles (one i32) -> v8 FP8-FNUZ MFMA operand."""
    raw = fx.Uint32(raw)
    lo, hi, sign_lo, sign_hi = lut
    sel_even = raw & 0x07070707  # magnitudes of nibbles 0,2,4,6
    sel_odd = (raw >> 4) & 0x07070707  # magnitudes of nibbles 1,3,5,7
    # byte = |value| | (nibble sign & 0x80-if-non-zero)
    even = (_perm_u32(sign_hi, sign_lo, sel_even) & (raw << 4)) | _perm_u32(
        hi, lo, sel_even
    )
    odd = (_perm_u32(sign_hi, sign_lo, sel_odd) & raw) | _perm_u32(hi, lo, sel_odd)
    lo32 = _perm_u32(odd, even, 0x05010400).bitcast(fx.Int32)
    hi32 = _perm_u32(odd, even, 0x07030602).bitcast(fx.Int32)
    return fx.Vector.from_elements([lo32, hi32], fx.Int32).bitcast(fx.Float8E4M3FNUZ)


def _channel_factor(exponent):
    """2**(exponent-127-5) as f32 (subnormal-safe)."""
    normal = ((exponent - 5).to(fx.Uint32) << 23).bitcast(fx.Float32)
    subnormal = (fx.Uint32(1) << (exponent + 17).to(fx.Uint32)).bitcast(fx.Float32)
    return (exponent >= 6).select(normal, subnormal)


def _fp8_frag8(v8):
    t = fx.make_rmem_tensor(fx.make_layout(8, 1), fx.Float8E4M3FNUZ)
    t.store(v8)
    return t


def _mma_fp8(mma_atom, acc, a8, b8):
    """acc += A(16x32) * B(32x16), one MFMA(16,16,32,fp8 FNUZ)."""
    fx.gemm(mma_atom, acc, _fp8_frag8(a8), _fp8_frag8(b8), acc)


# =============================================================================
# Epilogue: routing-weighted bf16x2 global atomic scatter (gfx942)
# =============================================================================


def _flat_buffer(arg, elem_ty, align):
    ptr = global_typed_ptr(arg, elem_ty, align=align)
    view = fx.Tensor(fx.make_view(ptr, fx.make_layout((1, 1), (1, 1))))
    return fx.rocdl.make_buffer_tensor(view, max_size=True)


def _atomic_add_bf16x2(out_base, elem_off, lo, hi):
    """``out[elem_off : elem_off+2] += (lo, hi)`` as one global_atomic_pk_add_bf16."""
    pk = Vec.from_elements([lo, hi], fx.Float32).to(fx.BFloat16)
    llvm.AtomicRMWOp(
        llvm.AtomicBinOp.fadd,
        _gep1(out_base, elem_off * fx.Int32(2)),
        _raw(pk),
        llvm.AtomicOrdering.monotonic,
        syncscope="agent",
        alignment=4,
    )


# @flyc.jit is LOAD-BEARING (both epilogues): it AST-rewrites ``if token < i32_M``
# into an scf.if. As a plain function the guard would run as a Python if (dropped at
# trace), so the atomic adds would fire on padding rows.
@flyc.jit
def _direct_atomic_epilog(
    accm, arg_out, arg_stids, arg_sweights, m_row, col0, lane, i32_M, N_OUT
):
    """LDS-free scatter straight from the MFMA accumulator layout.

    MFMA 16x16 acc: lane L holds column L%16 of rows (L//16)*4 + v, v = 0..3. Lane
    pair (L, L^1) owns two adjacent columns, so one ``shuffle_xor(1)`` per value
    lets the even lane emit rows v=0,1 and the odd lane rows v=2,3 as bf16x2
    (even col, odd col) atomics: all lanes busy, no LDS staging, no barrier.
    ``accm[mi][ni]`` is already dequantized; ``col0`` is this lane's column for
    ni = 0 (adjacent N blocks are 16 columns apart).
    """
    lane_div_16 = lane // fx.Int32(16)
    odd = lane & fx.Int32(1)
    is_odd = odd == fx.Int32(1)
    stids = _flat_buffer(arg_stids, T.i32, 4)
    sweights = _flat_buffer(arg_sweights, T.f32, 4)
    load_i32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
    load_f32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Float32)
    out_base = _global_base_ptr1(arg_out)
    col_even = col0 - odd

    def load_scalar(atom, src, index, elem_ty):
        frag = fx.make_rmem_tensor(1, elem_ty)
        fx.copy(atom, src[None, index], frag)
        return Vec(frag.load())[0]

    for mi in range_constexpr(len(accm)):
        # This lane's two output rows of the 16-row block: even lane v=0,1, odd v=2,3.
        rows = [
            m_row + fx.Int32(mi * 16 + k) + lane_div_16 * fx.Int32(4) + odd * fx.Int32(2)
            for k in range_constexpr(2)
        ]
        toks = [
            load_scalar(load_i32, stids, r, fx.Int32) & fx.Int32(0x00FFFFFF) for r in rows
        ]
        wts = [load_scalar(load_f32, sweights, r, fx.Float32) for r in rows]
        for ni in range_constexpr(len(accm[mi])):
            v = Vec(accm[mi][ni])
            pairs = []
            for k in range_constexpr(2):
                mine = is_odd.select(v[2 + k], v[k])
                # partner needs my value of its rows: even partner wants v[k] (rows
                # 0,1), odd partner wants v[2+k] (rows 2,3).
                theirs = is_odd.select(v[k], v[2 + k]).shuffle_xor(
                    fx.Int32(1), fx.Int32(64)
                )
                lo = is_odd.select(theirs, mine)  # even column
                hi = is_odd.select(mine, theirs)  # odd column
                pairs.append((lo, hi))
            for k in range_constexpr(2):
                if toks[k] < i32_M:  # padding rows carry a sentinel token id
                    _atomic_add_bf16x2(
                        out_base,
                        toks[k] * fx.Int32(N_OUT) + col_even + fx.Int32(ni * 16),
                        pairs[k][0] * wts[k],
                        pairs[k][1] * wts[k],
                    )


@flyc.jit
def _atomic_bf16_epilog(
    lds_base_i32, accm, arg_out, arg_stids, arg_sweights, m_row, n_block, wave, lane,
    i32_M, BM, N_OUT, BN,
):
    """Coalesced scatter through LDS: apply the routing weight in the MFMA layout,
    stage the tile as bf16 [BM, BN] (same bf16 rounding point as the port's f32
    staging, half the LDS), re-read it as (8 rows x 32 lanes x 2 cols) and
    ``global_atomic_pk_add_bf16`` into ``out[token, n]`` (128 B per row per op)."""
    # Row count comes from the accumulator list, not BM: a nested @flyc.jit call
    # does not re-specialize on Python int arguments (dyn_rows calls this with
    # several row variants in one kernel).
    M_CHUNKS = len(accm)
    M_REPS = M_CHUNKS * 2  # 256 threads = 8 rows x 32 lanes per pass
    n_per_wave = BN // 4
    num_acc_n = n_per_wave // 16
    s_count = BN // 64  # each pass covers 64 cols (32 lanes x 2)
    lane_div_16 = lane // fx.Int32(16)
    lane_mod_16 = lane % fx.Int32(16)
    lds_bf16 = lds_typed_ptr(lds_base_i32, T.bf16)

    tx = fx.Int32(gpu.thread_id("x"))
    m_lane = tx // fx.Int32(32)
    col_start = (tx % fx.Int32(32)) * fx.Int32(2)

    stids = _flat_buffer(arg_stids, T.i32, 4)
    sweights = _flat_buffer(arg_sweights, T.f32, 4)
    load_i32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
    load_f32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Float32)
    # gfx942 has no buffer_atomic_pk_add_bf16 -> global packed atomic.
    out_base = _global_base_ptr1(arg_out)

    def load_scalar(atom, src, index, elem_ty):
        frag = fx.make_rmem_tensor(1, elem_ty)
        fx.copy(atom, src[None, index], frag)
        return Vec(frag.load())[0]

    packed = []
    for mr in range_constexpr(M_REPS):
        sorted_pos = m_row + fx.Int32(mr * 8) + m_lane
        packed.append(load_scalar(load_i32, stids, sorted_pos, fx.Int32))

    # MFMA acc layout (lane: col L%16, rows (L//16)*4 + v) -> weighted bf16 in LDS.
    for i in range_constexpr(M_CHUNKS):
        row_base = fx.Int32(i * 16) + lane_div_16 * fx.Int32(4)
        w = [
            load_scalar(load_f32, sweights, m_row + row_base + fx.Int32(v), fx.Float32)
            for v in range_constexpr(4)
        ]
        for J in range_constexpr(num_acc_n):
            col = wave * fx.Int32(n_per_wave) + fx.Int32(J * 16) + lane_mod_16
            vec = Vec(accm[i][J])
            bf4 = Vec.from_elements(
                [vec[v] * w[v] for v in range_constexpr(4)], fx.Float32
            ).to(fx.BFloat16)
            for v in range_constexpr(4):
                lds_bf16[(row_base + fx.Int32(v)) * fx.Int32(BN) + col] = bf4[v]

    gpu.barrier()

    for mr in range_constexpr(M_REPS):
        row_in_block = fx.Int32(mr * 8) + m_lane
        token_id = packed[mr] & fx.Int32(0x00FFFFFF)
        if token_id < i32_M:  # padding rows carry a sentinel token id
            row_base_addr = (
                token_id * fx.Int32(N_OUT) + n_block * fx.Int32(BN) + col_start
            )
            for s in range_constexpr(s_count):
                idx0 = row_in_block * fx.Int32(BN) + col_start + fx.Int32(s * 64)
                pk = lds_vec_load(
                    lds_base_i32,
                    idx0 * fx.Int32(2),
                    Vec.make_type(2, fx.BFloat16),
                    fx.BFloat16,
                    align=4,
                )
                llvm.AtomicRMWOp(
                    llvm.AtomicBinOp.fadd,
                    _gep1(out_base, (row_base_addr + fx.Int32(s * 64)) * fx.Int32(2)),
                    _raw(pk),
                    llvm.AtomicOrdering.monotonic,
                    syncscope="agent",
                    alignment=4,
                )


# =============================================================================
# Kernel
# =============================================================================


@functools.cache
def compile_a8w4_gemm2(
    *,
    D_HIDDEN,
    D_INTER,
    NE,
    BM=64,
    TILE_N=128,
    TILE_K=256,
    b_cache_mod=2,
    xcd_swizzle=0,
    waves_per_eu=None,
    flush_tiny=True,
    epilog="lds",
    dyn_rows=False,
):
    """Build the A8W4 stage2 launcher (N = model_dim, K = inter_dim).

    ``epilog``: ``"lds"`` (default) stages a weighted bf16 tile in LDS
    (BM*TILE_N*2, half the port's f32 staging) for 128 B contiguous atomics;
    ``"direct"`` scatters straight from the MFMA accumulator (lane-pair shuffle, no
    LDS staging/barrier, LDS = A tile only) but issues 32 B-contiguous atomics.

    ``dyn_rows``: each WG computes only the leading 16-row sub-blocks of its sorted
    block that hold valid rows (valid rows are contiguous from the block start),
    so A loads / MFMA / dequant / scatter skip all-padding sub-blocks. All row
    variants (16, 32, ..., BM) are compiled in; W traffic is unchanged.

    Launch args (raw device pointers): ``a`` fp8 [sorted_size, K], ``a_scale`` f32
    [sorted_size], ``w`` mxfp4 [E, N, K/2] (standard preshuffle), ``w_scale`` e8m0
    (shuffled), ``sorted_expert_ids``, ``num_valid_ids``, ``sorted_ids``,
    ``sorted_weights``, ``out`` bf16 [tokens, N] (pre-zeroed, atomically
    accumulated), then ``tokens``, ``grid`` and the stream.
    """
    K = D_INTER
    N_OUT = D_HIDDEN
    NUM_WAVES = 4
    assert K % TILE_K == 0 and TILE_K % 128 == 0, f"bad K={K} / TILE_K={TILE_K}"
    assert N_OUT % TILE_N == 0, f"model_dim must be a multiple of TILE_N={TILE_N}"
    assert TILE_N % (NUM_WAVES * 16) == 0, "TILE_N must be a multiple of 64"
    assert BM % 16 == 0, f"BM must be a multiple of 16, got {BM}"
    assert (BM * TILE_K) % (256 * 16) == 0, "A tile must be whole 16 B per thread"
    assert epilog in ("direct", "lds"), f"epilog must be direct or lds, got {epilog!r}"

    NUM_N_BLOCKS = N_OUT // TILE_N
    K_TILES = K // TILE_K
    N_REPEAT = TILE_N // NUM_WAVES // 16  # 16-col MFMA blocks per wave
    K_STEPS = TILE_K // 32  # MFMA K32 steps per tile
    K_GROUPS = TILE_K // 128  # 128-K groups: one W dwordx4 + one scale byte each
    # LDS epilogue: the A tile and the bf16 staging tile never coexist (barrier
    # between) -> max, not sum. Direct epilogue: A tile only.
    LDS_BYTES = BM * TILE_K if epilog == "direct" else max(BM * TILE_K, BM * TILE_N * 2)

    # W (mxfp4) N-major preshuffle in bytes: (N/16, K/128, klane=4, nlane=16, kpack=16).
    W_K0 = K // 128
    W_BYTES = NE * N_OUT * K // 2
    # E8M0 scale preshuffle (dwords): (N/32, Kpad/256, klane=4, nlane=16); each dword
    # packs [kpack=2] x [npack=2] bytes.
    SCALE_K_PAD = ((K + 255) // 256) * 256
    SC_STRIDE_N0 = (SCALE_K_PAD // 256) * 64
    WS_BYTES = NE * N_OUT * (SCALE_K_PAD // 32)

    ftz_tag = "_ftz" if flush_tiny else ""
    wpe_tag = f"_w{waves_per_eu}" if waves_per_eu else ""
    kname = (
        f"a8w4_gemm2_h{N_OUT}_i{K}_ne{NE}_bm{BM}_tn{TILE_N}_tk{TILE_K}"
        f"_bcm{b_cache_mod}_xcd{xcd_swizzle}{wpe_tag}{ftz_tag}_{epilog}"
        f"{'_dyn' if dyn_rows else ''}"
    )

    def _body(
        lds_ptr,
        arg_a,
        arg_a_scale,
        arg_w,
        arg_w_scale,
        arg_eids,
        arg_stids,
        arg_sweights,
        arg_out,
        i32_M,
        tile,
        lane,
        wave,
    ):
        lane_div_16 = lane // fx.Int32(16)
        lane_mod_16 = lane % fx.Int32(16)

        # ---- tile decode: m-block (one expert) x n-block (model_dim tile) -------
        m_block = tile // fx.Int32(NUM_N_BLOCKS)
        n_block = tile % fx.Int32(NUM_N_BLOCKS)
        e = rocdl.readfirstlane(T.i32, _raw(_global_i32_at(arg_eids, m_block)))
        m_row = m_block * fx.Int32(BM)  # first sorted row of this m-block
        by_n = n_block * fx.Int32(TILE_N)

        # ---- W operand resources ----------------------------------------------
        expert_off = e * fx.Int32(N_OUT)
        w_tiles = _global_i32_buffer_tiles(arg_w, min(W_BYTES, 0xFFFFFFFF), 4)
        w_atom = fx.make_copy_atom(fx.rocdl.BufferCopy128b(b_cache_mod), fx.Int32)
        ws_tiles = _global_i32_buffer_tiles(arg_w_scale, min(WS_BYTES, 0xFFFFFFFF), 1)
        ws_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(0), fx.Int32)

        # ---- A operand: BM sorted rows -> VGPRs -> LDS (single slot) ----------
        # Rows < cumsum0 always exist in the [sorted_size, K] buffer; the grid never
        # visits rows beyond it, so an unclamped resource is fine.
        x_tiles = fx.logical_divide(
            _global_i32_buffer_view(arg_a, fx.Int64(0xFFFFFFFF)), fx.make_layout(4, 1)
        )
        x_atom = fx.make_copy_atom(fx.rocdl.BufferCopy128b(b_cache_mod), fx.Int32)
        lds_flat = fx.make_view(
            fx.recast_iter(fx.Int32, lds_ptr), fx.make_layout(LDS_BYTES // 4, 1)
        )
        lds_tiles16 = fx.logical_divide(lds_flat, fx.make_layout(4, 1))
        lds_tiles8 = fx.logical_divide(lds_flat, fx.make_layout(2, 1))
        lds_write_atom = fx.make_copy_atom(fx.UniversalCopy128b(), fx.Int32)
        lds_read_atom = fx.make_copy_atom(fx.UniversalCopy64b(), fx.Int32)

        def _swizzle(row, col_bytes):
            # A-LDS bank-conflict XOR swizzle; applied to the GMEM source column on
            # the write (LDS destination linear) and to the LDS column on the read.
            return col_bytes ^ ((row & fx.Int32(TILE_K // 16 - 1)) * fx.Int32(16))

        tx = fx.Int32(gpu.thread_id("x"))

        # ---- W columns: wave owns TILE_N/4 output channels ----------------------
        # Addresses are K-invariant per lane; a K tile only adds a static offset.
        # Two 16-col blocks of one 32-row scale block share a scale dword (npack
        # halves) -> load it once.
        share_scale = (TILE_N // NUM_WAVES) % 32 == 0
        n_wave_base = wave * fx.Int32(TILE_N // NUM_WAVES)
        w_base, sc_base, sc_key, sc_npack = [], {}, [], []
        for ni in range_constexpr(N_REPEAT):
            n0 = expert_off + by_n + n_wave_base + fx.Int32(ni * 16)
            w_base.append(
                (n0 // fx.Int32(16)) * fx.Int32(W_K0 * 64)
                + lane_div_16 * fx.Int32(16)
                + lane_mod_16
            )
            key = ni // 2 if share_scale else ni
            sc_key.append(key)
            sc_npack.append((n0 // fx.Int32(16)) % fx.Int32(2))
            if key not in sc_base:
                sc_base[key] = (
                    (n0 // fx.Int32(32)) * fx.Int32(SC_STRIDE_N0)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )

        # ---- e8m0 codes for the whole K (short: K = inter_dim) ------------------
        # Lane L holds 32-K group 4*G + L//16 of every 128-K group G; the dword of
        # group G is (G//2) along K, byte (G%2)*2 + npack.
        packed = {
            (key, G2): _buffer_i32_scalar_read(
                ws_tiles, sc_base[key] + fx.Int32(G2 * 64), ws_atom
            )
            for key in sc_base
            for G2 in range((K // 128 + 1) // 2)
        }
        code = {}  # code[ni, G]: this lane's e8m0 byte of 128-K group G
        for ni in range_constexpr(N_REPEAT):
            for G in range_constexpr(K // 128):
                shift = fx.Int32((G % 2) * 16) + sc_npack[ni] * fx.Int32(8)
                code[ni, G] = packed[sc_key[ni], G // 2].shrui(shift) & fx.Int32(0xFF)
        # Per-output-channel max e8m0 code over K: lane max, then across the 4
        # lanes (L//16) that share the column.
        exp_n = []
        for ni in range_constexpr(N_REPEAT):
            mx = code[ni, 0]
            for G in range_constexpr(1, K // 128):
                mx = (code[ni, G] > mx).select(code[ni, G], mx)
            for off in (16, 32):
                peer = mx.shuffle_xor(fx.Int32(off), fx.Int32(64))
                mx = (peer > mx).select(peer, mx)
            exp_n.append(mx)

        mma_atom = fx.make_mma_atom(fx.rocdl.MFMA(16, 16, 32, fx.Float8E4M3FNUZ))

        def run_rows(rows):
            """A load, K loop, dequant and scatter for the first ``rows`` rows."""
            M_REPEAT = rows // 16  # 16-row MFMA blocks
            A_LOADS = rows * TILE_K // (256 * 16)  # 16 B A copies per thread

            a_src_tile, a_dst_tile = [], []
            for i in range_constexpr(A_LOADS):
                idx_dw = tx * fx.Int32(4) + fx.Int32(i * 256 * 4)
                row = idx_dw // fx.Int32(TILE_K // 4)
                col_bytes = (idx_dw % fx.Int32(TILE_K // 4)) * fx.Int32(4)
                row_bytes = (m_row + row) * fx.Int32(K)  # A is indexed by sorted row
                a_src_tile.append((row_bytes + _swizzle(row, col_bytes)) // fx.Int32(16))
                a_dst_tile.append((row * fx.Int32(TILE_K) + col_bytes) // fx.Int32(16))

            def store_a_tile(base_k):
                k16 = fx.Int32(base_k // 16)
                for i in range_constexpr(A_LOADS):
                    r = fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
                    fx.copy(x_atom, fx.slice(x_tiles, (None, a_src_tile[i] + k16)), r)
                    fx.copy(lds_write_atom, r, fx.slice(lds_tiles16, (None, a_dst_tile[i])))

            def load_a(mi, ku):
                # Lane L of K-step ku: row L%16, K = (ku//4)*128 + (L//16)*32 + (ku%4)*8.
                row = lane_mod_16 + fx.Int32(mi * 16)
                col = lane_div_16 * fx.Int32(32) + fx.Int32((ku // 4) * 128 + (ku % 4) * 8)
                off = (row * fx.Int32(TILE_K) + _swizzle(row, col)) // fx.Int32(8)
                r = fx.make_rmem_tensor(fx.make_layout(2, 1), fx.Int32)
                fx.copy_atom_call(lds_read_atom, fx.slice(lds_tiles8, (None, off)), r)
                return fx.Vector(fx.memref_load_vec(r)).bitcast(fx.Float8E4M3FNUZ)

            # ---- accumulators -------------------------------------------------------
            acc_layout = fx.make_layout(4, 1)
            accm = [
                [fx.make_rmem_tensor(acc_layout, fx.Float32) for _ in range(N_REPEAT)]
                for _ in range(M_REPEAT)
            ]
            zero4 = fx.Vector.filled(4, 0.0, fx.Float32)
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT):
                    accm[mi][ni].store(zero4)

            # ---- K loop (static: K = inter_dim is a few tiles) ----------------------
            for kt in range_constexpr(K_TILES):
                base_k = kt * TILE_K
                store_a_tile(base_k)
                raw = []  # raw[ni][g][j]: i32 with 8 fp4 for K-step g*4 + j
                for ni in range_constexpr(N_REPEAT):
                    per_g = []
                    for g in range_constexpr(K_GROUPS):
                        r = fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
                        idx = w_base[ni] + fx.Int32((base_k // 128 + g) * 64)
                        fx.copy(w_atom, fx.slice(w_tiles, (None, idx)), r)
                        v4 = fx.Vector(fx.memref_load_vec(r))
                        per_g.append([fx.Int32(v4[j]) for j in range(4)])
                    raw.append(per_g)
                rocdl.s_waitcnt(lgkmcnt=0)
                gpu.barrier()  # A(kt) visible in LDS
                for ni in range_constexpr(N_REPEAT):
                    luts = [
                        _fp8_lut(code[ni, base_k // 128 + g], exp_n[ni], flush_tiny)
                        for g in range_constexpr(K_GROUPS)
                    ]
                    for ku in range_constexpr(K_STEPS):
                        b8 = _fp4x8_to_fp8x8(raw[ni][ku // 4][ku % 4], luts[ku // 4])
                        for mi in range_constexpr(M_REPEAT):
                            _mma_fp8(mma_atom, accm[mi][ni], load_a(mi, ku), b8)
                gpu.barrier()  # A reads done before the slot (or the epilogue) reuses LDS

            # ---- dequant: acc * a_scale[sorted_row] * 2**(exp-132) ------------------
            as_tiles = _global_i32_buffer_tiles(arg_a_scale, fx.Int64(0xFFFFFFFF), 1)
            as_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
            f_n = [_channel_factor(x) for x in exp_n]
            for mi in range_constexpr(M_REPEAT):
                row0 = m_row + fx.Int32(mi * 16) + lane_div_16 * fx.Int32(4)
                rs = [
                    _buffer_i32_scalar_read(as_tiles, row0 + fx.Int32(ii), as_atom).bitcast(
                        fx.Float32
                    )
                    for ii in range_constexpr(4)
                ]
                for ni in range_constexpr(N_REPEAT):
                    v = Vec(accm[mi][ni].load())
                    accm[mi][ni].store(
                        Vec.from_elements(
                            [v[ii] * (rs[ii] * f_n[ni]) for ii in range_constexpr(4)],
                            fx.Float32,
                        )
                    )

            # ---- epilogue: routing weight + bf16x2 atomic scatter -------------------
            accm_v = [
                [accm[mi][ni].load().ir_value() for ni in range(N_REPEAT)]
                for mi in range(M_REPEAT)
            ]
            if const_expr(epilog == "direct"):
                _direct_atomic_epilog(
                    accm_v,
                    arg_out,
                    arg_stids,
                    arg_sweights,
                    m_row,
                    by_n + n_wave_base + lane_mod_16,
                    lane,
                    i32_M,
                    N_OUT,
                )
            else:
                _atomic_bf16_epilog(
                    fx.Int32(fx.ptrtoint(lds_ptr)),
                    accm_v,
                    arg_out,
                    arg_stids,
                    arg_sweights,
                    m_row,
                    n_block,
                    wave,
                    lane,
                    i32_M,
                    BM,
                    N_OUT,
                    TILE_N,
                )


        # ---- row-variant dispatch ------------------------------------------------
        if const_expr(dyn_rows):
            # Valid rows of a sorted block are contiguous from its start, so the
            # first 16-row sub-block whose first row is padding bounds the work.
            pad = {
                i: (
                    fx.Int32(
                        rocdl.readfirstlane(
                            T.i32,
                            _raw(_global_i32_at(arg_stids, m_row + fx.Int32(16 * i))),
                        )
                    )
                    & fx.Int32(0x00FFFFFF)
                )
                >= i32_M
                for i in range(1, BM // 16)
            }

            def _dispatch_from(i):
                # sub-blocks 0..i-1 hold valid rows; decide on sub-block i.
                if i == BM // 16:
                    run_rows(BM)
                    return
                cond = pad[i]

                @flyc.jit
                def _dispatch():
                    if cond:
                        run_rows(16 * i)
                    else:
                        _dispatch_from(i + 1)

                _dispatch()

            _dispatch_from(1)
        else:
            run_rows(BM)

    @fx.struct
    class SharedStorage:
        raw: fx.Array[fx.Uint8, LDS_BYTES, 16]

    @flyc.jit
    def _entry(
        arg_a,
        arg_a_scale,
        arg_w,
        arg_w_scale,
        arg_eids,
        arg_cumsum,
        arg_stids,
        arg_sweights,
        arg_out,
        i32_M,
    ):
        lds_ptr = fx.SharedAllocator().allocate(SharedStorage).peek().raw.ptr
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        lane = tx % fx.Int32(64)
        wave = rocdl.readfirstlane(T.i32, tx // fx.Int32(64))
        cumsum0 = _global_i32_at(arg_cumsum, fx.Int32(0))
        total_m_blocks = cumsum0 // fx.Int32(BM)
        bound = total_m_blocks * fx.Int32(NUM_N_BLOCKS)

        # Bijective XCD round-robin over valid tiles (always on: stage2 is HBM-bound);
        # xcd_swizzle>0 also groups xcd_swizzle m-blocks per XCD for L2 locality.
        NXCD = 8
        xq = _udiv(bound, NXCD)
        xr = _umod(bound, NXCD)

        def _xcd(pid):
            xc = _umod(pid, NXCD)
            wgid = xc * xq + fx.min(xc, xr) + _udiv(pid, NXCD)
            if const_expr(xcd_swizzle <= 0):
                return wgid
            ng = fx.Int32(xcd_swizzle * NUM_N_BLOCKS)
            first_m = (wgid // ng) * fx.Int32(xcd_swizzle)
            group_m = fx.min(total_m_blocks - first_m, fx.Int32(xcd_swizzle))
            wig = wgid % ng
            return (first_m + wig % group_m) * fx.Int32(NUM_N_BLOCKS) + wig // group_m

        if bx < bound:
            _body(
                lds_ptr,
                arg_a,
                arg_a_scale,
                arg_w,
                arg_w_scale,
                arg_eids,
                arg_stids,
                arg_sweights,
                arg_out,
                i32_M,
                _xcd(bx),
                lane,
                wave,
            )

    @flyc.kernel(name=kname, known_block_size=[256, 1, 1])
    def a8w4_gemm2_kernel(
        arg_a: fx.Int64,
        arg_a_scale: fx.Int64,
        arg_w: fx.Int64,
        arg_w_scale: fx.Int64,
        arg_eids: fx.Int64,
        arg_cumsum: fx.Int64,
        arg_stids: fx.Int64,
        arg_sweights: fx.Int64,
        arg_out: fx.Int64,
        i32_M: fx.Int32,
    ):
        _entry(
            arg_a,
            arg_a_scale,
            arg_w,
            arg_w_scale,
            arg_eids,
            arg_cumsum,
            arg_stids,
            arg_sweights,
            arg_out,
            i32_M,
        )

    @flyc.jit
    def launch(
        arg_a: fx.Int64,
        arg_a_scale: fx.Int64,
        arg_w: fx.Int64,
        arg_w_scale: fx.Int64,
        arg_eids: fx.Int64,
        arg_cumsum: fx.Int64,
        arg_stids: fx.Int64,
        arg_sweights: fx.Int64,
        arg_out: fx.Int64,
        i32_M: fx.Int32,
        i32_grid: fx.Int32,
        stream: fx.Stream,
    ):
        a8w4_gemm2_kernel(
            arg_a,
            arg_a_scale,
            arg_w,
            arg_w_scale,
            arg_eids,
            arg_cumsum,
            arg_stids,
            arg_sweights,
            arg_out,
            i32_M,
            value_attrs=(
                {"rocdl.waves_per_eu": waves_per_eu} if waves_per_eu else None
            ),
        ).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1), stream=stream)

    return launch


def a8w4_gemm2(
    a_fp8,
    a_scale,
    w2,
    w2_scale,
    sorted_ids,
    sorted_weights,
    sorted_expert_ids,
    num_valid_ids,
    out,
    *,
    num_experts,
    tile_m=64,
    tile_n=128,
    tile_k=256,
    b_cache_mod=2,
    xcd_swizzle=0,
    flush_tiny=True,
    waves_per_eu=None,
    epilog="lds",
    dyn_rows=False,
):
    """Host launcher. ``out`` is bf16 ``[tokens, model_dim]``; it is accumulated
    into (atomics), so the caller zeroes it (moe_sorting's moe_buf already is)."""
    tokens, model_dim = out.shape
    inter_dim = a_fp8.shape[1]
    launch = compile_a8w4_gemm2(
        D_HIDDEN=model_dim,
        D_INTER=inter_dim,
        NE=num_experts,
        BM=tile_m,
        TILE_N=tile_n,
        TILE_K=tile_k,
        b_cache_mod=b_cache_mod,
        xcd_swizzle=xcd_swizzle,
        flush_tiny=flush_tiny,
        waves_per_eu=waves_per_eu,
        epilog=epilog,
        dyn_rows=dyn_rows,
    )
    grid = sorted_expert_ids.numel() * (model_dim // tile_n)
    _run_compiled(
        launch,
        a_fp8.data_ptr(),
        a_scale.data_ptr(),
        w2.data_ptr(),
        w2_scale.data_ptr(),
        sorted_expert_ids.data_ptr(),
        num_valid_ids.data_ptr(),
        sorted_ids.data_ptr(),
        sorted_weights.data_ptr(),
        out.data_ptr(),
        int(tokens),
        int(grid),
        torch.cuda.current_stream(),
    )
    return out


# =============================================================================
# Reference + test
# =============================================================================


def run_torch(
    a_fp8,
    a_scale,
    w2_qt,
    w2_scale,
    sorted_ids,
    sorted_weights,
    sorted_expert_ids,
    num_valid_ids,
    tokens,
    tile_m,
):
    """fp32 reference: out[t] = sum over t's sorted rows r of
    w_r * (a_deq[r] @ W2[e_r]^T), using the same FP8 A (dequantized with its row
    scale) and exact mxfp4 W2. Returns bf16 [tokens, model_dim]."""
    E, model_dim, _ = w2_qt.shape
    inter_dim = a_fp8.shape[1]
    nv = int(num_valid_ids[0].item())
    ids = sorted_ids[:nv].to(torch.int64)
    token = ids & 0x00FFFFFF
    row_expert = sorted_expert_ids.to(torch.int64).repeat_interleave(tile_m)[:nv]
    valid = token < tokens

    a = a_fp8[:nv].to(torch.float32) * a_scale[:nv].view(-1, 1)
    w_scale = fp4_utils.e8m0_to_f32(w2_scale).view(E, model_dim, inter_dim // 32, 1)
    out = torch.zeros((tokens, model_dim), dtype=torch.float32, device=a.device)
    for e in row_expert[valid].unique().tolist():
        rows = torch.nonzero(valid & (row_expert == e)).squeeze(1)
        w = fp4_utils.mxfp4_to_f32(w2_qt[e]).view(model_dim, inter_dim // 32, 32)
        w = (w * w_scale[e]).view(model_dim, inter_dim)
        y = (a[rows] @ w.t()) * sorted_weights[rows].view(-1, 1)
        out.index_add_(0, token[rows], y)
    return out.to(dtypes.bf16)


def _cos_diff(x, y):
    x, y = x.double(), y.double()
    return float(1 - 2 * (x * y).sum() / (x * x + y * y).sum())


@benchmark()
def bench_a8w4_gemm2(
    token,
    model_dim,
    inter_dim,
    expert,
    topk,
    routing="uniform",
    tile_m=64,
    tile_n=128,
    b_cache_mod=2,
    xcd_swizzle=0,
    flush_tiny=True,
    waves_per_eu=None,
    epilog="lds",
    dyn_rows=False,
):
    tile_k = 256 if inter_dim % 256 == 0 else 128
    device = "cuda"
    torch.manual_seed(0)
    torch.cuda.manual_seed(0)

    # ---- routing: same construction as test_a8w4_gemm1 --------------------------
    inp = torch.randn((token, model_dim), dtype=dtypes.bf16, device=device)
    score = torch.randn((token, expert), dtype=dtypes.bf16, device=device)
    if routing == "hot":
        hot = torch.randperm(expert, device=device)[: max(1, expert // HOT_EXPERT_DIV)]
        score[:, hot] += HOT_EXPERT_BIAS
    else:
        assert routing == "uniform", f"unknown routing {routing!r}"
    topk_weights, topk_ids = fused_topk(inp, score, topk, True)

    w2 = torch.randn((expert, model_dim, inter_dim), dtype=dtypes.bf16, device=device)
    w2_qt, w2_scale = aiter.get_torch_quant(QuantType.per_1x32)(
        w2, quant_dtype=dtypes.fp4x2
    )
    del w2
    w2_qt = w2_qt.view(expert, model_dim, inter_dim // 2)
    w2_u8 = shuffle_weight_a16w4(w2_qt, 16, False).view(torch.uint8)
    w2_scale_u8 = (
        shuffle_scale_a16w4(w2_scale, expert, False)
        .view(torch.uint8)
        .contiguous()
        .view(-1)
    )

    # ---- per-call preprocessing (not timed): routing sort, A quant ---------------
    sorted_ids, sorted_weights, sorted_expert_ids, num_valid_ids, _ = moe_sorting(
        topk_ids, topk_weights, expert, model_dim, dtypes.bf16, tile_m
    )[:5]
    sorted_size = sorted_expert_ids.numel() * tile_m
    # Stage1 output stand-in: bf16 intermediate by sorted position, row-quantized
    # like the production path (only the num_valid_ids rows).
    inter = torch.randn((sorted_size, inter_dim), dtype=dtypes.bf16, device=device)
    a_fp8, a_scale = quantize_rows(inter, num_valid_ids)

    ref = run_torch(
        a_fp8,
        a_scale,
        w2_qt,
        w2_scale,
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        token,
        tile_m,
    )

    def _out():
        return torch.zeros((token, model_dim), dtype=dtypes.bf16, device=device)

    out_new, out_port = _out(), _out()
    candidates = {
        # this file's standalone kernel
        "a8w4_gemm2": (
            out_new,
            lambda: a8w4_gemm2(
                a_fp8,
                a_scale,
                w2_u8,
                w2_scale_u8,
                sorted_ids,
                sorted_weights,
                sorted_expert_ids,
                num_valid_ids,
                out_new,
                num_experts=expert,
                tile_m=tile_m,
                tile_n=tile_n,
                tile_k=tile_k,
                b_cache_mod=b_cache_mod,
                xcd_swizzle=xcd_swizzle,
                flush_tiny=flush_tiny,
                waves_per_eu=waves_per_eu,
                epilog=epilog,
                dyn_rows=dyn_rows,
            ),
        ),
        # production a16w4 port built for fp8r (baseline)
        "port": (
            out_port,
            lambda: flydsl_a16w4_gemm2(
                inter_sorted_bf16=a_fp8,
                w2_u8=w2_u8,
                w2_scale_u8=w2_scale_u8,
                sorted_expert_ids=sorted_expert_ids,
                cumsum_tensor=num_valid_ids,
                sorted_token_ids=sorted_ids,
                sorted_weights=sorted_weights,
                flat_out=out_port.view(-1),
                M_logical=token,
                max_sorted=sorted_size,
                NE=expert,
                D_HIDDEN=model_dim,
                D_INTER=inter_dim,
                topk=topk,
                tile_m=tile_m,
                tile_n=tile_n,
                tile_k=tile_k,
                b_nt=b_cache_mod,
                xcd_swizzle=xcd_swizzle,
                epilog="atomic",
                a_dtype="fp8r",
                a_scale=a_scale,
                flush_tiny=flush_tiny,
            ),
        ),
    }

    routed = token * topk
    n_experts_hit = int(topk_ids.unique().numel())
    flops = 2 * routed * model_dim * inter_dim
    nbytes = (
        n_experts_hit * model_dim * (inter_dim // 2 + inter_dim // 32)  # W2 + scale
        + routed * inter_dim  # fp8 A
        + token * model_dim * 2  # bf16 out
    )

    ret = {"gfx": get_gfx()}
    tok_per_expert = torch.bincount(topk_ids.flatten(), minlength=expert)
    ret["experts hit"] = n_experts_hit
    ret["max tok/expert"] = int(tok_per_expert.max())
    ret["m-blocks"] = int(num_valid_ids[0]) // tile_m
    ref_v = ref.to(dtypes.fp32)
    for name, (out, fn) in candidates.items():
        # Atomic accumulation: check one launch into a zeroed buffer (this also
        # JIT-compiles outside the timed region), then time repeated launches.
        out.zero_()
        fn()
        torch.cuda.synchronize()
        out_v = out.to(dtypes.fp32)
        # Output is a bf16 atomic sum of topk partials (each add rounds to bf16), so
        # the tolerance is looser than gemm1's: |ref| ~ 5 mean / 33 max here.
        err = checkAllclose(
            ref_v,
            out_v,
            rtol=2e-2,
            atol=1e-1,
            tol_err_ratio=TOL_ERR_RATIO,
            msg=f"{name}: a8w4 gemm2 ",
        )
        _, us = run_perftest(fn)
        ret[f"{name} us"] = us
        ret[f"{name} TFLOPS"] = flops / us / 1e6
        ret[f"{name} TB/s"] = nbytes / us / 1e6
        ret[f"{name} err"] = err
        ret[f"{name} cos"] = _cos_diff(ref_v, out_v)
    return ret


@pytest.mark.skipif(
    get_gfx() not in SUPPORTED_GFX, reason="A8W4 needs gfx942 FP8-FNUZ MFMA"
)
@pytest.mark.parametrize("model_dim,inter_dim,expert,topk", [(4096, 256, 256, 8)])
@pytest.mark.parametrize("token", [512])
@pytest.mark.parametrize("tile_m", [64, 32])
@pytest.mark.parametrize("dyn_rows", [False, True])
@pytest.mark.parametrize("routing", ROUTINGS)
def test_a8w4_gemm2(
    token, model_dim, inter_dim, expert, topk, tile_m, dyn_rows, routing
):
    """Mimo v2.6 stage2 shape: standalone kernel and port vs fp32 reference."""
    ret = bench_a8w4_gemm2(
        token,
        model_dim,
        inter_dim,
        expert,
        topk,
        routing=routing,
        tile_m=tile_m,
        dyn_rows=dyn_rows,
    )
    for name in ("a8w4_gemm2", "port"):
        assert ret[f"{name} err"] <= TOL_ERR_RATIO, f"{name} mismatch {ret}"
        assert ret[f"{name} cos"] < 1e-4, f"{name} cos diff too large {ret}"


def main():
    if get_gfx() not in SUPPORTED_GFX:
        aiter.logger.warning("a8w4 gemm2 unsupported on %s; skipping", get_gfx())
        return

    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description="A8W4 MoE stage2 (down-proj + atomic scatter) correctness / perf",
    )
    parser.add_argument(
        "-t",
        "--token",
        type=int,
        nargs="*",
        default=[128, 256, 512, 1024, 2048],
        help="token counts",
    )
    parser.add_argument(
        "-s",
        "--shape",
        type=dtypes.str2tuple,
        nargs="*",
        default=[(4096, 256, 256, 8)],
        help="model_dim,inter_dim,expert,topk  e.g. -s 4096,256,256,8",
    )
    parser.add_argument(
        "--tile",
        type=dtypes.str2tuple,
        nargs="*",
        default=[(64, 128, 1), (32, 128, 1)],
        help="tile_m,tile_n[,dyn_rows]  e.g. --tile 64,128 64,128,1 (dyn_rows: skip\n"
        "all-padding 16-row sub-blocks of each sorted block at runtime)",
    )
    parser.add_argument(
        "-r",
        "--routing",
        type=str,
        nargs="*",
        choices=ROUTINGS,
        default=ROUTINGS,
        help="uniform: random top-k; hot: a few hot experts own most routed rows",
    )
    args = parser.parse_args()

    df = []
    for (model_dim, inter_dim, expert, topk), token, routing, tile in (
        itertools.product(args.shape, args.token, args.routing, args.tile)
    ):
        tile_m, tile_n = tile[:2]
        df.append(
            bench_a8w4_gemm2(
                token,
                model_dim,
                inter_dim,
                expert,
                topk,
                routing=routing,
                tile_m=tile_m,
                tile_n=tile_n,
                dyn_rows=bool(tile[2]) if len(tile) > 2 else False,
            )
        )
    df = pd.DataFrame(df)
    aiter.logger.info("a8w4 gemm2 summary (markdown):\n%s", df.to_markdown(index=False))


if __name__ == "__main__":
    main()

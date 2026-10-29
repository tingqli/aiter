# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Single-kernel A8W4 fused MoE (gate+up GEMM + SiLU + per-token FP8 requant +
down GEMM + routed atomic scatter) FlyDSL kernel for gfx942.

Fuses ``op_tests/test_a8w4_gemm1.py`` and ``op_tests/test_a8w4_gemm2.py``: one
workgroup owns one sorted m-block (BM rows of one expert) and

  1. gemm1  : A1 = FP8 row-quantized x (gathered by token id) x W1[e] (mxfp4,
              all 2*inter columns) -> acc * x_scale * 2**(exp-132) -> SiLU(g)*u
  2. stage  : the bf16 [BM, inter] intermediate goes to LDS (same bf16 rounding
              point as the 2-kernel path)
  3. requant: per-row (per routed token) amax -> FP8-FNUZ [BM, inter] A2 tile +
              f32 row scale, written to LDS in gemm2's swizzled A layout
              (bit-identical to ``a8w4.quantize_rows``)
  4. gemm2  : for every TILE_N2 slice of model_dim: A2 (LDS) x W2[e] (mxfp4) ->
              acc * a2_scale * 2**(exp-132) * route_weight -> bf16 LDS tile ->
              packed bf16x2 global atomic add into ``[tokens, model_dim]``

The intermediate never leaves the CU (no [sorted_size, inter] HBM round trip, no
separate quantize kernel, one launch). The cost is parallelism: one workgroup per
m-block (vs m-blocks x n-blocks for each split kernel), so the block has 4-16
waves (``num_waves``) to hide memory latency.

LDS (reused across phases): region0 = A1 tile -> A2 tile; region1 = bf16
intermediate -> bf16 scatter staging; region2 = f32 row scales.

Run:
    pytest op_tests/test_a8w4_fmoe.py -q
    python op_tests/test_a8w4_fmoe.py -t 512 -s 4096,256,256,8
"""

import argparse
import functools
import itertools
import os
import sys

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
from aiter import ActivationType, QuantType, dtypes
from aiter.fused_moe import (
    fused_moe,
    fused_topk,
    moe_sorting,
    torch_moe_stage1,
    torch_moe_stage2,
)
from aiter.jit.utils.chip_info import get_gfx
from aiter.ops.flydsl.kernels.act import silu_mul_batch
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import (
    _pack_activation,
    channel_exponents,
    quantize_rows,
)
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
from aiter.ops.flydsl.moe_common import GateMode
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
from aiter.test_common import benchmark, checkAllclose, run_perftest

SUPPORTED_GFX = ["gfx942"]  # FP8-FNUZ MFMA + global bf16x2 atomics
ROUTINGS = ["uniform", "hot"]
# "hot" routing: 1/32 of the experts get this score bias, so they land in most
# tokens' top-k (a few experts own a large share of the routed rows).
HOT_EXPERT_DIV = 32
HOT_EXPERT_BIAS = 2.0


# =============================================================================
# Device helpers: fp4 -> fp8 decode, channel factor, MFMA (as test_a8w4_gemm1/2)
# =============================================================================


def _perm_u32(hi, lo, sel):
    return fx.Uint32(
        rocdl.perm_b32(
            fx.Uint32(hi).ir_value(), fx.Uint32(lo).ir_value(), fx.Uint32(sel).ir_value()
        )
    )


def _fp8_lut(group_code, max_code, flush_tiny):
    """8-entry ``|E2M1| * 2**(5-delta)`` -> FP8-FNUZ byte table + sign-mask table
    (0x80 for every non-zero entry; FNUZ has no -0)."""
    difference = max_code - group_code
    delta = fx.min(difference, 11).to(fx.Uint32) * fx.Uint32(0x08080808)
    lo = (fx.Uint32(0x6C686080) - delta) & fx.Uint32(0xFFFFFF00)
    hi = fx.Uint32(0x7C787470) - delta
    if const_expr(flush_tiny):
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
    sign_lo = (lo + fx.Uint32(0x7F7F7F7F)) & fx.Uint32(0x80808080)
    sign_hi = (hi + fx.Uint32(0x7F7F7F7F)) & fx.Uint32(0x80808080)
    return lo, hi, sign_lo, sign_hi


def _fp4x8_to_fp8x8(raw, lut):
    """Eight consecutive FP4 nibbles (one i32) -> v8 FP8-FNUZ MFMA operand."""
    raw = fx.Uint32(raw)
    lo, hi, sign_lo, sign_hi = lut
    sel_even = raw & 0x07070707
    sel_odd = (raw >> 4) & 0x07070707
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


def _flat_buffer(arg, elem_ty, align):
    ptr = global_typed_ptr(arg, elem_ty, align=align)
    view = fx.Tensor(fx.make_view(ptr, fx.make_layout((1, 1), (1, 1))))
    return fx.rocdl.make_buffer_tensor(view, max_size=True)


# @flyc.jit is LOAD-BEARING: it AST-rewrites ``if token < i32_M`` into an scf.if
# (as a plain function the guard would be dropped at trace and padding rows would
# fire atomics). Row/col counts are constant per kernel.
@flyc.jit
def _scatter_rows(
    lds_stage_i32, arg_out, arg_stids, m_row, n_base, i32_M, ROWS, THREADS, N_OUT, BN
):
    """Scatter the weighted bf16 [ROWS, BN] LDS tile: (THREADS/32 rows x 32 lanes x
    2 cols) per pass, ``global_atomic_pk_add_bf16`` into ``out[token, n_base:]``."""
    rows_per_pass = THREADS // 32
    tx = fx.Int32(gpu.thread_id("x"))
    m_lane = tx // fx.Int32(32)
    col_start = (tx % fx.Int32(32)) * fx.Int32(2)
    stids = _flat_buffer(arg_stids, T.i32, 4)
    load_i32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
    out_base = _global_base_ptr1(arg_out)
    for p in range_constexpr(ROWS // rows_per_pass):
        r = fx.Int32(p * rows_per_pass) + m_lane
        frag = fx.make_rmem_tensor(1, fx.Int32)
        fx.copy(load_i32, stids[None, m_row + r], frag)
        tok = Vec(frag.load())[0] & fx.Int32(0x00FFFFFF)
        if tok < i32_M:  # padding rows carry a sentinel token id
            row_addr = tok * fx.Int32(N_OUT) + n_base + col_start
            for s in range_constexpr(BN // 64):
                pk = lds_vec_load(
                    lds_stage_i32,
                    (r * fx.Int32(BN) + col_start + fx.Int32(s * 64)) * fx.Int32(2),
                    Vec.make_type(2, fx.BFloat16),
                    fx.BFloat16,
                    align=4,
                )
                llvm.AtomicRMWOp(
                    llvm.AtomicBinOp.fadd,
                    _gep1(out_base, (row_addr + fx.Int32(s * 64)) * fx.Int32(2)),
                    _raw(pk),
                    llvm.AtomicOrdering.monotonic,
                    syncscope="agent",
                    alignment=4,
                )


# =============================================================================
# Kernel
# =============================================================================


@functools.cache
def compile_a8w4_fmoe(
    *,
    D_HIDDEN,
    D_INTER,
    NE,
    BM=32,
    NUM_WAVES=16,
    TILE_K1=256,
    N2_PER_WAVE=16,
    b_cache_mod1=1,
    b_cache_mod2=2,
    xcd_swizzle=1,
    waves_per_eu=None,
    flush_tiny=True,
    a2_in_regs=True,
):
    """Build the fused A8W4 MoE launcher (SiLU, SEPARATED gate|up, atomic out).

    One workgroup (``NUM_WAVES`` waves) per sorted m-block. gemm1: wave w owns
    gate/up columns [w*I/NW, (w+1)*I/NW). gemm2: ``N2_PER_WAVE`` model_dim columns
    per wave per step (TILE_N2 = NW * N2_PER_WAVE).

    ``a2_in_regs``: after the requant, every wave reads the whole BM x I fp8 A2
    tile from LDS once into VGPRs (BM/16 * I/32 * 2 regs: 32 at bm32/i256) and
    reuses it for all model_dim slices, instead of re-reading LDS per slice. The
    phase-1 registers are dead by then, so the kernel's peak VGPR count is
    unchanged. With A2 in VGPRs region0 is free in gemm2, so when the
    BM x TILE_N2 bf16 scatter stage fits it, the stage alternates between
    region1 / region0 per slice and the trailing per-slice barrier is dropped.

    Launch args (raw device pointers): ``x`` fp8 [tokens, H], ``x_scale`` f32
    [tokens], ``w1`` mxfp4 [E, 2I, H/2], ``w1_scale`` e8m0, ``w1_exp`` int32
    [E, 2I], ``w2`` mxfp4 [E, H, I/2], ``w2_scale`` e8m0, ``w2_exp`` int32 [E, H]
    (``channel_exponents``), ``sorted_expert_ids``, ``num_valid_ids``,
    ``sorted_ids``, ``sorted_weights``, ``out`` bf16 [tokens, H] (zeroed,
    atomically accumulated), then ``tokens``, ``grid``, stream.
    """
    H = D_HIDDEN  # gemm1 K, gemm2 N
    INTER = D_INTER  # gemm1 N (x2 gate|up), gemm2 K
    NW = NUM_WAVES
    THREADS = 64 * NW
    I_PER_WAVE = INTER // NW
    TILE_N2 = NW * N2_PER_WAVE
    assert H % TILE_K1 == 0 and TILE_K1 % 256 == 0, f"bad H={H} / TILE_K1={TILE_K1}"
    assert INTER % 256 == 0, f"inter_dim must be a multiple of 256, got {INTER}"
    assert I_PER_WAVE % 16 == 0, f"inter_dim/num_waves must be a multiple of 16"
    assert N2_PER_WAVE % 16 == 0 and H % TILE_N2 == 0 and TILE_N2 % 64 == 0
    assert BM % 16 == 0 and BM % NW == 0 and BM % (THREADS // 32) == 0, f"bad BM={BM}"
    assert (BM * TILE_K1) % (THREADS * 8) == 0, "A1 tile must be whole 8 B/thread"

    N_OUT1 = 2 * INTER
    M_REPEAT = BM // 16
    N_REPEAT1 = I_PER_WAVE // 16  # 16-col blocks per wave (gate and up each)
    N_REPEAT2 = N2_PER_WAVE // 16
    K1_TILES = H // TILE_K1
    K1_STEPS = TILE_K1 // 32
    K1_GROUPS = TILE_K1 // 128
    K2_STEPS = INTER // 32  # gemm2 K = inter_dim: a single K tile
    K2_GROUPS = INTER // 128
    N2_TILES = H // TILE_N2
    # A1 gather: 16 B per thread copy when the tile allows it, else 8 B.
    A1_COPY = 16 if (BM * TILE_K1) % (THREADS * 16) == 0 else 8
    A1_LOADS = BM * TILE_K1 // (THREADS * A1_COPY)
    A1_SLOT = BM * TILE_K1  # one A1 tile; two slots (ping/pong) when K1_TILES > 1
    COLS_PER_LANE = INTER // 64  # requant pass: one wave per row, 64 lanes

    # LDS regions (bytes), reused across phases.
    R0 = max(BM * TILE_K1 * (2 if H > TILE_K1 else 1), BM * INTER)  # A1 x2 -> A2
    R1 = max(BM * INTER * 2, BM * TILE_N2 * 2)  # bf16 intermediate -> scatter stage
    # f32 A2 row scales: in region0's slack behind the A2 tile when it fits (keeps
    # e.g. bm32/nw8 at exactly 32 KB -> 2 workgroups per CU), else a 3rd region.
    R2_OFF = BM * INTER if BM * INTER + BM * 4 <= R0 else R0 + R1
    LDS_BYTES = max(R0 + R1, R2_OFF + BM * 4)
    # gemm2 scatter stage double-buffered over region1/region0: region0 (A2) is free
    # in phase 2 once A2 lives in VGPRs -> one barrier per model_dim slice.
    DB_STAGE = a2_in_regs and N2_TILES > 1 and BM * TILE_N2 * 2 <= R0

    # mxfp4 preshuffle (bytes): (N/16, K/128, klane=4, nlane=16, kpack=16); e8m0
    # preshuffle (dwords): (N/32, Kpad/256, klane=4, nlane=16) x [kpack2 x npack2].
    W1_K0, W2_K0 = H // 128, INTER // 128
    W1_BYTES, W2_BYTES = NE * N_OUT1 * H // 2, NE * H * INTER // 2
    SC1_STRIDE = ((H + 255) // 256) * 64
    SC2_STRIDE = ((INTER + 255) // 256) * 64
    WS1_BYTES = NE * N_OUT1 * (((H + 255) // 256) * 8)
    WS2_BYTES = NE * H * (((INTER + 255) // 256) * 8)

    ftz_tag = "_ftz" if flush_tiny else ""
    wpe_tag = f"_w{waves_per_eu}" if waves_per_eu else ""
    kname = (
        f"a8w4_fmoe_h{H}_i{INTER}_ne{NE}_bm{BM}_nw{NW}_tk{TILE_K1}_tn{TILE_N2}"
        f"_bcm{b_cache_mod1}{b_cache_mod2}_xcd{xcd_swizzle}{wpe_tag}{ftz_tag}"
        f"{'_a2r' if a2_in_regs else ''}{'_db' if DB_STAGE else ''}"
    )

    def _body(
        lds_ptr,
        arg_x,
        arg_x_scale,
        arg_w1,
        arg_w1_scale,
        arg_w1_exp,
        arg_w2,
        arg_w2_scale,
        arg_w2_exp,
        arg_eids,
        arg_stids,
        arg_sweights,
        arg_out,
        i32_ntok,
        m_block,
        lane,
        wave,
    ):
        lane_div_16 = lane // fx.Int32(16)
        lane_mod_16 = lane % fx.Int32(16)
        tx = fx.Int32(gpu.thread_id("x"))
        e = rocdl.readfirstlane(T.i32, _raw(_global_i32_at(arg_eids, m_block)))
        m_row = m_block * fx.Int32(BM)  # first sorted row of this m-block
        inter_i32 = fx.Int32(INTER)
        mma_atom = fx.make_mma_atom(fx.rocdl.MFMA(16, 16, 32, fx.Float8E4M3FNUZ))

        # ---- LDS views --------------------------------------------------------
        lds_base = fx.Int32(fx.ptrtoint(lds_ptr))
        lds_r1 = lds_base + fx.Int32(R0)  # bf16 intermediate / scatter stage
        lds_r2 = lds_base + fx.Int32(R2_OFF)  # f32 row scales
        r0_flat = fx.make_view(
            fx.recast_iter(fx.Int32, lds_ptr), fx.make_layout(R0 // 4, 1)
        )
        r0_tiles16 = fx.logical_divide(r0_flat, fx.make_layout(4, 1))
        r0_tiles8 = fx.logical_divide(r0_flat, fx.make_layout(2, 1))
        lds_write_atom = fx.make_copy_atom(fx.UniversalCopy128b(), fx.Int32)
        lds_read_atom = fx.make_copy_atom(fx.UniversalCopy64b(), fx.Int32)
        r0_i32 = lds_typed_ptr(lds_base, T.i32)
        r1_bf16 = lds_typed_ptr(lds_r1, T.bf16)
        r2_f32 = lds_typed_ptr(lds_r2, T.f32)

        def _swizzle(row, col_bytes, tile_k):
            # A-LDS XOR swizzle (16 B granules): bank-conflict-free MFMA A reads.
            return col_bytes ^ ((row & fx.Int32(tile_k // 16 - 1)) * fx.Int32(16))

        def load_a(mi, ku, tile_k, slot_bytes=0):
            """v8 fp8 A fragment of K-step ku from a swizzled region0 tile."""
            row = lane_mod_16 + fx.Int32(mi * 16)
            col = lane_div_16 * fx.Int32(32) + fx.Int32((ku // 4) * 128 + (ku % 4) * 8)
            off = (row * fx.Int32(tile_k) + _swizzle(row, col, tile_k)) // fx.Int32(8)
            off = off + fx.Int32(slot_bytes) // fx.Int32(8)
            r = fx.make_rmem_tensor(fx.make_layout(2, 1), fx.Int32)
            fx.copy_atom_call(lds_read_atom, fx.slice(r0_tiles8, (None, off)), r)
            return fx.Vector(fx.memref_load_vec(r)).bitcast(fx.Float8E4M3FNUZ)

        def load_w_codes(ws_tiles, ws_atom, sc_base, npack, G_count, s_off):
            """e8m0 bytes of 128-K groups 0..G_count-1 (dword G//2, byte (G%2)*2+npack)."""
            packed = [
                _buffer_i32_scalar_read(
                    ws_tiles, sc_base + s_off + fx.Int32(G2 * 64), ws_atom
                )
                for G2 in range_constexpr((G_count + 1) // 2)
            ]
            return [
                packed[G // 2].shrui(fx.Int32((G % 2) * 16) + npack * fx.Int32(8))
                & fx.Int32(0xFF)
                for G in range_constexpr(G_count)
            ]

        # =====================================================================
        # Phase 1: gemm1 (gate | up) over K = H, software-pipelined: tile kt+1 (A1
        # via VGPRs into the other LDS slot, W1 into staging VGPRs) is loaded while
        # kt computes; one barrier per tile.
        # =====================================================================
        x_tiles = fx.logical_divide(
            _global_i32_buffer_view(arg_x, fx.Int64(i32_ntok) * fx.Int64(H)),
            fx.make_layout(A1_COPY // 4, 1),
        )
        x_atom = fx.make_copy_atom(
            fx.rocdl.BufferCopy128b(2) if A1_COPY == 16 else fx.rocdl.BufferCopy64b(2),
            fx.Int32,
        )
        r0_tiles_a1 = r0_tiles16 if A1_COPY == 16 else r0_tiles8
        a1_write_atom = lds_write_atom if A1_COPY == 16 else lds_read_atom
        a_src_tile, a_dst_tile = [], []
        for i in range_constexpr(A1_LOADS):
            idx_b = tx * fx.Int32(A1_COPY) + fx.Int32(i * THREADS * A1_COPY)
            row = idx_b // fx.Int32(TILE_K1)
            col_bytes = idx_b % fx.Int32(TILE_K1)
            fused = fx.Int32(_global_i32_at(arg_stids, m_row + row))
            row_bytes = (fused & fx.Int32(0x00FFFFFF)) * fx.Int32(H)
            a_src_tile.append(
                (row_bytes + _swizzle(row, col_bytes, TILE_K1)) // fx.Int32(A1_COPY)
            )
            a_dst_tile.append((row * fx.Int32(TILE_K1) + col_bytes) // fx.Int32(A1_COPY))
        a1_regs = [
            fx.make_rmem_tensor(fx.make_layout(A1_COPY // 4, 1), fx.Int32)
            for _ in range(A1_LOADS)
        ]

        def load_a1_global(base_k):
            kc = base_k // fx.Int32(A1_COPY)
            for i in range_constexpr(A1_LOADS):
                fx.copy(x_atom, fx.slice(x_tiles, (None, a_src_tile[i] + kc)), a1_regs[i])

        def store_a1_lds(slot):
            sc = fx.Int32(slot) * fx.Int32(A1_SLOT // A1_COPY)
            for i in range_constexpr(A1_LOADS):
                fx.copy(
                    a1_write_atom,
                    a1_regs[i],
                    fx.slice(r0_tiles_a1, (None, a_dst_tile[i] + sc)),
                )

        w1_tiles = _global_i32_buffer_tiles(arg_w1, min(W1_BYTES, 0xFFFFFFFF), 4)
        w1_atom = fx.make_copy_atom(fx.rocdl.BufferCopy128b(b_cache_mod1), fx.Int32)
        ws1_tiles = _global_i32_buffer_tiles(arg_w1_scale, min(WS1_BYTES, 0xFFFFFFFF), 1)
        ws_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(0), fx.Int32)
        expert_off1 = e * fx.Int32(N_OUT1)
        out_cols1 = []  # this lane's intermediate column per ni
        w1_base, sc1_base, sc1_npack = {}, {}, {}
        for ni in range_constexpr(N_REPEAT1):
            n_local = wave * fx.Int32(I_PER_WAVE) + fx.Int32(ni * 16)
            out_cols1.append(n_local + lane_mod_16)
            for gu in range_constexpr(2):
                n0 = expert_off1 + n_local + (inter_i32 if gu else fx.Int32(0))
                w1_base[gu, ni] = (
                    (n0 // fx.Int32(16)) * fx.Int32(W1_K0 * 64)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                sc1_base[gu, ni] = (
                    (n0 // fx.Int32(32)) * fx.Int32(SC1_STRIDE)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                sc1_npack[gu, ni] = (n0 // fx.Int32(16)) % fx.Int32(2)
        exp1 = [
            [
                fx.Int32(
                    _global_i32_at(
                        arg_w1_exp,
                        expert_off1 + c + (inter_i32 if gu else fx.Int32(0)),
                    )
                )
                for c in out_cols1
            ]
            for gu in range(2)
        ]
        # W1 staging registers (raw fp4 dwordx4 + packed e8m0 dwords) of one tile.
        w1_regs = {
            (gu, ni, g): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
            for gu in range(2)
            for ni in range(N_REPEAT1)
            for g in range(K1_GROUPS)
        }
        s1_regs = {
            (gu, ni, g2): fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32)
            for gu in range(2)
            for ni in range(N_REPEAT1)
            for g2 in range((K1_GROUPS + 1) // 2)
        }

        def load_w1_global(base_k):
            s_off = (base_k // fx.Int32(256)) * fx.Int32(64)
            for (gu, ni, g2), r in s1_regs.items():
                idx = sc1_base[gu, ni] + s_off + fx.Int32(g2 * 64)
                fx.copy(ws_atom, fx.slice(ws1_tiles, (None, idx)), r)
            w_off = (base_k // fx.Int32(128)) * fx.Int32(64)
            for (gu, ni, g), r in w1_regs.items():
                idx = w1_base[gu, ni] + w_off + fx.Int32(g * 64)
                fx.copy(w1_atom, fx.slice(w1_tiles, (None, idx)), r)

        def read_w1():
            raw, codes = {}, {}
            for (gu, ni, g), r in w1_regs.items():
                v4 = fx.Vector(fx.memref_load_vec(r))
                raw[gu, ni, g] = [fx.Int32(v4[j]) for j in range(4)]
                packed = fx.Int32(fx.Vector(fx.memref_load_vec(s1_regs[gu, ni, g // 2]))[0])
                codes[gu, ni, g] = packed.shrui(
                    fx.Int32((g % 2) * 16) + sc1_npack[gu, ni] * fx.Int32(8)
                ) & fx.Int32(0xFF)
            return raw, codes

        acc_layout = fx.make_layout(4, 1)
        zero4 = fx.Vector.filled(4, 0.0, fx.Float32)
        acc1 = [
            [
                [fx.make_rmem_tensor(acc_layout, fx.Float32) for _ in range(N_REPEAT1)]
                for _ in range(M_REPEAT)
            ]
            for _ in range(2)
        ]
        for gu in range_constexpr(2):
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT1):
                    acc1[gu][mi][ni].store(zero4)

        def compute1(w_tile, slot):
            raw, codes = w_tile
            for ni in range_constexpr(N_REPEAT1):
                luts = [
                    [
                        _fp8_lut(codes[gu, ni, g], exp1[gu][ni], flush_tiny)
                        for g in range_constexpr(K1_GROUPS)
                    ]
                    for gu in range_constexpr(2)
                ]
                for ku in range_constexpr(K1_STEPS):
                    bs = [
                        _fp4x8_to_fp8x8(raw[gu, ni, ku // 4][ku % 4], luts[gu][ku // 4])
                        for gu in range_constexpr(2)
                    ]
                    for mi in range_constexpr(M_REPEAT):
                        a8 = load_a(mi, ku, TILE_K1, fx.Int32(slot) * fx.Int32(A1_SLOT))
                        for gu in range_constexpr(2):
                            _mma_fp8(mma_atom, acc1[gu][mi][ni], a8, bs[gu])

        def stage1(kt, slot, prefetch):
            rocdl.s_waitcnt(lgkmcnt=0)
            gpu.barrier()  # A1(kt) in LDS; slot (kt+1)%2 free
            w_tile = read_w1()
            if const_expr(prefetch):
                next_k = (kt + fx.Int32(1)) * fx.Int32(TILE_K1)
                load_a1_global(next_k)
                load_w1_global(next_k)
                rocdl.sched_barrier(0)  # keep the prefetch ahead of the MFMAs
            compute1(w_tile, slot)
            if const_expr(prefetch):
                store_a1_lds(fx.Int32(1) - slot)

        load_a1_global(fx.Int32(0))
        load_w1_global(fx.Int32(0))
        store_a1_lds(0)

        # range() lowers to scf.for only inside an AST-rewritten (@flyc.jit) function.
        @flyc.jit
        def _k1_loop(k_first):
            for kt in range(K1_TILES - 1):
                kt_i = k_first + fx.Int32(kt)
                stage1(kt_i, kt_i % fx.Int32(2), True)

        if const_expr(K1_TILES > 1):
            _k1_loop(fx.Int32(0))
        stage1(fx.Int32(K1_TILES - 1), (K1_TILES - 1) % 2, False)

        # ---- gemm1 epilogue: dequant -> SiLU(g)*u -> bf16 intermediate in LDS ---
        xs_tiles = _global_i32_buffer_tiles(
            arg_x_scale, fx.Int64(i32_ntok) * fx.Int64(4), 1
        )
        xs_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
        f1 = [[_channel_factor(x) for x in exp1[gu]] for gu in range(2)]
        for mi in range_constexpr(M_REPEAT):
            for ii in range_constexpr(4):
                row = fx.Int32(mi * 16 + ii) + lane_div_16 * fx.Int32(4)
                token = fx.Int32(_global_i32_at(arg_stids, m_row + row)) & fx.Int32(
                    0x00FFFFFF
                )
                # Padding rows: token >= tokens reads 0 (clamped resource) -> y = 0.
                rs = _buffer_i32_scalar_read(xs_tiles, token, xs_atom).bitcast(
                    fx.Float32
                )
                for ni in range_constexpr(N_REPEAT1):
                    g = fx.Float32(fx.Vector(fx.memref_load_vec(acc1[0][mi][ni]))[ii])
                    u = fx.Float32(fx.Vector(fx.memref_load_vec(acc1[1][mi][ni]))[ii])
                    y = silu_mul_batch([g * (rs * f1[0][ni])], [u * (rs * f1[1][ni])])[0]
                    r1_bf16[row * inter_i32 + out_cols1[ni]] = y.to(fx.BFloat16)
        gpu.barrier()

        # ---- per-row FP8 requant (== a8w4.quantize_rows of the bf16 rows) ------
        # One wave per row, 64 lanes x COLS_PER_LANE cols; A2 is written straight
        # into gemm2's swizzled region0 layout, the f32 row scale into region2.
        for j in range_constexpr(BM // NW):
            row = wave + fx.Int32(j * NW)
            col0 = lane * fx.Int32(COLS_PER_LANE)
            vals = []
            for q in range_constexpr(COLS_PER_LANE // 4):
                v4 = Vec(
                    lds_vec_load(
                        lds_r1,
                        (row * inter_i32 + col0 + fx.Int32(q * 4)) * fx.Int32(2),
                        Vec.make_type(4, fx.BFloat16),
                        fx.BFloat16,
                        align=8,
                    )
                ).to(fx.Float32)
                vals.append(v4)
            amax = fx.Float32(0.0)
            for v4 in vals:
                for k in range_constexpr(4):
                    amax = fx.max(amax, fx.max(v4[k], -v4[k]))
            for bit in range_constexpr(6):
                amax = fx.max(amax, amax.shuffle_xor(1 << bit, 64))
            s = (amax == 0.0).select(fx.Float32(1.0), amax / 240.0)
            inv = 1.0 / s
            r2_f32[row] = s  # every lane writes the same value
            for q in range_constexpr(COLS_PER_LANE // 4):
                v = vals[q] * inv
                packed = _pack_activation(v[0], v[1], v[2], v[3])
                c = _swizzle(row, col0 + fx.Int32(q * 4), INTER)
                r0_i32[(row * inter_i32 + c) // fx.Int32(4)] = packed
        gpu.barrier()

        # =====================================================================
        # Phase 2: gemm2 over model_dim slices; A2 (BM x INTER fp8) stays in LDS
        # =====================================================================
        w2_tiles = _global_i32_buffer_tiles(arg_w2, min(W2_BYTES, 0xFFFFFFFF), 4)
        w2_atom = fx.make_copy_atom(fx.rocdl.BufferCopy128b(b_cache_mod2), fx.Int32)
        ws2_tiles = _global_i32_buffer_tiles(arg_w2_scale, min(WS2_BYTES, 0xFFFFFFFF), 1)
        expert_off2 = e * fx.Int32(H)
        sw_tiles = _global_i32_buffer_tiles(arg_sweights, fx.Int64(0xFFFFFFFF), 1)
        # Row factors in MFMA layout (row = mi*16 + (L//16)*4 + v), N-invariant:
        # a2_scale (LDS) and the routing weight.
        if const_expr(a2_in_regs):
            # Whole A2 tile -> VGPRs once (MFMA A-fragment layout), reused by every
            # model_dim slice below.
            a2_frags = [
                [load_a(mi, ku, INTER) for ku in range_constexpr(K2_STEPS)]
                for mi in range_constexpr(M_REPEAT)
            ]
        row_a2s, row_w = [], []
        for mi in range_constexpr(M_REPEAT):
            rows = [
                fx.Int32(mi * 16 + v) + lane_div_16 * fx.Int32(4)
                for v in range_constexpr(4)
            ]
            row_a2s.append([fx.Float32(r2_f32[r]) for r in rows])
            row_w.append(
                [
                    _buffer_i32_scalar_read(sw_tiles, m_row + r, ws_atom).bitcast(
                        fx.Float32
                    )
                    for r in rows
                ]
            )

        acc2 = [
            [fx.make_rmem_tensor(acc_layout, fx.Float32) for _ in range(N_REPEAT2)]
            for _ in range(M_REPEAT)
        ]

        # W2 staging registers of one TILE_N2 slice (prefetched one slice ahead).
        w2_regs = {
            (ni, g): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
            for ni in range(N_REPEAT2)
            for g in range(K2_GROUPS)
        }
        s2_regs = {
            (ni, g2): fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32)
            for ni in range(N_REPEAT2)
            for g2 in range((K2_GROUPS + 1) // 2)
        }
        e2_regs = [fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32) for _ in range(N_REPEAT2)]
        e_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
        we2_tiles = _global_i32_buffer_tiles(arg_w2_exp, min(NE * H * 4, 0xFFFFFFFF), 1)

        def n2_col0(n_base, ni):
            return expert_off2 + n_base + wave * fx.Int32(N2_PER_WAVE) + fx.Int32(ni * 16)

        def load_w2_global(n_base):
            for ni in range_constexpr(N_REPEAT2):
                n0 = n2_col0(n_base, ni)
                fx.copy(e_atom, fx.slice(we2_tiles, (None, n0 + lane_mod_16)), e2_regs[ni])
                sc = (
                    (n0 // fx.Int32(32)) * fx.Int32(SC2_STRIDE)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                for g2 in range_constexpr((K2_GROUPS + 1) // 2):
                    fx.copy(
                        ws_atom,
                        fx.slice(ws2_tiles, (None, sc + fx.Int32(g2 * 64))),
                        s2_regs[ni, g2],
                    )
                base = (
                    (n0 // fx.Int32(16)) * fx.Int32(W2_K0 * 64)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                for g in range_constexpr(K2_GROUPS):
                    fx.copy(
                        w2_atom,
                        fx.slice(w2_tiles, (None, base + fx.Int32(g * 64))),
                        w2_regs[ni, g],
                    )

        def read_w2(n_base):
            raw, codes, exps = [], [], []
            for ni in range_constexpr(N_REPEAT2):
                npack = (n2_col0(n_base, ni) // fx.Int32(16)) % fx.Int32(2)
                per_g, cod = [], []
                for g in range_constexpr(K2_GROUPS):
                    v4 = fx.Vector(fx.memref_load_vec(w2_regs[ni, g]))
                    per_g.append([fx.Int32(v4[j]) for j in range(4)])
                    packed = fx.Int32(fx.Vector(fx.memref_load_vec(s2_regs[ni, g // 2]))[0])
                    cod.append(
                        packed.shrui(fx.Int32((g % 2) * 16) + npack * fx.Int32(8))
                        & fx.Int32(0xFF)
                    )
                raw.append(per_g)
                codes.append(cod)
                exps.append(fx.Int32(fx.Vector(fx.memref_load_vec(e2_regs[ni]))[0]))
            return raw, codes, exps

        def stage2(n_base, prefetch, buf):
            """One TILE_N2 slice: W2(n_base) is in the staging registers; the bf16
            scatter stage goes to buffer ``buf`` (0: region1, 1: region0)."""
            raw, codes, exps = read_w2(n_base)
            if const_expr(prefetch):
                load_w2_global(n_base + fx.Int32(TILE_N2))
                rocdl.sched_barrier(0)  # keep the prefetch ahead of the MFMAs
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT2):
                    acc2[mi][ni].store(zero4)
            for ni in range_constexpr(N_REPEAT2):
                luts = [
                    _fp8_lut(codes[ni][g], exps[ni], flush_tiny)
                    for g in range_constexpr(K2_GROUPS)
                ]
                for ku in range_constexpr(K2_STEPS):
                    b8 = _fp4x8_to_fp8x8(raw[ni][ku // 4][ku % 4], luts[ku // 4])
                    for mi in range_constexpr(M_REPEAT):
                        a8 = (
                            a2_frags[mi][ku]
                            if const_expr(a2_in_regs)
                            else load_a(mi, ku, INTER)
                        )
                        _mma_fp8(mma_atom, acc2[mi][ni], a8, b8)
            # dequant * route weight -> bf16 stage [BM, TILE_N2]
            if const_expr(DB_STAGE):
                stage_i32 = (fx.Int32(buf) == fx.Int32(0)).select(lds_r1, lds_base)
            else:
                stage_i32 = lds_r1
            stage_bf16 = lds_typed_ptr(stage_i32, T.bf16)
            f2 = [_channel_factor(x) for x in exps]
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT2):
                    v = Vec(acc2[mi][ni].load())
                    bf4 = Vec.from_elements(
                        [
                            v[k] * (row_a2s[mi][k] * f2[ni]) * row_w[mi][k]
                            for k in range_constexpr(4)
                        ],
                        fx.Float32,
                    ).to(fx.BFloat16)
                    col = wave * fx.Int32(N2_PER_WAVE) + fx.Int32(ni * 16) + lane_mod_16
                    for k in range_constexpr(4):
                        r = fx.Int32(mi * 16 + k) + lane_div_16 * fx.Int32(4)
                        stage_bf16[r * fx.Int32(TILE_N2) + col] = bf4[k]
            gpu.barrier()
            _scatter_rows(
                stage_i32, arg_out, arg_stids, m_row, n_base, i32_ntok, BM, THREADS,
                H, TILE_N2,
            )
            if const_expr(not DB_STAGE):
                gpu.barrier()  # stage reads done before the next slice overwrites it
            # DB_STAGE: slice j+1 writes the other buffer; the one slice j+2 reuses
            # was last read before every wave passed slice j+1's barrier.

        load_w2_global(fx.Int32(0))

        @flyc.jit
        def _n2_loop(n_first):
            for nt in range(N2_TILES - 1):
                nt_i = n_first + fx.Int32(nt)
                stage2(nt_i * fx.Int32(TILE_N2), True, nt_i % fx.Int32(2))

        if const_expr(N2_TILES > 1):
            _n2_loop(fx.Int32(0))
        stage2(fx.Int32((N2_TILES - 1) * TILE_N2), False, (N2_TILES - 1) % 2)

    @fx.struct
    class SharedStorage:
        raw: fx.Array[fx.Uint8, LDS_BYTES, 16]

    @flyc.jit
    def _entry(
        arg_x,
        arg_x_scale,
        arg_w1,
        arg_w1_scale,
        arg_w1_exp,
        arg_w2,
        arg_w2_scale,
        arg_w2_exp,
        arg_eids,
        arg_cumsum,
        arg_stids,
        arg_sweights,
        arg_out,
        i32_ntok,
    ):
        lds_ptr = fx.SharedAllocator().allocate(SharedStorage).peek().raw.ptr
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        lane = tx % fx.Int32(64)
        wave = rocdl.readfirstlane(T.i32, tx // fx.Int32(64))
        bound = _global_i32_at(arg_cumsum, fx.Int32(0)) // fx.Int32(BM)

        # Bijective XCD round-robin over valid m-blocks.
        NXCD = 8
        xq = _udiv(bound, NXCD)
        xr = _umod(bound, NXCD)

        def _xcd(pid):
            if const_expr(xcd_swizzle <= 0):
                return pid
            xc = _umod(pid, NXCD)
            return xc * xq + fx.min(xc, xr) + _udiv(pid, NXCD)

        if bx < bound:
            _body(
                lds_ptr,
                arg_x,
                arg_x_scale,
                arg_w1,
                arg_w1_scale,
                arg_w1_exp,
                arg_w2,
                arg_w2_scale,
                arg_w2_exp,
                arg_eids,
                arg_stids,
                arg_sweights,
                arg_out,
                i32_ntok,
                _xcd(bx),
                lane,
                wave,
            )

    @flyc.kernel(name=kname, known_block_size=[THREADS, 1, 1])
    def a8w4_fmoe_kernel(
        arg_x: fx.Int64,
        arg_x_scale: fx.Int64,
        arg_w1: fx.Int64,
        arg_w1_scale: fx.Int64,
        arg_w1_exp: fx.Int64,
        arg_w2: fx.Int64,
        arg_w2_scale: fx.Int64,
        arg_w2_exp: fx.Int64,
        arg_eids: fx.Int64,
        arg_cumsum: fx.Int64,
        arg_stids: fx.Int64,
        arg_sweights: fx.Int64,
        arg_out: fx.Int64,
        i32_ntok: fx.Int32,
    ):
        _entry(
            arg_x,
            arg_x_scale,
            arg_w1,
            arg_w1_scale,
            arg_w1_exp,
            arg_w2,
            arg_w2_scale,
            arg_w2_exp,
            arg_eids,
            arg_cumsum,
            arg_stids,
            arg_sweights,
            arg_out,
            i32_ntok,
        )

    @flyc.jit
    def launch(
        arg_x: fx.Int64,
        arg_x_scale: fx.Int64,
        arg_w1: fx.Int64,
        arg_w1_scale: fx.Int64,
        arg_w1_exp: fx.Int64,
        arg_w2: fx.Int64,
        arg_w2_scale: fx.Int64,
        arg_w2_exp: fx.Int64,
        arg_eids: fx.Int64,
        arg_cumsum: fx.Int64,
        arg_stids: fx.Int64,
        arg_sweights: fx.Int64,
        arg_out: fx.Int64,
        i32_ntok: fx.Int32,
        i32_grid: fx.Int32,
        stream: fx.Stream,
    ):
        a8w4_fmoe_kernel(
            arg_x,
            arg_x_scale,
            arg_w1,
            arg_w1_scale,
            arg_w1_exp,
            arg_w2,
            arg_w2_scale,
            arg_w2_exp,
            arg_eids,
            arg_cumsum,
            arg_stids,
            arg_sweights,
            arg_out,
            i32_ntok,
            value_attrs=(
                {"rocdl.waves_per_eu": waves_per_eu} if waves_per_eu else None
            ),
        ).launch(grid=(fx.Int64(i32_grid), 1, 1), block=(THREADS, 1, 1), stream=stream)

    return launch


# =============================================================================
# Host API
# =============================================================================


def a8w4_prepare_weights(w1, w2, w1_scale, w2_scale):
    """Weight-static prep (cache per weight in production): u8 views of the
    standard-preshuffled mxfp4 W1 [E, 2I, H/2] / W2 [E, H, I/2] + e8m0 scales and
    both per-output-channel max e8m0 exponents."""
    w1_u8, w2_u8 = w1.view(torch.uint8), w2.view(torch.uint8)
    s1 = w1_scale.view(torch.uint8).contiguous().view(-1)
    s2 = w2_scale.view(torch.uint8).contiguous().view(-1)
    return dict(
        w1=w1_u8,
        w2=w2_u8,
        w1_scale=s1,
        w2_scale=s2,
        w1_exp=channel_exponents(w1_u8, s1),
        w2_exp=channel_exponents(w2_u8, s2),
    )


def a8w4_fmoe(
    hidden_states,
    weights,
    topk_weights,
    topk_ids,
    *,
    block_m=32,
    num_waves=16,
    n2_per_wave=None,
    xcd_swizzle=1,
    flush_tiny=True,
    waves_per_eu=None,
    a2_in_regs=True,
):
    """SiLU SEPARATED A8W4 MoE in one kernel (+ moe_sorting + fp8 row-quant of x).
    Returns bf16 [tokens, model_dim]. ``n2_per_wave=None``: 16 at block_m>=32 (the
    double-buffered scatter stage then fits region0), else 32."""
    if n2_per_wave is None:
        n2_per_wave = 16 if block_m >= 32 else 32
    E, model_dim, _ = weights["w2"].shape
    inter_dim = weights["w1"].shape[1] // 2
    tokens = hidden_states.shape[0]
    sorted_ids, sorted_weights, sorted_expert_ids, num_valid_ids, moe_buf = (
        moe_sorting(topk_ids, topk_weights, E, model_dim, dtypes.bf16, block_m)[:5]
    )
    x_fp8, x_scale = quantize_rows(hidden_states)
    launch = compile_a8w4_fmoe(
        D_HIDDEN=model_dim,
        D_INTER=inter_dim,
        NE=E,
        BM=block_m,
        NUM_WAVES=num_waves,
        N2_PER_WAVE=n2_per_wave,
        xcd_swizzle=xcd_swizzle,
        flush_tiny=flush_tiny,
        waves_per_eu=waves_per_eu,
        a2_in_regs=a2_in_regs,
    )
    _run_compiled(
        launch,
        x_fp8.data_ptr(),
        x_scale.data_ptr(),
        weights["w1"].data_ptr(),
        weights["w1_scale"].data_ptr(),
        weights["w1_exp"].data_ptr(),
        weights["w2"].data_ptr(),
        weights["w2_scale"].data_ptr(),
        weights["w2_exp"].data_ptr(),
        sorted_expert_ids.data_ptr(),
        num_valid_ids.data_ptr(),
        sorted_ids.data_ptr(),
        sorted_weights.data_ptr(),
        moe_buf.data_ptr(),
        int(tokens),
        int(sorted_expert_ids.numel()),
        torch.cuda.current_stream(),
    )
    return moe_buf


def _two_kernel_moe():
    # 2-kernel reference pipeline (standalone gemm1 + gemm2) from the e2e test.
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from test_flydsl_moe_a16wfp4 import a8w4_fused_moe

    return a8w4_fused_moe


# =============================================================================
# Reference + test
# =============================================================================


def _cos_diff(x, y):
    x, y = x.double(), y.double()
    return float(1 - 2 * (x * y).sum() / (x * x + y * y).sum())


@benchmark()
def bench_a8w4_fmoe(
    token,
    model_dim,
    inter_dim,
    expert,
    topk,
    routing="uniform",
    block_m=32,
    num_waves=16,
):
    dtype = dtypes.bf16
    device = "cuda"
    torch.manual_seed(0)
    torch.cuda.manual_seed(0)

    # ---- inputs: same construction as test_flydsl_a16wfp4_silu_e2e -------------
    inp = torch.randn((token, model_dim), dtype=dtype, device=device)
    w1 = torch.randn((expert, inter_dim * 2, model_dim), dtype=dtype, device=device)
    w2 = torch.randn((expert, model_dim, inter_dim), dtype=dtype, device=device)
    score = torch.randn((token, expert), dtype=dtype, device=device)
    if routing == "hot":
        hot = torch.randperm(expert, device=device)[: max(1, expert // HOT_EXPERT_DIV)]
        score[:, hot] += HOT_EXPERT_BIAS
    else:
        assert routing == "uniform", f"unknown routing {routing!r}"
    topk_weights, topk_ids = fused_topk(inp, score, topk, True)

    tq = aiter.get_torch_quant(QuantType.per_1x32)
    w1_qt, w1_scale = tq(w1, quant_dtype=dtypes.fp4x2)
    w2_qt, w2_scale = tq(w2, quant_dtype=dtypes.fp4x2)
    del w1, w2
    w1_qt = w1_qt.view(expert, inter_dim * 2, model_dim // 2)
    w2_qt = w2_qt.view(expert, model_dim, inter_dim // 2)

    # bf16 SiLU SEPARATED reference (bf16 activations: measures the A8W4 loss too)
    o1 = torch_moe_stage1(
        inp,
        w1_qt.view(dtypes.fp4x2),
        w2_qt.view(dtypes.fp4x2),
        topk_weights,
        topk_ids,
        dtype=dtype,
        activation=ActivationType.Silu,
        quant_type=QuantType.per_1x32,
        a1_scale=None,
        w1_scale=w1_scale.view(expert, inter_dim * 2, model_dim // 32),
        doweight=False,
    )
    ref = torch_moe_stage2(
        o1.view(token, topk, inter_dim),
        w1_qt.view(dtypes.fp4x2),
        w2_qt.view(dtypes.fp4x2),
        topk_weights,
        topk_ids,
        dtype=dtype,
        quant_type=QuantType.per_1x32,
        w2_scale=w2_scale.view(expert, model_dim, inter_dim // 32),
        a2_scale=None,
        doweight=True,
    ).to(dtypes.fp32)

    # caller contract: standard GGUU (separated gate/up) layout
    w1_sh = shuffle_weight_a16w4(w1_qt, 16, False)
    w2_sh = shuffle_weight_a16w4(w2_qt, 16, False)
    w1_scale_sh = shuffle_scale_a16w4(w1_scale, expert, False)
    w2_scale_sh = shuffle_scale_a16w4(w2_scale, expert, False)
    weights = a8w4_prepare_weights(w1_sh, w2_sh, w1_scale_sh, w2_scale_sh)
    two_kernel = _two_kernel_moe()

    candidates = {
        # this file: gemm1 + requant + gemm2 in one kernel
        "fused": lambda: a8w4_fmoe(
            inp, weights, topk_weights, topk_ids, block_m=block_m, num_waves=num_waves
        ),
        # standalone gemm1 + quantize_rows + gemm2 (3 launches, same math)
        "2kernel": lambda: two_kernel(
            inp,
            {k: weights[k] for k in ("w1", "w2", "w1_scale", "w2_scale", "w1_exp")},
            topk_weights,
            topk_ids,
            block_m=32,
        ),
        # production fused_moe with the active tuned config (AITER_CONFIG_FMOE)
        "fused_moe": lambda: fused_moe(
            inp,
            w1_sh,
            w2_sh,
            topk_weights,
            topk_ids,
            w1_scale=w1_scale_sh,
            w2_scale=w2_scale_sh,
            quant_type=QuantType.per_1x32,
            activation=ActivationType.Silu,
            doweight_stage1=False,
            gate_mode=GateMode.SEPARATED.value,
        ),
    }

    w_bytes = sum(weights[k].numel() for k in ("w1", "w2", "w1_scale", "w2_scale"))
    n_hit = int(topk_ids.unique().numel())
    nbytes = w_bytes * n_hit // expert + token * model_dim * 3  # W + x(fp8) + out
    flops = 2 * token * topk * 3 * model_dim * inter_dim

    ret = {"gfx": get_gfx(), "experts hit": n_hit}
    outs = {}
    for name, fn in candidates.items():
        fn()  # JIT-compile outside the timed region
        torch.cuda.synchronize()
        out, us = run_perftest(fn)
        outs[name] = out.to(dtypes.fp32)
        ret[f"{name} us"] = us
        ret[f"{name} TB/s"] = nbytes / us / 1e6
        ret[f"{name} TFLOPS"] = flops / us / 1e6
        ret[f"{name} cos"] = _cos_diff(ref, outs[name])
    # Same A8W4 math as the 2-kernel path; only the bf16 atomic accumulation order
    # differs (topk partials of |out| ~ 1e4 here, bf16 ulp ~ 1e2), so atol scales
    # with the output magnitude.
    ret["fused vs 2kernel err"] = checkAllclose(
        outs["2kernel"],
        outs["fused"],
        rtol=2e-2,
        atol=2e-2 * outs["2kernel"].abs().mean().item(),
        msg="fused vs 2kernel: ",
    )
    ret["speedup vs 2kernel"] = ret["2kernel us"] / ret["fused us"]
    ret["speedup vs fused_moe"] = ret["fused_moe us"] / ret["fused us"]
    return ret


@pytest.mark.skipif(
    get_gfx() not in SUPPORTED_GFX, reason="A8W4 needs gfx942 FP8-FNUZ MFMA"
)
@pytest.mark.parametrize("model_dim,inter_dim,expert,topk", [(4096, 256, 256, 8)])
@pytest.mark.parametrize("token", [512])
@pytest.mark.parametrize("routing", ROUTINGS)
def test_a8w4_fmoe(token, model_dim, inter_dim, expert, topk, routing):
    """Mimo v2.6 shape: fused kernel vs 2-kernel A8W4 pipeline and a bf16 ref."""
    ret = bench_a8w4_fmoe(token, model_dim, inter_dim, expert, topk, routing=routing)
    assert ret["fused cos"] < 1e-2, f"fused cos diff too large {ret}"
    assert ret["fused vs 2kernel err"] <= 0.01, f"fused diverged from 2kernel {ret}"


def main():
    if get_gfx() not in SUPPORTED_GFX:
        aiter.logger.warning("a8w4 fmoe unsupported on %s; skipping", get_gfx())
        return

    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description="Single-kernel A8W4 fused MoE correctness / perf",
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
        default=[(32, 16), (16, 8)],
        help="block_m,num_waves  e.g. --tile 32,16 16,8",
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
    for (model_dim, inter_dim, expert, topk), token, routing, (block_m, nw) in (
        itertools.product(args.shape, args.token, args.routing, args.tile)
    ):
        df.append(
            bench_a8w4_fmoe(
                token,
                model_dim,
                inter_dim,
                expert,
                topk,
                routing=routing,
                block_m=block_m,
                num_waves=nw,
            )
        )
    df = pd.DataFrame(df)
    aiter.logger.info("a8w4 fmoe summary (markdown):\n%s", df.to_markdown(index=False))


if __name__ == "__main__":
    main()

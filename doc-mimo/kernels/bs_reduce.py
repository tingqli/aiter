# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""TOPK reduction for the blockscale MoE route buffer (gfx950).

Ported from tq/moe_gemm_blockscale (50ed9814c2):
gfx9_fp8/moe_reduce.py (invert_sorted_ids) and moe_packed_reduce.py (make_moe_sum).
"""

import functools

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl.expr import range_constexpr, rocdl

from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

from bs_common import _ptr, get_device_cache_key, rocdl_aux


def _scalar(value):
    return fx.Int32(rocdl.readfirstlane(fx.Int32.ir_type, value.ir_value()))


@functools.cache
def invert_sorted_ids(TOPK):
    """inverse[token, slot] = sorted position of (token, slot) (valid prefix only)."""
    num_threads = 64

    @flyc.kernel(known_block_size=[num_threads, 1, 1])
    def invert_sorted_ids_kernel(
        sorted_ids: fx.Pointer,
        invert: fx.Pointer,
        p_num_valid: fx.Pointer,
        num_ids: fx.Uint32,
        batch_size: fx.Uint32,
    ):
        batch = fx.block_idx.x
        tid = fx.thread_idx.x
        slot = batch * num_threads + tid
        num_valid = p_num_valid[0].to(fx.Uint32)
        if slot < num_valid:
            sid = sorted_ids[slot].to(fx.Uint32)
            tok_id = sid & 0xFFFFFF
            top_id = sid >> 24
            idx = tok_id * TOPK + top_id
            if top_id < TOPK and tok_id < batch_size:
                invert[idx] = fx.Uint32(slot)

    @flyc.jit
    def launch(
        sorted_ids: fx.Pointer,
        invert: fx.Pointer,
        p_num_valid: fx.Pointer,
        num_ids: fx.Uint32,
        batch_size: fx.Uint32,
        stream,
    ):
        grid_size = (num_ids + num_threads - 1) // num_threads
        invert_sorted_ids_kernel(
            sorted_ids, invert, p_num_valid, num_ids, batch_size
        ).launch(grid=(grid_size, 1, 1), block=(num_threads, 1, 1), stream=stream)

    def call(sorted_ids, invert, num_valid, num_ids, batch_size):
        _run_compiled(
            launch,
            _ptr(sorted_ids),
            _ptr(invert),
            _ptr(num_valid),
            fx.Uint32(num_ids),
            fx.Uint32(batch_size),
            torch.cuda.current_stream(),
        )

    return call


@functools.cache
def _compile_moe_sum(device_key, n, topk, sort_block_m):
    del device_key
    column_blocks = (n + 2047) // 2048

    @flyc.kernel(known_block_size=[256, 1, 1])
    def moe_down_sum_kernel(
        output: fx.Pointer,
        source: fx.Pointer,
        inverse: fx.Pointer,
        tokens: fx.Int32,
        source_rows: fx.Int32,
    ):
        tid = fx.Int32(fx.thread_idx.x)
        token = fx.Int32(fx.block_idx.x) // column_blocks
        block_col = fx.Int32(fx.block_idx.x) % column_blocks
        target_buffer = fx.rocdl.make_buffer_tensor(
            fx.make_view(output, fx.make_layout(tokens * n, 1)), False
        )
        drsrc = fx.rocdl.get_buffer_rsrc(fx.get_iter(target_buffer))
        zero_aux = rocdl_aux(0)
        zero_offset = fx.Int32(0).ir_value()
        vector_type = ir.VectorType.get([4], fx.Int32.ir_type)
        read_aux = rocdl_aux(2)
        locations = [
            _scalar(inverse[token * topk + route]) for route in range_constexpr(topk)
        ]

        def read_route(location, column):
            valid_row = (location >= 0) & (location < source_rows)
            safe_location = valid_row.select(location, fx.Int32(0))
            bm, row = safe_location // sort_block_m, safe_location % sort_block_m
            # A route's M block may start above 4 GiB; only the block-local
            # byte offset is 32-bit. Invalid inverse entries use a safe base.
            block = fx.make_view(
                source + fx.Int64(bm) * (sort_block_m * n),
                fx.make_layout(sort_block_m * n, 1),
            )
            source_buffer = fx.rocdl.make_buffer_tensor(block, False)
            srsrc = fx.rocdl.get_buffer_rsrc(fx.get_iter(source_buffer))
            element = column // 64 * (sort_block_m * 64) + row * 64 + column % 64
            valid = valid_row & (column < n)
            offset = valid.select(element * 2, fx.Int32(-1))
            return fx.Vector(
                rocdl.raw_ptr_buffer_load(
                    vector_type,
                    srsrc,
                    offset.ir_value(),
                    zero_offset,
                    aux=read_aux,
                )
            ).bitcast(fx.BFloat16)

        column = block_col * 2048 + tid * 8
        fragments = [
            read_route(locations[route], column) for route in range_constexpr(topk)
        ]
        accum = fragments[0].to(fx.Float32)
        for route in range_constexpr(1, topk):
            accum = accum + fragments[route].to(fx.Float32)
        offset = (column < n).select((token * n + column) * 2, fx.Int32(-1))
        rocdl.raw_ptr_buffer_store(
            accum.to(fx.BFloat16).bitcast(fx.Int32).ir_value(),
            drsrc,
            offset.ir_value(),
            zero_offset,
            aux=zero_aux,
        )

    @flyc.jit
    def launch(
        output: fx.Pointer,
        source: fx.Pointer,
        inverse: fx.Pointer,
        tokens: fx.Int32,
        source_rows: fx.Int32,
        stream: fx.Stream,
    ):
        moe_down_sum_kernel(output, source, inverse, tokens, source_rows).launch(
            grid=(tokens * column_blocks, 1, 1),
            block=(256, 1, 1),
            stream=stream,
        )

    return launch


@functools.cache
def make_moe_sum(*, n, topk, sort_block_m=128):
    """out[t] = sum_r route[inverse[t, r]] over the packed M128/N64 route buffer.

    Missing inverse entries (-1) contribute zero.
    """
    assert n > 0 and n % 128 == 0 and 0 < topk <= 255
    assert sort_block_m in (128, 256)
    assert sort_block_m * n * 2 < (1 << 32)

    def reduce(output, source, inverse):
        tokens = output.shape[0]
        assert output.shape == (tokens, n) and inverse.shape == (tokens, topk)
        assert source.ndim == 2 and source.shape[1] == n
        assert source.shape[0] % sort_block_m == 0
        assert source.dtype == output.dtype == torch.bfloat16 and inverse.dtype == torch.int32
        assert source.shape[0] < (1 << 31) and output.numel() * 2 < (1 << 32)
        with torch.cuda.device(output.device):
            launcher = _compile_moe_sum(get_device_cache_key(), n, topk, sort_block_m)
            stream = torch.cuda.current_stream(output.device)
            compiled = getattr(launcher, "_cf", None)
            if compiled is None:
                _run_compiled(
                    launcher,
                    _ptr(output),
                    _ptr(source),
                    _ptr(inverse),
                    fx.Int32(tokens),
                    fx.Int32(source.shape[0]),
                    fx.Stream(stream.cuda_stream),
                )
            else:
                compiled(
                    output.data_ptr(),
                    source.data_ptr(),
                    inverse.data_ptr(),
                    tokens,
                    source.shape[0],
                    stream.cuda_stream,
                )
        return output

    return reduce

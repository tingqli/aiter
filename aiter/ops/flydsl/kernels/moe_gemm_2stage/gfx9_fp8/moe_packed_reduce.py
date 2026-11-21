# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Packed BF16 TOPK sum: 256 threads, 2048 columns, NT reads."""

from functools import cache

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl.expr import range_constexpr, rocdl

from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

from .common import _ptr, _scalar, get_device_cache_key, rocdl_aux


@cache
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
            # OC partitions columns; it does not change the global N64 layout.
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


@cache
def make_moe_sum(*, n, topk, sort_block_m=256):
    """Gather packed routes through inverse; sort_block_m is the packed stride.

    Pass 128 for M128 output even when the routing metadata was sorted by 256.
    inverse[token, slot] is the route's packed source row. Entries outside
    [0, source_rows) contribute zero; any other value is read as a route, so
    the caller must write every (token, slot) or prefill inverse with -1.
    No tensors are retained in caches.
    """
    if not (n > 0 and n % 128 == 0 and 0 < topk <= 255):
        raise ValueError("moe_sum requires N divisible by 128 and 0 < TOPK <= 255")
    if sort_block_m not in (128, 256):
        raise ValueError("moe_sum requires sort_block_m 128 or 256")
    if sort_block_m * n * 2 >= 1 << 32:
        raise ValueError("one packed M block must fit a buffer descriptor")

    def reduce(output, source, inverse):
        if not all(
            t.is_cuda and t.is_contiguous() and t.device == output.device
            for t in (output, source, inverse)
        ):
            raise ValueError("moe_sum tensors must be contiguous on one GPU")
        if (
            source.dtype != torch.bfloat16
            or output.dtype != torch.bfloat16
            or inverse.dtype != torch.int32
        ):
            raise ValueError("moe_sum expects BF16 source/output and int32 inverse")
        if output.ndim != 2 or output.shape[1] != n:
            raise ValueError("moe_sum output must be [tokens, N]")
        tokens = output.shape[0]
        if (
            source.ndim != 2
            or source.shape[1] != n
            or source.shape[0] % sort_block_m
            or inverse.shape != (tokens, topk)
        ):
            raise ValueError("moe_sum source/inverse shape mismatch")
        if source.shape[0] >= 1 << 31 or output.numel() * 2 >= 1 << 32:
            raise ValueError("moe_sum buffers must fit 32-bit byte offsets")
        with torch.cuda.device(output.device):
            launcher = _compile_moe_sum(get_device_cache_key(), n, topk, sort_block_m)
            stream = torch.cuda.current_stream(output.device)
            _run_compiled(
                launcher,
                _ptr(output),
                _ptr(source),
                _ptr(inverse),
                fx.Int32(tokens),
                fx.Int32(source.shape[0]),
                fx.Stream(stream.cuda_stream),
            )
        return output

    return reduce

# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
# ruff: noqa: B023
# Helpers run synchronously during FlyDSL tracing, capturing loop SSA by design.
# Binding default arguments changes DSL state.

"""gfx950 FP8 block-scale Down with K128 multiples and routed BF16 output.

Each task retains its whole K tile. Four B tiles reside in LDS, so supported K
also depends on block_n and the split's scale storage. Callers own the counter;
each launch clears it on the input device's current stream, including replay.
"""

from functools import cache

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl.expr import const_expr, range_constexpr, rocdl
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

from aiter.jit.utils.chip_info import get_gfx_runtime
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

from . import common as fxh
from .a8w8_blockscale_config import routed_down_lds_bytes
from .common import _ptr, get_device_cache_key, permlane16_swap

# One 8-wave workgroup per CU (waves_per_eu=2) on 256-CU gfx950.
ROUTED_DOWN_WORKERS = 256


def _lds_llvm_ptr(address):
    """Raw LDS byte address as the !llvm.ptr the async-LDS DMA intrinsic takes."""
    return fx.to_llvm_ptr(
        fx.inttoptr(
            fx.PointerType.get(fx.Int32.ir_type, fx.AddressSpace.Shared, 4), address
        )
    )


def recast_tensor(tensor, dtype):
    dst_ptr_type = fx.PointerType.get(
        dtype.ir_type,
        tensor.memspace,
        dtype.width // 8,
    )
    dst_ptr = fx.recast_iter(dst_ptr_type, fx.get_iter(tensor))
    dst_layout = fx.recast_layout(
        tensor.layout,
        tensor.dtype.width,
        dtype.width,
    )
    return fx.make_view(dst_ptr, dst_layout)


def ptr_to_tensor(ptr, shape, dtype=None, as_buffer=False):
    tensor = fx.make_view(ptr, fx.make_ordered_layout(shape, 0))
    if dtype is not None:
        tensor = recast_tensor(tensor, dtype)
    if as_buffer:
        tensor = fx.rocdl.make_buffer_tensor(tensor, False)
    return tensor


class ROCDLBuffer:
    """Buffer-resource view for direct global-to-LDS copies of dwords."""

    def __init__(self, base_tensor):
        self.base_offset = fx.ptrtoint(fx.get_iter(base_tensor))
        buffer = fx.rocdl.make_buffer_tensor(base_tensor, False)
        self.rsrc = fx.rocdl.get_buffer_rsrc(fx.get_iter(buffer))

    @flyc.jit
    def load_async(
        self,
        ptr_src: fx.Pointer,
        ptr_dst: fx.Pointer,
        num_dwords: int,
        num_threads: int,
    ):
        """Cooperatively copy contiguous dwords from global memory to LDS.

        ``ptr_src`` must point inside the tensor used to construct this object;
        its descriptor-relative byte offset is calculated automatically.
        ``ptr_dst`` must point to compact LDS storage. No LDS bank swizzle is
        applied, so preshuffled input is copied byte-for-byte.

        Every full round uses one 16-byte DMA per thread. A partial 16-byte
        round is predicated by thread ID, and up to three residual dwords are
        copied by the first lanes of wave 0. The caller owns async group commit,
        waiting, and the workgroup barrier.
        """
        assert num_dwords > 0
        assert num_threads > 0 and num_threads % 64 == 0

        atom_bytes = 16
        dword_bytes = 4
        num_bytes = num_dwords * dword_bytes
        num_atoms = num_bytes // atom_bytes
        num_rounds = num_atoms // num_threads
        tail_atoms = num_atoms % num_threads
        tail_dwords = (num_bytes % atom_bytes) // dword_bytes

        tid = fx.thread_idx.x
        wave = tid // fx.Int32(64)
        zero_i32 = fx.Int32(0).ir_value()
        wave_byte_offset = fx.Int32(
            fx.rocdl.readfirstlane(
                T.i32,
                (wave * fx.Int32(64 * atom_bytes)).ir_value(),
            )
        )
        lds_address = fx.Int32(fx.ptrtoint(ptr_dst)) + wave_byte_offset
        src_base_byte_offset = fx.Int32(fx.ptrtoint(ptr_src) - self.base_offset)
        source_byte_offset = src_base_byte_offset + tid * fx.Int32(atom_bytes)

        # Full rounds: every thread copies one 16-byte atom.
        for copy_round in range_constexpr(num_rounds):
            rocdl.raw_ptr_buffer_load_async_lds(
                self.rsrc,
                _lds_llvm_ptr(lds_address),
                fx.Int32(atom_bytes).ir_value(),
                source_byte_offset.ir_value(),
                zero_i32,
                zero_i32,
                aux=fxh.rocdl_aux(0),
            )
            lds_address += num_threads * atom_bytes
            source_byte_offset += num_threads * atom_bytes

        # Partial 16-byte round.
        if fx.const_expr(tail_atoms != 0):  # noqa: SIM102 - Compile-time/runtime split.
            if tid < fx.Int32(tail_atoms):
                rocdl.raw_ptr_buffer_load_async_lds(
                    self.rsrc,
                    _lds_llvm_ptr(lds_address),
                    fx.Int32(atom_bytes).ir_value(),
                    source_byte_offset.ir_value(),
                    zero_i32,
                    zero_i32,
                    aux=fxh.rocdl_aux(0),
                )

        # Up to three residual dwords after the final 16-byte atom.
        if fx.const_expr(tail_dwords != 0):
            dword_source_base = src_base_byte_offset + fx.Int32(
                (num_bytes // atom_bytes) * atom_bytes
            )
            dword_lds_address = lds_address + tail_atoms * atom_bytes
            if tid < fx.Int32(tail_dwords):
                rocdl.raw_ptr_buffer_load_async_lds(
                    self.rsrc,
                    _lds_llvm_ptr(dword_lds_address),
                    fx.Int32(dword_bytes).ir_value(),
                    (dword_source_base + tid * fx.Int32(dword_bytes)).ir_value(),
                    zero_i32,
                    zero_i32,
                    aux=fxh.rocdl_aux(0),
                )


@cache
def _compile_8wave_down(
    device_key, n, k, topk, num_experts, block_m, block_n, num_oc_splits
):
    del device_key  # Cache key only.
    if get_gfx_runtime() != "gfx950":
        raise ValueError("8-wave FP8 blockscale Down requires gfx950")
    routed_down_lds_bytes(
        n=n,
        k=k,
        topk=topk,
        num_experts=num_experts,
        block_m=block_m,
        block_n=block_n,
        num_oc_splits=num_oc_splits,
    )
    n_split = n // num_oc_splits
    n_tiles_per_split = n_split // block_n
    n16_tiles_per_block = block_n // 16
    k_blocks = k // 128
    scale_n_blocks = n // 128
    scale_n_blocks_per_split = (n_split + 127) // 128
    num_warps = 8
    num_threads = num_warps * 64

    # A 16x16 preshuffled tile has ordered layout
    # [k16, n16, K/k16, N/n16], where k16 elements occupy 16 bytes.

    @fx.struct
    class SharedStorage:
        # Int32 storage makes the ring four times the FP8 element count in bytes.
        b_ring: fx.Array[fx.Int32, block_n * k, 16]
        sorted_weights: fx.Array[fx.Float32, block_m, 16]
        sorted_ids: fx.Array[fx.Int32, block_m, 16]
        scale_b: fx.Array[fx.Float32, scale_n_blocks_per_split * k_blocks, 16]

    @flyc.kernel(known_block_size=[num_threads, 1, 1])
    def flydsl_moe_gemm_8wave_down_kernel(
        output: fx.Pointer,
        input_q: fx.Pointer,
        weight_shuffled: fx.Pointer,
        input_scales: fx.Pointer,
        weight_scales: fx.Pointer,
        sorted_ids: fx.Pointer,
        sorted_weights: fx.Pointer,
        sorted_expert_ids: fx.Pointer,
        num_valid_ids: fx.Pointer,
        task_counter: fx.Pointer,
        num_tokens: fx.Int32,
        num_expert_blocks: fx.Int32,
    ):
        tid = fx.thread_idx.x
        wave = tid // fx.Int32(64)
        lane = tid % fx.Int32(64)
        lane_div16 = lane // fx.Int32(16)
        lane_mod16 = lane % fx.Int32(16)

        lds = fx.SharedAllocator().allocate(SharedStorage).peek()
        # The task ID is dead before the B ring is populated.
        lds_task_id = fx.recast_iter(fx.Int32, lds.b_ring.ptr)
        lds_scale_b = fx.make_view(
            lds.scale_b.ptr,
            fx.make_layout(
                (scale_n_blocks_per_split, k_blocks),
                (k_blocks, 1),
            ),
        )

        b_tile_dwords = block_n * k // 4

        sorted_ids_lds = fx.make_view(lds.sorted_ids.ptr, fx.make_layout(block_m, 1))
        sorted_weights_lds = fx.make_view(
            lds.sorted_weights.ptr, fx.make_layout(block_m, 1)
        )

        # weight_shuffled holds [num_experts, num_oc_splits] slabs of
        # [k16, n16, k/k16, n_split/n16].
        assert k % 64 == 0
        assert n % 16 == 0
        k16 = 16 // (weight_shuffled.dtype.width // 8)
        n16 = 16
        weight_slab_layout = fx.make_ordered_layout(
            (k16, n16, k // k16, n_split // n16), 0
        )

        # The Int32 ring replaces k16 with four contiguous dwords.
        num_slots = 4
        lds_b_ring = fx.make_view(
            lds.b_ring.ptr,
            fx.make_ordered_layout(
                (4, n16, k // k16, block_n // n16, num_slots),
                0,
            ),
        )

        # Activation scales are K-major because transpose_scale=True.
        input_scales = fxh.view_as_torch_tensor(
            input_scales,
            (k_blocks, num_tokens * fx.Int32(topk)),
            fx.Float32,
        )
        weight_scales = fxh.view_as_torch_tensor(
            weight_scales,
            (num_experts, scale_n_blocks, k_blocks),
            fx.Float32,
        )
        sorted_expert_ids = fxh.view_as_torch_tensor(
            sorted_expert_ids,
            (num_expert_blocks,),
            fx.Int32,
        )

        input_scales = fx.rocdl.make_buffer_tensor(input_scales, False)

        assert k % 16 == 0
        assert n % 8 == 0
        input_data = ptr_to_tensor(
            input_q,
            (16, k // 16, num_tokens * topk),
            fx.Int32,
            as_buffer=True,
        )
        output_data = ptr_to_tensor(
            output,
            (8, n // 8, num_tokens * topk),
            fx.Int32,
            as_buffer=True,
        )

        max_id = num_valid_ids[0]

        atom = fx.make_mma_atom(fx.rocdl.cdna4.MFMA_Scale(16, 16, 128, fx.Float8E4M3FN))

        running = fx.Boolean(True)
        while running:
            if tid == fx.Int32(0):
                lds_task_id[0] = fx.llvm.atomic_add(
                    task_counter, fx.Int32(1), syncscope=fx.rocdl.SyncScope.Agent
                )
            fx.barrier()
            task = lds_task_id[0]
            blk_m = task // fx.Int32(num_oc_splits)
            blk_oc = task % fx.Int32(num_oc_splits)
            running = blk_m * fx.Int32(block_m) < max_id
            if running:
                num_mma_m = 32 // 16
                num_mma_n = block_n // 16
                num_mma_k = k_blocks

                a_mma_frag_r = fx.make_rmem_tensor(
                    [8, num_mma_m, num_mma_k],
                    fx.Int32,
                )
                a_mma_frag_w = fx.make_view(
                    fx.get_iter(a_mma_frag_r),
                    fx.make_ordered_layout(
                        [4, 2, num_mma_m, num_mma_k],
                        0,
                    ),
                )
                a_scales_frag = fx.make_rmem_tensor([2, num_mma_k], fx.Float32)

                b_mma_frag_r = fx.make_rmem_tensor(
                    [8, num_mma_n, num_mma_k],
                    fx.Int32,
                )
                b_mma_frag_w = fx.make_view(
                    fx.get_iter(b_mma_frag_r),
                    fx.make_ordered_layout(
                        [4, 2, num_mma_n, num_mma_k],
                        0,
                    ),
                )
                # B uses one scale per 128x128 block.
                b_scales_frag = fx.make_rmem_tensor([num_mma_k], fx.Float32)

                acc = fx.make_rmem_tensor([4, num_mma_m, num_mma_n], fx.Float32)

                expert = fx.Int32(sorted_expert_ids[blk_m])

                sorted_ids_src = fx.make_view(
                    sorted_ids + blk_m * fx.Int32(block_m),
                    fx.make_layout(block_m, 1),
                )
                sorted_weights_src = fx.make_view(
                    sorted_weights + blk_m * fx.Int32(block_m),
                    fx.make_layout(block_m, 1),
                )
                ROCDLBuffer(sorted_ids_src).load_async(
                    fx.get_iter(sorted_ids_src),
                    fx.get_iter(sorted_ids_lds),
                    block_m,
                    num_threads,
                )
                ROCDLBuffer(sorted_weights_src).load_async(
                    fx.get_iter(sorted_weights_src),
                    fx.get_iter(sorted_weights_lds),
                    block_m,
                    num_threads,
                )

                ROCDLBuffer(weight_scales).load_async(
                    fx.get_iter(weight_scales[expert, blk_oc * (n_split // 128), None]),
                    lds.scale_b.ptr,
                    scale_n_blocks_per_split * k_blocks,
                    num_threads,
                )

                # Select one [k16, n16, K/k16, n_split/n16] expert/OC slab. The
                # base is 64-bit: E*N*K can exceed 2 GiB, while a static-layout
                # slice computes its offset in i32.
                weight_expert = fx.make_view(
                    weight_shuffled
                    + fx.Int64(expert) * (n * k)
                    + fx.Int64(blk_oc) * (n_split * k),
                    weight_slab_layout,
                )
                weight_rsrc = ROCDLBuffer(weight_expert)

                fx.rocdl.asyncmark()
                fx.rocdl.wait_asyncmark(0)
                fx.barrier()

                route_rows = {}
                valid_rows = {}
                output_rows = {}
                for mi in range_constexpr(num_mma_m):
                    a_row = wave * fx.Int32(32) + fx.Int32(mi * 16) + lane_mod16
                    packed = fx.Int32(sorted_ids_lds[a_row])
                    token = packed & fx.Int32(0xFFFFFF)
                    slot = (packed >> fx.Int32(24)) & fx.Int32(0xFF)
                    valid_row = (token < num_tokens) & (slot < fx.Int32(topk))
                    output_row = valid_row.select(
                        token * fx.Int32(topk) + slot, num_tokens * fx.Int32(topk)
                    )
                    route_rows[mi] = sorted_weights_lds[a_row]
                    valid_rows[mi] = valid_row
                    output_rows[mi] = output_row

                for mi in range_constexpr(num_mma_m):
                    for kb in range_constexpr(num_mma_k):
                        for step in range_constexpr(2):
                            a_mma_frag_w[None, step, mi, kb] = input_data[
                                None,
                                lane_div16 + (kb * 128 + step * 64) // 16,
                                output_rows[mi],
                            ].load()

                for mi in range_constexpr(num_mma_m):
                    for kb in range_constexpr(num_mma_k):
                        if valid_rows[mi]:
                            a_scales_frag[mi, kb] = input_scales[kb, output_rows[mi]]

                def global_load_b(n_tile):
                    """Copy one preshuffled B tile directly into its LDS slot."""
                    weight_rsrc.load_async(
                        fx.get_iter(
                            weight_expert[
                                None,
                                None,
                                None,
                                n_tile * n16_tiles_per_block,
                            ]
                        ),
                        fx.get_iter(lds_b_ring[None, None, None, None, n_tile % 4]),
                        b_tile_dwords,
                        num_threads,
                    )

                def global_store(n_tile):
                    # With physical operands ordered B,A, lane_mod16 selects the
                    # routed M row and each accumulator vector holds four
                    # contiguous N values; after the swap a lane stores 16 bytes.
                    n_base = blk_oc * fx.Int32(n_split) + fx.Int32(n_tile * block_n)

                    for mi in range_constexpr(num_mma_m):
                        for ni in range_constexpr(0, num_mma_n, 2):
                            c0 = acc[None, mi, ni].load() * route_rows[mi]
                            c1 = acc[None, mi, ni + 1].load() * route_rows[mi]
                            d0_a = rocdl.cvt_pk_bf16_f32(c0[0], c0[1])
                            d1_a = rocdl.cvt_pk_bf16_f32(c0[2], c0[3])
                            d0_b = rocdl.cvt_pk_bf16_f32(c1[0], c1[1])
                            d1_b = rocdl.cvt_pk_bf16_f32(c1[2], c1[3])
                            swap0 = permlane16_swap(d0_a, d0_b)
                            swap1 = permlane16_swap(d1_a, d1_b)
                            output_values = Vec.from_elements(
                                [swap0[0], swap1[0], swap0[1], swap1[1]], fx.Int32
                            )
                            swap_12_col = (lane_div16 & fx.Int32(1)) * fx.Int32(2) + (
                                lane_div16 >> fx.Int32(1)
                            )
                            output_data[
                                None,
                                n_base // 8 + ni * 2 + swap_12_col,
                                output_rows[mi],
                            ] = output_values

                def ds_read_b(n_tile):
                    noff = n_tile * block_n
                    slot = n_tile % 4
                    for kb in range_constexpr(num_mma_k):
                        for ni in range_constexpr(num_mma_n):
                            for step in range_constexpr(2):
                                b_mma_frag_w[None, step, ni, kb] = lds_b_ring[
                                    None,
                                    lane_mod16,
                                    lane_div16 + (kb * 2 + step) * 4,
                                    ni,
                                    slot,
                                ].load()
                        b_scales_frag[kb] = lds_scale_b[noff // 128, kb]

                def scaled_accumulate(partial, scale, accum):
                    # Fused FMA keeps the cross-K rounding of the tuned kernel;
                    # separate mul/add can flip a BF16 tie in the TOPK sum.
                    return Vec.from_elements(
                        [
                            fx.fma(partial[i], scale, accum[i])
                            for i in range_constexpr(4)
                        ],
                        fx.Float32,
                    )

                def compute():
                    acc_init = {}
                    dequant_queue = []
                    for kb in range_constexpr(num_mma_k):
                        for mi in range_constexpr(num_mma_m):
                            for ni in range_constexpr(num_mma_n):
                                c_mma_frag = fx.make_rmem_tensor(4, fx.Float32)
                                c_mma_frag.fill(0)
                                fx.gemm(
                                    atom,
                                    c_mma_frag,
                                    b_mma_frag_r[None, ni, kb],
                                    a_mma_frag_r[None, mi, kb],
                                    c_mma_frag,
                                )
                                rocdl.sched_barrier(0)

                                mfma_scaleAB = a_scales_frag[mi, kb] * b_scales_frag[kb]
                                dequant_queue.append(
                                    [c_mma_frag, mfma_scaleAB, (mi, ni)]
                                )

                                if len(dequant_queue) > 3:
                                    c_mma_frag, mfma_scaleAB, (mi0, ni0) = (
                                        dequant_queue.pop(0)
                                    )
                                    if const_expr((mi0, ni0) in acc_init):
                                        acc[None, mi0, ni0].store(
                                            scaled_accumulate(
                                                c_mma_frag.load(),
                                                mfma_scaleAB,
                                                acc[None, mi0, ni0].load(),
                                            )
                                        )
                                    else:
                                        acc[None, mi0, ni0].store(
                                            c_mma_frag.load() * mfma_scaleAB
                                        )
                                        acc_init[mi0, ni0] = True
                                rocdl.sched_barrier(0)

                    while const_expr(len(dequant_queue) > 0):
                        c_mma_frag, mfma_scaleAB, (mi0, ni0) = dequant_queue.pop(0)
                        if const_expr((mi0, ni0) in acc_init):
                            acc[None, mi0, ni0].store(
                                scaled_accumulate(
                                    c_mma_frag.load(),
                                    mfma_scaleAB,
                                    acc[None, mi0, ni0].load(),
                                )
                            )
                        else:
                            acc[None, mi0, ni0].store(c_mma_frag.load() * mfma_scaleAB)
                            acc_init[mi0, ni0] = True

                # Operand dependencies alone place lgkmcnt(0) before the MFMA,
                # not before the barrier (fx.barrier's fence makes LLVM wait
                # there). The explicit s_waitcnt(lgkmcnt=0) below is defensive:
                # every ds_read of a B slot completes before the barrier that
                # lets the next DMA overwrite it.
                global_load_b(0)
                fx.rocdl.asyncmark()

                global_load_b(1)
                fx.rocdl.asyncmark()

                fx.rocdl.wait_asyncmark(1)

                if wave > fx.Int32(3):
                    fx.barrier()

                fx.barrier()

                ds_read_b(0)
                global_load_b(2)

                fx.rocdl.asyncmark()
                fx.rocdl.wait_asyncmark(1)
                fx.rocdl.s_waitcnt(lgkmcnt=0)
                fx.barrier()

                compute()

                loop_begin = fx.Int32(0)
                loop_end = fx.Int32(n_tiles_per_split - 3)
                loop_step = fx.Int32(1)
                for n_tile in range(loop_begin, loop_end, loop_step):
                    fx.barrier()

                    ds_read_b(n_tile + 1)
                    global_store(n_tile)
                    global_load_b(n_tile + 3)

                    fx.rocdl.asyncmark()
                    fx.rocdl.wait_asyncmark(1)
                    fx.rocdl.s_waitcnt(lgkmcnt=0)
                    fx.barrier()

                    compute()

                fx.barrier()
                ds_read_b(n_tiles_per_split - 2)
                global_store(n_tiles_per_split - 3)

                fx.rocdl.asyncmark()
                fx.rocdl.wait_asyncmark(1)
                fx.rocdl.s_waitcnt(lgkmcnt=0)
                fx.barrier()

                compute()

                fx.barrier()
                ds_read_b(n_tiles_per_split - 1)
                global_store(n_tiles_per_split - 2)

                fx.rocdl.s_waitcnt(lgkmcnt=0)
                fx.barrier()

                compute()
                global_store(n_tiles_per_split - 1)

                if wave < fx.Int32(4):
                    fx.barrier()
            fx.barrier()

    @flyc.jit
    def launch(
        output: fx.Pointer,
        input_q: fx.Pointer,
        weight_shuffled: fx.Pointer,
        input_scales: fx.Pointer,
        weight_scales: fx.Pointer,
        sorted_ids: fx.Pointer,
        sorted_weights: fx.Pointer,
        sorted_expert_ids: fx.Pointer,
        num_valid_ids: fx.Pointer,
        task_counter: fx.Pointer,
        num_tokens: fx.Int32,
        num_expert_blocks: fx.Int32,
        stream: fx.Stream,
    ):
        flydsl_moe_gemm_8wave_down_kernel(
            output,
            input_q,
            weight_shuffled,
            input_scales,
            weight_scales,
            sorted_ids,
            sorted_weights,
            sorted_expert_ids,
            num_valid_ids,
            task_counter,
            num_tokens,
            num_expert_blocks,
            value_attrs={
                "rocdl.waves_per_eu": 2,
                "rocdl.flat_work_group_size": "512,512",
            },
        ).launch(grid=(ROUTED_DOWN_WORKERS, 1, 1), block=(512, 1, 1), stream=stream)

    return launch


@cache
def flydsl_moe_gemm_8wave_down(
    *, n, k, topk, num_experts, block_m=256, block_n=32, num_oc_splits=1
):
    """Build a stateless ten-tensor callable using native sort256 metadata.

    K is a positive multiple of 128, within the whole-K LDS/resource bounds.
    Weights use shuffle_weight(16,16); A scales are physically [K/128,T*topk]
    and B scales are [E,N/128,K/128]. Output is routed [T,topk,N], not packed.
    The caller supplies one int32 counter, never shared by concurrent launches.
    """
    routed_down_lds_bytes(
        n=n,
        k=k,
        topk=topk,
        num_experts=num_experts,
        block_m=block_m,
        block_n=block_n,
        num_oc_splits=num_oc_splits,
    )
    n_split, k_blocks, scale_n_blocks = n // num_oc_splits, k // 128, n // 128

    def down(
        output: torch.Tensor,
        input_q: torch.Tensor,
        weight_shuffled: torch.Tensor,
        input_scales: torch.Tensor,
        weight_scales: torch.Tensor,
        sorted_ids: torch.Tensor,
        sorted_weights: torch.Tensor,
        sorted_expert_ids: torch.Tensor,
        num_valid_ids: torch.Tensor,
        task_counter: torch.Tensor,
    ):
        tensors = (
            output,
            input_q,
            weight_shuffled,
            input_scales,
            weight_scales,
            sorted_ids,
            sorted_weights,
            sorted_expert_ids,
            num_valid_ids,
            task_counter,
        )
        if not all(
            t.is_cuda and t.is_contiguous() and t.device == output.device
            for t in tensors
        ):
            raise ValueError("8-wave Down tensors must be contiguous on one GPU")
        if (
            input_q.dtype != torch.float8_e4m3fn
            or weight_shuffled.dtype != torch.float8_e4m3fn
            or output.dtype != torch.bfloat16
            or any(
                t.dtype != torch.float32
                for t in (input_scales, weight_scales, sorted_weights)
            )
            or any(
                t.dtype != torch.int32
                for t in (sorted_ids, sorted_expert_ids, num_valid_ids, task_counter)
            )
        ):
            raise ValueError("8-wave Down tensor dtype mismatch")
        if (
            input_q.ndim != 3
            or weight_shuffled.ndim != 3
            or sorted_ids.ndim != 1
            or sorted_expert_ids.ndim != 1
        ):
            raise ValueError("8-wave Down expects 3D input/weights and 1D sorting")
        num_tokens = input_q.shape[0]
        if (
            not 0 < num_tokens < 1 << 24
            or input_q.shape[1:] != (topk, k)
            or weight_shuffled.shape != (num_experts, n, k)
            or output.shape != (num_tokens, topk, n)
            or input_scales.numel() != num_tokens * topk * k_blocks
            or weight_scales.shape != (num_experts, scale_n_blocks, k_blocks)
            or sorted_weights.shape != sorted_ids.shape
        ):
            raise ValueError("8-wave Down input/weight/output shape mismatch")
        if sorted_expert_ids.numel() != (sorted_ids.numel() + 255) // 256:
            raise ValueError("8-wave Down requires native sort256")
        if num_valid_ids.numel() < 1 or task_counter.numel() != 1:
            raise ValueError("8-wave Down needs a valid-row count and one counter")
        # The masked row uses the descriptor end; adding its last column must not wrap.
        if (
            (output.numel() + n) * 2 >= 1 << 32
            or input_q.numel() + k >= 1 << 32
            or max(
                input_scales.nbytes,
                weight_scales.nbytes,
                sorted_ids.nbytes,
                n_split * k,
            )
            >= 1 << 32
            or sorted_expert_ids.numel() * num_oc_splits + 256 >= 1 << 31
        ):
            raise ValueError("8-wave Down buffers must fit 32-bit byte offsets")
        with torch.cuda.device(output.device):
            launch = _compile_8wave_down(
                get_device_cache_key(),
                n,
                k,
                topk,
                num_experts,
                block_m,
                block_n,
                num_oc_splits,
            )
            task_counter.zero_()
            stream = torch.cuda.current_stream(output.device)
            _run_compiled(
                launch,
                *[_ptr(t) for t in tensors],
                fx.Int32(num_tokens),
                fx.Int32(sorted_expert_ids.numel()),
                fx.Stream(stream.cuda_stream),
            )
        return output

    return down

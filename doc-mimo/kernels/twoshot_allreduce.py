# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""A8W4 MoE stage2 under tensor parallelism: the per-rank down-proj + routed atomic
scatter kernel of ``test_a8w4_gemm2.py`` followed by a ``torch.distributed``
all-reduce of the bf16 ``[tokens, model_dim]`` partial outputs.

``inter_dim`` is the per-rank shard (Mimo v2.6 MoE TP8: 2048 / 8 = 256). Every rank
sees the same tokens and routing and owns its own W2 shard ``[E, model_dim,
inter_dim/2]`` and stage1-intermediate shard; the layer output is the sum over
ranks, reduced in place in the gemm2 output buffer as in the model.

Timed separately (slowest rank reported): ``a8w4_gemm2`` alone, ``allreduce``
(RCCL) and ``twoshot_ar`` (FlyDSL two-shot all-reduce over HIP-IPC symmetric
buffers, :class:`TwoShotAllreduce`) alone (bus bandwidth in TB/s, nccl-tests
convention), and ``gemm2+allreduce`` / ``gemm2+twoshot_ar`` back to back.

Run (one process per GPU):
    torchrun --nproc_per_node=8 op_tests/twoshot_allreduce.py
    torchrun --nproc_per_node=8 op_tests/twoshot_allreduce.py -t 512 --tile 64,128,1
"""

import argparse
import ctypes
import functools
import itertools
import logging
import os
import sys

import flydsl.compiler as flyc
import flydsl.expr as fx
import pandas as pd
import torch
import torch.distributed as dist
from flydsl._mlir.dialects import llvm
from flydsl.expr import const_expr, gpu, range_constexpr, rocdl
from flydsl.expr.typing import T

import aiter
from aiter import QuantType, dtypes
from aiter.fused_moe import fused_topk, moe_sorting
from aiter.jit.utils.chip_info import get_gfx
from aiter.ops.flydsl.kernels import buffer_ops as bo
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import (
    _gep1,
    _global_base_ptr1,
    global_typed_ptr,
)
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
from aiter.test_common import benchmark, checkAllclose, run_perftest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from test_a8w4_gemm2 import (  # noqa: E402
    HOT_EXPERT_BIAS,
    HOT_EXPERT_DIV,
    ROUTINGS,
    SUPPORTED_GFX,
    TOL_ERR_RATIO,
    _cos_diff,
    a8w4_gemm2,
    run_torch,
)


def _rank_max(x):
    """Max of a per-rank scalar over all ranks (slowest rank / worst error)."""
    t = torch.tensor([float(x)], dtype=torch.float64, device="cuda")
    dist.all_reduce(t, op=dist.ReduceOp.MAX)
    return t.item()


# =============================================================================
# Symmetric peer memory (HIP IPC), after FlyDSL kernels/monokernel/{ipc,runtime}.py
# =============================================================================


class _HipIpcHandle(ctypes.Structure):
    _fields_ = [("reserved", ctypes.c_byte * 64)]


@functools.cache
def _hip():
    lib = ctypes.CDLL("libamdhip64.so")
    lib.hipIpcGetMemHandle.argtypes = [ctypes.POINTER(_HipIpcHandle), ctypes.c_void_p]
    lib.hipIpcOpenMemHandle.argtypes = [
        ctypes.POINTER(ctypes.c_void_p),
        _HipIpcHandle,
        ctypes.c_uint,
    ]
    lib.hipIpcCloseMemHandle.argtypes = [ctypes.c_void_p]
    lib.hipPointerGetAttribute.argtypes = [
        ctypes.c_void_p,
        ctypes.c_int,
        ctypes.c_void_p,
    ]
    return lib


def _hip_check(err, what):
    if err != 0:
        raise RuntimeError(f"{what} failed: hipError {err}")


class SymmetricBuffer:
    """One zeroed ``nbytes`` allocation per rank, mapped into every peer.

    ``addrs`` (int64 [npes], device) holds each rank's base address as seen from
    this process. The storage lives in a private MemPool: exporting
    sub-allocations of shared caching-allocator segments gives stale IPC mappings.
    Collective: construct and ``close()`` on every rank in the same order.
    """

    def __init__(self, nbytes, rank, npes):
        self._pool = torch.cuda.MemPool()
        with torch.cuda.use_mem_pool(self._pool):
            self.storage = torch.zeros(nbytes, dtype=torch.uint8, device="cuda")
        local = self.storage.data_ptr()
        base = ctypes.c_void_p()
        _hip_check(  # 11 = HIP_POINTER_ATTRIBUTE_RANGE_START_ADDR
            _hip().hipPointerGetAttribute(ctypes.byref(base), 11, ctypes.c_void_p(local)),
            "hipPointerGetAttribute",
        )
        handle = _HipIpcHandle()
        _hip_check(
            _hip().hipIpcGetMemHandle(ctypes.byref(handle), base),
            "hipIpcGetMemHandle",
        )
        peers = [None] * npes
        dist.all_gather_object(peers, (bytes(handle.reserved), local - base.value))
        self._opened, addrs = [], []
        for r, (raw, off) in enumerate(peers):
            if r == rank:
                addrs.append(local)
                continue
            h = _HipIpcHandle()
            ctypes.memmove(ctypes.byref(h), raw, 64)
            mapped = ctypes.c_void_p()
            _hip_check(  # 1 = hipIpcMemLazyEnablePeerAccess
                _hip().hipIpcOpenMemHandle(ctypes.byref(mapped), h, 1),
                "hipIpcOpenMemHandle",
            )
            self._opened.append(mapped.value)
            addrs.append(mapped.value + off)
        self.addrs = torch.tensor(addrs, dtype=torch.int64, device="cuda")
        dist.barrier()

    def close(self):
        torch.cuda.synchronize()
        dist.barrier()  # no peer may still be writing into a mapping we drop
        for p in self._opened:
            _hip_check(_hip().hipIpcCloseMemHandle(ctypes.c_void_p(p)), "hipIpcClose")
        self._opened = []
        dist.barrier()  # peers closed their mappings before our storage is freed


# =============================================================================
# Two-shot bf16 all-reduce (FlyDSL): reduce-scatter push + all-gather push
# =============================================================================

_CM_SC1 = 16  # gfx942 buffer cache policy: sc1 (remote stores: ~45 GB/s/link)
_CM_SYS = 17  # sc0|sc1: system-coherent load, never hits a stale local L2 line


def _flag_ptr(base_i64, byte_off):
    return _gep1(_global_base_ptr1(base_i64), byte_off)


def _flag_read(ptr, ordering=llvm.AtomicOrdering.acquire):
    return fx.Int32(
        llvm.AtomicRMWOp(
            llvm.AtomicBinOp.add,
            ptr,
            _raw(fx.Int32(0)),
            ordering,
            alignment=4,
        ).result
    )


@functools.cache
def compile_twoshot_allreduce(numel, npes, light_sync=True):
    """Build the two-shot all-reduce of a bf16 ``[numel]`` tensor over ``npes``
    ranks into the symmetric buffer of :class:`TwoShotAllreduce`.

    The tensor is split into ``npes`` shards (rank s owns shard s) of ``CHUNKS``
    chunks; workgroup c handles chunk c of every shard (one 16 B vector per lane):

      1. reduce-scatter: push chunk c of shard s to rank s's inbox[rank] (sc1
         stores, destinations rotated by rank so all xGMI links run at once),
         then publish ``epoch`` in rank s's rs_flag[rank][c];
      2. wait for rs_flag[*][c] here, sum the npes inbox copies in fp32 (fixed
         rank order -> bit-identical on every rank), round to bf16;
      3. all-gather: push the reduced chunk to every rank's gather[shard rank]
         and publish ag_flag[rank][c]; wait for ag_flag[*][c] here.

    The grid ends only when every chunk of every shard has landed in this rank's
    gather region. Flags hold the last finished epoch (monotonic, ``>=`` test).
    Single-buffered inbox/gather are safe: a peer can push epoch e+1 only after
    its epoch-e grid saw our all-gather flags, i.e. after we read the inbox, and
    after we launched e+1, i.e. after (stream order) our consumer read e.

    ``light_sync``: data stores are system-coherent write-through (sc0|sc1), so a
    plain ``s_waitcnt vmcnt(0)`` orders them before the (monotonic, system) flag
    atomics; no release fence, whose ``buffer_wbl2 sc0 sc1`` writes back the whole
    L2 once per wave. Inbox reads bypass L2 (sc0|sc1); one acquire per workgroup
    at the end invalidates L2 for the consumer of the gather region. Otherwise:
    release fences / acquire flag reads (LLVM memory model, strictly ordered).
    """
    nbytes = numel * 2
    assert nbytes % (npes * 16 * 64) == 0, f"numel={numel} not shardable"
    shard = nbytes // npes
    threads = max(64, min(256, shard // (16 * 256)))  # aim for >= 128..256 WGs
    assert shard % (threads * 16) == 0
    chunk = threads * 16
    chunks = shard // chunk
    inbox_off = 0
    gather_off = npes * shard
    rs_flag_off = gather_off + nbytes
    ag_flag_off = rs_flag_off + npes * chunks * 4
    total_bytes = ag_flag_off + npes * chunks * 4
    st_cm = _CM_SYS if light_sync else _CM_SC1
    flag_order = (
        llvm.AtomicOrdering.monotonic if light_sync else llvm.AtomicOrdering.release
    )
    read_order = (
        llvm.AtomicOrdering.monotonic if light_sync else llvm.AtomicOrdering.acquire
    )

    def publish():
        """Make this workgroup's pushes visible before its flags go out."""
        if light_sync:
            rocdl.s_waitcnt(vmcnt=0)
        else:
            llvm.FenceOp(llvm.AtomicOrdering.release)
        gpu.barrier()

    @flyc.kernel(
        name=f"twoshot_ar_bf16_n{numel}_w{npes}_t{threads}{'_light' if light_sync else ''}",
        known_block_size=[threads, 1, 1],
    )
    def twoshot_ar(
        arg_in: fx.Int64, arg_tbl: fx.Int64, i32_rank: fx.Int32, i32_epoch: fx.Int32
    ):
        tx = fx.Int32(gpu.thread_id("x"))
        c = fx.Int32(gpu.block_id("x"))
        off = c * fx.Int32(chunk // 4) + tx * fx.Int32(4)  # i32 elems in a shard
        tbl = global_typed_ptr(arg_tbl, T.i64, align=8)
        # All peer bases up front: a table load between remote stores would make
        # the compiler wait vmcnt(0) (loads and stores share vmcnt on gfx9),
        # serializing the stores. Store i of workgroup c goes to rank
        # (rank + c + i) % npes: neighbouring workgroups hit different xGMI links
        # at the same time instead of all queueing on one.
        peer = [(i32_rank + c + fx.Int32(i)) % fx.Int32(npes) for i in range(npes)]
        bases = [fx.Int64(tbl[p]) for p in peer]
        own = fx.Int64(tbl[i32_rank])
        src = bo.create_buffer_resource_from_addr(fx.Int64(arg_in))
        flag_slot = (i32_rank * fx.Int32(chunks) + c) * fx.Int32(4)

        # ---- 1. reduce-scatter push ------------------------------------------
        vals = [
            bo.buffer_load(
                src, peer[i] * fx.Int32(shard // 4) + off, vec_width=4, dtype=T.i32
            )
            for i in range_constexpr(npes)
        ]
        for i in range_constexpr(npes):
            dst = bo.create_buffer_resource_from_addr(
                bases[i] + fx.Int64(inbox_off) + fx.Int64(i32_rank) * fx.Int64(shard)
            )
            bo.buffer_store(vals[i], dst, off, cache_modifier=st_cm)
        publish()
        if tx < fx.Int32(npes):
            # lane t signals rank (rank + t) % npes and waits for source rank t
            s = (i32_rank + tx) % fx.Int32(npes)
            llvm.AtomicRMWOp(
                llvm.AtomicBinOp.xchg,
                _flag_ptr(fx.Int64(tbl[s]) + fx.Int64(rs_flag_off), flag_slot),
                _raw(i32_epoch),
                flag_order,
                alignment=4,
            )
            mine = _flag_ptr(
                own + fx.Int64(rs_flag_off),
                (tx * fx.Int32(chunks) + c) * fx.Int32(4),
            )
            seen = _flag_read(mine, read_order)
            while seen < i32_epoch:
                rocdl.s_sleep(1)
                seen = _flag_read(mine, read_order)
        gpu.barrier()

        # ---- 2. reduce this rank's shard, chunk c ----------------------------
        inbox = bo.create_buffer_resource_from_addr(own + fx.Int64(inbox_off))
        acc = [fx.Float32(0.0)] * 8
        for r in range_constexpr(npes):
            w = fx.Vector(
                bo.buffer_load(
                    inbox,
                    fx.Int32(r * shard // 4) + off,
                    vec_width=4,
                    dtype=T.i32,
                    cache_modifier=_CM_SYS,
                )
            )
            for j in range_constexpr(4):
                word = fx.Int32(w[j])
                acc[2 * j] = acc[2 * j] + (word << fx.Int32(16)).bitcast(fx.Float32)
                acc[2 * j + 1] = acc[2 * j + 1] + (word & fx.Int32(-65536)).bitcast(
                    fx.Float32
                )
        red = fx.Vector.from_elements(acc, fx.Float32).to(fx.BFloat16).bitcast(fx.Int32)

        # ---- 3. all-gather push ----------------------------------------------
        for i in range_constexpr(npes):
            dst = bo.create_buffer_resource_from_addr(
                bases[i] + fx.Int64(gather_off) + fx.Int64(i32_rank) * fx.Int64(shard)
            )
            bo.buffer_store(red, dst, off, cache_modifier=st_cm)
        publish()
        if tx < fx.Int32(npes):
            s = (i32_rank + tx) % fx.Int32(npes)
            llvm.AtomicRMWOp(
                llvm.AtomicBinOp.xchg,
                _flag_ptr(fx.Int64(tbl[s]) + fx.Int64(ag_flag_off), flag_slot),
                _raw(i32_epoch),
                flag_order,
                alignment=4,
            )
            mine = _flag_ptr(
                own + fx.Int64(ag_flag_off),
                (tx * fx.Int32(chunks) + c) * fx.Int32(4),
            )
            seen = _flag_read(mine, read_order)
            while seen < i32_epoch:
                rocdl.s_sleep(1)
                seen = _flag_read(mine, read_order)
            if const_expr(light_sync):
                llvm.FenceOp(llvm.AtomicOrdering.acquire)

    @flyc.jit
    def launch(
        arg_in: fx.Int64,
        arg_tbl: fx.Int64,
        i32_rank: fx.Int32,
        i32_epoch: fx.Int32,
        stream: fx.Stream,
    ):
        twoshot_ar(arg_in, arg_tbl, i32_rank, i32_epoch).launch(
            grid=(chunks, 1, 1), block=(threads, 1, 1), stream=stream
        )

    return launch, total_bytes, gather_off


class TwoShotAllreduce:
    """Two-shot all-reduce of a fixed-size bf16 tensor over the default group.
    ``__call__(inp)`` returns the reduced tensor, a view of this rank's symmetric
    gather region (valid until the next call). Collective; ``close()`` on all ranks.
    """

    def __init__(self, shape, light_sync=True):
        self.rank, self.npes = dist.get_rank(), dist.get_world_size()
        self.shape = tuple(shape)
        numel = 1
        for d in self.shape:
            numel *= d
        self.launch, nbytes, gather_off = compile_twoshot_allreduce(
            numel, self.npes, light_sync
        )
        self.buf = SymmetricBuffer(nbytes, self.rank, self.npes)
        self.out = (
            self.buf.storage[gather_off : gather_off + numel * 2]
            .view(torch.bfloat16)
            .view(self.shape)
        )
        self.epoch = 0

    def __call__(self, inp):
        assert inp.dtype == torch.bfloat16 and inp.is_contiguous()
        assert tuple(inp.shape) == self.shape
        self.epoch += 1
        _run_compiled(
            self.launch,
            inp.data_ptr(),
            self.buf.addrs.data_ptr(),
            self.rank,
            self.epoch,
            torch.cuda.current_stream(),
        )
        return self.out

    def close(self):
        self.buf.close()


@benchmark()
def bench_a8w4_gemm2_tp(
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
    dyn_rows=False,
):
    rank, world = dist.get_rank(), dist.get_world_size()
    tile_k = 256 if inter_dim % 256 == 0 else 128
    device = "cuda"

    # ---- routing: replicated on every rank (same seed) ---------------------------
    torch.manual_seed(0)
    torch.cuda.manual_seed(0)
    inp = torch.randn((token, model_dim), dtype=dtypes.bf16, device=device)
    score = torch.randn((token, expert), dtype=dtypes.bf16, device=device)
    if routing == "hot":
        hot = torch.randperm(expert, device=device)[: max(1, expert // HOT_EXPERT_DIV)]
        score[:, hot] += HOT_EXPERT_BIAS
    else:
        assert routing == "uniform", f"unknown routing {routing!r}"
    topk_weights, topk_ids = fused_topk(inp, score, topk, True)

    # ---- rank-local shards: W2 [E, model_dim, inter_dim] + stage1 intermediate ---
    torch.manual_seed(1000 + rank)
    torch.cuda.manual_seed(1000 + rank)
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
    inter = torch.randn((sorted_size, inter_dim), dtype=dtypes.bf16, device=device)
    a_fp8, a_scale = quantize_rows(inter, num_valid_ids)

    # fp32 references: this rank's partial, and the TP sum over ranks.
    ref_part = run_torch(
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
    ).to(dtypes.fp32)
    ref_full = ref_part.clone()
    dist.all_reduce(ref_full)

    # gemm2 output buffer, all-reduced in place (as the model does with moe_buf).
    out = torch.zeros((token, model_dim), dtype=dtypes.bf16, device=device)

    def gemm2():
        a8w4_gemm2(
            a_fp8,
            a_scale,
            w2_u8,
            w2_scale_u8,
            sorted_ids,
            sorted_weights,
            sorted_expert_ids,
            num_valid_ids,
            out,
            num_experts=expert,
            tile_m=tile_m,
            tile_n=tile_n,
            tile_k=tile_k,
            b_cache_mod=b_cache_mod,
            xcd_swizzle=xcd_swizzle,
            dyn_rows=dyn_rows,
        )
        return out

    def allreduce():
        dist.all_reduce(out)
        return out

    def gemm2_allreduce():
        gemm2()
        return allreduce()

    twoshot = TwoShotAllreduce(out.shape)

    def twoshot_ar():
        return twoshot(out)

    def gemm2_twoshot_ar():
        gemm2()
        return twoshot(out)

    # Kernel partial (also JIT-compiles outside the timed region): the all-reduce
    # candidate is checked against the exact fp32 sum of these bf16 partials.
    out.zero_()
    gemm2()
    torch.cuda.synchronize()
    part_bf16 = out.clone()
    part_sum = part_bf16.to(dtypes.fp32)
    dist.all_reduce(part_sum)

    # name: (reset the buffer before the check, fn -> result tensor, fp32 reference)
    candidates = {
        "a8w4_gemm2": (out.zero_, gemm2, ref_part),
        "allreduce": (lambda: out.copy_(part_bf16), allreduce, part_sum),
        "twoshot_ar": (lambda: out.copy_(part_bf16), twoshot_ar, part_sum),
        "gemm2+allreduce": (out.zero_, gemm2_allreduce, ref_full),
        "gemm2+twoshot_ar": (out.zero_, gemm2_twoshot_ar, ref_full),
    }

    routed = token * topk
    n_experts_hit = int(topk_ids.unique().numel())
    out_bytes = token * model_dim * out.element_size()
    g2_flops = 2 * routed * model_dim * inter_dim
    g2_bytes = (
        n_experts_hit * model_dim * (inter_dim // 2 + inter_dim // 32)  # W2 + scale
        + routed * inter_dim  # fp8 A
        + out_bytes  # bf16 out
    )
    ar_flops = (world - 1) * token * model_dim
    ar_bytes = 2 * (world - 1) * out_bytes // world  # bus bytes (ring all-reduce)
    cost = {
        "a8w4_gemm2": (g2_flops, g2_bytes),
        "allreduce": (ar_flops, ar_bytes),
        "twoshot_ar": (ar_flops, ar_bytes),
        "gemm2+allreduce": (g2_flops + ar_flops, g2_bytes + ar_bytes),
        "gemm2+twoshot_ar": (g2_flops + ar_flops, g2_bytes + ar_bytes),
    }

    ret = {"gfx": get_gfx(), "world": world}
    ret["experts hit"] = n_experts_hit
    ret["m-blocks"] = int(num_valid_ids[0]) // tile_m

    def check(name, reset, fn, ref):
        reset()
        torch.cuda.synchronize()
        dist.barrier()
        res_v = fn().to(dtypes.fp32)
        torch.cuda.synchronize()
        err = checkAllclose(
            ref,
            res_v,
            rtol=2e-2,
            atol=2e-2 * ref.abs().mean().item(),
            tol_err_ratio=TOL_ERR_RATIO,
            msg=f"[rank {rank}] {name}: a8w4 gemm2 TP{world} ",
        )
        return err, _cos_diff(ref, res_v)

    for name, (reset, fn, ref) in candidates.items():
        # Check one call from a known buffer state, time repeated calls (the
        # buffer keeps accumulating; values do not affect the timing), then check
        # again: catches cross-rank sync bugs that only show after many epochs.
        err, cos = check(name, reset, fn, ref)
        out.zero_()
        dist.barrier()
        _, us = run_perftest(fn)
        err2, cos2 = check(name, reset, fn, ref)
        us = _rank_max(us)
        flops, nbytes = cost[name]
        ret[f"{name} us"] = us
        ret[f"{name} TFLOPS"] = flops / us / 1e6
        ret[f"{name} TB/s"] = nbytes / us / 1e6
        ret[f"{name} err"] = _rank_max(max(err, err2))
        ret[f"{name} cos"] = _rank_max(max(cos, cos2))
    twoshot.close()
    return ret


def main():
    if get_gfx() not in SUPPORTED_GFX:
        aiter.logger.warning("a8w4 gemm2 unsupported on %s; skipping", get_gfx())
        return

    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        description="A8W4 MoE stage2 + TP all-reduce correctness / perf "
        "(launch with torchrun --nproc_per_node=N)",
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
        help="model_dim,inter_dim,expert,topk with inter_dim = per-rank shard\n"
        "e.g. -s 4096,256,256,8 (Mimo v2.6 MoE TP8)",
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

    local_rank = int(os.environ.get("LOCAL_RANK", "0"))
    torch.cuda.set_device(local_rank)
    dist.init_process_group(
        backend="nccl", device_id=torch.device("cuda", local_rank)
    )
    rank = dist.get_rank()
    if rank != 0:
        aiter.logger.setLevel(logging.WARNING)

    try:
        df = []
        for (model_dim, inter_dim, expert, topk), token, routing, tile in (
            itertools.product(args.shape, args.token, args.routing, args.tile)
        ):
            tile_m, tile_n = tile[:2]
            df.append(
                bench_a8w4_gemm2_tp(
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
        if rank == 0:
            df = pd.DataFrame(df)
            aiter.logger.info(
                "a8w4 gemm2 + TP all-reduce summary (markdown):\n%s",
                df.to_markdown(index=False),
            )
    finally:
        dist.destroy_process_group()


if __name__ == "__main__":
    main()

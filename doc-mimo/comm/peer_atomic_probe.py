"""Probe: do bf16x2 global atomics into HIP-IPC-mapped peer buffers work (xGMI)?

torchrun --nproc_per_node=8 doc-mimo/comm/peer_atomic_probe.py

Every rank adds (rank+1) to every element of every rank's buffer (own + peers,
own first), ITERS times. Expected per element: ITERS * sum(1..npes).
"""

import ctypes
import os

import torch
import torch.distributed as dist

import flydsl.compiler as flyc
import flydsl.expr as fx
from flydsl._mlir.dialects import llvm
from flydsl.expr import gpu, range_constexpr
from flydsl.expr.typing import T
from flydsl.expr.typing import Vector as Vec

from aiter.ops.flydsl.kernels.mxfp4_gemm_common import (
    _gep1,
    _global_base_ptr1,
    global_typed_ptr,
)
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw

# ---- HIP IPC (ctypes) ----------------------------------------------------------
_hip = ctypes.CDLL("libamdhip64.so")


class _Handle(ctypes.Structure):
    _fields_ = [("reserved", ctypes.c_byte * 64)]


_hip.hipIpcGetMemHandle.argtypes = [ctypes.POINTER(_Handle), ctypes.c_void_p]
_hip.hipIpcOpenMemHandle.argtypes = [
    ctypes.POINTER(ctypes.c_void_p),
    _Handle,
    ctypes.c_uint,
]
_hip.hipIpcCloseMemHandle.argtypes = [ctypes.c_void_p]
_hip.hipPointerGetAttribute.argtypes = [ctypes.c_void_p, ctypes.c_int, ctypes.c_void_p]


def _check(err, what):
    if err != 0:
        raise RuntimeError(f"{what} failed: hipError {err}")


def alloc_base(ptr):
    base = ctypes.c_void_p()
    _check(_hip.hipPointerGetAttribute(ctypes.byref(base), 11, ctypes.c_void_p(ptr)),
           "hipPointerGetAttribute")
    return base.value


def ipc_handle(base):
    h = _Handle()
    _check(_hip.hipIpcGetMemHandle(ctypes.byref(h), ctypes.c_void_p(base)), "hipIpcGetMemHandle")
    return bytes(h.reserved)


def ipc_open(raw):
    h = _Handle()
    ctypes.memmove(ctypes.byref(h), raw, 64)
    p = ctypes.c_void_p()
    _check(_hip.hipIpcOpenMemHandle(ctypes.byref(p), h, 1), "hipIpcOpenMemHandle")
    return p.value


# ---- kernel ----------------------------------------------------------------------
def build(npes, scope):
    tag = scope or "system"

    @flyc.kernel(name=f"peer_atomic_n{npes}_{tag}", known_block_size=[256, 1, 1])
    def peer_atomic(arg_tbl: fx.Int64, i32_rank: fx.Int32):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        pair = bx * fx.Int32(256) + tx
        tbl = global_typed_ptr(arg_tbl, T.i64, align=8)
        v = (i32_rank + fx.Int32(1)).to(fx.Float32)
        pk = Vec.from_elements([v, v], fx.Float32).to(fx.BFloat16)
        for i in range_constexpr(npes):
            base = fx.Int64(tbl[(i32_rank + fx.Int32(i)) % fx.Int32(npes)])
            llvm.AtomicRMWOp(
                llvm.AtomicBinOp.fadd,
                _gep1(_global_base_ptr1(base), pair * fx.Int32(4)),
                _raw(pk),
                llvm.AtomicOrdering.monotonic,
                syncscope=scope,
                alignment=4,
            )

    @flyc.jit
    def launch(arg_tbl: fx.Int64, i32_rank: fx.Int32, i32_grid: fx.Int32, stream: fx.Stream):
        peer_atomic(arg_tbl, i32_rank).launch(
            grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1), stream=stream
        )

    return launch


def main():
    local_rank = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(local_rank)
    dist.init_process_group("nccl", device_id=torch.device("cuda", local_rank))
    rank, npes = dist.get_rank(), dist.get_world_size()

    nbytes = 4 << 20  # 4 MB bf16 buffer (= gemm2 out at 512 tokens x 4096)
    pairs = nbytes // 4
    grid = pairs // 256
    pool = torch.cuda.MemPool()
    with torch.cuda.use_mem_pool(pool):
        buf = torch.zeros(nbytes // 2, dtype=torch.bfloat16, device="cuda")
    base = alloc_base(buf.data_ptr())
    mine = (ipc_handle(base), buf.data_ptr() - base)
    allh = [None] * npes
    dist.all_gather_object(allh, mine)
    opened, addrs = [], []
    for r, (h, off) in enumerate(allh):
        if r == rank:
            addrs.append(buf.data_ptr())
        else:
            b = ipc_open(h)
            opened.append(b)
            addrs.append(b + off)
    tbl_all = torch.tensor(addrs, dtype=torch.int64, device="cuda")
    tbl_self = torch.tensor([buf.data_ptr()], dtype=torch.int64, device="cuda")
    dist.barrier()

    ITERS = 4
    stream = torch.cuda.current_stream()
    for scope in ("agent", None):
        for n, tbl in ((1, tbl_self), (npes, tbl_all)):
            launch = build(n, scope)
            # correctness: zero everywhere, then ITERS launches on every rank
            buf.zero_()
            torch.cuda.synchronize()
            dist.barrier()
            for _ in range(ITERS):
                _run_compiled(launch, tbl.data_ptr(), rank, grid, stream)
            torch.cuda.synchronize()
            dist.barrier()
            expect = ITERS * (sum(range(1, npes + 1)) if n > 1 else rank + 1)
            v = buf.float()
            bad = int((v != expect).sum())
            # timing (values no longer checked)
            dist.barrier()
            t0, t1 = torch.cuda.Event(True), torch.cuda.Event(True)
            reps = 20
            t0.record()
            for _ in range(reps):
                _run_compiled(launch, tbl.data_ptr(), rank, grid, stream)
            t1.record()
            torch.cuda.synchronize()
            us = t0.elapsed_time(t1) * 1e3 / reps
            res = torch.tensor([bad, us], dtype=torch.float64, device="cuda")
            allres = [torch.zeros_like(res) for _ in range(npes)]
            dist.all_gather(allres, res)
            if rank == 0:
                bads = [int(r[0]) for r in allres]
                us_max = max(float(r[1]) for r in allres)
                remote = nbytes * (n - 1)  # bytes of atomic payload sent off-GPU
                print(
                    f"scope={scope or 'system':6s} dests={n}  expect={expect:4d} "
                    f"min/max={v.min().item():.0f}/{v.max().item():.0f} (rank0) "
                    f"mismatches/rank={bads}  {us_max:8.1f} us/launch  "
                    f"local {nbytes / us_max / 1e3:6.1f} GB/s  "
                    f"remote total {remote / us_max / 1e3:6.1f} GB/s",
                    flush=True,
                )

    torch.cuda.synchronize()
    dist.barrier()
    for b in opened:
        _check(_hip.hipIpcCloseMemHandle(ctypes.c_void_p(b)), "hipIpcCloseMemHandle")
    dist.barrier()
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

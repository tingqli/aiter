"""Probe: cross-GPU plain store (push) / load (pull) bandwidth over HIP IPC (xGMI).

torchrun --nproc_per_node=8 doc-mimo/comm/peer_store_probe.py

Per rank one symmetric allocation: [src: CHUNK][mailbox: npes x CHUNK].
  push: every rank copies its src into slot[rank] of each peer's mailbox
        (remote dwordx4 buffer_store; one-shot all-reduce traffic pattern)
  pull: every rank copies each peer's src into its own mailbox slot[peer]
        (remote dwordx4 buffer_load)
All 8 ranks run concurrently (all-to-all over the 7 links of each GPU).
"""

import os
import sys

import torch
import torch.distributed as dist

import flydsl.compiler as flyc
import flydsl.expr as fx
from flydsl.expr import gpu
from flydsl.expr.typing import T

from aiter.ops.flydsl.kernels import buffer_ops as bo
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import global_typed_ptr
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from peer_atomic_probe import _check, _hip, alloc_base, ipc_handle, ipc_open  # noqa: E402

import ctypes  # noqa: E402

# gfx942 buffer cache-policy bits: sc0=1, nt=2, sc1=16
CMS = {"default": 0, "nt": 2, "sc1": 16, "sc0|sc1": 17}


def build(mode, npes, chunk, cm):
    BPD = chunk // 4096  # workgroups per peer (256 lanes x 16 B)

    @flyc.kernel(name=f"peer_{mode}_n{npes}_c{chunk}_cm{cm}", known_block_size=[256, 1, 1])
    def k(arg_tbl: fx.Int64, i32_rank: fx.Int32):
        tx = fx.Int32(gpu.thread_id("x"))
        bx = fx.Int32(gpu.block_id("x"))
        # consecutive WGs target different peers -> all links busy at once
        peer = (i32_rank + bx % fx.Int32(npes - 1) + fx.Int32(1)) % fx.Int32(npes)
        if mode == "local":
            peer = i32_rank
        off = (bx // fx.Int32(npes - 1)) * fx.Int32(1024) + tx * fx.Int32(4)  # i32 elems
        tbl = global_typed_ptr(arg_tbl, T.i64, align=8)
        own = fx.Int64(tbl[i32_rank])
        far = fx.Int64(tbl[peer])
        if mode in ("push", "local"):
            src = bo.create_buffer_resource_from_addr(own)
            dst = bo.create_buffer_resource_from_addr(
                far + fx.Int64(chunk) + fx.Int64(i32_rank) * fx.Int64(chunk)
            )
            v = bo.buffer_load(src, off, vec_width=4, dtype=T.i32)
            bo.buffer_store(v, dst, off, cache_modifier=cm)
        else:
            src = bo.create_buffer_resource_from_addr(far)
            dst = bo.create_buffer_resource_from_addr(
                own + fx.Int64(chunk) + fx.Int64(peer) * fx.Int64(chunk)
            )
            v = bo.buffer_load(src, off, vec_width=4, dtype=T.i32, cache_modifier=cm)
            bo.buffer_store(v, dst, off)

    @flyc.jit
    def launch(arg_tbl: fx.Int64, i32_rank: fx.Int32, i32_grid: fx.Int32, stream: fx.Stream):
        k(arg_tbl, i32_rank).launch(
            grid=(fx.Int64(i32_grid), 1, 1), block=(256, 1, 1), stream=stream
        )

    return launch, (npes - 1) * BPD


def main():
    local_rank = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(local_rank)
    dist.init_process_group("nccl", device_id=torch.device("cuda", local_rank))
    rank, npes = dist.get_rank(), dist.get_world_size()
    stream = torch.cuda.current_stream()

    for chunk in (512 << 10, 1 << 20, 4 << 20, 16 << 20):
        pool = torch.cuda.MemPool()
        with torch.cuda.use_mem_pool(pool):
            sym = torch.zeros((npes + 1) * chunk // 4, dtype=torch.int32, device="cuda")
        src, mbox = sym[: chunk // 4], sym[chunk // 4 :].view(npes, chunk // 4)
        src.fill_(rank + 1)
        base = alloc_base(sym.data_ptr())
        allh = [None] * npes
        dist.all_gather_object(allh, (ipc_handle(base), sym.data_ptr() - base))
        opened, addrs = [], []
        for r, (h, off) in enumerate(allh):
            if r == rank:
                addrs.append(sym.data_ptr())
            else:
                b = ipc_open(h)
                opened.append(b)
                addrs.append(b + off)
        tbl = torch.tensor(addrs, dtype=torch.int64, device="cuda")
        dist.barrier()

        for mode in ("local", "push", "pull"):
            for cm_name, cm in CMS.items():
                if mode == "local" and cm:
                    continue
                launch, grid = build(mode, npes, chunk, cm)
                mbox.zero_()
                torch.cuda.synchronize()
                dist.barrier()
                _run_compiled(launch, tbl.data_ptr(), rank, grid, stream)
                torch.cuda.synchronize()
                dist.barrier()
                expect = torch.arange(1, npes + 1, device="cuda", dtype=torch.int32)
                expect[rank] = 0  # own slot is not written
                if mode == "local":  # every WG copies src into own slot[rank]
                    expect = torch.zeros_like(expect)
                    expect[rank] = rank + 1
                bad = int((mbox != expect.view(-1, 1)).sum())
                for _ in range(3):  # warmup
                    _run_compiled(launch, tbl.data_ptr(), rank, grid, stream)
                torch.cuda.synchronize()
                dist.barrier()
                reps = 20
                t0, t1 = torch.cuda.Event(True), torch.cuda.Event(True)
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
                    bads = sum(int(r[0]) for r in allres)
                    us_max = max(float(r[1]) for r in allres)
                    remote = (npes - 1) * chunk
                    print(
                        f"chunk={chunk >> 10:6d} KB {mode:4s} cm={cm_name:8s} "
                        f"mismatch={bads:3d}  {us_max:8.1f} us  "
                        f"{remote / us_max / 1e3:6.1f} GB/s per rank "
                        f"({remote / us_max / 1e3 / (npes - 1):5.1f} GB/s per link)",
                        flush=True,
                    )

        torch.cuda.synchronize()
        dist.barrier()
        for b in opened:
            _check(_hip.hipIpcCloseMemHandle(ctypes.c_void_p(b)), "hipIpcCloseMemHandle")
        dist.barrier()
        del sym, src, mbox
        pool = None

    dist.destroy_process_group()


if __name__ == "__main__":
    main()

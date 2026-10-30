"""One-shot all-gather (FlyDSL, HIP-IPC symmetric buffer) for the "N-split + all-gather"
MoE TP idea (doc-mimo/moe-new-tp.md), vs RCCL all_gather and the two-shot all-reduce.

Each rank pushes its contiguous ``shard`` bytes into every rank's gather region and
publishes one flag per (source rank, chunk); a workgroup returns once the same chunk
of every source rank has landed. The shard is viewed as rows of ``seg`` bytes; row r
of rank s lands at ``r * npes * seg + s * seg`` (``seg == shard``: rank-major planes,
``seg < shard``: column-interleaved, e.g. [tokens, model_dim] with model_dim split).

Sizes per token count M (Mimo v2.6, TP8, topk 8, inter 2048, model_dim 4096):
  AG1  stage1 fp8 activation, unsorted [M*topk, 256] per rank -> planes (gemm2 K tile
       = 256 = one rank's plane)
  AG2  gemm2 bf16 output [M, 512] per rank -> interleaved into [M, 4096] (seg 1 KB)
  AR   two-shot all-reduce of [M, 4096] bf16 (traditional TP), for reference

    torchrun --nproc_per_node=8 doc-mimo/comm/allgather_bench.py 128 512 2048
"""
import functools
import os
import sys

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
import torch.distributed as dist
from flydsl._mlir.dialects import llvm
from flydsl.expr import const_expr, gpu, range_constexpr, rocdl
from flydsl.expr.typing import T

sys.path.insert(
    0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "kernels")
)
import twoshot_allreduce as m  # noqa: E402
from aiter.ops.flydsl.kernels import buffer_ops as bo  # noqa: E402
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import global_typed_ptr  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw  # noqa: E402

MAX_WG = 512


@functools.cache
def compile_allgather(shard, seg, npes):
    assert shard % seg == 0 and seg % 16 == 0
    vecs = shard // 16  # 16 B vectors per shard
    threads = 256
    while threads > 64 and vecs // threads < 128:
        threads //= 2
    assert vecs % threads == 0, f"shard {shard} not divisible into {threads}x16 B"
    per_wg = 1
    while vecs // (threads * per_wg) > MAX_WG:
        per_wg *= 2
    assert vecs % (threads * per_wg) == 0
    chunks = vecs // (threads * per_wg)
    gather_bytes = npes * shard
    # Double-buffered by epoch parity: with one-shot there is no handshake that
    # stops a fast peer from pushing epoch e+1 before we consumed epoch e. Pushing
    # e+2 (same slot as e) needs our e+1 flags, sent only after our consumer of e.
    flag_off = 2 * gather_bytes
    total_bytes = flag_off + npes * chunks * 4

    @flyc.kernel(
        name=f"oneshot_ag_s{shard}_g{seg}_w{npes}_t{threads}_v{per_wg}",
        known_block_size=[threads, 1, 1],
    )
    def oneshot_ag(
        arg_in: fx.Int64, arg_tbl: fx.Int64, i32_rank: fx.Int32, i32_epoch: fx.Int32
    ):
        tx = fx.Int32(gpu.thread_id("x"))
        c = fx.Int32(gpu.block_id("x"))
        tbl = global_typed_ptr(arg_tbl, T.i64, align=8)
        # peer bases up front (see twoshot_allreduce: avoid vmcnt(0) between stores);
        # store i of WG c goes to rank (rank + c + i) % npes -> all links busy.
        peer = [(i32_rank + c + fx.Int32(i)) % fx.Int32(npes) for i in range(npes)]
        slot_off = fx.Int64(i32_epoch & fx.Int32(1)) * fx.Int64(gather_bytes)
        bases = [fx.Int64(tbl[p]) for p in peer]
        own = fx.Int64(tbl[i32_rank])
        src = bo.create_buffer_resource_from_addr(fx.Int64(arg_in))

        vals, dst_off = [], []
        for j in range_constexpr(per_wg):
            v = c * fx.Int32(threads * per_wg) + fx.Int32(j * threads) + tx
            vals.append(bo.buffer_load(src, v * fx.Int32(4), vec_width=4, dtype=T.i32))
            b = v * fx.Int32(16)
            if const_expr(seg == shard):
                d = i32_rank * fx.Int32(shard) + b
            else:
                d = (
                    (b // fx.Int32(seg)) * fx.Int32(npes * seg)
                    + i32_rank * fx.Int32(seg)
                    + b % fx.Int32(seg)
                )
            dst_off.append(d // fx.Int32(4))
        for i in range_constexpr(npes):
            dst = bo.create_buffer_resource_from_addr(bases[i] + slot_off)
            for j in range_constexpr(per_wg):
                bo.buffer_store(vals[j], dst, dst_off[j], cache_modifier=m._CM_SYS)
        rocdl.s_waitcnt(vmcnt=0)
        gpu.barrier()
        if tx < fx.Int32(npes):
            s = (i32_rank + tx) % fx.Int32(npes)
            slot = (i32_rank * fx.Int32(chunks) + c) * fx.Int32(4)
            llvm.AtomicRMWOp(
                llvm.AtomicBinOp.xchg,
                m._flag_ptr(fx.Int64(tbl[s]) + fx.Int64(flag_off), slot),
                _raw(i32_epoch),
                llvm.AtomicOrdering.monotonic,
                alignment=4,
            )
            mine = m._flag_ptr(
                own + fx.Int64(flag_off), (tx * fx.Int32(chunks) + c) * fx.Int32(4)
            )
            seen = m._flag_read(mine, llvm.AtomicOrdering.monotonic)
            while seen < i32_epoch:
                rocdl.s_sleep(1)
                seen = m._flag_read(mine, llvm.AtomicOrdering.monotonic)
            llvm.FenceOp(llvm.AtomicOrdering.acquire)

    @flyc.jit
    def launch(
        arg_in: fx.Int64,
        arg_tbl: fx.Int64,
        i32_rank: fx.Int32,
        i32_epoch: fx.Int32,
        stream: fx.Stream,
    ):
        oneshot_ag(arg_in, arg_tbl, i32_rank, i32_epoch).launch(
            grid=(chunks, 1, 1), block=(threads, 1, 1), stream=stream
        )

    return launch, total_bytes, (chunks, threads, per_wg)


class OneShotAllgather:
    """``__call__(inp)`` (uint8 [shard]) returns this rank's gather region (uint8
    [npes * shard], valid until the next call)."""

    def __init__(self, shard, seg):
        self.rank, self.npes = dist.get_rank(), dist.get_world_size()
        self.shard = shard
        self.launch, nbytes, self.cfg = compile_allgather(shard, seg, self.npes)
        self.buf = m.SymmetricBuffer(nbytes, self.rank, self.npes)
        g = self.npes * shard
        self.outs = [self.buf.storage[:g], self.buf.storage[g : 2 * g]]
        self.epoch = 0

    def __call__(self, inp):
        assert inp.dtype == torch.uint8 and inp.numel() == self.shard
        self.epoch += 1
        _run_compiled(
            self.launch,
            inp.data_ptr(),
            self.buf.addrs.data_ptr(),
            self.rank,
            self.epoch,
            torch.cuda.current_stream(),
        )
        return self.outs[self.epoch & 1]

    def close(self):
        self.buf.close()


def timeit(fn, reps=100, queued=True):
    """queued: park the GPU on a sleep kernel while the host enqueues all reps, so
    per-launch host overhead is hidden (GPU-side time only)."""
    for _ in range(5):
        fn()
    torch.cuda.synchronize()
    dist.barrier()
    t0, t1 = torch.cuda.Event(True), torch.cuda.Event(True)
    if queued:
        torch.cuda._sleep(20_000_000)
    t0.record()
    for _ in range(reps):
        fn()
    t1.record()
    torch.cuda.synchronize()
    return t0.elapsed_time(t1) * 1e3 / reps


def check_ag(ag, shard, seg, epochs=50):
    """Bit-exact vs RCCL all_gather over epochs of changing inputs; returns #bad bytes."""
    npes = dist.get_world_size()
    bad = 0
    g = torch.Generator(device="cuda").manual_seed(dist.get_rank())
    for k in range(epochs):
        x = torch.randint(0, 256, (shard,), dtype=torch.uint8, device="cuda", generator=g)
        out = ag(x)
        if k % 5 == 4:
            ref = torch.empty(npes * shard, dtype=torch.uint8, device="cuda")
            dist.all_gather_into_tensor(ref, x)
            ref = ref.view(npes, shard // seg, seg).transpose(0, 1).reshape(-1)
            torch.cuda.synchronize()
            bad += int((out != ref).sum())
    return bad


def main():
    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank, npes = dist.get_rank(), dist.get_world_size()
    topk, inter_shard, model_dim = 8, 2048 // npes, 4096
    for tok in [int(t) for t in sys.argv[1:]] or [128, 512, 2048]:
        cases = {
            # name: (shard bytes, seg bytes)
            "AG1": (tok * topk * inter_shard, tok * topk * inter_shard),
            "AG2": (tok * model_dim // npes * 2, model_dim // npes * 2),
        }
        res, info, ags = {}, {}, {}
        for name, (shard, seg) in cases.items():
            ag = OneShotAllgather(shard, seg)
            bad = check_ag(ag, shard, seg)
            x = torch.randint(0, 256, (shard,), dtype=torch.uint8, device="cuda")
            res[name] = timeit(lambda: ag(x))
            res[f"{name}_host"] = timeit(lambda: ag(x), queued=False)
            ref = torch.empty(npes * shard, dtype=torch.uint8, device="cuda")
            res[f"{name}_rccl"] = timeit(lambda: dist.all_gather_into_tensor(ref, x))
            info[name] = f"{shard / 2**20:.3g}MB/rank cfg={ag.cfg} bad={bad}"
            ags[name] = (ag, x)
        a1, x1 = ags["AG1"]
        a2, x2 = ags["AG2"]
        res["AG1+AG2"] = timeit(lambda: (a1(x1), a2(x2)))
        y = torch.randn(tok, model_dim, dtype=torch.bfloat16, device="cuda")
        ar = m.TwoShotAllreduce(y.shape, light_sync=True)
        res["twoshot_AR"] = timeit(lambda: ar(y))
        res["twoshot_AR_host"] = timeit(lambda: ar(y), queued=False)
        ar.close()
        for ag, _ in ags.values():
            ag.close()
        t = torch.tensor(list(res.values()), dtype=torch.float64, device="cuda")
        dist.all_reduce(t, op=dist.ReduceOp.MAX)
        if rank == 0:
            print(f"tok={tok:5d}  " + "  ".join(f"{k}: {v}" for k, v in info.items()))
            print(
                "           "
                + "  ".join(f"{k}={v:.1f}us" for k, v in zip(res, t.tolist())),
                flush=True,
            )
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

"""Same-machine all-reduce comparison: RCCL vs QuickReduce (QR-FP16) vs aiter
CustomAllreduce (bf16; copy-in "CA" and registered-input "CA-reg") vs our FlyDSL
two-shot (bf16), 8x MI300X.

git clone https://github.com/mk1-project/quickreduce.git
cd quickreduce
python3 -m pip install ./quickreduce --no-build-isolation

torchrun --nproc_per_node=8 doc-mimo/comm/qr_compare.py [sizes_in_KB ...]

Timing: CUDA events over 100 back-to-back calls (after warmup + barrier), slowest
rank reported. Correctness: each implementation vs an fp32 all-reduce of the same
input (max abs error relative to mean |ref|).

CA bf16: 
    the input is copied into aiter's pre-registered buffer on every call,
    which is the normal path outside CUDA graphs.

   Python 侧把预注册输入池的地址作为 reg_inp_ptr 传进去,C++ 端 custom_all_reduce.cu:445-452 
   的流程是:
    - 用 hipMemcpyAsync 把输入拷进这个池。池在初始化时已经注册,所以 kernel 能读其他 rank 的数据。
    - 此时 is_broadcast_reg_outptr=false,输出不需要注册。
      2-stage kernel 先把规约好的分片写进其他 rank 的 tmp 区,
      stage 3 再由每个 rank 从自己的 tmp 区拷到输出。
    - 小消息(8 卡时 ≤ 64KB)可以走 LL 快速路径。

CA-reg: the input lives in a buffer registered once at startup, so the kernel reads
        other ranks' data directly. This matches the path used during CUDA graph capture.
    
    - 输入 tensor 本身已注册,kernel 按它的指针查表,省掉了 memcpy。
    - 此时 is_broadcast_reg_outptr=true,输出也必须注册。
      stage 2 直接把结果写进其他 rank 的输出 buffer,没有 stage 3。
    - LL 快速路径被关闭。
   这对应 CUDA graph capture 时 enable_register_for_capturing=True 的情形:
   capture 时记录用到的地址,结束后由 register_graph_buffers 统一注册。

从数据流上看，我们的实现最接近 CA-reg,结构上相当于 CA 的 2-stage write mode 加上输出直写。
不同之处在于，我们的输入不需要注册。
 - reduce-scatter push:直接从本地输入 arg_in(一个普通 tensor)读出各分片，写进对应 rank 的 inbox。这一步是推(写远端),不是拉(读远端)。
 - 本地规约:在自己的 inbox 里按固定 rank 顺序用 fp32 累加，再转回 bf16。
 - all-gather push:把规约结果直接写进每个 rank 的 gather 区，这块 gather 区就是最终输出(self.out)。

所有远端读写都在一块 SymmetricBuffer 里，它在初始化时交换一次 IPC handle。

"""
import os
import sys

import torch
import torch.distributed as dist

import quickreduce as qr

from aiter.dist.device_communicators.custom_all_reduce import CustomAllreduce

sys.path.insert(
    0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "kernels")
)
import twoshot_allreduce as tp  # noqa: E402


def timeit(fn, reps=100):
    for _ in range(5):
        fn()
    torch.cuda.synchronize()
    dist.barrier()
    t0, t1 = torch.cuda.Event(True), torch.cuda.Event(True)
    t0.record()
    for _ in range(reps):
        fn()
    t1.record()
    torch.cuda.synchronize()
    return t0.elapsed_time(t1) * 1e3 / reps


def rel_err(out, ref):
    return ((out.float() - ref).abs().max() / ref.abs().mean()).item()


def main():
    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank, world = dist.get_rank(), dist.get_world_size()

    qr.init(world, rank)
    handles = [None] * world
    dist.all_gather_object(handles, bytes(qr.get_comm_handle()))
    qr.set_comm_handles([list(h) for h in handles])
    dist.barrier()

    sizes_kb = [int(s) for s in sys.argv[1:]] or [32, 128, 512, 1024, 2048, 4096, 8192, 16384, 65536]
    max_bytes = max(sizes_kb) * 1024

    # aiter CustomAllreduce needs a non-NCCL (gloo) group for its IPC exchange.
    ca = CustomAllreduce(
        dist.new_group(backend="gloo"),
        lr,
        max_size=max(64 * 1024 * 1024, max_bytes),
    )
    # Persistent IPC-registered input buffer (mirrors the CUDA-graph registered
    # path); per-size inputs are prefix views so data_ptr() matches the key.
    ca_in = torch.empty(max_bytes, dtype=torch.uint8, device="cuda")
    # Registered mode also writes results directly into peers' output buffers
    # (is_broadcast_reg_outptr), so the output must be IPC-registered too.
    ca_out_buf = torch.empty(max_bytes, dtype=torch.uint8, device="cuda")
    if not ca.disabled:
        ca.register_input_buffer(ca_in)
        ca.register_output_buffer(ca_out_buf)

    if rank == 0:
        print(
            f"{'size':>8s} {'RCCL bf16':>10s} {'QR-FP16':>10s} {'CA bf16':>10s} "
            f"{'CA-reg':>10s} {'ours bf16':>10s}   err(QR / CA / CA-reg / ours)"
        )
    for kb in sizes_kb:
        n = kb * 1024 // 2
        torch.manual_seed(rank)
        x16 = torch.randn(n, dtype=torch.float16, device="cuda")
        xbf = x16.to(torch.bfloat16)
        ref = x16.float()
        dist.all_reduce(ref)

        res = {}
        y = xbf.clone()
        res["rccl"] = timeit(lambda: dist.all_reduce(y))

        e_qr = rel_err(qr.allreduce(1, x16), ref)
        res["qr"] = timeit(lambda: qr.allreduce(1, x16))

        ours = tp.TwoShotAllreduce(xbf.shape)
        ref_bf = xbf.float()
        dist.all_reduce(ref_bf)
        e_ours = rel_err(ours(xbf), ref_bf)
        res["ours"] = timeit(lambda: ours(xbf))
        ours.close()

        nan = float("nan")
        res["ca"] = res["ca_reg"] = e_ca = e_ca_reg = nan
        if ca.should_custom_ar(xbf):
            ca_out = torch.empty_like(xbf)
            # copy-in path: input staged into the pre-registered pool each call
            e_ca = rel_err(ca.all_reduce(xbf, out=ca_out), ref_bf)
            res["ca"] = timeit(lambda: ca.all_reduce(xbf, out=ca_out))
            # registered path: kernel reads peers' input buffers directly
            x_reg = ca_in[: n * 2].view(torch.bfloat16)
            x_reg.copy_(xbf)
            out_reg = ca_out_buf[: n * 2].view(torch.bfloat16)
            e_ca_reg = rel_err(
                ca.all_reduce(x_reg, out=out_reg, registered_input=True), ref_bf
            )
            res["ca_reg"] = timeit(
                lambda: ca.all_reduce(x_reg, out=out_reg, registered_input=True)
            )

        t = torch.tensor(
            [res["rccl"], res["qr"], res["ca"], res["ca_reg"], res["ours"],
             e_qr, e_ca, e_ca_reg, e_ours],
            dtype=torch.float64, device="cuda",
        )
        dist.all_reduce(t, op=dist.ReduceOp.MAX)
        if rank == 0:
            v = t.tolist()
            label = f"{kb}K" if kb < 1024 else f"{kb // 1024}M"
            print(
                f"{label:>8s} {v[0]:10.1f} {v[1]:10.1f} {v[2]:10.1f} {v[3]:10.1f} "
                f"{v[4]:10.1f}   {v[5]:.2g} / {v[6]:.2g} / {v[7]:.2g} / {v[8]:.2g}",
                flush=True,
            )
    ca.close()
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

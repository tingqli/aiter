"""Same-machine all-reduce comparison: RCCL vs QuickReduce (QR-FP16) vs our FlyDSL
two-shot (bf16), 8x MI300X.

    PYTHONPATH=/tmp/qr_src/quickreduce torchrun --nproc_per_node=8 \
        doc-mimo/comm/qr_compare.py [sizes_in_KB ...]

Timing: CUDA events over 100 back-to-back calls (after warmup + barrier), slowest
rank reported. Correctness: each implementation vs an fp32 all-reduce of the same
input (max abs error relative to mean |ref|).
"""
import os
import sys

import torch
import torch.distributed as dist

import quickreduce as qr

sys.path.insert(
    0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "kernels")
)
import test_a8w4_gemm2_tp as tp  # noqa: E402


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

    sizes_kb = [int(s) for s in sys.argv[1:]] or [32, 128, 512, 1024, 2048, 4096, 8192, 16384]
    if rank == 0:
        print(f"{'size':>8s} {'RCCL fp16':>10s} {'QR-FP16':>10s} {'ours bf16':>10s}   err(QR / ours)")
    for kb in sizes_kb:
        n = kb * 1024 // 2
        torch.manual_seed(rank)
        x16 = torch.randn(n, dtype=torch.float16, device="cuda")
        xbf = x16.to(torch.bfloat16)
        ref = x16.float()
        dist.all_reduce(ref)

        res = {}
        y = x16.clone()
        res["rccl"] = timeit(lambda: dist.all_reduce(y))

        e_qr = rel_err(qr.allreduce(1, x16), ref)
        res["qr"] = timeit(lambda: qr.allreduce(1, x16))

        ours = tp.TwoShotAllreduce(xbf.shape)
        ref_bf = xbf.float()
        dist.all_reduce(ref_bf)
        e_ours = rel_err(ours(xbf), ref_bf)
        res["ours"] = timeit(lambda: ours(xbf))
        ours.close()

        t = torch.tensor([res["rccl"], res["qr"], res["ours"], e_qr, e_ours], dtype=torch.float64, device="cuda")
        dist.all_reduce(t, op=dist.ReduceOp.MAX)
        if rank == 0:
            v = t.tolist()
            label = f"{kb}K" if kb < 1024 else f"{kb // 1024}M"
            print(f"{label:>8s} {v[0]:10.1f} {v[1]:10.1f} {v[2]:10.1f}   {v[3]:.2g} / {v[4]:.2g}", flush=True)
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

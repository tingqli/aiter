"""Standalone two-shot all-reduce bench vs RCCL, with a correctness check over
200 epochs of changing inputs.

    torchrun --nproc_per_node=8 doc-mimo/comm/twoshot_bench.py 128 512 2048
    LIGHT=1,0 ...   # also time the release-fence (strict) sync variant
"""
import os
import sys

import torch
import torch.distributed as dist

sys.path.insert(
    0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "kernels")
)
import twoshot_allreduce as m  # noqa: E402


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


def main():
    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank = dist.get_rank()
    variants = [v == "1" for v in os.environ.get("LIGHT", "1,0").split(",")]
    for tok in [int(t) for t in sys.argv[1:]] or [128, 512, 2048]:
        x = torch.randn(tok, 4096, dtype=torch.bfloat16, device="cuda") * (rank + 1)
        res = {}
        y = x.clone()
        res["rccl"] = timeit(lambda: dist.all_reduce(y))
        for light in variants:
            ar = m.TwoShotAllreduce(x.shape, light_sync=light)
            # correctness over many epochs, input changes every epoch
            bad = 0
            for k in range(200):
                xi = x * (1 + (k % 7))
                out = ar(xi)
                if k % 10 == 9:
                    ref = xi.float()
                    dist.all_reduce(ref)
                    torch.cuda.synchronize()
                    diff = (out.float() - ref).abs()
                    bad += int((diff > 0.02 * ref.abs() + 0.05 * (1 + k % 7)).sum())
            res[f"twoshot{'_light' if light else '_fence'} bad={bad}"] = timeit(
                lambda: ar(x)
            )
            ar.close()
        t = torch.tensor(list(res.values()), dtype=torch.float64, device="cuda")
        dist.all_reduce(t, op=dist.ReduceOp.MAX)
        if rank == 0:
            print(
                f"tok={tok:5d} ({tok * 8 // 1024} MB): "
                + "  ".join(f"{k}={v:.1f}us" for k, v in zip(res, t.tolist())),
                flush=True,
            )
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

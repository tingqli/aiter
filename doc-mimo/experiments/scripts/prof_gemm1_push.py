import os, sys, collections, torch, torch.distributed as dist
sys.path.insert(0, "/sgl-workspace/aiter/doc-mimo/kernels")
import gemm1_ag_tp as g
from torch.profiler import profile, ProfilerActivity

def prof_timeit(fn, reps=50, queued=True):
    for _ in range(5): fn()
    torch.cuda.synchronize(); dist.barrier()
    with profile(activities=[ProfilerActivity.CUDA]) as p:
        for _ in range(reps): fn()
        torch.cuda.synchronize()
    agg = collections.defaultdict(float)
    for e in p.events():
        if e.device_type.name == "CUDA":
            agg[e.name[:60]] += e.device_time / reps
    if dist.get_rank() == 0:
        print("   ", "; ".join(f"{k}={v:.1f}" for k, v in agg.items() if v > 0.5), flush=True)
    return sum(agg.values())
g.timeit = prof_timeit
lr = int(os.environ["LOCAL_RANK"]); torch.cuda.set_device(lr)
dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
g.run(512, 32, False, dist.get_rank(), dist.get_world_size())
dist.destroy_process_group()

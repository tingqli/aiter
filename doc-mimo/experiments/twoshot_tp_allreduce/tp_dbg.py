import os, sys, torch, torch.distributed as dist, logging
sys.path.insert(0, "doc-mimo/kernels")
import twoshot_allreduce as m
import aiter
lr = int(os.environ["LOCAL_RANK"]); torch.cuda.set_device(lr)
dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
aiter.logger.setLevel(logging.ERROR)
orig = m._rank_max
vals = []
def rm(x):
    vals.append(float(x)); return orig(x)
m._rank_max = rm
m.bench_a8w4_gemm2_tp(512, 4096, 256, 256, 8, routing="uniform", tile_m=64, tile_n=128, dyn_rows=True)
print(f"rank{dist.get_rank()} gemm2={vals[0]:.1f} ar={vals[3]:.1f} both={vals[6]:.1f}", flush=True)
dist.destroy_process_group()

import os, sys, torch, torch.distributed as dist
sys.path.insert(0, "/sgl-workspace/aiter/doc-mimo/comm")
from allgather_bench import OneShotAllgather, timeit, check_ag
lr = int(os.environ["LOCAL_RANK"]); torch.cuda.set_device(lr)
dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
shard = 512 * 8 * 256  # AG1 at 512 tokens
out = []
for seg in [shard, 4096, 1024, 512, 256, 128, 64]:
    ag = OneShotAllgather(shard, seg)
    bad = check_ag(ag, shard, seg, epochs=10)
    x = torch.randint(0, 256, (shard,), dtype=torch.uint8, device="cuda")
    t = min(timeit(lambda: ag(x)) for _ in range(3))
    ag.close()
    tt = torch.tensor([t, bad], dtype=torch.float64, device="cuda"); dist.all_reduce(tt, op=dist.ReduceOp.MAX)
    out.append(f"seg={seg:>7}B: {tt[0].item():6.1f}us bad={int(tt[1])}")
if dist.get_rank() == 0: print("\n".join(out))
dist.destroy_process_group()

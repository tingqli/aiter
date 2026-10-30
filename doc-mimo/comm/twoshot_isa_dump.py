"""Compile + run the two-shot all-reduce once and dump its ISA:

    FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fdts \
        torchrun --nproc_per_node=8 doc-mimo/comm/twoshot_isa_dump.py
    grep -nE "buffer_store|buffer_wbl2|buffer_inv|s_waitcnt vmcnt" \
        /tmp/fdts/*twoshot*/21_final_isa.s
"""
import os, sys, torch, torch.distributed as dist
sys.path.insert(
    0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "kernels")
)
import twoshot_allreduce as m
lr = int(os.environ["LOCAL_RANK"]); torch.cuda.set_device(lr)
dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
x = torch.randn(512, 4096, dtype=torch.bfloat16, device="cuda")
ar = m.TwoShotAllreduce(x.shape)
y = ar(x); torch.cuda.synchronize()
ref = x.float().clone(); dist.all_reduce(ref)
print("rank", dist.get_rank(), "maxdiff", (y.float() - ref).abs().max().item(), flush=True)
ar.close(); dist.destroy_process_group()

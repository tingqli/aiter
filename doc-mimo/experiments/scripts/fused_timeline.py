"""Timeline of the fused gemm2 + all-reduce kernel (gemm2_ar_fused.py) on rank 0:
when each 512-column chunk becomes final (gemm2 tile probe) vs when the comm units
of that chunk see it, finish the reduce-scatter handshake and finish.

    AR_PROBE=1 torchrun --nproc_per_node=8 doc-mimo/experiments/scripts/fused_timeline.py 128 512 2048
    CWG=32 VPT=1 ...
"""
import os
import sys

import torch
import torch.distributed as dist

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "..", "kernels"))
sys.path.insert(0, os.path.join(HERE, "..", "..", "comm"))
os.environ.setdefault("AR_PROBE", "1")

import gemm2_ar_fused as g  # noqa: E402
from test_a8w4_gemm2 import a8w4_gemm2  # noqa: E402


def main():
    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank = dist.get_rank()
    cwg = int(os.environ.get("CWG", "32"))
    vpt = int(os.environ.get("VPT", "1"))
    split = os.environ.get("SPLIT", "0") == "1"
    sep = os.environ.get("SEP", "0") == "1"
    chunk = int(os.environ.get("CHUNK", "512"))
    hp = int(os.environ.get("ROUTE", "0"))
    D, BM, TN = 4096, 32, 128
    NB = D // TN
    for tok in [int(t) for t in sys.argv[1:]] or [512]:
        g2args, g2kw, out = g.make_case(tok, rank)
        f = g.FusedGemm2AR(
            D, mmax=max(2048, tok), cwg=cwg, vpt=vpt, split=split, sep=sep, chunk_n=chunk,
            route=hp,
        )
        seids, nv = g2args[6], g2args[7]
        dbg = torch.zeros(seids.numel() * NB * 2, dtype=torch.int64, device="cuda")
        L = f.L
        tim = f.buf.storage[L["tim"]: L["tim"] + L["nu_max"] * 32].view(torch.int64)
        rows = []
        for it in range(6):
            # steady state: 20 launches back to back (ranks re-align every launch:
            # a launch ends only once all ranks' all-gather flags arrived); the
            # probe buffers keep the last launch
            for _ in range(20):
                out.zero_()
                f(a8w4_gemm2, *g2args, out=out, dbg=dbg, **g2kw)
            torch.cuda.synchronize()
            dist.barrier()
            if it < 1:
                continue
            mb = int(nv[0]) // BM
            ts = dbg[: mb * NB * 2].view(mb, NB, 2).double() * 1e-2  # 100 MHz -> us
            R = tok // f.npes
            U = R // L["ru"]
            nu = U * L["nch"]
            tu = tim[: nu * 4].view(L["nch"], U, 4).double() * 1e-2
            t0 = min(float(ts[..., 0].min()), float(tu[..., 0].min()))
            ready = (ts[..., 1].amax(0).view(L["nch"], -1).amax(1) - t0).tolist()
            rows.append(
                dict(
                    gemm_end=float(ts[..., 1].max()) - t0,
                    ready=ready,
                    u_start=(tu[..., 0].amin(1) - t0).tolist(),
                    u_seen=(tu[..., 1].amax(1) - t0).tolist(),
                    u_rs=(tu[..., 2].amax(1) - t0).tolist(),
                    u_done=(tu[..., 3].amax(1) - t0).tolist(),
                )
            )
        f.close()
        if rank == 0:
            r = sorted(rows, key=lambda x: max(x["u_done"]))[len(rows) // 2]
            print(f"tok={tok} cwg={cwg} vpt={vpt} split={int(split)} sep={int(sep)} chunk={chunk} route={hp} units/chunk={U} gemm2 tiles end at "
                  f"{r['gemm_end']:.1f} us, last unit done at {max(r['u_done']):.1f} us")
            print("  chunk | final(gemm) | 1st unit start | last unit saw ready | "
                  "last RS handshake | last unit done   (us from kernel start)")
            for c in range(len(r["ready"])):
                print(f"  {c:5d} | {r['ready'][c]:11.1f} | {r['u_start'][c]:14.1f} | "
                      f"{r['u_seen'][c]:19.1f} | {r['u_rs'][c]:17.1f} | {r['u_done'][c]:15.1f}",
                      flush=True)
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

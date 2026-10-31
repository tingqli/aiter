"""Upper bound of gemm2 || all-reduce concurrency: the all-reduce works on its own
buffer (fixed data, no dependency on gemm2's result), so nothing ever waits for
gemm2. Shows how much of the all-reduce can hide behind gemm2 at best, and what
each way of running them concurrently costs.

  gemm2(m) / gemm2(g)     gemm2 alone (moe_buf zeroing included, as everywhere)
  AR                      standalone two-shot all-reduce (256+ WGs) of buffer x
  seq                     gemm2(m) then AR
  side g->AR / AR->g      gemm2(m) on the main stream, two-shot AR of x on a
                          high-priority side stream, enqueued gemm2-first / AR-first
  commWG(c) alone         the fused kernel's comm role alone (c WGs, chunked
                          two-shot, own kernel): its standalone speed
  fused nodep o=m/g c     ONE kernel: c comm WGs all-reduce x while gemm2 (tile order
                          m or g) computes; no counters waited on
  sep nodep c             gemm2(m) + comm-role kernel (c WGs) on a side stream

    torchrun --nproc_per_node=8 doc-mimo/experiments/fused_ar_concurrency_bound/concurrency_bound.py 128 512 1024 2048
    CWG=32,64,128 CHUNK=256 ...
"""
import os
import sys

import torch
import torch.distributed as dist

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "..", "..", "kernels"))
sys.path.insert(0, os.path.join(HERE, "..", "..", "comm"))

import gemm2_ar_fused as g  # noqa: E402
import twoshot_allreduce as tsar  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled  # noqa: E402
from allgather_bench import timeit  # noqa: E402
from test_a8w4_gemm2 import a8w4_gemm2  # noqa: E402


def best(fn):
    return min(timeit(fn) for _ in range(3))


def main():
    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank = dist.get_rank()
    D = 4096
    cwgs = [int(x) for x in os.environ.get("CWG", "32,64,128").split(",")]
    chunk = int(os.environ.get("CHUNK", "256"))
    side = torch.cuda.Stream(priority=-1)
    ev0, ev1 = torch.cuda.Event(), torch.cuda.Event()

    for tok in [int(t) for t in sys.argv[1:]] or [128, 512, 1024, 2048]:
        g2args, g2kw, out = g.make_case(tok, rank)
        torch.manual_seed(77 + rank)
        x = torch.randn((tok, D), dtype=torch.bfloat16, device="cuda")
        ts = tsar.TwoShotAllreduce(x.shape)

        def gemm2(order="m"):
            out.zero_()
            a8w4_gemm2(*g2args, out, tile_order=order, **g2kw)

        def on_side(first, second):
            """first on `first` stream ('main'/'side'), both concurrent."""
            main = torch.cuda.current_stream()
            out.zero_()
            ev0.record(main)
            side.wait_event(ev0)
            for who in (first, second):
                if who == "g":
                    a8w4_gemm2(*g2args, out, tile_order="m", **g2kw)
                else:
                    with torch.cuda.stream(side):
                        ts(x)
            ev1.record(side)
            main.wait_event(ev1)

        res, info = {}, []
        res["gemm2(m)"] = best(lambda: gemm2("m"))
        res["gemm2(g)"] = best(lambda: gemm2("g"))
        res["AR"] = best(lambda: ts(x))
        res["seq"] = best(lambda: (gemm2("m"), ts(x)))
        res["side g->AR"] = best(lambda: on_side("g", "a"))
        res["side AR->g"] = best(lambda: on_side("a", "g"))
        # sanity: the side-stream all-reduce result is still right
        on_side("g", "a")
        torch.cuda.synchronize()
        ref = x.float()
        dist.all_reduce(ref)
        info.append(f"side AR bad={int(((ts.out.float() - ref).abs() > 1e-2 * ref.abs() + 5e-2).sum())}")

        for cwg in cwgs:
            # comm WGs launched but idle: cost of their footprint alone (grid, VGPRs)
            fk = g.FusedGemm2AR(D, mmax=max(2048, tok), cwg=cwg, chunk_n=chunk,
                                nodep=True, order="m", skip=True)

            def idle():
                out.zero_()
                return fk(a8w4_gemm2, *g2args, out=out, **g2kw)

            res[f"fused idle o=m c{cwg}"] = best(idle)
            fk.close()
            for order in ("m", "g"):
                f = g.FusedGemm2AR(D, mmax=max(2048, tok), cwg=cwg, chunk_n=chunk,
                                   nodep=True, order=order)
                f.src(tok).copy_(x)

                def fused():
                    out.zero_()
                    return f(a8w4_gemm2, *g2args, out=out, **g2kw)

                y = fused()
                torch.cuda.synchronize()
                bad = int(((y.float() - ref).abs() > 1e-2 * ref.abs() + 5e-2).sum())
                info.append(f"fused o={order} c{cwg} bad={bad}")
                res[f"fused nodep o={order} c{cwg}"] = best(fused)
                if order == "m":
                    # comm role alone (own kernel) and gemm2(m) + it on a side stream
                    launch = g.compile_ar_kernel(f.ar, D=D, chunk=chunk, cg=chunk // 128,
                                                 bm=g2kw["tile_m"])

                    def comm_alone():
                        f.epoch += 1
                        _run_compiled(launch, f.buf.addrs.data_ptr(), out.data_ptr(),
                                      g2args[7].data_ptr(), tok, f.rank, f.epoch,
                                      torch.cuda.current_stream())

                    res[f"commWG c{cwg} alone"] = best(comm_alone)
                    f.close()
                    fs = g.FusedGemm2AR(D, mmax=max(2048, tok), cwg=cwg, chunk_n=chunk,
                                        nodep=True, order="m", sep=True)
                    fs.src(tok).copy_(x)

                    def sep():
                        out.zero_()
                        return fs(a8w4_gemm2, *g2args, out=out, **g2kw)

                    y = sep()
                    torch.cuda.synchronize()
                    bad = int(((y.float() - ref).abs() > 1e-2 * ref.abs() + 5e-2).sum())
                    info.append(f"sep c{cwg} bad={bad}")
                    res[f"sep nodep c{cwg}"] = best(sep)
                    fs.close()
                else:
                    f.close()
        ts.close()
        t = torch.tensor(list(res.values()), dtype=torch.float64, device="cuda")
        dist.all_reduce(t, op=dist.ReduceOp.MAX)
        if rank == 0:
            r = dict(zip(res, t.tolist()))
            g2, ar = r["gemm2(m)"], r["AR"]
            print(f"tok={tok:5d}  " + "  ".join(info), flush=True)
            for k, v in r.items():
                hid = (g2 + ar - v) / ar * 100 if k not in ("gemm2(m)", "gemm2(g)", "AR") and "alone" not in k and "idle" not in k else None
                print(f"    {k:24s} {v:7.1f} us" + (f"   AR hidden {hid:5.0f}%" if hid is not None else ""), flush=True)
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

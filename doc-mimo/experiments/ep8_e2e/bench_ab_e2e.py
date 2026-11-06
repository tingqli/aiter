"""Interleaved A/B timing of the whole EP8 MoE (prep + gemm1 + gemm2) for config
variants: rounds alternate the variants (power/clock drift hits all alike), median.

    python bench_ab_e2e.py -t 1024 4096 --adt fp8 bf16 \\
        --var "l128" "l128 sched=False" "l128 g1.sch=1"

A variant is a CFGS name followed by overrides ``key=value`` (``g1.key`` / ``g2.key``
go to one stage), or ``auto`` (ep8_moe.pick_cfg).
"""
import argparse
import ast
import copy
import os
import statistics
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402


def make_cfg(spec):
    name, *ovr = spec.split()
    cfg = copy.deepcopy(EP.CFGS[name])
    for o in ovr:
        k, v = o.split("=", 1)
        v = ast.literal_eval(v)
        if "." in k:  # g1.key / g2.key / bf16.g1.key
            *path, k = k.split(".")
            d = cfg
            for q in path:
                d = d.setdefault(q, {})
            d[k] = v
        else:
            cfg[k] = v
    return cfg


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="+", default=[1024, 4096])
    p.add_argument("--adt", nargs="+", default=["fp8"])
    p.add_argument("--var", nargs="+", default=["l128"])
    p.add_argument("--rounds", type=int, default=5)
    p.add_argument("--iters", type=int, default=10)
    p.add_argument("--check", type=int, default=1, help="cos check vs reference")
    p.add_argument("--routing", default="uniform", help="uniform | hot (ep8_common)")
    args = p.parse_args()
    W = C.make_weights()
    P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
    for tok in args.t:
        x, tw, ti = C.make_routing(tok, routing=args.routing)
        for adt in args.adt:
            fns = []
            for spec in args.var:
                cfg = make_cfg(spec) if spec != "auto" else copy.deepcopy(EP.pick_cfg(tok))
                fn = (lambda cfg=cfg: EP.ep8_moe(x, P, tw, ti, rank=C.RANK, adt=adt, cfg=cfg))
                out = fn()
                if args.check:
                    ref = C.ref_moe(x, tw, ti, W, a8w4=adt == "fp8")
                    cd = C.cos_diff(ref, out.float())
                    assert cd < 1e-4, (spec, cd)
                fns.append((spec, fn))
            torch.cuda.synchronize()
            res = {s: [] for s, _ in fns}
            for _ in range(args.rounds):
                for s, fn in fns:
                    res[s].append(C.time_cold(fn, iters=args.iters))
            base = statistics.median(res[fns[0][0]])
            for s, _ in fns:
                m = statistics.median(res[s])
                rt = f" {args.routing}" if args.routing != "uniform" else ""
                print(f"tok {tok:6d} {adt:4s} {s:44s}: {m:8.1f} us ({m / base - 1:+6.1%})"
                      f"  [min {min(res[s]):7.1f} max {max(res[s]):7.1f}]{rt}", flush=True)


if __name__ == "__main__":
    main()

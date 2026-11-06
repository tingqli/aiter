"""EP8 end-to-end: sort -> (x quant) -> gemm1 -> gemm2 for each config of
ep8_moe.CFGS, cold caches, vs the rooflines (memory / compute / sum).

    python doc-mimo/experiments/ep8_e2e/bench_e2e.py -t 16 256 1024 4096 16384 --adt fp8 bf16
"""
import argparse
import json
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402


def stage(name):
    n = name.lower()
    if "sorting" in n or "ep_prep" in n:
        return "prep"
    if "ep_gemm1" in n:
        return "g1"
    if "ep_gemm2" in n:
        return "g2"
    if name == "kernel_0" or "quant" in n:
        return "quant"
    return "other"


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="*", default=[16, 64, 256, 1024, 4096, 16384])
    p.add_argument("--adt", nargs="*", default=["fp8", "bf16"])
    p.add_argument("--cfg", nargs="*", default=list(EP.CFGS) + ["auto"],
                   help="CFGS names; auto = ep8_moe.pick_cfg(tokens)")
    p.add_argument("--json", default="")
    args = p.parse_args()
    W = C.make_weights()
    P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
    mask = C.expert_mask()
    rows = []
    for tok in args.t:
        x, tw, ti = C.make_routing(tok)
        r = C.roofline(tok, ti)
        print(f"tokens {tok:6d}: {C.fmt_roof(r)}", flush=True)
        for adt in args.adt:
            ref = C.ref_moe(x, tw, ti, W, a8w4=adt == "fp8")
            comp = r["fp8"] if adt == "fp8" else r["bf16"]
            for name in args.cfg:
                cfg = EP.pick_cfg(tok) if name == "auto" else EP.CFGS[name]
                fn = lambda cfg=cfg: EP.ep8_moe(x, P, tw, ti, rank=C.RANK, adt=adt, cfg=cfg)  # noqa: E731
                try:
                    cd = C.cos_diff(ref, fn().float())
                    us = C.time_cold(fn)
                    prof = C.profile_cold(fn, stage)
                except Exception as ex:  # noqa: BLE001
                    print(f"   {adt:4s} {name:5s}: FAIL {type(ex).__name__}: {str(ex)[:160]}")
                    continue
                br = " ".join(f"{k} {v:6.1f}" for k, v in prof.items() if k != "total")
                print(f"   {adt:4s} {name:5s}: {us:8.1f} us | x{us / r['mem']:.2f} mem "
                      f"x{us / comp:.2f} comp x{us / (r['mem'] + comp):.2f} sum | "
                      f"cos {cd:.1e} | {br}", flush=True)
                rows.append(dict(tokens=tok, adt=adt, cfg=name, us=us, cos=cd, prof=prof,
                                 mem=r["mem"], comp=comp))
    if args.json:
        with open(args.json, "w") as f:
            json.dump(rows, f, indent=1)


if __name__ == "__main__":
    main()

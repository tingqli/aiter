"""Correctness + cold timing of the fused small-batch EP8 kernel (ep8_small.py)
against the fp32 reference and the 3-launch pipeline.

    python doc-mimo/kernels/test_ep8_small.py -t 1 16 64 256 512 --adt fp8 bf16
"""
import argparse
import os
import sys

import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
import ep8_small as S  # noqa: E402


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="*", default=[16, 256])
    p.add_argument("--adt", nargs="*", default=["fp8", "bf16"])
    p.add_argument("--maxm", type=int, default=512)
    p.add_argument("--cfg", default="{}", help="SMALL_CFG overrides (python dict literal)")
    p.add_argument("--base", default="l128", help="3-launch config to compare ('' = skip)")
    p.add_argument("--reps", type=int, default=3, help="repeat runs (counter reset check)")
    args = p.parse_args()
    import ast
    cfg = ast.literal_eval(args.cfg)
    W = C.make_weights()
    P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
    for tok in args.t:
        x, tw, ti = C.make_routing(tok)
        r = C.roofline(tok, ti)
        print(f"tokens {tok:5d}: {C.fmt_roof(r)}", flush=True)
        for adt in args.adt:
            ref = C.ref_moe(x, tw, ti, W, a8w4=adt == "fp8")
            fn = lambda: S.ep8_moe_small(x, P, tw, ti, rank=C.RANK, adt=adt,  # noqa: E731
                                         maxm=args.maxm, cfg=cfg)
            outs = [fn().float() for _ in range(args.reps)]
            torch.cuda.synchronize()
            cds = [C.cos_diff(ref, o) for o in outs]
            us = C.time_cold(fn)
            msg = (f"   {adt:4s} small: {us:7.1f} us x{us / r['mem']:.2f} mem | cos "
                   + " ".join(f"{c:.1e}" for c in cds))
            if args.base:
                bfn = lambda: EP.ep8_moe(x, P, tw, ti, rank=C.RANK, adt=adt,  # noqa: E731
                                         cfg=EP.CFGS[args.base])
                bus = C.time_cold(bfn)
                msg += f" | 3-launch {args.base}: {bus:7.1f} us"
            print(msg, flush=True)


if __name__ == "__main__":
    main()

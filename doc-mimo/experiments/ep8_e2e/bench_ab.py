"""A/B timing of EP8 gemm1/gemm2 variants, interleaved (power/clock drift hits all
variants alike), median over rounds; optional ISA register report.

    python bench_ab.py g1 -t 16384 --adt fp8 --base "dict(bm=128, ni=128, nw=8, rowv=(32,64,128))" \
        --var "dict(sch=1)" "dict(sch=3, arb=128)"

var keys are ep_gemm1/ep_gemm2 kwargs plus ``sched=True`` (the prep's tile order).
"""
import argparse
import ast
import glob
import os
import statistics
import sys
import tempfile

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402


def _lit(s):
    s = s.strip()
    if s.startswith("dict(") and s.endswith(")"):
        node = ast.parse(s, mode="eval").body
        return {kw.arg: ast.literal_eval(kw.value) for kw in node.keywords}
    return ast.literal_eval(s)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("what", choices=["g1", "g2"])
    p.add_argument("-t", type=int, default=16384)
    p.add_argument("--adt", default="fp8")
    p.add_argument("--base", default="dict(bm=128, rowv=(32, 64, 128))")
    p.add_argument("--var", nargs="+", default=["dict()"])
    p.add_argument("--rounds", type=int, default=5)
    p.add_argument("--iters", type=int, default=10)
    args = p.parse_args()
    base = _lit(args.base)
    W = C.make_weights()
    P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
    x, tw, ti = C.make_routing(args.t)
    bm = base["bm"]
    import ep8_prep
    fp8 = args.adt == "fp8"
    sids, sw, seids, nv, x8, xs, sched = ep8_prep.ep_prep(
        ti, tw, x, e0=C.RANK * C.E_LOCAL, block_m=bm, quant=fp8)
    ss = seids.numel() * bm
    if not fp8:
        x8, xs = x, None
    a = torch.zeros((ss, C.I), dtype=torch.uint8 if fp8 else torch.bfloat16, device="cuda")
    a_s = torch.zeros((ss, C.I // EP.QG1), dtype=torch.float32, device="cuda") if fp8 else None
    out = torch.zeros((args.t, C.H), dtype=torch.bfloat16, device="cuda")
    if args.what == "g2":  # realistic A (zero operands draw less MFMA power)
        EP.ep_gemm1(x8, xs, P, sids, seids, nv, a, a_s, adt=args.adt, block_m=bm, ni=128,
                    rowv=base.get("rowv"), nw=8, **({"arb": 128} if fp8 else {}))
    fns = []
    for v in args.var:
        kw = dict(base)
        kw.update(_lit(v))
        kw.pop("bm")
        kw["sched"] = sched if kw.pop("sched", False) else None
        if not fp8:
            kw.pop("arb", None)  # bf16: one 128-K W chunk = 256 A bytes per row
        if args.what == "g1":
            kw.setdefault("ni", 128)
            fn = (lambda kw=kw: EP.ep_gemm1(x8, xs, P, sids, seids, nv, a, a_s, adt=args.adt,
                                            block_m=bm, **kw))
        else:
            kw.setdefault("no", 128)
            fn = (lambda kw=kw: EP.ep_gemm2(a, a_s, P, sids, sw, seids, nv, out, adt=args.adt,
                                            block_m=bm, **kw))
        fn()
        fns.append((v, fn))
    torch.cuda.synchronize()
    res = {v: [] for v, _ in fns}
    for _ in range(args.rounds):
        for v, fn in fns:
            res[v].append(C.time_cold(fn, iters=args.iters))
    for v, _ in fns:
        ts = res[v]
        print(f"{args.what} {args.adt} tok {args.t} {v:40s}: median {statistics.median(ts):7.1f} us"
              f"  (min {min(ts):7.1f} max {max(ts):7.1f})", flush=True)


if __name__ == "__main__":
    main()

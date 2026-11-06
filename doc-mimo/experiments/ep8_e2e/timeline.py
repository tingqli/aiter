"""Per-tile timeline of the EP8 gemm1/gemm2 (EP8_TL=1 build; cold caches): per WG
finish time, per XCD busy time, tile duration by row variant; plain m-major tile
order vs the prep's schedule (--sched 0 1).

    EP8_TL=1 python timeline.py g1 -t 4096 --adt fp8 \\
        --kw "dict(bm=128, ni=128, nw=8, arb=128, sch=3, tr=True, rowv=(32,64,128))" --sched 0 1
"""
import argparse
import ast
import os
import statistics
import sys
from collections import defaultdict

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
assert os.environ.get("EP8_TL") == "1", "run with EP8_TL=1"
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
import ep8_prep  # noqa: E402


def _lit(s):
    node = ast.parse(s.strip(), mode="eval").body
    return {kw.arg: ast.literal_eval(kw.value) for kw in node.keywords}


def analyze(name, tl, ntiles, valid, rowv):
    r = tl[: ntiles * 8].view(ntiles, 8).cpu().long()
    t0 = (r[:, 3] & 0xFFFFFFFF) | (r[:, 4] << 32)
    t1 = (r[:, 5] & 0xFFFFFFFF) | (r[:, 6] << 32)
    base = int(t0.min())
    t0, t1 = (t0 - base) / 100.0, (t1 - base) / 100.0  # us
    bx, xcc, mb = r[:, 0].tolist(), (r[:, 2] & 0xF).tolist(), r[:, 7].tolist()
    span = float(t1.max())
    dur = (t1 - t0).tolist()
    var = [min(v for v in rowv if v >= valid[m]) for m in mb]
    by_var = defaultdict(list)
    for d, v in zip(dur, var):
        by_var[v].append(d)
    fin = defaultdict(float)
    busy = defaultdict(float)
    for i in range(ntiles):
        fin[bx[i]] = max(fin[bx[i]], float(t1[i]))
        busy[xcc[i]] += dur[i]
    fins = sorted(fin.values())
    work = sum(dur)
    nwg = len(fin)
    print(f"[{name}] tiles {ntiles} WGs {nwg} span {span:7.1f} us | work/WG {work / nwg:7.1f} us"
          f" | WG finish p10 {fins[len(fins) // 10]:6.1f} p50 {statistics.median(fins):6.1f}"
          f" max {fins[-1]:6.1f}")
    print("   tile us by row variant: " + ", ".join(
        f"R{v}: n {len(d)} med {statistics.median(d):6.1f} min {min(d):6.1f} max {max(d):6.1f}"
        for v, d in sorted(by_var.items())))
    print("   XCD busy (us/CU): " + " ".join(f"{busy[x] / (nwg / 8):6.1f}" for x in sorted(busy)))
    first = sorted(range(ntiles), key=lambda i: float(t0[i]))[:3]
    print("   first starts (us):", [round(float(t0[i]), 1) for i in first],
          "last end:", round(span, 1))


def main():
    p = argparse.ArgumentParser()
    p.add_argument("what", choices=["g1", "g2"])
    p.add_argument("-t", type=int, default=4096)
    p.add_argument("--adt", default="fp8")
    p.add_argument("--kw", default="dict(bm=128, ni=128, nw=8, arb=128, sch=3, tr=True, "
                                   "rowv=(32,64,128))")
    p.add_argument("--sched", type=int, nargs="*", default=[0, 1])
    args = p.parse_args()
    kw = _lit(args.kw)
    bm = kw.pop("bm")
    rowv = kw.get("rowv", (bm,))
    fp8 = args.adt == "fp8"
    if not fp8:
        kw.pop("arb", None)
    W = C.make_weights()
    P = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
    x, tw, ti = C.make_routing(args.t)
    sids, sw, seids, nv, x8, xs, sched = ep8_prep.ep_prep(
        ti, tw, x, e0=C.RANK * C.E_LOCAL, block_m=bm, quant=fp8)
    if not fp8:
        x8, xs = x, None
    nb = int(nv[0]) // bm
    valid = ((sids[: nb * bm] & 0xFFFFFF) < args.t).view(nb, bm).sum(1).tolist()
    ss = seids.numel() * bm
    a = torch.zeros((ss, C.I), dtype=torch.uint8 if fp8 else torch.bfloat16, device="cuda")
    a_s = torch.zeros((ss, C.I // EP.QG1), dtype=torch.float32, device="cuda") if fp8 else None
    out = torch.zeros((args.t, C.H), dtype=torch.bfloat16, device="cuda")
    g1kw = dict(ni=128, rowv=rowv, nw=8, **({"arb": 128} if fp8 else {}))
    EP.ep_gemm1(x8, xs, P, sids, seids, nv, a, a_s, adt=args.adt, block_m=bm, **g1kw)
    torch.cuda.synchronize()
    print("setup gemm1 ok", flush=True)
    tl = EP.tl_buffer()
    for bo in args.sched:
        k = dict(kw, sched=sched if bo else None)
        if args.what == "g1":
            nt = nb * (C.I // k.get("ni", 128))
            fn = lambda: EP.ep_gemm1(x8, xs, P, sids, seids, nv, a, a_s, adt=args.adt,  # noqa
                                     block_m=bm, **k)
        else:
            nt = nb * (C.H // k.get("no", 128))
            fn = lambda: EP.ep_gemm2(a, a_s, P, sids, sw, seids, nv, out, adt=args.adt,  # noqa
                                     block_m=bm, **k)
        for rep in range(3):
            C.flush_cache()
            torch.cuda.synchronize()
            fn()
            torch.cuda.synchronize()
            analyze(f"{args.what} {args.adt} t{args.t} sched{bo} rep{rep}", tl, nt, valid, rowv)


if __name__ == "__main__":
    main()

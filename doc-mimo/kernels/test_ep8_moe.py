# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Correctness / quick perf of the EP8 kernels (doc-mimo/kernels/ep8_moe.py).

    python doc-mimo/kernels/test_ep8_moe.py g1 -t 16 256 --adt fp8 bf16
    python doc-mimo/kernels/test_ep8_moe.py g2 -t 16 256 --adt fp8 bf16 --bm 16 --no 128
"""
import argparse
import os
import sys

import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
import test_a8w4_gemm1 as G1  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402
from aiter.utility import fp4_utils  # noqa: E402

_W = {}


def weights():
    if "W" not in _W:
        _W["W"] = C.make_weights()
        W = _W["W"]
        _W["P"] = EP.prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"])
    return _W["W"], _W["P"]


def _dequant_w(q, s):
    n, kh = q.shape
    w = fp4_utils.mxfp4_to_f32(q).view(n, kh * 2 // 32, 32)
    return (w * fp4_utils.e8m0_to_f32(s).view(n, -1, 1)).view(n, kh * 2)


def ref_gemm1(xf, W, sids, seids, nv, bm, tokens):
    """fp32 SiLU(gate)*up per sorted row (exact mxfp4 W1); rows -> [sorted, I]."""
    n2 = W["w1q"].shape[1]
    inter = n2 // 2
    n = int(nv[0])
    tok = sids[:n].long() & 0xFFFFFF
    rexp = seids.long().repeat_interleave(bm)[:n]
    valid = tok < tokens
    out = torch.zeros((seids.numel() * bm, inter), dtype=torch.float32, device=xf.device)
    for e in rexp[valid].unique().tolist():
        rows = torch.nonzero(valid & (rexp == e)).squeeze(1)
        g, u = (xf[tok[rows]] @ _dequant_w(W["w1q"][e], W["w1s"][e]).t()).split(inter, dim=-1)
        out[rows] = torch.nn.functional.silu(g) * u
    mask = torch.zeros(out.shape[0], dtype=torch.bool, device=xf.device)
    mask[:n] = valid
    return out, mask


def ref_gemm2(af, W, sids, sw, seids, nv, bm, tokens):
    """fp32 out[token] = sum over its sorted rows of w * (a[row] @ W2[e]^T)."""
    n = int(nv[0])
    tok = sids[:n].long() & 0xFFFFFF
    rexp = seids.long().repeat_interleave(bm)[:n]
    valid = tok < tokens
    out = torch.zeros((tokens, W["w2q"].shape[1]), dtype=torch.float32, device=af.device)
    for e in rexp[valid].unique().tolist():
        rows = torch.nonzero(valid & (rexp == e)).squeeze(1)
        y = (af[rows] @ _dequant_w(W["w2q"][e], W["w2s"][e]).t()) * sw[rows].view(-1, 1)
        out.index_add_(0, tok[rows], y)
    return out


def run_g1(x, adt, P, sids, seids, nv, bm, ni, rowv, pf, bcm, nw=4, arb=256, kw=None):
    """-> (fn, out, outs, x8, xs): fn launches gemm1 into out (+ outs).
    ``kw``: extra ep_gemm1 options (acm, sch, st)."""
    kw = kw or {}
    sorted_size = seids.numel() * bm
    if adt == "fp8":
        x8, xs = quantize_rows(x)
        out = torch.zeros((sorted_size, C.I), dtype=torch.uint8, device="cuda")
        outs = torch.zeros((sorted_size, C.I // EP.QG1), dtype=torch.float32, device="cuda")
        fn = lambda: EP.ep_gemm1(x8, xs, P, sids, seids, nv, out, outs, adt=adt,  # noqa: E731
                                 block_m=bm, ni=ni, rowv=rowv, pf=pf, bcm=bcm, nw=nw,
                                 arb=arb, **kw)
        return fn, out, outs, x8, xs
    out = torch.zeros((sorted_size, C.I), dtype=torch.bfloat16, device="cuda")
    fn = lambda: EP.ep_gemm1(x, None, P, sids, seids, nv, out, None, adt=adt,  # noqa: E731
                             block_m=bm, ni=ni, rowv=rowv, pf=pf, bcm=bcm, nw=nw, **kw)
    return fn, out, None, None, None


def dequant_inter(out, outs, adt, ni=EP.QG1):
    if adt != "fp8":
        return out.float()
    n, inter = out.shape
    g = EP.QG1
    return (out.view(torch.float8_e4m3fnuz).float().view(n, inter // g, g)
            * outs.view(n, inter // g, 1)).view(n, inter)


def test_g1(tokens, adt, bm, ni, rowv, pf, bcm=2, nw=4, arb=256, check_old=True, kw=None):
    W, P = weights()
    x, tw, ti = C.make_routing(tokens)
    sids, sw, seids, nv, _ = C.ep_sort(ti, tw, bm, C.expert_mask())
    sorted_size = seids.numel() * bm
    I = C.I
    fn, out, outs, x8, xs = run_g1(x, adt, P, sids, seids, nv, bm, ni, rowv, pf, bcm, nw, arb,
                                   kw)
    fn()
    torch.cuda.synchronize()
    xf = x8.float() * xs.view(-1, 1) if adt == "fp8" else x.float()
    ref, mask = ref_gemm1(xf, W, sids, seids, nv, bm, tokens)
    got = dequant_inter(out, outs, adt, ni)
    cd = C.cos_diff(ref[mask], got[mask])
    us = C.time_cold(fn)
    r = C.roofline(tokens, ti)
    gb = r["n_act"] * C.W1_BYTES
    msg = (f"g1 {adt} tok {tokens:6d} bm{bm} ni{ni} nw{nw} a{arb} rowv{rowv} pf{pf} bcm{bcm}"
           f" {kw or ''}: cos {cd:.2e}"
           f" | {us:7.1f} us {gb / us / 1e6:5.2f} TB/s"
           f" {2.0 * r['rows'] * 2 * I * C.H / us / 1e6:6.0f} TF")
    if check_old and adt == "fp8" and ni == 128 and bm >= 32:
        # the TP kernel (q8s, tile_n 128, fd2) does the same math: expect bit-exact
        buf = torch.zeros(sorted_size * (I + (I // 128) * 4), dtype=torch.uint8, device="cuda")
        G1.a8w4_gemm1(x8, xs, P["w1"], P["w1_scale"], P["w1_exp"], sids, seids, nv, buf,
                      num_experts=C.E_LOCAL, tile_m=bm, epilog="q8s", inter_dim=I,
                      topk=C.TOPK, tile_n=128, b_cache_mod=1, xcd_swizzle=1, fast_dec=2)
        torch.cuda.synchronize()
        nd = sorted_size * I
        q_old = buf[:nd].view(sorted_size, I)
        s_old = buf[nd:].view(torch.float32).view(sorted_size, I // 128)
        rows = mask.nonzero().squeeze(1)
        msg += (f" | bitexact vs TP kernel: q {bool(torch.equal(q_old[rows], out[rows]))}"
                f" s {bool(torch.equal(s_old[rows], outs[rows]))}")
    print(msg, flush=True)
    return cd


def test_g2(tokens, adt, bm, no, rowv, pf, bcm=2, ni=128, nw=4, arb=256, kw=None):
    W, P = weights()
    x, tw, ti = C.make_routing(tokens)
    sids, sw, seids, nv, moe_buf = C.ep_sort(ti, tw, bm, C.expert_mask())
    g1, a, a_s, _, _ = run_g1(x, adt, P, sids, seids, nv, bm, ni, (bm,), 2, 2)
    g1()
    out = torch.zeros((tokens, C.H), dtype=torch.bfloat16, device="cuda")
    fn = lambda: EP.ep_gemm2(a, a_s, P, sids, sw, seids, nv, out, adt=adt,  # noqa: E731
                             block_m=bm, no=no, rowv=rowv, pf=pf, bcm=bcm, nw=nw, arb=arb,
                             **(kw or {}))
    fn()
    torch.cuda.synchronize()
    ref = ref_gemm2(dequant_inter(a, a_s, adt, ni), W, sids, sw, seids, nv, bm, tokens)
    cd = C.cos_diff(ref, out.float())
    us = C.time_cold(lambda: (out.zero_(), fn()))
    r = C.roofline(tokens, ti)
    gb = r["n_act"] * C.W2_BYTES
    print(f"g2 {adt} tok {tokens:6d} bm{bm} no{no} nw{nw} a{arb} rowv{rowv} pf{pf} bcm{bcm}"
          f" {kw or ''}: "
          f"cos {cd:.2e} | {us:7.1f} us {gb / us / 1e6:5.2f} TB/s"
          f" {2.0 * r['rows'] * C.I * C.H / us / 1e6:6.0f} TF", flush=True)
    return cd


def main():
    p = argparse.ArgumentParser()
    p.add_argument("what", choices=["g1", "g2"])
    p.add_argument("-t", type=int, nargs="*", default=[16, 256])
    p.add_argument("--adt", nargs="*", default=["fp8", "bf16"])
    p.add_argument("--bm", type=int, nargs="*", default=[16])
    p.add_argument("--ni", type=int, nargs="*", default=[128])
    p.add_argument("--no", type=int, nargs="*", default=[128])
    p.add_argument("--pf", type=int, nargs="*", default=[2])
    p.add_argument("--bcm", type=int, nargs="*", default=[2])
    p.add_argument("--nw", type=int, nargs="*", default=[4])
    p.add_argument("--arb", type=int, nargs="*", default=[256])
    p.add_argument("--rowv", type=str, default="", help="e.g. 16,32,64")
    p.add_argument("--acm", type=int, nargs="*", default=[2])
    p.add_argument("--sch", type=int, nargs="*", default=[1])
    p.add_argument("--st", type=int, nargs="*", default=[-1], help="ST_STEP (-1: default)")
    p.add_argument("--prio", type=int, nargs="*", default=[0])
    p.add_argument("--tr", type=int, nargs="*", default=[0])
    args = p.parse_args()
    kws = [dict(acm=a, sch=s, **({} if st < 0 else dict(st=st)), **({} if not pr else dict(prio=pr)),
                **({} if not tr else dict(tr=True)))
           for a in args.acm for s in args.sch for st in args.st for pr in args.prio
           for tr in args.tr]
    for t in args.t:
        for adt in args.adt:
            for bm in args.bm:
                rowv = tuple(int(v) for v in args.rowv.split(",")) if args.rowv else (bm,)
                for pf, bcm, kw in [(a, b, c) for a in args.pf for b in args.bcm for c in kws]:
                    if args.what == "g1":
                        for ni in args.ni:
                            for nw in args.nw:
                                for arb in args.arb:
                                    test_g1(t, adt, bm, ni, rowv, pf, bcm, nw, arb, kw=kw)
                    else:
                        for no in args.no:
                            for nw in args.nw:
                                for arb in args.arb:
                                    test_g2(t, adt, bm, no, rowv, pf, bcm, args.ni[0], nw,
                                            arb, kw=kw)


if __name__ == "__main__":
    main()

"""2-kernel vs 1-kernel A8W4 MoE, each at its best compile-time configuration.

    python doc-mimo/experiments/moe_2k_vs_1k/bench.py --inter 256 512 [-t 128 256 ...]

Shape model_dim 4096, E 256, topk 8, inter_dim 256 / 512, uniform random routing.
Per token count every candidate is timed (torch profiler, sum of all kernels of the
call incl. moe_sorting and the x row-quant; median of --reps) and checked against
the first 2-kernel candidate (cos < 1e-4).

2-kernel (sort -> quant -> gemm1 q8s -> gemm2 atomic; test_flydsl_moe_a16wfp4 path):
  block_m 32 / 64:  gemm1 b_cache_mod 1 / 2  x  gemm2 {"base" (lds epilogue),
                    "nt4" (n_tiles 4, direct64, row data in VGPRs; one K tile)}
  block_m 128 (inter 256): gemm1 bcm 1 / 2 + test_a8w4_gemm2_bm128 (nt 8)
1-kernel:
  bm64  (test_a8w4_fmoe_bm64):  b_cache_mod 1 / 2, waves_per_eu 2 (inter 512: 1 / 2)
  bm64q (test_a8w4_fmoe_bm64q, inter 256): b_cache_mod 1 / 2
"""
import argparse
import json
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import test_a8w4_fmoe_bm64 as F  # noqa: E402
import test_a8w4_fmoe_bm64q as Q  # noqa: E402
import test_a8w4_gemm1 as G1  # noqa: E402
import test_a8w4_gemm2 as G2  # noqa: E402
import test_a8w4_gemm2_bm128 as B  # noqa: E402
import test_flydsl_moe_a16wfp4 as M  # noqa: E402

from aiter import QuantType, dtypes, get_torch_quant  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

E, MD, TOPK = 256, 4096, 8


def make_weights(inter):
    torch.manual_seed(0)
    w1 = torch.randn((E, inter * 2, MD), dtype=dtypes.bf16, device="cuda")
    w2 = torch.randn((E, MD, inter), dtype=dtypes.bf16, device="cuda")
    tq = get_torch_quant(QuantType.per_1x32)
    w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
    w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
    del w1, w2
    return M.a8w4_prepare_weights(
        shuffle_weight_a16w4(w1q.view(E, inter * 2, MD // 2), 16, False),
        shuffle_weight_a16w4(w2q.view(E, MD, inter // 2), 16, False),
        shuffle_scale_a16w4(w1s, E, False), shuffle_scale_a16w4(w2s, E, False), fast_dec=2)


def two_kernel(x, W, tw, ti, *, bm, g1_bcm, g2):
    inter = W["w1"].shape[1] // 2
    groups = inter // 128
    sids, sw, seids, nv, out = moe_sorting(ti, tw, E, MD, dtypes.bf16, bm)[:5]
    x8, xs = quantize_rows(x)
    sorted_size = seids.numel() * bm
    buf = torch.empty(sorted_size * (inter + groups * 4), dtype=torch.uint8, device=x.device)
    G1.a8w4_gemm1(x8, xs, W["w1"], W["w1_scale"], W["w1_exp"], sids, seids, nv, buf,
                  num_experts=E, tile_m=bm, epilog="q8s", inter_dim=inter, topk=TOPK,
                  tile_n=128, b_cache_mod=g1_bcm, xcd_swizzle=1, dyn_m=bm > 32, fast_dec=2)
    nd = sorted_size * inter
    a2 = buf[:nd].view(torch.float8_e4m3fnuz).view(sorted_size, inter)
    a2s = buf[nd:].view(torch.float32).view(sorted_size, groups)
    if bm == 128:
        B.a8w4_gemm2_bm128(a2, a2s, W["w2"], W["w2_scale"], sids, sw, seids, nv, out,
                           num_experts=E, n_tiles=8, topk=TOPK)
    else:
        kw = dict(tile_n=128, b_cache_mod=2, xcd_swizzle=0, dyn_rows=True)
        if g2 == "nt4":
            kw.update(n_tiles=4, epilog="direct64", row_vgpr=True, tile_k=inter)
        G2.a8w4_gemm2(a2, a2s, W["w2"], W["w2_scale"], sids, sw, seids, nv, out,
                      num_experts=E, tile_m=bm, a_group=128, fast_dec=2, **kw)
    return out


def candidates(inter):
    two = []
    for bm in (32, 64):
        for bcm in (1, 2):
            for g2 in (("base", "nt4") if inter == 256 else ("base",)):  # nt4: one K tile
                two.append((f"bm{bm} g1bcm{bcm} g2{g2}", dict(bm=bm, g1_bcm=bcm, g2=g2)))
    if inter == 256:
        for bcm in (1, 2):
            two.append((f"bm128 g1bcm{bcm} g2bm128", dict(bm=128, g1_bcm=bcm, g2="bm128")))
    one = []
    for bcm in (1, 2):
        for wpe in ((2,) if inter == 256 else (1, 2)):
            one.append((f"bm64 bcm{bcm} w{wpe}",
                        lambda x, W, tw, ti, bcm=bcm, wpe=wpe: F.fused_moe_a8w4_bm64(
                            x, W, tw, ti, b_cache_mod=bcm, waves_per_eu=wpe)))
        # ksplit: an expert block's inter columns split over ks CTAs (gemm2 split-K)
        for ks in [k for k in (2, 4) if k <= inter // 128]:
            one.append((f"bm64 bcm{bcm} w2 ks{ks}",
                        lambda x, W, tw, ti, bcm=bcm, ks=ks: F.fused_moe_a8w4_bm64(
                            x, W, tw, ti, b_cache_mod=bcm, waves_per_eu=2, ksplit=ks)))
        if inter == 256:
            one.append((f"bm64q bcm{bcm}",
                        lambda x, W, tw, ti, bcm=bcm: Q.fused_moe_a8w4_bm64q(
                            x, W, tw, ti, b_cache_mod=bcm)))
    return two, one


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--inter", type=int, nargs="*", default=[256, 512])
    p.add_argument("-t", type=int, nargs="*", default=[128 << i for i in range(9)])
    p.add_argument("--reps", type=int, default=3)
    p.add_argument("--out", default=os.path.join(HERE, "results"))
    args = p.parse_args()
    os.makedirs(args.out, exist_ok=True)

    def timed(fn):
        runs = sorted((F._profile(fn) for _ in range(args.reps)), key=lambda r: r["total"])
        return runs[len(runs) // 2]

    for inter in args.inter:
        W = make_weights(inter)
        two, one = candidates(inter)
        rows = []
        for tok in args.t:
            torch.manual_seed(tok)
            x = torch.randn((tok, MD), dtype=dtypes.bf16, device="cuda")
            tw, ti = fused_topk(x, torch.randn((tok, E), dtype=dtypes.bf16, device="cuda"),
                                TOPK, True)
            ref = None
            res = {"tokens": tok, "inter": inter, "two": {}, "one": {}}
            for kind, cands in (("two", [(n, lambda x, W, tw, ti, kw=kw: two_kernel(
                    x, W, tw, ti, **kw)) for n, kw in two]), ("one", one)):
                for name, f in cands:
                    fn = lambda f=f: f(x, W, tw, ti)  # noqa: E731
                    try:
                        o = fn().float().clone()
                        if ref is None:
                            ref = o
                        c = G1._cos_diff(ref, o)
                        t = timed(fn)
                        res[kind][name] = {"total": t["total"], "cos": c,
                                           "stages": {k: v for k, v in t.items() if k != "total"}}
                    except Exception as ex:  # noqa: BLE001
                        res[kind][name] = {"error": f"{type(ex).__name__}: {str(ex)[:200]}"}
            ok = {k: {n: v for n, v in res[k].items() if "total" in v and v["cos"] < 1e-4}
                  for k in ("two", "one")}
            b2 = min(ok["two"].items(), key=lambda kv: kv[1]["total"])
            b1 = min(ok["one"].items(), key=lambda kv: kv[1]["total"])
            res["best_two"], res["best_one"] = b2[0], b1[0]
            bad = [f"{k}:{n}" for k in ("two", "one") for n, v in res[k].items()
                   if "error" in v or v["cos"] >= 1e-4]
            print(f"inter {inter} tok {tok:6d}: 2-kernel {b2[1]['total']:8.1f} us [{b2[0]}] | "
                  f"1-kernel {b1[1]['total']:8.1f} us [{b1[0]}] | "
                  f"{b2[1]['total'] / b1[1]['total']:.2f}x"
                  f"{'  bad/failed: ' + ', '.join(bad) if bad else ''}", flush=True)
            print("      " + "  ".join(f"{n}={v['total']:.0f}" for k in ("two", "one")
                                       for n, v in res[k].items() if "total" in v), flush=True)
            rows.append(res)
        with open(os.path.join(args.out, f"i{inter}.json"), "w") as fh:
            json.dump(rows, fh, indent=1)
        del W
        torch.cuda.empty_cache()


if __name__ == "__main__":
    main()

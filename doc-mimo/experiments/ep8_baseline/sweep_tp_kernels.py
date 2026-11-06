"""EP8 shape: sweep the TP-tuned standalone gemm1 / gemm2 tile configs (cold
caches) to see how far the existing kernels get on 32 experts x inter 2048.

    python doc-mimo/experiments/ep8_baseline/sweep_tp_kernels.py -t 16 256 1024 4096
"""
import argparse
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
import ep8_common as C  # noqa: E402
import test_a8w4_gemm1 as G1  # noqa: E402
import test_a8w4_gemm2 as G2  # noqa: E402
import test_flydsl_moe_a16wfp4 as MM  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="*", default=[16, 256, 1024, 4096])
    args = p.parse_args()
    W = C.make_weights()
    Wp = MM.a8w4_prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"], fast_dec=2)
    mask = C.expert_mask()
    inter, groups = C.I, C.I // 128
    for tok in args.t:
        x, tw, ti = C.make_routing(tok)
        r = C.roofline(tok, ti)
        print(f"tokens {tok:6d}: {C.fmt_roof(r)}", flush=True)
        b1 = r["n_act"] * C.W1_BYTES
        b2 = r["n_act"] * C.W2_BYTES
        f1 = 2.0 * r["rows"] * 2 * C.I * C.H
        f2 = 2.0 * r["rows"] * C.I * C.H
        x8, xs = quantize_rows(x)
        for bm in (16, 32, 64):
            sids, sw, seids, nv, out = C.ep_sort(ti, tw, bm, mask)
            sorted_size = seids.numel() * bm
            buf = torch.zeros(sorted_size * (inter + groups * 4), dtype=torch.uint8,
                              device="cuda")
            inter_bf16 = torch.zeros((sorted_size, inter), dtype=torch.bfloat16, device="cuda")
            res1 = []
            for tn in (64, 128):
                for bcm in (1, 2):
                    for dyn in ((False, True) if bm >= 64 else (False,)):
                        # q8s needs tile_n 128 and BM % 32 == 0; else time the bf16 epilogue
                        q8 = tn == 128 and bm >= 32
                        fn = lambda tn=tn, bcm=bcm, dyn=dyn, q8=q8: G1.a8w4_gemm1(  # noqa: E731
                            x8, xs, Wp["w1"], Wp["w1_scale"], Wp["w1_exp"], sids, seids, nv,
                            buf if q8 else inter_bf16, num_experts=C.E_LOCAL, tile_m=bm,
                            epilog="q8s" if q8 else "bf16", inter_dim=inter, topk=C.TOPK,
                            tile_n=tn, b_cache_mod=bcm, xcd_swizzle=1, dyn_m=dyn, fast_dec=2)
                        try:
                            us = C.time_cold(fn)
                            res1.append((us, f"tn{tn} bcm{bcm}{' dyn' if dyn else ''}"
                                             f"{'' if q8 else ' bf16'}"))
                        except Exception as ex:  # noqa: BLE001
                            res1.append((float("inf"), f"tn{tn} FAIL {str(ex)[:80]}"))
            # gemm1 output for gemm2
            ag = 128 if bm >= 32 else 0
            if ag:
                G1.a8w4_gemm1(x8, xs, Wp["w1"], Wp["w1_scale"], Wp["w1_exp"], sids, seids, nv,
                              buf, num_experts=C.E_LOCAL, tile_m=bm, epilog="q8s",
                              inter_dim=inter, topk=C.TOPK, tile_n=128, b_cache_mod=1,
                              xcd_swizzle=1, dyn_m=bm > 32, fast_dec=2)
                nd = sorted_size * inter
                a2 = buf[:nd].view(torch.float8_e4m3fnuz).view(sorted_size, inter)
                a2s = buf[nd:].view(torch.float32).view(sorted_size, groups)
            else:
                a2, a2s = quantize_rows(inter_bf16)
            res2 = []
            for tn in (64, 128, 256):
                for bcm in (0, 2):
                    fn = lambda tn=tn, bcm=bcm: G2.a8w4_gemm2(  # noqa: E731
                        a2, a2s, Wp["w2"], Wp["w2_scale"], sids, sw, seids, nv, out,
                        num_experts=C.E_LOCAL, tile_m=bm, a_group=ag, fast_dec=2,
                        tile_n=tn, b_cache_mod=bcm, xcd_swizzle=0, dyn_rows=True)
                    try:
                        us = C.time_cold(fn)
                        res2.append((us, f"tn{tn} bcm{bcm}"))
                    except Exception as ex:  # noqa: BLE001
                        res2.append((float("inf"), f"tn{tn} FAIL {str(ex)[:80]}"))
            res1.sort()
            res2.sort()
            u1, n1 = res1[0]
            u2, n2 = res2[0]
            print(f"   bm{bm:3d} gemm1 best {n1:16s} {u1:7.1f} us {b1 / u1 / 1e6:5.2f} TB/s "
                  f"{f1 / u1 / 1e6:6.0f} TF | gemm2 best {n2:10s} {u2:7.1f} us "
                  f"{b2 / u2 / 1e6:5.2f} TB/s {f2 / u2 / 1e6:6.0f} TF", flush=True)
            print("        g1: " + "  ".join(f"{n} {u:.1f}" for u, n in res1), flush=True)
            print("        g2: " + "  ".join(f"{n} {u:.1f}" for u, n in res2), flush=True)


if __name__ == "__main__":
    main()

"""EP8 baseline: the TP-tuned kernels on the EP8 per-rank shape (32 local experts,
inter 2048), cold caches, vs the rooflines of ep8_common.

  a8w4  : doc-mimo 2-kernel (sort -> x quant -> gemm1 q8s fd2 -> gemm2 a_group 128)
  a16w4 : aiter fused_moe (production FlyDSL a16w4 path) with expert_mask

    python doc-mimo/experiments/ep8_baseline/bench_baseline.py [-t 1 16 256 ...]
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
from aiter import ActivationType, QuantType  # noqa: E402
from aiter.fused_moe import fused_moe  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402
from aiter.ops.flydsl.moe_common import GateMode  # noqa: E402


def a8w4_2k(x, Wp, tw, ti, mask, bm, g1_bcm=1):
    inter = Wp["w1"].shape[1] // 2
    groups = inter // 128
    sids, sw, seids, nv, out = C.ep_sort(ti, tw, bm, mask)
    x8, xs = quantize_rows(x)
    sorted_size = seids.numel() * bm
    buf = torch.empty(sorted_size * (inter + groups * 4), dtype=torch.uint8, device=x.device)
    G1.a8w4_gemm1(x8, xs, Wp["w1"], Wp["w1_scale"], Wp["w1_exp"], sids, seids, nv, buf,
                  num_experts=C.E_LOCAL, tile_m=bm, epilog="q8s", inter_dim=inter, topk=C.TOPK,
                  tile_n=128, b_cache_mod=g1_bcm, xcd_swizzle=1, dyn_m=bm > 32, fast_dec=2)
    nd = sorted_size * inter
    a2 = buf[:nd].view(torch.float8_e4m3fnuz).view(sorted_size, inter)
    a2s = buf[nd:].view(torch.float32).view(sorted_size, groups)
    G2.a8w4_gemm2(a2, a2s, Wp["w2"], Wp["w2_scale"], sids, sw, seids, nv, out,
                  num_experts=C.E_LOCAL, tile_m=bm, a_group=128, fast_dec=2, tile_n=128,
                  b_cache_mod=2, xcd_swizzle=0, dyn_rows=True)
    return out


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="*",
                   default=[1, 4, 16, 64, 256, 1024, 2048, 4096, 8192, 16384])
    p.add_argument("--skip", nargs="*", default=[])
    args = p.parse_args()

    W = C.make_weights()
    Wp = MM.a8w4_prepare_weights(W["w1"], W["w2"], W["w1_scale"], W["w2_scale"], fast_dec=2)
    mask = C.expert_mask()
    for tok in args.t:
        x, tw, ti = C.make_routing(tok)
        r = C.roofline(tok, ti)
        print(f"tokens {tok:6d}: {C.fmt_roof(r)}", flush=True)
        ref8 = ref16 = None
        if "a8w4" not in args.skip:
            for bm in (32, 64):
                fn = lambda bm=bm: a8w4_2k(x, Wp, tw, ti, mask, bm)  # noqa: E731
                try:
                    o = fn().float()
                    if ref8 is None:
                        ref8 = C.ref_moe(x, tw, ti, W, a8w4=True)
                    cd = C.cos_diff(ref8, o)
                    us = C.time_cold(fn)
                    prof = C.profile_cold(fn, C.default_stage)
                    br = " ".join(f"{k} {v:.1f}" for k, v in prof.items() if k != "total")
                    print(f"   a8w4 2k bm{bm:3d}: {us:8.1f} us  x{us / r['mem']:.2f} mem "
                          f"x{us / max(r['fp8'], 1e-9):.2f} fp8 x{us / (r['mem'] + r['fp8']):.2f} "
                          f"sum | cos {cd:.1e} | {br}", flush=True)
                except Exception as ex:  # noqa: BLE001
                    print(f"   a8w4 2k bm{bm}: FAIL {type(ex).__name__}: {str(ex)[:200]}")
        if "a16w4" not in args.skip:
            fn = lambda: fused_moe(  # noqa: E731
                x, W["w1"], W["w2"], tw, ti, expert_mask=mask, w1_scale=W["w1_scale"],
                w2_scale=W["w2_scale"], quant_type=QuantType.per_1x32,
                activation=ActivationType.Silu, doweight_stage1=False,
                gate_mode=GateMode.SEPARATED.value)
            try:
                o = fn().float()
                ref16 = C.ref_moe(x, tw, ti, W, a8w4=False)
                cd = C.cos_diff(ref16, o)
                us = C.time_cold(fn)
                prof = C.profile_cold(fn, C.default_stage)
                br = " ".join(f"{k} {v:.1f}" for k, v in prof.items() if k != "total")
                print(f"   a16w4 fused_moe : {us:8.1f} us  x{us / r['mem']:.2f} mem "
                      f"x{us / max(r['bf16'], 1e-9):.2f} bf16 x{us / (r['mem'] + r['bf16']):.2f} "
                      f"sum | cos {cd:.1e} | {br}", flush=True)
            except Exception as ex:  # noqa: BLE001
                print(f"   a16w4 fused_moe: FAIL {type(ex).__name__}: {str(ex)[:300]}")


if __name__ == "__main__":
    main()

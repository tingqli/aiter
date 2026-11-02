# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""A8W4 MoE tuner + ``tuned_moe`` dispatcher (gfx942, FlyDSL kernels in this dir).

Every candidate consumes the SAME weights: ``prepare_weights`` = fd2
(``a8w4_prepare_weights(..., fast_dec=2)``: fast-decode W1/W2 + scale deltas +
per-channel exponent codes), so a tuned table can switch kernels per batch size
without re-preparing weights.

Candidates (``candidates(model_dim, inter_dim)``, pruned to knobs that ever won):
  2k  sort -> x row-quant -> gemm1 (q8s epilogue) -> gemm2 (atomic scatter)
      block_m 32 / 64  x  gemm1 b_cache_mod 1 / 2  x  gemm2 "base" | "nt4"
      (nt4 = n_tiles 4 + direct64 + row data in VGPRs; inter 256 only)
  1k  fused single kernel (test_a8w4_fmoe_bm64): bcm 1 / 2  x  ksplit 1 | inter/256
      (waves_per_eu 2 when a CTA keeps <= 256 inter columns, else 1);
      persistent work-queue test_a8w4_fmoe_bm64q bcm 1 (inter 256)
  -> 11 candidates for inter 256, 8 for inter 512.

Tune (num_tokens 1, 2, 4, ... 32768; best per point -> CSV, rows of other shapes /
routings in the CSV are kept):
    python doc-mimo/kernels/a8w4_moe_tune.py tune --shape 4096,256,256,8 \
        --csv doc-mimo/kernels/configs/a8w4_moe_tuned.csv [--routing uniform]
Verify (tuned_moe vs the CSV time, vs the default 2-kernel, correctness):
    python doc-mimo/kernels/a8w4_moe_tune.py verify --shape 4096,256,256,8 \
        --csv doc-mimo/kernels/configs/a8w4_moe_tuned.csv

Runtime:
    W = prepare_weights(w1_shuffled, w2_shuffled, w1_scale_shuffled, w2_scale_shuffled)
    out = tuned_moe(x, W, topk_weights, topk_ids, csv_path=...)   # bf16 [tokens, H]
num_tokens is rounded up to 2^N (clamped to the table's range) and the fastest
row of (model_dim, inter_dim, E, topk, routing) is run.
"""

import argparse
import csv
import functools
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
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

DEFAULT_CSV = os.path.join(HERE, "configs", "a8w4_moe_tuned.csv")
ROUTINGS = ("uniform", "hot")
FIELDS = ["model_dim", "inter_dim", "experts", "topk", "routing", "num_tokens",
          "kind", "block_m", "g1_bcm", "g2", "bcm", "wpe", "ksplit", "us",
          "best_2k", "best_2k_us", "best_1k", "best_1k_us"]


# =============================================================================
# weights (shared by every candidate) and routing
# =============================================================================


def prepare_weights(w1, w2, w1_scale, w2_scale):
    """Standard-preshuffled mxfp4 W1 [E, 2I, H/2] / W2 [E, H, I/2] + e8m0 scales
    (``shuffle_weight_a16w4`` / ``shuffle_scale_a16w4``) -> the fd2 weight dict that
    every candidate (2-kernel and fused) uses."""
    return M.a8w4_prepare_weights(w1, w2, w1_scale, w2_scale, fast_dec=2)


def random_weights(model_dim, inter_dim, experts, seed=0):
    torch.manual_seed(seed)
    w1 = torch.randn((experts, inter_dim * 2, model_dim), dtype=dtypes.bf16, device="cuda")
    w2 = torch.randn((experts, model_dim, inter_dim), dtype=dtypes.bf16, device="cuda")
    tq = get_torch_quant(QuantType.per_1x32)
    w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
    w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
    del w1, w2
    return prepare_weights(
        shuffle_weight_a16w4(w1q.view(experts, inter_dim * 2, model_dim // 2), 16, False),
        shuffle_weight_a16w4(w2q.view(experts, model_dim, inter_dim // 2), 16, False),
        shuffle_scale_a16w4(w1s, experts, False), shuffle_scale_a16w4(w2s, experts, False))


def make_routing(x, experts, topk, routing="uniform"):
    """uniform: random scores; hot: 1/32 of the experts get a +2 score bias
    (as test_a8w4_gemm1 ``hot``)."""
    score = torch.randn((x.shape[0], experts), dtype=dtypes.bf16, device=x.device)
    if routing == "hot":
        hot = torch.randperm(experts, device=x.device)[: max(1, experts // G1.HOT_EXPERT_DIV)]
        score[:, hot] += G1.HOT_EXPERT_BIAS
    else:
        assert routing == "uniform", f"unknown routing {routing!r}"
    return fused_topk(x, score, topk, True)


# =============================================================================
# candidates
# =============================================================================


def config_name(cfg):
    if cfg["kind"] == "2k":
        return f"2k bm{cfg['block_m']} g1bcm{cfg['g1_bcm']} g2{cfg['g2']}"
    if cfg["kind"] == "1k":
        return f"1k bm64 bcm{cfg['bcm']} w{cfg['wpe']} ks{cfg['ksplit']}"
    return f"1kq bm64q bcm{cfg['bcm']}"


def candidates(model_dim, inter_dim):
    """Pruned to the knobs that won somewhere in doc-mimo/experiments/moe_2k_vs_1k and
    the first full tune (4096/256 and 4096/512, 1..32768 tokens):
      2k: block_m 32 / 64 and gemm1 bcm 1 / 2 all win somewhere; gemm2 nt4 vs base
          both win (inter 256; nt4 needs one K tile). block_m 128 + gemm2_bm128
          never won -> dropped.
      1k: ksplit only 1 or the split that leaves 256 inter columns per CTA (the A2
          fragments then fit 2 CTAs/CU); ksplit 4 never won. waves_per_eu follows
          the per-CTA columns (2 for <= 256, else 1: 2 spills badly). bcm 1 / 2
          both win (2 for small batches). bm64q only for inter 256, bcm 1."""
    out = []
    for bm in (32, 64):
        for g1_bcm in (1, 2):
            for g2 in (("base", "nt4") if inter_dim <= 256 else ("base",)):
                out.append(dict(kind="2k", block_m=bm, g1_bcm=g1_bcm, g2=g2))
    splits = sorted({1, max(1, inter_dim // 256)})
    for bcm in (1, 2):
        for ks in splits:
            wpe = 2 if inter_dim // ks <= 256 else 1
            out.append(dict(kind="1k", block_m=64, bcm=bcm, wpe=wpe, ksplit=ks))
    if inter_dim == 256:
        out.append(dict(kind="1kq", block_m=64, bcm=1))
    return out


def run_config(cfg, x, W, topk_weights, topk_ids):
    """Run one candidate end to end (moe_sorting + x quant + kernels)."""
    E, model_dim, _ = W["w2"].shape
    topk = topk_ids.shape[1]
    if cfg["kind"] == "1k":
        return F.fused_moe_a8w4_bm64(x, W, topk_weights, topk_ids, b_cache_mod=cfg["bcm"],
                                     waves_per_eu=cfg["wpe"], ksplit=cfg["ksplit"])
    if cfg["kind"] == "1kq":
        return Q.fused_moe_a8w4_bm64q(x, W, topk_weights, topk_ids, b_cache_mod=cfg["bcm"])
    assert cfg["kind"] == "2k", cfg
    bm = cfg["block_m"]
    inter = W["w1"].shape[1] // 2
    groups = inter // 128
    sids, sw, seids, nv, out = moe_sorting(topk_ids, topk_weights, E, model_dim,
                                           dtypes.bf16, bm)[:5]
    x8, xs = quantize_rows(x)
    sorted_size = seids.numel() * bm
    buf = torch.empty(sorted_size * (inter + groups * 4), dtype=torch.uint8, device=x.device)
    G1.a8w4_gemm1(x8, xs, W["w1"], W["w1_scale"], W["w1_exp"], sids, seids, nv, buf,
                  num_experts=E, tile_m=bm, epilog="q8s", inter_dim=inter, topk=topk,
                  tile_n=128, b_cache_mod=cfg["g1_bcm"], xcd_swizzle=1, dyn_m=bm > 32,
                  fast_dec=2)
    nd = sorted_size * inter
    a2 = buf[:nd].view(torch.float8_e4m3fnuz).view(sorted_size, inter)
    a2s = buf[nd:].view(torch.float32).view(sorted_size, groups)
    if cfg["g2"] == "bm128":
        B.a8w4_gemm2_bm128(a2, a2s, W["w2"], W["w2_scale"], sids, sw, seids, nv, out,
                           num_experts=E, n_tiles=8, topk=topk)
    else:
        kw = dict(tile_n=128, b_cache_mod=2, xcd_swizzle=0, dyn_rows=True)
        if cfg["g2"] == "nt4":
            kw.update(n_tiles=4, epilog="direct64", row_vgpr=True)
        G2.a8w4_gemm2(a2, a2s, W["w2"], W["w2_scale"], sids, sw, seids, nv, out,
                      num_experts=E, tile_m=bm, a_group=128, fast_dec=2, **kw)
    return out


DEFAULT_CFG = dict(kind="2k", block_m=64, g1_bcm=1, g2="base")  # no table / no row


# =============================================================================
# tuned_moe: CSV lookup -> kernel
# =============================================================================


def _row_to_cfg(r):
    kind = r["kind"]
    if kind == "2k":
        return dict(kind=kind, block_m=int(r["block_m"]), g1_bcm=int(r["g1_bcm"]), g2=r["g2"])
    if kind == "1k":
        return dict(kind=kind, block_m=64, bcm=int(r["bcm"]), wpe=int(r["wpe"]),
                    ksplit=int(r["ksplit"]))
    return dict(kind=kind, block_m=64, bcm=int(r["bcm"]))


@functools.lru_cache(maxsize=8)
def _load_table(path, mtime):
    """{(H, I, E, topk, routing): sorted [(num_tokens, cfg)]}"""
    del mtime  # cache key only (reload when the file changes)
    table = {}
    with open(path) as fh:
        for r in csv.DictReader(fh):
            key = (int(r["model_dim"]), int(r["inter_dim"]), int(r["experts"]),
                   int(r["topk"]), r["routing"])
            table.setdefault(key, []).append((int(r["num_tokens"]), _row_to_cfg(r)))
    return {k: sorted(v, key=lambda t: t[0]) for k, v in table.items()}


def lookup_config(num_tokens, model_dim, inter_dim, experts, topk, routing="uniform",
                  csv_path=DEFAULT_CSV):
    """Tuned config for num_tokens rounded up to 2^N (clamped to the table range);
    DEFAULT_CFG if the CSV or the shape is missing."""
    if not csv_path or not os.path.exists(csv_path):
        return DEFAULT_CFG
    rows = _load_table(csv_path, os.path.getmtime(csv_path)).get(
        (model_dim, inter_dim, experts, topk, routing))
    if not rows:
        return DEFAULT_CFG
    t = 1 << max(0, (int(num_tokens) - 1).bit_length())
    for n, cfg in rows:
        if n >= t:
            return cfg
    return rows[-1][1]


def tuned_moe(x, weights, topk_weights, topk_ids, *, csv_path=DEFAULT_CSV, routing="uniform"):
    """A8W4 MoE (bf16 x [tokens, H] -> bf16 [tokens, H]) with the tuned kernel for
    this batch size. ``weights`` from ``prepare_weights`` (fd2)."""
    E, model_dim, _ = weights["w2"].shape
    cfg = lookup_config(x.shape[0], model_dim, weights["w1"].shape[1] // 2, E,
                        topk_ids.shape[1], routing, csv_path)
    return run_config(cfg, x, weights, topk_weights, topk_ids)


# =============================================================================
# tuner
# =============================================================================


def _timed(fn, reps):
    runs = sorted((F._profile(fn) for _ in range(reps)), key=lambda r: r["total"])
    return runs[len(runs) // 2]["total"]


def tune(model_dim, inter_dim, experts, topk, routing, tokens, csv_path, reps=3, log=print):
    W = random_weights(model_dim, inter_dim, experts)
    cands = candidates(model_dim, inter_dim)
    rows = []
    for tok in tokens:
        torch.manual_seed(1000 + tok)
        x = torch.randn((tok, model_dim), dtype=dtypes.bf16, device="cuda")
        tw, ti = make_routing(x, experts, topk, routing)
        ref, res = None, []
        for cfg in cands:
            fn = lambda cfg=cfg: run_config(cfg, x, W, tw, ti)  # noqa: E731
            try:
                o = fn().float().clone()
                if ref is None:
                    ref = o
                c = G1._cos_diff(ref, o)
                if not c < 1e-4:
                    log(f"   {config_name(cfg)}: BAD cos {c:.2e} (skipped)")
                    continue
                res.append((_timed(fn, reps), cfg))
            except Exception as ex:  # noqa: BLE001
                log(f"   {config_name(cfg)}: FAIL {type(ex).__name__}: {str(ex)[:160]}")
        res.sort(key=lambda t: t[0])
        us, best = res[0]
        nan = (float("nan"), None)
        b2 = min((r for r in res if r[1]["kind"] == "2k"), key=lambda t: t[0], default=nan)
        b1 = min((r for r in res if r[1]["kind"] != "2k"), key=lambda t: t[0], default=nan)
        name = lambda c: config_name(c) if c else ""  # noqa: E731
        row = dict(model_dim=model_dim, inter_dim=inter_dim, experts=experts, topk=topk,
                   routing=routing, num_tokens=tok, kind=best["kind"],
                   block_m=best.get("block_m", ""), g1_bcm=best.get("g1_bcm", ""),
                   g2=best.get("g2", ""), bcm=best.get("bcm", ""), wpe=best.get("wpe", ""),
                   ksplit=best.get("ksplit", ""), us=f"{us:.1f}",
                   best_2k=name(b2[1]), best_2k_us=f"{b2[0]:.1f}",
                   best_1k=name(b1[1]), best_1k_us=f"{b1[0]:.1f}")
        rows.append(row)
        log(f"tok {tok:6d}: best {config_name(best):28s} {us:8.1f} us | 2k {b2[0]:8.1f} "
            f"({name(b2[1])}) | 1k {b1[0]:8.1f} ({name(b1[1])})  "
            f"[{len(res)}/{len(cands)} ok]")
        _write_rows(csv_path, rows)  # incremental: keep partial results
        del x
    return rows


def _write_rows(csv_path, new_rows):
    """Merge new_rows into csv_path, replacing rows with the same case key."""
    def key(r):
        return tuple(str(r[k]) for k in ("model_dim", "inter_dim", "experts", "topk",
                                         "routing", "num_tokens"))
    old = []
    if os.path.exists(csv_path):
        with open(csv_path) as fh:
            old = list(csv.DictReader(fh))
    keys = {key(r) for r in new_rows}
    merged = [r for r in old if key(r) not in keys] + list(new_rows)
    merged.sort(key=lambda r: (int(r["model_dim"]), int(r["inter_dim"]), int(r["experts"]),
                               int(r["topk"]), r["routing"], int(r["num_tokens"])))
    os.makedirs(os.path.dirname(os.path.abspath(csv_path)), exist_ok=True)
    with open(csv_path, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=FIELDS)
        w.writeheader()
        w.writerows(merged)


def verify(model_dim, inter_dim, experts, topk, routing, tokens, csv_path, reps=3, log=print):
    """tuned_moe at each point (and at non-power-of-2 counts): time vs the CSV entry
    and vs the default 2-kernel config; output vs the default config."""
    W = random_weights(model_dim, inter_dim, experts)
    table = {}
    with open(csv_path) as fh:
        for r in csv.DictReader(fh):
            if (int(r["model_dim"]), int(r["inter_dim"]), int(r["experts"]), int(r["topk"]),
                    r["routing"]) == (model_dim, inter_dim, experts, topk, routing):
                table[int(r["num_tokens"])] = r
    out = []
    for tok in tokens:
        torch.manual_seed(2000 + tok)
        x = torch.randn((tok, model_dim), dtype=dtypes.bf16, device="cuda")
        tw, ti = make_routing(x, experts, topk, routing)
        cfg = lookup_config(tok, model_dim, inter_dim, experts, topk, routing, csv_path)
        tuned = lambda: tuned_moe(x, W, tw, ti, csv_path=csv_path, routing=routing)  # noqa: E731
        base = lambda: run_config(DEFAULT_CFG, x, W, tw, ti)  # noqa: E731
        c = G1._cos_diff(base().float(), tuned().float())
        t_tuned, t_base = _timed(tuned, reps), _timed(base, reps)
        t2 = 1 << max(0, (tok - 1).bit_length())
        r = table.get(t2)
        csv_us = float(r["us"]) if r else float("nan")
        log(f"tok {tok:6d} -> {t2:6d}: {config_name(cfg):28s} tuned {t_tuned:8.1f} us "
            f"(csv {csv_us:8.1f}) | default 2k {t_base:8.1f} us | {t_base / t_tuned:.2f}x | "
            f"cos {c:.1e}{'' if c < 1e-4 else ' BAD'}")
        out.append(dict(tokens=tok, cfg=config_name(cfg), tuned=t_tuned, csv=csv_us,
                        default=t_base, cos=c))
    return out


def main():
    p = argparse.ArgumentParser()
    p.add_argument("mode", choices=["tune", "verify"])
    p.add_argument("--shape", default="4096,256,256,8", help="model_dim,inter_dim,E,topk")
    p.add_argument("--routing", default="uniform", choices=ROUTINGS)
    p.add_argument("-t", type=int, nargs="*", default=None,
                   help="num_tokens (tune default 1, 2, 4 .. 32768)")
    p.add_argument("--csv", default=DEFAULT_CSV)
    p.add_argument("--reps", type=int, default=3)
    args = p.parse_args()
    H, I, E, K = (int(v) for v in args.shape.split(","))
    if args.mode == "tune":
        toks = args.t or [1 << i for i in range(16)]
        tune(H, I, E, K, args.routing, toks, args.csv, args.reps,
             log=lambda s: print(s, flush=True))
    else:
        toks = args.t or [1 << i for i in range(16)]
        verify(H, I, E, K, args.routing, toks, args.csv, args.reps,
               log=lambda s: print(s, flush=True))


if __name__ == "__main__":
    main()

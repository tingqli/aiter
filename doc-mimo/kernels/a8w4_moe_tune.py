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


def random_weights(model_dim, inter_dim, experts, seed=0, return_raw=False):
    torch.manual_seed(seed)
    w1 = torch.randn((experts, inter_dim * 2, model_dim), dtype=dtypes.bf16, device="cuda")
    w2 = torch.randn((experts, model_dim, inter_dim), dtype=dtypes.bf16, device="cuda")
    tq = get_torch_quant(QuantType.per_1x32)
    w1q, w1s = tq(w1, quant_dtype=dtypes.fp4x2)
    w2q, w2s = tq(w2, quant_dtype=dtypes.fp4x2)
    del w1, w2
    W = prepare_weights(
        shuffle_weight_a16w4(w1q.view(experts, inter_dim * 2, model_dim // 2), 16, False),
        shuffle_weight_a16w4(w2q.view(experts, model_dim, inter_dim // 2), 16, False),
        shuffle_scale_a16w4(w1s, experts, False), shuffle_scale_a16w4(w2s, experts, False))
    if return_raw:  # unshuffled mxfp4 + e8m0, for torch_ref
        return W, dict(w1q=w1q, w1s=w1s, w2q=w2q, w2s=w2s)
    return W


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


def run_config(cfg, x, W, topk_weights, topk_ids, act="silu", situ=None):
    """Run one candidate end to end (moe_sorting + x quant + kernels).
    ``act`` "silu" | "situv2"; ``situ``: dict of situ_beta / situ_linear_beta /
    swiglu_limit (runtime launch args)."""
    akw = dict(act=act, **(situ or {}))
    E, model_dim, _ = W["w2"].shape
    topk = topk_ids.shape[1]
    if cfg["kind"] == "1k":
        return F.fused_moe_a8w4_bm64(x, W, topk_weights, topk_ids, b_cache_mod=cfg["bcm"],
                                     waves_per_eu=cfg["wpe"], ksplit=cfg["ksplit"], **akw)
    if cfg["kind"] == "1kq":
        return Q.fused_moe_a8w4_bm64q(x, W, topk_weights, topk_ids, b_cache_mod=cfg["bcm"],
                                      **akw)
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
                  fast_dec=2, **akw)
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


def tuned_moe(x, weights, topk_weights, topk_ids, *, csv_path=DEFAULT_CSV, routing="uniform",
              act="silu", situ=None):
    """A8W4 MoE (bf16 x [tokens, H] -> bf16 [tokens, H]) with the tuned kernel for
    this batch size. ``weights`` from ``prepare_weights`` (fd2). ``act``/``situ``
    as ``run_config`` (the table was tuned with silu)."""
    E, model_dim, _ = weights["w2"].shape
    cfg = lookup_config(x.shape[0], model_dim, weights["w1"].shape[1] // 2, E,
                        topk_ids.shape[1], routing, csv_path)
    return run_config(cfg, x, weights, topk_weights, topk_ids, act, situ)


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


def _name_to_cfg(name):
    """Inverse of ``config_name`` (the best_2k / best_1k CSV columns)."""
    p = name.split()
    if p[0] == "2k":
        return dict(kind="2k", block_m=int(p[1][2:]), g1_bcm=int(p[2][5:]), g2=p[3][2:])
    if p[0] == "1k":
        return dict(kind="1k", block_m=64, bcm=int(p[2][3:]), wpe=int(p[3][1:]),
                    ksplit=int(p[4][2:]))
    return dict(kind="1kq", block_m=64, bcm=int(p[2][3:]))


def torch_ref(x, raw, topk_weights, topk_ids, act="silu", situ=None):
    """fp32 MoE reference from bf16 x and the unshuffled mxfp4 weights: stage1 +
    act (``G1.act_ref``: SiTUv2 incl. the clamp) -> bf16 -> torch_moe_stage2."""
    from aiter.fused_moe import torch_moe_stage2
    from aiter.utility import fp4_utils

    tokens, H = x.shape
    topk = topk_ids.shape[1]
    E, N = raw["w1q"].shape[0], raw["w1q"].numel() * 2 // (raw["w1q"].shape[0] * H)
    inter = N // 2
    w1q = raw["w1q"].view(E, N, H // 2)
    w1s = fp4_utils.e8m0_to_f32(raw["w1s"]).view(E, N, H // 32, 1)
    a = x.float()
    o1 = torch.zeros((tokens, topk, inter), dtype=torch.float32, device=x.device)
    for e in topk_ids.unique().tolist():
        mask = topk_ids == e
        w = (fp4_utils.mxfp4_to_f32(w1q[e]).view(N, H // 32, 32) * w1s[e]).view(N, H)
        gate, up = (a[mask.nonzero()[:, 0]] @ w.t()).split(inter, dim=-1)
        o1[mask] = G1.act_ref(gate, up, act, situ)
    w2q = raw["w2q"].view(E, H, inter // 2)
    return torch_moe_stage2(
        o1.to(dtypes.bf16), w1q.view(dtypes.fp4x2), w2q.view(dtypes.fp4x2), topk_weights,
        topk_ids, dtype=dtypes.bf16, quant_type=QuantType.per_1x32,
        w2_scale=raw["w2s"].view(E, H, inter // 32), a2_scale=None, doweight=True)


def compare_act(model_dim, inter_dim, experts, topk, routing, tokens, csv_path, reps=3,
                situ=None, log=print):
    """silu vs situv2 per CSV point: the tuned config plus the CSV's best 2-kernel and
    best fused config. Same weights / x / routing, both acts timed back to back in
    one process. Correctness: cos vs the torch reference of that act."""
    situ = dict(G1.SITU if situ is None else situ)
    W, raw = random_weights(model_dim, inter_dim, experts, return_raw=True)
    table = {}
    with open(csv_path) as fh:
        for r in csv.DictReader(fh):
            if (int(r["model_dim"]), int(r["inter_dim"]), int(r["experts"]), int(r["topk"]),
                    r["routing"]) == (model_dim, inter_dim, experts, topk, routing):
                table[int(r["num_tokens"])] = r
    tokens = tokens or sorted(table)
    out = []
    for tok in tokens:
        r = table[1 << max(0, (tok - 1).bit_length())]
        torch.manual_seed(3000 + tok)
        x = torch.randn((tok, model_dim), dtype=dtypes.bf16, device="cuda")
        tw, ti = make_routing(x, experts, topk, routing)
        refs = {a: torch_ref(x, raw, tw, ti, a, situ).float() for a in G1.ACTS}
        cfgs = {"tuned": _row_to_cfg(r)}
        for col in ("best_2k", "best_1k"):
            c = _name_to_cfg(r[col])
            if c not in cfgs.values():
                cfgs[col] = c
        for role, cfg in cfgs.items():
            row = dict(tokens=tok, role=role, cfg=config_name(cfg))
            for a in G1.ACTS:
                fn = lambda a=a: run_config(cfg, x, W, tw, ti, a, situ)  # noqa: E731
                c = G1._cos_diff(refs[a], fn().float())
                row[f"{a} us"] = _timed(fn, reps)
                row[f"{a} cos"] = c
                assert c < 1e-2, f"{config_name(cfg)} {a} tok {tok}: cos {c:.2e}"
            row["situv2/silu"] = row["situv2 us"] / row["silu us"]
            log(f"tok {tok:6d} {role:8s} {row['cfg']:24s} silu {row['silu us']:8.1f} us "
                f"situv2 {row['situv2 us']:8.1f} us  x{row['situv2/silu']:.3f}  "
                f"cos {row['silu cos']:.1e}/{row['situv2 cos']:.1e}")
            out.append(row)
        del x
    return out


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
    p.add_argument("mode", choices=["tune", "verify", "compare-act"])
    p.add_argument("--shape", default="4096,256,256,8", help="model_dim,inter_dim,E,topk")
    p.add_argument("--routing", default="uniform", choices=ROUTINGS)
    p.add_argument("-t", type=int, nargs="*", default=None,
                   help="num_tokens (tune default 1, 2, 4 .. 32768)")
    p.add_argument("--csv", default=DEFAULT_CSV)
    p.add_argument("--reps", type=int, default=3)
    p.add_argument("--situ", default=None,
                   help="compare-act: beta,linear_beta,limit (default G1.SITU = 4,25,64)")
    args = p.parse_args()
    H, I, E, K = (int(v) for v in args.shape.split(","))
    if args.mode == "compare-act":
        import pandas as pd

        situ = None
        if args.situ:
            b, lb, lim = (float(v) for v in args.situ.split(","))
            situ = dict(situ_beta=b, situ_linear_beta=lb, swiglu_limit=lim)
        rows = compare_act(H, I, E, K, args.routing, args.t, args.csv, args.reps, situ,
                           log=lambda s: print(s, flush=True))
        print(pd.DataFrame(rows).to_markdown(index=False, floatfmt=".4g"))
        return
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

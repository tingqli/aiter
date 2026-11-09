# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""FP8 blockscale (W128x128 / A1x128) fused MoE for MiMo-V2.6 TP8 shapes (gfx950).

Pipeline (4 launches, no host sync, all scratch preallocated):
  1. bs_prep: routing sort (block 256) + x -> FP8 per (token, 128) + inverse map
  2. bs_gemm1: gate|up GEMM + SiLU*up, fused per-(row, 128) FP8 quant of A2
  3. bs_down: M128 Down GEMM x routing weight -> packed BF16 route buffer
  4. bs_reduce: TOPK sum of the routes -> out [T, H] BF16

prep="aiter" swaps step 1 for aiter CK moe_sorting + hip per_1x128 quant +
invert_sorted_ids (the reference flow); fuse_quant=False writes a BF16 A2 and
quantizes it with aiter (also the reference flow). down_out="atomic" zeroes out
and lets Down add its rows with packed BF16 atomics (no route buffer / reduce).
gemm1 / Down / the reduce are ported from tq/moe_gemm_blockscale (see each
file's header).
"""

import torch

import aiter
from aiter import QuantType
from aiter.fused_moe import _moe_sorting_impl

from bs_down import M128_QUEUE_SIZE, make_m128_down
from bs_gemm1 import fp8_blockscale_stage1
from bs_prep import bs_prep
from bs_reduce import invert_sorted_ids, make_moe_sum

F8 = torch.float8_e4m3fn
SORT_BLOCK = 256

# MiMo-V2.6 TP8 MoE shapes per rank: (model_dim, inter_dim per rank, experts, topk).
# Routed experts / topk from the HF configs; MiMo has no shared expert.
MODELS = {
    "flash": (4096, 256, 256, 8),  # XiaomiMiMo/MiMo-V2.6-Flash-RL
    "pro": (6144, 256, 384, 8),  # XiaomiMiMo/MiMo-V2.6-Pro-RL
}

_ws_cache = {}


def _workspace(key, shape, dtype, device):
    """Reusable scratch tensor (graph-friendly: no per-call allocation)."""
    t = _ws_cache.get(key)
    if t is None or t.shape != torch.Size(shape) or t.dtype != dtype or t.device != device:
        t = torch.empty(shape, dtype=dtype, device=device)
        _ws_cache[key] = t
    return t


def stages(
    x,
    w1,
    w1_scale,
    w2,
    w2_scale,
    topk_weights,
    topk_ids,
    *,
    out=None,
    down_splits=None,
    persistent_down=True,
    fuse_quant=True,
    prep="fused",
    down_out="store",
):
    """Return the MoE as a list of (name, callable) stages sharing a state dict.

    x [T, H] bf16; w1 [E, 2I, H] / w2 [E, H, I] fp8 e4m3fn, shuffle_weight(16,16);
    w1_scale [E, 2I/128, H/128] / w2_scale [E, H/128, I/128] fp32;
    topk_weights [T, topk] fp32, topk_ids [T, topk] int32.
    """
    T, H = x.shape
    E, two_i, _ = w1.shape
    I = two_i // 2
    topk = topk_ids.shape[1]
    dev = x.device
    if out is None:
        out = torch.empty(T, H, dtype=torch.bfloat16, device=dev)
    if down_splits is None:  # in-pipeline sweep on MI350X (down_out_ab.py): oc4
        down_splits = 4
    quant = aiter.get_hip_quant(QuantType.per_1x128)
    cap = T * topk + E * SORT_BLOCK - topk
    cap_blocks = (cap + SORT_BLOCK - 1) // SORT_BLOCK
    st = {}
    stage_list = []

    if prep == "fused":
        prep_out = (
            _workspace("sids", (cap,), torch.int32, dev),
            _workspace("sw", (cap,), torch.float32, dev),
            _workspace("seids", (cap_blocks,), torch.int32, dev),
            _workspace("nv", (2,), torch.int32, dev),
            _workspace("a", (T, H), F8, dev),
            _workspace("sa", (H // 128, T), torch.float32, dev),
            _workspace("inverse", (T, topk), torch.int32, dev),
        )

        def s_prep():
            bs_prep(x, topk_ids, topk_weights, E, out=prep_out)
            st["sort"] = prep_out[:4]
            st["a"], st["sa"], st["inverse"] = prep_out[4:]

        stage_list.append(("prep", s_prep))
    else:
        inverse = _workspace("inverse", (T, topk), torch.int32, dev)

        def s_sort():
            # CK sorting (opus is slower at these sizes); no moe_buf zeroing: the
            # reduce writes every output row.
            st["sort"] = _moe_sorting_impl(
                topk_ids, topk_weights, E, H, torch.bfloat16, SORT_BLOCK, None, None, 0,
                use_opus=False, accumulate=False,
            )
            si, sw, se, nv = st["sort"][:4]
            invert_sorted_ids(topk)(si, inverse, nv, si.numel(), T)
            st["inverse"] = inverse

        def s_quant():
            st["a"], st["sa"] = quant(x, quant_dtype=F8, transpose_scale=True)

        stage_list += [("sort", s_sort), ("quant", s_quant)]

    if fuse_quant:
        a2 = _workspace("a2", (T, topk, I), F8, dev)
        sa2 = _workspace("sa2", (I // 128, T * topk), torch.float32, dev)

        def s_gemm1():
            si, sw, se, nv = st["sort"][:4]
            fp8_blockscale_stage1(
                st["a"], w1, st["sa"], w1_scale, si, se, nv, a2, output_scale=sa2
            )
            st["a2"], st["sa2"] = a2, sa2

    else:
        mid = _workspace("mid", (T, topk, I), torch.bfloat16, dev)

        def s_gemm1():
            si, sw, se, nv = st["sort"][:4]
            fp8_blockscale_stage1(st["a"], w1, st["sa"], w1_scale, si, se, nv, mid)
            st["a2"], st["sa2"] = quant(
                mid, quant_dtype=F8, num_rows_factor=topk, transpose_scale=True
            )

    down = make_m128_down(
        n=H,
        k=I,
        topk=topk,
        num_experts=E,
        num_oc_splits=down_splits,
        persistent=persistent_down,
        is_sorted_bm_256=True,
        atomic_out=down_out == "atomic",
    )
    counter = (
        torch.zeros(M128_QUEUE_SIZE, dtype=torch.int32, device=dev)
        if persistent_down
        else torch.empty(1, dtype=torch.int32, device=dev)
    )
    ws2 = w2_scale.view(E, H // 128, I // 128)
    if down_out == "atomic":

        def s_zero():
            out.zero_()

        def s_down():
            si, sw, se, nv = st["sort"][:4]
            down(out, st["a2"], w2, st["sa2"], ws2, si, sw, se, nv, counter)

        stage_list += [("gemm1", s_gemm1), ("zero", s_zero), ("down", s_down)]
        return stage_list, out

    routes = _workspace("routes", (cap_blocks * SORT_BLOCK, H), torch.bfloat16, dev)

    def s_down():
        si, sw, se, nv = st["sort"][:4]
        down(routes, st["a2"], w2, st["sa2"], ws2, si, sw, se, nv, counter)

    moe_sum = make_moe_sum(n=H, topk=topk, sort_block_m=128)

    def s_reduce():
        moe_sum(out, routes, st["inverse"])

    stage_list += [("gemm1", s_gemm1), ("down", s_down), ("reduce", s_reduce)]
    return stage_list, out


def fp8_blockscale_moe(x, w1, w1_scale, w2, w2_scale, topk_weights, topk_ids, **kw):
    """out [T, H] bf16 = sum_k w_k * Down(SiLU(gate)*up) over the topk experts."""
    fns, out = stages(x, w1, w1_scale, w2, w2_scale, topk_weights, topk_ids, **kw)
    for _, f in fns:
        f()
    return out

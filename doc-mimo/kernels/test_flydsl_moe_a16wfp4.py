# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""FlyDSL-side coverage for the a16w4 (bf16 A x MXFP4 W) SiTUv2 MoE kernel.

Exercises the NEW shared a16w-mix a16w4 kernel
(``aiter/ops/flydsl/kernels/moe_2stage_a16wmix``) through the production
``fused_moe`` a16w4 path (the standard 2-stage FlyDSL dispatch:
``get_2stage_cfgs`` -> ``fused_moe_2stages`` -> the a16w4 branches of
``_flydsl_moe_stage{1,2}_impl`` -> ``flydsl_a16w4_gemm{1,2}``, built via
``compile_flydsl_moe_stage{1,2}``), in the SiTUv2 / SEPARATED bf16-activation x
mxfp4-weight configuration, against a bf16 SiTUv2 torch reference with a strict
cos/logits_diff gate.

This is the explicit FlyDSL-side test complementing the routed a16w4 rows of
``op_tests/test_moe_2stage.py``. It goes through ``fused_moe`` (or
``flydsl_a16w4_gemm1/2``), NOT the removed low-level ``compile_mixed_moe_gemm1_a16w4``
API.

Run:
    pytest op_tests/flydsl_tests/test_flydsl_moe_a16wfp4.py -q
"""

import itertools
import os
import sys

import pytest
import torch

import aiter
from aiter import ActivationType, QuantType, dtypes
from aiter.fused_moe import (
    fused_moe,
    fused_topk,
    moe_sorting,
    torch_moe_stage1,
    torch_moe_stage2,
)
from aiter.jit.utils.chip_info import get_gfx
from aiter.ops.flydsl.moe_common import GateMode
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4

_SKIP = pytest.mark.skipif(
    get_gfx() not in ("gfx942", "gfx950"),
    reason="CDNA (gfx942/gfx950) + FlyDSL required for a16w4 SiTUv2",
)


def _cos_diff(x, y):
    x, y = x.double(), y.double()
    denom = (x * x + y * y).sum()
    return float(1 - 2 * (x * y).sum() / denom)


# =============================================================================
# A8W4 fused MoE built from the standalone gemm1/gemm2 kernels
# (op_tests/test_a8w4_gemm1.py, op_tests/test_a8w4_gemm2.py; gfx942 only)
# =============================================================================

# block_m -> (gemm1 kwargs, gemm2 kwargs). Both stages share the sorting block_m.
#  32: gemm1 pipelined (prefetch) + XCD swizzle; gemm2 skips all-padding sub-blocks.
#  64: same block_m as the tuned CSV; gemm1 dyn_m (32/64 rows per block at runtime),
#      gemm2 dyn_rows.
A8W4_E2E_CFGS = {
    32: (
        dict(tile_n=128, b_cache_mod=1, xcd_swizzle=1),
        dict(tile_n=128, b_cache_mod=2, xcd_swizzle=0, dyn_rows=True),
    ),
    64: (
        dict(tile_n=128, b_cache_mod=1, xcd_swizzle=1, dyn_m=True),
        dict(tile_n=128, b_cache_mod=2, xcd_swizzle=0, dyn_rows=True),
    ),
}


def _a8w4_kernels():
    # The standalone kernels live next to this file as test modules.
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
    from test_a8w4_gemm1 import a8w4_gemm1
    from test_a8w4_gemm2 import a8w4_gemm2

    return a8w4_gemm1, a8w4_gemm2


def a8w4_prepare_weights(w1, w2, w1_scale, w2_scale):
    """Weight-static prep (cached per weight in production): u8 views of the
    standard-preshuffled mxfp4 W1/W2 + e8m0 scales and W1's per-channel max
    e8m0 exponent. W2's exponent is derived inside gemm2."""
    from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import channel_exponents

    w1_u8 = w1.view(torch.uint8)
    w1_scale_u8 = w1_scale.view(torch.uint8).contiguous().view(-1)
    return dict(
        w1=w1_u8,
        w2=w2.view(torch.uint8),
        w1_scale=w1_scale_u8,
        w2_scale=w2_scale.view(torch.uint8).contiguous().view(-1),
        w1_exp=channel_exponents(w1_u8, w1_scale_u8),
    )


def a8w4_fused_moe(
    hidden_states, weights, topk_weights, topk_ids, *, block_m=32, fuse_quant=False
):
    """SiLU SEPARATED A8W4 MoE: sort -> fp8 row-quant(x) -> gemm1 (gate+up+SiLU,
    bf16 by sorted row) -> fp8 row-quant(inter) -> gemm2 (down + weighted atomic
    scatter into the zeroed moe_buf). Returns bf16 [tokens, model_dim].

    ``fuse_quant``: gemm1 quantizes in its epilogue (``q8s``: fp8 by sorted row,
    one f32 scale per (row, 128 cols)) and gemm2 takes the per-128-K-group A
    scales; drops the second row-quant kernel and the bf16 round trip."""
    from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows

    a8w4_gemm1, a8w4_gemm2 = _a8w4_kernels()
    g1_cfg, g2_cfg = A8W4_E2E_CFGS[block_m]
    E, model_dim, _ = weights["w2"].shape
    inter_dim = weights["w1"].shape[1] // 2

    sorted_ids, sorted_weights, sorted_expert_ids, num_valid_ids, moe_buf = (
        moe_sorting(topk_ids, topk_weights, E, model_dim, dtypes.bf16, block_m)[:5]
    )
    x_fp8, x_scale = quantize_rows(hidden_states)
    sorted_size = sorted_expert_ids.numel() * block_m
    if fuse_quant:
        assert g1_cfg["tile_n"] == 128, "q8s scale groups = gemm1 tile_n = 128"
        groups = inter_dim // 128
        buf = torch.empty(
            sorted_size * (inter_dim + groups * 4),
            dtype=torch.uint8,
            device=hidden_states.device,
        )
        a8w4_gemm1(
            x_fp8,
            x_scale,
            weights["w1"],
            weights["w1_scale"],
            weights["w1_exp"],
            sorted_ids,
            sorted_expert_ids,
            num_valid_ids,
            buf,
            num_experts=E,
            tile_m=block_m,
            epilog="q8s",
            inter_dim=inter_dim,
            topk=topk_ids.shape[1],
            **g1_cfg,
        )
        nd = sorted_size * inter_dim
        a2_fp8 = buf[:nd].view(torch.float8_e4m3fnuz).view(sorted_size, inter_dim)
        a2_scale = buf[nd:].view(torch.float32).view(sorted_size, groups)
        a8w4_gemm2(
            a2_fp8,
            a2_scale,
            weights["w2"],
            weights["w2_scale"],
            sorted_ids,
            sorted_weights,
            sorted_expert_ids,
            num_valid_ids,
            moe_buf,
            num_experts=E,
            tile_m=block_m,
            a_group=128,
            **g2_cfg,
        )
        return moe_buf
    inter = torch.empty(
        (sorted_size, inter_dim),
        dtype=dtypes.bf16,
        device=hidden_states.device,
    )
    a8w4_gemm1(
        x_fp8,
        x_scale,
        weights["w1"],
        weights["w1_scale"],
        weights["w1_exp"],
        sorted_ids,
        sorted_expert_ids,
        num_valid_ids,
        inter,
        num_experts=E,
        tile_m=block_m,
        **g1_cfg,
    )
    a2_fp8, a2_scale = quantize_rows(inter, num_valid_ids)
    a8w4_gemm2(
        a2_fp8,
        a2_scale,
        weights["w2"],
        weights["w2_scale"],
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        moe_buf,
        num_experts=E,
        tile_m=block_m,
        **g2_cfg,
    )
    return moe_buf

import torch
from typing import Callable, Any, Tuple

def make_graphed_oprun(
    oprun: Callable,
    *sample_args,
    num_warmup_iters: int = 3,
    **sample_kwargs: Any,
):
    """
    将 oprun 手动捕获为 CUDA Graph，支持 *args 和 **kwargs。
    
    返回的 graphed_fn 不接受任何参数，调用即重放。
    调用者需通过 graphed_fn.static_args / graphed_fn.static_kwargs
    自行更新输入（原地 copy_），再调用 graphed_fn() 触发重放。
    """
    # ---------- 1. 分离张量与非张量参数 ----------
    if not all(isinstance(a, torch.Tensor) for a in sample_args):
        raise TypeError("sample_args 中的位置参数必须全部是 Tensor。")

    tensor_kw_keys = []
    non_tensor_kwargs = {}
    for k, v in sample_kwargs.items():
        if isinstance(v, torch.Tensor):
            tensor_kw_keys.append(k)
        else:
            non_tensor_kwargs[k] = v  # 冻结，重放时不可变

    # ---------- 2. 创建静态缓冲区 ----------
    # 位置参数：克隆并保持 requires_grad
    static_args = tuple(
        a.clone().detach().requires_grad_(a.requires_grad) for a in sample_args
    )
    # 张量 kwargs：克隆并保持 requires_grad
    static_kwargs = {
        k: sample_kwargs[k].clone().detach().requires_grad_(
            sample_kwargs[k].requires_grad
        )
        for k in tensor_kw_keys
    }

    # ---------- 3. 在 side stream 上预热 ----------
    s = torch.cuda.Stream()
    # s = torch.cuda.current_stream()
    with torch.cuda.stream(s):
        for _ in range(num_warmup_iters):
            _ = oprun(*static_args, **static_kwargs, **non_tensor_kwargs)
    torch.cuda.current_stream().wait_stream(s)

    # ---------- 4. 捕获 ----------
    graph = torch.cuda.CUDAGraph()
    with torch.cuda.graph(graph):
        static_output = oprun(*static_args, **static_kwargs, **non_tensor_kwargs)

    # ---------- 5. 返回零参数重放函数 ----------
    def graphed_fn():
        """重放图。调用者需事先更新 static_args / static_kwargs。"""
        with torch.cuda.stream(torch.cuda.current_stream()):
            graph.replay()
        return static_output

    return graphed_fn


@_SKIP
@pytest.mark.parametrize("model_dim,inter_dim", [(4096, 256)])
@pytest.mark.parametrize("token", [128, 512, 2048])
# Mimo v2.6
def test_flydsl_a16wfp4_silu_e2e(
    model_dim, inter_dim, token
):
    """a16w4 Silu SEPARATED end-to-end through fused_moe vs a bf16 ref."""
    E, topk = 256, 8
    dtype = dtypes.bf16
    torch.manual_seed(0)
    torch.cuda.manual_seed(0)

    inp = torch.randn((token, model_dim), dtype=dtype, device="cuda")
    w1 = torch.randn((E, inter_dim * 2, model_dim), dtype=dtype, device="cuda")
    w2 = torch.randn((E, model_dim, inter_dim), dtype=dtype, device="cuda")
    score = torch.randn((token, E), dtype=dtype, device="cuda")
    topk_weights, topk_ids = fused_topk(inp, score, topk, True)

    tq = aiter.get_torch_quant(QuantType.per_1x32)
    w1_qt, w1_scale = tq(w1, quant_dtype=dtypes.fp4x2)
    w2_qt, w2_scale = tq(w2, quant_dtype=dtypes.fp4x2)
    w1_qt = w1_qt.view(E, inter_dim * 2, model_dim // 2)
    w2_qt = w2_qt.view(E, model_dim, inter_dim // 2)
    w1_scale_e = w1_scale.view(E, inter_dim * 2, model_dim // 32)
    w2_scale_e = w2_scale.view(E, model_dim, inter_dim // 32)

    # bf16 Silu SEPARATED reference
    o1 = torch_moe_stage1(
        inp.to(dtype),
        w1_qt.view(dtypes.fp4x2),
        w2_qt.view(dtypes.fp4x2),
        topk_weights,
        topk_ids,
        dtype=dtype,
        activation=ActivationType.Silu,
        quant_type=QuantType.per_1x32,
        a1_scale=None,
        w1_scale=w1_scale_e,
        doweight=False,
    )
    ref = torch_moe_stage2(
        o1.view(token, topk, inter_dim),
        w1_qt.view(dtypes.fp4x2),
        w2_qt.view(dtypes.fp4x2),
        topk_weights,
        topk_ids,
        dtype=dtype,
        quant_type=QuantType.per_1x32,
        w2_scale=w2_scale_e,
        a2_scale=None,
        doweight=True,
    )

    # caller contract: standard GGUU (separated gate/up) W1 layout, matching main
    w1_gui = shuffle_weight_a16w4(w1_qt, 16, False)
    w2_gui = shuffle_weight_a16w4(w2_qt, 16, False)
    w1_scale_gui = shuffle_scale_a16w4(w1_scale, E, False)
    w2_scale_gui = shuffle_scale_a16w4(w2_scale, E, False)
    from aiter.test_common import run_perftest

    num_graphs = 0
    graphed_fused_moe = [make_graphed_oprun(fused_moe, 
                            inp.clone(),
                            w1_gui.clone(),
                            w2_gui.clone(),
                            topk_weights.clone(),
                            topk_ids.clone(),
                            w1_scale=w1_scale_gui.clone(),
                            w2_scale=w2_scale_gui.clone(),
                            quant_type=QuantType.per_1x32,
                            activation=ActivationType.Silu,
                            doweight_stage1=False,
                            gate_mode=GateMode.SEPARATED.value) for i in range(num_graphs)]

    if num_graphs:
        graph_id = 0
        def oprun():
            nonlocal graph_id
            graph_id += 1
            graph_id %= num_graphs
            return graphed_fused_moe[graph_id]()
        out, avg_us = run_perftest(oprun)
    else:
        out, avg_us = run_perftest(fused_moe,
            inp,
            w1_gui,
            w2_gui,
            topk_weights,
            topk_ids,
            w1_scale=w1_scale_gui,
            w2_scale=w2_scale_gui,
            quant_type=QuantType.per_1x32,
            activation=ActivationType.Silu,
            doweight_stage1=False,
            gate_mode=GateMode.SEPARATED.value
        )

    w1_gui_bytes = w1_gui.element_size() * w1_gui.nelement()
    w2_gui_bytes = w2_gui.element_size() * w2_gui.nelement()

    per_expert_load1 = w1_gui_bytes + (token * topk * model_dim)/E
    per_expert_load2 = w2_gui_bytes + (token * topk * inter_dim)/E

    print(f"{token, model_dim, inter_dim, E, topk} {avg_us=:.2f} {(w1_gui_bytes + w2_gui_bytes)*1e-12/(avg_us*1e-6):.2f} TB/s {per_expert_load1=:.2f} {per_expert_load2=:.2f}")

    assert not out.isnan().any().item(), "a16w4 Silu output contains NaN"
    ld = _cos_diff(ref.float(), out.float())
    assert ld < 1e-2, f"a16w4 Silu cos/logits_diff too large: {ld:.3e}"

    # ---- standalone A8W4 gemm1+gemm2 pipeline vs the fused_moe selection above ----
    if get_gfx() != "gfx942":
        return
    weights = a8w4_prepare_weights(w1_gui, w2_gui, w1_scale_gui, w2_scale_gui)
    print(f"  fused_moe (current selection): {avg_us:8.2f} us  cos_diff={ld:.3e}")
    for block_m, fuse_quant in itertools.product(A8W4_E2E_CFGS, (False, True)):
        # JIT-compile outside the timed region.
        a8w4_fused_moe(
            inp, weights, topk_weights, topk_ids, block_m=block_m, fuse_quant=fuse_quant
        )
        torch.cuda.synchronize()
        out_new, us_new = run_perftest(
            a8w4_fused_moe,
            inp,
            weights,
            topk_weights,
            topk_ids,
            block_m=block_m,
            fuse_quant=fuse_quant,
        )
        tag = f"bm{block_m}{' fused-quant' if fuse_quant else ''}"
        assert not out_new.isnan().any().item(), f"a8w4 {tag} output has NaN"
        ld_new = _cos_diff(ref.float(), out_new.float())
        print(
            f"  a8w4 standalone {tag:<16}: {us_new:8.2f} us  "
            f"cos_diff={ld_new:.3e}  speedup={avg_us / us_new:.2f}x"
        )
        assert ld_new < 1e-2, f"a8w4 {tag} cos/logits_diff too large: {ld_new:.3e}"

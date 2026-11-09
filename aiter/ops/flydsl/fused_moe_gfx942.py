# SPDX-License-Identifier: MIT
# Copyright (c) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
from dataclasses import dataclass
from functools import cache
from typing import Any

import torch

import aiter
from aiter import ActivationType, QuantType
from aiter.fused_moe import AUX_SORT_OPUS, moe_sorting
from aiter.fused_moe_registry import FusedMoeRequest
from aiter.jit.utils.chip_info import get_cu_num, get_gfx
from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8 import (
    flydsl_absmax,
    flydsl_quant_per_tensor,
    invert_sorted_ids,
    sorted_sum,
)
from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.a8w8_blockscale_config import (
    m128_down_lds_bytes,
    routed_down_lds_bytes,
)
from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.common import _ptr
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled

_BLOCKSCALE_PREFILL_PATHS = ("block_m128", "block_m128_persistent", "block_8wave")


@dataclass
class Config:
    BLOCK_M: int
    BLOCK_N: int
    BLOCK_K: int
    use_prefill: bool
    down_path: str = "default"
    down_output_padding_bytes: int = 0
    use_batch1_algorithm: bool = False
    down_block_n: int = 128
    num_oc_splits: int = 1
    # Stage1 K-tile rotation; None keeps the kernel wrapper's heuristic.
    k_rotate: bool | None = None

    @property
    def is_blockscale_prefill(self):
        return self.down_path in _BLOCKSCALE_PREFILL_PATHS

    @property
    def is_blockscale_decode(self):
        # Explicit weight-only A16W8, unlike the A1x128 prefill paths above.
        return self.down_path == "block_a16w8"

    def __post_init__(self):
        if self.down_path not in (
            "default",
            "1x4_64x256",
            "8x1_compact",
            "block_a16w8",
            *_BLOCKSCALE_PREFILL_PATHS,
        ):
            raise ValueError(f"Unsupported Down path: {self.down_path}")
        if self.down_output_padding_bytes not in (0, 32, 64, 128):
            raise ValueError("Down output padding must be 0, 32, 64 or 128 bytes")
        if self.down_path == "default" and self.down_output_padding_bytes != 0:
            raise ValueError("The default Down path does not support output padding")
        if (
            self.down_path != "default"
            and not self.is_blockscale_decode
            and not self.use_prefill
        ):
            raise ValueError("Specialized Down paths require prefill")
        if self.use_batch1_algorithm and (
            self.use_prefill or self.down_path not in ("default", "block_a16w8")
        ):
            raise ValueError(
                "Direct decoding cannot use prefill or specialized Down paths"
            )
        # The batch-1 kernels have a fixed tile, so any other tile would be misreported.
        tile = (self.BLOCK_M, self.BLOCK_N, self.BLOCK_K)
        if self.use_batch1_algorithm and tile != (16, 16, 16):
            raise ValueError("Direct decoding uses the 16_16_16 tile")
        if self.is_blockscale_decode and (
            self.use_prefill or self.down_output_padding_bytes
        ):
            raise ValueError("block_a16w8 requires decoding without output padding")
        if self.is_blockscale_prefill:
            # BLOCK_M is the shared sorting block, not the M128 Down tile.
            if (self.BLOCK_M, self.BLOCK_N, self.BLOCK_K) != (256, 256, 128):
                raise ValueError("blockscale uses sort256 and fixed Gate/Up N256/K128")
            if self.down_output_padding_bytes:
                raise ValueError("blockscale Down does not support output padding")
            if type(self.num_oc_splits) is not int or self.num_oc_splits <= 0:
                raise ValueError("num_oc_splits must be a positive integer")
            allowed_n = (32, 64, 128) if self.down_path == "block_8wave" else (128,)
            if self.down_block_n not in allowed_n:
                raise ValueError(
                    f"{self.down_path} requires down_block_n in {allowed_n}"
                )
        elif (self.down_block_n, self.num_oc_splits) != (128, 1):
            raise ValueError("Down N/OC overrides are supported by blockscale only")
        if self.k_rotate is not None and (
            not self.is_blockscale_prefill or type(self.k_rotate) is not bool
        ):
            raise ValueError("k_rotate must be a bool on blockscale prefill configs")

    def to_string(self):
        # Only direct decoding adds the fifth tile field, so existing strings are unchanged.
        batch1 = "_True" if self.use_batch1_algorithm else ""
        value = (
            f"{self.BLOCK_M}_{self.BLOCK_N}_{self.BLOCK_K}_{self.use_prefill}{batch1}:"
            f"{self.down_path}:{self.down_output_padding_bytes}"
        )
        # Keep every existing config/CSV spelling unchanged.
        if self.is_blockscale_prefill:
            value += f":{self.down_block_n}:{self.num_oc_splits}"
            # The optional sixth field is written only for an explicit choice.
            if self.k_rotate is not None:
                value += f":{int(self.k_rotate)}"
        return value

    @classmethod
    def from_string(cls, data: str):
        fields = data.split(":")
        # Configs tuned before the Down suffix existed use the default Down path.
        if len(fields) == 1:
            fields += ["default", "0"]
        if len(fields) not in (3, 5, 6):
            raise ValueError(f"Invalid FlyDSL MoE config: {data!r}")
        tile, down_path, padding = fields[:3]
        if (down_path in _BLOCKSCALE_PREFILL_PATHS) != (len(fields) >= 5):
            raise ValueError("blockscale configs require Down N and OC split fields")
        if len(fields) == 6 and fields[5] not in ("0", "1"):
            raise ValueError(f"Invalid K rotation flag: {fields[5]!r}")
        tile_fields = tile.split("_")
        if len(tile_fields) == 4:
            tile_fields.append("False")
        block_m, block_n, block_k, use_prefill, use_batch1_algorithm = tile_fields
        if use_prefill not in ("True", "False") or use_batch1_algorithm not in (
            "True",
            "False",
        ):
            raise ValueError(f"Invalid algorithm flags: {tile}")
        return cls(
            int(block_m),
            int(block_n),
            int(block_k),
            use_prefill == "True",
            down_path,
            int(padding),
            use_batch1_algorithm=use_batch1_algorithm == "True",
            down_block_n=int(fields[3]) if len(fields) >= 5 else 128,
            num_oc_splits=int(fields[4]) if len(fields) >= 5 else 1,
            k_rotate=fields[5] == "1" if len(fields) == 6 else None,
        )

    def unsupported_reason(self, problem: "_Problem") -> str | None:
        if self.use_batch1_algorithm and not 2 <= problem.batch <= 8:
            return "direct decoding requires 2 to 8 tokens"
        # Batch 1 runs the batch-1 kernels for any tile; tune it only as 16_16_16.
        tile = (self.BLOCK_M, self.BLOCK_N, self.BLOCK_K)
        if not self.use_prefill and problem.batch == 1 and tile != (16, 16, 16):
            return "batch 1 uses the 16_16_16 config"
        if self.is_blockscale_prefill:
            if problem.quant_type != "block":
                return "blockscale configs require W128x128/A1x128 FP8"
            if not 0 < problem.batch < (1 << 24):
                return "blockscale requires 1 to 2**24-1 tokens"
            if problem.hidden_dim < 256 or problem.hidden_dim % 256:
                return "blockscale Gate/Up requires hidden_dim divisible by 256"
            if problem.inter_dim <= 0 or problem.inter_dim % 128:
                return "blockscale requires inter_dim divisible by 128"
            if problem.gateup_dim != 2 * problem.inter_dim:
                return "blockscale requires separated Gate/Up weights"
            try:
                params = {
                    "n": problem.model_dim,
                    "k": problem.inter_dim,
                    "topk": problem.topk,
                    "num_experts": problem.experts,
                    "num_oc_splits": self.num_oc_splits,
                }
                if self.down_path == "block_8wave":
                    routed_down_lds_bytes(
                        **params, block_m=256, block_n=self.down_block_n
                    )
                else:
                    m128_down_lds_bytes(
                        **params, persistent=self.down_path == "block_m128_persistent"
                    )
            except ValueError as error:
                return str(error)
            return None
        if self.is_blockscale_decode:
            if problem.quant_type != "block":
                return "block_a16w8 requires FP8 blockscale weights"
            if problem.hidden_dim <= 0 or problem.hidden_dim % 512:
                return "block_a16w8 requires hidden_dim divisible by 512"
            if problem.inter_dim <= 0 or problem.inter_dim % 128:
                return "block_a16w8 requires inter_dim divisible by 128"
            if problem.model_dim <= 0 or problem.model_dim % 128:
                return "block_a16w8 requires model_dim divisible by 128"
            if problem.gateup_dim != 2 * problem.inter_dim:
                return "block_a16w8 requires separated Gate/Up weights"
            # The baseline decode gather/atomic mask reads signed slot bits.
            # TOPK itself is the padding slot, so it must also stay below 128.
            if problem.experts <= 0 or not 1 <= problem.topk <= min(
                problem.experts, 127
            ):
                return "block_a16w8 requires 1 to min(experts,127) routing slots"
            if not self.use_batch1_algorithm and problem.batch > 1:
                if problem.batch > 256:
                    return "decoding requires 1 to 256 tokens"
                if self.BLOCK_M != 16 or self.BLOCK_N not in (64, 128):
                    return "sorted decoding requires BM16 and BN64 or BN128"
                if self.BLOCK_K != 64:
                    return "sorted decoding requires BK64"
            return None
        if problem.quant_type == "block":
            return "blockscale requires a dedicated blockscale prefill or decode config"
        if self.down_path != "default":
            if self.BLOCK_M != 64:
                return "specialized Down paths require unchanged M64 Gate/Up metadata"
            # The native tuner's empty quant_type is a shape-only probe. The
            # runtime wrapper checks actual FP8 weight and activation support.
            if problem.quant_type not in ("", "ptpc", "per_tensor"):
                return "specialized Down paths require FP8 weights"
            if self.down_path == "8x1_compact":
                if problem.inter_dim not in (192, 256, 384, 512, 640):
                    return "compact Down requires inter_dim in {192,256,384,512,640}"
                if problem.model_dim < 512:
                    return "compact Down requires model_dim >= 512"
                if not 0 < problem.experts <= 2048:
                    return "compact Down requires 1 to 2048 experts"
            scale_bytes = 0 if problem.quant_type == "per_tensor" else 256 * 4
            if 64 * problem.inter_dim + scale_bytes + 4 * 16 * 64 * 2 > 64 * 1024:
                return "specialized M64 Down exceeds the 64 KiB LDS capacity"
        if self.use_prefill and problem.quant_type == "no":
            if self.BLOCK_K not in (64, 128):
                return "BF16 prefill requires Gate/Up BLOCK_K=64 or 128"
            if 2 * self.BLOCK_M * self.BLOCK_K * 2 > 64 * 1024:
                return "BF16 Gate/Up ping-pong exceeds the 64 KiB LDS capacity"
            if self.BLOCK_M * problem.inter_dim * 2 > 64 * 1024:
                return "BF16 default Down exceeds the 64 KiB LDS capacity"
        if self.use_prefill and problem.gateup_dim % self.BLOCK_N != 0:
            return (
                f"gateup_dim={problem.gateup_dim} is not divisible by "
                f"BLOCK_N={self.BLOCK_N}"
            )
        if self.use_prefill and problem.inter_dim % 64 != 0:
            return (
                f"inter_dim={problem.inter_dim} is not divisible by the "
                "down BLOCK_K=64"
            )
        if self.use_prefill and problem.hidden_dim % (2 * self.BLOCK_K) != 0:
            return (
                f"hidden_dim={problem.hidden_dim} is not divisible by "
                f"2*BLOCK_K={2 * self.BLOCK_K} for the gateup pipeline"
            )
        if self.use_prefill and problem.model_dim % 256 != 0:
            return (
                f"model_dim={problem.model_dim} is not divisible by 256; "
                "the prefill down pipeline processes paired 128-wide tiles"
            )
        return None


@dataclass(frozen=True)
class _Problem:
    batch: int
    experts: int
    gateup_dim: int
    hidden_dim: int
    model_dim: int
    inter_dim: int
    topk: int
    quant_type: str

    @classmethod
    def from_inputs(
        cls,
        hidden_states: torch.Tensor,
        w1: torch.Tensor,
        w2: torch.Tensor,
        topk_ids: torch.Tensor,
        quant_type: QuantType,
    ):
        experts, gateup_dim, hidden_dim = w1.shape
        model_dim, inter_dim = w2.shape[1], w2.shape[2]
        assert gateup_dim == 2 * inter_dim
        return cls(
            batch=int(hidden_states.shape[0]),
            experts=experts,
            gateup_dim=gateup_dim,
            hidden_dim=hidden_dim,
            model_dim=model_dim,
            inter_dim=inter_dim,
            topk=topk_ids.shape[1],
            quant_type={
                QuantType.No: "no",
                QuantType.per_Token: "ptpc",
                QuantType.per_Tensor: "per_tensor",
                QuantType.per_1x128: "block",
                QuantType.per_128x128: "block",
            }[quant_type],
        )


def get_tune_space():
    architecture = get_gfx()
    prefill = [(256, 128), (128, 256), (128, 128)]
    configs = [
        Config(16, 16, 16, False),
        Config(16, 16, 16, False, use_batch1_algorithm=True),
        Config(16, 128, 64, False),
    ]
    block_decode = [
        Config(16, 16, 16, False, down_path="block_a16w8"),
        Config(
            16,
            16,
            16,
            False,
            down_path="block_a16w8",
            use_batch1_algorithm=True,
        ),
        Config(16, 64, 64, False, down_path="block_a16w8"),
        Config(16, 128, 64, False, down_path="block_a16w8"),
    ]
    if architecture == "gfx950":
        # Only the blockscale paths support gfx950.
        configs = list(block_decode)
        # Stage1 K rotation is independent of the Down path; tune both choices.
        configs.extend(
            Config(
                256,
                256,
                128,
                True,
                down_path=path,
                num_oc_splits=splits,
                k_rotate=k_rotate,
            )
            for path in ("block_m128", "block_m128_persistent")
            for splits in (1, 2, 4, 8)
            for k_rotate in (False, True)
        )
        configs.extend(
            Config(
                256,
                256,
                128,
                True,
                down_path="block_8wave",
                down_block_n=block_n,
                num_oc_splits=splits,
                k_rotate=k_rotate,
            )
            for block_n in (32, 64, 128)
            for splits in (1, 2, 4, 8)
            for k_rotate in (False, True)
        )
        return [config.to_string() for config in configs]
    if architecture == "gfx942":
        configs.extend(block_decode)
    configs.extend(Config(64, block_n, block_k, True) for block_n, block_k in prefill)
    configs.extend(
        Config(
            64, block_n, block_k, True, down_path=path, down_output_padding_bytes=128
        )
        for path in ("1x4_64x256", "8x1_compact")
        for block_n, block_k in prefill
    )
    return [config.to_string() for config in configs]


@cache
def _get_compiled_kernel(
    N,
    K,
    weight_dtype_str,
    quant_type_str,
    TOPK,
    BLOCK_TILE_SIZE_M,
    BLOCK_TILE_SIZE_N,
    stage,
    alg,
    E,
    act_quant_type_str=None,
    BLOCK_TILE_SIZE_K=None,
    activation_str="silu",
    swiglu_limit=None,
    down_path="default",
    down_output_padding_bytes=0,
    fused_down_clear=False,
):
    from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8 import compile_gemm

    return compile_gemm(
        N=N,
        K=K,
        weight_dtype=weight_dtype_str,
        weight_quant_type=quant_type_str,
        TOPK=TOPK,
        BLOCK_TILE_SIZE_M=BLOCK_TILE_SIZE_M,
        BLOCK_TILE_SIZE_N=BLOCK_TILE_SIZE_N,
        tile_k=BLOCK_TILE_SIZE_K,
        stage=stage,
        alg=alg,
        E=E,
        USE_ATOMIC_WRITE=True,
        act_quant_type=act_quant_type_str,
        activation=activation_str,
        swiglu_limit=swiglu_limit,
        down_path=down_path,
        down_output_padding_bytes=down_output_padding_bytes,
        fused_down_clear=fused_down_clear,
    )


def _launch(kernel_fn, *args):
    stream = torch.cuda.current_stream()
    prepared_args = [
        _ptr(arg) if isinstance(arg, torch.Tensor) else arg for arg in args
    ]
    _run_compiled(kernel_fn, *prepared_args, stream)


def _quant_per_tensor(x, scale=None, quant_dtype=torch.float8_e4m3fn, num_rows=None):
    assert scale is None
    assert num_rows is None

    amax = torch.zeros(1, dtype=torch.float32, device=x.device)
    xq = torch.empty_like(x, dtype=quant_dtype)
    flydsl_absmax()(x, amax)
    flydsl_quant_per_tensor(quant_dtype)(x, amax, xq)
    fmax = torch.finfo(quant_dtype).max
    xs = amax / fmax
    xs = xs.reshape(1).to(torch.float32)

    return xq, xs


def _empty_scale(device):
    return torch.empty(0, device=device)


def _gateup_output(hidden_states: torch.Tensor, problem: _Problem):
    return torch.empty(
        [problem.batch, problem.topk, problem.inter_dim],
        dtype=hidden_states.dtype,
        device=hidden_states.device,
    )


def _validate_blockscale_inputs(
    hidden_states, w1, w2, topk_weight, topk_ids, w1_scale, w2_scale, problem
):
    fp8_dtype = torch.float8_e4m3fn if get_gfx() == "gfx950" else torch.float8_e4m3fnuz
    if not (getattr(w1, "is_shuffled", False) and getattr(w2, "is_shuffled", False)):
        raise ValueError("blockscale requires shuffle_weight(16,16) for both weights")
    if (
        hidden_states.shape != (problem.batch, problem.hidden_dim)
        or w2.shape != (problem.experts, problem.model_dim, problem.inter_dim)
        or topk_ids.shape != (problem.batch, problem.topk)
        or topk_weight.shape != topk_ids.shape
    ):
        raise ValueError("blockscale input/weight/routing shape mismatch")
    for tensor, dtype in (
        (hidden_states, torch.bfloat16),
        (w1, fp8_dtype),
        (w2, fp8_dtype),
        (topk_weight, torch.float32),
        (topk_ids, torch.int32),
        (w1_scale, torch.float32),
        (w2_scale, torch.float32),
    ):
        if (
            tensor.dtype != dtype
            or not tensor.is_cuda
            or tensor.device != hidden_states.device
        ):
            raise ValueError(
                "blockscale tensors must have matching dtypes and GPU device"
            )
    for scale, channels, reduction in (
        (w1_scale, problem.gateup_dim, problem.hidden_dim),
        (w2_scale, problem.model_dim, problem.inter_dim),
    ):
        if scale.numel() != problem.experts * (channels // 128) * (reduction // 128):
            raise ValueError("blockscale weights require FP32 [E,N/128,K/128] scales")


def _run_blockscale_prefill(
    hidden_states,
    w1,
    w2,
    topk_weight,
    topk_ids,
    w1_scale,
    w2_scale,
    moe_sorting_dispatch_policy,
    config,
    problem,
):
    from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.a8w8_blockscale_gemm1 import (
        fp8_blockscale_stage1,
    )

    with torch.cuda.device(hidden_states.device):
        si, sw, se, valid, output = moe_sorting(
            topk_ids,
            topk_weight,
            problem.experts,
            problem.model_dim,
            torch.bfloat16,
            256,
            None,
            None,
            moe_sorting_dispatch_policy,
        )
        quantize = aiter.get_hip_quant(QuantType.per_1x128)
        gate_input, gate_scale = quantize(
            hidden_states, quant_dtype=w1.dtype, transpose_scale=True
        )
        mid = _gateup_output(hidden_states, problem)
        fp8_blockscale_stage1(
            gate_input,
            w1,
            gate_scale,
            w1_scale,
            si,
            se,
            valid,
            mid,
            k_rotate=config.k_rotate,
        )
        # transpose_scale=True already writes K-major scale bytes. Do not transpose again.
        down_input, down_scale = quantize(
            mid,
            quant_dtype=w2.dtype,
            num_rows_factor=problem.topk,
            transpose_scale=True,
        )
        weight_scale = w2_scale.view(
            problem.experts, problem.model_dim // 128, problem.inter_dim // 128
        )
        params = {
            "n": problem.model_dim,
            "k": problem.inter_dim,
            "topk": problem.topk,
            "num_experts": problem.experts,
            "num_oc_splits": config.num_oc_splits,
        }
        if config.down_path == "block_8wave":
            from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.moe_8wave_down import (
                flydsl_moe_gemm_8wave_down,
            )

            down = flydsl_moe_gemm_8wave_down(
                **params, block_m=256, block_n=config.down_block_n
            )
            routes = torch.empty(
                (problem.batch, problem.topk, problem.model_dim),
                dtype=output.dtype,
                device=output.device,
            )
            counter = torch.empty(1, dtype=torch.int32, device=output.device)
            # The launcher resets its caller-owned counter on every launch/replay.
            down(
                routes,
                down_input,
                w2,
                down_scale,
                weight_scale,
                si,
                sw,
                se,
                valid,
                counter,
            )
            torch.sum(routes, dim=1, out=output)
        else:
            from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.a8w8_blockscale_gemm2 import (
                M128_QUEUE_SIZE,
                make_m128_down,
            )
            from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.moe_packed_reduce import (
                make_moe_sum,
            )

            persistent = config.down_path == "block_m128_persistent"
            down = make_m128_down(
                **params, persistent=persistent, is_sorted_bm_256=True
            )
            routes = torch.empty(
                (se.numel() * 256, problem.model_dim),
                dtype=output.dtype,
                device=output.device,
            )
            counter = (
                torch.zeros(M128_QUEUE_SIZE, dtype=torch.int32, device=output.device)
                if persistent
                else torch.empty(1, dtype=torch.int32, device=output.device)
            )
            down(
                routes,
                down_input,
                w2,
                down_scale,
                weight_scale,
                si,
                sw,
                se,
                valid,
                counter,
            )
            # Unmasked native sorting contains every real (token, slot) once.
            inverse = torch.empty(
                (problem.batch, problem.topk), dtype=torch.int32, device=output.device
            )
            invert_sorted_ids(problem.topk)(
                si, inverse, valid, si.numel(), problem.batch
            )
            # Packed M128/N64 layout, even though the shared routing uses sort256.
            make_moe_sum(n=problem.model_dim, topk=problem.topk, sort_block_m=128)(
                output, routes, inverse
            )
    return output


def _run_prefill(
    hidden_states: torch.Tensor,
    w1: torch.Tensor,
    w2: torch.Tensor,
    topk_weight: torch.Tensor,
    topk_ids: torch.Tensor,
    quant_type: QuantType,
    w1_scale: torch.Tensor | None,
    w2_scale: torch.Tensor | None,
    expert_mask: Any,
    num_local_tokens: Any,
    moe_sorting_dispatch_policy: int,
    config: Config,
    problem: _Problem,
    activation_str: str,
    swiglu_limit: float | None,
):
    # Opus also returns each route's sorted row; merged repeated expert IDs get -1.
    (
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        _,
        _,
        loc_ids,
    ) = moe_sorting(
        topk_ids,
        topk_weight,
        problem.experts,
        problem.model_dim,
        hidden_states.dtype,
        config.BLOCK_M,
        expert_mask,
        num_local_tokens,
        moe_sorting_dispatch_policy,
        # sorted_sum writes every output row, so the sort need not clear one.
        accumulate=False,
        output_aux=AUX_SORT_OPUS,
    )
    cur_out = torch.empty(
        [problem.batch, problem.model_dim],
        dtype=hidden_states.dtype,
        device=hidden_states.device,
    )
    weight_dtype_str = "bf16" if w1.dtype == torch.bfloat16 else "fp8"
    act_quant_type_str = problem.quant_type
    quant_func = (
        aiter.get_hip_quant(aiter.QuantType.per_Token)
        if quant_type == QuantType.per_Token
        else _quant_per_tensor
    )

    if weight_dtype_str == "fp8":
        gateup_in, a_scale = quant_func(
            hidden_states,
            scale=None,
            quant_dtype=w1.dtype,
            num_rows=None,
        )
        a_scale = a_scale.to(torch.float32).contiguous()
    else:
        gateup_in = hidden_states
        a_scale = torch.empty(1, dtype=torch.float32, device=hidden_states.device)

    gemm1_out = _gateup_output(hidden_states, problem)
    if quant_type == QuantType.per_Tensor:
        # Gate/Up skips routes sorting drops, but the Down absmax reads every row.
        gemm1_out.zero_()
    gateup_kernel = _get_compiled_kernel(
        N=problem.gateup_dim,
        K=problem.hidden_dim,
        weight_dtype_str=weight_dtype_str,
        quant_type_str=problem.quant_type,
        TOPK=problem.topk,
        BLOCK_TILE_SIZE_M=config.BLOCK_M,
        BLOCK_TILE_SIZE_N=config.BLOCK_N,
        BLOCK_TILE_SIZE_K=config.BLOCK_K,
        stage="gateup",
        alg="prefill_1x4",
        E=problem.experts,
        act_quant_type_str=act_quant_type_str,
        activation_str=activation_str,
        swiglu_limit=swiglu_limit,
    )
    task_num = int(sorted_expert_ids.shape[0])
    _launch(
        gateup_kernel,
        gateup_in,
        w1,
        gemm1_out,
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        w1_scale if w1_scale is not None else _empty_scale(hidden_states.device),
        a_scale,
        problem.batch,
        task_num,
    )

    if weight_dtype_str == "fp8":
        down_in, down_in_scale = quant_func(
            gemm1_out.view(problem.batch * problem.topk, -1),
            scale=None,
            quant_dtype=w2.dtype,
            num_rows=None,
        )
    else:
        down_in = gemm1_out
        down_in_scale = torch.empty(1, dtype=torch.float32, device=hidden_states.device)

    output_row_size = (
        problem.model_dim
        + config.down_output_padding_bytes // hidden_states.element_size()
    )
    gemm2_out = torch.empty(
        [sorted_expert_ids.shape[0] * config.BLOCK_M, output_row_size],
        dtype=hidden_states.dtype,
        device=hidden_states.device,
    )
    down_kernel = _get_compiled_kernel(
        N=problem.model_dim,
        K=problem.inter_dim,
        weight_dtype_str=weight_dtype_str,
        quant_type_str=problem.quant_type,
        TOPK=problem.topk,
        BLOCK_TILE_SIZE_M=config.BLOCK_M,
        BLOCK_TILE_SIZE_N=128,
        stage="down",
        alg="prefill_1x4",
        E=problem.experts,
        act_quant_type_str=act_quant_type_str,
        down_path=config.down_path,
        down_output_padding_bytes=config.down_output_padding_bytes,
    )
    down_args = (
        down_in,
        w2,
        gemm2_out,
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        w2_scale if w2_scale is not None else _empty_scale(hidden_states.device),
        down_in_scale,
        problem.batch,
        task_num,
    )
    if config.down_path == "8x1_compact":
        from aiter.ops.flydsl.kernels.moe_gemm_2stage.gfx9_fp8.gemm2_8x1_compact import (
            allocate_task_buffers,
        )

        # The split policy and its buffer capacities must use the same CU count.
        cu_count = get_cu_num()
        full_tasks, tail_tasks, counts = allocate_task_buffers(
            sorted_expert_ids, problem.experts, cu_count
        )
        _launch(
            down_kernel,
            *down_args,
            full_tasks,
            tail_tasks,
            counts,
            full_tasks.shape[0],
            tail_tasks.shape[0],
            cu_count,
        )
    else:
        _launch(down_kernel, *down_args)

    sorted_sum(problem.topk, problem.model_dim, config.down_output_padding_bytes)(
        loc_ids, gemm2_out, cur_out, problem.batch
    )
    return cur_out


def _run_batch1(
    hidden_states: torch.Tensor,
    w1: torch.Tensor,
    w2: torch.Tensor,
    topk_weight: torch.Tensor,
    topk_ids: torch.Tensor,
    w1_scale: torch.Tensor | None,
    w2_scale: torch.Tensor | None,
    problem: _Problem,
    activation_str: str,
    swiglu_limit: float | None,
):
    topk_weight = (
        topk_weight if topk_weight.dtype == torch.float32 else topk_weight.float()
    )
    gemm1_out = _gateup_output(hidden_states, problem)
    # Gate/Up zeroes the output itself when the output row matches its input row.
    fused_down_clear = problem.model_dim == problem.hidden_dim
    allocate_output = torch.empty if fused_down_clear else torch.zeros
    cur_out = allocate_output(
        [problem.batch, problem.model_dim],
        dtype=hidden_states.dtype,
        device=hidden_states.device,
    )
    route_count = problem.batch * problem.topk
    weight_dtype_str = "bf16" if w1.dtype == torch.bfloat16 else "fp8"
    gateup_kernel = _get_compiled_kernel(
        N=problem.gateup_dim,
        K=problem.hidden_dim,
        weight_dtype_str=weight_dtype_str,
        quant_type_str=problem.quant_type,
        TOPK=problem.topk,
        BLOCK_TILE_SIZE_M=16,
        BLOCK_TILE_SIZE_N=32,
        stage="gateup",
        alg="batch1",
        E=None,
        activation_str=activation_str,
        swiglu_limit=swiglu_limit,
        fused_down_clear=fused_down_clear,
    )
    _launch(
        gateup_kernel,
        hidden_states,
        w1,
        gemm1_out,
        topk_ids,
        cur_out,
        w1_scale if w1_scale is not None else _empty_scale(hidden_states.device),
        route_count,
    )

    down_kernel = _get_compiled_kernel(
        N=problem.model_dim,
        K=problem.inter_dim,
        weight_dtype_str=weight_dtype_str,
        quant_type_str=problem.quant_type,
        TOPK=problem.topk,
        BLOCK_TILE_SIZE_M=16,
        BLOCK_TILE_SIZE_N=64,
        stage="down",
        alg="batch1",
        E=None,
    )
    _launch(
        down_kernel,
        gemm1_out,
        w2,
        cur_out,
        topk_ids,
        topk_weight,
        w2_scale if w2_scale is not None else _empty_scale(hidden_states.device),
        route_count,
    )
    return cur_out


def _run_decode(
    hidden_states: torch.Tensor,
    w1: torch.Tensor,
    w2: torch.Tensor,
    topk_weight: torch.Tensor,
    topk_ids: torch.Tensor,
    w1_scale: torch.Tensor | None,
    w2_scale: torch.Tensor | None,
    expert_mask: Any,
    num_local_tokens: Any,
    moe_sorting_dispatch_policy: int,
    config: Config,
    problem: _Problem,
    activation_str: str,
    swiglu_limit: float | None,
):
    sorted_ids, sorted_weights, sorted_expert_ids, num_valid_ids, cur_out = moe_sorting(
        topk_ids,
        topk_weight,
        problem.experts,
        problem.model_dim,
        hidden_states.dtype,
        config.BLOCK_M,
        expert_mask,
        num_local_tokens,
        moe_sorting_dispatch_policy,
    )
    grid = int(sorted_expert_ids.shape[0])
    if problem.batch * problem.topk <= problem.experts:
        grid = problem.batch * problem.topk

    block_n = 64 if config.BLOCK_N == 16 else config.BLOCK_N
    gemm1_out = _gateup_output(hidden_states, problem)
    weight_dtype_str = "bf16" if w1.dtype == torch.bfloat16 else "fp8"
    gateup_kernel = _get_compiled_kernel(
        N=problem.gateup_dim,
        K=problem.hidden_dim,
        weight_dtype_str=weight_dtype_str,
        quant_type_str=problem.quant_type,
        TOPK=problem.topk,
        BLOCK_TILE_SIZE_M=config.BLOCK_M,
        BLOCK_TILE_SIZE_N=block_n,
        stage="gateup",
        alg="splitk",
        E=problem.experts,
        activation_str=activation_str,
        swiglu_limit=swiglu_limit,
    )
    _launch(
        gateup_kernel,
        hidden_states,
        w1,
        gemm1_out,
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        w1_scale if w1_scale is not None else _empty_scale(hidden_states.device),
        problem.batch,
        grid,
    )

    down_kernel = _get_compiled_kernel(
        N=problem.model_dim,
        K=problem.inter_dim,
        weight_dtype_str=weight_dtype_str,
        quant_type_str=problem.quant_type,
        TOPK=problem.topk,
        BLOCK_TILE_SIZE_M=config.BLOCK_M,
        BLOCK_TILE_SIZE_N=block_n,
        stage="down",
        alg="splitk",
        E=problem.experts,
    )
    _launch(
        down_kernel,
        gemm1_out,
        w2,
        cur_out,
        sorted_ids,
        sorted_weights,
        sorted_expert_ids,
        num_valid_ids,
        w2_scale if w2_scale is not None else _empty_scale(hidden_states.device),
        problem.batch,
        grid,
    )
    return cur_out


def run_flydsl_moe_gfx942(
    hidden_states: torch.Tensor,
    w1: torch.Tensor,
    w2: torch.Tensor,
    topk_weight: torch.Tensor,
    topk_ids: torch.Tensor,
    activation: ActivationType,
    quant_type: QuantType,
    w1_scale: torch.Tensor | None,
    w2_scale: torch.Tensor | None,
    expert_mask: Any,
    num_local_tokens: Any,
    moe_sorting_dispatch_policy: int,
    config_string: str,
    swiglu_limit: float | None = None,
) -> torch.Tensor:
    architecture = get_gfx()
    if quant_type == QuantType.per_128x128:
        quant_type = QuantType.per_1x128
    if num_local_tokens is not None:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support num_local_tokens"
        )
    for name, tensor in (
        ("hidden_states", hidden_states),
        ("w1", w1),
        ("w2", w2),
        ("topk_weight", topk_weight),
        ("topk_ids", topk_ids),
        ("w1_scale", w1_scale),
        ("w2_scale", w2_scale),
    ):
        if tensor is not None and not tensor.is_contiguous():
            raise NotImplementedError(
                f"gfx942 FlyDSL whole-graph backend requires contiguous {name}"
            )
    config = Config.from_string(config_string)
    if architecture not in ("gfx942", "gfx950"):
        raise NotImplementedError(
            f"Unsupported FlyDSL MoE architecture: {architecture}"
        )
    if config.is_blockscale_prefill and architecture != "gfx950":
        raise NotImplementedError("FP8 blockscale prefill requires gfx950")
    if (
        architecture == "gfx950"
        and not config.is_blockscale_prefill
        and not config.is_blockscale_decode
    ):
        raise NotImplementedError(
            "This FlyDSL backend supports only blockscale configs on gfx950"
        )
    fp8_dtype = (
        torch.float8_e4m3fn if architecture == "gfx950" else torch.float8_e4m3fnuz
    )
    is_bf16 = (
        w1.dtype == torch.bfloat16
        and w2.dtype == torch.bfloat16
        and quant_type == QuantType.No
    )
    is_fp8 = (
        w1.dtype == fp8_dtype
        and w2.dtype == fp8_dtype
        and quant_type
        in (QuantType.per_Token, QuantType.per_Tensor, QuantType.per_1x128)
    )
    if (
        hidden_states.dtype != torch.bfloat16
        or expert_mask is not None
        or activation not in (ActivationType.Silu, ActivationType.Swiglu)
        or not (is_bf16 or is_fp8)
    ):
        raise RuntimeError("Unsupported input for the gfx942 FlyDSL MoE backend")
    if is_fp8 and (w1_scale is None or w2_scale is None):
        raise ValueError("FP8 weights require both w1_scale and w2_scale")
    if is_bf16 and (w1_scale is not None or w2_scale is not None):
        raise NotImplementedError("BF16 weights do not support weight scales")

    if config.is_blockscale_prefill or config.is_blockscale_decode:
        if activation != ActivationType.Silu or swiglu_limit:
            raise NotImplementedError(
                "blockscale Gate/Up supports SiLU without clamp only"
            )
        if (
            hidden_states.ndim != 2
            or w1.ndim != 3
            or w2.ndim != 3
            or topk_ids.ndim != 2
        ):
            raise ValueError(
                "blockscale expects input[M,H], weights[E,N,K], routing[M,topk]"
            )
    activation_str = "swiglu" if activation == ActivationType.Swiglu else "silu"
    problem = _Problem.from_inputs(hidden_states, w1, w2, topk_ids, quant_type)
    unsupported_reason = config.unsupported_reason(problem)
    if unsupported_reason is not None:
        raise RuntimeError(
            f"Unsupported gfx942 FlyDSL MoE config {config_string!r}: "
            f"{unsupported_reason}"
        )
    if config.is_blockscale_prefill or config.is_blockscale_decode:
        _validate_blockscale_inputs(
            hidden_states, w1, w2, topk_weight, topk_ids, w1_scale, w2_scale, problem
        )
    if config.is_blockscale_prefill:
        return _run_blockscale_prefill(
            hidden_states,
            w1,
            w2,
            topk_weight,
            topk_ids,
            w1_scale,
            w2_scale,
            moe_sorting_dispatch_policy,
            config,
            problem,
        )
    if config.use_prefill:
        return _run_prefill(
            hidden_states,
            w1,
            w2,
            topk_weight,
            topk_ids,
            quant_type,
            w1_scale,
            w2_scale,
            expert_mask,
            num_local_tokens,
            moe_sorting_dispatch_policy,
            config,
            problem,
            activation_str,
            swiglu_limit,
        )
    if problem.batch == 1 or config.use_batch1_algorithm:
        return _run_batch1(
            hidden_states,
            w1,
            w2,
            topk_weight,
            topk_ids,
            w1_scale,
            w2_scale,
            problem,
            activation_str,
            swiglu_limit,
        )
    if 2 <= problem.batch <= 256:
        return _run_decode(
            hidden_states,
            w1,
            w2,
            topk_weight,
            topk_ids,
            w1_scale,
            w2_scale,
            expert_mask,
            num_local_tokens,
            moe_sorting_dispatch_policy,
            config,
            problem,
            activation_str,
            swiglu_limit,
        )
    raise RuntimeError(f"Unsupported batch-size {problem.batch}")


def run_flydsl_moe_gfx942_impl(
    request: FusedMoeRequest,
    config_string: str,
) -> torch.Tensor:
    config = Config.from_string(config_string)
    architecture = get_gfx()
    if architecture not in ("gfx942", "gfx950"):
        raise NotImplementedError(
            f"Unsupported FlyDSL MoE architecture: {architecture}"
        )
    if config.is_blockscale_prefill and architecture != "gfx950":
        raise NotImplementedError("FP8 blockscale prefill requires gfx950")
    if not (
        getattr(request.w1, "is_shuffled", False)
        and getattr(request.w2, "is_shuffled", False)
    ):
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend requires preshuffled weights"
        )
    if request.bias1 is not None or request.bias2 is not None:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support per-expert bias"
        )
    if request.doweight_stage1:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support doweight_stage1=True"
        )
    if request.a1_scale is not None or request.a2_scale is not None:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support prequantized activations"
        )
    if request.hidden_pad or request.intermediate_pad:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support hidden/intermediate padding"
        )
    if request.gate_mode not in (None, "separated"):
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend only supports separated gate weights"
        )
    if request.dtype not in (None, request.hidden_states.dtype):
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support output dtype conversion"
        )
    if request.block_size_m not in (None, config.BLOCK_M):
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support overriding block_size_m"
        )
    if request.ksplit != 0:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph backend does not support split-K"
        )
    fp8_dtype = (
        torch.float8_e4m3fn if architecture == "gfx950" else torch.float8_e4m3fnuz
    )
    quant_dtype = torch.bfloat16 if request.w1.dtype == torch.bfloat16 else fp8_dtype
    # block_a16w8 keeps BF16 activations, so it also accepts BF16 activation configs.
    supported_q_dtypes_a = (
        (None, quant_dtype, torch.bfloat16)
        if config.is_blockscale_decode
        else (None, quant_dtype)
    )
    if request.q_dtype_a not in supported_q_dtypes_a:
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph activation dtype must match the weight mode"
        )
    if request.q_dtype_w not in (None, quant_dtype):
        raise NotImplementedError(
            "gfx942 FlyDSL whole-graph weight dtype must match the weight mode"
        )
    return run_flydsl_moe_gfx942(
        request.hidden_states,
        request.w1,
        request.w2,
        request.topk_weight,
        request.topk_ids,
        request.activation,
        request.quant_type,
        request.w1_scale,
        request.w2_scale,
        request.expert_mask,
        request.num_local_tokens,
        request.moe_sorting_dispatch_policy,
        config.to_string(),
        request.swiglu_limit,
    )

# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Pure scalar checks shared by the blockscale dispatch gate and kernel wrappers.

No Torch, Aiter, FlyDSL compiler or device initialization is needed here.
"""

# chip_info.get_lds_capacity_bytes("gfx950"); kept local so this module stays pure.
GFX950_LDS_BYTES = 160 * 1024


def m128_down_lds_bytes(*, n, k, topk, num_experts, persistent, num_oc_splits):
    if not isinstance(num_oc_splits, int) or num_oc_splits <= 0:
        raise ValueError("num_oc_splits must be a positive integer")
    if k != 256:
        raise ValueError("M128 Down supports K=256 only")
    if n <= 0 or n % (num_oc_splits * 128) or not 0 < topk <= min(num_experts, 255):
        raise ValueError(
            "M128 requires N divisible by num_oc_splits*128 and valid TOPK"
        )
    n_split = n // num_oc_splits
    scale_words = (n_split // 128 * 2 + 63 + 255) // 256 * 256
    arena_words = scale_words + 4 * 4096 + 128 + 128 * 3 + 2 + int(persistent)
    lds_bytes = arena_words * 4
    if lds_bytes > GFX950_LDS_BYTES:
        raise ValueError(
            f"M128 Down needs {lds_bytes} LDS bytes, exceeding gfx950's "
            f"{GFX950_LDS_BYTES}"
        )
    return lds_bytes


def routed_down_lds_bytes(*, n, k, topk, num_experts, block_m, block_n, num_oc_splits):
    if not isinstance(k, int) or k <= 0 or k % 128:
        raise ValueError("8-wave Down requires K to be a positive multiple of 128")
    if block_m != 256 or block_n not in (32, 64, 128):
        raise ValueError("8-wave Down requires M256 and N32/N64/N128 tiles")
    if not isinstance(num_oc_splits, int) or num_oc_splits <= 0:
        raise ValueError("num_oc_splits must be a positive integer")
    if n <= 0 or n % (num_oc_splits * 128) or n // num_oc_splits < 3 * block_n:
        raise ValueError(
            "8-wave Down requires N divisible by num_oc_splits*128 and at least "
            "3 N tiles per split"
        )
    if not 0 < topk <= min(num_experts, 255):
        raise ValueError("8-wave Down requires 0 < TOPK <= min(num_experts,255)")
    scale_bytes = n // num_oc_splits // 128 * (k // 128) * 4
    lds_bytes = 4 * block_n * k + block_m * 8 + (scale_bytes + 15) // 16 * 16
    if lds_bytes > GFX950_LDS_BYTES:
        raise ValueError(
            f"8-wave Down needs {lds_bytes} LDS bytes, exceeding gfx950's "
            f"{GFX950_LDS_BYTES}"
        )
    return lds_bytes


def prefill_buffer_reason(
    *, tokens, hidden, inter, model_dim, topk, num_experts, routed, num_oc_splits
):
    """Name the buffers whose byte offsets exceed the kernels' 32-bit limits.

    Sizes follow native sort256 capacity. The kernel wrappers still check the
    actual tensors; this lets dispatch and tuning skip a shape up front.
    """
    rows = tokens * topk
    blocks = (rows + num_experts * 256 - topk + 255) // 256
    capacity = blocks * 256
    n_split = model_dim // num_oc_splits
    limit = 1 << 32
    extents = [
        ("GateUp input", tokens * hidden, limit),
        ("GateUp input scales", tokens * (hidden // 128) * 4, limit),
        ("Gate/Up weight per expert", 2 * inter * hidden, limit),
        ("GateUp output", rows * inter * 2, limit),
        # GateUp addresses the sorting metadata with 31-bit byte offsets.
        ("sorted IDs", capacity * 4, 1 << 31),
        ("Down input", (rows + 1) * inter, limit),
        ("Down input scales", rows * (inter // 128) * 4, limit),
        (
            "Down weight scales",
            num_experts * (model_dim // 128) * (inter // 128) * 4,
            limit,
        ),
        ("Down weight per OC split", n_split * inter, limit),
    ]
    if routed:
        extents += [
            ("routed Down output", (rows + 1) * model_dim * 2, limit),
            ("Down task counter", blocks * num_oc_splits + 256, 1 << 31),
        ]
    else:
        extents += [
            ("packed Down output", (capacity * model_dim + 128 * n_split) * 2, limit),
            ("reduced output", tokens * model_dim * 2, limit),
        ]
    over = [name for name, size, bound in extents if size >= bound]
    if over:
        return "blockscale prefill exceeds 32-bit buffer offsets: " + ", ".join(over)
    return None

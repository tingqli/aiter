# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.

"""MegaMoEGfx942: the EP8 a8w4 MegaMoE layer for gfx942 (MI300X), shaped like MegaMoEV2.

Prototype: the kernels still come from pyhip (``pyhip.contrib.flydsl.a8w4.megamoe``) and
move into this package in later PRs. The paths match MegaMoEV2's:

- main (``forward``): ``MegaMoeEpA8W4``, a count exchange plus one persistent kernel;
- small (``forward_small_m``): ``MegaMoeSmallEpA8W4``, one kernel per call;
- large (``forward`` once enabled): ``MegaMoeLargeEpA8W4``, one kernel per call.

Small and large spin on their peers inside the kernel, so they need the whole GPU while
they run: nothing may run on another stream at the same time. Every rank makes the same
calls in the same order, as with MegaMoEV2.

Weights: the standard aiter a16w4 preshuffle (``shuffle_weight_a16w4(w, 16, False)``,
``shuffle_scale_a16w4``), converted once per layer by ``prepare_weights`` into pyhip's fd2
form. The per-channel exponents ride at the tail of each scale tensor, so a layer is still
``(w1, w1_scale, w2, w2_scale)``.
"""

from contextlib import nullcontext

import torch

from ..mega_moe import envs

_EP, _MODEL_DIM, _INTER_DIM, _EXPERTS, _NUM_CU = 8, 4096, 2048, 256, 304
# The main and large kernels split a route id with shifts, so they need a power-of-two
# top-k: other top-k values are padded with no-route slots.
_KERNEL_TOPK = 8


def eligible(
    *, world_size, model_dim, inter_dim, experts, topk, quant="a8w4", act="silu"
):
    """Whether this build runs the layer: gfx942 with 304 CUs, EP8 and the MoE shape of
    DeepSeek-V4-Flash (top-6) or MiMo-V2.6-Flash (top-8)."""
    from aiter.jit.utils.chip_info import get_cu_num, get_gfx_runtime

    return (
        get_gfx_runtime() == "gfx942"
        and get_cu_num() == _NUM_CU
        and (world_size, model_dim, inter_dim, experts)
        == (_EP, _MODEL_DIM, _INTER_DIM, _EXPERTS)
        and topk in (6, 8)
        and quant == "a8w4"
        and act == "silu"
    )


def _tail_exp(w, scale):
    """The int32 [E, N] per-channel exponents at the tail of an fd2 scale tensor."""
    experts, channels = w.shape[:2]
    tail = experts * channels * 4
    return scale.view(torch.uint8)[-tail:].view(torch.int32).view(experts, channels)


def _on(stream):
    return torch.cuda.stream(stream) if stream is not None else nullcontext()


class MegaMoEGfx942:
    """One rank's EP8 a8w4 MoE layer. Construction is collective: every rank builds the
    same instances in the same order after MORI shmem is initialized."""

    def __init__(
        self,
        *,
        rank,
        world_size,
        model_dim,
        inter_dim,
        experts,
        topk,
        w1,
        w1_scale,
        w2,
        w2_scale,
        max_tok_per_rank,
        quant="a8w4",
        act="silu",
        swiglu_limit=0.0,
        small_m_mtprs=(128,),
        small_m_enabled=None,
        large_m_enabled=None,
        x_quant="per_1x128",
    ):
        if not eligible(
            world_size=world_size,
            model_dim=model_dim,
            inter_dim=inter_dim,
            experts=experts,
            topk=topk,
            quant=quant,
            act=act,
        ):
            raise ValueError(
                "MegaMoEGfx942 runs gfx942 (304 CUs), EP8, H 4096, I 2048, 256 experts, "
                f"top-6 / top-8, a8w4 silu; got world_size={world_size} "
                f"model_dim={model_dim} inter_dim={inter_dim} experts={experts} "
                f"topk={topk} quant={quant} act={act}"
            )
        from pyhip.contrib.flydsl.a8w4.megamoe import (
            MegaMoeEpA8W4,
            MegaMoeLargeEpA8W4,
            MegaMoeSmallEpA8W4,
        )

        self.rank, self.experts, self.topk = int(rank), int(experts), int(topk)
        self.mtpr = int(max_tok_per_rank)
        self._x_quant = x_quant
        limit = float(swiglu_limit)
        # As MegaMoEV2: a limit <= 0 means no clamp.
        self._act = "silu_clamp" if limit > 0 else "silu"
        self._situ = {"swiglu_limit": limit} if limit > 0 else None
        self._weights = {}
        self._W = self._weight_dict(w1, w1_scale, w2, w2_scale)

        self._main = MegaMoeEpA8W4(
            self._W,
            rank=self.rank,
            max_tokens=self.mtpr,
            topk=_KERNEL_TOPK,
            act=self._act,
            situ=self._situ,
            x_quant=x_quant,
        )
        if small_m_enabled is None:
            small_m_enabled = envs.AITER_MEGA_SMALL_M
        self._small, self._small_mtpr = None, 0
        if small_m_enabled:
            (mtpr,) = small_m_mtprs
            self._small = MegaMoeSmallEpA8W4(
                self._W, rank=self.rank, tmax=world_size * int(mtpr), topk=self.topk
            )
            self._small_mtpr = int(mtpr)
        if large_m_enabled is None:
            large_m_enabled = envs.AITER_MEGA_LARGE_M
        self._large = None
        if large_m_enabled:
            self._large = MegaMoeLargeEpA8W4(
                self._W, rank=self.rank, max_tokens=self.mtpr, topk=_KERNEL_TOPK
            )
        self._large_on = self._large is not None

    @staticmethod
    def prepare_weights(w1, w1_scale, w2, w2_scale, *, w1_gate_up_interleaved=False):
        """One layer's local experts in the standard aiter a16w4 preshuffle ->
        ``(w1, w1_scale, w2, w2_scale)`` in fd2 form. Load time, once per layer."""
        if w1_gate_up_interleaved:
            raise NotImplementedError(
                "MegaMoEGfx942 takes w1 shuffled with gate_up=False for now"
            )
        from pyhip.contrib.flydsl.a8w4 import prepare_weights

        W = prepare_weights(w1, w2, w1_scale, w2_scale)
        # w2_exp already sits at the tail of w2_scale; give w1_exp the same place.
        w1_tail = W["w1_exp"].contiguous().view(-1).view(torch.uint8)
        return W["w1"], torch.cat([W["w1_scale"], w1_tail]), W["w2"], W["w2_scale"]

    def _weight_dict(self, w1, w1_scale, w2, w2_scale):
        key = (w1.data_ptr(), w1_scale.data_ptr(), w2.data_ptr(), w2_scale.data_ptr())
        W = self._weights.get(key)
        if W is None:
            W = dict(
                w1=w1,
                w1_scale=w1_scale,
                w1_exp=_tail_exp(w1, w1_scale),
                w2=w2,
                w2_scale=w2_scale,
                w2_exp=_tail_exp(w2, w2_scale),
            )
            self._weights[key] = W
        return W

    def bind_weights(self, w1, w1_scale, w2, w2_scale):
        self._W = self._weight_dict(w1, w1_scale, w2, w2_scale)
        self._main.W = self._W

    def bind_layer(self, layer_slot, w1, w1_scale, w2, w2_scale):
        self.bind_weights(w1, w1_scale, w2, w2_scale)

    def select_layer_state(self, layer_slot):
        """No per-layer protocol state on gfx942."""

    def preload_aot_bundles(self):
        """No AOT bundles yet: the kernels compile on the first call."""

    @property
    def small_m_mtpr(self):
        """Largest per-rank token count ``forward_small_m`` accepts (0 when disabled)."""
        return self._small_mtpr

    @property
    def large_m_available(self):
        return self._large is not None

    def set_large_m_enabled(self, enabled):
        if enabled and self._large is None:
            raise RuntimeError(
                "the large-input path is not available (set AITER_MEGA_LARGE_M=1)"
            )
        self._large_on = bool(enabled)

    def _routes(self, topk_ids, wts, slots):
        # Out-of-range ids are no routes, as in MegaMoEV2 (sglang marks padding rows with
        # id == experts); the kernels skip negative ids only.
        ids = topk_ids.masked_fill(topk_ids >= self.experts, -1)
        pad = slots - ids.shape[1]
        if pad:
            ids = torch.cat([ids, ids.new_full((ids.shape[0], pad), -1)], dim=1)
            wts = torch.cat([wts, wts.new_zeros((wts.shape[0], pad))], dim=1)
        return ids, wts

    def forward(
        self,
        x_bf16,
        wts,
        topk_ids,
        *,
        stream=None,
        slice_output=True,
        mask_invalid_slots=None,
    ):
        """x bf16 [T, H], wts f32 [T, topk], topk_ids int32 [T, topk]. Returns bf16
        [T, H], a view of an internal buffer that the next call overwrites. Invalid ids
        are always skipped, so ``mask_invalid_slots`` has no effect; the output is always
        sliced to T rows."""
        with _on(stream):
            ids, w = self._routes(topk_ids, wts, _KERNEL_TOPK)
            if self._large_on:
                return self._large(
                    x_bf16,
                    ids,
                    w,
                    W=self._W,
                    act=self._act,
                    situ=self._situ,
                    x_quant=self._x_quant,
                )
            return self._main(x_bf16, ids, w)

    __call__ = forward

    def forward_small_m(
        self, x_bf16, wts, topk_ids, *, max_tokens, stream=None, slice_output=True
    ):
        """The small-input single kernel. ``max_tokens``: the most rows of this call on any
        EP rank, the same on every rank."""
        if self._small is None:
            raise RuntimeError(
                "small-input path is not enabled (set AITER_MEGA_SMALL_M=1)"
            )
        need = int(max_tokens)
        if need < int(x_bf16.shape[0]) or need > self._small_mtpr:
            raise ValueError(
                f"max_tokens={need}: this rank has {int(x_bf16.shape[0])} rows, the "
                f"small-input path takes at most {self._small_mtpr}"
            )
        with _on(stream):
            ids, w = self._routes(topk_ids, wts, self.topk)
            return self._small(
                x_bf16,
                ids,
                w,
                W=self._W,
                act=self._act,
                situ=self._situ,
                x_quant=self._x_quant,
            )

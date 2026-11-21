# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.

"""MegaMoEGfx942: the EP8 a8w4 MegaMoE layer for gfx942 (MI300X), shaped like MegaMoEV2.

The paths match MegaMoEV2's:

- main (``forward``, ``forward_prequant``): five kernels per call. ``comm.py``
  quantizes x, exchanges the route counts and plans every route's destination row;
  ``main.py`` is one persistent kernel that writes each route's row into its
  destination, runs gemm1 / gemm2 on the rows as they arrive and adds every route into
  its source rank's output (BF16 atomics); ``comm.py`` then waits until all ranks'
  adds are done. Its tasks only wait for work that is already running, so it needs no
  co-residency.
- small (``forward_small_m``, ``small_m.py``) and large (``forward`` once enabled,
  ``large_m.py``): one kernel per call each. They spin on their peers inside the
  kernel, so they need the whole GPU: nothing may run on another stream at the same
  time.

Every rank builds the same instances in the same order (after MORI shmem is
initialized) and makes the same calls in the same order, as with MegaMoEV2. Each rank
receives at most every route of every rank (8 x max_tok_per_rank x topk rows plus one
partial block per expert), so no route is dropped.

Weights: the standard aiter a16w4 preshuffle (``shuffle_weight_a16w4(w, 16, False)``,
``shuffle_scale_a16w4``), converted once per layer by ``prepare_weights`` into the fd2
form; the per-channel exponents ride at the tail of each scale tensor, so a layer is
still ``(w1, w1_scale, w2, w2_scale)``.
"""

from contextlib import nullcontext

import torch

from ..mega_moe import envs
from . import host
from . import weights as _weights

_EP, _MODEL_DIM, _INTER_DIM, _EXPERTS, _TOPK, _NUM_CU = 8, 4096, 2048, 256, 6, 304
# The main and large kernels split a route id with shifts, so they need a power-of-two
# top-k: other top-k values are padded with no-route slots.
_KERNEL_TOPK = 8
# main kernel: producer workgroups; gemm2 trails gemm1 by this many block pairs
_PRODUCERS, _LAG = 16, 2


def eligible(
    *, world_size, model_dim, inter_dim, experts, topk, quant="a8w4", act="silu"
):
    """Whether this build runs the layer: gfx942 with 304 CUs, EP8 and the MoE shape of
    DeepSeek-V4-Flash (H 4096, I 2048, 256 experts, top-6)."""
    from aiter.jit.utils.chip_info import get_cu_num, get_gfx_runtime

    return (
        get_gfx_runtime() == "gfx942"
        and get_cu_num() == _NUM_CU
        and (world_size, model_dim, inter_dim, experts, topk)
        == (_EP, _MODEL_DIM, _INTER_DIM, _EXPERTS, _TOPK)
        and quant == "a8w4"
        and act == "silu"
    )


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
                f"top-6, a8w4 silu; got world_size={world_size} "
                f"model_dim={model_dim} inter_dim={inter_dim} experts={experts} "
                f"topk={topk} quant={quant} act={act}"
            )
        if max_tok_per_rank <= 0:
            raise ValueError(f"max_tok_per_rank={max_tok_per_rank} must be positive")
        from .protocol import qx_of

        self.rank, self.world_size = int(rank), int(world_size)
        self.model_dim, self.inter_dim = int(model_dim), int(inter_dim)
        self.experts, self.topk = int(experts), int(topk)
        self.mtpr = int(max_tok_per_rank)
        self.dev = torch.device("cuda", torch.cuda.current_device())
        limit = float(swiglu_limit)
        # As MegaMoEV2: a limit <= 0 means no clamp.
        self._act = "silu_clamped" if limit > 0 else "silu"
        # The kernels' activation scalars, aiter act.situ_params order (beta, 1 / beta,
        # linear_beta, 1 / linear_beta, swiglu_limit): silu_clamped reads the limit.
        self._situ = (1.0, 1.0, 1.0, 1.0, limit if limit > 0 else float("inf"))
        self._x_quant, self._qx = x_quant, qx_of(x_quant)
        self._weights = {}
        self._W = self._weight_dict(w1, w1_scale, w2, w2_scale)
        self._build_main()
        if small_m_enabled is None:
            small_m_enabled = envs.AITER_MEGA_SMALL_M
        self._build_small(small_m_enabled, max(int(m) for m in small_m_mtprs))
        if large_m_enabled is None:
            large_m_enabled = envs.AITER_MEGA_LARGE_M
        self._build_large(large_m_enabled)
        self._large_on = self._large is not None

    # ---- weights ---------------------------------------------------------------

    @staticmethod
    def prepare_weights(w1, w1_scale, w2, w2_scale, *, w1_gate_up_interleaved=False):
        """One layer's local experts in the standard aiter a16w4 preshuffle ->
        ``(w1, w1_scale, w2, w2_scale)`` in fd2 form. Load time, once per layer."""
        if w1_gate_up_interleaved:
            raise NotImplementedError(
                "MegaMoEGfx942 takes w1 shuffled with gate_up=False for now"
            )
        return _weights.prepare_weights(w1, w1_scale, w2, w2_scale)

    def _weight_dict(self, w1, w1_scale, w2, w2_scale):
        key = (w1.data_ptr(), w1_scale.data_ptr(), w2.data_ptr(), w2_scale.data_ptr())
        W = self._weights.get(key)
        if W is None:
            W = {
                "w1": w1,
                "w1_scale": w1_scale,
                "w1_exp": _weights.tail_exp(w1, w1_scale),
                "w2": w2,
                "w2_scale": w2_scale,
                "w2_exp": _weights.tail_exp(w2, w2_scale),
            }
            self._weights[key] = W
        return W

    def bind_weights(self, w1, w1_scale, w2, w2_scale):
        self._W = self._weight_dict(w1, w1_scale, w2, w2_scale)

    def bind_layer(self, layer_slot, w1, w1_scale, w2, w2_scale):
        self.bind_weights(w1, w1_scale, w2, w2_scale)

    def select_layer_state(self, layer_slot):
        """No per-layer protocol state on gfx942."""

    def preload_aot_bundles(self):
        """No AOT bundles yet: the kernels compile on the first call."""

    # ---- main path ---------------------------------------------------------------

    def _build_main(self):
        import mori.shmem as ms

        from . import comm, main
        from .protocol import (
            ARRIVED,
            BLOCK_M,
            BUFFER_BYTES_MAX,
            E_LOCAL,
            NPES,
            ROW_BITS,
            SCHED_EXPECTED,
        )

        H, I, topk, dev = self.model_dim, self.inter_dim, _KERNEL_TOPK, self.dev
        self._token_shift = max((self.mtpr - 1).bit_length(), 1)
        self._tcap = tcap = 1 << self._token_shift
        # Every route of every rank (the real top-k; the padding slots take no row),
        # plus one partial block per local expert.
        s_cap = -(-(NPES * tcap * self.topk + E_LOCAL * BLOCK_M) // BLOCK_M) * BLOCK_M
        if s_cap >= 1 << ROW_BITS or s_cap * H >= BUFFER_BYTES_MAX:
            raise ValueError(
                f"max_tok_per_rank={self.mtpr}: {s_cap} receive rows of {H} bytes pass "
                "the 2 GiB the kernels address with i32 offsets"
            )
        self._s_cap, self._nblk = s_cap, s_cap // BLOCK_M
        sym = host.symmetric
        bufs = {
            "recv_a": sym((s_cap, H), torch.uint8),
            "recv_scale": sym((s_cap, H // 128), torch.float32),
            "down_ids": sym((s_cap,), torch.int32),
            "recv_w": sym((s_cap,), torch.float32),
            "ws": sym((ARRIVED + self._nblk,), torch.int32),
            "out": sym((tcap, H), torch.bfloat16),
        }
        torch.cuda.synchronize()
        ms.shmem_barrier_all()
        # every rank's address of each symmetric buffer
        self._tables = {
            name: host.peer_table(t, self.rank, self.world_size)
            for name, t in bufs.items()
        }
        self._bufs = bufs
        i32 = {"dtype": torch.int32, "device": dev}
        self._route_idx = torch.empty(tcap * topk, **i32)
        # forward's ids / weights padded to the kernels' top-k (see _routes)
        self._ids_pad = torch.full((tcap, topk), -1, **i32)
        self._no_route = torch.full((), -1, **i32)
        self._wts_pad = torch.zeros((tcap, topk), dtype=torch.float32, device=dev)
        self._send_route = torch.empty(tcap * topk, **i32)
        self._send_info = torch.empty(tcap * topk, **i32)
        self._num_valid = torch.zeros(1, **i32)
        self._status = torch.zeros(8, **i32)
        self._plan = torch.empty(comm.PLAN_INTS, **i32)
        self._expert_ids = torch.zeros(self._nblk, **i32)
        self._sched = torch.zeros(SCHED_EXPECTED + 2 * self._nblk, **i32)
        # the plan kernel: one workgroup per producer wave, up to 1024 routes each
        self._slices = _PRODUCERS * 8
        if tcap * topk > self._slices * 1024:
            raise ValueError(f"max_tok_per_rank={self.mtpr}: too many routes per call")
        self._a2 = torch.empty((s_cap, I), dtype=torch.uint8, device=dev)
        self._a2_scale = torch.empty((s_cap, I // 128), dtype=torch.float32, device=dev)
        self._x8 = torch.empty((tcap, H), dtype=torch.uint8, device=dev)
        self._xs = torch.empty((tcap, H // 128), dtype=torch.float32, device=dev)
        self._grid = min(
            torch.cuda.get_device_properties(dev).multi_processor_count,
            main.max_tasks(self._nblk, H, I, _PRODUCERS),
        )
        key = {
            "H": H,
            "I": I,
            "TOPK": topk,
            "token_shift": self._token_shift,
            "producers": _PRODUCERS,
            "lag": _LAG,
            "ACT": self._act,
        }
        if not self._qx:
            key["QX"] = 0
        d = dev.index
        self._mega_k = host.launcher(main.ep_mega_kernel, d, **key)
        # From BLOCK_M * E_LOCAL / topk tokens on this rank (uniform routing: an
        # expert's rows span several blocks) the blocks of an expert re-read its W:
        # cache gemm1's W, and gemm2's with cache modifier 1.
        self._mega_big_k = host.launcher(main.ep_mega_kernel, d, **key, BCM1=0, BCM2=1)
        self._big_tokens = BLOCK_M * E_LOCAL // topk
        self._quant_k = host.launcher(comm.mega_quant_kernel, d, H=H, QX=self._qx)
        self._prep_k = host.launcher(comm.mega_prep_kernel, d)
        self._plan_k = host.launcher(comm.mega_plan_kernel, d)
        self._finish_k = host.launcher(comm.mega_finish_kernel, d)

    def _forward_main(self, x, wts, ids, x_scale=None):
        T, H = x.shape
        if T > self._tcap or H != self.model_dim:
            raise ValueError(
                f"x {tuple(x.shape)}: at most {self._tcap} rows of {self.model_dim}"
            )
        tab, bufs = self._tables, self._bufs
        routes = T * _KERNEL_TOPK
        quant = x_scale is None
        if quant:
            if x.dtype != torch.bfloat16:
                raise TypeError(f"x is {x.dtype}, the main path quantizes bf16")
            src, x8, xs = x.contiguous(), self._x8, self._xs
        else:
            src = None
            x8, xs = x.contiguous().view(torch.uint8), x_scale.contiguous()
        if T:
            waves = T * (H // 512) if self._qx else T
            host.launch(
                self._quant_k, src, x8, xs, bufs["out"], T, int(quant), -(-waves // 4)
            )
        host.launch(
            self._prep_k,
            ids,
            self._route_idx,
            bufs["ws"],
            tab["ws"],
            self._num_valid,
            self._status,
            self._sched,
            self._plan,
            routes,
            self.rank,
            self._s_cap,
        )
        host.launch(
            self._plan_k,
            ids,
            self._route_idx,
            self._plan,
            self._send_route,
            self._send_info,
            bufs["down_ids"],
            self._expert_ids,
            self._sched,
            routes,
            self.rank,
            self._s_cap,
            self._slices,
        )
        W = self._W
        host.launch(
            self._mega_big_k if T >= self._big_tokens else self._mega_k,
            x8,
            xs,
            wts,
            self._send_route,
            self._send_info,
            tab["recv_a"],
            tab["recv_scale"],
            tab["down_ids"],
            tab["recv_w"],
            tab["ws"],
            tab["out"],
            bufs["recv_a"],
            bufs["recv_scale"],
            bufs["down_ids"],
            bufs["recv_w"],
            bufs["ws"],
            W["w1"],
            W["w1_scale"],
            W["w1_exp"],
            W["w2"],
            W["w2_scale"],
            W["w2_exp"],
            self._a2,
            self._a2_scale,
            self._expert_ids,
            self._num_valid,
            self._sched,
            routes,
            T,
            self.rank,
            self._nblk,
            *self._situ,
            self._grid,
        )
        host.launch(self._finish_k, bufs["ws"], tab["ws"], self._status, self.rank)
        return bufs["out"][:T]

    # ---- small / large paths ---------------------------------------------------

    def _build_small(self, enabled, mtpr):
        self._small, self._small_mtpr = None, 0
        if not enabled:
            return
        from .small_m import SmallMRuntime

        self._small = SmallMRuntime(
            rank=self.rank,
            world_size=self.world_size,
            model_dim=self.model_dim,
            inter_dim=self.inter_dim,
            topk=self.topk,
            tmax=self.world_size * mtpr,
            act=self._act,
            x_quant=self._x_quant,
        )
        self._small_mtpr = mtpr

    def _build_large(self, enabled):
        self._large = None
        if not enabled:
            return
        from .large_m import LargeMRuntime

        self._large = LargeMRuntime(
            rank=self.rank,
            world_size=self.world_size,
            model_dim=self.model_dim,
            inter_dim=self.inter_dim,
            topk=_KERNEL_TOPK,
            routes=self.topk,
            max_tokens=self.mtpr,
            act=self._act,
            x_quant=self._x_quant,
        )

    @property
    def small_m_mtpr(self):
        """Largest per-rank token count ``forward_small_m`` accepts (0 when disabled)."""
        return self._small_mtpr

    @property
    def large_m_available(self):
        return self._large is not None

    def set_large_m_enabled(self, enabled):
        """Send the following ``forward`` calls to the large path (True) or the main
        path (False); every rank must make the same choice."""
        if enabled and self._large is None:
            raise RuntimeError(
                "the large-input path is not available (set AITER_MEGA_LARGE_M=1)"
            )
        self._large_on = bool(enabled)

    # ---- calls -------------------------------------------------------------------

    def _routes(self, x, topk_ids, wts, slots):
        # The kernels take raw pointers: every input must be on this layer's device.
        T = x.shape[0]
        for name, t in (("x", x), ("topk_ids", topk_ids), ("wts", wts)):
            if t.device != self.dev:
                raise ValueError(f"{name} is on {t.device}, the layer on {self.dev}")
        if x.dim() != 2 or any(
            tuple(t.shape) != (T, self.topk) for t in (topk_ids, wts)
        ):
            raise ValueError(
                f"x {tuple(x.shape)}, topk_ids {tuple(topk_ids.shape)}, wts "
                f"{tuple(wts.shape)}: expected [T, H], [T, {self.topk}], [T, {self.topk}]"
            )
        # Out-of-range ids are no routes, as in MegaMoEV2 (sglang marks padding rows with
        # id == experts); the kernels skip negative ids only.
        topk_ids = topk_ids.to(torch.int32)
        if slots == self.topk:
            ids = torch.where(topk_ids < self.experts, topk_ids, self._no_route)
            return ids.contiguous(), wts.to(torch.float32).contiguous()
        # Padded to the kernels' slots in place: the extra slots of these buffers stay
        # -1 / 0 (no route) from the constructor on.
        if T > self._tcap:
            raise ValueError(f"{T} rows: at most {self._tcap} (max_tok_per_rank)")
        ids, w = self._ids_pad[:T], self._wts_pad[:T]
        torch.where(
            topk_ids < self.experts, topk_ids, self._no_route, out=ids[:, : self.topk]
        )
        w[:, : self.topk].copy_(wts)
        return ids, w

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
            ids, w = self._routes(x_bf16, topk_ids, wts, _KERNEL_TOPK)
            if self._large_on:
                return self._large.forward(x_bf16, ids, w, self._W, self._situ)
            return self._forward_main(x_bf16, w, ids)

    __call__ = forward

    def forward_prequant(
        self, x_q, x_scale, wts, topk_ids, *, stream=None, slice_output=True
    ):
        """The main path on x already quantized as this instance's ``x_quant``: x_q
        float8_e4m3fnuz [T, H] and x_scale f32 [T, H / 128] ("per_1x128") or [T]
        ("per_token")."""
        T, H = x_q.shape
        shape = (T, H // 128) if self._qx else (T,)
        if x_q.dtype != torch.float8_e4m3fnuz or x_scale.dtype != torch.float32:
            raise TypeError(
                f"x_q {x_q.dtype} / x_scale {x_scale.dtype}: expected "
                "float8_e4m3fnuz / float32"
            )
        if tuple(x_scale.shape) != shape or x_scale.device != self.dev:
            raise ValueError(
                f"x_scale {tuple(x_scale.shape)} on {x_scale.device}: expected "
                f"{shape} on {self.dev}"
            )
        with _on(stream):
            ids, w = self._routes(x_q, topk_ids, wts, _KERNEL_TOPK)
            return self._forward_main(x_q, w, ids, x_scale)

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
            ids, w = self._routes(x_bf16, topk_ids, wts, self.topk)
            return self._small.forward(x_bf16, ids, w, self._W, self._situ)

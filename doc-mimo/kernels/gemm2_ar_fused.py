"""gemm2 + all-reduce in ONE kernel: the chunked two-shot all-reduce of the gemm2
output runs inside the gemm2 grid, chunk by chunk, while later columns still compute
(idea after aiter's mega_moe_tp: the gemm2 sweeps output columns left to right and
flags each finished column chunk, so communication starts without a grid barrier).

Layout of the work (doc-mimo/moe-new-tp.md, "gemm2 + all-reduce fusion"):

  * gemm2 runs with tile order "g": column chunks of ``CHUNK_N`` (512) columns are
    swept in order; inside a chunk the tiles are m-major with the per-XCD remap.
  * every compute WG, once its bf16 atomics into ``out`` (moe_buf) have landed,
    bumps ``cnt[epoch & 1][chunk]`` on its own rank (agent-scope atomic). A chunk is
    final when the count reaches ``m_blocks * (CHUNK_N / TILE_N)``.
  * the first ``cwg`` WGs of the grid are comm WGs. Unit q = (chunk c, row block u):
    rows of the output are split into ``npes`` shards (rank s owns rows
    [s*R, (s+1)*R), R = M / npes); unit u covers ``RU`` rows of every shard and the
    chunk's columns (one 16 B vector per thread per shard and ``vpt``).
      1. wait cnt[c] (local, written by this rank's compute WGs)
      2. reduce-scatter push: shard s rows -> rank s inbox[rank] (sc0|sc1)
      3. flag rs[q][rank] = epoch on every rank; wait rs[q][*] here
      4. sum the npes inbox rows in fp32 in rank order (bit-identical on every
         rank), bf16, push to every rank's gather (= the all-reduced output)
      5. flag ag[q][rank] = epoch on every rank
    Comm WG w handles q = w, w + cwg, ... (chunk order). At the end it waits for
    ag[q][*] of its units, so the kernel returns with the full result in gather.
  * single-buffered inbox / gather are safe (two-shot handshake, see
    twoshot_allreduce.py); the chunk counters alternate by epoch parity and the
    unused parity is zeroed by comm WG 0 at kernel start.

    torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 512 2048
    CWG=32,64 VPT=1,2 CHUNK=256 ROUTE=0,8 ...

``ROUTE`` / ``ar_config(route=topk)``: topk-sum in the comm phase (mega_moe_tp's
route rows). gemm2 does no atomics: every routed row writes its weighted partial to
its own row ``route[token * topk + k]`` (write-through stores, so other XCDs see
them past their L2) and the reduce-scatter step sums the ``topk`` rows of each
token in fp32 before pushing; no moe_buf zeroing. 0 = atomics into moe_buf.

(A ticket protocol where compute WGs also took reduce-scatter work after their
tile was tried and reverted: slower, see doc-mimo/moe-new-tp.md section 7.)
"""

import functools
import os
import sys

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
import torch.distributed as dist
from flydsl._mlir.dialects import llvm
from flydsl.expr import const_expr, gpu, range_constexpr, rocdl
from flydsl.expr.typing import T

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "comm"))

from aiter.ops.flydsl.kernels import buffer_ops as bo  # noqa: E402
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import global_typed_ptr  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _to_raw as _raw  # noqa: E402

_CM_SYS = 17  # sc0|sc1: write-through / L2-bypassing (system coherent)


def ar_layout(npes, cwg, vpt, mmax, skip, split, route=0, nodep=False, *, D, chunk):
    """Byte offsets in every rank's symmetric buffer (sized for ``mmax`` tokens)."""
    vrow = chunk * 2 // 16  # 16 B vectors per chunk row
    assert (256 * vpt) % vrow == 0, "a unit must cover whole chunk rows"
    ru = 256 * vpt // vrow  # rows per (unit, shard)
    nch = D // chunk
    nu_max = nch * (mmax // npes // ru)
    L = dict(vrow=vrow, ru=ru, nch=nch, nu_max=nu_max)
    L["inbox"] = 0  # [npes src][R][D] bf16 (this rank's shard rows, from every src)
    L["gather"] = mmax * D * 2  # [M][D] bf16: the all-reduced output
    L["rs"] = L["gather"] + mmax * D * 2  # [nu][npes] i32
    L["ag"] = L["rs"] + nu_max * npes * 4
    L["cnt"] = L["ag"] + nu_max * npes * 4  # [2 parity][nch][NSLOT] i32, 256 B apart
    L["nslot"] = NSLOT
    L["tim"] = L["cnt"] + 2 * nch * NSLOT * CNT_STRIDE  # [nu][4] i64 probe
    L["src"] = L["tim"] + nu_max * 4 * 8  # nodep: [M][D] bf16 all-reduce input
    L["total"] = L["src"] + (mmax * D * 2 if nodep else 0)
    return L


# chunk-ready counters: one per (XCD, sub) slot and 256 B apart, so the ~1000
# per-chunk increments are spread over many memory channels instead of
# serializing on one address (a single counter per chunk cost ~33 us at 512 tok)
CNT_SUB = 4
NSLOT = 8 * CNT_SUB
CNT_STRIDE = 256


def cnt_slot(bx):
    """Counter slot of compute WG ``bx`` (bx % 8 = its XCD)."""
    return (bx % fx.Int32(8)) * fx.Int32(CNT_SUB) + (bx // fx.Int32(8)) % fx.Int32(CNT_SUB)


# symmetric-table reads: "s" = s_buffer_load (scalar cache), "v" = the original
# vector global load + readfirstlane (A/B knob; tagged into kernel names)
TBL_MODE = os.environ.get("TBL", "s")
# final all-gather flag wait: "par" = all units' flags polled at once, "seq" = one
# unit after another (original). Tagged into kernel names with TBL_MODE (AR_TAG).
WAIT_AG = os.environ.get("WAIT_AG", "par")
AR_TAG = f"t{TBL_MODE}_ag{WAIT_AG}"


def tbl_entry(arg_tbl, npes, idx):
    """``tbl[idx]`` (i64 symmetric-buffer base, ``idx`` wave-uniform) via two
    ``s_buffer_load_dword``: lands in SGPRs through the scalar cache (the table is
    read-only and hot), instead of a ~0.3-0.4 us vector global load + readfirstlane
    (ATT: per-unit / per-publish / per-tile-hook table reloads)."""
    if TBL_MODE == "v":
        v = fx.Int64(global_typed_ptr(arg_tbl, T.i64, align=8)[idx])
        lo = rocdl.readfirstlane(T.i32, _raw(fx.Int32(v)))
        hi = rocdl.readfirstlane(T.i32, _raw(fx.Int32(v >> fx.Int64(32))))
        return (fx.Int64(fx.Int32(hi)) << fx.Int64(32)) | (
            fx.Int64(fx.Int32(lo)) & fx.Int64(0xFFFFFFFF)
        )
    rt = bo.create_buffer_resource_from_addr(fx.Int64(arg_tbl), num_records_bytes=npes * 8)
    lo = fx.Int32(bo.buffer_load(rt, idx * fx.Int32(2), vec_width=1, is_scalar=True))
    hi = fx.Int32(
        bo.buffer_load(rt, idx * fx.Int32(2) + fx.Int32(1), vec_width=1, is_scalar=True)
    )
    return (fx.Int64(hi) << fx.Int64(32)) | (fx.Int64(lo) & fx.Int64(0xFFFFFFFF))


def hook_mult(hook):
    """Ready-counter increments per compute tile: 1 (WG-wide hook) or 4 ("wave":
    every wave counts itself after its own atomics landed, no barrier)."""
    return 4 if hook == "wave" else 1


@functools.cache
def build_ar_role(
    npes, cwg, vpt, mmax, skip, split, route=0, nodep=False, *, D, chunk, cg, hook="full"
):
    """Comm-WG role. ``route`` = topk: ``arg_out`` holds the route rows
    [tokens * topk, D] (no atomics) and the reduce-scatter sums each token's topk
    rows in fp32; 0: ``arg_out`` is the atomically accumulated moe_buf.
    ``nodep`` (upper-bound experiment): all-reduce the symmetric buffer's ``src``
    region instead, without waiting on any gemm2 chunk (no dependency at all)."""
    import twoshot_allreduce as tsar  # noqa: PLC0415

    L = ar_layout(npes, cwg, vpt, mmax, skip, split, route, nodep, D=D, chunk=chunk)
    VROW, RU, NCH = L["vrow"], L["ru"], L["nch"]
    INBOX, GATHER, RS, AG, CNT = L["inbox"], L["gather"], L["rs"], L["ag"], L["cnt"]
    INBOX_BYTES = L["gather"] - L["inbox"]
    TIM = L["tim"]
    AR_PROBE = os.environ.get("AR_PROBE", "0") == "1"  # bool closure: in JIT key
    # peers per reduce-scatter load batch: fewer live VGPRs (the comm role shares
    # the kernel's register allocation with gemm2) vs one more in-order vmcnt stall
    RS_BATCH = int(os.environ.get("RS_BATCH", str(npes)))
    assert npes % RS_BATCH == 0
    # parallel final ag-flag wait needs every (unit of a WG, src) pair on its own lane
    WAIT_AG_PAR = WAIT_AG == "par" and -(-L["nu_max"] // (cwg // 2 if split else cwg)) <= 256 // npes
    MONO = llvm.AtomicOrdering.monotonic

    def _uni64(v):
        """Wave-uniform i64 -> SGPRs (readfirstlane of both halves)."""
        v = fx.Int64(v)
        lo = rocdl.readfirstlane(T.i32, _raw(fx.Int32(v)))
        hi = rocdl.readfirstlane(T.i32, _raw(fx.Int32(v >> fx.Int64(32))))
        return (fx.Int64(fx.Int32(hi)) << fx.Int64(32)) | (
            fx.Int64(fx.Int32(lo)) & fx.Int64(0xFFFFFFFF)
        )

    @flyc.jit
    def _stamp(own, q, k):
        """Probe: tim[q][k] = s_memrealtime (k: 0 unit start, 1 chunk ready seen,
        2 reduce-scatter flags complete, 3 unit done)."""
        if const_expr(AR_PROBE):
            if fx.Int32(gpu.thread_id("x")) == fx.Int32(0):
                t = fx.Int64(
                    llvm.call_intrinsic(T.i64, "llvm.amdgcn.s.memrealtime", [], [], [])
                )
                global_typed_ptr(own + fx.Int64(TIM), T.i64, align=8)[
                    q * fx.Int32(4) + k
                ] = t

    def _xchg(addr_i64, byte_off, val):
        llvm.AtomicRMWOp(
            llvm.AtomicBinOp.xchg,
            tsar._flag_ptr(addr_i64, byte_off),
            val.ir_value() if hasattr(val, "ir_value") else val,
            MONO,
            alignment=4,
        )

    @flyc.jit
    def _spin_ge(addr_i64, byte_off, target):
        ptr = tsar._flag_ptr(addr_i64, byte_off)
        seen = tsar._flag_read(ptr, MONO)
        while seen < target:
            rocdl.s_sleep(1)
            seen = tsar._flag_read(ptr, MONO)

    @flyc.jit
    def _spin_cnt(own, par, c, target):
        """Wave 0: wait until the NSLOT counters of chunk c sum to ``target`` (lane
        s polls slot s, butterfly sum: one live VGPR, wave-uniform loop exit)."""
        rc = bo.create_buffer_resource_from_addr(
            own + fx.Int64(CNT), num_records_bytes=2 * NCH * NSLOT * CNT_STRIDE
        )
        lane = fx.Int32(gpu.thread_id("x")) % fx.Int32(64)
        off = (par * fx.Int32(NCH) + c) * fx.Int32(NSLOT * CNT_STRIDE // 4) + fx.Int32(
            CNT_STRIDE // 4
        ) * fx.min(lane, fx.Int32(NSLOT - 1))

        def total():
            v = fx.Int32(
                bo.buffer_load(rc, off, vec_width=1, dtype=T.i32, cache_modifier=_CM_SYS)
            )
            v = (lane < fx.Int32(NSLOT)).select(v, fx.Int32(0))
            for sh in (1, 2, 4, 8, 16, 32):
                v = v + v.shuffle_xor(fx.Int32(sh), fx.Int32(64))
            return v

        seen = total()
        while seen < target:
            rocdl.s_sleep(1)
            seen = total()

    def make_unit(PH):
        """PH: "all" = steps 1-5; "rs" = steps 1-3a (wait chunk, push, publish);
        "red" = steps 3b-5 (wait rs flags, reduce, all-gather push, publish)."""

        @flyc.jit
        def _unit(arg_tbl, arg_out, i32_M, i32_rank, i32_epoch, R, U, q, target):
            _unit_body(arg_tbl, arg_out, i32_M, i32_rank, i32_epoch, R, U, q, target, PH)

        return _unit

    def _unit_body(arg_tbl, arg_out, i32_M, i32_rank, i32_epoch, R, U, q, target, PH):
        tx = fx.Int32(gpu.thread_id("x"))
        own = tbl_entry(arg_tbl, npes, i32_rank)
        src = bo.create_buffer_resource_from_addr(
            fx.Int64(arg_out),
            num_records_bytes=i32_M * fx.Int32(D * 2 * (route if route else 1)),
        )
        if const_expr(nodep):
            src = bo.create_buffer_resource_from_addr(
                own + fx.Int64(L["src"]), num_records_bytes=mmax * D * 2
            )
        c = q // U
        u = q - c * U
        # destinations of this unit: rank (rank + q + i), rotated per unit so that
        # concurrent units use different xGMI links; bases loaded before any store
        dst_rank = [(i32_rank + q + fx.Int32(i)) % fx.Int32(npes) for i in range(npes)]
        dst = [tbl_entry(arg_tbl, npes, d) for d in dst_rank]
        rows, cols = [], []
        for j in range_constexpr(vpt):
            v = fx.Int32(j * 256) + tx
            rows.append(u * fx.Int32(RU) + v // fx.Int32(VROW))  # row within shard
            cols.append(c * fx.Int32(chunk) + (v % fx.Int32(VROW)) * fx.Int32(8))
        if const_expr(PH != "red"):
            _rs_part(arg_tbl, own, src, dst, dst_rank, rows, cols, i32_rank, i32_epoch, R, q, c, target)
        if const_expr(PH != "rs"):
            _red_part(arg_tbl, own, dst, rows, cols, i32_rank, i32_epoch, R, q)

    def _bf16x8_add(acc, w):
        """acc (8 x f32) += unpacked bf16x8 (v4 i32)."""
        w = fx.Vector(w)
        for k in range_constexpr(4):
            word = fx.Int32(w[k])
            acc[2 * k] = acc[2 * k] + (word << fx.Int32(16)).bitcast(fx.Float32)
            acc[2 * k + 1] = acc[2 * k + 1] + (word & fx.Int32(-65536)).bitcast(fx.Float32)
        return acc

    def _load_partial(src, row, col):
        """This rank's partial of output (row = token, col .. col+8) as v4 i32
        (bf16x8): one moe_buf vector, or (route) the fp32 sum of the token's topk
        route rows rounded to bf16."""
        if const_expr(not route):
            return bo.buffer_load(
                src, (row * fx.Int32(D) + col) // fx.Int32(2), vec_width=4,
                dtype=T.i32, cache_modifier=_CM_SYS,  # atomics landed past L2
            )
        acc = [fx.Float32(0.0)] * 8
        for k in range_constexpr(route):
            acc = _bf16x8_add(
                acc,
                bo.buffer_load(
                    src,
                    ((row * fx.Int32(route) + fx.Int32(k)) * fx.Int32(D) + col) // fx.Int32(2),
                    vec_width=4, dtype=T.i32, cache_modifier=_CM_SYS,
                ),
            )
        return fx.Vector.from_elements(acc, fx.Float32).to(fx.BFloat16).bitcast(fx.Int32)

    # nested @flyc.jit helpers get flag offsets / stamp slots as runtime i32: a
    # nested call does not re-specialize on Python int arguments
    def _rs_part(arg_tbl, own, src, dst, dst_rank, rows, cols, i32_rank, i32_epoch, R, q, c, target):
        # 1. wait until this rank's chunk c is final (all its gemm2 tiles landed)
        _stamp(own, q, fx.Int32(0))
        if const_expr(not nodep):
            _wait_chunk(own, i32_epoch, c, target)
        _stamp(own, q, fx.Int32(1))

        # 2. reduce-scatter push: rows of shard s (= dst_rank[i]) -> its inbox[rank]
        #    (route: topk loads per peer already; ROUTE_BATCH peers per batch)
        batch = int(os.environ.get("ROUTE_BATCH", "1")) if route else RS_BATCH
        for b in range_constexpr(npes // batch):
            peers = range(b * batch, (b + 1) * batch)
            vals = {
                (i, j): _load_partial(src, dst_rank[i] * R + rows[j], cols[j])
                for i in peers
                for j in range(vpt)
            }
            for i in peers:
                r_dst = bo.create_buffer_resource_from_addr(
                    dst[i] + fx.Int64(INBOX), num_records_bytes=INBOX_BYTES
                )
                for j in range_constexpr(vpt):
                    off = ((i32_rank * R + rows[j]) * fx.Int32(D) + cols[j]) // fx.Int32(2)
                    bo.buffer_store(vals[i, j], r_dst, off, cache_modifier=_CM_SYS)
        rocdl.s_waitcnt(vmcnt=0)
        gpu.barrier()
        # 3a. publish rs[q][rank] on every rank
        _publish_flag(arg_tbl, fx.Int32(RS), q, i32_rank, i32_epoch)

    def _red_part(arg_tbl, own, dst, rows, cols, i32_rank, i32_epoch, R, q):
        # 3b. wait rs[q][*] here (every rank pushed its rows of my shard)
        _wait_flags(own, fx.Int32(RS), q, i32_epoch)
        _stamp(own, q, fx.Int32(2))

        # 4. reduce own shard rows (fp32, rank order) -> push to every rank's gather
        inbox = bo.create_buffer_resource_from_addr(
            own + fx.Int64(INBOX), num_records_bytes=INBOX_BYTES
        )
        reds = []
        for j in range_constexpr(vpt):
            acc = [fx.Float32(0.0)] * 8
            for r in range_constexpr(npes):
                w = fx.Vector(
                    bo.buffer_load(
                        inbox,
                        ((fx.Int32(r) * R + rows[j]) * fx.Int32(D) + cols[j]) // fx.Int32(2),
                        vec_width=4,
                        dtype=T.i32,
                        cache_modifier=_CM_SYS,
                    )
                )
                for k in range_constexpr(4):
                    word = fx.Int32(w[k])
                    acc[2 * k] = acc[2 * k] + (word << fx.Int32(16)).bitcast(fx.Float32)
                    acc[2 * k + 1] = acc[2 * k + 1] + (word & fx.Int32(-65536)).bitcast(
                        fx.Float32
                    )
            reds.append(
                fx.Vector.from_elements(acc, fx.Float32).to(fx.BFloat16).bitcast(fx.Int32)
            )
        for i in range_constexpr(npes):
            r_dst = bo.create_buffer_resource_from_addr(
                dst[i] + fx.Int64(GATHER), num_records_bytes=mmax * D * 2
            )
            for j in range_constexpr(vpt):
                off = ((i32_rank * R + rows[j]) * fx.Int32(D) + cols[j]) // fx.Int32(2)
                bo.buffer_store(reds[j], r_dst, off, cache_modifier=_CM_SYS)
        rocdl.s_waitcnt(vmcnt=0)
        gpu.barrier()

        # 5. publish ag[q][rank] on every rank (waited for at the end of the role)
        _publish_flag(arg_tbl, fx.Int32(AG), q, i32_rank, i32_epoch)
        _stamp(own, q, fx.Int32(3))

    @flyc.jit
    def _wait_chunk(own, i32_epoch, c, target):
        if fx.Int32(gpu.thread_id("x")) < fx.Int32(64):
            _spin_cnt(own, i32_epoch & fx.Int32(1), c, target)
        gpu.barrier()

    @flyc.jit
    def _publish_flag(arg_tbl, flag_off, q, i32_rank, i32_epoch):
        tx = fx.Int32(gpu.thread_id("x"))
        if tx < fx.Int32(npes):
            idx = (i32_rank + tx) % fx.Int32(npes)
            if const_expr(TBL_MODE == "v"):
                peer = fx.Int64(global_typed_ptr(arg_tbl, T.i64, align=8)[idx])
            else:
                peer = tbl_entry(arg_tbl, npes, fx.Int32(0))
                for k in range_constexpr(1, npes):
                    peer = (idx == fx.Int32(k)).select(tbl_entry(arg_tbl, npes, fx.Int32(k)), peer)
            _xchg(peer + fx.Int64(flag_off), (q * fx.Int32(npes) + i32_rank) * fx.Int32(4), i32_epoch)

    @flyc.jit
    def _wait_flags(own, flag_off, q, i32_epoch):
        tx = fx.Int32(gpu.thread_id("x"))
        if tx < fx.Int32(npes):
            _spin_ge(own + fx.Int64(flag_off), (q * fx.Int32(npes) + tx) * fx.Int32(4), i32_epoch)
        gpu.barrier()

    unit_all, unit_rs, unit_red = make_unit("all"), make_unit("rs"), make_unit("red")

    @flyc.jit
    def ar_role(arg_tbl, arg_out, i32_M, i32_rank, i32_epoch, w, total_m_blocks):
        tx = fx.Int32(gpu.thread_id("x"))
        own = tbl_entry(arg_tbl, npes, i32_rank)
        # recycle the other parity's chunk counters (epoch-1 done, epoch+1 not begun)
        if w == fx.Int32(0):
            nxt = (i32_epoch + fx.Int32(1)) & fx.Int32(1)
            rc = bo.create_buffer_resource_from_addr(
                own + fx.Int64(CNT), num_records_bytes=2 * NCH * NSLOT * CNT_STRIDE
            )
            for k in range_constexpr((NCH * NSLOT + 255) // 256):
                e = fx.Int32(k * 256) + tx
                bo.buffer_store(
                    fx.Int32(0),
                    rc,
                    (nxt * fx.Int32(NCH * NSLOT) + e) * fx.Int32(CNT_STRIDE // 4),
                    mask=e < fx.Int32(NCH * NSLOT),
                    cache_modifier=_CM_SYS,
                )
        if const_expr(not skip):
            R = i32_M // fx.Int32(npes)
            U = R // fx.Int32(RU)
            NU = U * fx.Int32(NCH)
            target = total_m_blocks * fx.Int32(cg * hook_mult(hook))
            args = (arg_tbl, arg_out, i32_M, i32_rank, i32_epoch, R, U)
            if const_expr(split):
                # WGs [0, H): reduce-scatter pushers; [H, cwg): reducers + all-gather
                H = cwg // 2
                if w < fx.Int32(H):
                    for q_ in range(w, NU, fx.Int32(H)):
                        unit_rs(*args, fx.Int32(q_), target)
                else:
                    for q_ in range(w - fx.Int32(H), NU, fx.Int32(H)):
                        unit_red(*args, fx.Int32(q_), target)
                    _wait_ag(own, w - fx.Int32(H), NU, fx.Int32(H), i32_epoch)
            else:
                for q_ in range(w, NU, fx.Int32(cwg)):
                    unit_all(*args, fx.Int32(q_), target)
                _wait_ag(own, w, NU, fx.Int32(cwg), i32_epoch)
            llvm.FenceOp(llvm.AtomicOrdering.acquire)

    @flyc.jit
    def _wait_ag(own, first, NU, step, i32_epoch):
        tx = fx.Int32(gpu.thread_id("x"))
        if const_expr(WAIT_AG_PAR):
            # one lane per (unit k of this WG, source rank): every flag is polled
            # concurrently -> one round trip instead of one per unit (ATT: the
            # serial version cost wave 0 ~0.8 us per unit at the kernel tail)
            q_ = first + (tx // fx.Int32(npes)) * step
            if q_ < NU:
                _spin_ge(
                    own + fx.Int64(AG),
                    (q_ * fx.Int32(npes) + tx % fx.Int32(npes)) * fx.Int32(4),
                    i32_epoch,
                )
        else:
            for q_ in range(first, NU, step):
                if tx < fx.Int32(npes):
                    _spin_ge(
                        own + fx.Int64(AG),
                        (fx.Int32(q_) * fx.Int32(npes) + tx) * fx.Int32(4),
                        i32_epoch,
                    )

    return ar_role


def ar_config(npes, cwg=32, vpt=1, mmax=2048, skip=False, split=False, route=0, nodep=False):
    return (npes, cwg, vpt, mmax, bool(skip), bool(split), int(route), bool(nodep))


@functools.cache
def compile_ar_kernel(ar, *, D, chunk, cg, bm):
    """The comm role as its own kernel (grid = cwg WGs), run concurrently with a
    gemm2 launched with ``ar_sep=True``: separate register allocation, so the
    comm code cannot lower gemm2's occupancy (fused: 72 -> 98+ VGPRs)."""
    hook = os.environ.get("AR_HOOK", "wave")  # must match the gemm2 launch's hook
    ar_role = build_ar_role(*ar, D=D, chunk=chunk, cg=cg, hook=hook)
    cwg = ar[1]

    @flyc.kernel(
        name=f"ar_comm_{'_'.join(str(x).replace('-', 'm') for x in ar)}_d{D}_c{chunk}_{hook}_{AR_TAG}",
        known_block_size=[256, 1, 1],
    )
    def ar_comm(
        arg_tbl: fx.Int64,
        arg_out: fx.Int64,
        arg_cumsum: fx.Int64,
        i32_M: fx.Int32,
        i32_rank: fx.Int32,
        i32_epoch: fx.Int32,
    ):
        total_m_blocks = fx.Int32(global_typed_ptr(arg_cumsum, T.i32)[0]) // fx.Int32(bm)
        ar_role(
            arg_tbl, arg_out, i32_M, i32_rank, i32_epoch,
            fx.Int32(gpu.block_id("x")), total_m_blocks,
        )

    @flyc.jit
    def launch(
        arg_tbl: fx.Int64,
        arg_out: fx.Int64,
        arg_cumsum: fx.Int64,
        i32_M: fx.Int32,
        i32_rank: fx.Int32,
        i32_epoch: fx.Int32,
        stream: fx.Stream,
    ):
        ar_comm(arg_tbl, arg_out, arg_cumsum, i32_M, i32_rank, i32_epoch).launch(
            grid=(cwg, 1, 1), block=(256, 1, 1), stream=stream
        )

    return launch


class FusedGemm2AR:
    """gemm2 (tile order "g") + fused chunked two-shot all-reduce. ``__call__``
    takes the a8w4_gemm2 operands (``out`` = zeroed moe_buf, this rank's partial)
    and returns the all-reduced [tokens, model_dim] bf16 (view of the symmetric
    gather region, valid until the next call)."""

    def __init__(
        self, model_dim, mmax=2048, cwg=32, vpt=1, chunk_n=512, skip=False, split=False,
        sep=False, route=0, nodep=False, order="g",
    ):
        import twoshot_allreduce as tsar  # noqa: PLC0415

        self.rank, self.npes = dist.get_rank(), dist.get_world_size()
        self.ar = ar_config(self.npes, cwg, vpt, mmax, skip, split, route, nodep)
        self.order = order
        assert order == "g" or nodep, "chunked all-reduce needs column-group order"
        self.route = route
        if route:  # this rank's per-(token, k) weighted partials, [mmax*topk, D] bf16
            self.route_buf = torch.empty(
                mmax * route * model_dim, dtype=torch.bfloat16, device="cuda"
            )
        self.sep = sep
        if sep:
            self.side = torch.cuda.Stream(priority=-1)  # high-priority queue
            self.ev_in, self.ev_out = torch.cuda.Event(), torch.cuda.Event()
        self.chunk_n = chunk_n
        self.L = ar_layout(*self.ar, D=model_dim, chunk=chunk_n)
        self.buf = tsar.SymmetricBuffer(self.L["total"], self.rank, self.npes)
        self.gather = self.buf.storage[self.L["gather"]: self.L["gather"] + mmax * model_dim * 2]
        self.model_dim = model_dim
        self.epoch = 0

    def __call__(self, gemm2_fn, *args, out, **kw):
        from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled  # noqa: PLC0415

        tokens = out.shape[0]
        assert tokens % (self.npes * self.L["ru"]) == 0, "tokens % (npes * RU) != 0"
        if self.route:  # gemm2 writes route rows instead of accumulating into out
            out = self.routes(tokens)
        self.epoch += 1
        main = torch.cuda.current_stream()
        if self.sep:
            self.ev_in.record(main)  # out zeroed
        # gemm2 is enqueued FIRST: if both streams ever land on one hardware queue,
        # a spinning comm kernel ahead of gemm2 would deadlock (seen with the
        # comm kernel launched first)
        gemm2_fn(
            *args, out, tile_order=self.order, chunk_n=self.chunk_n, ar=self.ar,
            tbl=self.buf.addrs, rank=self.rank, epoch=self.epoch, ar_sep=self.sep, **kw,
        )
        if self.sep:
            self.side.wait_event(self.ev_in)
            launch = compile_ar_kernel(
                self.ar, D=self.model_dim, chunk=self.chunk_n,
                cg=self.chunk_n // kw.get("tile_n", 128), bm=kw["tile_m"],
            )
            _run_compiled(
                launch, self.buf.addrs.data_ptr(), out.data_ptr(), args[7].data_ptr(),
                tokens, self.rank, self.epoch, self.side,
            )
            self.ev_out.record(self.side)
            main.wait_event(self.ev_out)
        return self.gather[: tokens * self.model_dim * 2].view(torch.bfloat16).view(
            tokens, self.model_dim
        )

    def routes(self, tokens):
        """Route rows [tokens * topk, D] (route mode)."""
        return self.route_buf[: tokens * self.route * self.model_dim].view(
            tokens * self.route, self.model_dim
        )

    def src(self, tokens):
        """nodep mode: this rank's all-reduce input [tokens, D] bf16 (fill it)."""
        o = self.L["src"]
        return self.buf.storage[o: o + tokens * self.model_dim * 2].view(
            torch.bfloat16
        ).view(tokens, self.model_dim)

    def close(self):
        self.buf.close()


# =============================================================================
# Benchmark (torchrun, 8 ranks): gemm2 + two-shot vs fused
# =============================================================================


def make_case(tok, rank, a_group=0, E=256, D=4096, I=256, K=8, BM=32):
    """Same routing on every rank, rank-local W2 shard + stage1 intermediate.
    Returns (gemm2 positional args, gemm2 kwargs, zeroed out [tok, D])."""
    import aiter
    from aiter import QuantType, dtypes
    from aiter.fused_moe import fused_topk, moe_sorting
    from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4
    from test_a8w4_gemm2 import quantize_groups

    torch.manual_seed(0)
    inp = torch.randn((tok, D), dtype=dtypes.bf16, device="cuda")
    score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
    tw, ti = fused_topk(inp, score, K, True)
    torch.manual_seed(1000 + rank)
    w2 = torch.randn((E, D, I), dtype=dtypes.bf16, device="cuda")
    w2q, w2s = aiter.get_torch_quant(QuantType.per_1x32)(w2, quant_dtype=dtypes.fp4x2)
    del w2
    w2u = shuffle_weight_a16w4(w2q.view(E, D, I // 2), 16, False).view(torch.uint8)
    w2su = shuffle_scale_a16w4(w2s, E, False).view(torch.uint8).contiguous().view(-1)
    sids, sw, seids, nv, _ = moe_sorting(ti, tw, E, D, dtypes.bf16, BM)[:5]
    inter = torch.randn((seids.numel() * BM, I), dtype=dtypes.bf16, device="cuda")
    if a_group:
        a, s = quantize_groups(inter, a_group)
    else:
        from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows

        a, s = quantize_rows(inter, nv)
    out = torch.zeros((tok, D), dtype=dtypes.bf16, device="cuda")
    g2args = (a, s, w2u, w2su, sids, sw, seids, nv)
    g2kw = dict(num_experts=E, tile_m=BM, tile_n=128, dyn_rows=True, a_group=a_group)
    return g2args, g2kw, out


def main():
    from allgather_bench import timeit
    import twoshot_allreduce as tsar
    from test_a8w4_gemm2 import a8w4_gemm2

    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank, npes = dist.get_rank(), dist.get_world_size()
    D = 4096
    cwgs = [int(x) for x in os.environ.get("CWG", "32").split(",")]
    vpts = [int(x) for x in os.environ.get("VPT", "1").split(",")]
    splits = [x == "1" for x in os.environ.get("SPLIT", "0").split(",")]
    seps = [x == "1" for x in os.environ.get("SEP", "0").split(",")]
    chunks = [int(x) for x in os.environ.get("CHUNK", "512").split(",")]
    routes = [int(x) for x in os.environ.get("ROUTE", "0").split(",")]
    a_group = int(os.environ.get("A_GROUP", "0"))
    # fused kernel only: cap VGPRs so the comm role can't lower gemm2 occupancy
    fkw = {"waves_per_eu": int(os.environ["WPE"])} if os.environ.get("WPE") else {}

    for tok in [int(t) for t in sys.argv[1:]] or [128, 512, 2048]:
        g2args, g2kw, out = make_case(tok, rank, a_group)

        def gemm2(order="m"):
            out.zero_()
            a8w4_gemm2(*g2args, out, tile_order=order, **g2kw)

        ts = tsar.TwoShotAllreduce(out.shape)
        res, info = {}, []
        res["gemm2(m)"] = min(timeit(lambda: gemm2("m")) for _ in range(3))
        res["gemm2(g)"] = min(timeit(lambda: gemm2("g")) for _ in range(3))
        res["twoshot"] = min(timeit(lambda: ts(out)) for _ in range(3))
        res["gemm2(m)+twoshot"] = min(timeit(lambda: (gemm2("m"), ts(out))) for _ in range(3))
        for cwg in cwgs:
            for vpt in vpts:
              for split in splits:
               for sep in seps:
                for skip, chunk, hp in [
                    (m == "skip", ch, hp)
                    for m in os.environ.get("MODES", "skip,run").split(",")
                    for ch in chunks
                    for hp in routes
                ]:
                    if tok % (npes * ar_layout(npes, cwg, vpt, 2048, 0, 0, D=D, chunk=chunk)["ru"]):
                        continue  # unit taller than a shard
                    f = FusedGemm2AR(
                        D, mmax=max(2048, tok), cwg=cwg, vpt=vpt, skip=skip, split=split,
                        sep=sep, chunk_n=chunk, route=hp,
                    )

                    def fused():
                        if not hp:  # atomics need a zeroed moe_buf; route rows don't
                            out.zero_()
                        return f(a8w4_gemm2, *g2args, out=out, **g2kw, **fkw)

                    tag = (
                        f"fused c{cwg} v{vpt}{' split' if split else ''}"
                        f"{' sep' if sep else ''}{' skip' if skip else ''}"
                        f"{'' if chunk == 512 else f' ch{chunk}'}"
                        f"{'' if not hp else f' route{hp}'}"
                    )
                    if not skip:  # correctness: y == fp32 sum over ranks of this run's partial
                        bad, worst = 0, 0.0
                        for _ in range(10):
                            y = fused()
                            torch.cuda.synchronize()
                            if hp:  # kernel: fp32 topk sum -> bf16 partial -> fp32 rank sum
                                ref = (
                                    f.routes(tok).float().view(tok, hp, D).sum(1)
                                    .to(torch.bfloat16).float()
                                )
                            else:
                                ref = out.float()
                            dist.all_reduce(ref)
                            d = (y.float() - ref).abs()
                            bad += int((d > 1e-2 * ref.abs() + 1e-2).sum())
                            worst = max(worst, float(d.max()))
                        info.append(f"{tag}: bad={bad} maxdiff={worst:.3g}")
                    res[tag] = min(timeit(fused) for _ in range(3))
                    f.close()
        ts.close()
        t = torch.tensor(list(res.values()), dtype=torch.float64, device="cuda")
        dist.all_reduce(t, op=dist.ReduceOp.MAX)
        if rank == 0:
            print(f"tok={tok:5d}  " + "  ".join(info), flush=True)
            print("    " + "  ".join(f"{k}={v:.1f}" for k, v in zip(res, t.tolist())), flush=True)
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

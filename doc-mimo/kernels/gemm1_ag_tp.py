"""Step 3 of the N-split + all-gather MoE TP experiment (doc-mimo/moe-new-tp.md):
how much of AG1 (stage1 fp8 activation all-gather) hides inside gemm1 when gemm1's
epilogue pushes its tile straight into every TP peer.

Every rank: same tokens/routing, own W1 shard [E, 2*256, 4096]. Timed (GPU-only,
queued launches, slowest rank):

  bf16          gemm1 as today (bf16, sorted rows)
  bf16+quant    + the separate per-row fp8 quant kernel (today's stage1 output path)
  q8            gemm1 with fused per-(row,128) fp8 quant, unsorted rows, local only
  q8+AG         q8, then the standalone one-shot all-gather of its output
  q8push+wait   q8 epilogue pushes to all 8 ranks + per-tile flags, then a wait
                kernel (stand-in for gemm2's flag wait)

    torchrun --nproc_per_node=8 doc-mimo/kernels/gemm1_ag_tp.py 128 512 2048
    TILES=32,0:64,1 ...   # tile_m,dyn_m variants (default 32,0)
"""
import functools
import os
import sys

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
import torch.distributed as dist
from flydsl._mlir.dialects import llvm
from flydsl.expr import gpu, rocdl
from flydsl.expr.typing import T

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "comm"))
import twoshot_allreduce as tsar  # noqa: E402
from allgather_bench import OneShotAllgather, timeit  # noqa: E402
from test_a8w4_gemm1 import a8w4_gemm1  # noqa: E402

import aiter  # noqa: E402
from aiter import QuantType, dtypes  # noqa: E402
from aiter.fused_moe import fused_topk, moe_sorting  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import (  # noqa: E402
    channel_exponents,
    quantize_rows,
)
from aiter.ops.flydsl.kernels.mxfp4_gemm_common import global_typed_ptr  # noqa: E402
from aiter.ops.flydsl.kernels.tensor_shim import _run_compiled  # noqa: E402
from aiter.ops.shuffle import shuffle_scale_a16w4, shuffle_weight_a16w4  # noqa: E402

MODEL_DIM, INTER_FULL, EXPERTS, TOPK, TILE_N = 4096, 2048, 256, 8, 128


@functools.cache
def compile_wait(npes, max_tiles, bm, nb, flag_off):
    """Spin until flag[src][tile] >= epoch for every source rank and valid tile."""
    total = npes * max_tiles
    grid = -(-total // 256)

    @flyc.kernel(name=f"ag_wait_w{npes}_t{max_tiles}", known_block_size=[256, 1, 1])
    def ag_wait(arg_tbl: fx.Int64, arg_cumsum: fx.Int64, i32_rank: fx.Int32, i32_epoch: fx.Int32):
        t = fx.Int32(gpu.block_id("x")) * fx.Int32(256) + fx.Int32(gpu.thread_id("x"))
        tile = t % fx.Int32(max_tiles)
        valid = (fx.Int32(global_typed_ptr(arg_cumsum, T.i32)[0]) // fx.Int32(bm)) * fx.Int32(nb)
        if t < fx.Int32(total):
            if tile < valid:
                own = fx.Int64(global_typed_ptr(arg_tbl, T.i64, align=8)[i32_rank])
                ptr = tsar._flag_ptr(own + fx.Int64(flag_off), t * fx.Int32(4))
                seen = tsar._flag_read(ptr, llvm.AtomicOrdering.monotonic)
                while seen < i32_epoch:
                    rocdl.s_sleep(1)
                    seen = tsar._flag_read(ptr, llvm.AtomicOrdering.monotonic)
        llvm.FenceOp(llvm.AtomicOrdering.acquire)

    @flyc.jit
    def launch(arg_tbl: fx.Int64, arg_cumsum: fx.Int64, i32_rank: fx.Int32, i32_epoch: fx.Int32, stream: fx.Stream):
        ag_wait(arg_tbl, arg_cumsum, i32_rank, i32_epoch).launch(
            grid=(grid, 1, 1), block=(256, 1, 1), stream=stream
        )

    return launch


def ag_layout(npes, rows, inter, nb):
    data = npes * rows * inter
    slot = -(-(data + npes * rows * nb * 4) // 256) * 256
    return data, slot, 2 * slot


def run(tok, tile_m, dyn_m, rank, npes):
    dev = "cuda"
    inter = INTER_FULL // npes
    nb = inter // TILE_N
    rows = tok * TOPK
    torch.manual_seed(0)
    inp = torch.randn((tok, MODEL_DIM), dtype=dtypes.bf16, device=dev)
    score = torch.randn((tok, EXPERTS), dtype=dtypes.bf16, device=dev)
    topk_w, topk_ids = fused_topk(inp, score, TOPK, True)
    torch.manual_seed(1000 + rank)
    w1 = torch.randn((EXPERTS, 2 * inter, MODEL_DIM), dtype=dtypes.bf16, device=dev)
    w1_qt, w1_scale = aiter.get_torch_quant(QuantType.per_1x32)(w1, quant_dtype=dtypes.fp4x2)
    del w1
    w1_qt = w1_qt.view(EXPERTS, 2 * inter, MODEL_DIM // 2)
    w1_u8 = shuffle_weight_a16w4(w1_qt, 16, False).view(torch.uint8)
    w1_s = shuffle_scale_a16w4(w1_scale, EXPERTS, False).view(torch.uint8).contiguous().view(-1)
    sorted_ids, _, sorted_eids, num_valid, _ = moe_sorting(
        topk_ids, topk_w, EXPERTS, MODEL_DIM, dtypes.bf16, tile_m
    )[:5]
    x_fp8, x_scale = quantize_rows(inp)
    w1_exp = channel_exponents(w1_u8, w1_s)
    sorted_size = sorted_eids.numel() * tile_m
    max_tiles = sorted_eids.numel() * nb

    common = dict(num_experts=EXPERTS, tile_m=tile_m, tile_n=TILE_N, xcd_swizzle=1, dyn_m=dyn_m)
    args = (x_fp8, x_scale, w1_u8, w1_s, w1_exp, sorted_ids, sorted_eids, num_valid)

    out_bf16 = torch.zeros((sorted_size, inter), dtype=dtypes.bf16, device=dev)
    data_b, scale_b = rows * inter, rows * nb * 4
    out_q8 = torch.zeros(data_b + scale_b, dtype=torch.uint8, device=dev)

    def g_bf16():
        a8w4_gemm1(*args, out_bf16, **common)

    def g_bf16_quant():
        g_bf16()
        quantize_rows(out_bf16, num_valid)

    def g_q8():
        a8w4_gemm1(*args, out_q8, epilog="q8", inter_dim=inter, topk=TOPK, **common)

    # ---- correctness 1: fused q8 vs bf16 baseline (unsorted, per-128 quant) ------
    g_bf16()
    g_q8()
    torch.cuda.synchronize()
    nv = int(num_valid[0])
    ids = sorted_ids[:nv].to(torch.int64)
    tokv = ids & 0xFFFFFF
    keep = tokv < tok
    dest = tokv[keep] * TOPK + (ids[keep] >> 24)
    base = torch.zeros((rows, inter), dtype=torch.float32, device=dev)
    base[dest] = out_bf16[:nv][keep].float()
    q = out_q8[:data_b].view(torch.float8_e4m3fnuz).view(rows, nb, TILE_N).float()
    s = out_q8[data_b:].view(torch.float32).view(rows, nb, 1)
    deq = (q * s).view(rows, inter)
    rel = ((deq - base).abs().max() / base.abs().max()).item()
    cos = (1 - torch.nn.functional.cosine_similarity(deq.flatten(), base.flatten(), dim=0)).item()
    # bit-level check against the same quant in torch
    b3 = base.view(rows, nb, TILE_N)
    amax = b3.abs().amax(-1, keepdim=True)
    s_ref = torch.where(amax == 0, torch.ones_like(amax), amax / 240.0)
    q_ref = (b3 * (1.0 / s_ref)).clamp(-240, 240).to(torch.float8_e4m3fnuz)
    byte_mis = (q_ref.view(torch.uint8).flatten() != out_q8[:data_b]).float().mean().item()
    scale_ok = torch.equal(s_ref.flatten(), s.flatten())

    # ---- push paths ---------------------------------------------------------------
    g_data = torch.empty(npes * data_b, dtype=torch.uint8, device=dev)
    g_scale = torch.empty(npes * scale_b, dtype=torch.uint8, device=dev)
    dist.all_gather_into_tensor(g_data, out_q8[:data_b].contiguous())
    dist.all_gather_into_tensor(g_scale, out_q8[data_b:].contiguous())
    g_data = g_data.view(npes, rows, inter)
    g_scale = g_scale.view(torch.float32).view(npes, rows, nb)
    vidx = torch.arange(nv, device=dev)[keep]
    no_wait = "nopub" in os.environ.get("Q8PUSH_VARIANT", "")

    def make_push(epilog):
        ag_rows = sorted_size if epilog == "q8pushs" else rows
        data_off, slot, flag_off = ag_layout(npes, ag_rows, inter, nb)
        buf = tsar.SymmetricBuffer(flag_off + npes * max_tiles * 4, rank, npes)
        wait = compile_wait(npes, max_tiles, tile_m, nb, flag_off)
        state = {"epoch": 0}

        def push_only():
            state["epoch"] += 1
            a8w4_gemm1(
                *args, None, epilog=epilog, inter_dim=inter, topk=TOPK, npes=npes,
                tbl=buf.addrs, rank=rank, epoch=state["epoch"], **common,
            )

        def push_wait():
            push_only()
            if not no_wait:
                _run_compiled(wait, buf.addrs.data_ptr(), num_valid.data_ptr(), rank,
                              state["epoch"], torch.cuda.current_stream())

        def check():
            p = (state["epoch"] & 1) * slot
            got = buf.storage[p: p + slot]
            d = got[:data_off].view(npes, ag_rows, inter)
            sc = got[data_off: data_off + npes * ag_rows * nb * 4].view(torch.float32)
            if epilog == "q8pushs":
                sc = sc.view(npes, nb, ag_rows)
                return int((d[:, vidx] != g_data[:, dest]).sum()) + int(
                    (sc[:, :, vidx] != g_scale[:, dest].transpose(1, 2)).sum()
                )
            sc = sc.view(npes, ag_rows, nb)
            return int((d != g_data).sum()) + int((sc != g_scale).sum())

        bad = 0
        for k in range(20):
            push_wait()
            if k % 5 == 4:
                torch.cuda.synchronize()
                bad += check()
                dist.barrier()
        return push_wait, push_only, bad, buf

    pushes = {e: make_push(e) for e in ("q8push", "q8pushs")}
    bad = sum(p[2] for p in pushes.values())

    ag = OneShotAllgather(data_b + scale_b, data_b + scale_b)

    def g_q8_ag():
        g_q8()
        ag(out_q8)

    cands = [("bf16", g_bf16), ("bf16+quant", g_bf16_quant), ("q8", g_q8),
             ("q8+AG", g_q8_ag), ("AG", lambda: ag(out_q8))]
    for e, (pw, po, _, _) in pushes.items():
        cands += [(f"{e}+wait", pw), (e, po)]
    res = {}
    for name, fn in cands:
        res[name] = min(timeit(fn) for _ in range(3))
    ag.close()
    for p in pushes.values():
        p[3].close()
    t = torch.tensor(list(res.values()), dtype=torch.float64, device=dev)
    dist.all_reduce(t, op=dist.ReduceOp.MAX)
    chk = torch.tensor([bad, rel, cos, byte_mis, 0.0 if scale_ok else 1.0], dtype=torch.float64, device=dev)
    dist.all_reduce(chk, op=dist.ReduceOp.MAX)
    if rank == 0:
        print(
            f"tok={tok:5d} bm={tile_m} dyn_m={int(dyn_m)}  push bad={int(chk[0])} "
            f"({ {e: p[2] for e, p in pushes.items()} } on rank0)  "
            f"q8 vs bf16: rel={chk[1]:.3g} cos_diff={chk[2]:.2e} byte_mismatch={chk[3]:.2e} "
            f"scale_mismatch={int(chk[4])}\n    "
            + "  ".join(f"{k}={v:.1f}us" for k, v in zip(res, t.tolist())),
            flush=True,
        )


def main():
    lr = int(os.environ["LOCAL_RANK"])
    torch.cuda.set_device(lr)
    dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
    rank, npes = dist.get_rank(), dist.get_world_size()
    tiles = [tuple(int(v) for v in s.split(",")) for s in os.environ.get("TILES", "32,0").split(":")]
    for tok in [int(t) for t in sys.argv[1:]] or [128, 512, 2048]:
        for tile_m, dyn_m in tiles:
            run(tok, tile_m, bool(dyn_m), rank, npes)
    dist.destroy_process_group()


if __name__ == "__main__":
    main()

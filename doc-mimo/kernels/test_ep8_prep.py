"""ep8_prep vs aiter moe_sorting(expert_mask) + quantize_rows: same blocks, same
(token, slot, weight) set per expert, bit-identical x quant for local tokens.

    python doc-mimo/kernels/test_ep8_prep.py -t 1 16 256 4096 16384
"""
import argparse
import os
import sys

import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ep8_common as C  # noqa: E402
import ep8_prep as PR  # noqa: E402
from aiter.ops.flydsl.kernels.moe_2stage_a16wmix.a8w4 import quantize_rows  # noqa: E402


def ref_sched(counts, bm, CB=64, NX=8):
    """host reference of the prep's GEMM tile schedule -> (range starts, order)."""
    EL = len(counts)
    nb = [-(-c // bm) for c in counts]
    b0 = [sum(nb[:e]) for e in range(EL)]
    blocks = []  # (expert, rows, cost) in block order
    for e, c in enumerate(counts):
        for j in range(nb[e]):
            r = min(bm, c - j * bm)
            v = 32 if r <= 32 else 64 if r <= 64 else 128
            blocks.append((e, r, max(CB, min(v, bm))))
    C = sum(b[2] for b in blocks)
    pre, xs = 0, []
    for e, r, k in blocks:  # range of the cost midpoint: 8 (pre + k/2) < x C
        xs.append(max(x for x in range(NX) if 8 * pre + 4 * k >= x * C or x == 0))
        pre += k
    bst = [0] + [sum(1 for x in xs if x < y) for y in range(1, NX)] + [len(blocks)]
    seq = []
    for x in range(NX):
        idx = list(range(bst[x], bst[x + 1]))
        kf = max(CB, bm)
        seq += [i for i in idx if blocks[i][2] >= kf]
        seq += [i for i in idx if blocks[i][2] < kf]
    return bst, seq


def check_sched(sched, e1, s1, nb, bm, tokens):
    valid = ((s1[:nb * bm] & 0xFFFFFF) < tokens).view(nb, bm).sum(1)
    counts = torch.zeros(C.E_LOCAL, dtype=torch.long, device=valid.device)
    counts.index_add_(0, e1[:nb].long(), valid.long())
    bst, seq = ref_sched(counts.tolist(), bm)
    got_bst = sched[:9].tolist()
    got_seq = sched[PR.SCHED_BORDER:PR.SCHED_BORDER + nb].tolist()
    ok = got_bst == bst and got_seq == seq
    if not ok:
        print("sched mismatch: bst", got_bst, bst)
        print("   got ", got_seq[:40])
        print("   want", seq[:40])
    return ok


def check(tokens, bm, routing="uniform"):
    x, tw, ti = C.make_routing(tokens, routing=routing)
    mask = C.expert_mask()
    s0, w0, e0, n0, _ = C.ep_sort(ti, tw, bm, mask)
    s1, w1, e1, n1, x8, xs, bo = PR.ep_prep(ti, tw, x, e0=C.RANK * C.E_LOCAL, block_m=bm,
                                            quant=True)
    torch.cuda.synchronize()
    ok = int(n0[0]) == int(n1[0]) and int(n1[1]) == tokens
    nb = int(n1[0]) // bm
    ok &= torch.equal(e0[:nb], e1[:nb])
    ok_bo = check_sched(bo, e1, s1, nb, bm, tokens)
    ok &= ok_bo
    # per expert: sorted (id, weight) multisets equal
    for e in e1[:nb].unique().tolist():
        rows = (e1[:nb] == e).nonzero().squeeze(1)
        r0 = torch.cat([torch.arange(b * bm, (b + 1) * bm, device="cuda") for b in rows.tolist()])
        a, b = s0[r0], s1[r0]
        ka, kb = a.argsort(), b.argsort()
        ok &= torch.equal(a[ka], b[kb]) and torch.equal(w0[r0][ka], w1[r0][kb])
    q8, qs = quantize_rows(x)
    loc = (C.local_ids(ti) >= 0).any(dim=1)
    ok &= torch.equal(q8.view(torch.uint8)[loc], x8.view(torch.uint8)[loc])
    ok &= torch.equal(qs[loc], xs[loc])
    # timing: ep_prep vs moe_sorting + quantize_rows
    t_new = C.time_cold(lambda: PR.ep_prep(ti, tw, x, e0=0, block_m=bm, quant=True))
    t_new16 = C.time_cold(lambda: PR.ep_prep(ti, tw, x, e0=0, block_m=bm, quant=False))
    t_old = C.time_cold(lambda: (C.ep_sort(ti, tw, bm, mask), quantize_rows(x)))
    print(f"tok {tokens:6d} bm {bm:3d} {routing:7s}: match {ok} | prep+quant {t_new:6.1f} us "
          f"(sort only {t_new16:6.1f}) | moe_sorting+quantize_rows {t_old:6.1f} us", flush=True)
    return ok


def main():
    p = argparse.ArgumentParser()
    p.add_argument("-t", type=int, nargs="*", default=[1, 16, 256, 1024, 4096, 16384])
    p.add_argument("--bm", type=int, nargs="*", default=[16, 64, 128])
    args = p.parse_args()
    for t in args.t:
        for bm in args.bm:
            check(t, bm)
    check(4096, 64, "hot")


if __name__ == "__main__":
    main()

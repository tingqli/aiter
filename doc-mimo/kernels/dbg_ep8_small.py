"""Debug: check the fused small kernel's gemm1 intermediate rows against the
reference (deterministic token-order layout)."""
import os
import sys

import torch

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ep8_common as C  # noqa: E402
import ep8_moe as EP  # noqa: E402
import ep8_small as S  # noqa: E402
import test_ep8_moe as TT  # noqa: E402

tok = int(sys.argv[1]) if len(sys.argv) > 1 else 16
adt = sys.argv[2] if len(sys.argv) > 2 else "bf16"
maxm = 64
cfg = dict(S.SMALL_CFG, wpc=2)
W, P = TT.weights()
x, tw, ti = C.make_routing(tok)
out = S.ep8_moe_small(x, P, tw, ti, rank=C.RANK, adt=adt, maxm=maxm, cfg=cfg)
torch.cuda.synchronize()
bm = cfg["bm"]
launch, info = S.compile_ep_small(H=C.H, I=C.I, EL=32, TOPK=8, ADT=adt, BM=bm, NW=cfg["nw"],
                                  C1=cfg["c1"], C2=cfg["c2"], PF=cfg["pf"],
                                  ROWV=tuple(cfg["rowv"]), MAXM=maxm, SCH=3, DBG=0)
s = S._scratch(x.device, adt, maxm, C.H, C.I, info["CAP"], info["NMBMAX"])
# host layout: expert e's tokens in increasing order, padded to bm
loc = C.local_ids(ti, C.RANK)  # [M, 8] local expert id or -1
sids = []
seids = []
for e in range(32):
    toks = sorted(set(torch.nonzero((loc == e).any(dim=1)).flatten().tolist()))
    if not toks:
        continue
    rows = toks + [tok] * ((-len(toks)) % bm)
    for i in range(0, len(rows), bm):
        seids.append(e)
    for t in rows:
        slot = int(torch.nonzero(loc[t] == e).flatten()[0]) if t < tok else 8
        sids.append(t | (slot << 24))
sids_t = torch.tensor(sids, dtype=torch.int32, device="cuda")
seids_t = torch.tensor(seids, dtype=torch.int32, device="cuda")
nv = torch.tensor([len(sids), tok], dtype=torch.int32, device="cuda")
if adt == "fp8":
    from a8w4_row_quant import quantize_rows
    x8, xs = quantize_rows(x)
    xf = x8.float() * xs.view(-1, 1)
else:
    xf = x.float()
ref, mask = TT.ref_gemm1(xf, W, sids_t, seids_t, nv, bm, tok)
got = s["inter"][: ref.shape[0]].float()
print("rows", len(sids), "valid", int(mask.sum()))
for r in range(len(sids)):
    if not mask[r]:
        continue
    cd = C.cos_diff(ref[r], got[r])
    if cd > 1e-3:
        print(f"row {r} tok {sids[r] & 0xFFFFFF} expert {seids[r // bm]}: cos {cd:.2e}",
              "ref", ref[r, :4].tolist(), "got", got[r, :4].tolist())
print("inter cos", C.cos_diff(ref[mask], got[mask]))
ref_o = C.ref_moe(x, tw, ti, W, a8w4=adt == "fp8")
print("out cos", C.cos_diff(ref_o, out.float()))
bad = (ref_o - out.float()).abs().amax(dim=1)
print("per-token max abs err", [round(v, 4) for v in bad.tolist()][:32])
# 3-launch gemm2 on the fused kernel's intermediate (host-built sorted layout)
sw = torch.tensor([float(tw[t & 0xFFFFFF, t >> 24]) if (t & 0xFFFFFF) < tok else 0.0
                   for t in sids], dtype=torch.float32, device="cuda")
out2 = torch.zeros((tok, C.H), dtype=torch.bfloat16, device="cuda")
inter = s["inter"][: len(sids)].contiguous()
if adt == "bf16":
    EP.ep_gemm2(inter, None, P, sids_t, sw, seids_t, nv, out2, adt="bf16", block_m=bm,
                no=128, nw=4)
    torch.cuda.synchronize()
    print("3-launch g2 on fused inter: out cos", C.cos_diff(ref_o, out2.float()))
    d = (out.float() - out2.float()).abs().amax(dim=1)
    print("fused vs 3-launch per token", [round(v, 3) for v in d.tolist()][:32])

"""Per-phase ATT breakdown of the fused A8W4 MoE kernel (test_a8w4_fmoe_bm64):
gemm1 (up to the first ds_bpermute = row-data fetch) vs gemm2 (rest).

    python doc-mimo/experiments/fmoe_bm64/att_phases.py <ui_output_dir>
"""
import collections
import glob
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../gemm1_att_bottleneck"))

D = sys.argv[1]
code = json.load(open(os.path.join(D, "code.json")))["code"]
txt = {r[2]: r[0] for r in code}
first_bp = min(ci for ci, s in txt.items() if s.startswith("ds_bpermute"))


def cls(s):
    m = s.split()[0] if s else ""
    if m.startswith("s_waitcnt"):
        return "wait vm" if "vmcnt" in s else "wait lgkm"
    for p, c in (("v_mfma", "mfma"), ("scratch_", "scratch"), ("buffer_load", "vmem ld"),
                 ("global_load", "vmem ld"), ("global_atomic", "atomic"), ("ds_read", "ds rd"),
                 ("ds_write", "ds wr"), ("ds_bpermute", "ds bperm"), ("s_barrier", "barrier"),
                 ("s_nop", "s_nop")):
        if m.startswith(p):
            return c
    if m.startswith("v_"):
        return "valu"
    if m.startswith("s_"):
        return "salu"
    return "other"


ph = {"gemm1": collections.Counter(), "gemm2": collections.Counter()}
cnt = {"gemm1": collections.Counter(), "gemm2": collections.Counter()}
dur = {"gemm1": [], "gemm2": []}
nw = 0
for f in glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json")):
    w = json.load(open(f))["wave"]
    ins = w["instructions"]
    if len(ins) <= 500:
        continue
    nw += 1
    t_split = next((x[0] for x in ins if x[4] >= first_bp and txt[x[4]].startswith("ds_bpermute")),
                   w["end"])
    dur["gemm1"].append(t_split - w["begin"])
    dur["gemm2"].append(w["end"] - t_split)
    for i, (t, _, st, _, ci) in enumerate(ins):
        nxt = ins[i + 1][0] if i + 1 < len(ins) else w["end"]
        p = "gemm1" if t < t_split else "gemm2"
        c = cls(txt.get(ci, ""))
        ph[p][c] += nxt - t
        cnt[p][c] += 1
print(f"{nw} waves; first ds_bpermute at code index {first_bp}")
for p in ("gemm1", "gemm2"):
    tot = sum(ph[p].values())
    d = sorted(dur[p])
    print(f"\n{p}: per wave median {d[len(d) // 2]:.0f} cycles (p10 {d[len(d) // 10]:.0f}, "
          f"p90 {d[9 * len(d) // 10]:.0f})")
    for c, v in ph[p].most_common():
        print(f"  {c:10s} {100 * v / tot:5.1f}%  {v / nw:9.0f} cyc/wave  n/wave {cnt[p][c] / nw:8.1f}")

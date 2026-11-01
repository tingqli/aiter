"""Per-instruction profile of an ATT ui_output dir: for every code.json index, the
mean executions and mean issue-to-next-issue wall cycles per real wave.

    python doc-mimo/experiments/gemm2_att/att_listing.py <ui_output_dir> [min_pct]
"""
import collections
import glob
import json
import os
import sys

D = sys.argv[1]
MIN = float(sys.argv[2]) if len(sys.argv) > 2 else 0.0
code = json.load(open(os.path.join(D, "code.json")))["code"]
txt = {r[2]: r[0] for r in code}
cyc = collections.Counter()
cnt = collections.Counter()
stall = collections.Counter()
nw = 0
for f in glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json")):
    w = json.load(open(f))["wave"]
    ins = w["instructions"]
    if len(ins) <= 500:
        continue
    nw += 1
    for i, (t, _, st, _, ci) in enumerate(ins):
        nxt = ins[i + 1][0] if i + 1 < len(ins) else w["end"]
        cyc[ci] += nxt - t
        cnt[ci] += 1
        stall[ci] += st
tot = sum(cyc.values())
print(f"{nw} real waves, mean {tot / nw:.0f} cycles/wave")
for ci in sorted(txt):
    if ci not in cnt:
        continue
    pct = 100 * cyc[ci] / tot
    if pct < MIN:
        continue
    print(f"[{ci:4d}] x{cnt[ci] / nw:5.2f} {cyc[ci] / nw:8.1f} cyc {pct:5.2f}%  st {stall[ci] / nw:7.1f}  {txt[ci][:100]}")

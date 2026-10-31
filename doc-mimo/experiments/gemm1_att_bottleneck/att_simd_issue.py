"""SIMD issue-port occupancy and K-loop instruction mix of a gemm1 ATT trace.

    python doc-mimo/experiments/gemm1_att_bottleneck/att_simd_issue.py ck_test/ui_output_agent_45475_dispatch_7183

1. Per SIMD, 2000-cycle windows: VALU issue busy = #VALU x 4 cycles / 2000, grouped by
   the number of real waves alive on that SIMD; MFMA issues per window; and the gap
   between consecutive VALU issues on a SIMD (4 cycles = back to back).
2. K-loop body (instructions with the loop branch's hit count in code.json): count
   per mnemonic, VALU vs MFMA.
"""
import collections
import glob
import json
import os
import re
import statistics as st
import sys

D = sys.argv[1]
code = json.load(open(os.path.join(D, "code.json")))["code"]
txt = {r[2]: r[0] for r in code}


def kind(s):
    m = s.split()[0] if s else ""
    if m.startswith("v_mfma"):
        return "mfma"
    return "valu" if m.startswith("v_") else "other"


W = collections.defaultdict(list)
for f in glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json")):
    w = json.load(open(f))["wave"]
    se, sm = map(int, re.findall(r"\d+", os.path.basename(f))[:2])
    if len(w["instructions"]) > 500:
        W[(se, sm)].append(w)

res = collections.defaultdict(list)
gaps = collections.Counter()
for ws in W.values():
    t0 = min(w["begin"] for w in ws)
    t1 = max(w["end"] for w in ws)
    nb = int((t1 - t0) // 2000)
    va, mf, al = [0] * nb, [0] * nb, [0] * nb
    allv = []
    for w in ws:
        for x in w["instructions"]:
            k = kind(txt.get(x[4], ""))
            b = int((x[0] - t0) // 2000)
            if b >= nb:
                continue
            if k == "valu":
                va[b] += 1
                allv.append(x[0])
            elif k == "mfma":
                mf[b] += 1
        for b in range(nb):
            m = t0 + 2000 * (b + 0.5)
            al[b] += w["begin"] <= m < w["end"]
    for b in range(nb):
        res[al[b]].append((va[b] * 4 / 2000, mf[b]))
    allv.sort()
    for a, c in zip(allv, allv[1:]):
        gaps[min(c - a, 40)] += 1
for a in sorted(res):
    v = [u for u, _ in res[a]]
    m = [q for _, q in res[a]]
    print(f"waves alive on SIMD={a}: windows {len(v):4d}  VALU issue busy median "
          f"{st.median(v) * 100:5.1f}%  p90 {sorted(v)[int(0.9 * len(v))] * 100:5.1f}%  "
          f"mfma/2000cyc {st.median(m):.0f}")
tot = sum(gaps.values())
print("gap between consecutive VALU issues on a SIMD (cycles): "
      + ", ".join(f"{g}:{100 * c / tot:.1f}%" for g, c in sorted(gaps.items())[:12]))

# ---- K-loop body from code.json ------------------------------------------------------
rows = sorted(code, key=lambda r: r[2])
br = collections.Counter(x[4] for ws in W.values() for w in ws for x in w["instructions"]
                         if txt.get(x[4], "").startswith("s_cbranch"))
loop = br.most_common(1)[0][0]
h = next(r[6] for r in rows if r[2] == loop)
body = [r for r in rows if r[6] == h and r[2] <= loop]
c = collections.Counter(r[0].split()[0] for r in body)
v = sum(n for k, n in c.items() if k.startswith("v_") and not k.startswith("v_mfma"))
mf = sum(n for k, n in c.items() if k.startswith("v_mfma"))
print(f"\nK-loop body: {len(body)} instr, VALU {v}, MFMA {mf}")
for k, n in c.most_common(20):
    print(f"  {n:4d} {k}")

"""K-loop iteration time (cycles) of a gemm1 ATT trace, grouped by how many real
waves are alive on the same CU and by kernel phase (fraction of the CU span).

    python doc-mimo/experiments/gemm1_att_bottleneck/att_gemm1_iters.py ck_test/ui_output_agent_42008_dispatch_6034
"""
import collections, glob, json, os, re, statistics as st, sys

D = sys.argv[1]
code = json.load(open(os.path.join(D, "code.json")))["code"]
txt = {r[2]: r[0] for r in code}
waves = []
for f in glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json")):
    w = json.load(open(f))["wave"]
    se = int(re.findall(r"\d+", os.path.basename(f))[0])
    waves.append((se, w["begin"], w["end"], w["instructions"]))
real = [w for w in waves if len(w[3]) > 500]
br = collections.Counter(x[4] for w in real for x in w[3] if txt.get(x[4], "").startswith("s_cbranch"))
loop = br.most_common(1)[0][0]
kend = max(w[2] for w in waves)
kbeg = min(w[1] for w in waves)
by_alive = collections.defaultdict(list)
by_phase = collections.defaultdict(list)
for se, b, e, ins in real:
    ts = [x[0] for x in ins if x[4] == loop]
    for a, c in zip(ts, ts[1:]):
        m = (a + c) / 2
        alive = sum(1 for s2, b2, e2, i2 in real if s2 == se and b2 <= m < e2)
        by_alive[alive].append(c - a)
        by_phase[int(10 * (m - kbeg) / (kend - kbeg))].append(c - a)
print(f"{os.path.basename(D)}: kernel span {kend - kbeg} cycles; K-iteration cycles (median, n)")
for k in sorted(by_alive):
    v = by_alive[k]
    print(f"  {k:2d} waves alive on CU: {st.median(v):7.0f}  n={len(v)}")
print("  by kernel phase (decile): " + "  ".join(f"{k}:{st.median(v):.0f}" for k, v in sorted(by_phase.items())))

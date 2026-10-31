"""Analyze a rocprofv3 ATT ui_output dir of an a8w4 gemm1 kernel (standalone or port).

    python doc-mimo/experiments/gemm1_att_bottleneck/att_gemm1.py ck_test/ui_output_agent_42008_dispatch_6173

Prints: clock, per-CU residency (waves alive over time), per-wave lifetime, wall-time
attribution per instruction class (issue-to-next-issue), the K-loop iteration time,
the top stalling instructions, and the bytes each wave loads from global memory.
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
rt = json.load(open(os.path.join(D, "realtime.json")))
se0 = rt["SE0"]
CPU = (se0[1][0] - se0[0][0]) / ((se0[1][1] - se0[0][1]) / rt["metadata"]["frequency"] * 1e6)
print(f"kernel: {code[0][0]}")
print(f"clock: {CPU:.0f} cycles/us (from realtime.json SE0)")

LOAD_BYTES = {
    "buffer_load_dwordx4": 16, "buffer_load_dwordx2": 8, "buffer_load_dword": 4,
    "global_load_dwordx4": 16, "global_load_dwordx2": 8, "global_load_dword": 4,
    "buffer_load_ubyte": 1, "buffer_load_ushort": 2, "global_load_ubyte": 1,
}


def cls(s):
    m = s.split()[0] if s else ""
    if m.startswith("s_waitcnt"):
        if "vmcnt" in s and "lgkmcnt" in s:
            return "waitcnt vm+lgkm"
        return "waitcnt vmcnt" if "vmcnt" in s else "waitcnt lgkmcnt"
    if m == "s_barrier":
        return "s_barrier"
    if m.startswith("v_mfma"):
        return "mfma"
    if m.startswith(("buffer_load", "global_load")):
        return "vmem load"
    if m.startswith(("buffer_store", "global_store", "buffer_atomic", "global_atomic")):
        return "vmem store"
    if m.startswith("ds_read"):
        return "lds read"
    if m.startswith("ds_write"):
        return "lds write"
    if m.startswith(("s_load", "s_buffer_load")):
        return "smem"
    if m == "s_nop":
        return "s_nop"
    if m.startswith("v_"):
        return "valu"
    if m.startswith("s_"):
        return "salu/branch"
    return "other"


waves = []
for f in sorted(glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json"))):
    w = json.load(open(f))["wave"]
    ins = w["instructions"]
    se, sm, sl, wv = map(int, re.findall(r"\d+", os.path.basename(f))[:4])
    waves.append(dict(se=se, simd=sm, slot=sl, b=w["begin"], e=w["end"], ins=ins))

real = [w for w in waves if len(w["ins"]) > 500]
print(f"waves traced: {len(waves)}  (with >500 instructions: {len(real)})")

# ---- residency per CU ----------------------------------------------------------
for se in sorted({w["se"] for w in waves}):
    ws = [w for w in waves if w["se"] == se]
    t0 = min(w["b"] for w in ws)
    t1 = max(w["e"] for w in ws)
    rw = [w for w in ws if len(w["ins"]) > 500]
    starts = sorted(round((w["b"] - t0) / CPU, 1) for w in rw)
    ends = sorted(round((w["e"] - t0) / CPU, 1) for w in rw)
    print(f"SE{se} CU0: span {(t1 - t0) / CPU:6.1f} us, real waves {len(rw)} "
          f"(WG ~{len(rw) / 4:.1f}), empty {len(ws) - len(rw)}")
    print(f"   real-wave start us: {starts}")
    print(f"   real-wave end   us: {ends}")
    # waves alive per SIMD vs time (10 buckets)
    nb = 10
    alive = []
    for k in range(nb):
        t = t0 + (t1 - t0) * (k + 0.5) / nb
        alive.append(sum(1 for w in rw if w["b"] <= t < w["e"]))
    print(f"   real waves alive on CU at 5%,15%..95% of span: {alive}")

# ---- per-wave wall attribution -----------------------------------------------------
life = [(w["e"] - w["b"]) / CPU for w in real]
print(f"\nreal-wave lifetime us: median {st.median(life):.1f}  min {min(life):.1f}  max {max(life):.1f}")
agg = collections.Counter()
cnt = collections.Counter()
stall_by_ci = collections.Counter()
nbytes = []
for w in real:
    ins = w["ins"]
    b = 0
    for i, x in enumerate(ins):
        t, _, stall, dur, ci = x
        nxt = ins[i + 1][0] if i + 1 < len(ins) else w["e"]
        c = cls(txt.get(ci, ""))
        agg[c] += nxt - t
        cnt[c] += 1
        stall_by_ci[ci] += nxt - t
        m = txt.get(ci, "").split()[0] if txt.get(ci) else ""
        b += LOAD_BYTES.get(m, 0) * 64
    nbytes.append(b)
tot = sum(agg.values())
print(f"\nwall time per real wave by class (issue-to-next-issue), {len(real)} waves:")
for c, v in agg.most_common():
    print(f"  {c:<18} {v / len(real) / CPU:7.2f} us  {100 * v / tot:5.1f}%   instr/wave {cnt[c] / len(real):7.1f}")
print(f"\nglobal bytes loaded per real wave: median {st.median(nbytes) / 1024:.1f} KB "
      f"-> per-wave BW {st.median(nbytes) / st.median(life) / 1e3:.2f} GB/s")

print("\ntop instructions by wall time (all real waves):")
for ci, v in stall_by_ci.most_common(14):
    print(f"  {100 * v / tot:5.1f}%  [{ci:4d}] {txt.get(ci, '')[:90]}")

# ---- K-loop iterations: find the most-executed backward branch -----------------------
br = collections.Counter()
for w in real:
    for x in w["ins"]:
        s = txt.get(x[4], "")
        if s.startswith("s_cbranch"):
            br[x[4]] += 1
if br:
    loop_ci, n = br.most_common(1)[0]
    print(f"\nmost-executed branch [{loop_ci}] {txt[loop_ci][:60]}: {n / len(real):.1f}/wave")
    its = []
    for w in real:
        ts = [x[0] for x in w["ins"] if x[4] == loop_ci]
        its += [(b - a) / CPU for a, b in zip(ts, ts[1:])]
    if its:
        its.sort()
        print(f"   iteration time us: median {st.median(its):.2f}  p10 {its[len(its) // 10]:.2f}  "
              f"p90 {its[9 * len(its) // 10]:.2f}  (n={len(its)})")

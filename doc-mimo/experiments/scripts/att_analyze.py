"""Analyze a rocprofv3 ATT (thread trace) ui_output dir of the fused gemm2+AR kernel.

    python doc-mimo/experiments/scripts/att_analyze.py ck_test/ui_output_agent_52389_dispatch_3909

Per wave: classify (empty tile / gemm / comm) by the code it executed, attribute
wall time (issue-to-next-issue) to code regions, print per-class region
breakdown, wave-lifetime stats, per-CU residency timeline and the top stalls.
"""
import collections
import glob
import json
import os
import sys

D = sys.argv[1]
code = json.load(open(os.path.join(D, "code.json")))["code"]
txt = [r[0] for r in code]


def find(pred, start=0):
    for i in range(start, len(txt)):
        if pred(txt[i]):
            return i
    raise KeyError


# region boundaries from the code layout (see doc section 10)
i_exit = find(lambda s: s.startswith("s_endpgm"))  # empty-tile / comm exit
i_comm = None
for i, r in enumerate(code):
    if r[6] and i > i_exit and code[i - 1][0].startswith("s_cbranch_scc1") and r[6] < 64:
        i_comm = i  # first comm-only instruction (after the gemm tail branch-back)
        break
i_atom0 = find(lambda s: "global_atomic_pk_add_bf16" in s)
i_hook = max(i for i in range(i_comm) if txt[i].startswith("s_barrier")) - 1  # vmcnt(0)
i_epi = max(i for i in range(i_atom0) if txt[i].startswith("s_barrier"))  # LDS C-tile staged


def region(ci):
    if ci <= i_exit:
        return "0 prologue"
    if ci >= i_comm:
        return "9 comm"
    if ci >= i_hook:
        return "6 tile hook (vmcnt0+barrier+cnt atomic)"
    if ci > i_epi:
        return "5 epilogue atomics"
    return "1 load+mfma+scale (to C-tile in LDS)"


waves = []
fn = json.load(open(os.path.join(D, "filenames.json")))["wave_filenames"]
for f in glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json")):
    w = json.load(open(f))
    wv = w["wave"]
    ins = wv["instructions"]
    if not ins:
        continue
    se = int(os.path.basename(f).split("_")[0][2:])
    cis = {x[4] for x in ins}
    kind = "comm" if max(cis) >= i_comm else ("gemm" if max(cis) > i_exit else "empty")
    reg = collections.Counter()
    for a, b in zip(ins, ins[1:] + [[wv["end"], 0, 0, 0, ins[-1][4]]]):
        reg[region(a[4])] += b[0] - a[0]
    waves.append(dict(se=se, cu=wv["cu"], simd=int(os.path.basename(f).split("_")[1][2:]),
                      begin=wv["begin"], end=wv["end"], first=ins[0][0], kind=kind, reg=reg))

rt = json.load(open(os.path.join(D, "realtime.json")))
(g0, r0), (g1, r1) = rt["SE0"]
cyc_per_us = (g1 - g0) / ((r1 - r0) / rt["metadata"]["frequency"] * 1e6)
t0 = min(w["begin"] for w in waves)
t1 = max(w["end"] for w in waves)
us = lambda c: c / cyc_per_us  # noqa: E731
print(f"clock {cyc_per_us:.0f} cyc/us; traced span {us(t1 - t0):.1f} us; waves {len(waves)}")

by = collections.defaultdict(list)
for w in waves:
    by[w["kind"]].append(w)
for k, ws in sorted(by.items()):
    life = sorted(w["end"] - w["begin"] for w in ws)
    tot = collections.Counter()
    for w in ws:
        tot.update(w["reg"])
    n = len(ws)
    print(f"\n[{k}] {n} waves  lifetime us: min {us(life[0]):.2f} med {us(life[n // 2]):.2f} "
          f"max {us(life[-1]):.2f}  (dispatch->first issue med "
          f"{us(sorted(w['first'] - w['begin'] for w in ws)[n // 2]):.2f})")
    s = sum(tot.values())
    for r, v in sorted(tot.items()):
        print(f"    {r:44s} {us(v / n):7.2f} us/wave  {100 * v / s:5.1f}%")

# residency timeline: waves resident per (se) CU in 10 time bins, by kind
print("\nresident waves per traced CU (avg over the 4 SEs), 20 bins over the span:")
nb = 20
for k in ("gemm", "comm", "empty"):
    row = []
    for b in range(nb):
        a = t0 + (t1 - t0) * b / nb
        e = t0 + (t1 - t0) * (b + 1) / nb
        occ = sum(max(0, min(w["end"], e) - max(w["begin"], a)) for w in by[k]) / (e - a) / 4
        row.append(f"{occ:4.1f}")
    print(f"  {k:5s} " + " ".join(row))
print("  bin us " + " ".join(f"{us((t1 - t0) * (b + 1) / nb):4.0f}" for b in range(nb)))

# per-CU: last gemm wave end vs comm end
for se in sorted({w["se"] for w in waves}):
    g = [w for w in by["gemm"] if w["se"] == se]
    c = [w for w in by["comm"] if w["se"] == se]
    print(f"  SE{se}: gemm waves {len(g):3d} last end {us(max(w['end'] for w in g) - t0):6.1f} us"
          + (f" | comm waves {len(c)} begin {us(min(w['begin'] for w in c) - t0):5.1f} "
             f"end {us(max(w['end'] for w in c) - t0):6.1f} us" if c else ""))

print("\ntop stalls (code.json, summed over traced waves):")
rows = sorted(((r[8], i) for i, r in enumerate(code) if r[6]), reverse=True)[:25]
for st, i in rows:
    r = code[i]
    print(f"  {i:5d} {region(i)[:22]:22s} hits {r[6]:4d} stall/hit {r[8] / r[6]:8.0f} cyc  {r[0][:70]}")

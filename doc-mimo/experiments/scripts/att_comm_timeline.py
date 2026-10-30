"""Per-unit timeline of the fused kernel's comm WGs from a rocprofv3 ATT ui_output dir.

    python doc-mimo/experiments/scripts/att_comm_timeline.py ck_test/ui_output_agent_56655_dispatch_3909

Locates the comm role's landmark instructions in code.json by pattern (spin-poll
load, barriers, RS/AG store drains, flag swaps, final AG wait), then walks every
traced comm wave and prints, per unit (q loop iteration), when each phase ended
relative to the kernel's first traced wave, plus per-phase averages.
"""
import collections
import glob
import json
import os
import sys

D = sys.argv[1]
code = json.load(open(os.path.join(D, "code.json")))["code"]
txt = [r[0] for r in code]
hits = [r[6] for r in code]

# comm entry: first instruction after the compute tail's branch-back with few hits
i_comm = next(
    i for i in range(1000, len(code))
    if 0 < hits[i] <= 64 and txt[i - 1].startswith("s_cbranch_scc1")
)
comm = range(i_comm, len(code))


def find_all(pred):
    return [i for i in comm if pred(txt[i])]


barriers = find_all(lambda s: s.startswith("s_barrier"))
vm0 = find_all(lambda s: s.startswith("s_waitcnt vmcnt(0)") and "lgkmcnt" not in s)
swaps = find_all(lambda s: s.startswith("global_atomic_swap"))
sleeps = find_all(lambda s: s.startswith("s_sleep"))
polls = [i + 1 for i in sleeps]  # the load right after each s_sleep
assert len(barriers) >= 4 and len(swaps) >= 2, (barriers, swaps)
L = dict(
    loop_top=next(i for i in comm if txt[i].startswith("s_add_i32") and "64" in txt[i]) - 1,
    poll=polls[0],                 # chunk-counter poll load (after s_sleep)
    bar_chunk=barriers[0],         # waves 1-3 wait here for wave 0's poll
    rs_drain=[i for i in vm0 if barriers[0] < i < barriers[1]][-1],  # RS stores acked
    bar_rs=barriers[1],
    rs_swap=swaps[0],              # publish rs[q][rank] on every peer
    bar_flags=barriers[2],         # wait rs[q][*] (lanes < npes), then barrier
    ag_drain=[i for i in vm0 if barriers[2] < i < barriers[3]][-1],  # AG stores acked
    bar_ag=barriers[3],
    ag_swap=swaps[1],
    endpgm=len(code) - 1,
)
print("landmarks:", {k: (v, txt[v][:40]) for k, v in L.items()})

rt = json.load(open(os.path.join(D, "realtime.json")))
(g0, r0), (g1, r1) = rt["SE0"]
cyc_us = (g1 - g0) / ((r1 - r0) / rt["metadata"]["frequency"] * 1e6)

waves = []
for f in sorted(glob.glob(os.path.join(D, "se*_sm*_sl*_wv*.json"))):
    w = json.load(open(f))["wave"]
    if w["instructions"]:
        waves.append((os.path.basename(f), w))
t0 = min(w["begin"] for _, w in waves)
us = lambda c: (c - t0) / cyc_us  # noqa: E731

gemm_end = collections.defaultdict(float)
for name, w in waves:
    if max(x[4] for x in w["instructions"]) < i_comm and len(w["instructions"]) > 50:
        se = name.split("_")[0]
        gemm_end[se] = max(gemm_end[se], us(w["end"]))

phase_tot = collections.defaultdict(list)
for name, w in waves:
    ins = w["instructions"]
    if max(x[4] for x in ins) < i_comm:
        continue
    se = name.split("_")[0]
    nxt = {}  # issue time of the instruction after index i (= when i completed)
    units, cur = [], None
    for a, b in zip(ins, ins[1:] + [[w["end"], 0, 0, 0, -1]]):
        i = a[4]
        if i == L["bar_chunk"] + 1 or (i == L["loop_top"] + 1 and cur is None):
            pass
        if i == L["poll"] or i == L["bar_chunk"]:
            if cur is None or "ag_done" in cur:
                cur = {"start": a[0], "polls": 0}
                units.append(cur)
            if i == L["poll"]:
                cur["polls"] += 1
        if cur is None:
            continue
        for key, idx in (("chunk_ready", L["bar_chunk"]), ("rs_acked", L["rs_drain"]),
                         ("rs_bar", L["bar_rs"]), ("flags_ok", L["bar_flags"]),
                         ("ag_acked", L["ag_drain"]), ("ag_done", L["bar_ag"])):
            if i == idx:
                cur[key] = b[0]  # completion = next issue
    print(f"\n{name}  (gemm waves on {se} end at {gemm_end[se]:.1f} us)  begin {us(w['begin']):.1f} end {us(w['end']):.1f} us")
    print("   unit  start  chunk_ready  rs_acked  rs_barrier  rs_flags_ok  ag_acked  ag_done   polls")
    prev = None
    for k, u in enumerate(units):
        if "ag_done" not in u:
            continue
        print(f"   {k:4d} {us(u['start']):6.1f} {us(u['chunk_ready']):11.1f} {us(u['rs_acked']):9.1f}"
              f" {us(u['rs_bar']):10.1f} {us(u['flags_ok']):11.1f} {us(u['ag_acked']):9.1f} {us(u['ag_done']):8.1f}   {u['polls']}")
        seq = [("wait chunk", u["start"], u["chunk_ready"]),
               ("RS load+push+ack", u["chunk_ready"], u["rs_acked"]),
               ("RS barrier", u["rs_acked"], u["rs_bar"]),
               ("publish rs + wait rs flags", u["rs_bar"], u["flags_ok"]),
               ("reduce + AG push + ack", u["flags_ok"], u["ag_acked"]),
               ("AG barrier", u["ag_acked"], u["ag_done"])]
        for n, a, b in seq:
            phase_tot[n].append((b - a) / cyc_us)
    print(f"   final AG wait + exit: {(w['end'] - units[-1]['ag_done']) / cyc_us:.2f} us")

print("\nper-unit phase averages over all traced comm waves (us):")
for n, v in phase_tot.items():
    print(f"   {n:28s} avg {sum(v) / len(v):6.2f}  min {min(v):6.2f}  max {max(v):6.2f}  (n={len(v)})")

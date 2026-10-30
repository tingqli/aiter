"""Wave-slot gap analysis from a rocprofv3 ATT ui_output dir.

    python doc-mimo/experiments/scripts/att_slot_gaps.py ck_test/ui_output_agent_56655_dispatch_3909

For every hardware wave slot (SE, SIMD, slot) of the traced CUs: the waves that ran
on it in order, the idle gap between one wave's end and the next wave's begin, and
how much slot time is idle while the gemm2 phase is still running. Waves are
classified by instruction count / lifetime: comm (> 20 us), empty tile (< 1 us),
gemm tile (rest).
"""
import collections
import json
import os
import sys

D = sys.argv[1]
fn = json.load(open(os.path.join(D, "filenames.json")))["wave_filenames"]
rt = json.load(open(os.path.join(D, "realtime.json")))
(g0, r0), (g1, r1) = rt["SE0"]
cyc_us = (g1 - g0) / ((r1 - r0) / rt["metadata"]["frequency"] * 1e6)

slots = collections.defaultdict(list)  # (se, simd, slot) -> [(begin, end, kind)]
for se, a in fn.items():
    for simd, b in a.items():
        for slot, c in b.items():
            for _, (f, beg, end) in c.items():
                life = (end - beg) / cyc_us
                kind = "comm" if life > 20 else ("empty" if life < 1 else "gemm")
                slots[se, simd, slot].append((beg, end, kind))

allw = [w for v in slots.values() for w in v]
t0 = min(w[0] for w in allw)
gemm_end = {se: max(w[1] for k, v in slots.items() if k[0] == se for w in v if w[2] == "gemm")
            for se in {k[0] for k in slots}}
us = lambda c: c / cyc_us  # noqa: E731

gaps = collections.defaultdict(list)  # (prev kind, next kind) -> [gap us]
busy = idle = 0.0
for (se, simd, slot), ws in sorted(slots.items()):
    ws.sort()
    end_g = gemm_end[se]
    if any(w[2] == "comm" for w in ws):
        continue  # slot held by a comm wave for the whole kernel
    prev_end = None
    for beg, end, kind in ws:
        if beg > end_g:
            break
        if prev_end is not None:
            gaps[prev_kind, kind].append(us(beg - prev_end))
            idle += beg - prev_end
        busy += min(end, end_g) - beg
        prev_end, prev_kind = end, kind

print(f"clock {cyc_us:.0f} cyc/us, {len(slots)} slots, gemm phase ends at "
      + ", ".join(f"SE{se} {us(v - t0):.1f}" for se, v in sorted(gemm_end.items())) + " us")
print(f"slot time during the gemm phase (between first and last wave of each slot): "
      f"busy {us(busy):.0f} us, idle gaps {us(idle):.0f} us -> {100 * idle / (busy + idle):.1f}% idle")
print("gap between consecutive waves on a slot (us):")
for k, v in sorted(gaps.items(), key=lambda kv: -len(kv[1])):
    v = sorted(v)
    n = len(v)
    print(f"  {k[0]:5s} -> {k[1]:5s} n={n:4d}  min {v[0]:.2f}  p25 {v[n // 4]:.2f}  med {v[n // 2]:.2f}"
          f"  p75 {v[3 * n // 4]:.2f}  p90 {v[9 * n // 10]:.2f}  max {v[-1]:.2f}  sum {sum(v):.0f}")

# waves of one WG (same CU, begin within 64 cycles) end at different times: how long
# do early-finished sibling slots sit idle until the WG's last wave ends?
occ = json.load(open(os.path.join(D, "occupancy.json")))
print(f"\noccupancy.json events per SE: " + ", ".join(f"SE{k} {len(v)}" for k, v in occ.items()))

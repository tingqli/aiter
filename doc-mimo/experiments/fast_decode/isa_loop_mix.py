"""Instruction mix of the hottest loop in a FlyDSL ISA dump (21_final_isa.s).

    python doc-mimo/experiments/fast_decode/isa_loop_mix.py /tmp/fdump/<kernel>/21_final_isa.s

The K loop is taken as the largest block between a label and a backward
s_cbranch to it. Also prints VGPR / AGPR counts from the kernel descriptor.
"""
import collections
import re
import sys

lines = open(sys.argv[1]).read().splitlines()
labels = {}
best = None
for i, l in enumerate(lines):
    m = re.match(r"^(\.LBB\S+):", l)
    if m:
        labels[m.group(1)] = i
    m = re.match(r"^\s+s_cbranch_\w+\s+(\.LBB\S+)", l)
    if m and m.group(1) in labels and labels[m.group(1)] < i:
        span = (labels[m.group(1)], i)
        if best is None or span[1] - span[0] > best[1] - best[0]:
            best = span
body = [l.split()[0] for l in lines[best[0] + 1: best[1] + 1]
        if l.strip() and not l.strip().startswith((";", ".")) and not l.endswith(":")]
c = collections.Counter(body)
valu = sum(n for k, n in c.items() if k.startswith("v_") and not k.startswith("v_mfma"))
mfma = sum(n for k, n in c.items() if k.startswith("v_mfma"))
print(f"loop lines {best}: {len(body)} instr, VALU {valu}, MFMA {mfma}")
print("  " + ", ".join(f"{k} {n}" for k, n in c.most_common(14)))
for key in (".vgpr_count", ".agpr_count", ".sgpr_count", "NumVgprs", "NumAgprs", "Occupancy"):
    v = [l.strip() for l in lines if key in l]
    if v:
        print("  " + v[0])

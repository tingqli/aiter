"""Static instruction mix of a whole kernel in a FlyDSL ISA dump (21_final_isa.s).

    python doc-mimo/experiments/fast_decode/isa_mix.py /tmp/fdump/*/21_final_isa.s
"""
import collections
import os
import sys

for path in sys.argv[1:]:
    c = collections.Counter()
    regs = []
    for l in open(path):
        t = l.strip().split()
        if ".vgpr_count" in l or ".agpr_count" in l:
            regs.append(l.strip().lstrip("- "))
        if not t or t[0].startswith((";", ".")) or t[0].endswith(":"):
            continue
        m = t[0]
        c["mfma" if m.startswith("v_mfma") else "valu" if m.startswith("v_") else "other"] += 1
        if m in ("v_perm_b32", "v_mul_lo_u32", "v_cndmask_b32_e64"):
            c[m] += 1
    print(f"{os.path.basename(os.path.dirname(path))}: {dict(c)} {regs[:2]}")

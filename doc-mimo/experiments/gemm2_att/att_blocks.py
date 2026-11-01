"""Basic-block summary of att_listing.py output: consecutive code.json indices with
the same execution count form a block; prints cycles/wave and instruction mix.

    python doc-mimo/experiments/gemm2_att/att_listing.py <dir> > listing.txt
    python doc-mimo/experiments/gemm2_att/att_blocks.py listing.txt
"""
import re
import sys

KINDS = [("v_mfma", "mfma"), ("ds_write", "dsw"), ("ds_read", "dsr"), ("s_barrier", "bar"),
         ("global_atomic", "atom"), ("buffer_load", "ld"), ("global_load", "ld"),
         ("s_waitcnt", "wait"), ("v_perm", "perm")]
rows = []
for line in list(open(sys.argv[1]))[1:]:
    m = re.match(r"\[\s*(\d+)\] x\s*([\d.]+)\s+([\d.]+) cyc\s+([\d.]+)%\s+st\s+([\d.]+)\s+(.*)", line)
    rows.append((int(m[1]), float(m[2]), float(m[3]), m[6].rstrip()))
blocks, cur = [], None
for ci, x, cyc, s in rows:
    if cur is None or abs(x - cur["x"]) > 0.005 or ci != cur["end"] + 1:
        cur = dict(start=ci, end=ci, x=x, cyc=0.0, n=0, kinds={})
        blocks.append(cur)
    cur["end"], cur["cyc"], cur["n"] = ci, cur["cyc"] + cyc, cur["n"] + 1
    op = s.split()[0]
    for p, k in KINDS:
        if op.startswith(p):
            cur["kinds"][k] = cur["kinds"].get(k, 0) + 1
    if op.startswith("v_") and not op.startswith("v_mfma"):
        cur["kinds"]["valu"] = cur["kinds"].get("valu", 0) + 1
tot = sum(b["cyc"] for b in blocks)
for b in blocks:
    print(f"[{b['start']:4d}-{b['end']:4d}] x{b['x']:.2f} n{b['n']:4d} {b['cyc']:8.0f} cyc "
          f"{100 * b['cyc'] / tot:5.1f}%  {b['kinds']}")

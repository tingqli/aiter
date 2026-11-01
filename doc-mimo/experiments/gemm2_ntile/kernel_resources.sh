#!/bin/bash
# Kernel durations + VGPR/AGPR/LDS of every gemm2 variant run by bench_ntile.py.
#   bash doc-mimo/experiments/gemm2_ntile/kernel_resources.sh [bench_ntile.py args]
set -e
cd "$(dirname "$0")/../../.."
OUT=/tmp/kt_gemm2_ntile
rm -rf $OUT
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim rocprofv3 --kernel-trace \
  --output-format csv -d $OUT -o run -- \
  python3 doc-mimo/experiments/gemm2_ntile/bench_ntile.py "${@:--t 8192}" > /dev/null 2>&1
python3 - "$(find $OUT -name '*kernel_trace.csv' | head -1)" <<'EOF'
import collections, csv, sys
d = collections.defaultdict(list); meta = {}
for x in csv.DictReader(open(sys.argv[1])):
    n = x["Kernel_Name"]
    if "gemm2" in n:
        d[n].append((int(x["End_Timestamp"]) - int(x["Start_Timestamp"])) / 1e3)
        meta[n] = {k: x[k] for k in ("VGPR_Count", "Accum_VGPR_Count", "SGPR_Count",
                                     "LDS_Block_Size", "Grid_Size_X")}
for n, v in d.items():
    v.sort()
    print(f"{n.split('_fd2')[-1][:40]:40s} n={len(v):3d} median {v[len(v)//2]:7.1f} us | {meta[n]}")
EOF

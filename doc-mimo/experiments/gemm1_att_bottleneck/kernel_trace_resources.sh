#!/bin/bash
# Kernel durations + register/LDS resources of the gemm1 kernels (no ATT).
#   bash doc-mimo/experiments/gemm1_att_bottleneck/kernel_trace_resources.sh
set -e
cd "$(dirname "$0")/../../.."
OUT=/tmp/kt_gemm1
rm -rf $OUT
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim rocprofv3 --kernel-trace \
  --output-format csv -d $OUT -o run -- \
  python3 doc-mimo/kernels/test_a8w4_gemm1.py -s 4096,512,256,8 -t 512 -r uniform \
  --tile 32,128,0 > /dev/null 2>&1
python3 - "$(find $OUT -name '*kernel_trace.csv' | head -1)" <<'EOF'
import collections, csv, sys
d = collections.defaultdict(list); meta = {}
for x in csv.DictReader(open(sys.argv[1])):
    n = x["Kernel_Name"]
    if "gemm1" in n:
        d[n].append((int(x["End_Timestamp"]) - int(x["Start_Timestamp"])) / 1e3)
        meta[n] = {k: x[k] for k in ("VGPR_Count", "Accum_VGPR_Count", "SGPR_Count",
                                     "LDS_Block_Size", "Grid_Size_X")}
for n, v in d.items():
    v.sort()
    print(f"{n[:90]} n={len(v)} median {v[len(v)//2]:.1f} us min {v[0]:.1f} | {meta[n]}")
EOF

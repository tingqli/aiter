#!/bin/bash
# Dump the final ISA of all gemm1 / gemm2 variants (original, tile, fd1, fd2) and
# print their instruction mixes.
#   bash doc-mimo/experiments/fast_decode/isa_dump.sh
set -e
cd "$(dirname "$0")/../../.."
HERE=doc-mimo/experiments/fast_decode
rm -rf /tmp/fdump /tmp/fcache
export FLYDSL_DUMP_IR=1 FLYDSL_DEBUG_DUMP_ASM=1 FLYDSL_DUMP_DIR=/tmp/fdump
export FLYDSL_RUNTIME_CACHE_DIR=/tmp/fcache  # fresh cache: otherwise nothing is dumped
export PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim
python3 - > /tmp/fdump.log 2>&1 <<'EOF'
import sys; sys.path.insert(0, "doc-mimo/kernels")
import test_a8w4_gemm1 as T1, test_a8w4_gemm2 as T2
T1.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=32, tile_n=128)
T2.bench_a8w4_gemm2(512, 4096, 512, 256, 8, routing="uniform", tile_m=32, dyn_rows=False)
EOF
echo "== gemm1 K-loop mix"
for k in /tmp/fdump/a8w4_gemm1_*; do
  echo "-- $(basename $k)"; python3 $HERE/isa_loop_mix.py $k/21_final_isa.s
done
echo "== gemm2 whole-kernel mix"
python3 $HERE/isa_mix.py /tmp/fdump/a8w4_gemm2_*/21_final_isa.s

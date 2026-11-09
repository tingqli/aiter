#!/bin/bash
# Extract the reference FP8 blockscale kernels (branch tq/moe_gemm_blockscale,
# commit 50ed9814c2) unmodified into $1/bsref (default /tmp/bs_ref_pkg/bsref).
# ab_gemm1.py / ref_baseline.py import them from there (env BS_REF_PKG).
set -e
dst=${1:-/tmp/bs_ref_pkg}
mkdir -p "$dst/bsref"
git archive 50ed9814c2 aiter/ops/flydsl/kernels/moe_gemm_2stage/gfx9_fp8 \
  | tar -x -C "$dst/bsref" --strip-components=6
# The package __init__ imports kernels these scripts do not use.
echo '"""Reference (tq/moe_gemm_blockscale 50ed9814c2) FP8 blockscale kernels, unmodified."""' \
  > "$dst/bsref/__init__.py"
echo "reference kernels in $dst/bsref"

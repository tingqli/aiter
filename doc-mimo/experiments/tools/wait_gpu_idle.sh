#!/usr/bin/env bash
# Block until every GPU is idle for IDLE_CHECKS consecutive polls, POLL s apart:
#   - GPU use <= MAX_USE % on every GPU, and
#   - no KFD process with non-zero CU occupancy or holding > MAX_VRAM_GB of VRAM
#     (bursty foreign jobs: ~150 GB each, can read 0% use between bursts; small
#     idle VRAM holders, e.g. ~3.5 GB, do not count).
#   doc-mimo/experiments/tools/wait_gpu_idle.sh && <benchmark command>
MAX_USE=${MAX_USE:-5}
MAX_VRAM_GB=${MAX_VRAM_GB:-20}
POLL=${POLL:-60}
IDLE_CHECKS=${IDLE_CHECKS:-3}
ok=0
while (( ok < IDLE_CHECKS )); do
    busy=$(rocm-smi --showuse 2>/dev/null | awk -F': ' '/GPU use/ {if ($NF+0 > '"$MAX_USE"') n++} END {print n+0}')
    procs=$(rocm-smi --showpids 2>/dev/null | awk -v lim="$MAX_VRAM_GB" \
        '$1 ~ /^[0-9]+$/ && ($NF+0 > 0 || $4+0 > lim * 1e9) {n++} END {print n+0}')
    if (( busy == 0 && procs == 0 )); then
        ok=$((ok + 1))
    else
        ok=0
        echo "$(date +%T) GPUs busy: ${busy} GPU(s) > ${MAX_USE}% use, ${procs} busy/large process(es); waiting ${POLL}s"
    fi
    (( ok < IDLE_CHECKS )) && sleep "$POLL"
done
echo "$(date +%T) GPUs idle"

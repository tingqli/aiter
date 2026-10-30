#!/bin/bash
# profile_wrapper.sh
if [ "$LOCAL_RANK" == "0" ]; then
    # 只在 rank 0 上启用 rocprofv3
    # exec rocprofv3 --kernel-trace --output-format csv -d results/%pid% -- python "$@"
    exec rocprofv3 -i ./trace.yaml -- python "$@"
else
    # 其他 rank 正常执行，不加 profile
    exec python "$@"
fi

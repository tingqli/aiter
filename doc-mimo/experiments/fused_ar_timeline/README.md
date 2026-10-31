# fused_ar_timeline：融合 kernel 内部的 chunk 与 comm unit 时间线

## 结论

融合 kernel 剩下的瓶颈有三个：

1. **gemm2 自身被拖慢。** 融合 kernel 内 gemm2 的 tile 在 512 tokens 时约 73–75 us 结束（单独跑约 67），2048 tokens 时 180 vs 166。原因有：
   - tile 顺序 `g` 加计数器，约 +2 至 +5 us；
   - comm 代码让 kernel 的 VGPR 从 72 涨到 78；
   - xGMI 和 HBM 流量互相争抢。
2. **每个 unit 的同步延迟高。** 从看到 chunk 完成到 rs flag 到齐要 4–15 us，其中一部分是各 rank 的 gemm 进度差。2048 tokens 时通讯只跑到约 146 GB/s（单独的 two-shot 约 248），通讯越来越落后于 gemm，尾巴约 29 us。
3. **最后一个 chunk 无法掩盖。** 512 tokens 时约 8 us（判定 + RS 握手 + 规约 + AG）。128 tokens 时这段尾巴和 13 us 的 all-reduce 相当，所以几乎没有收益。

## 实验

`fused_timeline.py`（8 卡，torchrun；会自动设置 `AR_PROBE=1`）。在 rank 0 上用 `s_memrealtime` 探针记录：

- 每个 512 列 chunk 被 gemm2 写完（final）的时刻；
- comm unit 各阶段的结束时刻：开始、看到 chunk ready、RS 握手完成、整个 unit 完成；

全部以 kernel 起点为基准，并输出 gemm2 最后一个 tile 的结束时刻和最后一个 unit 的完成时刻。可以叠加 `CWG`、`VPT`、`SPLIT`、`CHUNK`、`ROUTE` 等配置。

```bash
CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/experiments/fused_ar_timeline/fused_timeline.py 512 2048
```

## 结果（`results/`）

- `fused_timeline_v2.txt`、`fused_timeline_v3.txt`：v1 kernel 在不同 cwg 和 chunk 配置下的时间线。例如 512 tokens、cwg 32 时，gemm2 tile 在 75.0 us 结束，最后一个 unit 在 82.9 us 完成。
- 后续实验的时间线放在各自目录：`../fused_ar_comm_help`、`../fused_ar_route`；最终复测的时间线在 `../fused_ar_final_recheck`（E 组）。

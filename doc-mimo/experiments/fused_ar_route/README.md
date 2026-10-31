# fused_ar_route：把 topk 求和移到通讯阶段（mega_moe_tp 的 route 模式）

## 结论

- **gemm2 本身变快了：** 不用 atomic，也不用清零 `moe_buf`，单独跑时 512 tokens 下 71.8 → 64.8 us，2048 tokens 下 179.8 → 161.0 us。
- **但通讯变慢更多，整体比 atomic 方式慢 3–16 us，不建议用。** reduce-scatter 时每个输出向量要读 8 行 route，而且全部 L2 未命中，每个 unit 从看到 chunk ready 到 RS 握手完成由 6–10 us 涨到 13–25 us。
- **调参无效：** comm WG 加到 128 / 192 / 256、每批 2 / 4 / 8 个 peer（`ROUTE_BATCH`）、512 列 chunk，结果都在 96–103 us（512 tokens）和 241–285 us（2048 tokens）之间。
- 根本原因：topk 求和原本由约 8000 个 compute WG 并行做 atomic，现在挪到几十个 comm WG 上，正好压在通讯这条关键路径上。mega_moe_tp 的通讯由常驻 CTA 里大量空闲 wave 动态认领，并行度远高于这里的 64 个 comm WG。
- **精度：** 每个 rank 在 fp32 下求和、只舍入一次 bf16，好于 atomic 方式的 8 次 bf16 累加。参考结果按同样的舍入点计算后 bad=0。

## 实验

`ROUTE=8`（`ar_config(..., route=topk)`）：

- gemm2 用 `_route_bf16_epilog`，把每个路由行 (token, k) 的加权结果写到 `route[token*topk + k]`，用 sc0|sc1 写穿；
- comm 侧用 `_load_partial` 读出每个 token 的 8 行，fp32 求和后再推送。

FlyDSL 的坑：`buffer_store` 一个 `vector<1xi32>` 会让指令选择崩溃，要改存标量 i32。

```bash
ROUTE=8 CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 512 1024 2048
ROUTE=8 CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/experiments/fused_ar_timeline/fused_timeline.py 512 2048
```

## 结果（`results/`，单位 us）

`gemm2_ar_route_sweep.txt`：

| tokens | 依次执行 | gemm2 单独（atomic） | gemm2 单独（route） | 融合（atomic） | 融合（route） |
|---|---|---|---|---|---|
| 128 | 72.2 | 55.8 | 54.5 | 75.4 | 78.6 |
| 512 | 102.8 | 71.8 | 64.8 | **92.8** | 97.3 |
| 1024 | 164.0 | 105.1 | 98.0 | **136.8** | 148.6 |
| 2048 | 281.6 | 179.8 | 161.0 | **237.9** | 254.3 |

- `gemm2_ar_route_cwg.txt`、`gemm2_ar_route_batch.txt`：comm WG 数和 `ROUTE_BATCH` 扫描。
- `fused_timeline_route.txt`：2048 tokens 时 route 模式 gemm2 tile 结束更早（178 vs 187 us），但最后一个 unit 到 235.6 us 才结束（atomic 210.8）。

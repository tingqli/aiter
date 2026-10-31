# gemm2_config_sweep：standalone gemm2 的配置扫描（TP8 shape）

## 结论

- standalone gemm2 在 128 tokens 时 **37.5 us**（port 83.5 us），512 tokens 时 **51.6 us**（port 97.8 us）。
- 有效的优化：
  - **`epilog="lds"`（默认）**：在 MFMA 布局下先乘路由权重，结果以 bf16 暂存到 LDS（port 用 f32，这里减半），再以 128 B 连续的 `global_atomic_pk_add_bf16` 写回；
  - **`dyn_rows`**：跳过 sorted block 中全是 padding 的 16 行子块，16/32/…/BM 行的变体都编译进同一个 kernel。
- **`epilog="direct"`**（保留，非默认）：不经 LDS，lane 对之间 shuffle 后直接 atomic 写回；但每次只写 32 B 连续数据，BM≤32 时更慢。

## 实验

`sweep_g2.py "[dict(token=512, tile_m=32, dyn_rows=True), …]" 3`：多轮交错运行 `bench_a8w4_gemm2`（model_dim 4096、inter 256、E=256、topk 8），每个配置取最小值，并断言误差不超过 `TOL_ERR_RATIO`、cos < 1e-4。

## 结果

当时没有单独存结果文件。数值见 `../session_log.md` 和 `doc-mimo/README.md` 第 2 节；各配置的 ISA 和 VGPR 见 `../isa_snapshots`。

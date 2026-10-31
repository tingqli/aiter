# gemm1_config_sweep：standalone gemm1 的配置扫描（TP8 shape）

## 结论

- 从 port 中只抽出 A8W4 实际用到的路径后，gemm1 在 512 tokens 时约 **83–87 us**，port 约 113 us。与 port 逐位一致（扫描时断言 `bitexact vs port`）。
- 有效的优化：
  - **软件流水**（`pipeline`，BM≤32 时默认开启）：A-LDS 双缓冲，预取下一个 tile 的 A 和 W，用 `sched_barrier(0)` 防止预取被调度器挪到循环末尾；
  - **sign-mask LUT 解码**：去掉 FNUZ -0 的逐片段修正；
  - **`dyn_m`**：排序固定用 64 行 block，运行时根据 `sorted_ids[bx_m+32]` 选择计算 32 行还是 64 行。
- 限制：
  - BM≥64 时预取加寄存器暂存会使 VGPR 超过 168，prefill 变慢，所以只在小 M 时开启；
  - `dyn_m` 在 2048 tokens 时慢约 10%，因为两种路径一起编译后 VGPR 超过 168。

## 实验

shape：model_dim 4096、inter 256（TP8 每卡）、E=256、topk 8。从仓库根目录运行。

| 脚本 | 内容 |
|---|---|
| `sweep.py "[dict(token=512, tile_m=32), …]"` | 每个配置跑一次 `bench_a8w4_gemm1`，打印 standalone、port 的耗时、误差和是否逐位一致 |
| `sweep2.py "[dict(token=512, tile_m=64, dyn_m=True), …]" 3` | 多轮交错运行，每个配置取最小值，并断言与 port 逐位一致、误差为 0 |

## 结果

当时没有单独存结果文件。数值见 `../session_log.md`（扫描过程）和 `doc-mimo/README.md` 第 1 节（汇总）；各配置的 ISA 和 VGPR 见 `../isa_snapshots`。

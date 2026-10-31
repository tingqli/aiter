# gemm1_read_pattern：gemm1 读权重的方式本身能跑多快

## 结论

- 按 gemm1 现在的读法（每个 K-tile 读 16 段 2 KB、段间跨 32 KB，gate 和 up 相距 1 MB），即使不做任何计算也只有 **3.27–3.54 TB/s**。同样的数据量整块连续读能到 **3.9–4.1 TB/s**，所以这种分段读法本身损失约 10–15%。
- **段长是主要因素。** 段长 2 KB 时最慢，4 KB 已经恢复大部分，≥8 KB 就和整块连续一样快。
- **所有 WG 同时读同一个 K 偏移，也有一点损失。** 让每个 WG 的 K 起点错开（rot），2 KB 段从 3.28 提到 3.50 TB/s；整块连续时错开没有作用。推测原因是并发请求的低位地址相同，集中到了少数 HBM 通道或 bank 上（没有直接测到）。
- 据此实现了 tile 布局（`../gemm1_tile_layout`），但实际 kernel **没有收益**：kernel 本身只有约 3.0 TB/s，还没碰到这个上限，瓶颈在 VALU（`../gemm1_att_bottleneck`）。

## 实验

Triton 纯读 kernel，不做计算。grid 是 1024 个 program，与 512 tokens、E=256、inter 512、tn128 时 gemm1 的 grid 相同。每个 program 读 16 个 K-tile × 32 KB = 512 KB，总共 512 MiB。

| 脚本 | 对比 |
|---|---|
| `gemm1_read_pattern.py` | gemm1 布局 vs 整块连续，num_warps 4/8 |
| `gemm1_read_pattern_v2.py` | 每个 K-tile 内的连续段长度 RL：2 KB（即 gemm1 现在的读法）/ 4 / 8 / 16 KB / 整块 32 KB；以及每个 program 的 K 起点错开（rot） |

```bash
python doc-mimo/experiments/gemm1_read_pattern/gemm1_read_pattern.py
python doc-mimo/experiments/gemm1_read_pattern/gemm1_read_pattern_v2.py
```

## 结果（`results/read_pattern_v2.txt`，单位 TB/s）

| 每个 K-tile 内的连续段 | nw=4 | nw=8 |
|---|---|---|
| 2 KB × 16（gemm1 现在的读法） | 3.28 | 3.47 |
| 2 KB，K 起点错开 | 3.50 | 3.53 |
| 4 KB × 8 | 3.90 | 3.72 |
| 8 KB × 4 | 3.87 | 3.95 |
| 16 KB × 2（gate 一段、up 一段） | 3.81 | 3.91 |
| 32 KB 整块 | 3.93 | 4.04 |

`read_pattern_v1.txt`：gemm1 布局 3.27 / 3.54 TB/s，整块连续 3.91 / 4.09 TB/s（nw=4 / nw=8）。

这类纯读 kernel 的功耗低于 750 W，时钟接近满频，所以这里的上限比 gemm1 实际运行时（撞功耗墙）更乐观。

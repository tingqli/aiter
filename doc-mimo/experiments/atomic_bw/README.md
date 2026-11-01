# atomic_bw：bf16x2 atomic 写出 vs dwordx4 store + topk reduce

## 结论

### 带宽上限（单独运行，只看写出本身）

| 路径 | 带宽 | 说明 |
|---|---|---|
| `global_atomic_pk_add_bf16` | 约 1.5 TB/s | linear 64–256 MB 为 1.55–1.60 TB/s；gemm2 的写出模式（每行 128 B 一段）在 ≥1024 tokens 时稳定在 1.44–1.53 TB/s |
| 普通 store（dword / dwordx4） | 4.3–5.4 TB/s | gemm2 模式的 dwordx4（每行 256 B 一段）为 3.6–4.8 TB/s |
| dwordx4 load | 3.9–4.8 TB/s | — |

- atomic 的吞吐只有普通 store 的约 **1/3**，而且 store 用 dword 还是 dwordx4 差别不大。
- gfx942 没有更宽的 bf16 atomic，`pk_add_bf16` 已经是 4 B/lane 的上限。
- 4/16 MB 的 linear 测试 grid 太小，测出来的是延迟，不能当上限看。

### 只比较写出路径（不含 GEMM，单位 us）

| tokens | atomic | + memset | atomic 合计 | dwordx4 store | reduce | store + reduce 合计 |
|---:|---:|---:|---:|---:|---:|---:|
| 128 | 9.4 | 1.7 | 11.1 | 6.3 | 4.6 | 11.0 |
| 256 | 14.4 | 1.8 | 16.2 | 6.5 | 4.6 | 11.1 |
| 512 | 25.2 | 4.8 | 29.9 | 8.5 | 4.7 | **13.2** |
| 1024 | 46.6 | 5.9 | 52.5 | 14.5 | 16.8 | **31.3** |
| 2048 | 89.6 | 6.0 | 95.6 | 28.1 | 32.1 | **60.2** |
| 4096 | 178.0 | 7.8 | 185.8 | 56.6 | 59.7 | **116.3** |
| 8192 | 352.0 | 12.6 | 364.6 | 137.5 | 146.0 | **283.6** |
| 16384 | 701.2 | 22.5 | 723.8 | 301.5 | 296.5 | **598.1** |

- 单看写出，store + reduce 处处不慢于 atomic，512 tokens 时只有 atomic 的 0.44。
- 但 reduce 要把 topk 份数据（T·topk·H·2 B）再读一遍。这个开销在 GEMM 外面，无法和计算重叠。

### 放回 gemm2 里估算

atomic 的写出在 gemm2 里大部分和计算重叠了。依据是 [moe_token_scaling](../moe_token_scaling/) 里的写回消融："不写回"在 512 / 2048 / 8192 / 16384 tokens 时分别省 12.6 / 35.3 / 136.9 / 308.6 us，只相当于单独 atomic 耗时的 39–50%。

估算方法：
- 假设 dwordx4 store 在 kernel 里暴露的比例和 atomic 相同（f = 0.50 / 0.39 / 0.39 / 0.44；没有消融数据的档位取 0.4–0.45）。
- 再加上不能重叠的 reduce。
- atomic 路径另加 memset（moe_sorting 里的 moe_buf 清零）。store 路径不需要清零。

| tokens | atomic 路径的额外开销 | store + reduce 路径的额外开销 | 结论 |
|---:|---:|---:|---|
| 128 | 约 6 | 约 7（再加一次 launch） | atomic 略好 |
| 256 | 约 8 | 约 7.5 | 持平 |
| 512 | 17.4 | 9.0 | **store 好约 8 us**（约占 MoE 的 5%） |
| 1024 | 约 27 | 约 23 | store 略好 |
| 2048 | 41.3 | 43.1 | 持平 |
| 4096 | 约 79 | 约 82 | 持平 |
| 8192 | 149.5 | 199.5 | **atomic 好 50 us** |
| 16384 | 331.1 | 429.2 | **atomic 好 98 us** |

- **≤1024 tokens**：store + reduce 最多省约 8 us。代价有三：多一个 kernel；中间 route buffer 为 64 KB/token（T·topk·H·2 B）；moe_sorting 的清零要去掉才能拿到 memset 那部分收益。
- **≥8192 tokens**：reduce 要读 8 倍数据，抵消并超过了 store 比 atomic 快的那部分，所以 atomic 更好；而且 route buffer 在 16384 tokens 时要 1 GB。
- **要让 store 方案在大 token 上也占优**，topk 求和必须融进一个本来就要读这份数据的后续 kernel。在 TP8 里唯一的候选是 all-reduce，而 [fused_ar_route](../fused_ar_route/) 已经测过：把 topk 求和挪到通讯阶段，整体反而慢 3–16 us。
- **结论**：保留 atomic；只有在 512–1024 tokens 档位值得考虑 store + reduce，收益约 5%。

注意：上面都是单独运行的数字，没有功耗墙下与 GEMM 抢功耗的情况。f 只是近似，整体判断以 ±5 us 为分辨率。

## 实验

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/atomic_bw/bench_atomic_bw.py --sizes_mb 4 16 64 256 1024
```

`bench_atomic_bw.py` 中的 kernel 全部用 FlyDSL 写，每个 WG 256 线程：

- **第 1 部分（linear）**：每个 lane 处理 4 项，地址连续，每 4 B / 16 B 只写一次。共四种 kernel：`atomic`（pk_add_bf16）、`store4`、`store16`、`load16`。
- **第 2 部分（gemm2 写出模式）**：使用真实的 moe_sorting（block_m 64），tile 64×128，grid = m_blocks × 32，写入常数 1.0。
  - `g2_atomic`：与 `_atomic_bf16_epilog` 的映射相同，每次 8 行 × 32 lane × bf16x2。
  - `g2_store16`：每次 16 行 × 16 lane × 16 B，写到 route[token·topk + slot, n]。
  - `reduce`：每个 lane 处理 16 B，读 topk 份，用 f32 求和后写回。
  - 校验：out == topk，reduce(route) == topk。
- 计时用 `run_perftest`（kernel 时间）。memset 指 `out.zero_()`。

## 结果

`results/run1.log`。

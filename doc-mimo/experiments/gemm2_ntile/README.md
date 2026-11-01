# gemm2_ntile：一个 CTA 连续处理多个 n-tile（A 只加载一次，相邻 tile 软件流水）

## 结论

**结果总结**
- 实现可用，结果正确：所有变体与参考的 cos diff 都是 9.4e-6，和 baseline 一样。
- 加速不大：
  - ≤2048 tokens：快 10–13%；
  - ≥8192 tokens：只快 2–5%。

**流水本身做到了**（8192 tokens 的 ATT，与 [gemm2_att](../gemm2_att/) 对比）
- `vmcnt` 等待从 wave 时间的 35% 降到 6%；
- A 每个 m-block 只加载一次，sorted id / A scale / route weight 每个 CTA 只加载一次；
- 下一个 n-tile 的 W 在当前 tile 计算时就已发出加载。

**收益小的两个原因**
1. **占用率被资源吃掉了。**
   - A 要在整个 CTA 的生命周期里留在 LDS，epilogue 的 staging 就不能再复用 A 的区域。
   - 第一版（row data 放在 VGPR、staging 用整块）只能跑 2 WG/CU：VGPR 从 134 涨到 196，LDS 32 KB。baseline 是 4 WG/CU（ATT 观测）。
   - 后来做了两项改进，恢复到 3 WG/CU：
     - row data 移到 LDS（每行 12 B）；
     - 两个 A-scale group 共用一套累加器，在 group 边界乘 s0/s1。

     这一版 VGPR 为 148，`stage_rows=16` 时 LDS 为 21 KB。
2. **整卡受 750 W 功耗墙限制**，减少 stall 主要换来的是降频，而不是变快。
   - 512 tokens：每次迭代的 cycle 数少了约 19%，但时钟从 1198 降到 1004–1069 MHz，wall time 只快 4–8%。
   - 在功耗墙下，真正有效的是减少能耗，也就是减少指令数和数据搬运。只把延迟藏起来作用有限。
   - 大 token 的上限在输出写回：8192 tokens 时要写约 537 MB 的 bf16 atomic，只去掉写回就快约 35%（见 [moe_token_scaling](../moe_token_scaling/)）。

**推荐配置**（tile_m=64，epilog=lds，均与同 tile_m 的 baseline 比较）

| tokens | 配置 | gemm2 us（baseline → 新） |
|---:|---|---|
| ≤512 | `n_tiles=2, stage_rows=16` | 128 tokens：46.9 → 42.2；512 tokens：63.7 → 57.0 |
| 2048 | `n_tiles=2, stage_rows=16` | 144.2 → 127.7 |
| ≥8192 | `n_tiles=4, stage_rows=32` | 8192 tokens：463.7 → 440.8；16384 tokens：875.3 → 857.3 |

- 你担心的 grid 变小，在 nt=2/4 时并不明显。nt=8 普遍比 nt=4 慢 1–3%，小 batch 下 grid 变小确实开始有影响。
- 不推荐的变体：
  - `direct` epilogue：32 B 粒度的 atomic，在 ≥2048 tokens 时慢 30–40%；
  - `n_tiles=1` 在 ≥8192 tokens：多占的 VGPR 让 occupancy 下降；
  - 不分块 staging（`stage_rows=BM`）：LDS 超过 32 KB，只能跑 1–2 WG/CU。

## 实现（`doc-mimo/kernels/test_a8w4_gemm2.py`）

调用方式：`a8w4_gemm2(..., n_tiles=k, stage_rows=s)`，对应编译期参数 `NTILE` / `STAGE_ROWS`。默认值 0 走原来的代码路径，pytest 16 个用例全部通过。

- **grid 与 tile 映射**：grid = m_blocks × (N/TILE_N/NTILE)。CTA 先按 m-block、再按 n-group 排布，XCD 映射照旧。
- **加载顺序**：
  1. 先发出全部 A 的 `buffer_load`；
  2. 再发 W(0) 和 scale 的加载；
  3. 再发 row data 的加载；
  4. 最后才写 LDS。

  这样排是因为 LLVM 不会把 buffer load 提到更早的 `ds_write` 之前，所以加载必须在源码顺序上就排在前面。
- **row data**：每行存 ratio = s0/s1、fin = s1·w、sorted id，放在 LDS。
  - 在 group 0/1 边界执行 `acc *= ratio`，dequant 时乘 `fin * 2^(exp-132)`。
  - 如果 s1 = 0（整组为零），按 1 处理。
- **每个 n-tile 的流程**：
  1. 先发出 W(t+1) 的加载（prefetch）；
  2. decode + MFMA；
  3. dequant；
  4. 以 `stage_rows` 行为一块做 staging，用 barrier 隔开后执行 atomic scatter。

## 实验

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/gemm2_ntile/bench_ntile.py --bm 64 --nt 1 2 4 8 --epilog lds --sr 16 32
bash doc-mimo/experiments/gemm2_ntile/kernel_resources.sh -t 8192        # VGPR/LDS/grid（rocprofv3 kernel trace）
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/gemm2_ntile/probe_clock.py -t 512 --cfg 0:0 1:0 4:16   # 时钟 / 功耗
```

ISA 资源统计：设置 `FLYDSL_DUMP_IR=1 FLYDSL_DEBUG_DUMP_ASM=1 FLYDSL_DUMP_DIR=<dir> FLYDSL_RUNTIME_CACHE_DIR=<新目录>`，然后在 `21_final_isa.s` 里 grep `.vgpr_count` / `.group_segment_fixed_size`。

## 结果（`results/`）

- `sweep_v1.log` / `sweep_v1_bm32.log`：第一版（row data 放在 VGPR），含 lds/direct 两种 epilogue。nt4 最好，只快 2–10%；VGPR 196、LDS 32 KB，2 WG/CU。
- `sweep_v2_sr_bf.log`：第一版加上 `stage_rows` 和 `BF16_FAST`。两者都没有明显作用，因为瓶颈仍是 VGPR 导致的占用率。
- `sweep_v3_rowlds.log`：最终版（row data 放在 LDS、单套累加器），bm64 / bm32。上面的表就取自这里。
- `clock.log`：时钟和功耗。所有变体都在 750 W，时钟 1.0–1.44 GHz（每个点只有 2–3 个采样，噪声较大）。
- ATT（trace 未保存，8192 tokens，nt4 sr16）：
  - 3 WG/CU；
  - 耗时占比：VALU 34%、lgkmcnt 15%、LDS 读 9.5%、vmcnt 6%、barrier 5.7%；
  - 每个 tile 每个 wave 约 440 条 VALU；
  - 3 个 wave/SIMD 时，VALU 发射占用 57%。

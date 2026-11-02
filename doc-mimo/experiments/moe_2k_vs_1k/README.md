# moe_2k_vs_1k：2-kernel 与单 kernel（融合）A8W4 MoE 的全面对比

## 结论

shape：model_dim 4096、E 256、topk 8，inter_dim 分 256 / 512 两组；num_tokens 从 128 翻倍到 32768，路由均匀随机。两边都在下面的编译期参数空间里逐点取最快配置。计时是一次调用里所有 kernel 的时间之和（含 moe_sorting 和 x 的 row-quant），取 3 次中位数，单位 us。

- **inter 256：≥4096 tokens 单 kernel 更快。** 8192 / 16384 / 32768 tokens 快 **13–15%**；1024 tokens 及以下，以及 2048 tokens，基本持平或略慢（0.89–1.02x）。
  - 128 / 256 tokens 慢 11%。这时是带宽受限：2-kernel 的 gemm1 grid 是 m-block × n-block，CTA 多、读权重的并行度高；单 kernel 一个 CTA 处理一个 m-block，只有约 250 个 CTA，还要在一个 CTA 内串行读完 W1 和 W2。
  - 4096 tokens 最好的是 persistent 工作队列版 `bm64q`（1.04x），因为它的任务粒度更细、尾部更均衡。其余点上 `bm64` 最好。
- **inter 512：单 kernel 基本没有收益。** 只有 512 tokens（1.04x）以及 8192 / 32768 tokens（1.05x）略快；2048 tokens 慢 20%，4096 慢 6%，128 / 256 慢 10%。**（补充：加上 `ksplit=2` 之后，≥4096 tokens 和 1024 tokens 快 6–10%，见文末。）**
  - 原因是融合 kernel 中 gemm2 的 A（64×512 fp8）放在 VGPR 里，寄存器翻倍，≥1024 tokens 只能用 `waves_per_eu=1`（每 CU 1 个 CTA）。在 2048 tokens 时，378 个 block 分到 304 个 CU 上约 1.24 轮，尾部很重；用 `waves_per_eu=2` 会大量 spill（8192 tokens 时 2353 us，对比 w1 的 1453 us）。
  - 单 kernel 在 inter 512 下若要有收益，需要换一种 A2 存放方式（放 LDS，或按 K 切分 wave），让每个 CU 能放 2 个 CTA。
- **2-kernel 的最佳配置：**
  - **gemm1：** `b_cache_mod=1` 在 inter 256 全部点、inter 512 下 ≥2048 tokens 时最好；inter 512 小 token 时 bcm2 更好。
  - **gemm2：** inter 256 下多数点 `nt4`（n_tiles 4、direct64、行数据放 VGPR）最好；inter 512 只能用 base，因为 nt4 要求只有一个 K tile。
  - **block_m：** 32 只在 ≤512 tokens 和 2048 tokens 时有优势。bm128（配 gemm2_bm128）没有在任何点胜出，8192 tokens 时 932 us，对比 bm64 的 901 us。

### inter_dim 256

| tokens | 2-kernel 最佳配置 | 2-kernel 总计 | sort | quant | gemm1 | gemm2 | 1-kernel 最佳配置 | 1-kernel 总计 | 其中融合 kernel | 加速比 |
|---:|---|---:|---:|---:|---:|---:|---|---:|---:|---:|
| 128 | bm32 g1bcm1 g2nt4 | 136.1 | 10.6 | 6.3 | 73.4 | 45.9 | bm64 bcm2 w2 | 153.1 | 135.2 | 0.89x |
| 256 | bm64 g1bcm1 g2nt4 | 146.0 | 11.5 | 7.2 | 78.7 | 48.6 | bm64 bcm2 w2 | 164.7 | 142.3 | 0.89x |
| 512 | bm32 g1bcm1 g2base | 165.8 | 16.2 | 8.0 | 85.9 | 55.7 | bm64 bcm2 w2 | 167.3 | 145.1 | 0.99x |
| 1024 | bm64 g1bcm1 g2nt4 | 220.9 | 17.5 | 8.8 | 115.7 | 78.9 | bm64 bcm2 w2 | 216.2 | 191.6 | 1.02x |
| 2048 | bm32 g1bcm1 g2base | 327.0 | 33.4 | 13.4 | 160.2 | 120.0 | bm64 bcm1 w2 | 344.3 | 301.0 | 0.95x |
| 4096 | bm64 g1bcm1 g2nt4 | 519.8 | 36.4 | 21.8 | 228.9 | 232.7 | bm64q bcm1 | 498.7 | 440.2 | 1.04x |
| 8192 | bm64 g1bcm1 g2nt4 | 912.0 | 48.6 | 33.2 | 390.0 | 440.2 | bm64 bcm1 w2 | 794.1 | 706.7 | **1.15x** |
| 16384 | bm64 g1bcm1 g2nt4 | 1699.3 | 72.5 | 59.8 | 713.0 | 853.9 | bm64 bcm1 w2 | 1476.2 | 1342.9 | **1.15x** |
| 32768 | bm64 g1bcm1 g2nt4 | 3307.0 | 123.0 | 139.9 | 1350.7 | 1693.4 | bm64 bcm1 w2 | 2926.8 | 2639.6 | **1.13x** |

### inter_dim 512

| tokens | 2-kernel 最佳配置 | 2-kernel 总计 | sort | quant | gemm1 | gemm2 | 1-kernel 最佳配置 | 1-kernel 总计 | 其中融合 kernel | 加速比 |
|---:|---|---:|---:|---:|---:|---:|---|---:|---:|---:|
| 128 | bm32 g1bcm2 g2base | 256.4 | 12.8 | 7.4 | 157.3 | 78.8 | bm64 bcm2 w2 | 286.3 | 266.5 | 0.90x |
| 256 | bm32 g1bcm2 g2base | 265.4 | 13.2 | 7.8 | 163.2 | 81.2 | bm64 bcm2 w2 | 294.4 | 274.5 | 0.90x |
| 512 | bm32 g1bcm2 g2base | 310.4 | 16.5 | 7.6 | 179.1 | 107.2 | bm64 bcm2 w2 | 298.5 | 274.8 | 1.04x |
| 1024 | bm64 g1bcm2 g2base | 371.9 | 17.5 | 8.8 | 200.9 | 144.7 | bm64 bcm1 w1 | 390.5 | 364.4 | 0.95x |
| 2048 | bm64 g1bcm1 g2base | 581.6 | 32.4 | 13.6 | 286.0 | 249.5 | bm64 bcm1 w1 | 727.4 | 687.9 | 0.80x |
| 4096 | bm64 g1bcm1 g2base | 913.6 | 36.6 | 21.1 | 412.3 | 443.6 | bm64 bcm1 w1 | 974.1 | 920.9 | 0.94x |
| 8192 | bm64 g1bcm1 g2base | 1559.0 | 49.8 | 36.7 | 672.6 | 800.0 | bm64 bcm1 w1 | 1480.6 | 1402.2 | 1.05x |
| 16384 | bm64 g1bcm1 g2base | 2864.9 | 73.5 | 66.5 | 1199.2 | 1525.8 | bm64 bcm2 w1 | 2912.6 | 2780.9 | 0.98x |
| 32768 | bm64 g1bcm1 g2base | 5491.8 | 121.1 | 155.9 | 2249.9 | 2964.8 | bm64 bcm1 w1 | 5229.4 | 4946.6 | 1.05x |

单次测量的噪声约 ±3%（功耗墙下时钟会浮动），所以 0.97–1.03x 视为持平。

## 补充：单 kernel 加 bm32 / ksplit（`results/ksplit_*`）

- **bm32 不会改善小 batch。**
  - ≤512 tokens 时，每个专家最多 11 / 15 / 30 行。bm64 和 bm32 的 block 数完全相同（252 / 256 / 256），而且 `dyn_rows` 已经让这些 block 走 32 行变体。
  - bm32 只有在 1024 / 2048 tokens 时才会增加 block 数（368 / 625，对比 256 / 369），但每多一个 block 就要多读一遍 W1 + W2（每个 1.5 MB）。
- **改为 `ksplit`：** 一个专家 block 的 inter 列切给 ks 个 CTA。每个 CTA 只算自己那部分 inter 列的 gemm1，再做 gemm2 的 split-K，部分和用 atomic 累加。这样 CTA 数乘以 ks，权重总读量不变，代价是 atomic 变为 ks 倍。
- **inter 256 小 batch：ks2 只多 2–5%。** 128 / 256 / 512 tokens 时 149 / 159 / 164 us，2-kernel 是 136 / 144 / 166 us，128 / 256 tokens 仍差约 10%。≥2048 tokens 时 ks2 更慢（atomic 翻倍）。
- **inter 512：ks2 的收益很大。** 每个 CTA 只有 256 个 inter 列，A2 回到 64 VGPR，可以每 CU 放 2 个 CTA（w2）。ks4 不如 ks2。

  | tokens | 2-kernel | 1-kernel 原最佳 | ks2 后 1-kernel 最佳 | 加速比（新） |
  |---:|---:|---:|---:|---:|
  | 128 | 266 | 286 | 275（ks2） | 0.97x |
  | 256 | 273 | 294 | 284（ks2） | 0.96x |
  | 512 | 295 | 299 | 298（ks2） | 0.99x |
  | 1024 | 373 | 391 | **347（ks2）** | **1.07x** |
  | 2048 | 579 | 727 | 628（ks2） | 0.92x |
  | 4096 | 930 | 974 | **846（ks2）** | **1.10x** |
  | 8192 | 1555 | 1481 | **1462（ks2）** | 1.06x |
  | 16384 | 2871 | 2913 | **2711（ks2）** | 1.06x |
  | 32768 | 5520 | 5229 | 5197（w1，ks2 5310） | 1.06x |

- **小 batch 剩下的差距不在 CTA 数。** 这时是带宽受限：单 kernel 每个 CTA 依次读 W1 和 W2，两次读之间要经过 gemm1 epilogue、量化和 barrier；2-kernel 的两个 kernel 各自都能把带宽用满。

## tune 表与 `tuned_moe`（`doc-mimo/kernels/a8w4_moe_tune.py`）

- 所有候选共用同一份 fd2 权重。候选空间只保留实际赢过的配置，inter 256 共 11 个，inter 512 共 8 个：
  - **2-kernel：** bm32 / bm64 × gemm1 bcm 1 / 2 × gemm2 base / nt4（nt4 只在 inter 256）；
  - **单 kernel：** bm64 × bcm 1 / 2 × ksplit 1 / inter÷256（`waves_per_eu` 由每个 CTA 的列数决定）；
  - **bm64q：** bcm1（只在 inter 256）。
- 两组 shape（uniform 路由，1–32768 tokens）的结果在 `doc-mimo/kernels/configs/a8w4_moe_tuned.csv`，日志在 `results/tune_*.log`。
  - inter 256：≤512 tokens 和 2048 tokens 选 2-kernel，1024 和 ≥4096 tokens 选单 kernel；
  - inter 512：≤256 tokens 和 2048 tokens 选 2-kernel，其余选单 kernel。
- **验证**（`results/verify_*.log`）：
  - `tuned_moe` 的耗时与 CSV 中的记录误差在约 3% 以内，输出 cos ≤2.2e-5。
  - 相对默认 2-kernel（bm64 g1bcm1 base），2 的幂处快 1.00–1.20x。
  - 非 2 的幂的 token 数向上对齐后，个别点略慢（3000→4096 为 0.98x，20000→32768 为 0.97x）。

## 实验

`bench.py`：

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/moe_2k_vs_1k/bench.py --inter 256 512 [-t 128 256 ...] [--reps 3]
```

候选配置（全部在 2-kernel 第一个候选的输出上校验 cos < 1e-4）：

- **2-kernel**，即 sort → x row-quant → gemm1（q8s epilogue）→ gemm2（atomic）：
  - `block_m` 32 / 64：gemm1 `b_cache_mod` 取 1 / 2（另有 `xcd_swizzle=1`，bm64 时还加 `dyn_m`），gemm2 取 `base`（lds epilogue，bcm2）/ `nt4`（只用于 inter 256）；
  - `block_m` 128（只用于 inter 256）：gemm1 bcm 1 / 2，加 `test_a8w4_gemm2_bm128`（nt 8）。
- **1-kernel**：
  - `bm64`（`test_a8w4_fmoe_bm64`）：bcm 1 / 2；`waves_per_eu` 在 inter 256 时为 2，在 inter 512 时取 1 / 2；
  - `bm64q`（只用于 inter 256）：bcm 1 / 2。
- 为了这次对比，`test_a8w4_fmoe_bm64` 扩展到了 inter_dim 为 256 的任意倍数：
  - gemm1 按 128 列分成 inter/128 块；
  - gemm2 的 K 分成 inter/128 组，组边界处用 s_g/s_{g+1} 对累加器做 rescale；
  - 上一 tile 的 epilogue 按 K step 均匀摊开。

## 结果（`results/`）

- `bench.log`：每个点所有候选的耗时。
- `i256.json`、`i512.json`：每个候选的总时间、各 stage 的时间、cos 误差。

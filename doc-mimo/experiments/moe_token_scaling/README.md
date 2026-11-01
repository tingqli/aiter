# moe_token_scaling：A8W4 MoE 在 128–16384 tokens 下的表现与瓶颈

## 结论

被测实现：`a8w4_fused_moe`，即 fd2 版 gemm1 + gemm2，`fuse_quant=True`。对每个 token 数都扫了 `block_m` ∈ {32, 64, 128} 和 gemm1 `b_cache_mod` ∈ {1, 2}，取最快的组合。

测试条件：
- shape 为 model_dim 4096、inter_dim 256、256 个专家、topk 8，路由均匀随机。
- 两个 gemm 的权重共 428 MB，其中 W1 285 MB、W2 143 MB。
- 所有 case 都顶在 750 W 功耗墙上，gfx 时钟只有 1.12–1.31 GHz；按 1.19 GHz 折算，fp8 MFMA 峰值约 1480 TFLOPs。

| tokens | 最优配置 | 总耗时 us | sort | quant | gemm1 | gemm2 | MoE 有效带宽 TB/s | gemm1 TB/s / TFLOPs | gemm2 TB/s / TFLOPs | aiter fused_moe us | 判断 |
|---:|---|---:|---:|---:|---:|---:|---:|---|---|---:|---|
| 128 | bm64 bcm1 | 146.6 | 9.5 | 5.4 | 79.5 | 52.2 | 2.87 | 3.53 / 54 | 2.69 / 41 | 221.9 | 带宽 bound |
| 256 | bm32 bcm1 | 165.6 | 10.0 | 5.7 | 88.8 | 61.1 | 2.58 | 3.21 / 97 | 2.33 / 70 | 224.8 | 带宽 bound |
| 512 | bm32 bcm1 | 162.6 | 12.1 | 5.9 | 85.2 | 59.4 | 2.63 | 3.35 / 202 | 2.40 / 145 | 254.2 | 带宽 bound |
| 1024 | bm64 bcm2 | 222.0 | 14.6 | 7.6 | 112.2 | 87.7 | 1.93 | 2.54 / 306 | 1.63 / 196 | 369.0 | 过渡区 |
| 2048 | bm32 bcm1 | 358.7 | 31.3 | 12.8 | 180.5 | 134.1 | 1.19 | 1.58 / 381 | 1.06 / 256 | 596.9 | compute bound |
| 4096 | bm64 bcm1 | 544.0 | 34.0 | 20.5 | 235.5 | 254.0 | 0.79 | 1.21 / 584 | 0.56 / 271 | 982.4 | compute bound |
| 8192 | bm64 bcm1 | 968.0 | 46.5 | 36.0 | 365.0 | 520.4 | 0.44 | 0.78 / 753 | 0.27 / 264 | 1770.1 | compute bound |
| 16384 | bm64 bcm1 | 1759.5 | 68.4 | 59.4 | 698.0 | 933.7 | 0.24 | 0.41 / 788 | 0.15 / 294 | 3452.1 | compute bound，gemm2 主导 |

表中定义：
- 耗时是 torch profiler 统计的 kernel 时间之和，不含 launch 间隙。
- 带宽 = 被命中专家的权重字节数 / 耗时。
- TFLOPs 只算有效行，不含 padding。

主要发现：
- **≤512 tokens 受带宽限制。**
  - gemm1 达到 3.2–3.5 TB/s，是功耗墙下纯读上限（约 3.6 TB/s）的 90–97%。
  - gemm2 只有 2.3–2.7 TB/s，约为上限的 75%。
  - 两个 gemm 合计约为理想值（119 us）的 1.1 倍。
  - 剩余开销：sort + quant 约 15–18 us（10%），以及 gemm2 的带宽缺口约 12 us。
- **1024 tokens 是过渡区**：带宽降到 1.9 TB/s，padding 系数为 1.41。
- **≥2048 tokens 受 compute 限制，且越往后越由 gemm2 主导。**
  - gemm1 在 16384 tokens 时达到 788 TFLOPs，约为功耗墙下 MFMA 峰值的 53%。
  - gemm2 一直只有 260–300 TFLOPs（约 20%）。它的 FLOPs 只有 gemm1 的一半，但 ≥4096 tokens 时耗时反而更长。
- **gemm2 的写回在大 token 时不可忽略**（见下文复测）。去掉写回后，gemm2 在 512 / 2048 / 8192 / 16384 tokens 分别快 20% / 24% / 30% / 35%，16384 tokens 时省下 309 us。
  - 改成普通 store 和 atomic 一样慢，所以瓶颈不在 atomic 指令本身，而在 epilogue 整体：LDS 中转、barrier、4 B 粒度的写回，以及写回没有和主循环重叠。
  - 去掉写回后，gemm2 主循环约为 477 TFLOPs（32%），仍远低于 gemm1。原因是 K=256 只有一个 K tile，WG 内部没有流水。
- **更正**：[gemm2_epilog_ablation](../gemm2_epilog_ablation/) 原先的结论"写回方式不影响耗时"，是 FlyDSL 磁盘缓存复用了旧二进制造成的假象：本次首轮复测中，store 版的误差也约为 1e-6，说明实际跑的还是 atomic。每个变体使用独立的 `FLYDSL_RUNTIME_CACHE_DIR` 后，store 版误差约为 0.98，说明变体真正生效了，于是得到上面的数据。
- **`block_m` 应按 token 数选择**：256/512/2048 tokens 用 bm32，其余用 bm64，bm128 在所有点都最慢。sglang 里固定用 bm64，在 256/512/2048 tokens 时分别慢 4% / 5% / 1%。
- **e2e 中 gemm1 用 bcm1 更好**：除 1024 tokens 外，`b_cache_mod=2` 在 e2e 中都更慢，与 standalone bench 中 nt 快约 7% 的结论相反。
- 与 aiter 当前的 `fused_moe` a16w4 路径相比，快 1.34–1.96 倍。

## 继续提升的方向（按收益排序）

1. **gemm2 epilogue 与主循环重叠（≥2048 tokens，最多约 35%）。**
   - 做法：常驻 WG，用双 tile 缓冲交替处理，在写回当前 tile 的同时加载并解码下一个 tile；或者降低 LDS 占用（当前 16 KB/WG，每 CU 只能放 4 个 WG），让其他 WG 的主循环覆盖写回。
   - 16384 tokens 时上限约 300 us（gemm2 885 → 约 580 us）。
2. **gemm2 主循环的 MFMA 利用率（32%）。**
   - K=256 只有一个 K tile，加载延迟完全暴露。可以跨 tile 预取 A/W（同上，常驻 WG），或用更大的 `tile_n`（256）复用 A。
3. **gemm1 大 token 时的 VALU 解码摊销。**
   - bm64 时每 64 行就要解码一次 W，bm128 本该减半解码量，实际却更慢。推测是累加器 VGPR 增加导致 occupancy 下降，以及 bm128 没有流水；需要 ATT 确认。
   - 方向：做一个面向大 token 的 tile 方案（bm128 / tile_n 256，或者解码一次存进 LDS，供多个 wave 共用）。
4. **按 token 数选 `block_m`（零成本）**：生产路径改为查表即可，见上表。
5. **小 token（≤512）的剩余空间约 10–15%。**
   - sort + quant 约 15 us：可以把 x 的量化融合进 sorting 或 gemm1 的 prologue。
   - 2048 tokens 时 sort 从 14.6 跳到 31.3 us，是 moe_sorting 切换了 multi-phase 变体，可以单独调优。
   - gemm2 的带宽还差约 12 us。
   - launch 间隙约 13 us（wall 160 vs kernel 和 147）由 CUDA graph 消除。
6. **整体受功耗墙限制。** 所有 case 都在 750 W 运行，时钟 1.1–1.3 GHz，因此减少 VALU 指令数或减少搬运字节，既降低能耗，也会直接提高时钟。

## 实验

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/moe_token_scaling/bench.py 256      # token 扫描 + 分阶段耗时
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/moe_token_scaling/probe_clock.py    # 最优配置下的时钟 / 功耗
for m in atomic store none; do rm -rf /tmp/fly_epi_$m; EPI=$m FLYDSL_RUNTIME_CACHE_DIR=/tmp/fly_epi_$m \
  PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/experiments/gemm2_epilog_ablation/g2_epilog_ablation.py \
  -t 512 2048 8192 16384 --tile 64,128,1 -r uniform; done         # gemm2 写回消融（必须用独立缓存）
```

- `bench.py`：每个 token 数扫 6 种配置，用 profiler 统计每个 kernel 的时间（sort / quant / gemm1 / gemm2），并用 aiter `fused_moe` 作为参照。`bench.py 512` 可以测 inter_dim 512。
- `probe_kernels.py`：列出一次调用会发起哪些 kernel，用来把 kernel 名映射到阶段。
- `probe_clock.py`：最优配置连续运行 8 s，用 `amd-smi` 采样时钟和功耗。

## 结果

- `results/token_scaling_i256.log` / `.json`：扫描结果，json 中包含所有配置的分阶段耗时。
- `results/clock_i256.log`：

  | tokens | 时钟 MHz | 功耗 W |
  |---:|---:|---:|
  | 128 | 1312 | 736 |
  | 512 | 1120 | 748 |
  | 2048 | 1124 | 750 |
  | 16384 | 1191 | 750 |

- `results/g2_epilog_ablation_large.log`：gemm2 单独测试（bm64，dyn_rows）的耗时（us）。

  | tokens | atomic | store | 不写回 |
  |---:|---:|---:|---:|
  | 512 | 61.0 | 59.4 | 48.4 |
  | 2048 | 145.1 | 136.3 | 109.8 |
  | 8192 | 455.4 | 451.2 | 318.5 |
  | 16384 | 885.1 | 895.4 | 576.5 |

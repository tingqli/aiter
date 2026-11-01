# fmoe_bm64：BM=64 单 kernel MoE（gemm1 → 量化 → gemm2 + atomic，2 CTA/CU）

## 结论

- **正确性：** 与 2-kernel 输出的 cos 差 ≤1.2e-5；与 torch 参考的 cos 差 9.8e-4，和 2-kernel 相同。
- **性能（总时间含 sort + quant，单位 us）：** 加上 XCD 连续映射（`xcd=True`，默认）后，≥4096 tokens 都比 2-kernel 快，8192 / 16384 tokens 快 13–15%。

  | tokens | 2-kernel | 融合 xcd0 | 融合 xcd1 | 其中融合 kernel（xcd1） | xcd1 加速比 |
  |---|---|---|---|---|---|
  | 512 | 188.6 | 185.5 | – | – | 1.02x（xcd0） |
  | 2048 | 364.1 | 368.7 | 358.1 | 321.6 | 1.02x |
  | 4096 | 550.8 | 591.1 | 531.9 | 482.6 | 1.04x |
  | 8192 | 971.3 | 968.1 | **845.3** | 753.9 | **1.15x** |
  | 16384 | 1774.5 | 1825.7 | **1572.5** | 1434.4 | **1.13x** |

- **XCD 映射是关键。** WG 按 block id 轮流分到 8 个 XCD，同一专家的几个 m-block 原本落在不同 XCD 上，各自从 HBM 读一遍 W1/W2（每个 m-block 1.5 MB）。改成每个 XCD 处理一段连续的 m-block 后，同一专家的 block 几乎同时在同一个 L2 上跑，权重读取被 L2 合并。8192 tokens 时 kernel 从 884 降到 754 us。
- **占用率达到 2 CTA/CU。** 256 VGPR、LDS 25088 B。ATT（8192 tokens、xcd0）显示每个 CU 大部分时间有 8 个 wave（2 个 CTA）。但有 **21 个 VGPR spill**，不过 scratch 只占 wave 时间的 0.4%，影响很小。
- **两个 CTA 之间的 VALU 和 MFMA 重叠得不好。** 按每个 wave 统计（xcd0）：
  - gemm1 阶段约 21.2 万 cycle：VALU 12111 条（fp4 解码为主），MFMA 3840 条；
  - gemm2 阶段约 10.9 万 cycle：VALU 10742 条（解码加 epilogue），MFMA 1920 条，SALU 1794 条。
  - 每个 SIMD 有 2 个 wave 时，VALU 发射占用 55%，MFMA 占用约 58%（每 2000 cycle 72 条 × 16 cycle）。两者加起来只有约 113%，离「MFMA 满载、VALU 藏在下面」差得远。
  - 每个 block 的 VALU 和 MFMA 工作量都约为 9 万 cycle/SIMD，大致是 1:1，所以 BM=64 下解码开销本来就与 MFMA 同量级。
- **下一步可做的方向：**
  - 去掉 spill；
  - 减少 gemm2 epilogue 的 VALU 和 SALU（SALU 占 gemm2 阶段的 11%）；
  - persistent 化 + 相位错开（计划中的第 3 步），让一个 CTA 的解码与另一个 CTA 的 MFMA 重叠。

## 实验

- kernel：`doc-mimo/kernels/test_a8w4_fmoe_bm64.py`，非 persistent，grid = `sorted_expert_ids.numel()`，一个 CTA（4 wave）处理一个 BM=64 的 expert block：
  1. **gemm1**，分两半（inter 0–127、128–255）。每个 wave 算 32 列 gate 加 32 列 up；K 循环用一个 A 的 LDS 槽，并在寄存器里预取下一个 tile。
  2. **epilogue**：dequant → SiLU → bf16 暂存在 A 区 → 按（行, 128）量化为 fp8（与 q8s 数值相同）→ 写入 8 KB 的 XOR swizzle LDS 半区，加上 scale。之后每个 wave 把 gemm2 的 A 片段读进 VGPR。
  3. **gemm2**：32 个 n-tile。两组累加器 ping-pong，W2 预取距离 1，上一个 tile 的 epilogue 与当前 tile 交织；每行数据（ratio、fin、sorted id）在每个 CTA 内用 `ds_bpermute` 取一次。atomic 按 64 B 一段写出。
  4. 按行数动态选 32 行或 64 行的变体；`xcd=True` 时做 XCD 连续映射。
- 对比对象：`test_flydsl_moe_a16wfp4.a8w4_fused_moe(block_m=64, fuse_quant=True)`（sort + quant + gemm1 + gemm2）。

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/kernels/test_a8w4_fmoe_bm64.py -t 512 2048 4096 8192 16384 --xcd 0 1 [--wpe 2] [--ref]
# ATT（kernel_include_regex: (.*fmoe_bm64.*)），再按阶段拆分
python doc-mimo/experiments/fmoe_bm64/att_phases.py ck_test_fmoe/ui_output_agent_<pid>_dispatch_<id>
```

`att_phases.py` 以第一条 `ds_bpermute`（gemm2 取行数据）为界，把每个 wave 分成 gemm1 / gemm2 两段，统计每段的时长和各类指令的耗时。

## 结果（`results/`）

- `bench.log`：计时、误差、ISA 资源。
- `att_8192_xcd0.txt`：8192 tokens（xcd0）的 ATT 阶段拆分、驻留情况、SIMD 发射占用。

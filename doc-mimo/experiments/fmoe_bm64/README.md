# fmoe_bm64：BM=64 单 kernel MoE（gemm1 → 量化 → gemm2 + atomic，2 CTA/CU）

## 第 3 步结论（优化与 persistent 尝试，`results/step3.log`）

- **当前最好：`test_a8w4_fmoe_bm64.py`（非 persistent）。** kernel 时间 8192 tokens 691 us，16384 tokens 1350 us；总时间比 2-kernel 快 **18% / 17%**，512–4096 tokens 与 2-kernel 持平。和第 2 步相比做了这些改动：
  - **lean epilogue：** 整数舍入，padding 行的 atomic 用 wave 一致的 full/part 分支，atomic 用 SGPR base；
  - **gemm1 预取分散：** 下一 tile 的 A/W 读取分散到各 K step 发出，W 不再整体拷出，**21 个 spill 消失**；
  - **W 读取 cache policy 改为 sc0（bcm1）。**
- **atomic 仍是大头，但原因不是「相位锁定」。**
  - 去掉 atomic 后，8192 / 16384 tokens 的 kernel 降到 551 / 985 us，说明 atomic 要多花 140 / 365 us。
  - 相位探针（`FMOE_PROBE=1`）显示 CTA 在全 GPU 范围确实同相：开头约 180 us 全部 608 个 CTA 都在 gemm1，之后 gemm2 成批出现。
  - 但打乱相位并没有收益：推迟第二个 slot 启动（`FMOE_DELAY`）无效；工作队列版本 bm64q 让 gemm1/gemm2 在时间上均匀混合，atomic 的代价仍然约 150 us（noat 589 → 740）。
  - 所以 atomic 的开销是它本身的发射和访存代价（atomic 在内存端做 RMW，与 W 读取争抢带宽和功耗），而不是集中爆发造成的。
- **bm64p（persistent，1 CTA/CU，gemm2(i-1) 按 K step 交织进 gemm1(i)）更慢：** 8192 tokens 872–916 us。
  - 每个 SIMD 只有 1 个 wave，同一指令流里 VALU（解码、epilogue）和 MFMA 基本是串行的：VALU 发射占用 34%，MFMA 约 38%；
  - 寄存器 488–512，无分支 atomic 版本还有 spill。
- **bm64q（persistent 工作队列，2 CTA/CU）：** 每个 XCD 一个队列，顺序是 g1 × D，然后 g2 / g1 交替，最后是 g2；A2 经 L2 传递，每个 block 一个 epoch 标志。
  - **4096 tokens 最好：** kernel 442 us，bm64 是 485 us（快 9%，主要来自任务粒度更细、尾部更均衡）。
  - 8192 / 16384 tokens 比 bm64 慢 2–5%（任务调度的 barrier、10 个 spill）；512 tokens 慢 18%（每个 CTA 只有约 1 个任务，persistent 没有收益）。
  - **同步不能用 agent 级 release/acquire：** `buffer_inv sc1` 会把 XCD 的 L2（缓存着的专家权重）整个作废，8192 tokens 时慢 36 us。producer 和 consumer 在同一个 XCD（按 `HW_REG_XCC_ID` 选队列）时，用 sc1 store/load 标志即可。
- **踩过的坑：**
  - 在带 `s_barrier` 的 runtime `while` 循环里使用 lane 级发散分支（`if tx == 0`），会被 structurizer 拆成不同 wave 执行次数不同的 barrier，导致 hang。要改成 `if wave == 0` 加按 lane 选择的增量。
  - 循环上界必须 `readfirstlane`。
  - gfx942 上 `v2bf16` 的 buffer atomic fadd 无法选指令（isel 失败）。
- **按 token 数分档建议（第 4 步）：**
  - ≤2048 tokens 用 2-kernel 或 bm64（两者持平）；
  - 4096 tokens 用 bm64q；
  - ≥8192 tokens 用 bm64。

## 第 1–2 步结论

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
- `step3.log`：第 3 步的全部数据，包括优化后的 bm64、消融、相位探针、DELAY、bm64p、bm64q。

第 3 步相关的 kernel 与脚本：

| 文件 | 内容 |
|---|---|
| `doc-mimo/kernels/test_a8w4_fmoe_bm64.py` | 开关：`FMOE_PROBE=1`（相位探针，打印每段时间线）、`FMOE_ABL=nog2/nodec/nomma/g2nodec`、`FMOE_DELAY`、`FMOE_LDS_PAD`、`FMOE_G1SPREAD`、`G2_NO_ATOMIC`；CLI 参数 `--bcm`、`--reps` |
| `doc-mimo/kernels/test_a8w4_fmoe_bm64p.py` | persistent 交织版本（较慢，仅作记录） |
| `doc-mimo/kernels/test_a8w4_fmoe_bm64q.py` | persistent 工作队列版本，`-t ... [--no_bm64]`；调试开关 `FMOEQ_DBG=trace/skipg1/skipg2` |
| `dbg_queue_trace.py` | 配合 `FMOEQ_DBG=trace`，检查每个 block 是否恰好执行一次 g1、一次 g2 |

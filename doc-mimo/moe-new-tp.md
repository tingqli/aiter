
==================================================================================
**USER**
传统MoE TP为了减少卡间通讯，第一个gemm使用N维度切分，第二个使用K维度切分，尝试实现下面的方式，两个gemm都使用相同的N维度切分+all_gather

```python
q0 = quant_row_to_fp8(a0)                 # [M, 4096]
a1 = gemm1(q0, w1_r)                      # w1 沿 inter 切：[M*topk, 256]（含 SiLU）
q1, s1 = quant_group_fp8(a1, group=256)   # 本卡局部量化，每 (行, rank) 一个 scale
qa, sa = all_gather(q1, s1)               # [M*topk, 2048] fp8 + [M*topk, 8] scale
a2 = gemm2_atomic(qa, sa, w2_r)           # w2 沿 model_dim 切：[M, 512]，本地 atomic 累加 topk
out = all_gather(a2)                      # [M, 4096]
```

关键点：all_gather 之后再做 per-token 量化，需要传 bf16（字节数翻倍）；要对整行 2048 取 max，又得多一次跨卡同步。更合理的做法是 group=256 的分组 scale。它的精度和现在 TP8 的做法完全一致（现在也是每卡只对自己那 256 列做 row-quant），代价是 gemm2 要支持沿 K 分块的 A scale。

==================================================================================
## 实验结论（8× MI325X，TP8，model_dim 4096，inter 2048，256 专家，topk 8）

**结论：这个方案不值得做。** 整层（gemm1 + gemm2 + 通讯）与传统 TP 基本持平；传统 TP 也用上同样的融合量化后，新方案还要慢 3–14 us。根本原因有两个：

- 中间激活宽度 topk×inter = 16384，是输出宽度 4096 的 4 倍。即使 AG1 用 fp8，发送量也等于整个 two-shot all-reduce，再加一次 AG2。
- AG1 推送放进 gemm1 epilogue 后，只有 19–36% 被计算掩盖。

除特别注明外，时间单位都是 us，计时只算 GPU 时间；8 卡的数据取最慢 rank。

### 1. gemm2 换 shape 的收益（单卡，`test_a8w4_gemm2.py`，bm32 + dyn_rows）

| tokens | 传统（N=4096，K=256） | 新（N=512，K=2048） |
|---|---|---|
| 128 | 44–46 | 46 |
| 512 | 57–59 | 54 |
| 2048 | 141 | 117–119 |

- 把 epilogue 的 atomic 换成普通 store 或者直接不写回，耗时都不变，说明 gemm2 不受 atomic 或输出写回限制。128 tokens 时它受权重读取限制，约 3.1 TB/s。所以"atomic 少 8 倍"没有带来收益。
- 新 shape 的收益来自更长的 K 循环和少 8 倍的 WG，每个 WG 的固定开销被摊薄，只在 token 多时明显。

### 2. one-shot all-gather 实测（`comm/allgather_bench.py`）

| tokens | AG1（fp8 [M×8, 256]/卡） | AG2（bf16 [M, 512]/卡） | AG1+AG2 | 传统 two-shot AR |
|---|---|---|---|---|
| 128 | 约 10 | 7.6 | 18 | 13 |
| 512 | 33–35 | 19–20 | 53–54 | 31–33 |
| 2048 | 114–118 | 63–73 | 178–185 | 115–117 |

- 计时方式：先排一个 `torch.cuda._sleep` 让 GPU 忙，再连续提交，只统计 GPU 时间。不这样做的话，FlyDSL 每次 launch 的 host 开销约 17 us，小尺寸的结果会被它主导。
- AG1 和 two-shot 每卡都发约 1.75 N_out 字节，耗时也相同，受链路带宽限制（每卡约 200–240 GB/s）。one-shot 少一轮同步，但几乎没省时间。
- 消息大小相同时，RCCL `all_gather_into_tensor` 比这个 one-shot 实现慢 1.2–3 倍。
- one-shot 必须对 gather 缓冲做双缓冲（按 epoch 奇偶）。只用一份时，快的 rank 会在慢的 rank 读完上一轮之前写入下一轮，结果会出错。

### 3. AG1 融进 gemm1 epilogue（`kernels/gemm1_ag_tp.py`，gemm1 `epilog="q8pushs"`）

gemm1 的 SiLU 结果先暂存到 LDS，按每 128 列一个 scale 量化成 fp8，再直接 push 到 8 张卡对应的 plane（sc0|sc1，双缓冲），然后按 tile 发 flag。之后接一个等待 kernel，代替 gemm2 开头的 flag 等待。push 后各卡数据与本地结果的 all_gather 逐位一致。

| tokens / 配置 | gemm1 + 融合量化（本地） | + 推送 + 等待 | 暴露时间 | 单独 AG | 掩盖比例 |
|---|---|---|---|---|---|
| 128 / bm32 | 90.7 | 98.8 | 8.1 | 11.0 | 26% |
| 512 / bm32 | 99.6 | 127.0 | 27.4 | 34.0 | 19% |
| 2048 / bm32 | 207.3 | 304.7 | 97.4 | 137.1 | 29% |
| 2048 / bm64 + dyn_m | 193.4 | 281.2 | 87.8 | 137.7 | 36% |

- 推送让 gemm1 本身变慢：512 tokens 时 +18 us，2048 tokens 时 +63 us。去掉 flag 发布、换 cache 策略（sc0|sc1、sc1、默认）都没有改善。远端写集中在每个 WG 结束时突发写出，平均带宽远低于链路上限。
- 等待 kernel 还要再等最后一批数据传完，多出 +8 / +34 us。
- 行按 token 顺序存放（token×topk+slot）时，每行的 scale 是 4 B 分散远端写，代价很大，比按排序位置存放、scale 先在 LDS 汇总再连续写出慢 5–40 us。

### 4. 整层对比

| tokens | 传统（现状） | 传统 + 融合量化 | 新方案（q8pushs + gemm2′ + AG2） |
|---|---|---|---|
| 128 | 155 | 150 | 153 |
| 512 | 197 | 191 | 200 |
| 2048 | 470 | 450 | 464 |

新方案的 gemm2′ 是用整行 scale 测的，偏乐观。传统方案还有一项没用上的优化：two-shot 融进 gemm2 尾部，约 5–10 us。

### 5. 副产品：融合量化用到现有流程（已实现）

唯一的正收益来自 gemm1 epilogue 里的融合量化，它与 TP 方案无关：

- gemm1 新增 `epilog="q8s"`：按排序位置写 fp8，每 (行, 128 列) 一个 f32 scale。
- gemm2 新增 `a_group=128`：A scale 布局为 `[sorted_rows, K/128]`，每个 K 组有自己的一组累加器，在 dequant 时合并。
- `a8w4_fused_moe(..., fuse_quant=True)` 把两者接起来，省掉第二个量化 kernel 和 bf16 中间结果的写回与读入。

正确性：gemm2 分组 scale 与 fp32 参考的误差和整行 scale 相同（cos diff 约 9.3e-6）。e2e 的 cos diff 从 1.0e-3 降到 9.6e-4，分组 scale 更细，所以略好。

各 kernel 的 GPU 时间（单卡，warm cache，两轮平均）：

| tokens / 配置 | 现状：sort + 2 次量化 + gemm1 + gemm2 | 融合量化 | 差值 |
|---|---|---|---|
| 128 / bm32 | 162.7 | **153.0** | −9.7（−6%） |
| 512 / bm32 | 185.8 | **180.9** | −4.9（−3%） |
| 2048 / bm32 | 388.6 | 382.1 | −6.5 |
| 2048 / bm64 + dyn_m | 387.3 | **371.9** | −15.4（−4%） |

- 省掉第二个量化 kernel，节省 5–10 us。gemm1 改为写 fp8 而非 bf16，节省 0–13 us。
- gemm2 的分组 scale 在 bm32 时基本没有开销。bm64 时多出 5–8 us，因为累加器从 16 个 VGPR 翻倍到 32 个。
- gemm2 分组 scale 试过两种不成功的实现：
  - 单组累加器，在组边界乘 $s_g/s_{g+1}$：编译器把 scale 加载和除法提到循环前面，VGPR 反而从 77 涨到 89；
  - 用 `waves_per_eu=7` 把 VGPR 压到 72：慢了 5–30 us。
  - 最终方案：每组一套累加器，一行的 2 个 scale 用一次 64 bit load 读取。

### 6. 实验中的坑

- **FlyDSL 的 JIT 磁盘缓存 key 只包含 int、float、bool、str、tuple 类型的闭包值**。用 `set` 或 `dict` 作编译开关时，不同变体会复用同一份二进制，而且不会报错。
- **带 mask 的 `buffer_ops.buffer_store` 会把偏移改成 0x7FFFFFFF**，靠 buffer 资源的大小检查丢弃。`create_buffer_resource_from_addr` 默认大小是 4 GB，所以被 mask 的 lane 会真的写到基址 +2 GB 处：远端写会变慢，严重时触发 GPU 越界写。一定要传 `num_records_bytes`。
- **当前 `/sgl-workspace/pyhip` 的 checkout 里没有 `pyhip.contrib`**，而 aiter 无条件导入它。实验时用 `PYTHONPATH=/tmp/pyhip_shim`（一个 sitecustomize 桩模块）绕过。

### 运行

```bash
# 1. gemm2 shape 对比 / 分组 A scale
python doc-mimo/kernels/test_a8w4_gemm2.py -t 128 512 2048 -s 4096,256,256,8 512,2048,256,8 -r uniform --tile 32,128,1
python doc-mimo/kernels/test_a8w4_gemm2.py -t 128 512 2048 -r uniform --tile 32,128,1 --a_group 0 128
# 2. one-shot all-gather vs two-shot all-reduce
torchrun --nproc_per_node=8 doc-mimo/comm/allgather_bench.py 128 512 2048
# 3. gemm1 融合推送（Q8PUSH_VARIANT=noscale,nopub,cm0,cm16,one,selfonly 做消融）
TILES=32,0:64,1 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm1_ag_tp.py 128 512 2048
# 5. e2e：现有流程 vs 融合量化
AITER_CONFIG_FMOE=$PWD/mimo_v2.6_flash_a8w4_tuned_fmoe.csv \
  pytest -s doc-mimo/kernels/test_flydsl_moe_a16wfp4.py::test_flydsl_a16wfp4_silu_e2e
```

（上面的命令若遇到 `pyhip.contrib` 导入失败，前面加 `PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim`。）

==================================================================================
## gemm2 + all-reduce 融合（参考 mega_moe_tp）

**结论（第 4 节复测后）：** gemm2 和 two-shot all-reduce 放进同一个 kernel，按列 chunk 逐块通讯，在 ≥512 tokens 时可以隐藏 38–63% 的 all-reduce 时间。gemm2 + all-reduce 的耗时（单位 us）：

| tokens | 依次执行 | 融合 | 变化 |
|---|---|---|---|
| 512 | 103 | 90 | −13% |
| 1024 | 163 | 134–136 | −17% |
| 2048 | 280 | 225–232 | −18% 至 −20% |
| 4096 | 520–532 | 395–412 | −21% 至 −26% |
| 8192 | 1009–1017 | 718–725 | −29% |

128 tokens 时融合反而慢 6–14 us，256 tokens 时持平：all-reduce 本身只有 13–20 us，小于融合的固定开销，所以这一段应该回退到依次执行。所有配置都与 fp32 all-reduce 一致（bad=0）。

### 1. mega_moe_tp 的做法（上游 main，`aiter/ops/flydsl/kernels/mega_moe_tp/{gemm,communication}.py`）

1. **gemm2 从左到右扫描列。** CTA 常驻，工作单元是 (expert, 行块)。每个单元里 4 个 wave 以 64 列为一组从左往右算；每算完 512 列（一个 chunk），在 LDS 里记下 chunk 编号（`report_chunk`）。
2. **chunk 完成信号分两级汇总。** comm wave 取本 CTA 所有 wave 中最小的已完成 chunk，先在按 XCD 拆开的计数器上累加；每个 XCD 的最后一个 CTA 再累加全局计数，最后一个 XCD 置 `lrdy[chunk] = epoch`（`comm_signal`）。这样不需要 grid 级 barrier。
3. **topk 求和放在通讯阶段。** gemm2 不用 atomic，每个 (token, k) 的部分结果单独存一行。对 ready 的 chunk，`push_chunk_dyn` 读出每个 token 的 topk 行，用 fp32 求和，推送给该 token 的 owner rank（reduce-scatter），然后在所有 peer 上置 `FLAG_RDY`。
4. **`final_chunk`** 等所有 peer 的 flag 到齐后求和，再推送给所有 rank（all-gather），也可以顺带做 RMSNorm。通讯任务由空闲的 wave 动态认领，另有 LL 模式（flag 嵌在数据包里）。

### 2. 我们的实现（`kernels/gemm2_ar_fused.py`，以及 `kernels/test_a8w4_gemm2.py` 的 `tile_order="g"` / `AR`）

我们的 gemm2 不是常驻 CTA，而是每个 WG 算一个 (m-block, n-block) tile，topk 求和靠 atomic 写进 `moe_buf`。所以照搬的是思路，不是代码：

- **列扫描靠调度顺序实现**（tile order `g`）：
  - 输出按 `CHUNK_N` 列分成若干 chunk，grid 按 chunk 顺序发射；
  - 每个 chunk 内部是 m-major，并保留按 XCD 连续分配的映射以维持 cache 局部性。
  - 探针结果（`experiments/gemm2_tile_order/results/g2_order_probe.txt`）：

    | tile 顺序 | 8 个 512 列 chunk 完成时刻（占 kernel 时长的 %） | gemm2 代价 |
    |---|---|---|
    | 现状 `m` | 全部在 97–100% | — |
    | `n`（列优先 + XCD 映射） | 仍在 98–100%（XCD x 正好负责 chunk x） | +3 至 +14 us |
    | `nx`（列优先，无映射） | 依次完成：约 25 / 40 / 50 / … / 100 | 2048 tokens 时 +40 us（丢了 cache 局部性） |
    | **`g`** | 依次完成：约 17–27 / 30–41 / … / 100 | +2 至 +5 us |

- **chunk 完成计数**：每个 compute WG 等自己的 atomic 落地（`s_waitcnt vmcnt(0)`），再给所属 chunk 的计数器加 1；计数达到 `m_blocks × (CHUNK_N / 128)` 即完成。
  - 每个 chunk 拆成 32 个计数器（8 个 XCD × 4，各占一条 256 B 的线），comm 侧由 wave 0 的 32 个 lane 分别轮询、再做 butterfly 求和。
  - 最初每个 chunk 只有一个计数器，约 8000 次 atomic 打在同一条缓存线上，gemm2 慢了 33 us。
  - 计数器按 epoch 奇偶交替使用，不用的那一组在 kernel 开头清零。
- **comm 角色**：grid 最前面的 `cwg` 个 WG 负责通讯，逐个 unit 做 two-shot。
  - unit 的定义：输出行分成 8 份 shard，每份 R = M/8 行；一个 unit = (chunk, 每个 shard 中的 RU 行)，每个线程每个 shard 一个 16 B 向量。
  - 步骤：等本 rank 的 chunk 完成 → 把各 shard 的行推送到 owner 的 inbox（sc0|sc1）→ 置 rs flag → 等 rs flag 到齐 → 按 rank 顺序用 fp32 求和 → 推送到所有 rank 的 gather 区 → 置 ag flag。
  - 每个 comm WG 结束前等它负责的 unit 的 ag flag 全部到齐，所以 kernel 返回时 gather 区就是完整的 all-reduce 结果。
  - inbox 和 gather 都只用一份缓冲，靠 two-shot 的握手保证安全。

### 3. 优化过程（512 tokens 为主，单位 us；对照：gemm2(m) + two-shot = 103–105）

| 版本 | 时间 | 说明 |
|---|---|---|
| v0：每个 chunk 一个计数器 | 156.3 | comm WG 什么都不做（skip）时也要 102.7：计数器热点 |
| v1：计数器拆成 32 个，各占 256 B | 93.0 | skip 时 69.3，约等于 gemm2(g) 单独跑的时间 |
| 拆分角色（一半 WG 只推送，一半只做规约） | 93–99 | 没有改善 |
| `vpt`=2/4/8（每个 unit 的数据量） | 95 / 113 / 155 | 变慢：comm 代码让整个 kernel 的 VGPR 涨到 98–173，gemm2 的 occupancy 下降 |
| `waves_per_eu=7`，VGPR 硬压到 72 | 128–137 | spill 落在了 gemm2 路径上 |
| comm 单独做成 kernel，放 side stream 并发 | 112 | 两者确实重叠，但跨 stream 的事件依赖开销更大。comm 先发射时会死锁（两条 stream 可能落到同一个硬件队列），gemm2 必须先发射 |
| peer 基址用 SGPR，计数器改为 lane 并行轮询 | 91–92 | VGPR 从 98 降到 78 |
| `CHUNK_N` = 256 / 512 / 1024，`cwg` = 32 / 64 / 96 / 128 | 88–98 | 512 tokens 时差别不大；大 M 时 256 + 64 最好 |

### 4. 最终结果（复测版，当前代码；`experiments/fused_ar_final_recheck/results/final_recheck.txt`、`final_recheck_smallm.txt`）

**测法：** 每个配置在同一进程里先后测 gemm2(m)、two-shot、「gemm2(m) 后接 two-shot」（依次执行，实测而非相加）和融合 kernel。GPU 先排一个 `torch.cuda._sleep` 再连发 100 次，取 3 次中最好的一次，再取 8 卡中最慢的 rank。两边都包含 `out.zero_()`。每次运行都做 10 次正确性检查（对比 fp32 `dist.all_reduce`），结果都是 bad=0。每组测试前先用 `wait_gpu_idle.sh` 确认 GPU 空闲。

**结果**（c64，ch256，两次独立运行 A1 / A2，单位 us；被隐藏的比例 = (依次执行 − 融合) / two-shot）：

| tokens | gemm2(m) | two-shot | 依次执行 | 融合 A1 / A2 | 节省 | AR 被隐藏的比例 A1 / A2 |
|---|---|---|---|---|---|---|
| 128 | 52.2 | 12.6 | 65.3 | 76.6 / 74.5 | **+9 至 +11（变慢）** | −90% / −74% |
| 256 | 55.6 | 19.2–20.6 | 78.6–78.9 | 80.7 / 77.4 | 约 0 | −9% / +6% |
| 512 | 67.4–68.0 | 32.8 | 102.8–103.4 | 90.0 / 90.3 | −13 | 41% / 38% |
| 1024 | 98.4 | 60.2–60.6 | 163.1–163.9 | 133.8 / 135.7 | −28 至 −29 | 49% / 47% |
| 2048 | 159.3–159.9 | 113.4–113.9 | 279.5 | 227.2 / 224.7 | −52 至 −55 | 46% / 48% |
| 4096 | 281.1–283.9 | 248 | 519.5–532.4 | 394.6 / 412.2 | −107 至 −138 | 56% / 43% |
| 8192 | 527.6–529.6 | 465–469 | 1009–1017 | 718.1 / 725.3 | −291 | 62% / 63% |

其他运行中 c64 ch256 的数据：`persist_lite_sweep.txt` 里两次 `PERSIST=0`，1024 tokens 为 135.1 / 136.1（50% / 46%），2048 tokens 为 230.2 / 232.0（43% / 43%）。

**小 M 的配置扫描**（`final_recheck_smallm.txt`，两次运行 F1 / F2，融合时间，单位 us）：

| tokens | 依次执行 | c32 ch256 | c32 ch1024 | c64 ch256 | c64 ch1024 |
|---|---|---|---|---|---|
| 128 | 65.1–65.7 | 75.9 / 74.3 | 76.3 / 71.7 | 75.6 / 73.3 | 77.2 / 79.0 |
| 256 | 79.0–79.4 | 77.2 / 80.7 | 77.1 / 76.3 | 76.6 / 76.9 | 79.1 / 78.6 |
| 512 | 103.5–104.1 | 91.1 / 90.3 | 94.8 / 95.0 | 91.4 / 92.4 | 96.3 / 96.0 |

**大 M 的 cwg**（同一文件 C 组，ch256，c32 / c128，单位 us）：

| tokens | c32 | c128 |
|---|---|---|
| 1024 | 132.2 | 135.6 |
| 2048 | 240.7 | 247.0 |
| 4096 | 441.4 | 462.3 |
| 8192 | 861.5 | 999.1 |

c64 在大 M 时仍是最好的配置。

**可信度：**

- **512 至 2048、8192 tokens 可信。** 两次运行的融合时间相差在 1–3% 以内，依次执行的时间相差在 1% 以内。被隐藏的比例在这几档的波动约为 ±3 个百分点。
- **4096 tokens 噪声较大。** 融合 395 / 412、依次执行 520 / 532，被隐藏的比例落在 43–56%。同一时段 D 组的 sep 在 4096 tokens 也出现了 715 us 的异常值，推测有外部干扰。
- **128 / 256 tokens 的比例本身不稳定。** AR 只有 13–20 us，2–3 us 的抖动就会让比例变动 15 个百分点以上。不过结论是稳定的：6 次测量（A1、A2、F1、F2 以及 persist 扫描中两次 `PERSIST=0`）里，128 tokens 的融合时间为 71.7–79.0 us，**都比依次执行（65 us）慢**；256 tokens 时打平。
- **旧表（第一版，`gemm2_ar_fused_final.txt`）有两处与复测不符：**
  1. 128 tokens 旧表写的是「68.2 vs 71.3，−3」。旧表那次的「依次执行」偏高约 6 us：52.2 + 13.3 = 65.5，实测却是 71.3，而复测稳定在 65 us。当时的融合时间 68.2 也没能复现，第 11 节的「A 原样」已经是 76.7。**128 tokens 有收益的结论作废：小 M（≤256 tokens）应该回退到依次执行。**
  2. 2048 tokens 从 239.3（38%）变为 225–232（43–48%），这来自第 11 节的改动（237 → 233）和 `comm-wg-behavior.md` 里的 `WAIT_AG=par`。
- 第 9 节表格最后一列「v1 有依赖」引用的是旧表数据。

**为什么被隐藏的比例先升、到 2048 tokens 持平、再继续升**

记 O = 融合 − gemm2(m)，即融合相对纯 gemm2 多花的时间，则被隐藏的比例 = 1 − O / AR。

| tokens | 128 | 256 | 512 | 1024 | 2048 | 4096 | 8192 |
|---|---|---|---|---|---|---|---|
| AR（two-shot） | 12.6 | 20 | 32.8 | 60 | 113 | 248 | 466 |
| O | 22–24 | 22–25 | 22–23 | 35–37 | 65–72 | 113–129 | 190–198 |
| O / AR | 1.8 | 1.1 | 0.68 | 0.6 | 0.6 | 0.46–0.52 | 0.41 |
| nodep 上限 o=m / o=g（D 组，c64） | — | — | — | 34% / 32% | 60% / 45% | 78% / 68% | 84% / 71% |
| 融合中 gemm2 tile 结束 → 最后一个 unit 完成（E 组） | — | — | — | 101.0 → 118.3 | 181.0 → 206.7 | 351.0 → 397.0 | 635.8 → 737.6 |

按 O 的来源可以分成三段：

1. **≤512 tokens：O 基本是常数，约 22 us，所以比例随 AR 增大而上升。** 这部分与 M 关系不大：
   - comm WG 占槽位、kernel 的 VGPR 变多，tile 顺序 `g`、计数器 hook；
   - 最后一个 chunk 的尾巴（判定 + RS 握手 + 规约 + AG，约 8 us）；
   - 各 rank 的进度差。

   128 tokens 时 AR 只有 12.6 us，比这笔固定开销还小，所以为负。512 tokens 时 AR 为 33 us，固定开销被摊薄到 0.68 × AR。
2. **1024 至 2048 tokens：O 开始与 AR 同比例增长（约 0.6 × AR），比例持平。** 并发争抢成为主导：
   - 通讯被拖慢、跟不上 gemm2，尾巴从 17 us 增加到 26 us；
   - gemm2 本身也被拖慢，融合内 tile 结束于 181 us，单独跑约 159 us；
   - tile 顺序 `g` 的代价在并发下被放大：nodep 时 o=g 比 o=m 慢 1.5 us（1024 tokens）和 16 us（2048 tokens）。

   这些都随 M 增长，所以 2048 tokens 的比例不升反略降：当前代码为 43–48%，1024 tokens 为 46–50%，两者在噪声范围内持平。旧表的「突然降到 38%」主要是旧代码的问题，后续优化之后已经消失。
3. **≥4096 tokens：O / AR 降到 0.41–0.5，比例重新上升到约 60%。** nodep 上限本身在升高（o=g：32 → 45 → 68 → 71%）：
   - 「并发」比「各跑各的」多出的时间，即 nodep − max(gemm2 空转, comm 单独跑)，在 1024 / 2048 / 4096 / 8192 tokens 时分别为 38 / 39 / 45 / 27 us，基本不随 M 增长；而 AR 线性增长，所以相对代价越来越小。
   - 这段代价为什么与 M 无关，没有直接测出原因。
   - v1 与上限的差距却在拉大：8192 tokens 时 v1 为 62–63%，o=g 上限为 71%；尾巴从 46 us 涨到 102 us。原因是 c64 comm WG 的通讯速度本身就跟不上 gemm2：8192 tokens 时 comm 单独跑 575 us，gemm2 空转 533 us。到了后半程，每个 chunk 的第一个 unit 比 chunk 完成晚了最多 56 us。
   - 加大 cwg 也不行：c128 抢走了 gemm2 的 CU 槽位，反而慢很多（C 组）。

**结论：**

- 融合只在 ≥512 tokens 时有收益：512 tokens 省 13 us，1024 tokens 省约 29 us，2048 tokens 省约 53 us，4096 tokens 省 110–140 us，8192 tokens 省约 290 us。
- ≤256 tokens 应该回退到依次执行。
- 4096 / 8192 tokens 剩下的空间主要在尾巴上（46–102 us），需要更快的通讯：更少的字节（例如 fp8 传输），或者每个 WG 更高的吞吐。

### 5. 时间线揭示的剩余瓶颈（`experiments/fused_ar_timeline/fused_timeline.py`，`experiments/fused_ar_timeline/results/fused_timeline_v{2,3}.txt`）

1. **gemm2 自身被拖慢。** 512 tokens 时 tile 结束于约 73–75 us（单独跑约 67），2048 tokens 时 180 vs 166。原因有：
   - tile 顺序 `g` 加计数器，约 +2 至 +5；
   - comm 代码让 kernel 的 VGPR 从 72 涨到 78；
   - xGMI 和 HBM 流量互相争抢。
2. **每个 unit 的同步延迟高。** 从看到 chunk 完成到 rs flag 到齐要 4–15 us，其中一部分是各 rank 的 gemm 进度差：all-reduce 必须等最慢的 rank。2048 tokens 时通讯只跑到约 146 GB/s（单独的 two-shot 约 248），通讯越来越落后于 gemm，尾巴约 29 us。
3. **最后一个 chunk 无法掩盖。** 512 tokens 时约 8 us（判定 + RS 握手 + 规约 + AG）。小 M 时这段尾巴和 13 us 的 all-reduce 相当，所以 128 tokens 时几乎没有收益。

### 6. 后续可以尝试的方向

- **LL 协议**（mega_moe_tp 的 `ll_rs`）：flag 嵌在数据包里，每个 unit 省掉两次 flag 往返，主要针对小 M 和尾巴。
- ~~**topk 求和移到通讯阶段**（mega_moe_tp 的 route 模式）~~：已经试过，见第 8 节。gemm2 本身变快了，但通讯变慢更多，整体没有收益。
- ~~**压低 comm 代码的 VGPR**，或者让刚算完 tile 的 compute WG 顺手领取通讯任务（mega_moe_tp 的 `comm_help`）~~：已经试过，见第 7 节，没有收益。
- **在 gemm2 之后接 RMSNorm**（mega_moe_tp 的 `tn`），把下一层的输入处理也并进来。

### 7. 让 compute WG 顺手做通讯（`HELP`，ticket 协议）

**结论：** 让 compute WG 分担通讯会让 gemm2 明显变慢，整体反而更慢，不建议用。为它引入的 ticket 协议本身（`HELP=0`）和 v1 基本持平，但 gemm2 被拖慢得少一些。

**做法**（代码已撤销，只保留结论；当时位于 `gemm2_ar_fused.py` 的 `tile_hook`、`_claim_box`、`_drain_one`，配置为 `ar_config(..., help=N)`）：

1. **精确判定 chunk 完成。** compute WG 用带返回值的 atomic 给自己的计数器槽加 1。
   - 每个槽对应的 tile 数可以按 `bx % 32` 算出来；把槽加满的 WG 再给该 chunk 的「已满槽数」计数加 1（每个 chunk 只有 32 次）。
   - 把它加满的 WG 置 `ready[c] = epoch`。comm 侧从此只轮询一个 flag，不再轮询 32 个计数器。
2. **reduce-scatter 按 ticket 领取。** 每个 chunk 有一个 ticket 计数器。compute WG 算完 tile 后，依次检查上一个 chunk 和自己的 chunk 是否 ready；ready 就领最多 `HELP` 个 ticket，执行对应 unit 的 reduce-scatter 推送（不等待对端）。
3. **comm WG** 等自己负责的 unit 所在 chunk ready 后，先把该 chunk 剩下的 ticket 领完做掉，再做自己 unit 的规约和 all-gather。
4. 正确性：所有配置 bad=0。当时用一个调试脚本（已随代码删除）验证过：每个 chunk 都正好计满 512 个 tile、32 个槽，并且被置 ready。

**结果**（`experiments/fused_ar_comm_help/results/gemm2_ar_help_sweep.txt`，64 个 comm WG，256 列 chunk；单位 us）：

| tokens | 依次执行 | v1（`HELP=-1`） | ticket，`HELP=0` | `HELP=1` | `HELP=2` |
|---|---|---|---|---|---|
| 128 | 66–68 | 75.5 | 74.4 | 76.5 | 78.9 |
| 512 | 101–104 | 92.1 | 94.9 | 97.5 | 106.4 |
| 1024 | 163–166 | 134.5 | 137.2 | 147.9 | 153.2 |
| 2048 | 278–282 | 234.5 | 231.9 | 248.0 | 264.2 |

时间线（`experiments/fused_ar_comm_help/results/fused_timeline_help.txt`）解释了原因：

- **`HELP=0`**：gemm2 被拖慢得更少，2048 tokens 时 tile 结束于 161.5 us，v1 是 180。原因是单个 ready flag 取代了 32 个计数器的轮询。代价是瓶颈完全转到通讯：最后一个 chunk 在 161.5 完成，最后一个 unit 到 204.4 才结束，尾巴约 43 us。
- **`HELP=1`**：gemm2 的 tile 结束时间从 161.5 推迟到 194.2 us（+33 us），512 tokens 时从 70.8 推迟到 76.4。
  - 帮忙的 WG 要先读 ready flag、做 ticket atomic，推送远端数据后还要等写入确认（`vmcnt(0)`），这几步都是微秒级延迟。
  - 在这段时间里 WG 一直占着 CU 槽位，新的 gemm2 tile 发不进来。
  - 非常驻的 gemm2 里，每个 compute WG 只活约 10–20 us，多出几微秒就是 10–20% 的吞吐损失；省下的通讯时间远不够抵消。
  - mega_moe_tp 能这么做，是因为它的 CTA 常驻，comm wave 和 compute wave 在同一个 CTA 里交错执行，不存在释放槽位的问题。
- **加更多 comm WG 也没用**（`experiments/fused_ar_comm_help/results/gemm2_ar_ticket_cwg.txt`）：`HELP=0` 时 64、128、192 个 WG 的结果相同（2048 tokens 时 232–237 us）。`vpt=2` 更慢。瓶颈是每个 unit 的同步延迟，加上各 rank 进度不一致。

**期间遇到的坑：**

- kernel 名里出现 `-`（`help=-1` 拼进了名字）会让汇编器的 `.amdhsa_kernel` 指令解析失败，表现为 `ld.lld: ... at least one .o file required`，看起来很像多 rank 并发编译的竞争。现在名字里的 `-` 统一替换为 `m`。
- 在 FlyDSL 里，嵌套 `@flyc.jit` 函数的返回值拿来做 `while` 的循环变量时出现了错误值（导致越界访存）和挂死。改为把值写进 LDS、调用方每次重新读取，循环改成有上界的 `for`。
- 编译期 `if const_expr(...)` 后面接运行时 `elif` 时，FlyDSL 的 AST 改写不可靠，要拆成两个独立的 `if`。

### 8. topk 求和移到通讯阶段（`ROUTE=8`，mega_moe_tp 的 route 行）

**结论：** gemm2 本身变快了：不再需要 atomic 和 `moe_buf` 清零，单独跑时基本追平 gemm2(m)。但 reduce-scatter 每个向量要读 8 行，通讯变慢，整体比 v1 的 atomic 方式慢 3–16 us，不建议用。

**做法**（`ar_config(..., route=topk)`；gemm2 中的 `_route_bf16_epilog`；`gemm2_ar_fused.py` 中的 `_load_partial`）：

- **gemm2 不再用 atomic。** 每个路由行 (token, k) 的加权结果写到独立的一行 `route[token*topk + k]`，用 sc0\|sc1 写穿（其他 XCD 上的 comm WG 绕过 L2 读取），因此不需要清零 `moe_buf`。
  - FlyDSL/LLVM 的坑：`buffer_store` 一个 `vector<1xi32>` 会让指令选择崩溃（`Do not know how to scalarize this operator's operand`），要存标量 i32。
- **reduce-scatter 时求 topk 和。** 对目标 shard 的每个 token，读出它的 8 行 route，用 fp32 求和后转成 bf16，再推送给 owner。
- **精度：** 每个 rank 先在 fp32 下求和、只舍入一次 bf16，好过 atomic 方式的 8 次 bf16 累加。参考结果需要按同样的舍入点计算，之后 bad=0。

**结果**（`experiments/fused_ar_route/results/gemm2_ar_route_sweep.txt`，64 个 comm WG，256 列 chunk；单位 us）：

| tokens | gemm2(m) + two-shot | gemm2 单独跑：atomic（skip） | gemm2 单独跑：route（skip） | 融合：atomic | 融合：route |
|---|---|---|---|---|---|
| 128 | 72.2 | 55.8 | 54.5 | 75.4 | 78.6 |
| 512 | 102.8 | 71.8 | **64.8** | **92.8** | 97.3 |
| 1024 | 164.0 | 105.1 | **98.0** | **136.8** | 148.6 |
| 2048 | 281.6 | 179.8 | **161.0** | **237.9** | 254.3 |

时间线（`experiments/fused_ar_route/results/fused_timeline_route.txt`）：

- route 模式下 gemm2 的 tile 结束更早（2048 tokens 时 178 vs 187 us）。
- 但每个 unit 从看到 chunk 完成到 RS 握手完成，由 6–10 us 涨到 13–25 us，原因是每个向量要额外读 8 行、全部 L2 未命中。最后一个 unit 在 2048 tokens 时到 235.6 us 才结束（atomic 为 210.8）。
- 调参都没用（`experiments/fused_ar_route/results/gemm2_ar_route_{cwg,batch}.txt`）：comm WG 增加到 128/192/256，每批 2/4/8 个 peer 的 `ROUTE_BATCH`，512 列 chunk，结果都在 96–103 us（512 tokens）和 241–285 us（2048 tokens）之间。
- 原因是：topk 求和本来由 8000 个 compute WG 并行做 atomic，现在挪到了几十个 comm WG 上，正好压在通讯这条关键路径上。mega_moe_tp 能这么做，是因为它的通讯由常驻 CTA 里大量空闲的 wave 动态认领，并行度远高于这里的 64 个 comm WG。

### 9. 并发上限：all-reduce 与 gemm2 完全无依赖（`nodep`）

**问题：** 如果 all-reduce 根本不用等 gemm2 的结果，两者并发时最多能隐藏多少？这给出任何依赖调度方案（chunk 计数、ticket、LL 协议等）的天花板。

**做法**（`experiments/fused_ar_concurrency_bound/concurrency_bound.py`；`ar_config(..., nodep=True)`）：

- all-reduce 的输入是对称 buffer 里一块独立的 `src` 区（每个 rank 填自己的随机数据），与 gemm2 的 `moe_buf` 无关。comm WG 跳过 `_wait_chunk`，一启动就做 reduce-scatter → 规约 → all-gather；其余代码与 v1 完全相同（同样的 unit 划分、flag 协议、sc0\|sc1 读写）。gemm2 照常算，照常做 tile 计数器 atomic。
- nodep 时不要求 tile 顺序 `g`，所以 `o=m`（gemm2 最快的顺序）也能测。
- 对比的几种并发方式：
  - **side stream**：gemm2(m) 在主 stream，现成的 two-shot all-reduce（数据是另一块 buffer）放在高优先级 side stream，两种入队顺序都测；
  - **fused nodep**：同一个 kernel，额外 c 个 comm WG 做 all-reduce；
  - **sep nodep**：gemm2(m) 加上一个单独的 comm kernel（c 个 WG，同样的 comm 代码），放在 side stream；
  - **fused idle**：comm WG 也启动，但什么都不做（`skip`），用来单独测出它们占位（grid、VGPR）的代价；
  - **commWG alone**：comm kernel 单独跑，测 c 个 comm WG 本身的通讯速度。
- 正确性：所有配置的结果都等于 fp32 all_reduce(src)，bad=0。

**结果**（`experiments/fused_ar_concurrency_bound/results/gemm2_ar_concurrency_bound{,_run2}.txt`，两次运行的范围；256 列 chunk；单位 us；AR 被隐藏的比例 = (gemm2 + AR − 实测) / AR）：

| tokens | gemm2(m) | two-shot AR | 依次执行 | side stream（较好的入队顺序） | sep nodep（最佳 c） | **fused nodep（最佳）** | 被隐藏的比例上限 | v1 有依赖（第 4 节） |
|---|---|---|---|---|---|---|---|---|
| 128 | 52.4–52.8 | 13 | 66–68 | 71–72 | 72–74（c32/c64） | **59–61**（o=m c32/c64） | 约 35–50% | 68.2 |
| 512 | 68–70 | 32–33 | 100–101 | 104–105 | 101–102（c64） | **82–85**（c32） | 约 50–55% | 90.9 |
| 1024 | 99–100 | 60–62 | 161–162 | 157–159 | 146–148（c32） | **131**（o=m c32） | 约 48% | 134.3 |
| 2048 | 159 | 113–114 | 270–271 | 272–277 | 214–219（c64） | **199**（o=m c64） | 约 65% | 239.3 |

其他数据（同一组输出）：

- comm WG 空转的代价：fused idle 比 gemm2(m) 只多 0–9 us（2048 tokens 时 166–169 vs 159）。
- comm WG 单独跑的速度：c64 基本等于 256+ WG 的 two-shot（2048 tokens 时 111–113 vs 113）；c32 慢一些（135）；c128 略快（106–108）。
- tile 顺序：o=g 比 o=m 慢 0–3 us（≤1024 tokens），2048 tokens 时慢 12–15 us（并发下，顺序 `g` 的代价放大了）。
- c128 无论哪种方式都很差：fused 时只隐藏 5–18%（占掉了 gemm2 的 CU 槽位）；sep 时反复出现 280–475 us 的异常值。

**结论：**

1. **完全无依赖时，AR 最多也只能隐藏约一半（35–65%），离理想的 max(gemm2, AR) = gemm2 很远。**
   - 2048 tokens 时，理想值是 159 us，上限实测 199 us。
   - fused idle 证明占位代价很小，所以剩下的约 40 us 是两者真正**同时跑**时的资源争抢。
   - 争抢的资源：一是 HBM/L2，peer 写进来的 inbox 和 gather、comm 侧读 src 和 inbox，与 gemm2 读权重、做 atomic 抢带宽；二是同一个 CU 上的 issue/VMEM 槽位，comm WG 和 compute WG 共享 CU，comm 的访存延迟被拉长，gemm2 也被拖慢。
   - 例如 2048 tokens 时，c32 单独跑只要 135 us（< gemm2 的 159），并发时却要 229 us：通讯在并发下被严重拖慢。
2. **side stream 基本没有并发**（隐藏 −40% 至 +17%，大多数 ≈0）。
   - gemm2 的 grid 远大于一屏，CU 槽位一直被 gemm2 WG 占满。另一条 stream 的 kernel 只能等 gemm2 的尾部 WG 退出后才分发进来，高优先级也不会抢占正在运行的 WG。
   - two-shot 跨 rank 自旋同步，各 rank 等最晚分发的那个，实际上等价于依次执行，还多出跨 stream 同步的开销。
   - AR 先入队时偶尔出现 276 us：先分发的 AR WG 占着 CU 自旋，等待还没分发的 peer。
3. **sep nodep**（单独的 comm kernel，配合 side stream）在 2048 tokens 时有一定并发（c64 时 214–219），但比 fused 差 15–20 us，而且不稳定：c128 和部分 c32/c64 配置会出现 280–510 us 的异常值。原因是各 rank 的 comm kernel 分发时刻差别很大，一个 rank 的 comm WG 迟迟分发不进来，所有 peer 都在空等。**所以把 comm WG 和 gemm2 放在同一个 kernel 里（保证它们同时驻留）是唯一可靠的并发方式。**
4. **v1（有依赖）离上限还有多远：**
   - 512 tokens：90.9 vs 82–85，主要差在 comm WG 数。nodep 时 c32 最好，因为通讯不必追上 gemm2，WG 越少争抢越小；v1 需要 c64 来缩短最后一个 chunk 的尾巴。
   - 1024 tokens：134.3 vs 131，已经基本到上限。
   - 2048 tokens：239.3 vs 199，差约 40 us，其中约 14 us 来自 tile 顺序 `g`（o=g 的上限是 211–214），其余是第 5 节说的通讯掉队、尾巴约 25 us。
   - **依赖调度方案能够挽回的空间：** 128 tokens 约 7–9 us，512 tokens 约 6–9 us，1024 tokens 约 3 us，2048 tokens 约 25 us（保持顺序 `g`）到 40 us（如果能不用顺序 `g`）。超出这些的部分只能靠**减少通讯字节**（例如 fp8 传输），或者降低 gemm2 自身的带宽占用，才能进一步压缩。

### 10. thread trace 分析（ATT，TP4，512 tokens，c64 ch256）

**数据来源：**

- trace：`ck_test/ui_output_agent_52389_dispatch_3909`，分析脚本 `experiments/fused_ar_att/att_analyze.py`，输出存为 `experiments/fused_ar_att/results/att_fused_tp4_512.txt`。
- 每个 SE 只采了 CU0，共 4 个 CU、632 个 wave，其中 comm wave 只采到 8 个（2 个 WG）。时钟按 `realtime.json` 换算为 1703 cycle/us。
- ATT 本身会拖慢执行，所以下面的绝对时间只作参考，看比例。
- 注意：`make_case` 里写死了 I=256，所以 TP4 跑出来的仍是 TP8 的 per-rank shape（kernel 名里是 `i256`）。

**compute wave**（420 个，生命周期中位数 6.87 us）：

| 阶段 | us/wave | 占比 | 主要构成 |
|---|---|---|---|
| prologue | 0.54 | 7% | 标量参数加载、tile 判定 |
| 加载 + 反量化 + mfma，C-tile 写进 LDS | 5.34 | 73% | VALU 2.1 us，vmcnt 等待 1.4 us |
| epilogue（atomic） | 0.86 | 12% | **vmcnt 等待 0.57 us** |
| tile hook | 0.55 | 7.5% | barrier 0.24 us，vmcnt(0) 0.24 us，wave0 读 tbl 0.31 us |

**comm wave**（每个 WG 依次处理 4 个 unit，每个 unit 约 5 us）：

| 阶段 | 每个 unit 的耗时 |
|---|---|
| 等 chunk 完成（wave0 自旋，其余 wave 停在 barrier） | 约 4.3 us |
| 每个 unit 重新读 npes 个 peer 基址 | 0.38 us |
| reduce-scatter：读 `moe_buf` | 0.32 us |
| reduce-scatter：远端写确认 `vmcnt(0)` | 1.03 us |
| 发布 flag：读 tbl | 0.26 us |
| 等所有 peer 的 rs flag | 0.94 us |
| 读 inbox | 0.52 us |
| all-gather：远端写确认 `vmcnt(0)` | 1.1 us |
| 发布 flag：读 tbl | 0.34 us |

时间线：采样的 CU 上，gemm wave 在 41.6–45.8 us 全部结束，comm 在 48.9–55.4 us 结束，**尾巴 3–10 us**。

**优化点**（按收益排序）：

1. **gemm2 是 VALU 瓶颈**（与融合无关）。
   - 每个 wave 执行 437 条 VALU，mfma 只有 24 条：fp4→fp8 反量化约 280 条（`v_perm` 96、and/or/shift 约 150），epilogue 的 bf16 RNE 舍入约 60 条，外加 `s_nop`。
   - 估算每个 SIMD 的 VALU 占用约 64%，mfma 约 14%。
   - 方向：精简反量化序列（每个输入 dword 现在约 17 条，目标约 8 条）；bf16 舍入去掉 NaN 分支（`v_cmp_u`/`v_cndmask`/`v_or`，每个元素省 3 条）。
2. **epilogue 中途在等 atomic 完成**（每个 wave 0.57 us，占 8%）。
   - 两个 token id 的 load（v9、v7）在第一批 atomic 发出之后才被使用。gfx9 上 load 和 store/atomic 共用一个按顺序计数的 vmcnt，所以 `s_waitcnt vmcnt(1)`/`vmcnt(0)` 实际在等前面的 atomic 写完，各组 atomic 被串行化。
   - 修法：先用完所有 token id（行掩码、地址），再一次性发出全部 atomic。单独跑的 gemm2 也同样受益。
3. **tile hook 每个 wave 0.55 us。**
   - wave0 的 `global_load tbl[rank]` 是一次依赖访存（532 cycle）。改为 kernel 参数直接传入本 rank 的计数器基址，或在开头用 `s_load` 预取。
   - 可以改成每个 wave 各自 `vmcnt(0)` 后各自做计数器 atomic（target ×4），去掉 `s_barrier`，让 wave 独立退出、尽早释放槽位。
   - 第 2、3 两项加起来约占 wave 生命周期的 19%。WG 不是常驻的，等待期间会一直占着 CU 槽位。
4. **comm unit 的延迟几乎全是同步往返。**
   - peer 基址表和发布 flag 时要用的 tbl 每次都从全局内存重新读：改为每个 WG 开头读一次、放进 SGPR，每个 unit 省约 0.6–0.7 us。
   - 两次远端写确认加一次 flag 等待，每个 unit 约 3 us。LL 协议（flag 嵌在数据里）可以去掉这几次往返。
   - 也可以在 WG 内做跨 unit 的软件流水：先发出 unit q+1 的读写，再等 unit q 的写确认。
   - 这三项直接缩短尾巴（最后一个 chunk 的约 5 us 和各 rank 间的进度差）。
5. 次要：
   - 3 次依赖访存（sorted id/expert → A/B → scale）的等待约 1.4 us/wave，靠占用率掩盖；可以把 scale 的 load 和 B 一起提前发出。
   - 空 tile 占 204/632 个 wave，每个只有 0.14 us，可以忽略。

### 11. 按 thread trace 结论做的优化尝试

**结论：** 第 10 节列的几处开销都已消除，ISA 层面确认生效，但端到端几乎没有收益。只有融合 2048 tokens 快了约 2%（237 → 233 us）。gemm2 单独跑的时间完全没变。

由此可以确认：

- 那些等待会被同 CU 上的其他 wave 掩盖，不在关键路径上。
- gemm2 也**不是 VALU 瓶颈**。删掉约 7% 的 VALU 指令，耗时没有变化，所以第 10 节按指令数估算的 64% VALU 占用率并不说明瓶颈在 VALU。
- 剩下的开销基本就是第 9 节的并发争抢，只靠省指令和省等待压不下去。

**做法**（每项都是环境变量开关，并写进 kernel 名，保证 JIT key 不同）：

| 开关 | 改动 | 是否生效 | 默认 |
|---|---|---|---|
| `EPI_DRAIN=1` | epilogue 在发第一个 atomic 之前先 `s_waitcnt vmcnt(0)`，把早已返回的 token id load 清掉 | ISA 确认：8 个 atomic 连续发出，中间的 `vmcnt(2)/(1)/(0)` 消失 | 开 |
| `TBL=s` | 对称表 `tbl[i]` 改用两个 `s_buffer_load_dword`，走标量缓存直接进 SGPR。用在 gemm2 的 hook（并且在 tile 开始前就发出）、comm 每个 unit 的 peer 基址、发布 flag。`TBL=v` 是原来的向量 load 加 readfirstlane | — | `s` |
| `AR_HOOK=wave` | 每个 wave 各自 `vmcnt(0)` 后由 lane 0 给计数器加 1，comm 侧 target ×4，去掉 WG barrier | — | `wave` |
| `BF16_FAST=1` | epilogue 的 bf16 舍入改为 `bits + 0x7FFF + lsb`，去掉 NaN 处理，每个值约少 3 条 VALU 和一个 `s_nop` | 正确（16/16） | 关 |
| `WPERM=1` | fp4→fp8 解码去掉 even/odd 交织用的 2 个 `v_perm`（每个 dword 共 6 个）：kernel 的 VALU 从 853 降到 789，`v_perm` 从 192 降到 128 | 正确，见下 | 关 |

**WPERM 的正确性：** 用标准 preshuffle 权重，去掉交织后依然正确。

- pytest 16/16 通过，误差与原来相同（1−cos 约 9.4e-6）。
- 单点探针 `experiments/fused_ar_opt_ab/wperm_probe.py`：A 只在第 k 列为 1，W 只在第 k' 列为 2。两种解码得到的都是严格的对角，即 A[k] 只与 W[k] 配对。
- 原因还没想清楚：从源码推导，交织应该决定 B 的字节顺序。由于没有速度收益，没有继续深究，默认关闭。

**结果**（`experiments/fused_ar_opt_ab/results/opt_ab_sweep.txt`，8 卡，c64 ch256，单位 us。标了 INVALID 的那组是在别人占满 GPU 时跑的，作废）：

| tokens | gemm2(m) 单独跑：A / D | 融合，A：原样（3 次中位数） | 融合，D：DRAIN+TBL=s+wave（5 次中位数） | 融合，E/F/G：D 加 BF16_FAST / WPERM / 两者 |
|---|---|---|---|---|
| 128 | 52.2 / 52.3 | 76.7 | 76.3 | 74.5 / 73.7 / 75.1–79.3 |
| 512 | 67.3 / 67.6 | 90.9 | 91.6 | 93.1 / 91.4 / 91.1–92.0 |
| 1024 | 98.1 / 97.8 | 132.0 | 133.6 | 134.5 / 135.4 / 134.3–134.8 |
| 2048 | 159.5 / 159.1 | 237.1 | **232.6** | 232.2 / 231.1 / 229.7–229.9 |

**注意事项：**

- 这台机器的 GPU 和别人共用。有一组测试遇到 8 个外部进程、100% 占用，时间被放大了 3–8 倍。
- 现在用 `experiments/tools/wait_gpu_idle.sh` 先确认 GPU 空闲（`rocm-smi --showuse/--showpids`）再跑。
- 多组 torchrun 循环运行期间不要修改 kernel 源码，后面的组会导入改了一半的代码。

### 12. 评估：改成常驻 CTA（仿 mega_moe_tp）有没有进一步收益

**问题：** 从 ATT 里看到，同一个 wave 槽位上相邻两次 gemm2 CTA 启动之间有空隙。改成 persistent CTA 能否消除这部分开销？进一步，仿照 mega_moe_tp 的整套方案能否继续提升？

**1. 槽位空隙有多大**（`experiments/fused_ar_persistent/att_slot_gaps.py`，trace 56655，TP4，512 tokens，每个 SE 采 CU0）：

- gemm2 阶段内，槽位空闲时间只占 **4.1%**。
- 相邻两个 gemm wave 之间的间隔：中位数 0.20 us，p75 0.47，p90 0.84，最大 1.64 us。
- 把这部分全部消除，上限也只有 gemm2 时间的约 4%：512 tokens 约 2–3 us，2048 tokens 约 6 us。

**2. mega_moe_tp 方案的要点**（源码见上游 `aiter/ops/flydsl/kernels/mega_moe_tp`）：

- 常驻 CTA，每个 CTA 4 个 wave，按角色分工：wave 0–2 做计算，wave 3 的不同 lane 组分别做 A 加载、all-gather 发送、轮询等。
- 各 CTA 用 atomic 认领工作单元。
- A 有 3–4 份 LDS 缓冲，加载提前 1–3 个 tile。
- 在同一个 CTA 内，计算与通讯交替进行（`comm_help`）。
- 可选 LL 协议（flag 嵌在数据里）。

**3. 改成常驻 CTA 理论上能挽回什么，以及上限**（每个 gemm wave 的耗时取自第 10 节和 trace 56655）：

| 来源 | 目前每个 gemm wave 的开销 | 常驻后能否挽回 |
|---|---|---|
| 槽位空隙（每次分发） | 占槽位时间 4.1% | 基本能，但量很小 |
| 每个 tile 重复执行的 prologue（参数 load、tile 下标解码） | 约 1.0 us | 参数 load 只需做一次，解码仍然每个 tile 都要做；而且目前已有其他 wave 帮忙掩盖 |
| tile hook 等自己的 atomic 落地 | 约 0.96 us | 可以推迟到下一个 tile 的 load 发出之后再报数，需要重新设计顺序 |
| 单个 K tile，load 延迟无法流水（vmcnt 等待） | 约 1.4 us | 这是 mega_moe_tp 真正发挥作用的地方：提前加载下一个 tile 的 W/A，LDS 多缓冲。128 tokens 时 gemm2 读权重约 2.5 TB/s，还有余量；2048 tokens 时瓶颈不在带宽 |
| 空 tile（trace 中 228 个 wave，每个约 0.2 us） | — | 常驻后不再分发这些 tile |

**上限受第 9 节的并发争抢限制：**

- 即使 all-reduce 与 gemm2 完全无依赖，AR 也只能隐藏 35–65%。常驻 CTA 并不减少 HBM 和 xGMI 上的字节数。
- v1 离这个上限：512 tokens 差 6–9 us，1024 tokens 差约 3 us，只有 2048 tokens 差 25–40 us（其中约 14 us 来自 tile 顺序 `g`）。
- mega_moe_tp 依赖的几项手段，在本架构上已经试过，都是负收益：
  - LL 协议：慢约 2 倍（`comm-wg-behavior.md` 第 9 节）；
  - compute WG 顺手做通讯：变慢（第 7 节）；
  - comm 代码加大共用的寄存器分配：VGPR 从 77 涨到 128。
- mega_moe_tp 能用这些手段，前提是 comm wave 本身就常驻在 CTA 里。照搬就意味着调度、多缓冲流水和通讯三部分一起重写。

**4. 低成本验证：`PERSIST=k`（persistent-lite）**

- 在 `test_a8w4_gemm2.py` 里加了开关：只启动 k × CU 数个 compute CTA，每个 CTA 按 grid stride 循环处理 tile（`for t in range(bx, bound, grid_dim.x − cwg)`），每个 tile 之后 `gpu.barrier()`。tile 本身的代码和 comm role 都不变；CTA 数是 8 的倍数，tile 仍落在原来的 XCD 上。
- 默认 `PERSIST=0`，行为与原来一致。不过 `_entry` 为此改成了「嵌套函数 `_tile_work` 加调用」的结构。
- 正确性：pytest 在 `PERSIST=0` / `4` / `6` 下都是 16/16 通过。`PERSIST=4` 最初那次失败是 `gpu.grid_dim` 的用法错误，修正为 `gpu.grid_dim.x` 后重跑通过。
- 结果（`experiments/fused_ar_persistent/results/persist_lite_sweep.txt`，8 卡，c64 ch256，单位 us；k=4 那一轮正好碰上上面的错误，所以没有数据）：

| tokens | gemm2(m)：k=0 / 5 / 6 / 8 | 融合：k=0 / 5 / 6 / 8 |
|---|---|---|
| 128 | 51.7–52.3 / 60.1 / 56.3 / 55.1 | 72.4–77.2 / 77.4 / 74.1 / 77.2 |
| 512 | 66.7–68.5 / 76.6 / 73.8 / 70.7 | 90.7–90.8 / 98.1 / 97.4 / 95.9 |
| 1024 | 98.0–98.6 / 114.1 / 109.8 / 106.6 | 135.1–136.1 / 155.6 / 149.5 / 148.3 |
| 2048 | 158.5–159.3 / 196.4 / 188.1 / 181.0 | 230.2–232.0 / 286.2 / 269.5 / 256.6 |

- **所有 k 都更慢**：gemm2 单独跑慢 6–24%，融合慢 2–24%。k 越大越接近原版，但始终比不上。
- 原因：各 tile 的代价很不均匀，例如每个专家的行数不同，还有空 tile。原版把 tile 交给硬件分发，哪个槽位空了就分给谁，是动态负载均衡；grid stride 是静态分配，最慢的 CTA 决定总时间。每个 tile 后的 `barrier` 也让同一个 CTA 内的 wave 互相等待，失去了 wave 之间的错位掩盖。省下来的槽位空隙（4.1%）远小于这两项损失。
- 如果要真正做成常驻 CTA，至少需要用 atomic 动态认领 tile（mega_moe_tp 的做法），并且做跨 tile 的预取流水，才可能有收益。这接近重写。

**结论：** 槽位空隙不在关键路径上，静态的常驻方案是负收益。照搬 mega_moe_tp 整套方案，潜在收益主要在小 M 下 gemm2 的预取流水，代价是大规模重写；而它的通讯部分（LL、compute 顺手做通讯）在本架构上已经证明是负收益。目前不建议投入。代码里保留了 `PERSIST` 开关，默认关闭。

### 运行

```bash
# tile 顺序探针（单卡）
ORDERS=m,n,nx,g python doc-mimo/experiments/gemm2_tile_order/g2_order_probe.py
# 融合 vs 依次执行（8 卡）；CWG / VPT / SPLIT / SEP / CHUNK / MODES=skip,run / WPE / A_GROUP / ROUTE（0 = atomic，8 = topk 求和放到通讯阶段）/ ROUTE_BATCH
CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 512 2048
# 时间线（AR_PROBE=1 自动打开；ROUTE=8 可选）
CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/experiments/fused_ar_timeline/fused_timeline.py 512 2048
# 并发上限（第 9 节）：side stream / fused nodep / sep nodep / idle / comm 单独跑
CWG=32,64,128 CHUNK=256 torchrun --nproc_per_node=8 doc-mimo/experiments/fused_ar_concurrency_bound/concurrency_bound.py 128 512 1024 2048
```

### 实验目录

各节对应的实验目录（`experiments/<实验名>/`，每个目录含 README、脚本和 `results/`；总索引见 [experiments/README.md](experiments/README.md)）：

| 本文章节 | 实验目录 |
|---|---|
| 前半部分（N 维切分 TP）第 1 节 | `gemm2_epilog_ablation` |
| 前半部分第 2–4 节 | `nsplit_tp_allgather` |
| 前半部分第 5 节 | `fused_quant` |
| 后半部分第 2 节（tile 顺序） | `gemm2_tile_order` |
| 第 3 节（优化过程）、第一版最终结果 | `fused_ar_dev` |
| 第 4 节（复测） | `fused_ar_final_recheck` |
| 第 5 节（时间线） | `fused_ar_timeline` |
| 第 7 节（compute WG 帮忙） | `fused_ar_comm_help` |
| 第 8 节（route 模式） | `fused_ar_route` |
| 第 9 节（并发上限） | `fused_ar_concurrency_bound` |
| 第 10 节（ATT） | `fused_ar_att` |
| 第 11 节（优化 A/B、WPERM） | `fused_ar_opt_ab` |
| `comm-wg-behavior.md` | `fused_ar_comm_wg` |
| 第 12 节（常驻 CTA） | `fused_ar_persistent` |

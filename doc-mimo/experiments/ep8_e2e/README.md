# ep8_e2e：EP8（专家并行）MoE 端到端优化与调度实验

EP8 每卡 shape：256 个专家中本卡 32 个、model_dim H=4096、inter I=2048、topk 8。
两种数据类型：**a8w4**（x 量化成 fp8 + 每行 scale，W fp4）和 **a16w4**（x bf16，W fp4）。
kernel 在 `doc-mimo/kernels/ep8_{prep,moe}.py`，设计见 `doc-mimo/README.md` 第 8 节。

## 结论

最终版本（`results/e2e_v5.txt`，`ep8_moe(..., cfg=None)` 按 token 数自动选配置，冷 cache，单位 us）：

| tokens | a8w4 | a16w4 | mem 下限 | 计算下限 a8w4 / a16w4 | a8w4 x mem / x sum | a16w4 x mem / x sum | TP 调好的 a8w4 kernel 直接跑 EP |
|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 42 | 42 | 7.4 | 0.1 / 0.2 | 5.70 / 5.63 | 5.64 / 5.51 | 57 |
| 16 | 64 | 73 | 40.9 | 0.6 / 1.1 | 1.57 / 1.54 | 1.79 / 1.74 | 149 |
| 64 | 126 | 146 | 108 | 3.0 / 5.3 | 1.17 / 1.13 | 1.35 / 1.29 | 165 |
| 256 | 145 | 163 | 120 | 11.4 / 20.0 | 1.21 / 1.10 | 1.36 / 1.16 | 174 |
| 1024 | 188 | 240 | 123 | 46 / 81 | 1.53 / 1.11 | 1.95 / 1.18 | 247 |
| 4096 | 408 | 603 | 136 | 195 / 342 | 3.00 / 1.23 | 4.43 / 1.26 | 668 |
| 16384 | 1288 | 1726 | 187 | 772 / 1353 | 6.88 / 1.34 | 9.22 / 1.12 | 2275 |

- mem 下限 = 本卡活跃专家的权重 + 激活读写，按 3.6 TB/s（750 W 功耗墙下纯读实测）；计算下限按 hipBLASLt 在同 shape dense GEMM 的实测吞吐（fp8 1117/1002 TF，bf16 637/571 TF，见 `ep8_roofline/`）。x sum = 实测 / (mem + 计算)。
- 交错 A/B（`bench_ab_e2e.py`，5–7 轮中位数）比这张表低 5–10%（例如 16384 tokens a8w4 1158 us、4096 tokens a16w4 549–580 us）：`bench_e2e.py` 每个配置只测一次，受功耗/时钟状态影响更大。
- 对比 TP 调好的 2-kernel a8w4（`ep8_baseline/results/baseline.txt`）快 1.2–2.3 倍；aiter `fused_moe` 的 a16w4 路径在当前环境下加载失败（JIT 模块符号缺失），没有对比数据。
- **离目标的差距：**
  - 小 batch（≤16 tokens）还没到 memory-bound：prep 约 8–10 us、3 次 launch 的固定开销，加上只有 1–11 个专家活跃、能并行读 W 的 WG 太少。1 token 时 W 只有 7.4 us 的量，固定开销占了大头。
  - 中等 batch（1024–8192）比 mem + 计算之和慢 11–37%：tile 数只有 CU 数的 1.7–3 倍，轮次量化明显；a8w4 的 gemm1 输出按 (行, 128 列) 量化，NI 不能小于 128，没法切得更细。
  - 大 batch（16384）a8w4 是计算下限的 1.5–1.7 倍、a16w4 的 1.3 倍：MFMA 利用率约 45–60%；和 pyhip 的 FP8 权重版相比，gemm1 只差 7–12%，gemm2 差 15–25%（`doc-mimo/README.md` 8.6）。

## 本轮（v3 → v5）做了什么

| 改动 | 效果（交错 A/B） |
|---|---|
| **`_opaque_tx`**：在每个 tile 的 body 前，把 `tx` 经一条带副作用的 `v_mov` inline asm 复制一份，再从它推出 lane / wave | LLVM 不再把 body 里按 lane 算的地址提到循环外 / kernel 开头，**所有配置 0 spill**：bf16 gemm1 256 VGPR + 15 spill → 254、gemm2 256 + 22 spill → 238；fp8 gemm1 234 → 212、gemm2 220 → 202。a16w4 16384 tokens 1850 → ~1705–1740 us |
| **prep 生成 tile 调度**（`sched`）：块按专家顺序、按估计代价切成 8 段连续区间（每个 XCD 一段），段内重块在前；GEMM 的 WG bx 去第 bx % 8 段的第 bx // 8 个 tile，由硬件按 WG 顺序动态派发 | m64/l128：4096 tokens −9% / −14%，16384 −3% / −1%，1024 −0.5 ~ −5%；热点路由 4096 −2% / −8%。s16/s32 上慢 2–7%，这两档关掉 |
| **t16 配置**（≤8 tokens）：gemm2 NO=64、a16w4 的 gemm1 NI=64 / gemm2 NO=128，让更多 CU 同时读 W | a8w4 −6 ~ −10%，a16w4 −20 ~ −26% |
| **按 token 数自动选配置**（`ep8_moe.AUTO` / `pick_cfg`） | ≤8 t16，≤480 s16，≤960 s32，≤2176 m64，其余 l128（各档边界处 A/B 实测） |
| **single_store**（v5，参考 pyhip `moe_a8w8_blockscale_gfx942.md`）：prep 用 wave ballot 数出每个 token 的本地路数（`route_counts`），单路 token 的 sorted id 置符号位；gemm2 对这些行用普通 store，gemm1 只清零路数 ≠ 1 的行（路数先读进 SGPR，tile 后再写 0；放在 VGPR 里时 bf16 gemm1 有 2 个 spill） | gemm2：a8w4 16384 / 4096 tokens 484 → 455 / 160 → 150 us（−6%），a16w4 16384 631 → 605 us（−4%）；端到端 a8w4 −1.5% / −2.5%（4096 / 16384），a16w4 −0.3% / −1.1%，≤1024 持平。单路 token 的输出与 atomic 版逐位相同；随机路由下约 40% 的路由是单路 |

历次最好结果（每个 token 数取各配置最好值，us，a8w4 / a16w4）：

| 版本 | 16 | 256 | 1024 | 4096 | 16384 |
|---|---|---|---|---|---|
| v1（首个可用版本） | 76 / 76 | 149 / 165 | 195 / 261 | 479 / 696 | 1320 / 2456 |
| v2 | 70 / 72 | 146 / 164 | 180 / 249 | 473 / 688 | 1267 / 1850 |
| v3（sch3、b128 A、TR epilogue） | 70 / 73 | 143 / 159 | 181 / 244 | 451 / 659 | 1226 / 1850 |
| v4（auto、tile 调度、无 spill） | 63 / 74 | 144 / 161 | 183 / 244 | 426 / 606 | 1306 / 1767 |
| v5（+ single_store） | 64 / 73 | 145 / 163 | 188 / 240 | 408 / 603 | 1288 / 1726 |

v4 / v5 的 16384 tokens a8w4 在 `bench_e2e.py` 下偏高，交错 A/B 中 v4 为 1206 us、v5 为 1158 us。

## 调度实验细节

### 先看清楚：per-tile 时间线（`timeline.py`，`EP8_TL=1`）

`EP8_TL=1` 时 GEMM 在每个 tile 前后读 `s_memrealtime`（100 MHz）、`HW_ID`、`XCC_ID`，写到一块调试 buffer。4096 tokens、a8w4 gemm1、l128、原始 m-major 顺序：

- R128 tile（>64 行）约 90 us，R32 tile 约 43 us（小 tile 受 W 读取限制，不与行数成正比）；
- 每个 WG 平均工作 180 us，但 WG 完成时间 p10 137 / p50 188 / max 243 us，XCD 之间忙碌时间 162–197 us/CU：**负载不均约 25%**；
- `bx % 8 == XCC_ID` 全部成立，硬件确实按 WG 顺序轮流派发到 8 个 XCD。

### 试过但放弃的方案

| 方案 | 结果 | 原因 |
|---|---|---|
| 静态 persistent（grid = 304，WG 依次取 bx、bx+304…） | 与每 tile 一个 WG 持平（±1–3%） | 硬件派发本身就是动态的，死 WG 只有约 1 us |
| 每 XCD 一个 atomic 工作队列（persistent，按代价排序） | 4096 −6.5% / −15%，但 256 +16–18%、1024 +12% | 时间线上负载完全均衡（WG 完成 p10 222 / max 245 us），但重 tile 同时跑使功耗更高，单个 tile 变慢（R128 中位数 97 → 114 us）；小 batch 还多了冷 cache 下的依赖读取。改为「prep 排序 + 硬件派发」后在所有档位都不差于它 |
| 专家整块分到 XCD（按代价排序后蛇形分配） | 均匀路由 4096 −10% / −13% | 热点路由 4096 **慢 2 倍**：一个热点专家整个压在一个 XCD 上。改为按代价切连续区间后热点专家会跨 XCD |
| 块按 round robin 分到 XCD（不保持专家连续） | gemm1 4096 +4%，16384 +8% | 同一专家的块分散到不同 XCD，W 不能在 L2 中复用 |
| 段内 n-major 分组（GRP=2/4，相邻 WG 共享 W tile） | +0 ~ +12% | 没有收益，代码已撤销 |
| 代价模型 CB + 行数（而非 max(CB, 行数变体)） | 1024 tokens +10–13% | 1024 tokens 时 R32 和 R64 tile 一样慢（都受 W 读取限制），按行数切段反而不均；改为 max(64, 行数变体) |
| fp8 l128 ARB=256 | gemm1 256 VGPR + 2 spill；gemm2 LDS 超过 64 KB | 放弃 |

### 踩过的坑

- **运行时 `while` 里的 lane 级发散 `if`**（`if tx == 0: 取 ticket`）：LLVM 把整个循环体放在部分 exec mask 下执行，结果全错（`fmoe_bm64` 中同样的写法会 hang）。改成 `if wave == 0`，再按 lane 选择增量（lane 0 加 1，其余加 0；LLVM 的 atomic optimizer 会合并成一次 atomic）。
- **LDS 超过 64 KB 时 launch 报 `hipErrorIllegalState`**，而不是编译期报错（gemm2 fp8 l128 正好 64 KB，多加 16 B 就失败）。
- **FlyDSL 磁盘 cache 的 key** 只包含源文件 hash 和闭包里的标量；在 helper 里 trace 时读到的运行时值（例如调试 buffer 的地址）不在 key 里，新进程会拿到写死旧地址的二进制并访存出错。要把这种值放进 kernel 函数的闭包标量（`TLP`）。
- 用 `gpu.barrier()` 广播 LDS 里的值前，先 `s_waitcnt lgkmcnt(0)`。

## 文件

| 文件 | 用途 |
|---|---|
| `bench_e2e.py` | 端到端（prep + gemm1 + gemm2）冷 cache 计时 + 分 kernel 时间 + 与下限对比；`--cfg auto` 为自动选配置 |
| `bench_ab_e2e.py` | 端到端配置交错 A/B（5 轮中位数），变体写法 `"l128 sched=False g1.arb=256 bf16.g2.no=128"`，`--routing hot` 为热点路由 |
| `bench_ab.py` | 单个 gemm1 / gemm2 的交错 A/B（`sched=True` 用 prep 的调度） |
| `timeline.py` | `EP8_TL=1` 下的 per-tile 时间线：WG 完成时间分布、XCD 忙碌时间、按行数变体的 tile 时间 |
| `run_one.py` / `run_gemm.py` / `run_small.py` | 给 rocprofv3（pmc / ATT）用的单次运行脚本 |
| `exp_w_latency.py` | W 首次读取延迟实验 |
| `results/e2e_v{1..5}.{txt,json}` | 历次端到端结果 |

```bash
python doc-mimo/experiments/ep8_e2e/bench_e2e.py -t 1 16 256 1024 4096 16384 --adt fp8 bf16 --cfg auto
python doc-mimo/experiments/ep8_e2e/bench_ab_e2e.py -t 4096 --adt fp8 bf16 --var "l128 sched=False" "l128"
EP8_TL=1 python doc-mimo/experiments/ep8_e2e/timeline.py g1 -t 4096 --adt fp8 --sched 0 1
```

# Mimo v2.6 MoE（A8W4, gfx942）FlyDSL 实验记录

本目录汇总 Mimo v2.6 MoE（TP8）在 MI325X（gfx942，与 MI300X 同架构）上的 FlyDSL 实验：

- A8W4 gemm1、gemm2 单独抽出的 kernel 和测试；
- 2-kernel 端到端流程，以及单 kernel 融合 MoE；
- TP8 下 gemm2 + all-reduce 的卡间通讯实验，包括跨卡 atomic、跨卡 store/load 带宽，以及自研 two-shot all-reduce；
- EP8（专家并行，每卡 32 个专家、inter 2048）专用的 a8w4 / a16w4 kernel（第 8 节）。

这些改动有实测收益，但依赖测试文件里的私有 kernel、HIP IPC 和特定 shape，难以直接 upstream，所以集中存档在这里。

- 基线：aiter `812dbb29b`，FlyDSL 0.3.2，torch 2.9.1+rocm7.2.0，8× MI325X（304 CU/卡；rocm-smi 显示的型号，早期记录误写为 MI300X）
- 目标 shape：model_dim 4096、TP8 下每卡 inter_dim 256（完整 2048）、256 个专家、topk 8，重点关注 token < 1024

## 目录

```
doc-mimo/
  README.md
  kernels/                              # 均可直接 pytest / python / torchrun（同目录互相 import）
    test_a8w4_gemm1.py                  # gemm1（gate|up + SiLU）standalone kernel + 正确性/性能
    test_a8w4_gemm2.py                  # gemm2（down + 路由 atomic scatter）standalone kernel + 正确性/性能
    twoshot_allreduce.py               # TP8：gemm2 + RCCL / two-shot all-reduce（含 HIP IPC symmetric buffer）
    test_a8w4_fmoe.py                   # gemm1+gemm2 单 kernel 融合 MoE（对比 2-kernel 与 fused_moe）
    test_flydsl_moe_a16wfp4.py          # 加了 a8w4 2-kernel e2e 对比的 e2e 测试（完整文件）
    test_flydsl_moe_a16wfp4.e2e.patch   # 同上，相对基线的 diff
    ep8_common.py                       # EP8：shape、权重/路由生成、参考实现、下限、冷 cache 计时
    ep8_prep.py                         # EP8：本地专家排序 + x 量化 + GEMM tile 调度（1 次 launch）
    ep8_moe.py                          # EP8：gemm1 / gemm2（a8w4、a16w4）、配置表、ep8_moe 入口
    test_ep8_prep.py / test_ep8_moe.py  # EP8：prep 与 moe_sorting / 调度参考实现对比；gemm1 / gemm2 正确性
    ep8_small.py / test_ep8_small.py    # EP8：小 batch 单 kernel 融合实验（正确，但没有比 3-launch 快）
  comm/                                 # 卡间通讯实验（torchrun --nproc_per_node=8）
    peer_atomic_probe.py                # 跨卡 bf16x2 atomic：正确性 + 带宽
    peer_store_probe.py                 # 跨卡普通 store（push）/ load（pull）带宽
    twoshot_bench.py                    # two-shot all-reduce vs RCCL，200 个 epoch 校验 + 计时
    twoshot_isa_dump.py                 # 导出 two-shot kernel 的 ISA，用于查看 fence/waitcnt
  experiments/                          # 全部实验：每个实验一个目录（README 先结论后细节 + 脚本 + results/）
    README.md                           # 实验索引（按主题分组，每项一句结论）
    tools/                              # pyhip_shim、wait_gpu_idle.sh、build_log.py
    session_log.md                      # 早期按时间顺序的会话记录
```

kernels/ 下的文件与 op_tests/ 中同名文件是同一时刻的快照。

## 运行

```bash
# 单卡
pytest -q doc-mimo/kernels/test_a8w4_gemm1.py doc-mimo/kernels/test_a8w4_gemm2.py doc-mimo/kernels/test_a8w4_fmoe.py
python doc-mimo/kernels/test_a8w4_gemm1.py -t 128 512 2048 --tile 32,128 64,128,1
python doc-mimo/kernels/test_a8w4_gemm2.py -t 128 512 2048 --tile 64,128,1 32,128,1
python doc-mimo/kernels/test_a8w4_fmoe.py -t 128 512
AITER_CONFIG_FMOE=$PWD/mimo_v2.6_flash_a8w4_tuned_fmoe.csv \
  pytest -s doc-mimo/kernels/test_flydsl_moe_a16wfp4.py::test_flydsl_a16wfp4_silu_e2e

# EP8（单卡即一个 rank）
python doc-mimo/kernels/test_ep8_prep.py -t 1 16 1024 16384
python doc-mimo/kernels/test_ep8_moe.py g1 -t 16 4096 --adt fp8 bf16 --bm 128 --rowv 32,64,128 --nw 8 --sch 3 --tr 1
python doc-mimo/experiments/ep8_e2e/bench_e2e.py -t 1 16 256 1024 4096 16384 --adt fp8 bf16 --cfg auto

# 8 卡
torchrun --nproc_per_node=8 doc-mimo/kernels/twoshot_allreduce.py -t 128 512 2048 -r uniform --tile 32,128,1
torchrun --nproc_per_node=8 doc-mimo/comm/peer_atomic_probe.py
torchrun --nproc_per_node=8 doc-mimo/comm/peer_store_probe.py
torchrun --nproc_per_node=8 doc-mimo/comm/twoshot_bench.py 128 256 512 1024 2048
```

---

## 1. gemm1（`test_a8w4_gemm1.py`）

从生产 port（`moe_2stage_a16wmix/gemm1.py`，`a_dtype="fp8r"`）中只抽出 A8W4 实际用到的路径，去掉 a16w4 逻辑。

- A 是 fp8 FNUZ，每行一个 f32 scale；W 是 mxfp4（E2M1 加每 1×32 一个 E8M0 scale）。
- fp4 → fp8 用每个 32-K group 一张字节 LUT（`v_perm`）解码，另加一张 sign-mask LUT，与 port 逐位一致（测试断言 `bitexact vs port`）。

| 优化 | 说明 |
|---|---|
| 软件流水（`pipeline`，BM≤32 时默认开启） | A-LDS 双缓冲，预取下一个 tile 的 A 和 W，用 `sched_barrier(0)` 防止预取 load 被调度器挪到循环末尾 |
| sign-mask LUT 解码 | 去掉对 FNUZ -0 的逐片段修正 |
| `dyn_m` | moe_sorting 固定用 64 行 block；运行时探测 `sorted_ids[bx_m+32]`，在 32 行和 64 行两种计算路径中选一个 |
| `fast_dec=1/2`（fd1/fd2） | 权重准备时预先重排 nibble、存好每组 delta，解码 VALU −39%，结果逐位一致，详见第 7 节 |

结果：512 tokens 时约 83–87 us，port 为约 113 us。

- 预取加寄存器暂存在 BM≥64 时会使 VGPR 超过 168，prefill 变慢，所以只在小 M 时开启。
- dyn_m 在 2048 tokens 时会慢约 10%，因为两种路径一起编译后 VGPR 超过 168。

实验：`experiments/gemm1_config_sweep`、`gemm1_att_stats`、`isa_snapshots`。

## 2. gemm2（`test_a8w4_gemm2.py`）

| 优化 | 说明 |
|---|---|
| `epilog="lds"` | 在 MFMA 布局下先乘路由权重，结果以 bf16 暂存到 LDS（port 用 f32，这里减半），再以 128 B 连续的 `global_atomic_pk_add_bf16` 写回 |
| `dyn_rows` | 跳过 sorted block 中全是 padding 的 16 行子块，16/32/…/BM 行的变体都编译进同一个 kernel |
| `epilog="direct"`（保留，非默认） | 不经 LDS，lane 对之间 shuffle 后直接 atomic 写回；但每次只写 32 B 连续数据，BM≤32 时更慢 |
| `fast_dec=1/2`（fd1/fd2） | 与 gemm1 同一套快速解码，kernel VALU −29%，结果逐位一致，详见第 7 节 |

结果：128 tokens 时 37.5 us（port 83.5 us），512 tokens 时 51.6 us（port 97.8 us）。

实验：`experiments/gemm2_config_sweep`、`gemm2_epilog_ablation`、`isa_snapshots`。

## 3. 端到端与单 kernel 融合

**2-kernel 流程**（`test_flydsl_moe_a16wfp4.py` 中的 `a8w4_fused_moe`）：sort → quant → gemm1 → quant → gemm2。

| 512 tokens | 耗时 |
|---|---|
| 2-kernel（bm32） | 154.6 us |
| fused_moe（缺省 CSV） | 237.5 us（2-kernel 快 1.54 倍） |
| fused_moe（a8w4 CSV） | 246 us（2-kernel 快 1.58 倍） |

**单 kernel 融合**（`test_a8w4_fmoe.py`）：一个 WG 处理一个 m-block，共 16 个 wave。

- gemm1 做流水；SiLU 的结果暂存在 LDS，每行量化为 fp8（A2）。
- A2 常驻 VGPR；gemm2 按 slice 计算，写回暂存在 region1 和 region0 之间交替（双缓冲）。

| 场景 | fused（bm32/nw16/npw16） | 2-kernel |
|---|---|---|
| 128 | 139 us（bm16/nw8 时 133.5 us） | 135–140 us |
| 512 uniform | 154 us | 156 us |
| 512 hot | 217 us | 178 us |
| 2048 | 359 us | 324 us |

结论：融合只在 token 很少时能小幅领先。瓶颈在于：

- WG 总数只等于 m-block 数，约每个 CU 一个；
- 每个 m-block 都要读完整一份专家权重（约 1.5 MB）；
- m-block 数略多于 CU 数时会留下长尾。

试过但没有收益的方向：

- 4/8 wave 的 CTA，配合 `TILE_K1=128` 实现每 CU 两个 CTA（已撤销）；
- 用 `waves_per_eu` 强制提高占用率：寄存器溢出，慢约 2 倍。

实验：`experiments/fmoe_single_kernel`。

---

## 4. 卡间通讯（TP8 下 gemm2 之后的 all-reduce）

inter_dim=256 是 TP8 下每卡的切分，所以 gemm2 之后还要做 8 卡 all-reduce。实验：`experiments/comm_peer_atomic`、`comm_peer_store`、`twoshot_tp_allreduce`、`quickreduce_compare`。`twoshot_allreduce.py` 的设定：

- 各 rank 的路由相同，W2 和 stage-1 中间结果的分片各不相同；
- 计时取最慢的 rank；
- 每个候选在计时前后各校验一次。

### 4.1 RCCL 基线（`dist.all_reduce`，bf16）

| tokens（输出大小） | gemm2 | RCCL all-reduce | gemm2+RCCL |
|---|---|---|---|
| 128（1 MB） | 41.4 | 26.2 | 64.7 |
| 512（4 MB） | 53.1 | 53.5 | 105.7 |
| 2048（16 MB） | 125.7 | 148.6 | 253.3 |

单位 us。512 tokens 时，all-reduce 的耗时与 gemm2 本身相当。

### 4.2 方案一：gemm2 写回时直接跨卡 atomic（`comm/peer_atomic_probe.py`）

设想：每个 rank 事先分配与 gemm2 输出同大小的 symmetric buffer，用 HIP IPC 把 peer 的 buffer 映射进来；gemm2 写回时同时向所有 rank 的对应位置做 atomic，从而省掉 all-reduce。

实验：每个 rank 向自己和其余 7 个 rank 的 4 MB buffer 的每个元素做 bf16x2 atomic 加 (rank+1)。

| scope | 目标 rank 数 | 结果 | 每次 launch | 跨卡总带宽（每 rank） |
|---|---|---|---|---|
| agent | 1 | 正确 | 6.4 us | — |
| agent | 8 | 8 个 rank 全部正确（=144） | 279 us | 约 105 GB/s |
| system | 1 | 正确 | 21 us | — |
| system | 8 | 正确 | 2045 us | 约 14 GB/s |

- 跨卡 atomic 能正确累加，但这只在 kernel 边界加 host 同步的条件下验证过。
- 结论：**不可行**。atomic 是按路由行发的，不是按 token；每个 rank 发出的数据量 = topk ×（npes−1）× 输出大小。512 tokens 时约 224 MB，按 105 GB/s 约 2.1 ms。

### 4.3 跨卡普通 store / load 带宽（`comm/peer_store_probe.py`）

8 个 rank 同时互相发送，每线程 dwordx4。下表是每 rank 发往 7 个 peer 的总带宽。

**第一版**：WG 按目标卡顺序排列，同一时刻只用到一条链路，结果偏低且随数据量变差，说明的是一个坑：

| chunk / peer | push 默认 | push sc1 | pull |
|---|---|---|---|
| 512 KB | 188 GB/s | 178 GB/s | 80 GB/s |
| 4 MB | 80 GB/s | 70 GB/s | 52 GB/s |
| 16 MB | 61 GB/s | 61 GB/s | 45 GB/s |

**改为相邻 WG 轮流发往不同 peer 后**（存档的就是这一版）：

| chunk / peer | 本卡拷贝（对照） | push 默认 | push `sc1` / `sc0\|sc1` | pull |
|---|---|---|---|---|
| 512 KB | 824 GB/s | 229 GB/s（16 us） | 263–271 GB/s（13.6 us） | 87–118 GB/s |
| 1 MB | 917 | 236 | 295 | 90–93 |
| 4 MB | 1282 | 232 | **321（91.5 us）** | 110–112 |
| 16 MB | 1941 | **44**（明显变慢） | 305–311 | 94–119 |

- push 用 `sc1` 时每条链路约 45 GB/s；默认 cache 策略在大数据量时会崩。
- pull 只有 push 的约三分之一，所以应由发送方 push。
- 由此估算 512 tokens 时各种 all-reduce 方案的跨卡传输量与耗时：

| 方案 | 每 rank 发出 | 估算耗时 |
|---|---|---|
| 逐路由行 atomic | 224 MB | 约 2 ms |
| one-shot push | 28 MB | 约 92 us，比 RCCL 慢 |
| two-shot（reduce-scatter 加 all-gather） | 2 × 3.5 MB | 约 27 us 加同步，**可行** |

### 4.4 two-shot all-reduce（`kernels/twoshot_allreduce.py`：`SymmetricBuffer`、`compile_twoshot_allreduce`、`TwoShotAllreduce`）

**symmetric buffer**

- 每个 rank 在独立的 `torch.cuda.MemPool` 里分配内存。不能从共享的缓存分配器 segment 中切出一段导出，否则 IPC 映射会失效。
- 通过 `hipIpcGetMemHandle` 导出、`all_gather_object` 交换、`hipIpcOpenMemHandle` 打开，得到一张 int64 的 peer 地址表。
- 布局：`[inbox: npes×shard][gather: N][rs_flag: npes×chunks][ag_flag: npes×chunks]`。

**单个 kernel 内的三步**：数据切成 npes 个分片（rank s 负责分片 s），每个分片再分成 `chunks` 个 chunk，WG c 负责每个分片的第 c 个 chunk。

1. **reduce-scatter**：把分片 s 的 chunk c push 到 rank s 的 `inbox[rank]`，然后写 `rs_flag[rank][c] = epoch`。
2. 等 `rs_flag[*][c] ≥ epoch`。读 inbox 时用 `sc0|sc1`（绕过可能过期的本地 L2），按固定的 rank 顺序用 fp32 求和，再转成 bf16；因此每个 rank 的结果逐位相同。
3. **all-gather**：把求和后的 chunk push 到所有 rank 的 `gather[shard rank]`，写 `ag_flag`，然后等 `ag_flag[*][c]` 全部到齐。

返回值是本 rank gather 区域的视图，不需要额外拷贝。

- flag 存单调递增的 epoch，判断用 `>=`。
- inbox 和 gather 都只有一份缓冲也是安全的：一个 peer 要开始第 e+1 轮，必须先看到我方第 e 轮的 all-gather flag，这时我方已经读完 inbox；而我方 consumer 读第 e 轮结果，按 stream 顺序也在第 e+1 轮 launch 之前。

**优化过程**（512 tokens，4 MB）

| 版本 | 耗时 | 原因 |
|---|---|---|
| 初版 | 88.8 us | — |
| peer 地址表在开头一次读完 | 约 52 us | 地址表的 load 夹在远端 store 之间时，gfx9 上 load 和 store 共用同一个等待计数（vmcnt），编译器插 `vmcnt(0)`，8 条远端 store 被串行化（见 ISA） |
| 轻量同步（`light_sync=True`） | 40.4 us | 原来的 release fence 会让每个 wave 写回整个 L2（`buffer_wbl2 sc0 sc1`），acquire 轮询每次还要使 L2 失效（`buffer_inv`）。改为：数据 store 用 `sc0\|sc1` 写穿，`s_waitcnt vmcnt(0)` 后再写 monotonic 的 system flag 原子操作，结尾每个 WG 只做一次 acquire fence |
| 目标 peer 按 `(rank + WG 序号 + i)` 轮转 | **30.5 us** | 原来只按 rank 轮转，所有 WG 同一时刻写同一个 peer，挤在一条 xGMI 链路上 |

**最终结果**

独立 benchmark（`comm/twoshot_bench.py`，CUDA event 计时，200 个 epoch 的输入各不相同且逐次校验，bad=0）：

| tokens | 大小 | RCCL | two-shot（light） | two-shot（fence） |
|---|---|---|---|---|
| 128 | 1 MB | 40–45 us | **12.3 us** | 17.8 us |
| 256 | 2 MB | 44 us | **19.6 us** | 31.9 us |
| 512 | 4 MB | 67–69 us | **30.4–30.8 us**（多次运行一致） | 44–58 us |
| 1024 | 8 MB | 101 us | **60.8 us** | 105 us |
| 2048 | 16 MB | 157–263 us | **110 us** | 572 us |

TP 测试（`twoshot_allreduce.py`，profiler 统计 kernel 时间，tile_m=32 加 dyn_rows）：

| tokens | gemm2 | RCCL | **twoshot** | gemm2+RCCL | **gemm2+twoshot** |
|---|---|---|---|---|---|
| 128 | 41.5 | 25.1 | **12.1** | 63.5 | **50.5**（快 20%） |
| 512 | 53.6 | 53.3 | **31.0** | 104.9 | **79.6**（快 24%） |
| 2048 | 126.7 | 148.4 | **111.8** | 255.0 | **219.3**（快 14%） |

单位 us。精度：two-shot 与 fp32 精确求和相比 err=0（cos 约 1e-6），比 RCCL 的 bf16 累加更准。

### 4.5 与 QuickReduce（mk1-project/quickreduce）的对比

QuickReduce 的 QR-FP16 同样是 two-shot（reduce-scatter push 加 all-gather push，flag 用每次 launch 递增的颜色），原理与我们一致。但在它 README 的 8×MI300X 表中，4 MB 时 QR-FP16 为 46.8 us，RCCL 为 52.1 us，几乎没有优势；而我们的实现是 30.5 us，RCCL 为 53–67 us。

下面的差异来自源码（`csrc/core/allreduce.h` 中的 `AllReduceTwoshot` 和 `TwoshotFP16LineCodec`）以及本机编译出的 8-rank FP16 kernel 的反汇编（`experiments/quickreduce_compare/results/quickreduce_twoshot_fp16_w8.s`）：

| 方面 | QuickReduce QR-FP16 | 本实现 | 影响 |
|---|---|---|---|
| 等待对端数据 | 按 rank 0..7 逐个等：thread 0 自旋读 flag → `s_barrier` → 读该 rank 的数据 → `s_waitcnt` → 加法，然后才轮到下一个 rank | 8 个 lane 同时轮询 8 个 flag，一次 barrier 后一次性发出 8 个 inbox load | QR 每个 tile 有 2 个阶段 × 8 次串行的访存往返加 barrier，延迟链长度与 world size 成正比。这正是它在 TP2/TP4 上优势大（2–4 次往返）、到 TP8 优势消失的主要原因 |
| 远端 store 的发射 | 发送顺序固定为 rank 0..7，所有 rank、所有 WG 都一样；地址表 `buffer_list[r]` 在 store 之间读取，反汇编里第 1 条远端 store 后紧跟 `global_load_dwordx2` 加 `s_waitcnt vmcnt(0)`，要等那条远端 store 完成 | 地址表在开头一次读完；目标按 (rank + WG + i) 轮转 | QR 每个阶段多一次远端写往返；同时所有 rank 先写 rank 0，造成 incast。我们实测这两项各值 10–20 us（88.8 → 52 → 30.5 中的两步） |
| 发布 flag | 线程 0..7 执行 `__atomic_store_n(RELEASE)`，即每个 WG、每个阶段一次 `buffer_wbl2 sc0 sc1`（写回整个 L2），且发布前还要 load 一次地址表并 `vmcnt(0)` | 数据用 `sc0\|sc1` 写穿，`s_waitcnt vmcnt(0)` 后写 monotonic flag，没有 `wbl2` | 我们实测 fence 版本比 light 版本慢 1.3–5 倍（512 KB–16 MB） |
| 输出 | gather 的结果读回寄存器，再写到新分配的输出张量 B | 直接返回 symmetric buffer 中 gather 区域的视图 | QR 多一次 N 字节的读加 N 字节的写，以及一次依赖等待（4 MB 时约 2–3 us） |
| 小消息的并行度 | 每个 WG 处理 32 KB tile，`num_blocks = N/32KB`：1 MB 只有 32 个 WG，4 MB 只有 128 个 WG | 每个 WG 线程数 64–256，WG 数约 128–512 | QR 在 4 MB 以下只用到少量 CU，串行延迟链无法摊薄 |
| 远端访存指令 | 指针来自内存表，编译成 `flat_store/flat_load ... nt`（同时占用 vmcnt 和 lgkmcnt）；通讯 buffer 为 `hipDeviceMallocUncached` | `buffer_store/load`，地址来自 SGPR 中的资源描述符，cache 策略为 `sc1` / `sc0\|sc1` | 我们的 store 带宽探针中 `nt` 比 `sc1` 低约 7%（4 MB）到 15%（16 MB） |
| 累加精度 | fp16 `v_pk_add_f16` 逐 rank 累加 | fp32 累加后转一次 bf16，所有 rank 逐位相同 | 与性能无关，但我们的精度更好 |

结论：两者的数据流量相同（每 rank 2 × 7/8 × N），差别全在延迟和同步上。

- QR-FP16 每个 tile 是"8 个 rank 依次 flag 往返加数据往返"的长串行链，加上每阶段一次 L2 写回、一次被 `vmcnt(0)` 卡住的远端 store、一次输出拷贝。在 TP8 下这些固定开销与传输时间相当，所以只略快于 RCCL。
- 它的压缩 codec（Q6/Q4）减少的是字节数，只在 8 MB 以上才明显有用。
- 我们的实现把等待并行化，去掉了 `wbl2` 和多余的 `vmcnt(0)`，并让 7 条链路同时工作，所以 4 MB 时接近带宽下限（2 × 3.5 MB / 约 300 GB/s ≈ 23 us，再加两次同步）。

注意事项：

- QR README 的数据是 ROCm 6.2、RCCL 2.20.5、MI300X；我们是 ROCm 7.2、RCCL 2.27.7、MI325X，绝对值不可直接比较。
- 同机对比脚本 `comm/qr_compare.py`（RCCL / QR-FP16 / 本实现，fp16 和 bf16 同字节数）已写好；分析时 8 张卡都被其他进程占满（约 272 GB 显存、100% 利用率），尚未跑出结果。
- 运行方式：`cd /tmp && git clone https://github.com/mk1-project/quickreduce qr_src && (cd qr_src/quickreduce && python setup.py build_ext --inplace)`，然后 `PYTHONPATH=/tmp/qr_src/quickreduce torchrun --nproc_per_node=8 doc-mimo/comm/qr_compare.py`。

---

## 5. 经验与坑

- **ISA dump**：`FLYDSL_DUMP_IR=1 FLYDSL_DEBUG_DUMP_ASM=1 FLYDSL_DUMP_DIR=/tmp/fdX`，看 `*/21_final_isa.s`，包括 `.vgpr_count`、`.vgpr_spill_count`、`.group_segment_fixed_size`。kernel 命中磁盘 JIT cache 时不会重新 dump，需要另给一个空的 `FLYDSL_RUNTIME_CACHE_DIR`。
- **测量噪声**：刚 JIT 完的第一次计时偏慢，计时前先调用一次预热。单次测量有 ±3–5% 的抖动，要多轮交错取最小值。TP 测试取最慢 rank，偶尔会把单个 rank 的异常值（如 138 us）带进表里。
- **嵌套 `@flyc.jit` 不会因 Python int 参数不同而重新特化**：尺寸要从列表长度推导。
- **运行时控制流**：运行时的 `if` 和 `while` 必须写在 `@flyc.jit` 或 `@flyc.kernel` 函数体里（会做 AST 改写）。`range()` 只有在 jit 函数内才会生成 `scf.for`。
- **跨卡访问**：
  - 地址表一次读完，避免 `vmcnt(0)` 把远端 store 串行化；
  - 发往不同 peer 的流量要在同一时刻铺开到所有链路；
  - 远端写用 push 加 `sc1`，不用 pull；
  - 跨卡 atomic 能工作但很慢（约 105 GB/s）。
- **内存序**：
  - release fence 在 gfx942 上会生成 `buffer_wbl2 sc0 sc1`（写回整个 L2），每个 wave 一次，代价很高；
  - 数据写穿（`sc0|sc1`）加 `s_waitcnt vmcnt(0)` 再写 flag 就足够；
  - 读远端写进来的数据用 `sc0|sc1` 绕过本地 L2。
- **flag 协议**：用单调递增的 epoch 加 `>=` 判断，可以容忍 peer 领先一轮。等待只发生在同序号 WG 之间，grid 不超过可同时驻留的 WG 数，所以不会死锁。
- **IPC 内存**：放在独立的 MemPool 中，`close()` 前后都要做 barrier。

## 6. 后续方向

- 把 two-shot 并进 gemm2 尾部：gemm2 本地 atomic 归约完成后做一次全 grid 同步，接着直接做 reduce-scatter。这样能省一次 launch，并让通讯与最后几个 tile 重叠，预计 512 tokens 时还能省 5–10 us。
- two-shot 在 1 MB 以下主要受同步延迟限制，可以试一下 one-shot 的混合方案，或者 LL（flag 和数据打包在一起）协议。
- 把 gemm2 的输出 buffer 直接放进 symmetric buffer，让 reduce-scatter 直接读 gemm2 的输出，省掉 moe_buf 这份中间数据。

---

## 7. fp4 解码优化 fd1/fd2：如何发现，如何实现

**起点：** `python doc-mimo/kernels/test_a8w4_gemm1.py -s 4096,512,256,8 -t 512 -r uniform --tile 32,128,0`（inter_dim 512、512 tokens）。gemm1 只有约 2.7 TB/s，但这个 shape 预期是 memory-bound。

本节用到的 9 个实验（`gemm1_power_ceiling` … `fast_decode`）列在 [experiments/README.md](experiments/README.md) 第 6 组，每个目录都有 README（先写结论，再写细节）、脚本和 `results/`。

### 7.1 先确认真实上限

| 测量 | 结果 | 结论 |
|---|---|---|
| 持续运行时用 `amd-smi metric` 采样（`gemm1_power_ceiling/gemm1_clock_probe.py`） | 功耗一直在 750 W 上限，gfx 时钟只有约 1.05 GHz（最高 2.1 GHz） | 整卡受功耗墙限制 |
| 同样功耗下纯读 576 MB（`gemm1_power_ceiling/hbm_ceiling.py`） | `torch.sum` 3.62 TB/s | 在这台机器上，memory-bound 的现实上限约 3.6 TB/s，不是 5–6 TB/s |
| 按 gemm1 的读法纯读（`gemm1_read_pattern/`） | 3.2–3.4 TB/s | gemm1 当时约达到其访存模式上限的 80% |

另外发现，ATT 每个 dispatch 的 `realtime.json` 换算出的时钟不可靠：同一 kernel 两次 trace 的 cycle 数可以相差 2 倍，比较时只能用 cycle 数。

### 7.2 逐个排除的假设

| 假设 | 实验 | 结果 |
|---|---|---|
| 访存模式：每个 K-tile 读 16 段 2 KB、段间跨 32 KB，DRAM 效率低 | `gemm1_read_pattern/`：只改变连续段长度的纯读；`gemm1_tile_layout/` | 段长 2 KB 时 3.24–3.43 TB/s，≥8 KB 时 3.8–3.9 TB/s。据此实现了 `w_layout="tile"`（每个 (expert, n-block, K-tile) 一整块 32 KB 连续）：结果逐位一致，**但 kernel 时间没变** |
| CU 数和任务分配：1024 个 WG 分到 304 个 CU 上不均匀 | `cu_scaling_bw/`：纯读时 CU 数与带宽的关系；`gemm1_cumask/`：用 stream CU mask 限制为每 XCD 32 个 CU、每个 CU 正好 4 个 WG | 纯读每 XCD 只要 10–16 个 CU 就能跑满（每 XCD 上限约 0.88 TB/s）；gemm1 限到每 XCD 32 个 CU 后**反而变慢**（192 → 210 us），说明它需要所有 CU 同时发出读请求 |
| tail：最后一轮只剩少数 WG，并发读请求不够 | `gemm1_wave_rounds/`：改变专家数，让 grid 正好是 1/1.5/2/…/4 轮 | 1024 WG（1.68 轮）为 2.97 TB/s，其余约 3.15 TB/s，**tail 只占约 5%** |
| W 的 cache 策略 | `gemm1_cache_modifier/`：`b_cache_mod` 0/1/2 | nt（=2）从 212 降到 197 us，已改为默认值 |

结论：即使所有 CU 一直排满，稳态带宽也只有约 3.15 TB/s；瓶颈不在访存布局、CU 数和 tail。

### 7.3 关键证据：ATT 显示发射口已满

在 E=304 时抓 ATT（1216 个 WG，正好 2 轮，没有 tail 干扰），用 `gemm1_att_bottleneck/` 里的脚本分析：

- **SIMD 发射口已占满：** 每 SIMD 2 个 wave 时，VALU 发射占用中位数 81%（p90 91%），加上 MFMA 约 9%，发射口约 90% 被占。相邻 VALU 的间隔 79% 是 4 cycle，即背靠背发射。
- **访存等待很少：** `s_waitcnt vmcnt` 只占 wave 时间的 8.6%。
- **加 wave 几乎不加速：** 每个 K 迭代，1 个 wave 时 3388 cycle，2 个 wave 时 3600 cycle。

所以这时 gemm1 是 **VALU 发射受限**：提高 occupancy、加深预取都不会有用。

K 循环每次迭代（每个 wave）有 529 条 VALU，MFMA 只有 64 条：

| 来源 | 条数 | 占比 |
|---|---|---|
| fp4→fp8 解码：每个 dword 约 13 条，其中 6 条 `v_perm` | 约 416 | 79% |
| ├ 其中把 even/odd 两组字节拼回 K 顺序：每个 dword 2 条 `v_perm` | 64 | 12% |
| ├ 其中符号处理：每个 dword 2 条 `v_perm`、2 条 `v_and_or` | 128 | 24% |
| 每个 128-K 组重建查找表：`v_sub`/`v_min`/`v_cndmask`，以及 8 条慢速的 `v_mul_lo_u32` | 约 90 | 17% |

### 7.4 优化思路：权重是静态的，把能做的提前到权重准备时做

| 级别 | 权重准备（每份权重做一次） | kernel 里省掉的操作 |
|---|---|---|
| **fd1** | `prep_w1_fast_decode`：每个 dword 内把 byte j 改存 (k_j, k_{j+4})；nibble 0x8（-0）改成 0 | 拼回 K 顺序的 2 条 `v_perm`。在 flush_tiny 下，非零数值不会被查成 0，于是符号可以直接用位运算加上：`even = ((raw<<4) & smask) \| perm(...)`、`odd = (raw & smask) \| perm(...)`，省掉 2 条符号 `v_perm` 和符号表的构建 |
| **fd2** | 再加 `prep_w1_predelta`：scale 字节改存 `min(通道最大值 − 组内 scale, 11)×8`；会被 flush 成 0 的组，直接在 W 里写 0 | 查找表只剩：1 条 `v_perm` 把 delta 广播到 4 个字节，再做 `sub`/`and`/`sub`。不再需要 `v_min`、`v_cndmask` 和慢速的 `v_mul_lo` |

实现要点：

- **直接在标准 preshuffle 布局上改写**，不用先 unshuffle：
  - W 字节按 `(N/16, K/128, klane 4, nlane 16, 16 B)` 排列，每 16 B 是第 `kg = k128*4 + klane` 个 32-K 组、第 `n16*16 + nlane` 列；
  - scale 字节按 `(N/32, K/256, klane, nlane, kpack 2, npack 2)` 排列。
  - 准备函数会断言由此换算出的每通道最大值与 `channel_exponents` 一致，用来校验映射。
- **gemm2（`prep_w2_fast`）：** gemm2 原本在 kernel 内部从 scale 求出每通道最大值；fd2 改写 scale 后求不出来了，所以把这些最大值（int32）接在 scale 数据后面，kernel 从 `arg_w_scale + WS_BYTES` 读取，不用改 kernel 参数表。
- **生产路径：** `test_flydsl_moe_a16wfp4.a8w4_prepare_weights(..., fast_dec=2)`（默认）同时处理 W1 和 W2，`a8w4_fused_moe` 根据 `w1_fast_dec` / `w2_fast_dec` 选择解码方式。处理过的权重只能给这两个 kernel 用，port、CK 等路径不能读。
- **正确性：**
  - gemm1：fd1、fd2 与原解码、与 port 都逐位一致（pytest 断言）；
  - gemm2：用原子加累加，topk>1 时输出本身不完全可复现，所以用 topk=1（每个输出元素只被加一次）验证逐位一致；
  - 端到端：fd0 与 fd0 连跑两次 cos 差就有约 3e-6，所以用 cos < 1e-4 断言。

### 7.5 效果

ISA（`fast_decode/isa_dump.sh`）：

| | 原版 | fd1 | fd2 |
|---|---|---|---|
| gemm1 K 循环 VALU（每迭代每个 wave） | 531 | 379 | **325（−39%）** |
| gemm2 整个 kernel 的 VALU / VGPR | 719 / 80 | 568 / 80 | **509 / 74** |

时间（单位 us；gemm1/gemm2 为 inter_dim 512、bm32；端到端为 test_flydsl_moe_a16wfp4 的 bm32）：

| | 原版 | fd2 |
|---|---|---|
| gemm1，512 tokens | 191.6–198.8 | 169.4–179.0 |
| gemm2，512 tokens（bm64，dyn_rows） | 108.6 | 96.7 |
| gemm2，2048 tokens（bm64） | 222.0 | 192.7 |
| 端到端，128 / 512 / 2048 tokens | 170.6 / 193.9 / 369.5 | **153.2 / 175.8 / 340.7** |

端到端快了 8–10%，比现有 `fused_moe` 快 1.37–1.74 倍。

**为什么 VALU 少了 39%，时间只少约 10%：** fd2 跑起来功耗仍是 750 W，时钟从约 1.09 降到约 1.04 GHz。计算变快后，单位时间搬运的数据更多，访存功耗随之上升，瓶颈从「VALU 发射」变成了「功耗墙」。此时 gemm1 约 3.3 TB/s，已是同样功耗下纯读（3.6 TB/s）的约 90%。

### 7.6 经验

1. **先在实际条件下测上限，再谈 kernel 达到多少比例。** 拿峰值规格比，会误判成「带宽只用了一半」。
2. **每个假设单独设计实验验证。** 访存布局、CU 数、tail 这三个看似合理的方向都被数据否定了；tile 布局虽然做出来了，但没有收益。
3. **判断计算还是访存瓶颈，最有用的指标是「每 SIMD 在跑 N 个 wave 时的 VALU 发射占用」和「增加 wave 后单次迭代时间变不变」**。只看指令条数会误判：`moe-new-tp.md` 第 11 节在 TP8 shape 上删掉约 7% VALU 没有收益；这次在 inter_dim 512 的 shape 上发射口已饱和，删掉 39% 就有收益。
4. **权重是静态的，凡是只依赖权重的计算都可以挪到准备阶段**，包括字节顺序、符号规范化、scale 的相对值和 flush 判断，只要保证结果逐位一致。

---

## 8. EP8（专家并行）：a8w4 / a16w4 专用 kernel

**目标：** EP8 下每卡 32 个本地专家（共 256 个，topk 8）、H 4096、I 2048。小 batch 达到 memory-bound，大 batch 达到 compute-bound，中间的 batch 不慢于两者之和。激活有两种：a8w4（x 量化成 fp8 + 行 scale）和 a16w4（x 直接用 bf16）。权重都是 mxfp4。

代码在 `kernels/ep8_prep.py`、`kernels/ep8_moe.py`，实验在 `experiments/ep8_{roofline,baseline,e2e}/`。

### 8.1 结论

冷 cache，单位 us（`experiments/ep8_e2e/results/e2e_v5.txt`，`ep8_moe(..., cfg=None)` 按 token 数自动选配置）：

| tokens | a8w4 | a8w4 TFLOPS | a16w4 | mem 下限 | 计算下限 a8w4 / a16w4 | a8w4：x mem / x 之和 | a16w4：x mem / x 之和 | TP 调好的 a8w4 kernel |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 42 | 2.4 | 42 | 7.4 | 0.1 / 0.2 | 5.70 / 5.63 | 5.64 / 5.51 | 57 |
| 16 | 64 | 10 | 73 | 40.9 | 0.6 / 1.1 | 1.57 / 1.54 | 1.79 / 1.74 | 149 |
| 64 | 126 | 26 | 146 | 108 | 3.0 / 5.3 | 1.17 / 1.13 | 1.35 / 1.29 | 165 |
| 256 | 145 | 85 | 163 | 120 | 11.4 / 20.0 | 1.21 / 1.10 | 1.36 / 1.16 | 174 |
| 1024 | 188 | 264 | 240 | 123 | 46 / 81 | 1.53 / 1.11 | 1.95 / 1.18 | 247 |
| 4096 | 408 | 514 | 603 | 136 | 195 / 342 | 3.00 / 1.23 | 4.43 / 1.26 | 668 |
| 16384 | 1288 | 645 | 1726 | 187 | 772 / 1353 | 6.88 / 1.34 | 9.22 / 1.12 | 2275 |

- a8w4 TFLOPS 只计有效计算：本卡 (token, 专家) 对的行数 rows × 6 × I × H（gemm1 2·rows·2I·H + gemm2 2·rows·I·H），除以端到端时间（含 prep）。对照：hipBLASLt fp8 dense GEMM 在同形状上为 1117（gemm1）/ 1002（gemm2）TFLOPS。交错 A/B 下 16384 tokens 为 1158 us，即 717 TFLOPS。
- mem 下限 = 活跃专家权重 + 激活读写，按 3.6 TB/s；计算下限 = hipBLASLt 同形状 dense GEMM 的实测吞吐。两者都是 750 W 功耗墙下的实测值（`experiments/ep8_roofline/`）。
- 比 TP 调好的 2-kernel a8w4 直接跑 EP8 shape 快 1.2–2.3 倍（`experiments/ep8_baseline/`）。交错 A/B 下的数字比这张表低 5–10%（例如 16384 tokens a8w4 1158 us）。
- **还没达到的目标：**
  - **≤16 tokens 不是 memory-bound**（1.5–1.8 倍）：prep 约 8–10 us 加 3 次 launch 是固定开销；只有 1–11 个专家活跃时，能同时读 W 的 WG 不够多。1 token 的 W 只够 7.4 us，固定开销占了大头。
  - **1024–8192 tokens 比 mem + 计算之和慢 11–37%**：tile 数只有 CU 数的 1.7–3 倍，轮次量化明显；a8w4 gemm1 的输出按 (行, 128 列) 量化，NI 不能小于 128，tile 没法再切细。
  - **16384 tokens a8w4 是计算下限的 1.5–1.7 倍**（a16w4 1.3 倍）：MFMA 利用率约 45–60%；主要差在 gemm2（见 8.6）。

### 8.2 流程：3 次 launch

1. **`ep_prep`**：本地专家的路由排序（≤256×EPT 个条目时单 WG 只用 LDS；否则多 WG，每 WG 每专家一次全局 atomic 预留区间 + grid barrier），填充行，每个 block 的专家号；a8w4 时把有本地专家的 token 行量化成 fp8 + 行 scale（与 `quantize_rows` 逐位一致）；WG 0 最后写出 GEMM 的 tile 调度。替代 `moe_sorting` + `quantize_rows`，快 1.3–2 倍。
2. **`ep_gemm1`**：gate|up GEMM + SiLU；a8w4 的输出按 (行, 128 列) 量化成 fp8 + scale，a16w4 输出 bf16；顺带把 gemm2 的输出清零。
3. **`ep_gemm2`**：down GEMM；a8w4 时 A 的分组 scale 在 K 循环里按相邻组的比值重标定（一个累加器）；乘路由权重后用 bf16x2 atomic 加到 token 行，本卡只有 1 路的 token 直接 store（single_store）。

### 8.3 kernel 结构要点

- **权重**：mxfp4 预处理成 fd2 形式（第 7 节），fp4 → fp8 用字节查找表；两种激活共用一份权重，a16w4 再经 fp8 → f32 → bf16。
- **WG = 一个 (m-block, n-block) tile**，NW 个 wave 按列切分（解码出的 W 片段供 R/16 个 MFMA 使用，WG 内不重复解码）。W 从全局直接读进 VGPR（MFMA 操作数布局），提前 PF 个 K-tile；A 经 LDS 双缓冲（XOR swizzle），`ds_read_b128` 一次读两步。`sch=3`：每个 K-tile 最后一步的 MFMA 推迟到下一个 K-tile 的 barrier 之后，填补 barrier 等待。
- **行数变体（ROWV）**：每个 WG 按本 block 的有效行数选最小的编译变体（32 / 64 / 128 行），避免为填充行做 MFMA。
- **TR epilogue**（gemm1）：W 作为 MFMA 的 A 操作数，lane 对应行、每 lane 4 个连续列，SiLU 和 fp8 量化都在寄存器里完成。
- **`_opaque_tx`**：每个 tile body 前把 `tx` 经一条带副作用的 `v_mov` 复制一份，LLVM 就不会把按 lane 算的地址提到 kernel 开头长期占用寄存器。所有配置都没有 spill（之前 a16w4 有 15–22 个，加循环后有 73–83 个）。
- **tile 调度**（`sched`，m64 / l128 用）：prep 把 m-block 按专家顺序、按估计代价（max(64, 行数变体)）切成 8 段连续区间，每个 XCD 一段（热点专家会跨 XCD），段内重块在前；GEMM 的 WG bx 处理第 bx % 8 段的第 bx // 8 个 tile，由硬件按 WG 顺序动态派发，相当于每个 XCD 内做 LPT。
- **single_store**（参考 pyhip，见 8.6）：prep 用一次 wave ballot 数出每个 token 的本地路数，写出 `route_counts`，并在只有 1 路的 token 的 sorted id 上置符号位；gemm2 对这些行用普通 store 代替 atomic，gemm1 只清零路数 ≠ 1 的行（路数在 WG 开头读进 SGPR，tile 结束后再写 0，不占 VGPR）。随机路由下约 40% 的路由和 40% 的输出行受益，单路 token 的结果与 atomic 版逐位相同。
- **配置**（`CFGS`，`AUTO`）：≤8 tokens `t16`（窄 n-tile），≤480 `s16`，≤960 `s32`，≤2176 `m64`，其余 `l128`。

### 8.4 本轮的优化过程（细节见 `experiments/ep8_e2e/README.md`）

| 步骤 | 发现 / 做法 | 效果 |
|---|---|---|
| ATT + per-tile 时间线 | 4096 tokens 时 R128 tile 约 90 us、R32 约 43 us；WG 完成时间 p10 137 / max 243 us，XCD 之间差 20%；每 tile 一个 WG 时死 WG 只有约 1 us | 确认问题是负载不均，而不是死 WG |
| per-XCD atomic 工作队列（persistent） | 负载完全均衡，但重 tile 同时跑时功耗更高、单 tile 变慢；小 batch 多了冷 cache 依赖读取 | 4096 快 6–15%，≤1024 慢 12–18%，放弃 |
| 加循环后 spill 暴增 → `_opaque_tx` | LLVM 把按 lane 算的地址提到循环外 | 所有配置 0 spill；a16w4 16384 tokens 1850 → ~1720 us |
| prep 排序 + 硬件派发 | 先按专家整块蛇形分 XCD（热点路由慢 2 倍），再改为按代价切连续区间 | 4096 tokens −9% / −14%，热点路由不退化 |
| t16 配置 + 按 token 数选配置 | ≤8 tokens 用窄 n-tile | a16w4 −20–26% |
| single_store（pyhip） | 单路 token 的行 store、不清零 | gemm2 −4 ~ −6%；端到端 a8w4 4096 / 16384 tokens −1.5% / −2.5%，a16w4 −0.3% / −1.1% |

### 8.5 经验与坑

- **先测 per-tile 时间线再优化调度。** `EP8_TL=1` 时 kernel 记录每个 tile 的 `s_memrealtime`、`HW_ID`、`XCC_ID`；`bx % 8 == XCC_ID` 实测成立。
- **负载均衡不一定变快：** 功耗墙下，把重 tile 集中到一起跑会降低时钟，均衡省下的时间被抵消一部分。
- **改变循环结构后一定要看 VGPR / spill**（`FLYDSL_DUMP_IR=1 FLYDSL_DEBUG_DUMP_ASM=1`）。
- **运行时 `while` 里不要写 lane 级发散的 `if`**（例如 `if tx == 0` 取 ticket）：LLVM 会让整个循环体在部分 exec mask 下执行，结果错误或 hang。改成 wave 级分支加按 lane 选择的增量。
- **LDS 超过 64 KB 是 launch 时报 `hipErrorIllegalState`**，不是编译错误。
- **FlyDSL 磁盘 cache 的 key** 只包含源文件 hash 和闭包里的标量；trace 时在 helper 里读到的运行时值（如调试 buffer 地址）不在 key 里，要放进 kernel 的闭包标量。
- **代价模型要与实际 tile 时间一致：** 小 tile 受 W 读取限制，R32 与 R64 一样慢；按「固定开销 + 行数」估计会切出不均的区间。

### 8.6 与 pyhip a8w8 blockscale MoE 的对照

[pyhip `moe_a8w8_blockscale_gfx942.md`](https://github.com/tingqli/pyhip/blob/luwei/942-fp8-blockwise/docs/moe_a8w8_blockscale_gfx942.md) 是同一个 MiMo-V2.6-Flash EP8 shape 的 FlyDSL 两段式 MoE，但权重是 FP8（128×128 block scale），不需要 fp4 解码。它第 3 节列的优化逐条对照：

| pyhip 的优化 | 在本实现中 |
|---|---|
| A2 按排序后的行连续读（sorted_a2） | 已有：gemm1 按 sorted 行写 A2，gemm2 连续读 |
| GateUp epilogue 里做 SiLU·up 的 (行, 128) FP8 量化 | 已有（a8w4 的 gemm1） |
| Down 先经 LDS 转置，一条 atomic 写 2 行 × 128 B | 已有（gemm2 epilogue 经 LDS 暂存，32 lane × bf16x2 一行） |
| BF16 输出 round-to-nearest-even | 已有 |
| single_store（单路 token 直接 store + 只清零路数 ≠ 1 的行） | **本轮实现**：gemm2 −4 ~ −6%（pyhip 在真实 EP8 路由下 Down −6%），端到端 a8w4 −1.5 ~ −2.5% |
| pair_blocks（GateUp 任务顺序） | 类似的是 prep 的 tile 调度（同专家的块在同一 XCD、重块在前） |
| 没采用：常驻 GateUp、清零放另一个 stream | 一致：我们的 persistent / atomic 工作队列也没有收益（750 W 功耗墙） |
| GateUp / Down 用 BM256×BN256、8 wave 2x4 / 4x2 布局、A 和 W 都过 LDS，mainloop MFMA 效率约 93% | **未做**，见下 |

按每个 kernel 的有效 TFLOPS（16K tokens，pyhip 是 `ep_uniform` 路由，每个 token 恰好 1 路）：

| | pyhip（FP8 W） | 本实现 a8w4（fp4 W） |
|---|---:|---:|
| gemm1 / GateUp | 878（626 us） | 770–815（680–719 us） |
| gemm2 / Down | 705（atomic，390 us）/ 833（全 store，330 us） | 550–608（455–503 us） |

- gemm1 只差 7–12%：gemm2 差 15–25%，是大 batch 下主要的差距。
- pyhip 的 Down 靠 256×256 的大 tile 把 prolog / epilog（K 只有 2048）摊薄，并把 A、W 都放进 LDS。搬到 fp4 W 上有三个障碍：
  - W 要先解码：多个 wave 共用一个 W tile（二维 wave 布局）时，要么各自重复解码，要么先解码成 fp8 写进 LDS；
  - LDS：BM=256 时 A 的双缓冲（K-tile 128）就要 64 KB，还放不下 a8w4 的分组 scale 比值表；
  - VGPR：256 行的累加器要翻倍（128 个），再加上 W 预取和解码临时寄存器，超过每 CU 跑 8 wave 时的 256。
  所以这一项需要重写 gemm2，而不是调参；若能达到 pyhip Down 的水平（16K 下 705 TF），16384 tokens 的 gemm2 约可从 ~460 降到 ~390 us，端到端再快约 6%。

### 8.7 后续方向

- 小 batch：把 prep 合进 gemm1（gemm1 自己读路由），或与上一层重叠；只有 1–8 个专家活跃时用 split-K，让更多 CU 读 W。
- 中等 batch：a8w4 gemm1 的量化组跨 WG（NI=64 时相邻 WG 交换行 amax），把 tile 切细，减少轮次量化。
- 大 batch：按 8.6 重写 gemm2（更大的 M tile，解码后的 W 经 LDS 在 wave 间共用）；提高 gemm1 的 MFMA 利用率。

---

## 实验目录

所有实验（脚本、原始结果、每个实验的结论与细节）都按实验分目录放在 `experiments/` 下，索引见 [experiments/README.md](experiments/README.md)。

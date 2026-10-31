# experiments：实验目录索引

每个实验一个目录，目录名就是实验名。目录里有：

- `README.md`：先写结论，再写实验细节；
- 实验脚本；
- `results/`：原始输出和数据。

除特别注明外，脚本都在**仓库根目录**下运行。如果 aiter 导入 `pyhip.contrib` 失败，在命令前加 `PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim`。机器是共享的，测量前先用 `doc-mimo/experiments/tools/wait_gpu_idle.sh` 等 GPU 空闲。

目标 shape：model_dim 4096、256 个专家、topk 8。TP8 下每卡 inter_dim 为 256；fd1/fd2 那组实验主要用 inter_dim 512。硬件为 8× MI325X（gfx942）。

## 1. standalone gemm1 / gemm2（TP8 shape）

| 实验 | 结论 |
|---|---|
| [gemm1_config_sweep](gemm1_config_sweep/) | 只抽出 A8W4 用到的路径，加流水、sign-mask LUT、`dyn_m`：512 tokens 约 83–87 us（port 约 113），与 port 逐位一致 |
| [gemm1_att_stats](gemm1_att_stats/) | 早期 gemm1 的 ATT：访存等待和访存发射约占一半，VALU 约 34% |
| [gemm2_config_sweep](gemm2_config_sweep/) | `epilog="lds"` + `dyn_rows`：128 / 512 tokens 为 37.5 / 51.6 us（port 83.5 / 97.8） |
| [gemm2_epilog_ablation](gemm2_epilog_ablation/) | 写回改成 atomic / store / 不写，耗时都不变：gemm2 不受写回限制 |
| [isa_snapshots](isa_snapshots/) | 早期各 kernel 变体的 ISA 和 VGPR / spill / LDS 汇总 |

## 2. 单 kernel 融合 MoE

| 实验 | 结论 |
|---|---|
| [fmoe_single_kernel](fmoe_single_kernel/) | 融合只在 token 很少时略占优；WG 数等于 m-block 数，有长尾；强行提高 occupancy 会 spill，慢约 2 倍 |

## 3. 卡间通讯（TP8 下 gemm2 之后的 all-reduce）

| 实验 | 结论 |
|---|---|
| [comm_peer_atomic](comm_peer_atomic/) | 跨卡 atomic 能正确累加，但每 rank 只有约 105 GB/s，作为 all-reduce 方案不可行 |
| [comm_peer_store](comm_peer_store/) | 发送方 push 加 `sc1`、发送目标交错时，每 rank 约 263–321 GB/s；pull 只有约 1/3；two-shot 是可行方案 |
| [twoshot_tp_allreduce](twoshot_tp_allreduce/) | 自研 two-shot：512 tokens 时 31 us（RCCL 53 us），gemm2 + all-reduce 快 14–24% |
| [quickreduce_compare](quickreduce_compare/) | QR-FP16 在 TP8 下慢在逐 rank 串行等待、L2 写回、远端 store 被 vmcnt 串行化等同步开销 |

## 4. N 维切分 TP 方案与融合量化

| 实验 | 结论 |
|---|---|
| [nsplit_tp_allgather](nsplit_tp_allgather/) | 两个 gemm 都按 N 切分 + all-gather：与传统 TP 基本持平，不值得做；AG1 推送只有 19–36% 被掩盖 |
| [fused_quant](fused_quant/) | gemm1 epilogue 融合量化 + gemm2 分组 A scale：端到端快 3–6%，已接入 `fuse_quant=True` |

## 5. gemm2 + all-reduce 融合（参考 mega_moe_tp）

| 实验 | 结论 |
|---|---|
| [gemm2_tile_order](gemm2_tile_order/) | tile 顺序 `g`：输出 chunk 依次完成，代价只有 +2–5 us，是融合的基础 |
| [fused_ar_dev](fused_ar_dev/) | 开发迭代：计数器拆成 32 个后 156 → 93 us；peer 基址放 SGPR 后 91–92 us；其他调参无效 |
| [fused_ar_timeline](fused_ar_timeline/) | 时间线显示剩余瓶颈：gemm2 被拖慢、unit 同步延迟、最后一个 chunk 的尾巴 |
| [fused_ar_comm_help](fused_ar_comm_help/) | 让 compute WG 顺手做通讯会拖慢 gemm2，更慢；代码已撤销 |
| [fused_ar_route](fused_ar_route/) | topk 求和挪到通讯阶段：gemm2 变快，但通讯更慢，整体慢 3–16 us |
| [fused_ar_concurrency_bound](fused_ar_concurrency_bound/) | 完全无依赖时最多也只隐藏 35–65% 的 all-reduce；side stream 基本没有并发 |
| [fused_ar_att](fused_ar_att/) | 融合 kernel 的 ATT：compute / comm wave 的耗时分解与改进点 |
| [fused_ar_opt_ab](fused_ar_opt_ab/) | 按 ATT 去掉各处等待：只有 2048 tokens 快约 2%；gemm2（TP8 shape）不是 VALU 瓶颈 |
| [fused_ar_comm_wg](fused_ar_comm_wg/) | comm WG 的行为；`WAIT_AG=par` 无收益，LL 协议慢 1.6–2.2 倍 |
| [fused_ar_persistent](fused_ar_persistent/) | 槽位空隙只占 4.1%；简单版常驻 CTA 更慢 6–24% |
| [fused_ar_final_recheck](fused_ar_final_recheck/) | 最终复测：≥512 tokens 隐藏 38–63%；≤256 tokens 应回退到依次执行 |

## 6. gemm1 带宽分析与 fp4 快速解码（fd1/fd2，inter_dim 512）

按发现的先后顺序排列，完整过程见 `doc-mimo/README.md` 第 7 节。

| 实验 | 结论 |
|---|---|
| [gemm1_power_ceiling](gemm1_power_ceiling/) | 受 750 W 功耗墙限制，时钟约 1.05 GHz，纯读约 3.6 TB/s；gemm1 的 2.7 TB/s 约为这个上限的 75–80% |
| [gemm1_read_pattern](gemm1_read_pattern/) | 2 KB 分段读 3.3–3.5 TB/s；段长 ≥8 KB 与整块连续一样（3.9–4.0 TB/s） |
| [gemm1_cache_modifier](gemm1_cache_modifier/) | W 用 nt（`b_cache_mod=2`）快约 7%，已设为默认 |
| [gemm1_tile_layout](gemm1_tile_layout/) | W 按 WG tile 重排：结果逐位一致，但没有收益 |
| [cu_scaling_bw](cu_scaling_bw/) | 纯读每 XCD 10–16 个 CU 即可跑满；单个 XCD 上限约 0.88 TB/s |
| [gemm1_cumask](gemm1_cumask/) | 每 XCD 只用 32 个 CU、让任务均分，反而慢 9% |
| [gemm1_wave_rounds](gemm1_wave_rounds/) | tail 只占约 5%；稳态带宽约 3.15 TB/s |
| [gemm1_att_bottleneck](gemm1_att_bottleneck/) | VALU 发射受限：发射口约 90% 被占，fp4 解码占 VALU 的 79% |
| [fast_decode](fast_decode/) | fd1/fd2：VALU 减少 39% / 29%，结果逐位一致，端到端快 7–11%；已接入生产路径 |

## 工具与记录

| 路径 | 用途 |
|---|---|
| `tools/pyhip_shim/sitecustomize.py` | `pyhip.contrib` 缺失时的导入桩，通过 `PYTHONPATH` 生效 |
| `tools/wait_gpu_idle.sh` | 等所有 GPU 空闲后再返回（GPU 利用率低，且没有占 CU 或占大量显存的外部进程），用法：`wait_gpu_idle.sh && <测量命令>` |
| `tools/build_log.py` | 从 Copilot 会话 transcript 重建 `session_log.md` |
| `session_log.md` | 早期 26 个请求的完整过程：执行的命令、分析与结论（gemm1/gemm2 扫描的数值主要在这里）。transcript 不保存工具原始输出，数值以回复中的汇总为准 |

`doc-mimo/comm/` 下的通讯探针脚本（`peer_atomic_probe.py`、`peer_store_probe.py`、`allgather_bench.py`、`twoshot_bench.py`、`qr_compare.py` 等）属于独立组件，没有移动；对应实验目录里存放它们的结果和说明。

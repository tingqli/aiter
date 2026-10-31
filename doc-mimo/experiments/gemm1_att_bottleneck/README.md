# gemm1_att_bottleneck：用 ATT 定位 gemm1 的瓶颈

## 结论

- **gemm1 主体阶段是 VALU 发射受限，不是访存受限。** 在 E=304 的 trace 里（1216 个 WG 正好两轮，没有 tail 干扰）：
  - 每个 SIMD 跑 2 个 wave 时，VALU 发射占用中位数 **81%**（p90 91%），再加上 MFMA 约 9%，发射口约 90% 被占；
  - 相邻两条 VALU 之间的间隔 79% 是 4 cycle，也就是背靠背在发；
  - `s_waitcnt vmcnt` 只占 wave 时间的 **8.6%**。
- **再加 wave 也不会更快。** 每个 K 迭代，CU 上有 4 个 wave（每 SIMD 1 个）时是 3388 cycle，有 8 个 wave（每 SIMD 2 个）时是 3600 cycle。第二个 wave 基本把发射口填满了，所以提高 occupancy 或加深预取都不会有多少收益。
- **VALU 来源：** K 循环每个迭代、每个 wave 有 **529 条 VALU，只有 64 条 MFMA**。
  - fp4→fp8 解码约 416 条（79%），其中 `v_perm` 192 条；
  - 每个 128-K 组重建查找表约 90 条，其中有 8 条慢速的 `v_mul_lo_u32`。

  这就是 `../fast_decode` 的优化目标。
- **资源：** standalone 是 104 VGPR + 128 AGPR，每 SIMD 只能放 2 个 wave；port 是 120 VGPR，每 SIMD 放 4 个 wave，但 VALU 更多（每迭代 607 条），4 个 wave 时 SIMD 的 VALU 忙碌率已达 92%。
- **方法上的坑：** ATT 每个 dispatch 的 `realtime.json` 换算出的时钟不可靠。同一个 standalone kernel 的两次 trace，6033 是 43.9 万 cycle（约 2 GHz），6034 是 22.4 万 cycle（约 1 GHz），而墙钟时间几乎一样。比较时只能用 cycle 数。

## 实验

| 脚本 | 做法 |
|---|---|
| `att_gemm1.py <ui_output_dir>` | 每个 SE 采 CU0。输出：WG 驻留时间线（每个 CU 上同时在跑的 wave 数）、按指令类别统计的 wave 耗时（以 issue 到下一条 issue 的间隔计）、最耗时的指令、K 循环迭代时间 |
| `att_gemm1_iters.py <dir>` | K 迭代 cycle 数，按同一 CU 上同时在跑的 wave 数分组，以及按 kernel 阶段分组 |
| `att_simd_issue.py <dir>` | 每个 SIMD 按 2000 cycle 分窗统计 VALU 发射占用（VALU 条数 × 4 / 2000），按该 SIMD 上同时在跑的 wave 数分组；相邻 VALU 的间隔分布；K 循环体逐指令统计（来自 code.json） |
| `kernel_trace_resources.sh` | `rocprofv3 --kernel-trace`：各 gemm1 变体（含 tile/fd1/fd2）的耗时，以及 VGPR/AGPR/LDS 用量 |

抓 trace 用仓库根目录的 `trace.yaml`（`advanced_thread_trace: true`、`att_target_cu: 0`、`att_shader_engine_mask: 0xf`）：

```bash
rocprofv3 -i trace.yaml -- python3 doc-mimo/kernels/test_a8w4_gemm1.py -s 4096,512,304,8 -t 512 -r uniform --tile 32,128,0
python doc-mimo/experiments/gemm1_att_bottleneck/att_gemm1.py ck_test/ui_output_agent_<pid>_dispatch_<id>
python doc-mimo/experiments/gemm1_att_bottleneck/att_simd_issue.py ck_test/ui_output_agent_<pid>_dispatch_<id>
```

## 结果（`results/`）

原始 trace 每次有几百 MB，没有保存，下面两个 att 文件是当时分析脚本的输出。

- `att_run42008.txt`：512 tokens、E=256、`b_cache_mod=1`。
  - 6033/6034 是 standalone：每个 CU 一直只有 8 个 wave 在跑（2 个 WG）。约 2 GHz 时访存等待占主导（`vmcnt` 41% 加 vmem 发射 28%）；约 1 GHz 时 VALU 占 53%。
  - 6172/6173 是 port：每个 CU 有 12–16 个 wave，VALU 占 47–54%，WG 依次结束（73 / 95 / 122 / 155 us）。
- `att_run45475_7183.txt`：E=304、`b_cache_mod=2` 的 standalone。上面的结论主要来自这一份。
- `kernel_trace_resources.txt`：standalone 188.8 us（104 VGPR + 128 AGPR），port 205.2 us（120 VGPR），tile 192.4 us，fd1 180.8 us，fd2 175.9 us。

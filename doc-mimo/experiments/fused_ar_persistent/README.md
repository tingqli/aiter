# fused_ar_persistent：改成常驻 CTA 能否消除 wave 槽位的空隙

## 结论

- **槽位空隙不在关键路径上。** gemm2 阶段内槽位空闲只占 **4.1%**；相邻两个 wave 之间的间隔中位数 0.20 us（p90 0.84，最大 1.64 us）。全部消除，收益上限也只有约 4%。
- **简单版常驻 CTA（`PERSIST=k`：只启动 k × CU 数个 compute CTA，按 grid stride 循环处理 tile）在所有 k 下都更慢**：gemm2 单独跑慢 6–24%，融合慢 2–24%。原因：
  - 各 tile 的代价不均匀，而 grid stride 是静态分配，丢掉了硬件按空闲槽位分发 tile 的动态负载均衡；
  - 每个 tile 之后的 barrier 让 CTA 内的 wave 互相等待。
- 照搬 mega_moe_tp 的整套方案，潜在收益主要在小 M 下 gemm2 的预取流水，代价是大规模重写；而它的通讯部分（LL、compute 顺手做通讯）在本架构上已被证明是负收益（`../fused_ar_comm_wg`、`../fused_ar_comm_help`）。**目前不建议投入。**

## 实验

- `att_slot_gaps.py <ui_output_dir>`：对每个硬件 wave 槽位（SE, SIMD, slot），按顺序列出在它上面运行过的 wave，统计前一个结束到下一个开始的空隙，以及 gemm2 阶段内槽位的空闲比例。wave 按指令数和生命周期分为 comm（>20 us）、空 tile（<1 us）和 gemm tile。
- `PERSIST=k`（`test_a8w4_gemm2.py` 中的开关，默认 0）：k = 0 / 4 / 5 / 6 / 8，先跑 pytest，再分别测 gemm2 单独跑和融合的时间。

```bash
python doc-mimo/experiments/fused_ar_persistent/att_slot_gaps.py ck_test/ui_output_agent_56655_dispatch_3909
PERSIST=6 CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 512 1024 2048
```

## 结果（`results/`）

- `att_slot_gaps.txt`：trace 56655（TP4，512 tokens），96 个槽位。gemm2 阶段内忙碌 3204 us、空闲 137 us（4.1%）。
- `persist_lite_sweep.txt`（8 卡，c64 ch256，单位 us）：

  | tokens | gemm2 单独：k=0 / 5 / 6 / 8 | 融合：k=0 / 5 / 6 / 8 |
  |---|---|---|
  | 128 | 51.7–52.3 / 60.1 / 56.3 / 55.1 | 72.4–77.2 / 77.4 / 74.1 / 77.2 |
  | 512 | 66.7–68.5 / 76.6 / 73.8 / 70.7 | 90.7–90.8 / 98.1 / 97.4 / 95.9 |
  | 1024 | 98.0–98.6 / 114.1 / 109.8 / 106.6 | 135.1–136.1 / 155.6 / 149.5 / 148.3 |
  | 2048 | 158.5–159.3 / 196.4 / 188.1 / 181.0 | 230.2–232.0 / 286.2 / 269.5 / 256.6 |

  文件里 `PERSIST=4` 那一轮碰上了 `gpu.grid_dim` 的用法错误（修复后 pytest 通过，但没有重测性能），所以没有数据。

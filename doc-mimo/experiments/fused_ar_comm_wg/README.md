# fused_ar_comm_wg：comm WG 的行为分析与改进尝试

## 结论

- **每个 unit 的忙碌时间约 4.8 us**，几乎都是同步往返：RS 远端写确认约 1.07 us、flag 往返约 0.7 us、AG 写确认约 0.94 us。rs/ag flag 的自旋循环从不重复，flag 在第一次读时就已经到了。
- 按这些发现做了两项改进，**都没有收益**：
  1. **`WAIT_AG=par`**（退出前并行等待所有 ag flag）：耗时不变，例如 512 tokens 时 seq 90.9、par 91.4 us。kernel 何时结束取决于最慢的 rank 推完最后一批数据，串行读 flag 的时间被这段等待覆盖了。因为没有坏处，保留为默认。
  2. **`RS_LL=1`**（reduce-scatter 改用 LL 协议，flag 嵌在数据包里）：结果正确，但**慢 1.6–2.2 倍**（512 tokens 92 → 144–148 us，2048 tokens 230 → 502–520 us）。主因是接收端必须绕过缓存反复读数据本身来判断是否到齐，每次轮询每个 WG 要读 32 KB，加上 RS 字节数翻倍，把 HBM 和 xGMI 压垮了，gemm2 的 tile 结束时间从 72.9 推迟到 109–112 us。代码已撤销。
- 在「comm WG 嵌在非常驻 gemm2 kernel 里」的架构下，同步协议这一层已基本优化到头。剩下能做的只有减少通讯字节（例如 fp8 传输）或减轻 HBM 争抢。

## 实验

- `att_comm_timeline.py <ui_output_dir>`：在 code.json 里按模式找到 comm 角色的关键指令（自旋轮询的 load、barrier、RS/AG store 的 drain、flag 交换、最后的 AG 等待），然后对每个被采到的 comm wave，按 unit 输出各阶段的结束时刻和各阶段平均耗时。
- `WAIT_AG=seq|par`、`RS_LL=1`（以及 `LL_MASK`、`LL_HINT`、`LL_SLEEP`、`WPE`）的 8 卡 A/B，c64 ch256，每个配置都在 GPU 空闲时运行（`../tools/wait_gpu_idle.sh`）。

```bash
python doc-mimo/experiments/fused_ar_comm_wg/att_comm_timeline.py ck_test/ui_output_agent_56655_dispatch_3909
WAIT_AG=par CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 512 1024 2048
```

## 结果（`results/`）

| 文件 | 内容 |
|---|---|
| `att_comm_timeline_tp4_512.txt` | trace 56655（TP4，512 tokens）的 comm unit 时间线 |
| `opt_wait_ag.txt` | `WAIT_AG` seq vs par，各 3 次交替运行 |
| `opt_rs_ll.txt` | RS_LL 各变体。标了 INVALID 的组是在别人占满 GPU 时跑的 |
| `opt_baseline.txt` | 一次失败的基线运行（只有 traceback），仅作记录 |

完整的反汇编和协议说明见 `doc-mimo/comm-wg-behavior.md`。

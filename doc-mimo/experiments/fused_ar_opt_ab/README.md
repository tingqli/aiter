# fused_ar_opt_ab：按 ATT 结论做的优化 A/B（以及 WPERM 配对探针）

## 结论

- `../fused_ar_att` 列出的几处开销都已消除，ISA 层面确认生效，但**端到端几乎没有收益**：只有融合 2048 tokens 快了约 2%（237 → 233 us），gemm2 单独跑的时间完全没变。
- 由此确认：
  - 这些等待会被同 CU 上的其他 wave 掩盖，不在关键路径上；
  - gemm2（TP8 shape）**不是 VALU 瓶颈**：删掉约 7% 的 VALU 指令，耗时不变。按指令数估算的 64% VALU 占用率并不说明瓶颈在 VALU。
- 保留为默认的开关：`EPI_DRAIN=1`、`TBL=s`、`AR_HOOK=wave`。默认关闭：`BF16_FAST`、`WPERM`。
- **WPERM**（fp4→fp8 解码时去掉把 even/odd 字节拼回 K 顺序的两条 `v_perm`）：pytest 16/16 通过，误差相同；`wperm_probe.py` 单点探针显示两种解码都严格对角配对（A[k] 只与 W[k] 相乘）。从源码推导本该出错，原因没想清楚，因为没有速度收益没有深究。
  - 后来的 `../fast_decode` 改为在准备权重时预先重排 nibble，严格等价，并且在 VALU 受限的 shape 上确实有收益。

## 实验

各开关通过环境变量设置，并写进 kernel 名，保证 JIT 缓存不会混用：

| 开关 | 改动 |
|---|---|
| `EPI_DRAIN=1` | epilogue 发第一个 atomic 前先 `s_waitcnt vmcnt(0)`，8 个 atomic 连续发出 |
| `TBL=s` | 对称表改用 `s_buffer_load` 读进 SGPR |
| `AR_HOOK=wave` | 每个 wave 各自 `vmcnt(0)` 后报数，去掉 WG 级 barrier |
| `BF16_FAST=1` | epilogue 的 bf16 舍入去掉 NaN 分支 |
| `WPERM=1` | 解码去掉 2 条拼回 K 顺序的 `v_perm` |

`wperm_probe.py`：A 只在第 KA 列为 1，W 只在第 KW 列为 2，遍历同一个 8 宽 K 组内所有 (KA, KW)，检查输出是否只在 KA == KW 时翻倍。

```bash
WPERM=0 HIP_VISIBLE_DEVICES=0 python doc-mimo/experiments/fused_ar_opt_ab/wperm_probe.py
WPERM=1 HIP_VISIBLE_DEVICES=0 python doc-mimo/experiments/fused_ar_opt_ab/wperm_probe.py
```

## 结果（`results/opt_ab_sweep.txt`，8 卡，c64 ch256，单位 us）

| tokens | gemm2 单独（A / D） | 融合 A：原样 | 融合 D：DRAIN + TBL=s + wave | E / F / G：D 加 BF16_FAST / WPERM / 两者 |
|---|---|---|---|---|
| 128 | 52.2 / 52.3 | 76.7 | 76.3 | 74.5 / 73.7 / 75.1–79.3 |
| 512 | 67.3 / 67.6 | 90.9 | 91.6 | 93.1 / 91.4 / 91.1–92.0 |
| 1024 | 98.1 / 97.8 | 132.0 | 133.6 | 134.5 / 135.4 / 134.3–134.8 |
| 2048 | 159.5 / 159.1 | 237.1 | **232.6** | 232.2 / 231.1 / 229.7–229.9 |

文件里标了 INVALID 的那组是在别人占满 GPU 时跑的，作废。

# fused_ar_dev：gemm2 + all-reduce 融合 kernel 的开发迭代

## 结论

- 关键的一步是**把 chunk 完成计数器从每个 chunk 一个，拆成 32 个**（8 个 XCD × 4，各占一条 256 B 的线）。拆之前约 8000 次 atomic 打在同一条缓存线上，即使 comm WG 什么都不做（skip）也要 102.7 us；拆之后 512 tokens 时 156.3 → **93.0 us**，skip 时 69.3，约等于 gemm2(g) 单独跑的时间。
- 第二个有效改动：peer 基址放进 SGPR、计数器改为 lane 并行轮询，VGPR 从 98 降到 78，得到 **91–92 us**。
- 没有收益的改动：
  - 拆分角色（一半 WG 只推送，一半只做规约）：93–99；
  - 加大每个 unit 的数据量（`vpt`=2/4/8）：95 / 113 / 155，因为 comm 代码让整个 kernel 的 VGPR 涨到 98–173；
  - `waves_per_eu=7` 把 VGPR 硬压到 72：128–137，spill 落在 gemm2 路径上；
  - comm 单独做成 kernel 放在 side stream 并发：112，跨 stream 的依赖开销更大；而且 comm 先发射时会死锁，gemm2 必须先发射；
  - 扫 `CHUNK_N` 256 / 512 / 1024 和 `cwg` 32 / 64 / 96 / 128：88–98，512 tokens 时差别不大，大 M 时 256 列加 64 个 comm WG 最好。
- 第一版最终结果见 `gemm2_ar_fused_final.txt`，其中 128 tokens 那一行后来没能复现，以 `../fused_ar_final_recheck` 为准。

## 实验

融合 kernel 在 `doc-mimo/kernels/gemm2_ar_fused.py`（8 卡，torchrun）。主要环境变量：

- `CWG`：comm WG 数；`CHUNK`：每个 chunk 的列数；`VPT`：每个 unit 的数据量；
- `SPLIT`：拆分角色；`SEP`：comm 单独成 kernel；`WPE`：`waves_per_eu`；
- `MODES=skip,run`：skip 时 comm WG 不做通讯，用来单独测 gemm2 部分。

```bash
CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 512 2048
```

每组输出：gemm2(m)、gemm2(g)、two-shot、依次执行，以及各融合配置的时间，并与 fp32 `dist.all_reduce` 对比（bad=0）。

## 结果（`results/`，以 512 tokens 为主）

| 文件 | 内容 |
|---|---|
| `raw_fused.txt` | v1：32 个计数器，c32 时 93.0，skip 69.3 |
| `raw_fused_full.txt`、`raw_fused_novm.txt`、`raw_fused_nocnt.txt`、`raw_fused_none.txt` | skip 模式下 tile hook 的消融：full 103.6 / novm 103.1 / nocnt 70.7 / none 68.6，定位到计数器热点 |
| `raw_fused_sweep.txt` | c32 / c64 × v1 / v2 |
| `raw_fused_split.txt` | 拆分角色 |
| `raw_fused_vpt.txt` | `vpt`=2 / 4 / 8 |
| `raw_fused_wpe.txt` | `waves_per_eu` |
| `raw_fused_sep.txt` | comm 单独成 kernel：112.0 |
| `raw_fused_ch.txt`、`raw_fused_cw.txt` | `CHUNK_N` 和 `cwg` 扫描 |
| `gemm2_ar_fused_final.txt` | 第一版最终结果（128–2048 tokens） |

设计说明见 `moe-new-tp.md` 后半部分第 2–3 节。

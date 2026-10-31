# fused_ar_final_recheck：gemm2 + all-reduce 融合的最终复测（128–8192 tokens）

## 结论

- **测量方法可信。** 512–2048 和 8192 tokens 两次运行相差 1–3%；4096 tokens 噪声较大，隐藏比例在 43–56% 之间。
- **融合只在 ≥512 tokens 时有收益**（c64，256 列 chunk）：

  | tokens | 依次执行 | 融合 | AR 被隐藏的比例 |
  |---|---|---|---|
  | 128 | 65.3 | 74.5–76.6 | **负**（融合更慢） |
  | 256 | 78.6–78.9 | 77.4–80.7 | 约 0 |
  | 512 | 103 | 90.0–90.3 | 38–41% |
  | 1024 | 163–164 | 133.8–135.7 | 47–49% |
  | 2048 | 279.5 | 224.7–227.2 | 46–48% |
  | 4096 | 519–532 | 394.6–412.2 | 43–56% |
  | 8192 | 1009–1017 | 718–725 | 62–63% |

- **第一版表格（`../fused_ar_dev/results/gemm2_ar_fused_final.txt`）中 128 tokens 那一行不可信：** 那次「依次执行」偏高约 6 us，融合的 68.2 us 也没能复现。**≤256 tokens 应回退到依次执行。**
- **隐藏比例的走势**：记 O = 融合 − gemm2，则隐藏比例 = 1 − O/AR。
  - ≤512 tokens：O 约为常数 22 us，比例随 AR 增大而上升；
  - 1024–2048 tokens：O ≈ 0.6 × AR，比例持平——并发争抢使通讯跟不上 gemm2，gemm2 本身也被拖慢，`g` 顺序的代价在并发下被放大；
  - ≥4096 tokens：O/AR 降到 0.41–0.5，因为并发的额外代价基本不随 M 增长（27–45 us）。但尾巴从 46 涨到 102 us，因为 c64 的 comm WG 本身就比 gemm2 慢。
- **comm WG 数：** c64 在大 M 时仍然最好；c32 和 c128 在 4096 / 8192 tokens 时明显更慢。

## 实验

都在 GPU 空闲时运行（`../tools/wait_gpu_idle.sh`）：

- **A1 / A2**：`gemm2_ar_fused.py` 跑 128–8192 tokens，c64 ch256，两次；
- **C**：c32 / c128 对比；
- **D**：`../fused_ar_concurrency_bound/concurrency_bound.py`，c64，无依赖时的上限（1024–8192 tokens）；
- **E**：`../fused_ar_timeline/fused_timeline.py`，c64 ch256，时间线；
- **F1 / F2**（`final_recheck_smallm.txt`）：128 / 256 / 512 tokens 下 c32 / c64 × ch256 / ch1024 两次。

```bash
CHUNK=256 CWG=64 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm2_ar_fused.py 128 256 512 1024 2048 4096 8192
```

## 结果（`results/`）

- `final_recheck.txt`：A1、A2、C、D、E 各组的原始输出；
- `final_recheck_smallm.txt`：F1、F2。

完整讨论见 `moe-new-tp.md` 后半部分第 4 节。

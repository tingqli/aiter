# gemm1_cumask：限制每 XCD 的 CU 数，让每个 CU 分到的 WG 数相同

## 结论

- 想法是：1024 个 WG 平分到 8 个 XCD，每个 XCD 只用 38 个 CU 中的 32 个，这样每个 CU 正好 4 个 WG、跑 2 轮，消除「有的 CU 3 个、有的 CU 4 个 WG」的不均。结果**更慢**：192 → **209–211 us**（约 +9%）。CU 越少越慢，每 XCD 16 个 CU 时约 265 us。
- 原因：
  - 不限制 CU 时，每个 CU 最多也是 4 个 WG（有 112 个 CU 分到 4 个），总时间本来就由这些 CU 决定，均分并没有减少它们的工作量；
  - 而 CU 少了 16%，第一轮同时运行的 WG 从 608 个降到 512 个，在途读请求随之减少，带宽从 3.0 降到 2.75 TB/s。
- 和 `../cu_scaling_bw` 对照：纯读每 CU 有约 64 KB 在途，所以 80–96 个 CU 就够；gemm1 每 CU 平均在途只有约 10 KB（按 3 TB/s × 约 1 us 估算），必须用上全部 CU。
- 这个实验本身说明 gemm1 受「每个 WG 能发出的读请求量」限制。后面的 ATT 进一步说明，限制读请求发出的是 VALU 解码（`../gemm1_att_bottleneck`）。

## 实验

`gemm1_cumask.py`：

1. 用 `hipExtStreamCreateWithCUMask`（ctypes 调用）创建只能用部分 CU 的 stream，再用 `torch.cuda.ExternalStream` 包装，gemm1 在这个 stream 上执行。
2. **验证 mask 映射：** 在每个 mask 下运行 `../cu_scaling_bw` 的 HW_ID 探针 kernel（每个 CU 一个 WG）。确认 mask 的第 j 位对应 XCD `j % 8` 上的第 `j // 8` 个 CU，并在各 SE 之间均匀分布（例如每 XCD 32 个 CU 时，正好 256 个不同的 CU、每个 SE 8 个）。
3. 在每 XCD 38 / 36 / 32 / 28 / 24 / 19 / 16 个 CU 的 mask 下，对 standalone 和 port 各计时 2 次（tn128 时 1024 个 WG；tn64 时 2048 个）。

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim python doc-mimo/experiments/gemm1_cumask/gemm1_cumask.py
```

## 结果（`results/gemm1_cumask.txt`，standalone，tn128，`b_cache_mod=2`，单位 us）

| 每 XCD 的 CU 数 | 不限制 | 38 | 36 | **32** | 28 | 24 | 19 | 16 |
|---|---|---|---|---|---|---|---|---|
| 第 1 次 | 191.5 | 192.3 | 191.5 | **209.1** | 214.4 | 227.9 | 252.0 | 265.7 |
| 第 2 次 | 195.2 | 192.0 | 193.0 | **210.8** | 209.6 | 231.2 | 253.9 | 264.9 |

tn64 和 port 的趋势相同，见原始文件。

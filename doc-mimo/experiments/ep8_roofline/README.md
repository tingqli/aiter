# ep8_roofline：本机（750 W 功耗墙）实测上限

## 结论

EP8 的下限（`ep8_common.roofline`）用的是这里测出的持续值，不是规格峰值：

| 项目 | 实测 | 功耗 / 时钟 |
|---|---|---|
| HBM 纯读（`torch.sum`，408 MB / 1 GB） | **3.60 / 3.64 TB/s** | 720–740 W，1.29–1.39 GHz |
| fp8 GEMM（hipBLASLt，`torch._scaled_mm`）16384×4096×4096（= gemm1 形状） | **1117 TFLOPs** | 740 W，1.20 GHz |
| fp8 GEMM 16384×4096×2048（= gemm2 形状） | **1002 TFLOPs** | 746 W，1.32 GHz |
| bf16 GEMM（hipBLASLt）16384×4096×4096 / 16384×4096×2048 | **637 / 571 TFLOPs** | 736–744 W，1.32–1.38 GHz |
| fp8 / bf16 GEMM 2048×4096×4096 | 869 / 515 TFLOPs | |
| fp8 / bf16 GEMM 512×4096×4096 | 586 / 403 TFLOPs | |

- 所有 dense GEMM 都跑在 750 W 功耗墙上，时钟只有 1.2–1.5 GHz（规格 2.1 GHz）；fp8 16384×4096×4096 对应约 75% 的 MFMA 利用率。
- 结果：`results/roofline_gpu0.txt`。

## 方法

每个用例循环约 4 秒，同时用 `amd-smi metric` 采样功耗和 gfx 时钟，取稳态值。

```bash
python doc-mimo/experiments/ep8_roofline/roofline.py
```

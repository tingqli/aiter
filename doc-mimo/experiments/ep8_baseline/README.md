# ep8_baseline：TP 调好的 kernel 直接跑 EP8 shape

## 结论

把 TP8 下调好的 a8w4 2-kernel（sort → x 量化 → gemm1 q8s fd2 → gemm2 a_group 128）直接用在 EP8 每卡 shape（32 个本地专家、inter 2048）上，冷 cache，单位 us（`results/baseline.txt`）：

| tokens | bm32 | bm64 | EP8 专用 kernel（`ep8_e2e` v4，auto） |
|---:|---:|---:|---:|
| 1 | 57.0 | 58.1 | 43.3 |
| 16 | 154.9 | 149.0 | 63.4 |
| 64 | 183.0 | 165.1 | 124.4 |
| 256 | 174.8 | 174.1 | 144.0 |
| 1024 | 246.6 | 248.8 | 182.9 |
| 4096 | 668.3 | 747.5 | 425.8 |
| 16384 | 2275.0 | 2491.0 | 1306.3 |

- TP kernel 按 inter 256 调参，在 inter 2048 上：16 tokens 时 sort / quant / 2 个 gemm 各自的固定开销加起来就超过 140 us；≥4096 tokens 时 gemm2 占一半以上（16384 tokens gemm2 1283 us）。
- `sweep_tp_kernels.py` 单独扫了 gemm1 / gemm2 的 tile 配置（`results/sweep_tp_kernels.txt`）：16 tokens 时 gemm1 最好 37 us（2.6 TB/s）、gemm2 21 us；1024 tokens 时 gemm1 115 us、gemm2 80–112 us。
- aiter `fused_moe` 的 a16w4 路径在当前环境下不可用（`module_moe_cktile2stages.so` 符号缺失 / 启发式分发不支持该配置），没有对比数据。

```bash
python doc-mimo/experiments/ep8_baseline/bench_baseline.py -t 1 16 64 256 1024 4096 16384
python doc-mimo/experiments/ep8_baseline/sweep_tp_kernels.py -t 16 256 1024 4096
```

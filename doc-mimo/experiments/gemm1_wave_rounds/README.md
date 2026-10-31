# gemm1_wave_rounds：tail（最后一轮 WG 不足）对 gemm1 的影响

## 结论

- **tail 只占约 5%。** 1024 个 WG（1.68 轮）稳定在 **2.96–2.97 TB/s**；WG 数正好是整数轮（2 / 3 / 4 轮）或更多轮时约 **3.1–3.2 TB/s**。
- **即使 tail 几乎可以忽略（4 轮），带宽也只有约 3.15 TB/s。** 所以 2.97 和理想值约 4 TB/s 之间的大部分差距不来自 tail，而来自稳态下每个 WG 发出读请求太慢（后来查明是 VALU 解码受限，`../gemm1_att_bottleneck`）。
- 只修 tail（更细的 tile、按轮数凑 grid、均分到 CU）最多拿回约 5%。tn64 只快约 2%、限制 CU 均分反而更慢（`../gemm1_cumask`），都和这个结论一致。

## 实验

`rounds_sweep.py`：改变专家数 E，同时令 tokens = 2E、topk 8，使每个专家平均 16 行（只占一个 bm32 的 m-block）。这样每个 WG 的工作量相同（读 512 KB 权重），只有 grid 大小变化（每个专家 4 个 WG）。

standalone kernel 每个 CU 放 2 个 WG，所以 608 个 WG（304 个 CU × 2）算一轮。E=76 和 E=152 的权重只有约 160 MB 和 320 MB，可能部分落在 256 MB 的 MALL 里，带宽偏高，不作为结论依据。

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim python doc-mimo/experiments/gemm1_wave_rounds/rounds_sweep.py 3
```

## 结果（`results/gemm1_rounds.txt`，standalone，tn128，`b_cache_mod=2`）

| E | WG 数 | 轮数 | TB/s（3 次） |
|---|---|---|---|
| 228 | 912 | 1.50 | 3.11 / 2.90 / 3.09 |
| **256** | **1024** | **1.68** | **2.97 / 2.97 / 2.96** |
| 304 | 1216 | 2.00 | 3.03 / 3.11 / 3.23 |
| 380 | 1520 | 2.50 | 3.15 / 3.10 / 3.22 |
| 456 | 1824 | 3.00 | 3.14 |
| 532 | 2128 | 3.50 | 3.13 |
| 608 | 2432 | 4.00 | 3.11 / 3.21 / 3.16 |

结果文件里前 9 行来自较早版本的脚本（输出格式略不同），后面是两次重复。

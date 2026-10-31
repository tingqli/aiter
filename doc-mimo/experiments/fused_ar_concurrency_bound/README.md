# fused_ar_concurrency_bound：gemm2 与 all-reduce 完全无依赖时的并发上限

## 结论

- **即使 all-reduce 完全不依赖 gemm2 的结果（nodep），融合在同一个 kernel 里也只能隐藏约一半（35–65%）的 all-reduce。** 2048 tokens 时理想值 max(gemm2, AR) = 159 us，实测上限 199 us。comm WG 空转只多 0–9 us，所以剩下约 40 us 是两者**同时运行时的资源争抢**：HBM / L2 带宽，以及同一个 CU 上的发射和访存槽位。
- **side stream 基本没有并发**（隐藏比例 −40% 到 +17%，大多约 0）：gemm2 的 grid 一直占满 CU，另一条 stream 的 kernel 只能等 gemm2 尾部的 WG 退出后才分发，高优先级也不会抢占正在运行的 WG。
- **comm 单独成 kernel（sep nodep）** 在 2048 tokens 时有一定并发，但比融合差 15–20 us，而且不稳定（280–510 us 的异常值）：各 rank 的 comm kernel 分发时刻不同，peer 之间互相空等。
- 所以**把 comm WG 和 gemm2 放在同一个 kernel 里，是唯一可靠的并发方式**。v1（有依赖）在 ≤1024 tokens 时已基本达到上限；2048 tokens 时还差约 40 us，其中约 14 us 来自 tile 顺序 `g`。

## 实验

`concurrency_bound.py`（8 卡）。all-reduce 作用在 symmetric buffer 里一块独立的 `src` 区，与 gemm2 的输出无关，comm WG 一启动就开始做（`ar_config(..., nodep=True)`）。对比的几种方式：

- `gemm2(m)`、`gemm2(g)` 单独跑；`AR`（two-shot）单独跑；依次执行；
- side stream：AR 放在高优先级 side stream，两种入队顺序都测；
- fused nodep：同一个 kernel 内，o=m 和 o=g 两种 tile 顺序都测；
- sep nodep：comm 单独成 kernel，放在 side stream；
- fused idle：comm WG 启动但不做事，测它占位的代价；
- commWG alone：comm kernel 单独跑。

所有配置的结果都等于 fp32 all_reduce(src)。

```bash
CWG=32,64,128 CHUNK=256 torchrun --nproc_per_node=8 doc-mimo/experiments/fused_ar_concurrency_bound/concurrency_bound.py 128 512 1024 2048
```

## 结果（`results/gemm2_ar_concurrency_bound.txt`、`_run2.txt`，两次运行的范围，单位 us）

| tokens | gemm2(m) | AR | 依次执行 | side stream | sep nodep | **fused nodep** | 隐藏比例上限 |
|---|---|---|---|---|---|---|---|
| 128 | 52.4–52.8 | 13 | 66–68 | 71–72 | 72–74 | **59–61** | 约 35–50% |
| 512 | 68–70 | 32–33 | 100–101 | 104–105 | 101–102 | **82–85** | 约 50–55% |
| 1024 | 99–100 | 60–62 | 161–162 | 157–159 | 146–148 | **131** | 约 48% |
| 2048 | 159 | 113–114 | 270–271 | 272–277 | 214–219 | **199** | 约 65% |

更大 M（4096 / 8192 tokens）时上限升到 68–84%，见 `../fused_ar_final_recheck`（D 组）。

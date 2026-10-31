# nsplit_tp_allgather：两个 gemm 都按 N 维切分 + all-gather 的 TP 方案

## 结论

- **这个方案不值得做。** 整层（gemm1 + gemm2 + 通讯）与传统 TP 基本持平；传统 TP 也用上同样的融合量化后，新方案还要慢 3–14 us。
- 根本原因：
  - 中间激活宽度 topk × inter = 16384，是输出宽度 4096 的 4 倍。即使 AG1 用 fp8，发送量也等于整个 two-shot all-reduce，之后还要再做一次 AG2。
  - AG1 推送放进 gemm1 epilogue 后，只有 **19–36%** 被计算掩盖。推送让 gemm1 本身变慢（512 tokens +18 us，2048 tokens +63 us）：远端写集中在每个 WG 结束时突发写出，平均带宽远低于链路上限；等待 kernel 还要再等最后一批数据传完。
- **one-shot all-gather 的写段长度不是瓶颈：** 把连续写段从整个分片缩到 128 B，AG 耗时仍只有约 40 us（整段约 34 us）。
- 行按 token 顺序存放（token×topk+slot）时，每行的 scale 变成 4 B 的分散远端写，比按排序位置存放、scale 先在 LDS 汇总再连续写出慢 5–40 us（`q8push` vs `q8pushs`）。

## 实验

| 脚本 / 组件 | 内容 |
|---|---|
| `doc-mimo/comm/allgather_bench.py` | one-shot all-gather（AG1：fp8 [M×8, 256]/卡；AG2：bf16 [M, 512]/卡）与 two-shot、RCCL 对比 |
| `ag_segment_sweep.py` | one-shot AG1（512 tokens）的连续写段长扫描：整个分片 / 4096 / 1024 / 512 / 256 / 128 / 64 B，各 10 个 epoch 校验 |
| `doc-mimo/kernels/gemm1_ag_tp.py` | gemm1 `epilog="q8push" / "q8pushs"`：SiLU → LDS → fp8 量化 → push 到 8 张卡对应的 plane，按 tile 发 flag，再接一个等待 kernel。`Q8PUSH_VARIANT=noscale,nopub,cm0,cm16,one,selfonly` 做消融 |
| `prof_gemm1_push.py` | 用 torch profiler 拆分 gemm1 融合推送各 kernel 的 GPU 时间（GPU 先排队后计时） |

```bash
torchrun --nproc_per_node=8 doc-mimo/comm/allgather_bench.py 128 512 2048
torchrun --nproc_per_node=8 doc-mimo/experiments/nsplit_tp_allgather/ag_segment_sweep.py
TILES=32,0:64,1 torchrun --nproc_per_node=8 doc-mimo/kernels/gemm1_ag_tp.py 128 512 2048
```

## 结果（`results/`，单位 us）

- `raw_g1ag.txt`：gemm1 融合推送的主结果。

  | tokens / 配置 | gemm1 + 融合量化 | + 推送 + 等待 | 单独 AG | 掩盖比例 |
  |---|---|---|---|---|
  | 128 / bm32 | 90.7 | 98.8 | 11.0 | 26% |
  | 512 / bm32 | 99.6 | 127.0 | 34.0 | 19% |
  | 2048 / bm32 | 207.3 | 304.7 | 137.1 | 29% |
  | 2048 / bm64 + dyn_m | 193.4 | 281.2 | 137.7 | 36% |

- `raw_g1ag_cm0.txt`、`raw_g1ag_cm16.txt`：换远端写的 cache 策略，没有改善。
- `raw_g1ag_nopub.txt`：去掉 flag 发布（结果因此出错，bad>0），也没有变快。

整层对比、one-shot AG 的实测表和 gemm2 换 shape 的收益，见 `moe-new-tp.md` 前半部分第 1–4 节。

# gemm2_epilog_ablation：gemm2 的写回方式是否是瓶颈

## 结论

- 把 gemm2 epilogue 的 atomic 换成普通 store、或者完全不写回，在 128 / 512 / 2048 tokens 时**耗时都不变**。
- 所以 gemm2（TP8 shape：N=4096，K=256）不受 atomic 或输出写回限制，而是受读权重和主循环限制（128 tokens 时约 3.1 TB/s）。
- 推论：N 维切分 TP 方案里「atomic 少 8 倍」的设想不会带来收益（见 `../nsplit_tp_allgather`、`moe-new-tp.md` 第 1 节）。

## 实验

`g2_epilog_ablation.py` 是当时 `test_a8w4_gemm2.py` 的快照，加了环境变量 `EPI`：

- `atomic`（默认）：原来的 atomic 写回；
- `store`：普通 store（结果不正确，只看耗时）；
- 其他值：不写回。

kernel 名带 `_epi<模式>`，所以三种变体不会共用同一份编译缓存。

```bash
for m in atomic store none; do EPI=$m python doc-mimo/experiments/gemm2_epilog_ablation/g2_epilog_ablation.py -t 128 512 2048 --tile 32,128,1; done
```

## 结果

没有单独存结果文件。结论记录在 `moe-new-tp.md` 第 1 节和 `../session_log.md`。

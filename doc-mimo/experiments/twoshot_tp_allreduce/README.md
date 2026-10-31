# twoshot_tp_allreduce：自研 two-shot all-reduce 与 TP8 下的 gemm2 + all-reduce

## 结论

- **自研 two-shot**（`doc-mimo/kernels/twoshot_allreduce.py`）比 RCCL 快很多。在 TP 测试中（profiler 统计 kernel 时间，单位 us）：

  | tokens | gemm2 | RCCL | two-shot | gemm2+RCCL | **gemm2+two-shot** |
  |---|---|---|---|---|---|
  | 128 | 41.5 | 25.1 | **12.1** | 63.5 | **50.5**（快 20%） |
  | 512 | 53.6 | 53.3 | **31.0** | 104.9 | **79.6**（快 24%） |
  | 2048 | 126.7 | 148.4 | **111.8** | 255.0 | **219.3**（快 14%） |

- **精度：** 与 fp32 精确求和相比 err=0（cos 约 1e-6），比 RCCL 的 bf16 累加更准；而且所有 rank 的结果逐位相同。
- **优化过程**（512 tokens，4 MB）：
  - 初版 88.8 us；
  - peer 地址表在开头一次读完，避免 `vmcnt(0)` 把远端 store 串行化：约 52 us；
  - 轻量同步：数据用 `sc0|sc1` 写穿，加 monotonic flag，去掉每个 wave 的 `buffer_wbl2`：40.4 us；
  - 发送目标按 `(rank + WG + i)` 轮转，让 7 条链路同时工作：**30.5 us**。
- **排查异常值：** 早期表中偶尔出现的 138 us 是单个 rank 的异常值（取最慢 rank 时被带进来），不是稳定行为；`tp_dbg.py` 就是为排查这个写的。

## 实验

- 主测试：`torchrun --nproc_per_node=8 doc-mimo/kernels/twoshot_allreduce.py -t 128 512 2048 -r uniform --tile 32,128,1`。各 rank 的路由相同，W2 和 stage-1 中间结果按 rank 切分；计时取最慢 rank，每个候选在计时前后各校验一次。
- 独立 benchmark：`torchrun --nproc_per_node=8 doc-mimo/comm/twoshot_bench.py 128 256 512 1024 2048`（200 个 epoch，每次输入不同且逐次校验）。
- `tp_dbg.py`：用 torchrun 运行，替换 `_rank_max`，逐 rank 打印 gemm2 和 all-reduce 的耗时。

## 结果（`results/comm_tp_gemm2_allreduce.txt`）

原始输出，包括 RCCL 基线、逐 rank 排查，以及 two-shot 各版本（v0 / v1 / light / fence / v2）和稳定性复测。two-shot kernel 的 ISA 见 `../isa_snapshots/results/twoshot_ar_bf16_n2097152_w8_t128.s`。设计细节见 `doc-mimo/README.md` 第 4.4 节。

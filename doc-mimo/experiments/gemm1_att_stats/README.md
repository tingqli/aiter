# gemm1_att_stats：早期 gemm1（TP8 shape）的 ATT stats 汇总

## 结论

- **TP8 shape**（inter 256，bm32，xcd0，`b_cache_mod=1`）：gemm1 每个 wave 的时间里，访存等待和访存发射约占一半——`s_waitcnt vmcnt` 31.0%，`buffer_load` 发射 21.8%；VALU 33.9%，MFMA 3.4%，`s_barrier` 5.0%。
- 最耗时的单条指令是等待权重 load 的 `s_waitcnt vmcnt(2)` / `vmcnt(0)`，以及 W 的 `buffer_load_dwordx4 ... sc0`。完整 wave 的时长为 12.8–17.1 万 cycle。
- 当时据此判断这个 shape 偏访存延迟受限，所以做了软件流水。后来在 inter 512、功耗墙下重新分析，VALU 解码才成为主瓶颈（`../gemm1_att_bottleneck`、`../fast_decode`）。

## 实验

`att_an.py <stats_*.csv> [ui_output_dir]`：读 rocprofv3 ATT 的 stats CSV（每条指令一行，含 Hitcount、Latency、Stall），输出：

- 按指令类别（`s_waitcnt vmcnt`、`buffer_load`、`v_`、`v_mfma`、`s_barrier` 等）汇总的 latency / stall 和每迭代均值；
- 最耗时的指令；
- 如果给了 ui_output 目录，还输出完整 wave 的时长。

```bash
rocprofv3 -i trace.yaml -- python3 doc-mimo/kernels/test_a8w4_gemm1.py -t 512 --tile 32,128
python doc-mimo/experiments/gemm1_att_stats/att_an.py ck_test/stats_ui_output_agent_<pid>_dispatch_<id>.csv
```

## 结果（`results/`）

- `stats_ui_output_agent_64551_dispatch_6004.csv` / `_6005.csv`：ATT stats CSV（standalone gemm1，bm32，xcd0）。原始 trace 约 433 MB，没有保存。
- `att_an_gemm1_dispatch_6004.txt` / `_6005.txt`：`att_an.py` 的输出。

# fused_ar_att：融合 kernel 的 thread trace（ATT）分析

## 结论（TP4，512 tokens，c64 ch256；ATT 会拖慢执行，只看比例）

- **compute wave**（每个生命周期中位数 6.87 us）：prologue 7%，主循环 73%（其中 VALU 2.1 us、等 vmcnt 1.4 us），epilogue atomic 12%（其中等 vmcnt 0.57 us），tile hook 7.5%。
- **comm wave** 依次处理 unit，每个 unit 约 5 us，主要是三次往返：
  - 等 chunk 完成，约 4.3 us；
  - RS 远端写确认，1.03 us；
  - 等 rs flag，0.94 us；
  - AG 远端写确认，1.1 us；
  - 每个 unit 重新读 peer 基址和 tbl，约 0.6 us。
- 当时列出的改进点：
  1. 按指令数估算 gemm2 是 VALU 瓶颈：每个 wave 437 条 VALU，MFMA 只有 24 条，fp4 解码约 280 条；
  2. epilogue 的 token id load 在 atomic 之后才被使用，`vmcnt` 等待把各组 atomic 串行化；
  3. tile hook 里的 tbl 读取和 barrier；
  4. comm unit 的往返。
- **后续实测**（`../fused_ar_opt_ab`）：第 2、3、4 点都已消除，ISA 上确认生效，但端到端几乎没有收益；精简 VALU 也没有变快。说明这些等待会被同 CU 上的其他 wave 掩盖，**按指令数估算的 VALU 占用不能直接说明瓶颈**。

## 实验

`att_analyze.py <ui_output_dir>`：

- 按 wave 执行过的代码把它分成空 tile / gemm / comm 三类；
- 按代码区域（prologue、主循环、epilogue atomic、tile hook、comm）统计每类 wave 的耗时（以 issue 到下一条 issue 的间隔计）；
- 输出 wave 生命周期、每个 CU 上的驻留时间线、最耗时的指令。

```bash
rocprofv3 -i trace.yaml -- torchrun --nproc_per_node=4 doc-mimo/kernels/gemm2_ar_fused.py 512
python doc-mimo/experiments/fused_ar_att/att_analyze.py ck_test/ui_output_agent_<pid>_dispatch_<id>
```

## 结果（`results/att_fused_tp4_512.txt`）

trace `ui_output_agent_52389_dispatch_3909` 的分析输出：每个 SE 采 CU0，共 632 个 wave，按 1703 cycle/us 换算。原始 trace 没有保存。

注意：当时的 `make_case` 写死了 I=256，所以 TP4 下跑出来的仍是 TP8 的每卡 shape。完整的表格见 `moe-new-tp.md` 后半部分第 10 节。

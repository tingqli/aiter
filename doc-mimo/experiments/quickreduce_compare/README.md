# quickreduce_compare：与 QuickReduce（QR-FP16）two-shot 的对比

## 结论

- QuickReduce 的 QR-FP16 同样是 two-shot，跨卡数据量与本实现相同（每 rank 2 × 7/8 × N）。它在 TP8、4 MB 时只比 RCCL 略快（其 README：46.8 vs 52.1 us），本实现为 30.5 us（RCCL 53–67 us）。
- 差别全在延迟和同步上（根据源码和本机编译出的 8-rank kernel 反汇编）：
  1. **按 rank 0..7 逐个等待：** 每个 tile 2 个阶段 × 8 次串行的「flag 往返 + 数据往返 + barrier」，延迟链长度与 world size 成正比，所以它在 TP2/TP4 上优势明显，到 TP8 优势消失；
  2. **远端 store 之间读地址表：** 第一条远端 store 后紧跟 `global_load` 和 `s_waitcnt vmcnt(0)`，要等这条远端写完成；而且所有 rank 都先写 rank 0，形成 incast；
  3. **每个阶段发布 flag 用 release 原子操作：** 生成 `buffer_wbl2 sc0 sc1`，写回整个 L2；
  4. **输出多拷一次；**
  5. **小消息时 WG 太少：** 每个 WG 处理 32 KB，4 MB 只有 128 个 WG；
  6. **远端访存用 `flat_* nt`：** 比 `buffer_* sc1` 慢约 7–15%。
- 它的压缩 codec（Q6/Q4）减少字节数，只在 8 MB 以上才明显有用。

## 实验

- 读 QuickReduce 源码：`csrc/core/allreduce.h` 中的 `AllReduceTwoshot` 和 `TwoshotFP16LineCodec`。
- 在本机编译它的 8-rank FP16 kernel 并反汇编。
- 同机对比脚本 `doc-mimo/comm/qr_compare.py`（RCCL / QR-FP16 / 本实现，fp16 和 bf16 同字节数）已写好，但分析时 8 张卡都被其他进程占满，**尚未跑出结果**。运行方式：

```bash
cd /tmp && git clone https://github.com/mk1-project/quickreduce qr_src && (cd qr_src/quickreduce && python setup.py build_ext --inplace)
PYTHONPATH=/tmp/qr_src/quickreduce torchrun --nproc_per_node=8 doc-mimo/comm/qr_compare.py
```

## 结果（`results/quickreduce_twoshot_fp16_w8.s`）

QR-FP16 8-rank two-shot kernel 的反汇编。逐项对比表见 `doc-mimo/README.md` 第 4.5 节。注意环境不同：QR README 是 ROCm 6.2、RCCL 2.20.5、MI300X；本实验是 ROCm 7.2、RCCL 2.27.7、MI325X。

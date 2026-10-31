# comm_peer_atomic：gemm2 写回时直接跨卡 atomic

## 结论

- **跨卡 bf16x2 atomic 能正确累加**（8 个 rank 全部 = 144），但只在 kernel 边界加 host 同步的条件下验证过。
- **速度很慢：** agent scope、发往 8 个 rank 时，每 rank 跨卡带宽约 **105 GB/s**；system scope 只有约 14 GB/s。
- **作为 all-reduce 方案不可行。** atomic 按路由行发，不是按 token，每个 rank 发出的数据量 = topk × (npes−1) × 输出大小；512 tokens 时约 224 MB，按 105 GB/s 约需 2.1 ms。

## 实验

脚本是 `doc-mimo/comm/peer_atomic_probe.py`（属于 comm/ 组件，没有移动）：

- 每个 rank 分配 4 MB 的 symmetric buffer，通过 HIP IPC 映射 peer 的 buffer；
- 每个 rank 向自己和其余 7 个 rank 的 buffer 的每个元素做 bf16x2 atomic 加 (rank+1)；
- 分别测 agent / system 两种 scope、1 / 8 个目标 rank。

```bash
torchrun --nproc_per_node=8 doc-mimo/comm/peer_atomic_probe.py
```

## 结果（`results/comm_peer_atomic_probe.txt`）

| scope | 目标 rank 数 | 结果 | 每次 launch | 跨卡总带宽（每 rank） |
|---|---|---|---|---|
| agent | 1 | 正确 | 6.4 us | — |
| agent | 8 | 正确（=144） | 279 us | 约 105 GB/s |
| system | 1 | 正确 | 21 us | — |
| system | 8 | 正确 | 2045 us | 约 14 GB/s |

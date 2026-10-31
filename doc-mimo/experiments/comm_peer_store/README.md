# comm_peer_store：跨卡普通 store / load 带宽

## 结论

- **由发送方 push，并用 `sc1`：** 每 rank 发往 7 个 peer 的总带宽约 **263–321 GB/s**，即每条链路约 45 GB/s。pull 只有 push 的约三分之一（87–119 GB/s）。
- **默认 cache 策略的 push 在大数据量时会崩：** 16 MB 时只有 44 GB/s。
- **发送目标要交错：** 同一时刻所有 WG 都写同一个 peer 时，只用到一条链路，带宽偏低且随数据量变差（第一版 4 MB 时 80 GB/s）。改成相邻 WG 轮流写不同 peer 后才正常。
- 由此估算 512 tokens 时 all-reduce 方案的跨卡传输量与耗时：

  | 方案 | 每 rank 发出 | 估算耗时 |
  |---|---|---|
  | 逐路由行 atomic | 224 MB | 约 2 ms |
  | one-shot push | 28 MB | 约 92 us，比 RCCL 慢 |
  | two-shot | 2 × 3.5 MB | 约 27 us 加同步，**可行** → `../twoshot_tp_allreduce` |

## 实验

脚本是 `doc-mimo/comm/peer_store_probe.py`（没有移动）：8 个 rank 同时互相发送，每个线程一次 dwordx4。对比本卡拷贝、push（默认 / `sc1` / `sc0|sc1`）和 pull，每个 peer 的数据量为 512 KB–16 MB。

```bash
torchrun --nproc_per_node=8 doc-mimo/comm/peer_store_probe.py
```

## 结果（`results/comm_peer_store_probe.txt`）

v1（按目标卡顺序排列 WG）和 v2（交错，现在存档的版本）的原始输出。v2 中每 rank 的总带宽（GB/s）：

| 每个 peer 的数据量 | 本卡拷贝 | push 默认 | push `sc1` / `sc0\|sc1` | pull |
|---|---|---|---|---|
| 512 KB | 824 | 229 | 263–271 | 87–118 |
| 1 MB | 917 | 236 | 295 | 90–93 |
| 4 MB | 1282 | 232 | **321** | 110–112 |
| 16 MB | 1941 | **44** | 305–311 | 94–119 |

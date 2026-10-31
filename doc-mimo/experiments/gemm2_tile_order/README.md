# gemm2_tile_order：gemm2 的 tile 顺序与输出 chunk 何时完成

## 结论

- 要把 all-reduce 和 gemm2 重叠，输出的列 chunk 必须一块接一块地完成。现状的 m-major 顺序（`m`）下，8 个 512 列 chunk 全部在 kernel 时长的 97–100% 才完成，**没有可重叠的窗口**。
- 新顺序 **`g`**（按 `CHUNK_N` 列分组依次发射，组内 m-major，保留按 XCD 连续的映射）让 chunk 依次完成（约 17–27% / 30–41% / … / 100%），代价只有 **+2 至 +5 us**。这是 gemm2 + all-reduce 融合（`../fused_ar_*`）的基础。
- 其他顺序：
  - `n`（列优先 + XCD 映射）：chunk 仍在 98–100% 才完成，因为 XCD x 正好负责 chunk x，还多花 +3 至 +14 us；
  - `nx`（列优先、不做 XCD 映射）：chunk 依次完成，但 2048 tokens 时 +40 us（丢了 L2 局部性）。

## 实验

`g2_order_probe.py`：`ORDERS=m,n,nx,g`，128 / 512 / 2048 tokens 各跑两次。

- 计时，并检查结果误差；
- 带 `PROBE` 再跑一次：每个 WG 的线程 0 在开始和 atomic 完成后各写一个 `s_memrealtime` 时间戳，由此算出每个 512 列 chunk 最后一个 tile 结束的时刻，占 kernel 时长的百分比。

```bash
ORDERS=m,n,nx,g python doc-mimo/experiments/gemm2_tile_order/g2_order_probe.py
```

## 结果（`results/g2_order_probe.txt`）

- 耗时（单位 us）：128 tokens 时 m 44.9–46.2、nx 47.1–48.5、g 48.0–50.8；2048 tokens 时 m 140.7、nx 179.3、g 146.5。
- 每种顺序下各 chunk 的完成时刻。

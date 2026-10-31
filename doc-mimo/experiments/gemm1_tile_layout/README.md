# gemm1_tile_layout：按 WG tile 重排 W 的布局

## 结论

- 实现了 `w_layout="tile"`（`test_a8w4_gemm1.py` 里的 `retile_w1`）。结果与标准布局**逐位一致**，但**没有稳定收益**：
  - tn128 时 196.0 vs 195.9 us；
  - 两次重复里 tile 布局反而慢 0–13 us，在噪声范围内或更差。
- 原因：在纯读测试里，这种布局能把上限从约 3.4 提到约 3.9 TB/s（`../gemm1_read_pattern`）。但实际 kernel 只有约 3.0 TB/s，被 VALU 发射卡住（`../gemm1_att_bottleneck`），根本没碰到访存布局的上限。
- 快速解码之后再复测，tile 布局依然没有稳定收益（`../fast_decode/results/fd_gemm1_bench.txt`）。所以生产路径用标准布局，tile 布局保留为默认关闭的选项。

## 实现

`retile_w1(w1_u8, w1_scale_u8, num_experts, inter_dim, model_dim, tile_n, tile_k)`：

- **W**：以 1 KB 为单位（一个 n16 块 × 一个 128-K 组），从标准的 `[E][gu][NB][TILE_N/16][K/TILE_K][TILE_K/128]` 重排为 `[E][NB][K/TILE_K][gu][TILE_N/16][TILE_K/128]`。这样每个 (expert, n-block, K-tile) 是一块 32 KB 连续，gate 和 up 在同一块里。
- **scale**：以 256 B 为单位，重排为 `[E][NB][K/256][gu][TILE_N/32]`，每个 K-tile 的 2 KB 连续。
- **kernel**：`w_layout="tile"` 时只改 `w_base` / `sc_base` 和每个 K-tile 偏移的计算方式，每条 wave 指令仍然读连续的 1 KB。kernel 名带 `_wt`。

## 实验

`tile_layout_bench.py`：512 tokens、E=256、inter 512。对比 standalone 的标准布局和 tile 布局（bench 候选 `a8w4_tile`，并断言 `tile bitexact`）：先扫 tn × `b_cache_mod`，再做两次重复（bm32 tn128、bm32 tn64、bm64 tn128 dyn_m）。

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim python doc-mimo/experiments/gemm1_tile_layout/tile_layout_bench.py
```

## 结果（`results/tile_layout_bench.txt`，单位 us）

| 配置 | 标准布局 | tile 布局 | 逐位一致 |
|---|---|---|---|
| tn128，bcm2 | 195.9 | 196.0 | ✓ |
| tn128，bcm1 | 211.7 | 214.0 | ✓ |
| tn64，bcm2 | 190.0 | 195.8 | ✓ |
| 重复：bm32 tn128 | 192.1–193.2 | 204.8–206.2 | ✓ |
| 重复：bm32 tn64 | 186.8–187.5 | 197.6–202.0 | ✓ |
| 重复：bm64 tn128 dyn_m | 191.0–198.8 | 197.4–204.1 | ✓ |

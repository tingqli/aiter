# gemm1_cache_modifier：W 读取的 cache 策略

## 结论

- W 的 buffer load 用 **nt**（`b_cache_mod=2`）最快：tn128 时从 210–214 us 降到 **195.7 us**（约 −7%），tn64 时降到 **191.8 us**。
- W 每个元素只读一次，用 nt 可以少占 L2，把 L2 留给 A 等会被重复读的数据。
- 因此 `bench_a8w4_gemm1` 的 `b_cache_mod` 默认值已改为 2。port 加 nt 也会变快：231 → 211 us。

## 实验

`bcm_sweep.py`：512 tokens、E=256、inter 512、bm32。扫 `b_cache_mod`（0 = 默认，1 = sc0，即原来的值；2 = nt）和 `tile_n`（128 / 64）。standalone 和 port 都跑；standalone 的误差每组都是 0。

```bash
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim python doc-mimo/experiments/gemm1_cache_modifier/bcm_sweep.py
```

## 结果（`results/bcm_sweep.txt`，单位 us）

| 配置 | standalone | port |
|---|---|---|
| tn128，bcm0 | 213.8 | 233.2 |
| tn128，bcm1 | 210.3 | 231.0 |
| **tn128，bcm2** | **195.7** | 211.5 |
| tn64，bcm1 | 213.5 | 246.0 |
| **tn64，bcm2** | **191.8** | 213.5 |

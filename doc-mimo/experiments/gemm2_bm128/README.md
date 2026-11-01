# gemm2_bm128：BM=128、低 occupancy、靠指令流水的 gemm2（独立源码）

## 结论

**结果**

| tokens | 原 gemm2（bm64） | bm64 NTILE（nt4，direct64） | **bm128（nt8）** | 只算不写回（bm128 nt8） | atomic 带宽下限 |
|---:|---:|---:|---:|---:|---:|
| 2048 | 142.7 | 133.8 | 150.9（nt4：144.8） | 116.0 | 89.6 |
| 4096 | 247.8 | 233.4 | **240.5** | — | 178.0 |
| 8192 | 457.8 | 437.2 | **424.9**（1.08x） | 279.0 | 352.0 |
| 16384 | 900.8 | 835.4 | **774.4**（1.16x） | 498.2 | 701.2 |

（单位 us，结果都正确，cos diff 9.4e-6。"atomic 带宽下限"取自 [atomic_bw](../atomic_bw/)：同样的 scatter 写出量，只跑 atomic 时的耗时。）

- **BM=128 版本可用**，≥8192 tokens 时是目前最快的 gemm2：比原版快 8–16%，比 bm64 NTILE 快 3–7%。≤4096 tokens 时与 bm64 持平或略慢。
- **计算已经快于写出。** 不写回时 8192 tokens 只要 279 us（MFMA 约 985 TFLOPs，约为功耗墙下峰值的 66%），16384 tokens 只要 498 us，都低于 atomic 带宽下限（352 / 701 us）。
- **大 token 的 gemm2 现在由 atomic 吞吐决定**，实测约 1.3 TB/s。这个下限 bm128 已经贴近（下限 + 70 us），再优化计算只能缩小剩余的重叠损失。
- **换 atomic 作用域没用。** 让输出列与 XCD 绑定（每列只由一个 XCD 写）、并用 workgroup scope 让 atomic 留在 L2，测得吞吐不变（[atomic_bw](../atomic_bw/) 第 4 部分），说明 1.5 TB/s 是 atomic 本身的硬上限。
- **想再快，只能减少写出的字节数，或者换写出方式。** [atomic_bw](../atomic_bw/) 的估算仍然成立：store + reduce 在大 token 上不划算。下面实测验证了这一点。

### 编译期开关 `OUT_MODE="sorted"`：按 sorted 顺序 store，再用 sorted_sum 做 reduce

思路参照 pyhip 的 `moe_gemm_2stage/moe_reduce.py`：

1. **gemm2**：把每行（已乘 route weight）用 bf16x2 store 写到 `routes[sorted_pos]`。一个 block 的 128 行在 routes 里是连续的行，kernel 不需要 token id，也不需要 padding 判断。
2. **`invert_sorted_ids`**：生成 `loc[token, slot] = sorted_pos`。
3. **`sorted_sum`**：`out[t] = Σ_k routes[loc[t, k]]`。每个 lane 处理 16 B，用 f32 累加。

这种方式 `out` 不需要清零，精度也更好（cos 3.4e-6，atomic 为 9.4e-6）。

| tokens | atomic（nt8） | sorted 合计 | 其中 gemm2（store） | invert | sorted_sum | sorted / atomic |
|---:|---:|---:|---:|---:|---:|---:|
| 2048 | 146.6 | 183.4 | 148.7 | 2.5 | 32.5 | 0.79x |
| 4096 | 249.4 | 279.4 | 212.5 | 2.8 | 65.0 | 0.89x |
| 8192 | 429.2 | 544.3 | 368.2 | 3.4 | 165.6 | 0.85x |
| 16384 | 784.3 | 1023.1 | 659.9 | 4.3 | 337.0 | 0.89x |

- **所有档位 sorted 都更慢。** sorted_sum 要读回 topk 份 routes（8192 tokens 约 537 MB 读 + 67 MB 写，约 3.6 TB/s），这一步无法与 GEMM 重叠，单独就占 166 us。
- **即使 store 不额外耗时也赢不了。** 8192 tokens 时 gemm2 只算不写回是 279 us，加上 sum 和 invert 也有 279 + 166 + 3 = 448 us，仍然慢于 atomic 的 429 us。
- **store 本身也有开销**：8192 tokens 时 gemm2 从 279 涨到 368 us。原因是每条 store 指令只写 4 B/lane，且每行 64 B 一段。
- **routes 行间 padding 无效**：加 128 B 或 256 B（参照 pyhip 的 `row_padding_bytes`，用来把同一列被 gather 的几行分散到不同 HBM channel），各项耗时不变。
- **结论：保留 atomic。** 只有当 topk 求和能并入一个本来就要读这份数据的后续 kernel 时，sorted 才可能占优；TP8 下唯一的候选是 all-reduce，而 [fused_ar_route](../fused_ar_route/) 已经测过，整体反而更慢。

## 设计（`doc-mimo/kernels/test_a8w4_gemm2_bm128.py`）

与 `test_a8w4_gemm2.py` 那种靠高 occupancy 遮延迟的思路分开实现。资源按 **每 SIMD 1 个 wave** 设计（`waves_per_eu=1`，最多可用 512 VGPR）：

- **A 直接进 VGPR。** 128×256 fp8 按 MFMA 操作数布局从 global 加载，每 lane 128 个 VGPR，每个 CTA 加载一次。不用 LDS（LDS = 0）、没有 barrier，MFMA 循环里也没有 ds_read。
- **N 方向 1×4 切分。** 每个 wave 负责全部 128 行、32 列，一个解码后的 W 片段喂 8 条 MFMA（bm64 时是 4 条），解码 VALU / MFMA 比降到一半。
- **CTA 内的指令流水。**
  - 一个 CTA 处理一个 m-block 和相邻的 NT 个 n-tile。
  - W、scale、max code 的加载提前 2 个 tile 发出。
  - 上一个 tile 的 epilogue 拆成 8 块，交错进当前 tile 的 8 个 K step：第 ku 步顺带做上一 tile 第 mi = ku 块（16 行）。为此两套累加器同时存活。
- **行数据。** ratio（s0/s1）、fin（s1×w）和 sorted id 先按 lane 分布加载（lane L 存第 L 行和第 64+L 行）。每个 CTA 用 ds_bpermute 把每个 lane 需要的 4×8 行取到 VGPR 一次，所有 n-tile 共用。
- **精简的 epilogue。**
  - bf16 用整数 RNE 转换（每个值 2 条 VALU，输入为有限值），再用 `v_perm` 把两个 block 的值打包。
  - 用一条 DPP quad_perm 交换相邻 lane，再用一条按 lane 选择器的 `v_perm` 完成配对：16 个 lane 覆盖 32 列，每行 64 B 连续（满速 atomic 需要至少 64 B，32 B 只有一半吞吐）。
  - 行地址偏移每个 CTA 预计算一次；atomic 用 SGPR base + 零扩展的 32 位偏移（`global_atomic_pk_add_bf16 v, v, s[..]`），每条 atomic 不需要 VALU 算地址。
- **dyn_rows**：第 64 行以后全是 padding 的 block 走 64 行变体。
- **限制**：K = 256，tile_n = 128，fast_dec = 2，A scale 按 (行, 128) 分组，sorting 的 block_m 必须是 128。
  - 后两项意味着 gemm1 也要按 128 排序。之前的 e2e 测试里 gemm1 在 bm128 下更慢，所以接入前要让 gemm1 支持"按 128 排序、以 64 行为 tile"（同一个 128 行 block 内专家相同，可以安全拆成两个 64 行 tile）。

## 迭代过程（8192 tokens，nt8）

| 版本 | VGPR | 每 tile 每 wave 的 VALU | us | 说明 |
|---|---:|---:|---:|---|
| v1 | 352 | 803 | 531 | bf16 转换带 NaN 处理、配对用 ds_swizzle + 3 个 select、每个 tile 用 bpermute 取行数据、64 位地址运算 |
| v2 | 438 | 521 | 412–425 | 上面"精简的 epilogue"和"行数据只取一次" |

v2 的 ATT（`results/` 未保存原始 trace）：
- 每 tile 每 wave 约 7.4k cycle，其中 MFMA 1.3k、`s_waitcnt` 0.77k；
- atomic 的发射约 0.72k cycle，每条约 28 cycle，被内存管线反压，与 1.3 TB/s 的 atomic 吞吐相符；
- 每条 atomic 的 padding 判断分支（s_and_saveexec / cbranch / s_or）约 0.6k cycle。

## 实验

```bash
# atomic 与 sorted（store + invert + sorted_sum）对比，输出各阶段耗时；--pad 设置 routes 行间 padding
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/kernels/test_a8w4_gemm2_bm128.py -t 2048 4096 8192 16384 --nt 8 --mode atomic sorted [--pad 0 128 256]
PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim \
  python doc-mimo/kernels/test_a8w4_gemm2_bm128.py -t 2048 4096 8192 16384 --nt 4 8 16 32
# 只算不写回（消融，必须使用独立的缓存目录）
G2_NO_ATOMIC=1 FLYDSL_RUNTIME_CACHE_DIR=/tmp/g2na PYTHONPATH=... python doc-mimo/kernels/test_a8w4_gemm2_bm128.py -t 8192 --nt 8
```

## 结果

`results/sweep.log`（NT 扫描），`results/sorted_vs_atomic.log`（atomic 与 sorted 对比）。

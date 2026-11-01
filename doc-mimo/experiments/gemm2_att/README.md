# gemm2_att：大 token 下 gemm2 的 ATT 分析

## 结论

trace：8192 tokens，bm64、tile_n 128，dyn_rows，fd2，a_group 128（`dispatch_6856`）。每个 SE 采 CU0。下面以 1724 个真实 wave 的平均值为准：每个 wave 平均 17.7k cycle，每个 CU 同时有 16 个 wave（4 个 WG）。

- **gemm2 在大 token 下既不是带宽 bound，也不是 compute bound，而是延迟 bound。**
  - VALU 发射口的中位占用只有 48%；MFMA 每个 wave 只有 64 条，在 wave 时间中占比不到 5%。
  - 访存只有约 0.5 TB/s。
  - 但 wave 时间的 35% 花在 `s_waitcnt vmcnt` 上，而且几乎都是**串行**的单次访存延迟（每次 500–850 cycle）。
- **占用率被 LDS 限制在每 CU 4 个 WG。** 每个 WG 用 16 KB LDS（A tile 和 bf16 staging tile 取较大者），64 KB / 16 KB = 4；VGPR 只有 74，本身不是限制。所以每个 SIMD 只有 4 个 wave，不足以掩盖串行等待。

每个 wave 的阶段分解：

| 阶段 | cycle | 占比 | 主要成分 |
|---|---:|---:|---|
| prologue（expert id、scale、exp） | 1716 | 9.7% | vmcnt 584 |
| A → LDS staging + W 加载 | 3454 | 19.5% | **vmcnt 2871：4 次 A 加载串行，load→wait→ds_write，循环 4 遍** |
| decode + MFMA + dequant | 3483 | 19.7% | lgkmcnt 811（ds_read 后立刻用于 MFMA），barrier 442 |
| epilogue 加载 + bf16 写入 LDS | 5138 | 29.0% | **vmcnt 2561：sorted id / A scale / route weight 在计算之后才发出，且按 4 个 16 行块串行** |
| barrier + LDS 读 + atomic | 1935 | 10.9% | lgkmcnt 597，barrier 212 |
| `s_endpgm`（等 atomic 排空） | 1241 | 7.0% | wave 退出前要等所有 atomic 完成，期间仍占着槽位 |
| 其余行变体（dyn_rows 16/32/48 行） | 751 | 4.2% | — |

**串行等待的原因。** A staging 和 epilogue 用的都是 `buffer_load` intrinsic，LLVM 认为它可能与 LDS store（`ds_write`）别名，所以不能把后面的 load 提到前面的 `ds_write` 之上：
- `store_a_tile` 里每次 load 后紧跟一次 `ds_write`；
- `_atomic_bf16_epilog` 在 `M_CHUNKS` 循环里先 load route weight，再写 LDS。

结果 ISA 里就是 load → wait → ds_write，重复 4 遍。

## 改进点（按收益排序）

1. **在源码里手动提前发出所有加载**，预计可省约 4.5k cycle/wave，接近 wave 时间的 25%。
   - A staging 改成两阶段：先把 4 个 `buffer_load_dwordx4` 全部发出（多用 16 个 VGPR），再一次性 wait 并写入 LDS。约省 2000 cycle。
   - sorted id（8 个）、A scale、route weight（16 个）都与计算无关，应在 kernel 开头和 A/W 一起发出（约 30 个 VGPR）。约省 2500 cycle。
2. **在 MFMA 循环里提前一个 K step 发出 `ds_read`**（软件流水），覆盖约 800 cycle 的 lgkmcnt 等待。
3. **提高占用率或做跨 tile 重叠。**
   - 让 A tile 和 bf16 staging tile 不同时占用（例如 epilogue 直接用寄存器做 shuffle），或者降低 staging 精度/尺寸，使每个 CU 能放下 5–6 个 WG。
   - 或者用常驻 WG：在当前 tile 的 epilogue 和 atomic 排空期间（共 18%），预取下一个 tile 的 A/W。
4. `s_endpgm` 排空的 7% 和 atomic 阶段的 11%，属于[moe_token_scaling](../moe_token_scaling/)中"不写回快 35%"的那一部分；第 1、3 点能把其中大部分与其他 WG 的主循环重叠起来。

## 实验

```bash
rocprofv3 -i trace.yaml -- python3 doc-mimo/kernels/test_a8w4_gemm2.py \
  -s 4096,256,256,8 -t 8192 -r uniform --tile 64,128,1      # trace.yaml: kernel_include_regex (.*gemm2.*)
D=ck_test/ui_output_agent_21650_dispatch_6856
python3 doc-mimo/experiments/gemm1_att_bottleneck/att_gemm1.py $D      # 驻留、各类指令耗时、热点指令
python3 doc-mimo/experiments/gemm1_att_bottleneck/att_simd_issue.py $D # 每个 SIMD 的 VALU 发射占用
python3 doc-mimo/experiments/gemm2_att/att_listing.py $D > listing.txt # 每条指令的执行次数和 cycle
python3 doc-mimo/experiments/gemm2_att/att_blocks.py listing.txt       # 按基本块汇总
```

## 结果（`results/`）

- `att_6856.txt`：`att_gemm1.py` 和 `att_simd_issue.py` 的输出。各类指令耗时占比：vmcnt 34.9%、VALU 22.0%、SALU 11.7%、lgkmcnt 9.5%、MFMA 4.4%、barrier 3.9%。4 个 wave/SIMD 时，VALU 发射占用的中位数为 47.8%。
- `listing_6856.txt`：每条指令的执行次数、cycle 和 stall。
- `blocks_6856.txt`：按基本块汇总。64 行主路径（`[1581-2293]`）占 71.8%，执行 x0.95。
- ATT 由 realtime 换算出的时钟（1416 cycle/us，kernel 跨度约 371 us）不可靠，见 `../gemm1_att_bottleneck`，所以只按 cycle 比较。

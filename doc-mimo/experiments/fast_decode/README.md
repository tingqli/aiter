# fast_decode：fp4→fp8 解码优化 fd1 / fd2（gemm1 与 gemm2）

## 结论

- **做法：** 权重是静态的，把只依赖权重的解码工作提前到权重准备阶段完成，kernel 只剩最少的位运算。结果与原解码**逐位一致**。
- **VALU 指令数：**
  - gemm1 K 循环每迭代、每个 wave：529 → **323（−39%）**，其中 `v_perm` 192 → 72，`v_mul_lo_u32` 8 → 0；
  - gemm2 整个 kernel：719 → **509（−29%）**，VGPR 80 → 74。
- **耗时：**
  - gemm1（512 tokens、E=256、inter 512、bm32）：193–197 → **174 us**（3.31 TB/s）；
  - gemm2：−4% 到 −14%，例如 I512、2048 tokens、bm64 从 219.5 降到 195.2 us；
  - 端到端 `a8w4_fused_moe`（bm32）：128 / 512 / 2048 tokens 从 166.5 / 193.0 / 379.7 降到 **153.9 / 179.6 / 338.1 us**（−7% 到 −11%），比现有 `fused_moe` 快 1.39–1.75 倍。
- **为什么 VALU 少了 39%，时间只少约 10%：** fd2 运行时功耗仍在 750 W 上限，时钟约 1.03 GHz（原版约 1.06 GHz）。计算变快后单位时间搬运的数据更多，访存功耗随之上升，瓶颈从 VALU 发射变成了功耗墙（`../gemm1_power_ceiling`）。此时 gemm1 约 3.3 TB/s，已是同功耗下纯读约 3.6 TB/s 的 90%。
- **已接入生产路径：** `test_flydsl_moe_a16wfp4.a8w4_prepare_weights(..., fast_dec=2)` 是默认值。处理过的权重只能给这两个 kernel 用，port、CK 等路径不能读。

## 做法

| 级别 | 权重准备（每份权重一次） | kernel 中省掉的操作 |
|---|---|---|
| **fd1** | `prep_w1_fast_decode`：每个 dword 内把 byte j 改存 (k_j, k_{j+4})；nibble 0x8（-0）改成 0 | 拼回 K 顺序的 2 条 `v_perm`。另外，在 flush_tiny 下非零数值不会被查成 0，所以符号可以直接用位运算加上：`even = ((raw<<4) & smask) \| perm(hi, lo, raw & 0x07070707)`，`odd = (raw & smask) \| perm(hi, lo, (raw>>4) & 0x07070707)`。省掉 2 条符号 `v_perm` 和符号表的构建 |
| **fd2** | 再加 `prep_w1_predelta`：scale 字节改存 `min(通道最大值 − 组内 scale, 11)×8`；整组会被 flush 成 0 的，直接在 W 里写 0 | 查找表只剩 `v_perm`（把 delta 广播到 4 个字节）+ `sub` + `and` + `sub`，不再需要 `v_min`、`v_cndmask`、`v_mul_lo` |

细节：

- **直接在标准 preshuffle 布局上改写，不用先 unshuffle。**
  - W 字节按 `(N/16, K/128, klane 4, nlane 16, 16 B)` 排列：每 16 B 是第 `kg = k128*4 + klane` 个 32-K 组、第 `n16*16 + nlane` 列；
  - scale 字节按 `(N/32, K/256, klane, nlane, kpack 2, npack 2)` 排列：第 `n32*32 + npack*16 + nlane` 列、第 `k256*8 + kpack*4 + klane` 组。
  - 准备函数会断言由此换算出的每通道最大值与 `channel_exponents` 一致，以此校验映射。
- **gemm2（`prep_w2_fast`）：** gemm2 原本在 kernel 内部从 scale 求出每通道最大值。fd2 改写 scale 后求不出来了，所以把这些最大值（int32 [E·N]）接在 scale 数据后面，kernel 从 `arg_w_scale + WS_BYTES` 读取，不用改 kernel 参数表。
- **代码位置：**
  - `doc-mimo/kernels/test_a8w4_gemm1.py`：`fast_dec` 参数、`_fp8_lut_fast`、`_fp8_lut_predelta`、`_fp4x8_to_fp8x8_fast`、`prep_w1_fast_decode`、`prep_w1_predelta`、`prep_w1_fast`；
  - `test_a8w4_gemm2.py`：`fast_dec`、`prep_w2_fast`；
  - `test_flydsl_moe_a16wfp4.py`：`a8w4_prepare_weights`、`a8w4_fused_moe`。

## 实验

| 脚本 | 内容 |
|---|---|
| `isa_dump.sh`（调用 `isa_loop_mix.py`、`isa_mix.py`） | 导出 gemm1/gemm2 各变体的最终 ISA，统计 K 循环和整个 kernel 的指令构成 |
| `fd_gemm1_bench.py` | gemm1：原版、tile 布局、fd1、fd2、port，两次重复，并输出逐位一致标志 |
| `fd_gemm2_bench.py` | gemm2：4 种 shape × bm32/bm64，原版、fd1、fd2、port，以及各自相对参考结果的误差 |
| `fd_gemm2_bitexact_topk1.py` | gemm2 逐位一致检查。gemm2 用 bf16 原子加累加，topk>1 时结果取决于加法顺序，所以用 topk=1（每个输出元素只被加一次） |
| `fd_e2e_check.py` | 端到端：fd0 自身连跑两次的差异（原子加带来的噪声）、fd0 与 fd1/fd2 的差异，以及 gemm1 中间结果是否逐位一致 |
| （pytest） | `test_a8w4_gemm1.py -k silu`、`test_a8w4_gemm2.py`、`test_flydsl_moe_a16wfp4.py`（端到端对比 fd0 和 fd2） |

```bash
export PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim
bash   doc-mimo/experiments/fast_decode/isa_dump.sh
python doc-mimo/experiments/fast_decode/fd_gemm1_bench.py
python doc-mimo/experiments/fast_decode/fd_gemm2_bench.py
python doc-mimo/experiments/fast_decode/fd_gemm2_bitexact_topk1.py
python doc-mimo/experiments/fast_decode/fd_e2e_check.py
pytest -q -s doc-mimo/kernels/test_flydsl_moe_a16wfp4.py
```

## 结果（`results/`）

`isa_mix.txt`：

| | 原版 | fd1 | fd2 |
|---|---|---|---|
| gemm1 K 循环 VALU / 指令总数 | 529 / 645 | 377 / 490 | **323 / 438** |
| gemm1 K 循环 `v_perm` | 192 | 64 | 72 |
| gemm2 整个 kernel VALU / `v_perm` / `v_mul_lo` | 719 / 192 / 8 | 568 / 64 / 8 | **509 / 72 / 0** |
| gemm2 VGPR | 80 | 80 | 74 |

`fd_gemm1_bench.txt`（单位 us，两次重复）：

| 配置 | 原版 | tile 布局 | fd1 | **fd2** | port |
|---|---|---|---|---|---|
| E256，512 tokens，tn128 | 193.4–197.1 | 194.4–205.6 | 179.4–198.7 | **174.2–174.4** | 209–211 |
| E256，512 tokens，tn64 | 187.3–191.9 | 193.9–200.8 | 184.6–192.1 | **177.0–180.3** | 215–216 |
| E304，608 tokens，tn128 | 210.7–221.1 | 225.4–229.5 | 208.9–221.3 | **205.8–215.1** | 228–232 |

所有变体都与原版逐位一致。fd1 的波动较大，fd2 稳定。

`fd_gemm2_bench.txt`（单位 us，dyn_rows）：

| 配置 | 原版 | fd1 | **fd2** | port |
|---|---|---|---|---|
| I512，E256，512 tokens，bm32 | 103.2 | 97.1 | **95.6** | 117.1 |
| I512，E256，512 tokens，bm64 | 111.5 | 101.6 | **98.6** | 169.0 |
| I512，E304，512 tokens，bm64 | 126.5 | 112.4 | **108.3** | 195.8 |
| I256，E256，512 tokens，bm32 | 59.5 | 56.6 | **52.9** | 67.5 |
| I512，E256，2048 tokens，bm64 | 219.5 | 216.9 | **195.2** | 280.9 |

各版本相对参考结果的 cos 误差都是 9.4e-6，与原版相同。

`fd_gemm2_bitexact_topk1.txt`：I512/bm32、I512/bm64、I256/bm32 下 fd1、fd2 都与原版逐位一致。

`fd_e2e_check.txt`：fd0 自身连跑两次的 cos 差为 4.35e-6，fd0 与 fd1 / fd2 的 cos 差为 3.7e-6，处在同一噪声水平；gemm1 中间结果逐位一致。所以端到端测试用 cos < 1e-4 断言。

`e2e_and_pytest.txt`：pytest 结果 6 / 16 / 3 全部通过。端到端耗时（单位 us）：

| tokens | 配置 | fd0 | **fd2** | 现有 fused_moe |
|---|---|---|---|---|
| 128 | bm32 | 166.5 | **153.9** | 214.4 |
| 128 | bm32 fused-quant | 166.5 | **152.9** | |
| 512 | bm32 | 193.0 | **179.6** | 282.8 |
| 512 | bm32 fused-quant | 190.8 | **178.1** | |
| 2048 | bm32 | 379.7 | **338.1** | 592.5 |
| 2048 | bm32 fused-quant | 386.6 | **343.4** | |

# fmoe_single_kernel：gemm1 + gemm2 融合成一个 kernel 的 MoE

## 结论

- 融合只在 token 很少时略占优，其余情况不如 2-kernel 流程（单位 us）：

  | 场景 | 融合（bm32 / nw16 / npw16） | 2-kernel |
  |---|---|---|
  | 128 tokens | 139（bm16 / nw8 时 133.5） | 135–140 |
  | 512 uniform | 154 | 156 |
  | 512 hot | 217 | 178 |
  | 2048 | 359 | 324 |

- 瓶颈：
  - WG 总数只等于 m-block 数，约每个 CU 一个；
  - 每个 m-block 都要读完整一份专家权重（约 1.5 MB）；
  - m-block 数略多于 CU 数时会留下长尾。
- 没有收益的尝试：
  - 4 / 8 wave 的 CTA 加 `TILE_K1=128`，实现每个 CU 两个 CTA（已撤销）；
  - 用 `waves_per_eu` 强制提高占用率：寄存器溢出，慢约 2 倍（见 `../isa_snapshots`）。

## 实验

kernel 在 `doc-mimo/kernels/test_a8w4_fmoe.py`：一个 WG 处理一个 m-block，共 16 个 wave。gemm1 做流水；SiLU 结果暂存在 LDS，每行量化为 fp8（A2）；A2 常驻 VGPR；gemm2 按 slice 计算，写回暂存在 region1 和 region0 之间交替（双缓冲）。

| 脚本 | 内容 |
|---|---|
| `prof2.py "[(512,'uniform'),(512,'hot')]" "[dict(), dict(block_m=16,num_waves=8)]"` | 融合 kernel 与 2-kernel 对比计时，以及与 2-kernel 输出的误差 |
| `prof_fmoe.py <tokens>` | 融合 kernel 单独计时。`skip=True`（只跑 gemm1 部分）依赖的 `_skip_gemm2` 开关已从 kernel 中删除，脚本只作历史参考 |
| `dbg_fmoe.py` | 截获 `checkAllclose` 的两个输入，按行和列分析融合 kernel 与 2-kernel 的误差分布 |
| `chk_tk.py` | `TILE_K1=128` 变体多次运行的误差对比（这个变体已撤销） |

## 结果（`results/fmoe_prof2.txt`）

各组的原始输出：写回暂存双缓冲、4 / 8 wave 的 CTA、`waves_per_eu`、`TILE_K1=128`。汇总见 `doc-mimo/README.md` 第 3 节。

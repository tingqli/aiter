# isa_snapshots：早期各 kernel 变体的最终 ISA 与资源汇总

## 结论（`results/isa_summary.txt`）

- **gemm1（inter 256）**：
  - bm32 加流水（`_p`）为 230 VGPR（含 AGPR），每 SIMD 2 个 wave；
  - bm64 不开流水（`_s`）为 168；bm64 加 `dyn_m` 为 173。
  - 加 `waves_per_eu=3`（`_w3`）能压到 168，但有 11 个 VGPR spill。
- **gemm2**：VGPR 随 BM 增长，bm16 / bm32 / bm64 分别为 50 / 69 / 110（`dyn_rows` 再 +3–5）；LDS 为 4 / 8 / 16 KB。port 为 48 / 63 / 108。
- **单 kernel 融合 MoE（fmoe）**：
  - 4 wave 的 CTA（nw4）需要 211–301 VGPR；
  - 16 wave、A2 常驻 VGPR（`_a2r`）、写回双缓冲（`_db`）的版本为 108 VGPR；
  - 用 `waves_per_eu` 强压（`_w2` / `_w4`）会产生 40–50 个 VGPR spill，这和实测「强制提高占用率反而慢约 2 倍」一致（`../fmoe_single_kernel`）。
- **two-shot all-reduce**：72 VGPR，不用 LDS。

## 实验

ISA 导出方式：`FLYDSL_DUMP_IR=1 FLYDSL_DEBUG_DUMP_ASM=1 FLYDSL_DUMP_DIR=/tmp/fdX`，取 `*/21_final_isa.s`。kernel 命中磁盘 JIT 缓存时不会重新 dump，需要另给一个空的 `FLYDSL_RUNTIME_CACHE_DIR`。

`isa_summary.txt` 从每个 `.s` 里提取 `.vgpr_count`、`.agpr_count`、`.vgpr_spill_count`、`.sgpr_spill_count` 和 `.group_segment_fixed_size`（LDS）。

## 结果（`results/`）

- 27 份 `<kernel 名>.s`：dump 时刻的代码版本，可能与 kernels/ 当前代码不同；
- `isa_summary.txt`：资源汇总表。

kernel 名里的后缀含义：`bm`/`tn`/`tk` 是 tile 尺寸，`nw` 是每个 CTA 的 wave 数，`_p`/`_s` 表示是否开流水，`_dynm`/`_dyn` 是动态行数，`_a2r` 表示 A2 常驻 VGPR，`_db` 表示写回双缓冲，`_w<N>` 表示 `waves_per_eu`。

# fused_quant：gemm1 epilogue 融合量化 + gemm2 分组 A scale

## 结论

- **有正收益，已接入现有流程**（`a8w4_fused_moe(..., fuse_quant=True)`）：gemm1 `epilog="q8s"` 直接写 fp8 和每 (行, 128 列) 一个 scale，gemm2 `a_group=128` 读分组 scale，省掉第二个量化 kernel 和 bf16 中间结果的读写。
- 端到端各 kernel 的 GPU 时间之和（单位 us）：

  | tokens / 配置 | 现状 | 融合量化 | 差值 |
  |---|---|---|---|
  | 128 / bm32 | 162.7 | **153.0** | −9.7（−6%） |
  | 512 / bm32 | 185.8 | **180.9** | −4.9（−3%） |
  | 2048 / bm32 | 388.6 | 382.1 | −6.5 |
  | 2048 / bm64 + dyn_m | 387.3 | **371.9** | −15.4（−4%） |

- **精度：** gemm2 分组 scale 与 fp32 参考的误差和整行 scale 相同（cos diff 约 9.3e-6）；端到端 cos diff 从 1.0e-3 降到 9.6e-4（分组更细，略好）。
- **gemm2 分组 scale 的代价：** bm32 时基本没有；bm64 时多 5–8 us，因为累加器从 16 个 VGPR 翻倍到 32 个。
- 没有收益的做法：
  - 单组累加器，在组边界乘 s_g/s_{g+1}：编译器把 scale 加载和除法提到循环前，VGPR 反而从 77 涨到 89；
  - 用 `waves_per_eu=7` 把 VGPR 压到 72：慢 5–30 us。

## 实验

| 脚本 | 内容 |
|---|---|
| `e2e_fused_quant_breakdown.py` | 128 / 512 / 2048 tokens，现状与融合量化流程中各 kernel（sort、quant、gemm1、gemm2）的 GPU 时间 |
| `g2_agroup_wpe.py` | gemm2：`a_group` 0 / 128 × `waves_per_eu`，两次重复 |
| （bench） | `python doc-mimo/kernels/test_a8w4_gemm2.py -t 128 512 2048 -r uniform --tile 32,128,1 64,128,1 --a_group 0 128` |

## 结果（`results/raw_g2ag.txt`）

gemm2 bench 中 `a_group=0/128` 的 markdown 汇总表，例如：

| 配置 | `a_group=0` | `a_group=128` |
|---|---|---|
| 128 tokens，bm32 | 45.7 us | 46.6 us |
| 512 tokens，bm32 | 57.7 us | 62.0 us |
| 512 tokens，bm64 | 63.5 us | 68.9 us |

端到端拆分的数值见 `moe-new-tp.md` 前半部分第 5 节。

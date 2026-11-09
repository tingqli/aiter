# bs_moe_tp8：MiMo-V2.6 TP8 的 FP8 blockscale fused MoE（MI350X / gfx950）

代码在 `doc-mimo/kernels/bs_*.py`，入口 `bs_moe.fp8_blockscale_moe()`；kernel 从参考分支
`tq/moe_gemm_blockscale`（50ed9814c2）移植后再优化。本目录是测量脚本和原始结果。

形状（TP8 每卡，路由专家数 / topk 取自 HF config，MiMo 没有 shared expert）：flash H 4096、I 256、
256 个专家、topk 8；pro H 6144、I 256、384 个专家、topk 8。权重 FP8 e4m3fn + 128×128 FP32 block scale，
激活按 (行, 128) 量化。随机路由。（最初按参考分支 model_configs CSV 里的 257 / 9、385 / 9 测过一轮，
已全部按 256 / 8、384 / 8 重测；少数只在旧形状上做过的辅助实验会注明。）

## 结论

| case | 本实现 us | TFLOPS（% of 2540） | 参考分支最佳配置 us | 加速 | 计算下限 | 访存下限 | 各 stage 下限之和 | dense 等价 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| flash 8192 | 617 | 669（26%） | 656 | 1.06× | 162 | 423 | 423 | 441 |
| flash 16384 | 1046 | 788（31%） | 1109 | 1.06× | 325 | 685 | 773 | 883 |
| flash 32768 | 1942 | 849（33%） | 2053 | 1.06× | 649 | 1208 | 1493 | 1760 |
| pro 8192 | 969 | 638（25%） | 1021 | 1.05× | 244 | 752 | 752 | 658 |
| pro 16384 | 1654 | 748（29%） | 1726 | 1.04× | 487 | 1141 | 1197 | 1322 |
| pro 32768 | 3039 | 814（32%） | 3423 | 1.13× | 974 | 1919 | 2273 | 2628 |

- 本实现：`results/bs_moe_fused.txt`；参考分支：`results/ref_baseline.txt`，每个 case 取 Down
  为 m128p / 8wave、oc2 / oc4 中最快的（pro 32768 的 m128 因 route buffer 超过 4 GB 断言失败，只能用 8wave）。
- 计算下限 = FLOPs / 2540 TF（hipBLASLt FP8 8192³ 实测）；访存下限 = 整个流程必须读写的字节数 / 5 TB/s
  （x、a、w1、w2、a2 各一次，routes 写一次读一次，out 写一次）；各 stage 下限 = 每个 kernel 取
  max(计算, 访存) 再求和；dense 等价 = hipBLASLt 跑同形状的 dense GEMM（不 gather、不 padding、
  per-tensor scale，`results/ceiling_gemm.txt`）+ prep / reduce 的访存下限。
- **这些形状逼近不了 compute-bound：** 访存下限是计算下限的 1.9–3.1 倍。Down 输出每个 (token, slot)
  一行 H 维 BF16，写出再被 topk 求和读回，这部分流量就占到总时间的 33–44%；
  Down 的 K 只有 256，连 hipBLASLt 跑同形状的 dense GEMM 也只有 816–841 TF。
- **Down 改用 atomic 直接累加更慢**（见下面单独一节）：MI350X 的 packed BF16 atomic 上限约 1.16 TB/s，
  只有普通 store 的 1/4；只算 atomic 写出本身就比现在的 Down + reduce 整体慢 1.3–1.6 倍。
- **除 prep 外，每个 stage 实际都在 4.1–5.1 TB/s 的 fabric 带宽上**（`results/traffic.txt`）：Down 和
  reduce 已在访存下限附近；gemm1 的 L2 命中率只有 33–52%，w1 从 L2 之外重复读了 2.1–4.6 遍。
- 与各 stage 下限之和相比还差 1.3–1.5 倍，主要差在 gemm1（flash 32768：682 us，下限 433）。gemm1 处理
  的 256 行 tile 约 1700–1770 TF（pro 32768，含 padding；`g1_batches.py`），完全复用权重的上限是 gemm1
  再快 7–21%（`g1_bshare.py`）。

相对参考分支的改动和各自的收益：

| 改动 | 收益 |
|---|---|
| Down 输出按 M128 block 建 buffer descriptor（64 位 block 基址） | pro 32768 能用 M128 Down（参考分支断言失败，只能用 8wave）：−11% |
| 配置：Down oc4 + persistent；CK sort 关掉 opus；所有 workspace 预分配；invert 并入 sort stage | 与参考分支的 kernel 相同，端到端 −2~−3%（`results/bs_moe_port.txt`） |
| gemm1 epilogue 直接量化成 FP8 + (行, 128) scale（SiLU·up → 跨 lane / wave 求 amax → 1 次 barrier） | 省掉 BF16 mid 的写回和一次 quant launch：gemm1 +8~17 us，省 16~43 us |
| `bs_prep`：路由排序 + x 量化 + inverse map 合成 1 次 launch（LDS 直方图、每专家一次全局 atomic、grid barrier 藏在量化后面） | prep 比 CK sort + hip quant + invert 快 20–50 us；流水线里的 gemm1 在 6 个 case 里都慢 3–15 us（专家内行序不再按 token 递增；单独测两种顺序一样快，原因未确认），端到端净省 13–37 us |

合起来比只移植的版本快 2.0–2.8%（pro 32768 持平，在测量波动内），比参考分支快 1.04–1.13 倍。

试过但没有采用的：

- Down 用 packed BF16 atomic 直接累加到 out（`down_out="atomic"`，见下一节）：Down 阶段（含清零）是 store Down +
  reduce 的 5.5–7 倍，端到端慢 3.6–4.5 倍。
- gemm1 per-XCD 分批同步（每轮 32 个 worker 齐步开始，让同一专家的 task 共享 L2；旧形状上测）：结果逐位
  一致，但 pro 32768 的 gemm1 从 1231 变成 1390 us，撤销。（第一版用普通 buffer load 自旋，GPU 死循环，
  很可能是 LLVM 把 load 提到了循环外；改为 atomic 读后正常。`bs_prep` 的 grid barrier 也一起改成了 atomic 读。）
- gemm1 `group_size_m` 2 / 4：flash 持平，pro 16384 慢 100 us；一个 WG 一个 task（非 persistent）：
  持平或慢 1–3%；去掉 64 行空 slice 的 MFMA：±2%（流水受 barrier 限制，不受 MFMA 限制）。这几项都在旧形状上测。
- prep：每个 wave 4 行在途（不快），grid 512（更慢），256 线程（持平）。

## 为什么 Down 不用 atomic 写出

之前在 gfx942 上的 TP 实验（`../atomic_bw/`、`../gemm2_bm128/`）里，gemm2 直接 atomic 写出在 ≥8192 tokens 时
比 store + reduce 快。那里有两个前提：atomic 约 1.5 TB/s，是 store 的 1/3；A8W4 gemm2 要解码 fp4，计算本身
够长，atomic 写出大部分被计算盖住。在 MI350X 上这两个前提都不成立（`results/atomic.txt`、`results/down_out_ab.txt`）：

| 测量 | 结果 |
|---|---|
| `bench_atomic_bw.py`，Down 的写出模式 | packed BF16 atomic 1.16 TB/s，dwordx4 store 4.7 TB/s，reduce 4.4–4.5 TB/s |
| 同上，每个输出元素只由一个 XCD 更新，scope 用 workgroup | 仍是 1.16 TB/s |
| `atomic_footprint.py`，footprint 1 MB–1 GB | 1.07–1.17 TB/s：数据全在 L2 里也一样，瓶颈是 L2 的 atomic 单元，不是 miss 或一致性 |
| `atomic_lanes.py`，同样字节数、同样 atomic 条数 | 每条指令 32 lane 写满一个 128 B cache line：1.16 TB/s；8 lane 一行：0.29 TB/s。代价按请求（cache line）算，不按 lane 算 |
| `down_out_ab.py`，Down 里直接改成 atomic | Down 每个 lane 持有一行里连续 8 个 BF16，做成 packed atomic 就是 8 lane 一行，实测 0.27 TB/s：flash 8192 的 Down 1960 us（store Down + reduce 330 us） |

即使把 epilogue 改成 32 lane 写满一行（要经 LDS 或跨 lane 重排），atomic 写出本身最少也要
payload / 1.16 TB/s：

| case | atomic 写出下限 | 现在的 Down + reduce | 
|---|---:|---:|
| flash 8192 / 16384 / 32768 | 463 / 926 / 1851 us | 332 / 594 / 1129 us |
| pro 8192 / 16384 / 32768 | 694 / 1389 / 2777 us | 537 / 917 / 1748 us |

这还没算清零 out（14–58 us）。FP8 Down 的计算只要 54–325 us（2540 TF），盖不住这么长的 atomic；atomic 版每个
输出还要多做 7 次 BF16 舍入（相对误差 4.1e-3，store + reduce 是 2.6e-3）。所以保留 route buffer + reduce。
`down_out="atomic"` 留作对照，默认不用。

## 运行

在仓库根目录下（aiter 导入 `pyhip.contrib` 失败时加 `PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim`）：

```bash
# 正确性（小 shape + 6 个目标 shape，fp32 参考取 256 个 token 子集）
pytest -q doc-mimo/kernels/test_bs_moe.py
# 端到端 + 分 stage 计时（--prep aiter：CK sort + hip quant；--no-fuse：BF16 mid + aiter quant）
python doc-mimo/kernels/test_bs_moe.py --check
python doc-mimo/kernels/test_bs_moe.py --check --prep aiter --no-fuse
python doc-mimo/kernels/test_bs_moe.py --check --down-out atomic
# Down 写出方式与 oc 切分的 A/B（流水线内，交替测两轮）
python doc-mimo/experiments/bs_moe_tp8/down_out_ab.py flash 8192 16384 32768
# atomic 微基准（MI350X）
python doc-mimo/experiments/atomic_bw/bench_atomic_bw.py --sizes_mb 64 256 1024 -t 8192 16384 32768
python doc-mimo/experiments/bs_moe_tp8/atomic_footprint.py
python doc-mimo/experiments/bs_moe_tp8/atomic_lanes.py
# 参考分支（先把参考 kernel 解到 /tmp/bs_ref_pkg）
bash doc-mimo/experiments/bs_moe_tp8/make_ref_pkg.sh
python doc-mimo/experiments/bs_moe_tp8/ref_baseline.py --down m128p 8wave --splits 2 4 --warm 40
# 平台上限
python doc-mimo/experiments/bs_moe_tp8/ceiling_gemm.py
python doc-mimo/experiments/bs_moe_tp8/ceiling_bw.py
# 每个 stage 的 fabric 流量
rocprofv3 --pmc TCC_EA0_RDREQ_sum TCC_EA0_WRREQ_sum TCC_EA0_WRREQ_64B_sum -d /tmp/rp -o rw \
  --output-format csv -- python doc-mimo/experiments/bs_moe_tp8/prof_l2.py flash 8192
```

## 细节

### 1. 平台上限（`ceiling_gemm.py`、`ceiling_bw.py`、`results/atomic.txt`）

8× MI350X（gfx950，256 CU，最高 2200 MHz，FP8 满载时约 1.42 GHz），ROCm 7.2，torch 2.9.1，FlyDSL 0.3.4.1。

- hipBLASLt FP8：8192³ 2531–2552 TF（rowwise scale 2199–2213 TF）。同 gemm1 形状（M = T·8，N 512，K = H）
  2026–2116 TF，同 Down 形状（N = H，K 256）816–841 TF。
- HBM：写 4.7–5.7 TB/s，读 4.5–5.2 TB/s，copy 4.5–4.7 TB/s（≥1 GB）。256 MB 以下的数据可以留在 MALL，
  但 MALL 只比 HBM 快约 1.25 倍。
- packed BF16 atomic 约 1.16 TB/s（每条指令 32 lane 写满 cache line 时；与 scope、footprint 无关）。

### 2. 流程（4 次 launch）

1. `bs_prep`：路由排序（moe_sorting 格式，block 256）+ x → FP8 (行, 128) + scale（K-block 主序）+ inverse map。
2. `bs_gemm1`：gate|up GEMM + SiLU·up，epilogue 直接写 FP8 A2 和 scale。8 wave、256×256 tile，半 M 流水；
   底部 128 行没有路由的 block 走 128 行流水；persistent，每 CU 一个 worker。
3. `bs_down`：M128 Down，乘路由权重，按 sorted 行写 BF16 route buffer；persistent，per-XCD 工作队列；
   oc4（流水线内 A/B：flash 8192 / 16384、pro 8192 / 16384 比 oc2 快 7–28 us，32768 持平（±10 us））。
4. `bs_reduce`：按 inverse map 把每个 token 的 topk 行加起来（slot 顺序固定，结果确定）。

### 3. gemm1 分析

- **padding**：每个专家的行数补齐到 256 的倍数，末尾不超过 128 行的 block 走 half task。按处理的 tile 行算，
  有效行占 81 / 90 / 94%（flash）、67 / 89 / 90%（pro）。pro 8192 平均每专家 171 行，每个专家一个 full task，
  1/3 是 padding。half task 的耗时约为 full task 的 80%（`results/g1_balanced.txt`，合成路由）。
- **权重复用决定速度**（`results/g1_weight_reuse.txt`）：task 数和 MFMA 完全相同时，每个 task 读各自权重
  比 32 个 task 共享权重慢约 1.35 倍。实际路由下把所有 block 都映射到专家 0（结果错误，只看耗时），
  gemm1 快 7–21%，这是改善权重复用的上限。（只预热 10 次时一度测出 1.6 倍：MI350X 的时钟在前几十次
  launch 里会变，先测的一方偏慢。两个脚本现在都充分预热并交替测量。）
- **fabric 流量**（`results/traffic.txt`）：gemm1 的 L2 命中率 33–52%，L2 之外的读流量是 w1 + a 的
  2.1–4.6 倍，flash 8192 时 5.1 TB/s，已在带宽上限。pro 32768 每个专家正好 3 个 full block，每轮
  （256 个 task）约 105–120 us、每 task 从 L2 外读 1.6–1.9 MB（理想共享时 1.25 MB），处理的 tile 约
  1700–1770 TF。
- **强制同步反而更慢**（旧形状，full / half task 混合时）：每 XCD 32 个 worker 每轮齐步开始，gemm1
  1231 → 1390 us。等最慢 worker 的时间超过了 L2 复用省下的时间。
- **VGPR 已满**：fp8 输出版本 256 VGPR、14 个 VGPR spill（只在 epilogue 读回），每个 DOT 阶段 4 个 MFMA、
  每 K-tile 16 次 s_barrier。要减少 barrier（每阶段 8 个 MFMA）需要更多寄存器，等于重写 gemm1。

### 4. Down / reduce

都已在访存下限附近：Down 读写合计 4.2–4.8 TB/s，reduce 4.7–4.8 TB/s。Down 的权重和 a2 读了 1.5–2 遍
（flash 8192 读 0.44 GB，w2 + a2 只有 0.29 GB），多出的流量约占 Down 时间的 6–15%。atomic 写出的对照
见上面单独一节和 `results/down_out_ab.txt`。

### 5. prep

在流水线里 42 / 69 / 131 us（flash），57 / 100 / 194 us（pro），带宽 2.5–3.2 TB/s；其中约 15 us 是固定开销
（直方图、每专家 atomic、grid barrier、scatter）。单独连续测时快 15–31%（`results/prep.txt`）。

### 6. 后续方向

- gemm1：让同一专家的 task 稳定地同时运行（例如按专家把 task 绑定到同一 XCD 的固定 CU 组，并让 half task
  与 full task 分开调度），或者重写为每阶段更多 MFMA、更少 barrier 的流水；按上面的测量，权重完全复用
  能快 7–21%。
- prep：专家内按 token 递增排列（需要跨 WG 的稳定前缀和），看流水线里的 gemm1 是否能拿回 3–15 us。
- Down + reduce：route buffer 的写和读是结构性的流量，占总时间 33–44%；atomic 在这块卡上更慢（见上）。
  只有改变数据流（例如 token 维度分块后让 Down 直接在片上累加 topk）才能去掉，代价是权重要重复读。

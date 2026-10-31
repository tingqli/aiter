# gemm1_power_ceiling：功耗墙与真实带宽上限

## 结论

- 这台 MI325X 的整卡功耗上限是 **750 W**。gemm1 一持续运行就会撞到这个上限，gfx 时钟从最高 2.1 GHz 降到 **约 1.03–1.09 GHz**。
- 在同样的条件下，纯读 576 MB（`torch.sum`）也只有 **约 3.6 TB/s**；拷贝（读加写）约 3.6 TB/s。所以在这台机器上，memory-bound kernel 的现实上限约 3.6 TB/s，不是规格上的 5–6 TB/s。gemm1 最初的 2.7 TB/s 约为这个上限的 75–80%，而不是「只用了一半带宽」。
- 空闲一段时间后单发 kernel，并不比持续循环快：standalone 约 192 us，`torch.sum` 约 187 us。所以功耗墙不是唯一限制，HBM 本身在当前访存方式下也只能跑到约 3.2–3.6 TB/s。
- 快速解码 fd2 之后，gemm1 仍贴在 750 W 上限，时钟还略低于原版（约 1.03 vs 1.06 GHz）。这说明 kernel 已经从 VALU 受限变成功耗受限，见 `../fast_decode`。

## 实验

| 脚本 | 做法 |
|---|---|
| `gemm1_clock_probe.py <standalone\|port\|tile\|fd1\|fd2> [秒]` | 循环跑指定的 gemm1 候选（512 tokens、E=256、inter 512、bm32、tn128），同时每隔约 0.2 s 用 `amd-smi metric -c -p` 采样功耗和 8 个 XCD 的 gfx 时钟 |
| `hbm_ceiling.py` | 对 576 MB（约等于 gemm1 的权重量）做 `torch.sum`（只读）和 `copy_`（读加写），循环跑 6 s 并采样功耗和时钟 |
| `burst_after_idle.py` | 每次先空闲 0.3 s，再连发 5 次 standalone、port 和 `torch.sum`，共 15 轮，取每个位置的中位数，看降频前的单发速度 |

运行（从仓库根目录）：

```bash
export PYTHONPATH=$PWD/doc-mimo/experiments/tools/pyhip_shim
python doc-mimo/experiments/gemm1_power_ceiling/hbm_ceiling.py
for w in standalone port fd2; do python doc-mimo/experiments/gemm1_power_ceiling/gemm1_clock_probe.py $w 8; done
python doc-mimo/experiments/gemm1_power_ceiling/burst_after_idle.py
```

## 结果（`results/`）

`clock_probe.txt`（持续运行；每次耗时含 launch 开销）：

| kernel | us/launch | 功耗 | gfx 时钟（8 个 XCD） |
|---|---|---|---|
| standalone（`b_cache_mod=2`） | 196.0 | 750 W | 1031–1080 MHz |
| port | 200.9 | 749–750 W | 1050–1098 MHz |
| fd2 | 181.7 | 749–751 W | 1009–1050 MHz |

`hbm_ceiling.txt`：`torch.sum` 167.1 us，3.62 TB/s；`copy_` 334.9 us，3.61 TB/s（751 W，1275 MHz）。

- `torch.sum` 那一项只采到 3 个样本，第一个样本还在升温阶段（579 W，1502 MHz）。
- 早一次运行采到 26 个样本：读 3.62 TB/s，730 W，1271 MHz。

`burst_after_idle.txt`：standalone 192 us（3.15 TB/s），port 198–199 us，`torch.sum` 186–191 us（3.24 TB/s）。

## 注意

- 机器是共享的。每次测量前先用 `doc-mimo/experiments/tools/wait_gpu_idle.sh` 确认 GPU 空闲。
- 这个 `amd-smi` 版本的 `metric -c -p` 输出里，前 8 个 `CLK:` 是 GFX_0..7。

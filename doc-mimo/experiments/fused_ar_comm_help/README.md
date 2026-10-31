# fused_ar_comm_help：让 compute WG 顺手做通讯（ticket 协议，代码已撤销）

## 结论

- **compute WG 分担通讯会让 gemm2 明显变慢，整体更慢，不建议用。** `HELP=1` 时 2048 tokens 下 gemm2 的 tile 结束时间从 161.5 推迟到 194.2 us（+33 us）。原因：
  - 帮忙的 WG 要读 ready flag、做 ticket atomic，推送后还要等写入确认，这几步都是微秒级延迟；
  - 这段时间 WG 一直占着 CU 槽位，新的 gemm2 tile 发不进来；
  - 非常驻的 gemm2 里每个 WG 只活约 10–20 us，多出几微秒就是 10–20% 的吞吐损失。
- **为此引入的 ticket 协议本身（`HELP=0`）与 v1 基本持平。** gemm2 被拖慢得更少（2048 tokens 时 tile 结束于 161.5 vs 180 us，因为单个 ready flag 取代了轮询 32 个计数器），但瓶颈完全转到通讯：尾巴约 43 us。
- **增加 comm WG 也没用：** `HELP=0` 时 64 / 128 / 192 个 WG 结果相同（2048 tokens 时 232–237 us）。瓶颈是每个 unit 的同步延迟和各 rank 进度不一致。
- mega_moe_tp 能这么做，是因为它的 CTA 常驻，comm wave 与 compute wave 在同一个 CTA 里交错执行，不存在释放槽位的问题。

## 实验

当时的实现位于 `gemm2_ar_fused.py` 的 `tile_hook`、`_claim_box`、`_drain_one`，配置为 `ar_config(..., help=N)`，代码已撤销。做法：

1. **精确判定 chunk 完成：** compute WG 用带返回值的 atomic 给计数器槽加 1，把槽加满的 WG 再累加该 chunk 的已满槽数；把它加满的 WG 置 `ready[c] = epoch`。
2. **reduce-scatter 按 ticket 领取：** 每个 chunk 一个 ticket 计数器。compute WG 算完 tile 后，如果上一个 chunk 或自己的 chunk 已 ready，就领最多 `HELP` 个 ticket，执行对应 unit 的推送。
3. **comm WG** 先把自己 unit 所在 chunk 剩下的 ticket 领完，再做规约和 all-gather。

所有配置 bad=0。

## 结果（`results/`，64 个 comm WG，256 列 chunk，单位 us）

`gemm2_ar_help_sweep.txt`：

| tokens | 依次执行 | v1（`HELP=-1`） | `HELP=0` | `HELP=1` | `HELP=2` |
|---|---|---|---|---|---|
| 128 | 66–68 | 75.5 | 74.4 | 76.5 | 78.9 |
| 512 | 101–104 | 92.1 | 94.9 | 97.5 | 106.4 |
| 1024 | 163–166 | 134.5 | 137.2 | 147.9 | 153.2 |
| 2048 | 278–282 | 234.5 | 231.9 | 248.0 | 264.2 |

- `gemm2_ar_ticket_cwg.txt`：`HELP=0` 时 cwg 64 / 128 / 192 的对比。
- `fused_timeline_help.txt`：各 `HELP` 设置下的时间线。

完整分析见 `moe-new-tp.md` 后半部分第 7 节。

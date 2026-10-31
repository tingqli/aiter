# 融合 gemm2 + all-reduce kernel 里 comm WG 的行为（结合 ATT 反汇编）

本文结合 thread trace 的反汇编，逐段说明 comm WG 的行为，重点是两类同步：

- 它如何与同一 kernel 里的 gemm2 计算 CTA（compute WG）同步；
- 它如何与其他 rank 的 comm WG 同步。

**数据来源：**

- trace：`ck_test/ui_output_agent_56655_dispatch_3909`。
- 命令：`CHUNK=256 CWG=64 torchrun --nproc_per_node=4 ... gemm2_ar_fused.py 512`，即 TP4、512 tokens、64 个 comm WG、256 列一个 chunk、vpt=1。
- 默认开关：`EPI_DRAIN=1 TBL=s AR_HOOK=wave`。
- kernel：`a8w4_gemm2_h4096_i256_ne256_bm32_tn128_tk256_bcm2_xcd0_ftz_lds_dr_dyn_og_c256_ar4_64_1_2048_False_False_0_False_wave_ts`。
- 每个 SE 只采了 CU0。采到 2 个 comm WG，共 8 个 wave：一个在 SE0，一个在 SE2。
- 时钟按 `realtime.json` 换算为 1627 cycle/us。ATT 会拖慢执行，绝对时间只作参考。

**脚本与原始输出：**

- 时间线：`experiments/fused_ar_comm_wg/att_comm_timeline.py`，输出 `experiments/fused_ar_comm_wg/results/att_comm_timeline_tp4_512.txt`。
- 整体统计：`experiments/fused_ar_att/att_analyze.py`。
- 文中的 `#1461` 指 `code.json` 的指令序号（`stats_*.csv` 中的行号）。

---

## 1. grid 布局与角色分派

`gemm2_ar_fused.FusedGemm2AR` 启动时，grid 大小为 `cwg + sorted_blocks × N_BLOCKS`。前 `cwg`（64）个 WG 是 comm WG，其余是 compute WG。

```
#4    s_sub_i32 s44, s2, 64          ; s44 = bx - CWG（s2 = workgroup_id.x）
#24   s_cmp_lt_i32 s44, 0            ; comm WG?
#26   s_cmp_ge_i32 s44, s1           ; 或者 tile 超出有效 sorted block（空 tile）
#30   s_cbranch_vccz 3               ; 都不是：进入 gemm2 主体（#34 起）
#32   s_cbranch_scc0 2013            ; s44 < 0：跳到 comm role（#1294）
#33   s_endpgm                       ; 空 tile 直接退出
```

几点说明：

- 硬件按 bx 递增分发，comm WG 最先上 CU。
- 分发时 bx % 8 决定 XCD，所以 64 个 comm WG 均匀落在 8 个 XCD 上，每个 XCD 8 个，各占某个 CU 的一个 WG 槽位。
- comm WG 从开始到 kernel 结束一直驻留，本次约 46–54 us。
- 它与该 CU 上的 compute WG 共用 CU，而且共用同一份寄存器分配，因为两者是同一个 kernel。
- 本 trace 的 640 个 wave 中：404 个 gemm wave、228 个空 tile wave（约 0.2 us 即退出）、8 个 comm wave。

## 2. 对称 buffer 布局

对称 buffer 是 HIP IPC 映射的，每个 rank 一份，地址表 `tbl[npes]` 作为 kernel 参数传入。偏移按 `ar_layout(mmax=2048, D=4096, chunk=256, npes=4)` 计算，ISA 里能看到同样的常量：

| 区域 | 偏移 | ISA 中的常量 | 内容 |
|---|---|---|---|
| inbox | 0 | 基址本身（`s[20:23]` 等） | `[npes 源][R 行][D]` bf16：各 rank 推给本 rank 的 shard 行（reduce-scatter 的目的地） |
| gather | 16 MB | `0x1000000`（#1712 等） | `[M][D]` bf16：all-reduce 的最终结果（all-gather 的目的地），作为 kernel 输出返回 |
| rs flags | 32 MB | `0x2000000`（#1355、#1385） | `[nu][npes]` i32：`rs[q][src] = epoch`，表示 src 已把 unit q 推到本 rank |
| ag flags | 32 MB + 16 KB | `0x2004000`（#1400、#1757） | `[nu][npes]` i32：`ag[q][src] = epoch`，表示 src 已把规约好的 unit q 推到本 rank |
| cnt | 32 MB + 32 KB | `0x2008000`（#1279、#1345） | `[2 parity][16 chunk][32 slot]` i32，每个 slot 相隔 256 B：gemm2 每个 chunk 的完成计数器 |

所有 flag 都写 **epoch**（每次调用加 1，单调递增），等待条件是 `flag >= epoch`，所以不需要清零。

计数器按 epoch 奇偶分两套（`s35 = epoch`，`#1305` 的 `s_not_b32 s0, s35` 得到下一次的 parity）。WG 0（`s2 == 0`）开头把下一个 epoch 要用的那一套清零（`#1313` 和 `#1315` 两条 `buffer_store_dword ... sc0 sc1`）。之所以安全：上一个 epoch 的 kernel 已经结束（同一 stream 先后执行），下一个 epoch 还没开始。本 trace 采到的不是 WG 0，所以这两条的命中数为 0。

## 3. 工作划分：unit 与 chunk

参数：TP4、512 tokens。

- 每个 rank 负责的 shard 行数 R = 512 / 4 = 128。
- 一个 unit 是「一个 chunk 的 256 列 × RU = 8 行」：256 个线程，每个线程负责 16 B（8 个 bf16），一行 256 列正好是 32 个线程，所以 8 行。
- 每个 chunk 有 U = 128 / 8 = 16 个 unit，共 16 个 chunk，所以 NU = 256 个 unit。
- 64 个 comm WG 中，WG w 依次处理 unit q = w, w+64, w+128, w+192（主循环 `#1403–#1406`：`s_add_i32 s68, s68, 64`，`s_cmp_ge_i32 s68, s56`，其中 s56 = NU）。
- unit q 属于 chunk c = q / 16，所以 WG w 依次处理 chunk `w/16`、`w/16+4`、`w/16+8`、`w/16+12` 的各一个 unit。每个 WG 正好 4 个 unit，与 trace 一致。
- 同一 chunk 的 16 个 unit 由 16 个不同的 WG 并行处理。

每个 unit 都走一遍完整的 5 步（`unit_all`），下面按步骤结合反汇编说明。

## 4. 与 gemm2 compute WG 的同步：chunk 完成计数器

### 4.1 compute 侧：每个 wave 写完自己的 atomic 后报数（`AR_HOOK=wave`）

gemm2 的 epilogue 用 `global_atomic_pk_add_bf16` 把 tile 结果累加进本 rank 的 `moe_buf`（即 `arg_out`）。随后的 hook 反汇编如下：

```
#1233/#1239 global_atomic_pk_add_bf16 ...    ; epilogue 的最后几个数据 atomic
#1241 v_cmp_eq_u32 vcc, 0, v1                ; v1 = lane id
#1242 s_waitcnt vmcnt(0)                     ; 等本 wave 的所有 atomic 完成（平均停 677 cycle/wave）
#1245-#1251 s_mov exec / v_mbcnt / ...       ; 编译器的 atomic optimizer：只让一条 lane 去做
#1257 s_buffer_load_dwordx2 s[6:7], s[8:11], s12   ; tbl[rank]：走标量缓存（TBL=s）
#1258-#1286 ...                              ; slot 地址 = CNT + ((epoch&1)*16 + chunk)*8 KB + cnt_slot(bx)*256
#1290 global_atomic_add v2, v3, s[6:7]       ; counter[parity][chunk][slot] += 1（v3 = 活跃 lane 数，即 1）
#1293 s_cbranch_scc1 ...                     ; 回到 #33：退出
```

- `cnt_slot(bx) = (bx % 8) * 4 + (bx / 8) % 4`，对应 `#1274–#1277` 的 `s_lshl_b32 s9, s2, 2`、`s_and_b32 s9, s9, 28` 和 `s_bfe_u32 s10, s2, 0x20003`。每个 chunk 的计数分散在 32 个相隔 256 B 的 slot 上，避免所有 WG 抢同一个地址。只用一个计数器时，512 tokens 会多出约 33 us（见 `moe-new-tp.md` 第 3 节）。
- **顺序保证**：数据 atomic → `s_waitcnt vmcnt(0)` → 计数 atomic。gfx9 上无返回值的 atomic 也计入 vmcnt，所以 `vmcnt(0)` 返回时，这个 wave 的数据 atomic 都已完成。计数器加 1 就表示「这个 wave 的数据已经落地」。这里没有显式的 release fence，`vmcnt(0)` 起的就是 release 的作用。
- `wave` 模式下每个 wave 各自报数，所以一个 tile 计 4 次，comm 侧的 target 也乘 4。这样省掉了 WG 级的 `s_barrier`，wave 各自尽早退出。
- 一个 chunk 的 target = 有效 sorted block 数 × 每个 chunk 的 n-block 数（cg = 2）× 4 个 wave。对应 `#1341` 的 `s_lshl_b32 s33, s33, 3`：s33 原本是 `total_m_blocks`，左移 3 位即乘以 8 = 2 × 4。

### 4.2 comm 侧：wave 0 轮询，其余 3 个 wave 停在 barrier

每个 unit 开始时，comm WG 要等「本 rank 上 chunk c 的所有 tile 都已写回」：

```
#1431 s_and_saveexec_b64 s[44:45], vcc      ; vcc = tx < 64：只有 wave 0 进入
#1434 v_lshl_or_b32 v0, s12, 13, v4         ; 地址 = (parity*16 + c) * 8 KB + min(lane,31) * 256
#1435 buffer_load_dword v1, v0, s[16:19], 0 offen sc0 sc1   ; 每条 lane 读一个 slot（sc0 sc1：绕过非一致的缓存）
#1436 s_waitcnt vmcnt(0)
#1437 v_cndmask_b32 v1, 0, v1, s[10:11]     ; lane >= 32 置 0
#1438-#1452 ds_swizzle_b32 SWAP 1/2/4/8/16 + v_add   ; 蝶形求和
#1453 ds_bpermute_b32 (xor 32) + v_add       ; 64 条 lane 的总和，每条 lane 都拿到相同值
#1456 v_cmp_gt_i32 s[12:13], s33, v1         ; target > sum：继续等
#1460 s_sleep 1                              ; 循环体 #1460-#1485
#1461 buffer_load_dword ... sc0 sc1          ; 再读一次
#1462 s_waitcnt vmcnt(0)                     ; 每次读平均停 1074 cycle（0.66 us，未命中缓存的往返）
...
#1485 s_cbranch_execnz 65501                 ; 满足时退出循环
#1521 s_barrier                              ; wave 1-3 一直停在这里；wave 0 到达后整个 WG 放行
```

几点观察：

- **轮询一次约 1 us**：读一次 0.66 us，6 级蝶形求和每级等一次 lgkm，约 0.2 us，加上 `s_sleep 1`。所以从 chunk 最后一个 tile 报数，到 comm 发现它，延迟最多约 1 us。
- trace 中 wave 0 每个 unit 轮询 2–11 次，只有 wave 0 有轮询（表中 `polls` 列）。wave 1-3 在 `#1521` 的 `s_barrier` 上平均每个 unit 停 8103 cycle，约 5 us。等待期间它们几乎不占 issue 带宽，只是占着 wave 槽位和寄存器。
- **为什么用 sc0 sc1 读**：MI300 的 L2 按 XCD 划分，彼此不一致。计数器和 `moe_buf` 由所有 XCD 上的 compute WG 写入，comm WG 必须绕过本 XCD 的缓存，从一致点读取。之后读 `moe_buf` 也同样带 `sc0 sc1`（`#1523` 起）。

## 5. 与其他 rank 的同步：两次推送 + 两组 epoch flag

整个 all-reduce 是 two-shot（reduce-scatter + all-gather），以 unit 为粒度，由 comm WG 互相推送。数据都是**推（store）到对端**，从不跨 rank 读。

### 5.1 第 2 步：reduce-scatter 推送

```
#1523/#1524/#1528/#1531 buffer_load_dwordx4 v[..], v0, s[36:39], 0 offen sc0 sc1
                     ; 读本 rank moe_buf 中 4 个 shard 的对应行（dst_rank[i]*R + row），
                     ; 共 4 个 16 B 向量；s[36:39] = arg_out
#1533-#1539 s_buffer_load_dwordx2 ×4         ; tbl[(rank+q+i)%4]：4 个目标 rank 的基址（标量缓存）
#1545 s_waitcnt vmcnt(3)                     ; 等第一个向量（平均 542 cycle）
#1546/#1550/#1554/#1558 buffer_store_dwordx4 ... sc0 sc1
                     ; 推到 peer[i].inbox[rank][row][col]
#1559 s_waitcnt vmcnt(0)                     ; 等 4 个远端写全部确认（平均 1747 cycle，约 1.07 us）
#1560 s_barrier                              ; 整个 WG 的推送都已确认
```

- 目标 rank 按 unit 轮换：unit q 的第 i 个目标是 `(rank + q + i) % 4`，让同时进行的各个 unit 分散到不同的 xGMI 链路上。自己那份 shard 也走同样的 store 路径（目标是自己的 inbox）。
- `sc0 sc1` 的 store 是 system 一致性的 write-through。`vmcnt(0)` 返回表示写已经在目标 rank 的内存上完成，这是下一步发布 flag 的前提。

### 5.2 第 3 步：发布 rs flag，并等所有 peer 推完

```
#1561 s_and_saveexec_b64 s[52:53], s[0:1]    ; s[0:1] = tx < 4：只用 wave 0 的 lane 0-3
#1563 s_buffer_load_dwordx8 s[72:79], s[28:31], 0x0   ; 一次读出全部 4 个 tbl 项（32 B）
#1573-#1582 v_cndmask ×6                     ; lane t 选出 tbl[(rank+t)%4]
#1583-#1584 v_lshl_add_u64 ...               ; + RS 区偏移 + (q*4 + rank)*4
#1585 global_atomic_swap v[0:1], v10, off sc1   ; peer.rs[q][rank] = epoch（v10 = s35 = epoch）
#1589 global_load_dword v11, ... sc0 sc1     ; 读本 rank 的 rs[q][t]（lane t 读来自 rank t 的 flag）
#1590 s_waitcnt vmcnt(0)                     ; 平均 1141 cycle（0.7 us）
#1591 v_cmp_gt_i32 s[12:13], s35, v11        ; epoch > flag：还没到
#1595-#1601 s_sleep 1 / 重读 / ...           ; 循环体：本 trace 中命中数为 0
#1606 s_barrier                              ; wave 1-3 等 wave 0 确认（平均 1000 cycle）
```

- 4 条 lane 分别向 4 个 rank（包括自己）写 flag，然后各自检查「来自 rank t 的 flag」。
- **trace 里自旋循环一次都没有执行**：第一次读时 4 个 rank 的 flag 都已就位。原因是同一个 chunk 在各 rank 上几乎同时完成（各 rank 的 gemm 进度相近），而本 WG 自己前面还花了约 1.8 us 做推送。所以这一步的耗时（平均 0.85 us）基本就是「写 flag + 读一次 flag」的往返延迟，不是在等对端。

### 5.3 第 4 步：规约，并做 all-gather 推送

```
#1607/#1612/#1613/#1614 buffer_load_dwordx4 ... s[20:23] sc0 sc1
                     ; 读本 rank inbox[src][row]，src = 0..3（4 个来源的同一行）
#1615 s_waitcnt vmcnt(3)                     ; 平均 573 cycle
#1616-#1690 v_and 0xffff0000 / v_lshlrev 16 / v_pk_add_f32 ...
                     ; bf16 → fp32，按 rank 顺序求和（确定性）
#1662-#1711 v_bfe / v_add3 / v_or 0x400000 / v_cmp_u / v_cndmask / s_nop
                     ; fp32 → bf16，RNE 舍入，带 NaN 处理
#1693/#1697/#1699/#1714 v_perm_b32 ..., s67(0x07060302)   ; 取高半字，打包成 bf16x8
#1716/#1720/#1724/#1728 buffer_store_dwordx4 v[12:15], v7, s[12:15] sc0 sc1
                     ; 推到 peer[i].gather[rank*R + row][col]（基址 + 0x1000000）
#1729 s_waitcnt vmcnt(0)                     ; 等远端写确认（平均 1530 cycle，约 0.94 us）
#1730 s_barrier
```

规约在每个 rank 上只做一次，对象是自己 shard 的行。之后同一个结果向量推给所有 rank，包括自己。

### 5.4 第 5 步：发布 ag flag

```
#1733 s_buffer_load_dwordx8 s[44:51] ...     ; 同样一次读出 4 个基址
#1735-#1748 v_cndmask ...                    ; lane t 选出 peer (rank+t)%4
#1750-#1752 ...                              ; + AG 区偏移 + (q*4 + rank)*4
#1753 global_atomic_swap v[0:1], v10, off sc1   ; peer.ag[q][rank] = epoch
#1754 s_branch 65021                         ; 回到循环开头，处理下一个 unit
```

ag flag 在这里**只发布、不等待**。unit 之间不需要互相等待，所有等待都放到 WG 退出前统一进行。

### 5.5 退出前：等本 WG 负责的所有 unit 的 ag flag

```
#1755 s_and_saveexec_b64 s[4:5], s[0:1]      ; 只有 lane 0-3
#1761-#1763 s_add_i32 s2, s2, 64 / s_cmp_lt / ...   ; 遍历 q = w, w+64, ...
#1767 global_load_dword v2, v[0:1], off sc0 sc1     ; 读本 rank 的 ag[q][t]
#1768 s_waitcnt vmcnt(0)                     ; 每个 unit 平均 1287 cycle（0.8 us）
#1769 v_cmp_gt_i32 vcc, s35, v2
#1772-#1780 s_sleep / 重读                   ; 本 trace 中同样从未执行
#1782 s_waitcnt vmcnt(0) lgkmcnt(0)
#1783 buffer_inv sc0 sc1                     ; acquire：使 L1/L2 失效，之后才能看到 gather 的最新内容
#1784 s_endpgm
```

- 当 `ag[q][0..3]` 都等于 epoch 时，本 rank 的 `gather` 中 unit q 那 8 行已经被 4 个 rank 写全。
- 64 个 WG 合起来覆盖全部 256 个 unit，所以 kernel 结束时整个 gather（即 all-reduce 的输出）都已就绪。

## 6. 一个 unit 的完整时间线（trace 实测）

单位 us，从第一个被采到的 wave 开始计时。下表是 SE2 上的 comm WG，wave 0 在 SIMD 0 上：

| unit | 开始等 chunk | chunk 完成 | RS 写确认 | rs flag 到齐 | AG 写确认 | 本 unit 完成 | 轮询次数 |
|---|---|---|---|---|---|---|---|
| 0 | 2.7 | 15.1 | 16.5 | 17.2 | 19.1 | 19.1 | 10 |
| 1 | 20.2 | 23.6 | 24.9 | 25.5 | 28.1 | 28.1 | 4 |
| 2 | 29.1 | 30.4 | 31.8 | 32.5 | 34.1 | 34.1 | 2 |
| 3 | 35.1 | 39.5 | 41.8 | 42.9 | 46.3 | 46.4 | 5 |

退出前的 ag 等待：wave 0 用了 3.74 us，wave 1-3 只用约 0.3–0.6 us（它们不参与等待，直接退出）。该 SE 上 gemm wave 最晚在 40.0 us 结束，这个 comm WG 在 50.1 us 结束。

SE0 上的另一个 comm WG：chunk 完成时刻为 17.0、25.2、33.9、44.3；最后一个 unit 在 51.8 us 完成；wave 0 在 55.7 us 退出；该 SE 上 gemm 最晚在 43.4 us 结束。

8 个 comm wave、32 个 unit 的平均耗时：

| 阶段 | 平均 us | 范围 |
|---|---|---|
| 等 chunk（只有 wave 0 轮询，其余停在 barrier） | 6.45 | 1.3–13.7 |
| RS：读 moe_buf、推送、远端写确认 | 1.76 | 1.1–3.9 |
| RS 后的 barrier | 0.08 | 0–0.35 |
| 发布 rs flag 并等对端（实际都已到齐） | 0.85 | 0.6–1.75 |
| 规约、AG 推送、远端写确认 | 1.93 | 1.2–3.45 |
| AG 后的 barrier | 0.16 | 0–0.54 |

每个 unit 真正干活约 4.8 us，主要是 3 次远端往返：RS 写确认、flag、AG 写确认。每个 WG 4 个 unit 合计约 19 us 在干活，其余约 30 us 都在等 gemm2 产出 chunk。

## 7. 正确性依赖哪些保证

**gemm2 → comm（同一 GPU，跨 XCD）**

- 每个 compute wave：数据 atomic → `vmcnt(0)` → 计数器 atomic。
- comm 用 `sc0 sc1` 读计数器，计数达到 target 后经 barrier 放行整个 WG，再用 `sc0 sc1` 读 `moe_buf`。
- 正确性已通过 `bad=0` 和此前的计数探针（每个 chunk 都正好计满）验证。

**rank → rank**

- 推送用 `sc0 sc1` 的 store，`vmcnt(0)` 等远端确认，然后 barrier，再由一条 lane 用 `sc1` 的 `atomic_swap` 写入 flag（值为 epoch）。
- 对端用 `sc0 sc1` 读 flag，确认 `flag >= epoch` 后经 barrier，再用 `sc0 sc1` 读数据。
- 这相当于手写的 release / acquire 配对。

**跨 epoch 复用 buffer 的安全性**

- **inbox**：本 rank 的 kernel 退出前，已经等到自己 64 个 WG 所负责全部 unit 的 `ag[q][*]`。这意味着每个 peer 都已规约完每个 unit，也就读完了它们的 inbox。下一个 epoch 本 rank 往 peer inbox 推数据时，不会覆盖对方还没读的内容。
- **gather**：peer 要在下一个 epoch 往本 rank 的 gather 写 unit q，必须先收到下一个 epoch 本 rank 对 unit q 的 RS 推送，而这只能发生在本 rank 的下一次 kernel 启动之后。同一 stream 上，本次输出的消费者 kernel 先于下一次 kernel 执行，所以不会被提前覆盖。
- 这也是 `FusedGemm2AR.__call__` 返回的 gather 视图「在下一次调用前有效」的原因。
- **计数器**：按 parity 双缓冲，由 WG 0 在 kernel 开头清零另一套（见第 2 节）。

## 8. 从 trace 看到的问题与可改进点

1. **退出前逐个等 ag flag，每个 WG 多出约 3 us 尾巴。**
   - 自旋循环一次都没有执行，flag 早已就位。wave 0 却串行做了 4 次「读 flag → `vmcnt(0)`」（每次约 0.8 us），合计 3.7–3.85 us。
   - 这正好落在 kernel 的尾部：SE0 那个 WG 的最后一个 unit 在 51.8 us 完成，却到 55.7 us 才退出。
   - 改法：用 lane 0..(4×npes-1) 一次性读出本 WG 所有 unit 的 flag（4 个 unit × 4 个 rank = 16 条 lane），只等一次。
2. **最后一个 chunk 的 RS 明显变慢**：3.7–3.9 us，平时约 1.3 us。此时所有 rank 的最后一批 unit 同时推送，还要和 gemm 最后几批 atomic 抢带宽。这是尾巴的主要来源。
3. **每个 unit 有 3 次串行的远端往返**：RS 写确认约 1.07 us，读 flag 约 0.7 us，AG 写确认约 0.94 us。这些都由同一个 WG 串行执行，且 unit 之间没有流水。可以考虑：
   - 用 LL 协议（flag 嵌在数据里）去掉写确认和 flag 往返；
   - 或者在 WG 内做跨 unit 的流水：先发出 unit q+1 的 RS，再等 unit q 的写确认。
4. **rs flag 的等待实际从未阻塞**，0.85 us 全是往返延迟。可以把「写 flag」和「读 flag」拆开：写完 flag 后先去做别的（例如下一个 unit 的 RS），用到时再读。
5. **wave 1-3 闲置**：等 chunk 的约 6.45 us 里，它们一直停在 barrier 上，只占着槽位。代价不大，因为它们不占 issue 带宽，但一个 comm WG 始终占着 4 个 wave 槽位和整个 kernel 的寄存器分配。
6. 规约时的 bf16 舍入带 NaN 处理（`v_cmp_u` / `v_cndmask` / `s_nop`），每个 unit 只有 8 个值，影响可以忽略。

## 9. 按第 8 节做的改进尝试（结果：都没有收益）

结果见 `experiments/fused_ar_comm_wg/results/opt_wait_ag.txt` 和 `opt_rs_ll.txt`。条件：8 卡 TP8，c64 ch256，单位 us，每个配置都在 GPU 空闲时运行（`experiments/tools/wait_gpu_idle.sh`）。

### 9.1 退出前并行等待 ag flag（`WAIT_AG=par`，已保留为默认）

**改法：** 原来由 lane 0..npes-1 逐个 unit 读 flag。现在每条 lane 负责一个「本 WG 的第 k 个 unit × 源 rank」，即 lane `tx` 读 `ag[w + (tx/npes)*cwg][tx%npes]`，所有 flag 同时轮询，只需一次往返。前提是本 WG 的 unit 数 × npes ≤ 256，不满足时回退到逐个读。

**结果**（各 3 次，交替运行，取中位数）：

| tokens | seq（原来） | par |
|---|---|---|
| 128 | 75.5 | 76.2 |
| 512 | 90.9 | 91.4 |
| 1024 | 135.1 | 134.9 |
| 2048 | 231.1 | 231.0 |

**结论：** 没有收益。trace 中单个 rank 上那 3.7 us 的尾巴，并不是串行读 flag 本身造成的：kernel 什么时候结束，取决于最慢的 rank 把最后一批 AG 数据推完，串行读 flag 的时间被这段跨 rank 的等待覆盖了。由于没有坏处，保留为默认。

### 9.2 reduce-scatter 改用 LL 协议（`RS_LL=1`，代码已撤销）

**改法：** inbox 中每 8 B 改为「4 B 数据 + 4 B epoch」，两个包合成一次 16 B store，RS 的字节数翻倍。

- 发送端去掉了远端写确认（`vmcnt(0)`）、barrier 和 rs flag。
- 接收端读回自己 lane 的 8 个包，检查每个包里的 epoch，不是当前 epoch 就重读。
- 目的是每个 unit 省掉约 1.9 us：写确认 1.07 us，加上 flag 往返 0.85 us。
- 实现中遇到的问题：
  - 改布局时发现 rs 区的偏移原来写死成「inbox 之后两倍大小」，已改为跟在 gather 之后。这个修正保留了。
  - FlyDSL 的坑：在 `@flyc.jit` 函数体里，普通的 `range` 循环会被改写成运行时的 scf.for，必须用 `range_constexpr`；Python 层的 `if x is None` 也会被改写成带作用域的 scf.if。这类只在 trace 时执行的辅助函数要定义在 jit 函数外面。另外，运行时的 while/if 可以携带 list 形式的状态。

**结果：** 结果正确（bad=0），但大幅变慢：

| 变体 | 512 tokens | 2048 tokens | kernel VGPR |
|---|---|---|---|
| v1（原协议） | 92–93 | 230–234 | 77 |
| LL，只重读无效的包（`LL_MASK=1`） | 146 | 517 | **128** |
| LL，整体重读 | 144 | 502 | 88 |
| LL，整体重读，`WPE=6` | 148 | 520 | 80（有少量 spill，只发生在 comm 路径） |
| LL 加提示 flag（`LL_HINT=1`：发送端发出 store 后立刻写 flag，接收端先等 flag 再读数据） | 144–145 | 508 | — |
| 不同轮询间隔 `LL_SLEEP=1/8/32` | 144–146 | 502–517 | — |

**原因：**

1. **寄存器。** comm 代码和 gemm2 共用同一份寄存器分配。只重读无效包的版本要同时保留新旧两份包，使整个 kernel 的 VGPR 从 77 涨到 128，gemm2 的占用率因此下降。不过改成整体重读、或用 `WPE` 把 VGPR 压回 80 之后依然很慢，所以这不是主因。
2. **主因：接收端轮询数据，把 HBM 和互联压垮了。** 探针时间线（`fused_timeline.py`，512 tokens）：
   - gemm2 的 tile 结束时间从 72.9 us 推迟到 109–112 us，gemm2 本身被拖慢。
   - 单个 unit 的 RS 握手从约 5 us 变成约 33 us，例如 chunk 3 从 34.6 us 拖到 67.9 us。
   - LL 下接收端必须用 `sc0 sc1`（绕过缓存）去读数据本身才能判断数据是否到齐。每次轮询是 256 条 lane × 8 个包 × 16 B = 32 KB/WG，64 个 WG 就是 2 MB；而且在数据真正落地之前就开始读了。v1 只用 4 条 lane 轮询 4 个 flag。
   - 即使先等提示 flag，数据通常也还在路上（flag 在发出 store 时就写了，并不是在确认之后），所以仍然要反复读数据。
   - 再加上 RS 的字节数翻倍，与 gemm2 的 atomic 写回一起，把同一块 HBM 和 xGMI 链路压垮了。
3. LL 在 mega_moe_tp 中可行，是因为它的通讯由常驻 CTA 里大量空闲 wave 承担，轮询的是带 flag 的小包，并且 compute 和 comm 在同一个 CTA 里交替执行。本实现中 comm WG 和不常驻的 gemm2 WG 抢同一块 HBM，「用轮询代替一次往返」在这里得不偿失。

### 9.3 小结

对于第 8 节的改进点：

- 第 1 点（逐个等 ag flag）和第 3、4 点（缩短每个 unit 的往返）实测都不在关键路径上，或者代价比收益大。
- 第 2 点（最后一个 chunk 的 RS 变慢）和第 5 点（wave 1-3 闲置）没有可行的低成本改法。

结合 `moe-new-tp.md` 第 9 节的并发上限：在这种「comm WG 嵌在非常驻 gemm2 kernel 里」的架构下，同步协议这一层已经基本优化到头了。剩下能做的只有减少通讯字节（例如 fp8 传输）或者减轻 HBM 争抢。

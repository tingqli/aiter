# Mimo a8w4 实验会话记录（按时间顺序）

由 Copilot 会话 transcript 自动整理：每个用户请求下列出执行过的终端命令和助手给出的分析/结果。
注意：transcript 不保存工具的原始输出，数值结果以助手回复中的汇总为准；命令里的 /tmp/*.py 对应 experiments/scripts/。


---

## 1. 请求（2026-10-28 07:34 UTC）

> 分析一下/sgl-workspace/aiter/ck_test/ui_output_agent_12871_dispatch_16117/ 给出改进建议

命令（Aggregate the ATT stats CSV by instruction category and list top hotspots.）：
```bash
cd /sgl-workspace/aiter/ck_test && python3 - <<'EOF'
import csv,collections,re
rows=list(csv.DictReader(open('stats_ui_output_agent_12871_dispatch_16117.csv')))
print(len(rows), rows[0]['Instruction'])
tot_lat=sum(int(r['Latency']) for r in rows); tot_st=sum(int(r['Stall']) for r in rows); tot_idle=sum(int(r['Idle']) for r in rows)
print('lat',tot_lat,'stall',tot_st,'idle',tot_idle)
cat=collections.defaultdict(lambda:[0,0,0,0])
for r in rows:
    ins=r['Instruction'].split()[0] if r['Instruction'] and not r['Instruction'].startswith(';') else 'label'
    m=ins
    for p in ['s_waitcnt','buffer_load','buffer_store','global_load','global_store','ds_read','ds_write','ds_load','ds_store','v_mfma','s_barrier','v_cvt','v_pk','s_load','s_buffer','v_','s_']:
        if ins.startswith(p): m=p;break
    c=cat[m];c[0]+=int(r['Hitcount']);c[1]+=int(r['Latency']);c[2]+=int(r['Stall']);c[3]+=int(r['Idle'])
for k,v in sorted(cat.items(),key=lambda x:-x[1][1]): print(f"{k:15s} hit={v[0]:7d} lat={v[1]:9d} ({100*v[1]/tot_lat:5.1f}%) stall={v[2]:9d} idle={v[3]:8d}")
print('--- top 40 by latency')
for r in sorted(rows,key=lambda r:-int(r['Latency']))[:40]:
    print(r['Vaddr'],r['Hitcount'],r['Latency'],r['Stall'],r['Idle'],r['Instruction'][:80])
EOF
```

命令（Print compressed main-loop structure.）：
```bash
cd /sgl-workspace/aiter/ck_test && python3 - <<'EOF'
import csv
rows=list(csv.DictReader(open('stats_ui_output_agent_12871_dispatch_16117.csv')))
# print loop body (hit==128) compressing runs of plain valu
prev=None;run=[]
def flush():
    global run
    if run:
        lat=sum(int(r['Latency']) for r in run);st=sum(int(r['Stall']) for r in run)
        ops={}
        for r in run: o=r['Instruction'].split()[0]; ops[o]=ops.get(o,0)+1
        print(f"   [{run[0]['Vaddr']}-{run[-1]['Vaddr']}] {len(run)} insts lat={lat} stall={st} {dict(sorted(ops.items(),key=lambda x:-x[1])[:6])}")
        run=[]
for r in rows:
    if r['Hitcount']!='128': continue
    ins=r['Instruction']
    key=ins.split()[0]
    if key.startswith(('s_waitcnt','buffer_','ds_','s_barrier','s_cbranch','global_','s_setprio','s_sched','s_nop')) or int(r['Latency'])>3000:
        flush(); print(r['Vaddr'],r['Latency'],r['Stall'],ins[:90])
    else: run.append(r)
flush()
EOF
```

命令（Inspect trace JSON headers and GPU arch.）：
```bash
cd /sgl-workspace/aiter/ck_test/ui_output_agent_12871_dispatch_16117 && ls -la && head -c 600 occupancy.json; echo; head -c 400 realtime.json; echo; head -c 800 se0_sm0_sl0_wv0.json; echo; head -c 500 wstates1.json; echo; head -c 300 filenames.json; echo; rocminfo 2>/dev/null | grep -m2 gfx
```

命令（Inspect occupancy format and find kernel source.）：
```bash
cd /sgl-workspace/aiter/ck_test/ui_output_agent_12871_dispatch_16117 && python3 - <<'EOF'
import json
o=json.load(open('occupancy.json'))
for k,v in o.items():
    print(k,len(v), v[:3], v[-3:])
    # assume [time, slot, simd?, ..., delta]
for f in ['wstates2.json','wstates3.json','wstates4.json']:
    d=json.load(open(f)); print(f, list(d.keys()), d.get('name'), len(d['time']), set(d['state']))
EOF
cd /sgl-workspace/aiter && grep -rl "gemm1_a16w4_port_a8w4\|a16w4_port_a8w4" --include=*.py . 2>/dev/null | head
```

命令（Compute occupancy and find source.）：
```bash
cd /sgl-workspace/aiter/ck_test/ui_output_agent_12871_dispatch_16117 && python3 - <<'EOF'
import json,collections
o=json.load(open('occupancy.json'))['0']
cur=collections.Counter();mx=collections.Counter();starts=collections.Counter()
for t,cu,simd,slot,ev,_ in sorted(o):
    k=(cu,simd)
    if ev==1: cur[k]+=1; starts[k]+=1; mx[k]=max(mx[k],cur[k])
    else: cur[k]-=1
print('max waves per (cu,simd):',set(mx.values()),' waves per simd over kernel:',set(starts.values()), 'num cu',len({k[0] for k in mx}))
print('kernel span',min(x[0] for x in o),max(x[0] for x in o))
EOF
grep -rln "a16w4_port_a8w4" /sgl-workspace/aiter/aiter /sgl-workspace/aiter/op_tests 2>/dev/null | head
```

命令（Wave durations, loop instruction mix, VGPR usage.）：
```bash
cd /sgl-workspace/aiter/ck_test && python3 - <<'EOF'
import json,glob,csv,collections
for f in sorted(glob.glob('ui_output_agent_12871_dispatch_16117/se0_*.json')):
    d=json.load(open(f));w=d['wave'];print(f.split('/')[-1],w['begin'],w['end'],w['end']-w['begin'],d['num_insts'])
rows=list(csv.DictReader(open('stats_ui_output_agent_12871_dispatch_16117.csv')))
c=collections.Counter();l=collections.Counter()
for r in rows:
    if r['Hitcount']=='128':
        o=r['Instruction'].split()[0];c[o]+=1;l[o]+=int(r['Latency'])
print(sum(c.values()),'static insts in loop')
for o,n in c.most_common(25): print(f"{o:32s}{n:5d} lat={l[o]}")
print('nop total',sum(int(r['Latency']) for r in rows if r['Instruction'].startswith('s_nop')))
print('max vgpr', max(int(x) for r in rows for x in __import__('re').findall(r'v\[?(\d+)',r['Instruction'])), 'agpr', any('a[' in r['Instruction'] for r in rows))
EOF
```

这份 trace 对应的 kernel 是 `gemm1_a16w4_port_a8w4_h4096_i256_ne256_bm64_tn128_bcm1_asw_ftz_krt`，跑在 gfx942 上。配置是 K=4096、TILE_K=256，所以每个 wave 跑 16 次 K 循环，用的是 `k_loop="runtime"` 模式。共采样了 8 个 wave，每个耗时约 16–18 万 cycle。

#### 时间花在哪（8 个 wave 的累计 latency）

| 类别 | 占比 | 说明 |
|---|---|---|
| VALU（主要是 fp4→fp8 反量化） | 31.9% | 每次循环约 600 条 VALU，对应 128 条 MFMA，比例约 4.7:1 |
| `s_waitcnt`（主要在等显存加载） | 31.0% | `vmcnt(11)` 198k、`vmcnt(7)` 74k、`vmcnt(5)` 15k |
| `buffer_load` 发射阻塞 | 13.3% | 每组 load 的第一条阻塞 17–32k |
| MFMA | 11.8% | `v_mfma_f32_16x16x32_fp8_fp8`，每次循环 128 条 |
| `s_barrier` | 6.8% | 每次循环 2 个 barrier，合计 88k |
| `s_nop`（hazard 填充）+ LDS 等待 | 约 4% | |

其他关键事实：
- **寄存器限制并发**：最多用到 v165，没有用 AGPR，所以每个 SIMD 最多 3 个 wave（≤168 VGPR）。trace 里实际是 2–3 个 wave/SIMD，所有 wave 一次性派发完，只有一轮。
- **完全没有跨迭代预取**：`krt` 模式每次循环都是"发起 16 条 load → 立刻 `vmcnt(11)` 等待 → 写 LDS → barrier → 计算 → barrier"（见 [gemm1.py](aiter/ops/flydsl/kernels/moe_2stage_a16wmix/gemm1.py#L338)）。每次迭代每个 wave 都要完整吃一次 HBM 延迟（约 1.5k cycle）。

#### 改进建议（按预期收益排序）

##### 1. 让 runtime 循环支持预取（解决约 25% 的显存等待）
- 在 `_k_loop_runtime` 里，把下一块 B 的权重和 scale（8×dwordx4 + 4×dword，约 36 VGPR）在当前块的 MFMA 之前发出去，作为循环携带变量传到下一轮。
- 代价是 VGPR 超过 168，每 SIMD 并发从 3 降到 2。但这个 shape 本来就只有 2–3 个 wave/SIMD，而且只有一轮，所以值得实测。
- 还要先直接 benchmark 一下 `k_loop="unroll"`（已有双缓冲加预取）和 `krt` 的对比。LDS 不构成限制：gfx942 每 CU 64KB，unroll 下每个 WG 需要 32KB，可以放 2 个 WG。

##### 2. 精简反量化 VALU（VALU 时间和 MFMA 相当，是主要的计算瓶颈）
- [utils.py](aiter/ops/flydsl/kernels/moe_2stage_a16wmix/utils.py#L567) 里为处理 FNUZ 的 −0，每个 fragment 多花约 5–6 条指令（add / not / and / or），约占反量化 VALU 的 1/3。
- 当前 kernel 开了 `ftz`。在这个前提下，零值字节只有两种来源：nibble 为 0/−0，或整组被 flush。可以在权重 shuffle 时把这两种情况离线处理掉：
  - 把 −0（0x8）规范化为 0x0；
  - 把要 flush 的组的 nibble 直接置零（ftz 只取决于 scale，可以预先算出来）。
- 这样 kernel 里就能删掉整段 `zeros` 修正，预计 VALU 减少约 30–35%。

##### 3. 用更大的 BM 摊薄反量化开销
- 每个反量化出来的 B fragment 只被 `m_repeat = BM/16 = 4` 条 MFMA 复用。把 BM 提到 128，单位 MFMA 的 VALU 开销减半。
- 代价是累加器 +64 VGPR，并发降到 2；token 少时 padding 浪费也会增加。适合 prefill 大 M 的场景，需要按 shape 调优。

##### 4. 平滑 `buffer_load` 发射（13%）
- 现在每次循环开头连发 16 条 load，3 个 WG 又近乎同步，第一条 load 被访存发射队列（TA）的反压卡住 17–32k。
- 可以把 B 的 load 拆开，穿插到 MFMA 段中间发射。
- 每次迭代的地址计算（`v_or`/`v_add` 共约 20 条）可以改成"voffset 固定，用 SGPR soffset 按 K 前进"。

##### 5. 小项（合计约 5%）
- **LDS 读等待**：`ds_read2st64_b64` 后面紧跟 `lgkmcnt(0)`（8512 / 9136 / 12572 处，合计约 27k）。应该先连发多条读再等待，或者用 `lgkmcnt(N)` 分段等待。
- **`s_nop 2`**：共 17 处，约 19.5k。这是 MFMA 结果依赖引起的，可以调整顺序，用不相关的 VALU（例如下一个 fragment 的反量化）来填。
- **第二个 `s_barrier`**（12616，13k）：单 LDS slot 下躲不开，只有改双缓冲才能去掉，和第 1 条一起考虑。

#### 建议的验证顺序
1. 先 benchmark `unroll` 和 `krt`，用的是同一个 shape。
2. 做第 2 条（离线规范化 + 删 `zeros`）。这条纯属收益、不改变数值；不过离线规范化之后要用现有的 test 再确认一遍。
3. 给 `krt` 加 B 预取，同时扫 BM 64/128，比较 VGPR 和 occupancy 的取舍。

每一步做完都重新抓 ATT，重点看 `vmcnt(11)` 的 stall，以及每次迭代的 VALU 条数（现在约 600）。

Now find where the runtime fp8r gemm1 is launched (prepares a_scale / b_exp).

命令（Check tuned config rows using the a8w4 gemm1.）：
```bash
cd /sgl-workspace/aiter && head -3 mimo_v2.6_a16w4_a8w4_tuned_fmoe.csv && grep -n "fp8r" mimo_v2.6_a16w4_a8w4_tuned_fmoe.csv | head -20
```

命令（Check flash configs for h4096 shape.）：
```bash
cd /sgl-workspace/aiter && grep -h "fp8r" mimo_v2.6_flash_a16a8w4_tuned_fmoe.csv mimo_v2.6_flash_a8w4_tuned_fmoe.csv | cut -d, -f3-7,15,18 | head -30
```


---

## 2. 请求（2026-10-28 07:44 UTC，transcript 未记录原文，按会话摘要补）

> 针对这个gemm1的 a8w4 moe kernel，先单独提取一个实现和对应测试用例到test_a8w4_gemm1.py，去除多余的a16w4的逻辑，该文件只需要kernel实现和正确性+perf测试（参照test_flydsl_a16wfp4_silu_e2e）

命令（Run the new standalone a8w4 gemm1 test (correctness + perf).）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm1.py 2>&1 | grep -v "^\s*$" | tail -40
```

Now run the test.

命令（Re-run the standalone test.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm1.py 2>&1 | grep -v "^\s*$" | tail -30
```

命令（Run via pytest.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_gemm1.py -q 2>&1 | tail -3
```

I added [op_tests/test_a8w4_gemm1.py](op_tests/test_a8w4_gemm1.py): a standalone A8W4 gemm1 kernel plus a correctness and perf test. Both the script run and pytest pass on gfx942.

**What's in the kernel**
- Only the configuration the tuned A8W4 build actually runs is kept: fp8 activations with a per-token scale, mxfp4 weights in the standard layout, gfx942, SiLU activation, runtime K loop, swizzled A in LDS.
- Removed: bf16 activations, int4/bf16 weights, the interleaved gate/up layout, split-K across waves, the unrolled double-buffered K loop, and the SiTUv2/SwiGLU activations.
- The A loader, W loader, the fp4→fp8 lookup decode and the MFMA call are now written inline and specialized. Previously they went through generic loaders with branches for every data type.
- A few simplifications:
  - The weight scale's exponent byte is read directly as an integer, instead of going int → f32 → back to int.
  - The W column addressing is shorter.
  - The kernel launch no longer takes the unused SiTUv2 scalar arguments.
- `compile_a8w4_gemm1(...)` builds the kernel and `a8w4_gemm1(...)` launches it. The kernel name is prefixed `a8w4_gemm1_`, so its compile cache doesn't collide with the production kernel's.

**What the test does**
- Inputs, routing and weight preshuffle are built the same way as in `test_flydsl_a16wfp4_silu_e2e`.
- The fp32 torch reference reuses the kernel's own fp8-quantized activations and the exact mxfp4 weights. So the only differences left are accumulation order and bf16 output rounding. Comparison covers only the valid rows in sorted order (padding rows are skipped).
- There are two candidates:
  - `a8w4_gemm1` is the new standalone kernel.
  - `port` is the existing production kernel, `flydsl_a16w4_gemm1` with fp8 activations, kept as a baseline for later optimization.
- Each candidate reports time, TFLOPS, TB/s, the mismatch ratio from `checkAllclose`, and cos diff, ending in a markdown summary table.
- Default config is token=512, model_dim=4096, inter_dim=256, E=256, topk=8, tile 64×128, b_cache_mod=1, ftz on.

**Results** (default config)

| | us | TFLOPS | err | cos |
|---|---|---|---|---|
| a8w4_gemm1 (new) | 116.30 | 147.7 | 0 | 1.69e-10 |
| port (existing) | 116.41 | 147.6 | 0 | 1.69e-10 |

Accuracy and performance match the original kernel.

How to run:
```bash
pytest op_tests/test_a8w4_gemm1.py -q
python op_tests/test_a8w4_gemm1.py -t 512 2048 -s 4096,256,256,8 --tile 64,128 128,128
```


---

## 3. 请求（2026-10-28 08:01 UTC）

> 评估一下缺省参数运行时 compile_a8w4_gemm1 的进一步的优化空间，thread tracing 文件位于：/sgl-workspace/aiter/ck_test/ui_output_agent_8026_dispatch_6005

命令（List trace files for the new dispatch.）：
```bash
cd /sgl-workspace/aiter/ck_test && ls && ls ui_output_agent_8026_dispatch_6005 && head -2 stats_ui_output_agent_8026_dispatch_6005.csv 2>/dev/null; ls | grep 6005
```

命令（Aggregate hotspot stats for the new kernel trace.）：
```bash
cd /sgl-workspace/aiter/ck_test && python3 - <<'EOF'
import csv,collections,json,glob,re
rows=list(csv.DictReader(open('stats_ui_output_agent_8026_dispatch_6005.csv')))
print(len(rows))
tot=sum(int(r['Latency']) for r in rows)
cat=collections.defaultdict(lambda:[0,0,0,0])
for r in rows:
    ins=r['Instruction']
    if not ins or ins.startswith(';'): continue
    op=ins.split()[0]; m=op
    for p in ['s_waitcnt','buffer_load','buffer_store','global_load','ds_read','ds_write','v_mfma','s_barrier','s_nop','s_load','v_','s_']:
        if op.startswith(p): m=p;break
    c=cat[m];c[0]+=int(r['Hitcount']);c[1]+=int(r['Latency']);c[2]+=int(r['Stall']);c[3]+=int(r['Idle'])
print('total lat',tot)
for k,v in sorted(cat.items(),key=lambda x:-x[1][1]): print(f"{k:12s} hit={v[0]:7d} lat={v[1]:9d} ({100*v[1]/tot:5.1f}%) stall={v[2]:8d} idle={v[3]:7d}")
hc=collections.Counter(r['Hitcount'] for r in rows); print('hitcounts',hc.most_common(6))
print('--- top 25')
for r in sorted(rows,key=lambda r:-int(r['Latency']))[:25]:
    print(r['Vaddr'],r['Hitcount'],r['Latency'],r['Stall'],r['Instruction'][:70])
print('max vgpr', max(int(x) for r in rows for x in re.findall(r'\bv\[?(\d+)',r['Instruction'])), 'agpr', any(re.search(r'\ba\[?\d',r['Instruction']) for r in rows))
waves=[]
for f in sorted(glob.glob('ui_output_agent_8026_dispatch_6005/se*.json')):
    d=json.load(open(f));w=d['wave'];waves.append((f.split('/')[-1],w['begin'],w['end'],w['end']-w['begin'],d['num_insts']))
for w in waves: print(w)
o=json.load(open('ui_output_agent_8026_dispatch_6005/occupancy.json'))
print('occupancy keys',list(o.keys())[:5], {k:len(v) for k,v in o.items()})
rt=json.load(open('ui_output_agent_8026_dispatch_6005/realtime.json')); print(rt)
EOF
```

命令（Print compressed loop body and instruction mix.）：
```bash
cd /sgl-workspace/aiter/ck_test && python3 - <<'EOF'
import csv,re,collections
rows=list(csv.DictReader(open('stats_ui_output_agent_8026_dispatch_6005.csv')))
print([r['Instruction'] for r in rows if re.search(r'\ba\[?\d',r['Instruction'])][:5])
run=[]
def flush():
    global run
    if run:
        lat=sum(int(r['Latency']) for r in run);st=sum(int(r['Stall']) for r in run)
        ops=collections.Counter(r['Instruction'].split()[0] for r in run)
        print(f"   [{run[0]['Vaddr']}-{run[-1]['Vaddr']}] {len(run)} lat={lat} st={st} {dict(ops.most_common(5))}")
        run=[]
for r in rows:
    if r['Hitcount']!='448': continue
    k=r['Instruction'].split()[0]
    if k.startswith(('s_waitcnt','buffer_','ds_','s_barrier','s_cbranch','global_','s_nop')) or int(r['Latency'])>8000:
        flush(); print(r['Vaddr'],r['Latency'],r['Stall'],r['Instruction'][:80])
    else: run.append(r)
flush()
c=collections.Counter(r['Instruction'].split()[0] for r in rows if r['Hitcount']=='448')
print(sum(c.values())); print(c.most_common(30))
EOF
```

命令（Read kernel register usage from code object metadata and wave distribution from occupancy.）：
```bash
cd /sgl-workspace/aiter/ck_test && /opt/rocm/llvm/bin/llvm-readelf --notes out_gfx942_code_object_id_30.out 2>/dev/null | grep -E "\.name:|vgpr_count|agpr_count|sgpr_count|group_segment_fixed_size|vgpr_spill|sgpr_spill|private_segment" | head -20; python3 - <<'EOF'
import json
o=json.load(open('ui_output_agent_8026_dispatch_6005/occupancy.json'))
import collections
for se in ['0','1','2','3']:
    ev=o[se]; starts=collections.Counter((e[1],e[2]) for e in ev if e[4]==1)
    print(se, len(ev), 'cu-simd starts dist', collections.Counter(starts.values()), 'span', min(e[0] for e in ev), max(e[0] for e in ev))
print(o['dispatches'])
EOF
```

命令（Quantify routing padding and grid size for the default test shape.）：
```bash
cd /sgl-workspace/aiter && python3 - 2>/dev/null <<'EOF'
import torch
from aiter import dtypes
from aiter.fused_moe import fused_topk, moe_sorting
torch.manual_seed(0); torch.cuda.manual_seed(0)
T,H,I,E,K=512,4096,256,256,8
inp=torch.randn((T,H),dtype=dtypes.bf16,device='cuda')
w1=torch.randn((E,2*I,H),dtype=dtypes.bf16,device='cuda'); del w1
score=torch.randn((T,E),dtype=dtypes.bf16,device='cuda')
tw,ti=fused_topk(inp,score,K,True)
for BM in (16,32,64):
    si,_,se,nv,_=moe_sorting(ti,tw,E,H,dtypes.bf16,BM)[:5]
    n=int(nv[0]); blocks=n//BM
    valid=((si[:n]&0xFFFFFF)<T)
    v=valid.view(-1,BM)
    sub=v.view(blocks,-1,16).any(-1).sum().item() if BM>=16 else 0
    print(f"BM={BM} m_blocks={blocks} grid(tn128)={blocks*2} rows={n} valid={int(valid.sum())} pad={(1-valid.float().mean()).item():.2%} nonempty16subblocks={sub}/{blocks*BM//16} experts_hit={ti.unique().numel()}")
cnt=torch.bincount(ti.flatten(),minlength=E); print('tokens/expert min/mean/max',cnt.min().item(),cnt.float().mean().item(),cnt.max().item())
EOF
```

命令（Benchmark tile variants (BM 16/32/64, TILE_N 128/256) for the default shape.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 64,128 32,128 16,128 64,256 32,256 2>&1 | grep -E "^\||checkAllclose" | cut -c1-400
```

命令（Repeat BM 64/32/16 measurements to gauge noise.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 64,128 32,128 64,128 32,128 16,128 2>&1 | grep -E "^\|  " | awk -F'|' '{printf "tm=%s tn=%s new_us=%s port_us=%s\n",$7,$8,$13,$18}'
```

命令（Test TILE_N=64 variants for load balance.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 32,64 64,64 32,128 2>&1 | grep -E "^\|  |failed" | awk -F'|' '{printf "tm=%s tn=%s new_us=%s err=%s port_us=%s\n",$7,$8,$13,$16,$18}'
```

根据 trace（dispatch 6005，即 `a8w4_gemm1_h4096_i256_ne256_bm64_tn128_tk256_bcm1_xcd0_ftz`）和几组 tile 实测，缺省参数下估计还有 **30–40% 的优化空间**（约 115us → 70–80us）。其中最直接的一项不用改代码：把 tile_m 从 64 改成 32，实测就能快 13–15%。

#### 现状

**整体情况**
- **grid**：tile_m=64 时共 256 个 m-block，每个 m-block 拆成 2 个 n-block，合计 512 个 WG，分到 304 个 CU 上只有一轮。其中 208 个 CU 跑 2 个 WG，96 个 CU 跑 1 个。
- **padding**：每个 expert 平均只有 16 个 token（最少 7、最多 29），而 tile_m=64，所以 75% 的行是 padding。16 行一组的子块里只有 368/1024（36%）有有效数据。
- **寄存器**：VGPR 172、AGPR 0、LDS 16KB，所以每个 SIMD 最多 2 个 wave。
  - 原 port 版本是 166 个 VGPR，能放 3 个 wave。我抽取时把用量推过了 168 这条线，可以放回 3 个 wave，后面要修回来。
  - 当前 shape 每个 CU 只有约 1.7 个 WG，这一点暂时不影响；到 prefill（每个 CU 有 3 个以上 WG）时会影响。
- **wave 耗时**：每个 wave 约 155k–194k cycle。和别的 wave 共享 SIMD 的 wave（slot1）要多花约 15%。
- **带宽**：权重和 scale 共约 285MB。按 MI300X 实际能跑到约 4 TB/s 算，下限大约 70us；现在约 115us，只有 2.5 TB/s。

**每个 wave 每次 K 迭代的时间分布**（latency 总和除以 448 = 28 个 wave × 16 次迭代）

| 项 | cycle/iter | 占比 | 说明 |
|---|---|---|---|
| `s_waitcnt vmcnt` | 约 2.9k | 约 28% | `vmcnt(8)` 750k、`vmcnt(4)` 259k、`vmcnt(1)` 243k |
| VALU（fp4→fp8 解码） | 3.3k | 31.6% | 每次迭代约 600 条 VALU，对应 128 条 MFMA |
| MFMA | 1.6k | 15.6% | 其中 64% 算的是全 padding 的子块 |
| `s_waitcnt lgkmcnt` | 约 0.9k | 约 8% | `ds_read` 后立刻等 |
| `buffer_load` 发射 | 0.77k | 7.3% | |
| `s_barrier` ×2 | 0.58k | 5.5% | |
| `s_nop` + 其他 | 约 0.3k | 约 2% | |

trace 里还有一个新现象：编译器因为寄存器压力，把 8 条 W load 中的 3 条推迟到了解码之后才发（地址 7964–7984）。这导致计算做到一半时在 `vmcnt(1)` 处又卡了 243k。

#### 优化空间（按收益/成本排序）

| # | 手段 | 依据 | 预估收益 |
|---|---|---|---|
| 1 | **改用 tile_m=32**（不用改代码） | 最多的 expert 也只有 29 个 token，每个 expert 仍然只占一个 block，权重读取量不变，MFMA、A 搬运和累加器减半。现在 fp8r 的配置注册表里只有 tile_m 64/128，没有 32 | **实测 −13~15%**（112–118us → 97–102us） |
| 2 | **跨迭代预取**：runtime 循环里先发 kt+1 的 W、scale 和 A，再算 kt；A 的 LDS 改成双缓冲，每次迭代只留一个 barrier | 显存等待约 28%、barrier 5.5%，当前算和取完全串行。这个 shape 每个 SIMD 本来只有 1.7 个 wave，多用约 50 个 VGPR（总数不超过 256）不会降低并发；LDS 2×16KB 也放得下 2 个 WG | **−20~30%**，最大的一项 |
| 3 | **解码精简**：ftz 打开时，离线把 −0 nibble 规范成 +0；sign mask 和 LUT 一起计算（flush 时为 0）；去掉 `zeros` 修正 | 每个 fragment 的解码从约 16 条 VALU 降到约 10 条，结果和现在完全一致 | VALU −35%，约 **−8~10%**；预取做完后会更明显 |
| 4 | **跳过全 padding 的 16 行子块**：每个 wave 先根据 sorted_ids 算出每个子块有没有有效行，再用统一分支跳过对应的 MFMA 和 `ds_read` | tile_m=64 时只有 36% 的子块非空，tile_m=32 时 72% | tile_m=64 时 −8~10%；和第 1 项叠加后约 −3% |
| 5 | 修回 VGPR ≤168 | 恢复每 SIMD 3 个 wave | 当前 shape 没收益；prefill 大 token 时需要 |
| 6 | 把 `ds_read` 集中先发、再分段等 `lgkmcnt(N)`；用无关 VALU 去填 `s_nop` | lgkmcnt 约 8%、nop 0.9% | −3~5% |

其他结论：
- **改 TILE_N 解决不了负载不均**：tile_n=64 实测和 128 差不多（约 94–98us）。每个 WG 的耗时主要是 16 次串行迭代的延迟，而不是吞吐。
- **测量噪声**：同一配置多次跑会差约 ±4%。上面的结论都基于至少两次测量。

#### 建议路线
1. 先在 fp8r 的注册表里加上 tile_m 32（以及 16），重新 tune。代价最小，能拿到 −13%。
2. 给 `compile_a8w4_gemm1` 的 runtime 循环加预取和 A 的 LDS 双缓冲。重点看 `vmcnt` 的 stall 能不能压到 0.5k cycle/iter 以下。
3. 做解码精简（第 3 项）和 padding 子块跳过（第 4 项）。
4. 最后核对 VGPR，并用 4096 以上的 token 回归测试 prefill 场景。

全部做完，目标约 70–80us，相当于 3.6–4 TB/s，接近显存带宽上限。


---

## 4. 请求（2026-10-28 08:11 UTC）

> 好的开始


---

## 5. 请求（2026-10-28 08:11 UTC）

> 好的开始

命令（Find FlyDSL loop-carried docs in skill.）：
```bash
cd /sgl-workspace/aiter/.claude/skills/flydsl-kernel-authoring && ls -R && grep -n -i -E "loop-carried|iter_args|carried|scf|yield|range\(" SKILL.md | head -60
```

命令（Find FlyDSL env vars to dump ISA / compiled code.）：
```bash
cd /opt/venv/lib/python3.10/site-packages/flydsl && grep -rn "os.environ" --include=*.py | grep -i -E "dump|isa|asm|cache" | head -20
```

命令（List FlyDSL env var names.）：
```bash
cd /opt/venv/lib/python3.10/site-packages/flydsl && grep -rn "FLYDSL_[A-Z_]*" -o --include=*.py | sort -u -t: -k3 | awk -F: '{print $3}' | sort -u | head -50
```

Now rewrite the kernel's operand paths and K loop for software pipelining.

命令（Benchmark the pipelined kernel and dump its ISA.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd && FLYDSL_DEBUG_DUMP_ASM=1 FLYDSL_DUMP_DIR=/tmp/fd timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 64,128 32,128 2>&1 | grep -E "^\|  |failed|Error|error" | awk -F'|' '{printf "tm=%s tn=%s new_us=%s err=%s port_us=%s\n",$7,$8,$13,$16,$18}' ; ls /tmp/fd | head
```

命令（Find how ASM dump is configured.）：
```bash
cd /opt/venv/lib/python3.10/site-packages/flydsl && grep -rn "DUMP_ASM\|dump_asm\|DUMP_DIR\|dump_dir" --include=*.py | head -20
```

命令（Dump the final ISA for the pipelined kernels.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd /tmp/fdc && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd FLYDSL_RUNTIME_CACHE_DIR=/tmp/fdc timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 32,128 2>&1 | grep -E "final_isa" ; ls /tmp/fd
```

命令（Compare register usage and code size of new vs port kernel.）：
```bash
cd /tmp/fd && for d in a8w4* gemm1*; do echo "== $d"; grep -E "vgpr_count|sgpr_count|spill|group_segment_fixed_size|NumVgprs|ScratchSize|Occupancy" $d/21_final_isa.s | head -8; grep -cE "^\s+v_|^\s+s_|^\s+buffer|^\s+ds_" $d/21_final_isa.s; done
```

命令（Print compressed ISA structure of the new kernel.）：
```bash
cd /tmp/fd/a8w4*/ && python3 - <<'EOF'
import re
lines=[l.rstrip() for l in open('21_final_isa.s')]
ins=[(i,l.strip()) for i,l in enumerate(lines) if re.match(r'\s+(v_|s_|buffer_|ds_|global_)',l) or re.match(r'^\.?LBB',l.strip())]
# print compressed
prev=None;cnt=0
out=[]
for i,l in ins:
    op=l.split()[0]
    key = op if op.startswith(('s_waitcnt','buffer','ds_','s_barrier','s_cbranch','s_branch','.LBB','s_nop','global_')) or l.startswith('.LBB') else ('mfma' if 'mfma' in op else 'valu' if op.startswith('v_') else 'salu')
    if key in ('mfma','valu','salu'):
        if prev==key: cnt+=1; continue
        if prev in ('mfma','valu','salu'): out.append(f"   {prev} x{cnt}")
        prev=key;cnt=1
    else:
        if prev in ('mfma','valu','salu'): out.append(f"   {prev} x{cnt}")
        prev=None
        out.append(l[:90])
print(len(out))
print("\n".join(out))
EOF
```

命令（Find scheduling barrier usage in FlyDSL kernels.）：
```bash
cd /sgl-workspace/aiter/aiter/ops/flydsl && grep -rn "sched_barrier\|sched_group_barrier\|s_setprio\|iglp" --include=*.py | head -15
```

命令（Re-benchmark with sched_barrier keeping prefetch early.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd /tmp/fdc && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd FLYDSL_RUNTIME_CACHE_DIR=/tmp/fdc timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 64,128 32,128 2>&1 | grep -E "^\|  |failed|Error" | awk -F'|' '{printf "tm=%s tn=%s new_us=%s err=%s port_us=%s\n",$7,$8,$13,$16,$18}'; grep -h "vgpr_count\|vgpr_spill" /tmp/fd/a8w4*/21_final_isa.s
```

命令（Check whether other workloads are using the GPUs.）：
```bash
rocm-smi --showuse --showclocks 2>/dev/null | grep -E "GPU\[|use|sclk" | head -30; echo $HIP_VISIBLE_DEVICES $CUDA_VISIBLE_DEVICES
```

命令（Inspect loop ISA after sched_barrier.）：
```bash
cd /tmp/fd && d=$(ls -d a8w4*bm32*) && python3 - "$d" <<'EOF'
import re,sys
lines=[l.rstrip() for l in open(sys.argv[1]+'/21_final_isa.s')]
start=[i for i,l in enumerate(lines) if l.startswith('.LBB0_2')][0]
end=[i for i,l in enumerate(lines) if 's_cbranch_scc1 .LBB0_2' in l][0]
prev=None;cnt=0;out=[]
for l in lines[start:end+1]:
    s=l.strip()
    if not re.match(r'(v_|s_|buffer_|ds_|global_|\.LBB)',s): continue
    op=s.split()[0]
    key = None if op.startswith(('s_waitcnt','buffer','ds_','s_barrier','s_cbranch','.LBB','global_')) else ('mfma' if 'mfma' in op else 'valu' if op.startswith('v_') else 'salu')
    if key is None:
        if prev: out.append(f"   {prev} x{cnt}")
        prev=None; out.append(s[:80])
    else:
        if prev==key: cnt+=1
        else:
            if prev: out.append(f"   {prev} x{cnt}")
            prev=key;cnt=1
print("\n".join(out[:120]))
EOF
```

命令（Look at the end of the loop for waits.）：
```bash
cd /tmp/fd && d=$(ls -d a8w4*bm32*) && awk '/^.LBB0_2/{f=1} f' $d/21_final_isa.s | grep -n -E "s_waitcnt|ds_write|s_cbranch|s_barrier|sched" | tail -15
```

命令（See all waits within loop range.）：
```bash
cd /tmp/fd && d=$(ls -d a8w4*bm32*) && awk '/^.LBB0_2/{f=1} f' $d/21_final_isa.s | grep -n -E "s_waitcnt|ds_write|s_cbranch|s_barrier|LBB|buffer_store|s_endpgm" | head -60
```

命令（Repeated benchmark to compare new vs port robustly.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm1.py -t 512 --tile 32,128 64,128 32,128 64,128 32,128 2>&1 | grep -E "^\|  |failed|Error" | awk -F'|' '{printf "tm=%s tn=%s new_us=%s err=%s port_us=%s\n",$7,$8,$13,$16,$18}'
```

命令（Inspect the thread-trace config.）：
```bash
cd /sgl-workspace/aiter && cat trace.yaml
```

命令（Collect a thread trace of the pipelined kernel (BM=32) into /tmp/att.）：
```bash
cd /sgl-workspace/aiter && sed -e 's#output_directory: ck_test#output_directory: /tmp/att#' trace.yaml > /tmp/trace_att.yaml && rm -rf /tmp/att && timeout 1800 rocprofv3 -i /tmp/trace_att.yaml -- python op_tests/test_a8w4_gemm1.py -t 512 --tile 32,128 > /tmp/att_log.txt 2>&1; tail -3 /tmp/att_log.txt; ls /tmp/att | head
```

命令（Analyze the new trace.）：
```bash
cd /tmp/att && ls | grep -v code_object && cat > /tmp/att_an.py <<'EOF'
import csv,collections,json,glob,re,sys
f=sys.argv[1]
rows=list(csv.DictReader(open(f)))
print(rows[0]['Instruction'][:90])
tot=sum(int(r['Latency']) for r in rows)
cat=collections.defaultdict(lambda:[0,0,0])
for r in rows:
    ins=r['Instruction']
    if not ins or ins.startswith(';'): continue
    op=ins.split()[0]; m=op
    for p in ['s_waitcnt vmcnt','s_waitcnt lgkmcnt','s_waitcnt','buffer_load','buffer_store','global_load','ds_read','ds_write','v_mfma','s_barrier','s_nop','v_','s_']:
        if ins.startswith(p): m=p;break
    c=cat[m];c[0]+=int(r['Hitcount']);c[1]+=int(r['Latency']);c[2]+=int(r['Stall'])
hc=collections.Counter(r['Hitcount'] for r in rows).most_common(3); print('hitcounts',hc)
loop_hits=max(int(h) for h,_ in hc)
print('total lat',tot)
for k,v in sorted(cat.items(),key=lambda x:-x[1][1]): print(f"{k:18s} lat={v[1]:9d} ({100*v[1]/tot:5.1f}%) stall={v[2]:8d} per_iter={v[1]/loop_hits:7.0f}")
for r in sorted(rows,key=lambda r:-int(r['Latency']))[:12]:
    print(r['Vaddr'],r['Hitcount'],r['Latency'],r['Stall'],r['Instruction'][:70])
d=sys.argv[2]
durs=[]
for g in sorted(glob.glob(d+'/se*.json')):
    j=json.load(open(g));w=j['wave']
    if j['num_insts']>1000: durs.append(w['end']-w['begin'])
print('full waves',len(durs),'dur min/avg/max',min(durs),sum(durs)//len(durs),max(durs))
EOF
python3 /tmp/att_an.py /tmp/att/stats_ui_output_agent_*_dispatch_6005.csv /tmp/att/ui_output_agent_*_dispatch_6005
```

命令（Sweep cache modifier, TILE_N and xcd swizzle for the pipelined kernel.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/sweep.py <<'EOF'
import sys, importlib.util, itertools
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_gemm1.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cfgs = eval(sys.argv[1])
for c in cfgs:
    r = t.bench_a8w4_gemm1(512, 4096, 256, 256, 8, **c)
    print("RESULT", c, f"new={r['a8w4_gemm1 us']:.1f} port={r['port us']:.1f} err={r['a8w4_gemm1 err']}", flush=True)
EOF
timeout 1800 python /tmp/sweep.py "[dict(tile_m=32,tile_n=128,b_cache_mod=b) for b in (1,0,2,3,1)] + [dict(tile_m=32,tile_n=64), dict(tile_m=32,tile_n=128,xcd_swizzle=1)]" 2>&1 | grep RESULT
```

命令（Measure achievable HBM bandwidth with simple torch kernels for a speed-of-light reference.）：
```bash
cd /sgl-workspace/aiter && python3 - 2>/dev/null <<'EOF'
import torch
from aiter.test_common import run_perftest
n=285*1024*1024
x=torch.empty(n//4,dtype=torch.float32,device='cuda').normal_()
y=torch.empty_like(x)
for _ in range(2):
    _,us=run_perftest(lambda: y.copy_(x)); print('copy  ', us, 'us', 2*n/us/1e6,'TB/s')
    _,us=run_perftest(lambda: x.sum()); print('sum   ', us, 'us', n/us/1e6,'TB/s')
EOF
```

命令（Benchmark the decode change (repeated runs) and check VGPR / bit-exactness.）：
```bash
cd /sgl-workspace/aiter && sed -i 's/print("RESULT", c, f"new={r\[.a8w4_gemm1 us.\]:.1f} port={r\[.port us.\]:.1f} err={r\[.a8w4_gemm1 err.\]}"/print("RESULT", c, f"new={r[\x27a8w4_gemm1 us\x27]:.1f} port={r[\x27port us\x27]:.1f} err={r[\x27a8w4_gemm1 err\x27]} exact={r[\x27bitexact vs port\x27]}"/' /tmp/sweep.py && grep RESULT /tmp/sweep.py && rm -rf /tmp/fd && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd timeout 1800 python /tmp/sweep.py "[dict(tile_m=32)]*4 + [dict(tile_m=64)]*2" 2>&1 | grep RESULT; grep -h "vgpr_count" /tmp/fd/a8w4*/21_final_isa.s
```

命令（Benchmark lazy-A variant and check VGPR.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd timeout 1800 python /tmp/sweep.py "[dict(tile_m=32)]*3 + [dict(tile_m=64)]*2" 2>&1 | grep RESULT; grep -h "vgpr_count\|\.name:.*a8w4" /tmp/fd/a8w4*/21_final_isa.s
```

命令（Check prefill token counts for regressions vs the port.）：
```bash
cd /sgl-workspace/aiter && sed -i 's/r = t.bench_a8w4_gemm1(512, 4096, 256, 256, 8, \*\*c)/c = dict(c); tok = c.pop("token", 512); r = t.bench_a8w4_gemm1(tok, 4096, 256, 256, 8, **c); c["token"] = tok/' /tmp/sweep.py && timeout 3000 python /tmp/sweep.py "[dict(token=4096,tile_m=64), dict(token=4096,tile_m=64), dict(token=4096,tile_m=32), dict(token=16384,tile_m=64), dict(token=16384,tile_m=64), dict(token=16384,tile_m=128)]" 2>&1 | grep RESULT
```

Add a `pipeline` compile flag (single-slot, non-prefetching loop when False).

命令（Compare pipelined vs single-slot loops across BM and token counts, with VGPR stats.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd timeout 3000 python /tmp/sweep.py "[dict(token=16384,tile_m=128,pipeline=False), dict(token=16384,tile_m=128,pipeline=False), dict(token=16384,tile_m=128,pipeline=True,waves_per_eu=2), dict(token=16384,tile_m=64,pipeline=False), dict(token=16384,tile_m=64,pipeline=True), dict(token=512,tile_m=32,pipeline=False), dict(token=512,tile_m=32,pipeline=True)]" 2>&1 | grep RESULT; for f in /tmp/fd/a8w4*/21_final_isa.s; do echo "$(dirname $f | xargs basename) $(grep -h 'vgpr_count\|agpr_count' $f | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Find pipeline crossover point across token counts.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=64,pipeline=False), dict(token=512,tile_m=64,pipeline=False), dict(token=512,tile_m=64,pipeline=True), dict(token=512,tile_m=32,pipeline=True), dict(token=2048,tile_m=32,pipeline=True), dict(token=2048,tile_m=32,pipeline=False), dict(token=2048,tile_m=64,pipeline=False), dict(token=2048,tile_m=64,pipeline=True)]" 2>&1 | grep RESULT
```

命令（Re-measure with compile warm-up excluded, two rounds.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=64,pipeline=False), dict(token=512,tile_m=64,pipeline=True), dict(token=512,tile_m=32,pipeline=True), dict(token=512,tile_m=32,pipeline=False), dict(token=512,tile_m=64,pipeline=False), dict(token=512,tile_m=64,pipeline=True), dict(token=512,tile_m=32,pipeline=True), dict(token=512,tile_m=32,pipeline=False)]" 2>&1 | grep RESULT
```

命令（Explore TILE_N=64 / BM=16 / xcd / cache-mod with the new kernel.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=32,tile_n=64,pipeline=False), dict(token=512,tile_m=32,tile_n=64,pipeline=True), dict(token=512,tile_m=16,tile_n=64,pipeline=False), dict(token=512,tile_m=16,tile_n=128,pipeline=True), dict(token=512,tile_m=32,tile_n=128,pipeline=True,xcd_swizzle=1), dict(token=512,tile_m=32,tile_n=128,pipeline=True,b_cache_mod=0)]" 2>&1 | grep RESULT
```

命令（Refine best configs with XCD swizzle.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=32,tile_n=64,pipeline=False,xcd_swizzle=1), dict(token=512,tile_m=32,tile_n=64,pipeline=True,xcd_swizzle=1), dict(token=512,tile_m=32,tile_n=64,pipeline=False,xcd_swizzle=2), dict(token=512,tile_m=32,tile_n=128,pipeline=True,xcd_swizzle=1), dict(token=512,tile_m=32,tile_n=64,pipeline=False)]" 2>&1 | grep RESULT
```

命令（Locate defaults to update.）：
```bash
cd /sgl-workspace/aiter && grep -n "pipeline = BM <= 64\|default: \`\`BM <= 64\|tile_m=64,\|default=\[(64, 128)\]\|parametrize(\"token\"\|xcd_swizzle=0,$" op_tests/test_a8w4_gemm1.py
```

命令（Run pytest and the default script sweep.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_gemm1.py -q 2>&1 | tail -3 && timeout 1800 python op_tests/test_a8w4_gemm1.py 2>&1 | grep -E "^\|" | cut -c1-260
```

我改了 [op_tests/test_a8w4_gemm1.py](op_tests/test_a8w4_gemm1.py)。token=512 缺省 shape 下，从原 tuned 配置的约 113us 降到约 83–87us（−23~26%），离显存带宽下限（约 74us）还差 10–15%。所有配置的输出都和原 port kernel 逐位一致，pytest 2 个用例通过。

**token=512（4096/256/256/8）**，同一进程交替测，噪声约 ±3%：

| 配置 | 新 kernel | port 同配置 | 对比原 tuned 配置（port 64×128，约 113us） |
|---|---|---|---|
| 64×128，单 slot | 108–110 | 113 | −3~4% |
| 32×128，预取 | 93–94 | 102 | −17% |
| 32×128，预取 + `xcd_swizzle=1` | **83–87** | 94 | **−23~26%** |
| 32×64，单 slot | 85–87 | 89–92 | −23% |

**prefill**：token=16384 时，64×128 为 733us（port 754），128×128 为 684us（port 701），各快 2–3%。

**改了什么**
1. **fp4→fp8 解码精简**：每个 LUT 额外算一张 sign 掩码表（每个非零项对应 0x80），解码时直接带上符号。这样每个 fragment 不再需要单独修正 FNUZ 的 −0，约 16 条 VALU 降到约 12 条。不需要离线处理权重，所有 BM 都受益。
2. **跨迭代预取**（`pipeline` 参数，缺省在 BM≤32 时打开）：
   - A 的 LDS 改成双缓冲，每个 tile 只留一个 barrier。
   - 计算第 kt 个 tile 前，先发出第 kt+1 个 tile 的 A 和 W 加载；A 先发，这样写 LDS 前只需等 A。
   - 加了 `rocdl.sched_barrier(0)`，否则编译器会把这些预取 load 挪到循环末尾。
3. **A 改为按需从 LDS 读取**，不再一次性把整块 A 读进寄存器，减少寄存器占用。
4. **W 和 scale 的地址在 K 方向上只计算一次**，每个 tile 只加一个统一偏移；同一个 scale dword 只读一次。scale 字节的偏移在编译期就确定，前提是 TILE_K 必须是 256 的倍数（已加断言）。
5. **测试改动**：
   - 计时前先调用一次，把 JIT 编译排除在计时之外。原来首次计时偏慢 10–20%，干扰了对比。
   - 新增与 port 的逐位一致性断言。
   - pytest 同时覆盖 BM=32（预取）和 BM=64（单 slot）。
   - 缺省 tile 改为 32×128 加 64×128，`xcd_swizzle` 缺省改为 1。

**和之前估计不一致的地方**
- 预取只带来约 3% 收益，不是之前估计的 20–30%。改完后 kernel 已经卡在显存带宽上（约 3–3.5 TB/s，上限约 4 TB/s）：load 发射本身就在排队，提前一个 tile 发出的数据到下一轮仍未全部返回。
- 预取让寄存器涨到 230–260 个，在 BM≥64 的 prefill 场景反而变慢（BM=128 时 787us，port 703us）。所以缺省只在 BM≤32 时开启。

**没做的两项及原因**
- **跳过全 padding 的 16 行子块**：BM=32 时 MFMA 只占不到 4% 的时间，收益太小，暂缓。
- **在注册表里加 tile_m=32**：stage1 和 stage2 共用同一个 block_m，而 stage2 的 fp8r 目前只注册了 64/128。需要先验证 stage2 能跑 BM=32，再重新 tune CSV，范围超出这个文件，没有动生产代码。

剩下约 10–15% 的空间主要在两处：WG 之间负载不均（wave 耗时 123k–169k cycle），以及每次迭代只预取一个 tile、在途数据不够。要往下走，得先把预取路径的寄存器降到 168 以内，才能每个 SIMD 跑 3 个 wave，或者预取两个 tile。


---

## 6. 请求（2026-10-28 08:42 UTC）

> 在现有基础上增加一个缺省测试，人为的不均衡分配专家，模仿某些**Hot Experts**存在的情况

命令（Run pytest (now incl. hot-expert routing) and the default sweep.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_gemm1.py -q 2>&1 | tail -2 && timeout 1800 python op_tests/test_a8w4_gemm1.py 2>&1 | grep -E "^\|" | python3 -c "
import sys
rows=[[c.strip() for c in l.strip().strip('|').split('|')] for l in sys.stdin]
h=rows[0]; keep=['token','routing','tile_m','tile_n','experts hit','max tok/expert','m-blocks','a8w4_gemm1 us','a8w4_gemm1 TB/s','a8w4_gemm1 err','port us','bitexact vs port']
idx=[h.index(k) for k in keep]
for r in [h]+rows[2:]: print(' | '.join(r[i] for i in idx))
"
```

pytest 和缺省 sweep 都加上了 hot experts 用例，pytest 4 个用例全部通过，新 kernel 与 port 的输出逐位一致。

**怎么造不均衡**
- 新增 `routing` 参数，可选 `"uniform"`（原来的随机路由）或 `"hot"`。
- `"hot"` 时随机挑 E/32 个专家（256 个专家里挑 8 个），给它们的 router score 加 2.0，这样大部分 token 的 top-k 都会选中它们。
- 调整强度用两个常量：`HOT_EXPERT_DIV`（热点专家数量 = E/该值）和 `HOT_EXPERT_BIAS`（加多少分）。

**接入方式**
- **pytest**：`routing` 的两个取值和 `tile_m` 的 32、64 交叉，共 4 个用例。
- **脚本**：新增 `-r/--routing`，缺省两种都跑。
- **结果表**：新增 `experts hit`、`max tok/expert`、`m-blocks` 三列，方便看分布有多偏。

**缺省运行结果**（token=512）

| routing | tile_m | 每专家最多 token | m-blocks | 新 kernel us | port us |
|---|---|---|---|---|---|
| uniform | 32 | 29 | 256 | 83.9 | 95.0 |
| uniform | 64 | 29 | 256 | 109.3 | 111.1 |
| hot | 32 | 251 | 312 | 104.5 | 111.7 |
| hot | 64 | 251 | 280 | 108.5 | 112.6 |

有热点专家时，tile_m=32 的优势基本没了（104.5us，接近 tile_m=64 的 108.5us）。原因是热点专家被拆成多个 m-block（251 个 token / 32 ≈ 8 块），同一份权重要重复读多次；tile_m=64 拆得少，重复读也少。

所以 tile_m 不能只按 token 数选，还要看路由有多偏。热点专家能不能在多个 m-block 之间共享读进来的权重（比如让同一专家的 m-block 落在同一个 XCD 上提高 L2 命中，或者一个 WG 处理多个 m-block），可以作为下一步的优化方向。


---

## 7. 请求（2026-10-28 08:46 UTC）

> moe_sorting固定按照block_m=64，但是gemm1动态决定tile_m走32还是64 (根据有效sorted_ids连续分布特点，检查第32个id是否合法)，是否能更快

命令（Re-indent the K-loop/epilogue block into run_rows and append the dynamic row dispatch (scripted indentation edit).）：
```bash
cd /sgl-workspace/aiter && python3 - <<'EOF'
p='op_tests/test_a8w4_gemm1.py'
L=open(p).read().split('\n')
# lines 467..575 (1-based) -> indices 466..574
start,end=466,575
blk=L[start:end]
assert blk[0].strip().startswith('def compute_tile'), blk[0]
assert L[end].strip()=='@fx.struct', L[end]
# drop the xs_tiles/xs_atom lines (now hoisted)
out=[]
skip=0
i=0
while i<len(blk):
    s=blk[i]
    if s.strip().startswith('xs_tiles = _global_i32_buffer_tiles('):
        i+=3; continue
    if s.strip().startswith('xs_atom = fx.make_copy_atom'):
        i+=1; continue
    out.append(('    '+s) if s.strip() else s)
    i+=1
# strip trailing blank lines
while out and not out[-1].strip(): out.pop()
dispatch='''
        # ---- row-variant dispatch ------------------------------------------------
        if const_expr(dyn_m):
            # Valid rows of a sorted block are contiguous from its start, so the
            # block fits BM/2 rows iff sorted row BM/2 already holds padding.
            probe = rocdl.readfirstlane(
                T.i32, _raw(_global_i32_at(arg_mind, bx_m + fx.Int32(BM // 2)))
            )
            half = (fx.Int32(probe) & fx.Int32(0x00FFFFFF)) >= i32_ntok

            @flyc.jit
            def _dispatch():
                if half:
                    run_rows(BM // 2)
                else:
                    run_rows(BM)

            _dispatch()
        else:
            run_rows(BM)
'''.rstrip('\n').split('\n')
L[start:end]=out+dispatch+['']
open(p,'w').write('\n'.join(L))
EOF
sed -n 460,475p op_tests/test_a8w4_gemm1.py; grep -n "row-variant dispatch" -A 22 op_tests/test_a8w4_gemm1.py | tail -6
```

命令（Benchmark dynamic tile_m (sort at 64) against static 32/64 for uniform and hot routing.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=64,dyn_m=True), dict(token=512,tile_m=32), dict(token=512,tile_m=64), dict(token=512,tile_m=64,dyn_m=True,routing='hot'), dict(token=512,tile_m=32,routing='hot'), dict(token=512,tile_m=64,routing='hot')]" 2>&1 | grep -E "RESULT|Error|error" | head; for f in /tmp/fd/a8w4*/21_final_isa.s; do echo "$(dirname $f | xargs basename) $(grep -h 'vgpr_count\|group_segment_fixed_size:' $f | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Repeat and extend dyn_m comparison to 2048 tokens and an all-pipelined variant.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=64,dyn_m=True,routing='hot'), dict(token=512,tile_m=64,dyn_m=True,routing='hot',pipeline=True), dict(token=512,tile_m=64,dyn_m=True), dict(token=2048,tile_m=64,dyn_m=True), dict(token=2048,tile_m=32), dict(token=2048,tile_m=64), dict(token=2048,tile_m=64,dyn_m=True,routing='hot'), dict(token=2048,tile_m=32,routing='hot'), dict(token=2048,tile_m=64,routing='hot')]" 2>&1 | grep -E "RESULT"
```

命令（Compare dyn_m with non-pipelined half variant (lower VGPR) vs pipelined half variant.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=512,tile_m=32)] + [dict(token=t,tile_m=64,dyn_m=True,pipeline=False,routing=r) for t in (512,2048) for r in ('uniform','hot')] + [dict(token=t,tile_m=64,dyn_m=True,routing=r) for t in (512,2048) for r in ('uniform','hot')]" 2>&1 | grep -E "RESULT"
```

命令（Check VGPR of dyn_m non-pipelined variant and try waves_per_eu=3 cap at 2048 tokens.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd timeout 3000 python /tmp/sweep.py "[dict(token=2048,tile_m=64), dict(token=2048,tile_m=64,dyn_m=True,pipeline=False), dict(token=2048,tile_m=64,dyn_m=True,pipeline=False,waves_per_eu=3), dict(token=2048,tile_m=64,routing='hot'), dict(token=2048,tile_m=64,dyn_m=True,pipeline=False,routing='hot'), dict(token=2048,tile_m=64,dyn_m=True,pipeline=False,waves_per_eu=3,routing='hot')]" 2>&1 | grep -E "RESULT"; for f in /tmp/fd/a8w4*/21_final_isa.s; do echo "$(dirname $f | xargs basename) $(grep -h 'vgpr_count\|vgpr_spill' $f | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Measure the 1024-token crossover for static 32/64 vs dyn_m.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep.py "[dict(token=1024,tile_m=32,routing=r) for r in ('uniform','hot')] + [dict(token=1024,tile_m=64,routing=r) for r in ('uniform','hot')] + [dict(token=1024,tile_m=64,dyn_m=True,routing=r) for r in ('uniform','hot')]" 2>&1 | grep -E "RESULT"
```

命令（Full matrix (tokens x routing x static32/static64/dyn), 3 interleaved repeats, min time.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/sweep2.py <<'EOF'
import sys, importlib.util, collections
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_gemm1.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cfgs = eval(sys.argv[1]); reps = int(sys.argv[2])
best = collections.defaultdict(lambda: [1e9, 1e9])
for _ in range(reps):
    for c in cfgs:
        c = dict(c); tok = c.pop("token")
        r = t.bench_a8w4_gemm1(tok, 4096, 256, 256, 8, **c)
        assert r['bitexact vs port'] and r['a8w4_gemm1 err'] == 0
        k = (tok, c.get("routing", "uniform"), c.get("tile_m"), c.get("dyn_m", False))
        best[k][0] = min(best[k][0], r['a8w4_gemm1 us']); best[k][1] = min(best[k][1], r['port us'])
for k, (n, p) in sorted(best.items()):
    print("BEST", k, f"new={n:.1f} port={p:.1f}", flush=True)
EOF
timeout 6000 python /tmp/sweep2.py "[dict(token=t,tile_m=m,dyn_m=d,routing=r) for t in (512,1024,2048) for r in ('uniform','hot') for (m,d) in ((32,False),(64,False),(64,True))]" 3 2>&1 | grep BEST
```

命令（Run pytest matrix incl. dyn_m.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_gemm1.py -q 2>&1 | tail -2
```

能更快，但只在 token 少的时候。512 token 下它是最快的，有热点专家时也是；到 2048 token 反而比固定 tile_m=64 慢 8–13%。我已经实现成可选开关 `dyn_m`，缺省关闭。pytest 6 个用例全部通过，所有配置的输出都和原 port kernel 逐位一致。

**做法**（[op_tests/test_a8w4_gemm1.py](op_tests/test_a8w4_gemm1.py)）
- `compile_a8w4_gemm1(..., dyn_m=True)`：`moe_sorting` 固定按 64 分块。每个 WG 先读一次 `sorted_ids[bx_m + 32]`；如果这一行已经是 padding，说明这块只有前 32 行有效，就只算 32 行，否则算满 64 行。
- 32 行和 64 行两种算法都编进同一个 kernel，按上面的判断选一条执行。缺省时 32 行那条用预取，64 行那条不预取。
- 为此把和行数有关的部分（A 的地址与加载、累加器、K 循环、写回）收进了 `run_rows(rows)`；W 相关的部分两条路径共用。
- 测试接入：
  - **pytest**：tile 组合为 (32, 固定)、(64, 固定)、(64, `dyn_m`)，再乘两种路由，共 6 个用例。
  - **脚本**：`--tile` 支持写第三个值，比如 `64,128,1` 表示开启 `dyn_m`，缺省会跑这一项。

**实测**（单位 us；每个配置交替跑 3 轮取最小值，单次测量误差有 ±5%）

| token | 路由 | 固定 tile_m=32 | 固定 tile_m=64 | 按 64 排序 + `dyn_m` |
|---|---|---|---|---|
| 512 | uniform | 83.1 | 105.5 | **82.1** |
| 512 | hot | 102.7 | 108.5 | **98.7** |
| 1024 | uniform | 117.3 | 112.5 | **106.8** |
| 1024 | hot | **114.1** | 132.5 | 124.4 |
| 2048 | uniform | 175.9 | **150.1** | 169.1 |
| 2048 | hot | 173.8 | **149.9** | 162.8 |

**为什么 token 一多就变慢**
1. **寄存器**：两条路径编进同一个 kernel，寄存器按大的那条分配，约 173–234 个 VGPR，每个 SIMD 只能跑 2 个 wave；固定 tile_m=64 只用 168 个，能跑 3 个。2048 token 时 WG 数量超过 2 个 wave 能同时容纳的数量，要分两轮跑。用 `waves_per_eu=3` 强行压到 168 个 VGPR 会出现溢出，速度也没有回来。
2. **负载不均**：热点专家的块走满 64 行，耗时约是 32 行块的 2 倍。所以 1024 token 加热点专家时，WG 大小统一的固定 tile_m=32 反而更快。

**建议**
- **512 token 左右（含热点专家）、1024 token 均匀路由**：开启 `dyn_m`，比原 tuned 配置（约 110us）快约 10–25%。
- **2048 token 及以上**：继续用固定 tile_m=64，不开 `dyn_m`。
- 落地方式：把 `dyn_m` 作为一个额外配置加进 tuning 候选，让 CSV 按 token 数去选，而不是缺省打开。
- 想让它在大 token 时也不吃亏，需要把这个 kernel 的寄存器压到 168 个以内且不溢出，比如 32 行那条也不用预取，同时进一步缩减寄存器占用。这一步我还没做。


---

## 8. 请求（2026-10-28 09:13 UTC）

> 根据这几行选中的gemm2，仿照刚才的gemm1，提取一下a8w4的kernel和正确性+性能测试到单独文件test_a8w4_gemm2.py，使用跟gemm1类似的命令行测试参数和缺省值

命令（Survey gemm2.py structure.）：
```bash
cd /sgl-workspace/aiter/aiter/ops/flydsl/kernels/moe_2stage_a16wmix && wc -l gemm2.py && grep -n "^def \|^    def \|fp8r\|_fp8\b\|flush_tiny\|epilog\|persist" gemm2.py | head -80
```

命令（First run of the standalone gemm2 test.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm2.py -t 512 -r uniform --tile 64,128 2>&1 | grep -E "^\||checkAllclose|Error|error|Traceback|File \"/sgl" | cut -c1-300 | tail -20
```

命令（Show error stats and remaining columns.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm2.py -t 512 -r uniform --tile 64,128 2>&1 | grep -E "^\|  |max abs delta" | python3 -c "
import sys
for l in sys.stdin:
    if 'delta' in l: print(l.strip()[:200]); continue
    r=[c.strip() for c in l.strip().strip('|').split('|')]; print(r[-12:])
"
```

命令（Measure mismatch fraction under several tolerances to pick one for bf16 atomic accumulation.）：
```bash
cd /sgl-workspace/aiter && python3 - 2>/dev/null <<'EOF'
import importlib.util, torch
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_gemm2.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
orig = t.checkAllclose
stats = {}
def cap(a, b, **kw):
    d = (a-b).abs(); stats['ref_absmean']=a.abs().mean().item(); stats['ref_absmax']=a.abs().max().item()
    for rt, at in ((1e-2,1e-2),(2e-2,2e-2),(2e-2,0.1),(3e-2,0.1),(5e-2,0.1)):
        stats[(rt,at)] = (~torch.isclose(a,b,rtol=rt,atol=at)).float().mean().item()
    return orig(a,b,**kw)
t.checkAllclose = cap
t.bench_a8w4_gemm2(512, 4096, 256, 256, 8)
print(stats)
EOF
```

命令（Run pytest and the default CLI sweep for gemm2.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_gemm2.py -q 2>&1 | tail -2 && timeout 3000 python op_tests/test_a8w4_gemm2.py 2>&1 | grep -E "^\|" | python3 -c "
import sys
rows=[[c.strip() for c in l.strip().strip('|').split('|')] for l in sys.stdin]
h=rows[0]; keep=['token','routing','tile_m','tile_n','max tok/expert','m-blocks','a8w4_gemm2 us','a8w4_gemm2 TB/s','a8w4_gemm2 err','a8w4_gemm2 cos','port us','port err']
idx=[h.index(k) for k in keep]
for r in [h]+rows[2:]: print(' | '.join(r[i] for i in idx))
"
```

我把选中的 gemm2 kernel（`flydsl_moe2_afp8r_wfp4_bf16_t64x128x256_atomic_*`）抽到了 [op_tests/test_a8w4_gemm2.py](op_tests/test_a8w4_gemm2.py)，pytest 4 个用例通过，缺省 sweep 全部过精度。顺带发现 tile_m=32 在测过的所有 token 数上都明显比 tuned CSV 用的 64 快。

**kernel 部分**
- 只保留 CSV 实际用到的路径：gfx942、fp8 输入、mxfp4 权重、atomic 写回、K 循环静态展开。去掉了 bf16/int4、persistent、reduce 写回和 gfx950 分支。
- 写回部分（先存 LDS，再按路由权重用 bf16x2 全局原子加）内联成只针对 gfx942 的 `_atomic_bf16_epilog`。保留了 `@flyc.jit`，否则 padding 行的判断不会生效、仍会执行原子加。
- 每个输出通道的最大指数和原来一样在 kernel 内算；scale 只读一遍，同时用于求最大指数和主循环。
- 解码改用 gemm1 里精简后的版本（LUT 带符号掩码，数值完全一致）。W/A 地址和 gemm1 一样，按 lane 预先算好。
- XCD 映射保持 port 原来的语义：`xcd_swizzle=0` 时仍做 XCD 轮转（原版就是常开）。

**测试部分**
- 命令行参数、缺省值和 gemm1 一致：`-t` 缺省 128/256/512/1024/2048，`-s 4096,256,256,8`，`-r uniform hot`。
- `--tile` 缺省是 `64,128` 和 `32,128`。
- `b_cache_mod=2`、`xcd_swizzle=0` 取的是 512 那一行 CSV 的配置。
- 对比对象是原 port（`flydsl_a16w4_gemm2`，`a_dtype="fp8r"`）。stage1 的输出用随机 bf16 代替，再按真实路径用 `quantize_rows(inter, num_valid_ids)` 量化。
- 参考实现：用同一份 fp8 输入和精确的 mxfp4 权重在 fp32 下计算，乘路由权重后按 token `index_add_` 累加。
- **和 gemm1 的两点不同**：
  - 因为是原子累加，每个候选先往清零的 buffer 跑一次做精度检查，再计时。
  - 不做和 port 的逐位一致检查，原子加的顺序本身就不确定。
- **容差放宽到 rtol=2e-2、atol=0.1**：输出是 topk 个部分和逐次在 bf16 里累加，每次都会舍入。按 1e-2 时新旧 kernel 都有 6% 元素不过，cos 误差完全一样（9.3e-6）；放宽后不匹配降到约 2e-6。

**缺省 sweep 结果**（单次测量，噪声约 ±3%）

| token | 路由 | 新 kernel tile_m=64 | port tile_m=64 | 新 kernel tile_m=32 | port tile_m=32 |
|---|---|---|---|---|---|
| 128 | uniform | 75.9 | 77.0 | **44.6** | 50.1 |
| 512 | uniform | 82.3 | 85.8 | **55.0** | 58.8 |
| 512 | hot | 95.4 | 96.1 | **61.5** | 66.9 |
| 1024 | hot | 115.3 | 112.5 | **77.8** | 83.1 |
| 2048 | uniform | 152.3 | 155.8 | **131.1** | 139.0 |
| 2048 | hot | 145.1 | 145.2 | **131.9** | 139.7 |

- 同样 tile 下，新 kernel 比 port 快 1–8%，来自解码精简；1024 和 2048 token 加热点专家、tile_m=64 时两者持平或略慢。
- gemm2 的 tile_m=32 比 64 快 14–42%，到 2048 token 也是如此，而 CSV 里 stage2 一律用的是 64。原因是这里 K 只有 256（一个 tile），每个 WG 的 MFMA 和写回量随 BM 减半，权重读取量不变。
- 不过 stage1 和 stage2 共用同一个 block_m，而 fp8r 的注册表目前只有 64/128。要用上 32，需要两边一起加上并重新 tune。


---

## 9. 请求（2026-10-28 10:34 UTC）

> 针对token<1024的情况，从membound角度分析gemm2的性能合理吗？有什么改进建议

命令（Measure tile_m 16/32/64 at small token counts and inspect register/LDS usage and atomic instruction flags.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd2 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd2 timeout 1800 python op_tests/test_a8w4_gemm2.py -t 128 512 -r uniform --tile 64,128 32,128 16,128 2>&1 | grep -E "^\|  " | python3 -c "
import sys
rows=[[c.strip() for c in l.strip().strip('|').split('|')] for l in sys.stdin]
h=rows[0]; keep=['token','tile_m','m-blocks','a8w4_gemm2 us','a8w4_gemm2 TB/s','a8w4_gemm2 err','port us']
idx=[h.index(k) for k in keep]
for r in [h]+rows[1:]: print(' | '.join(r[i] for i in idx))
"; for d in /tmp/fd2/a8w4_gemm2*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:\|sgpr_count' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; grep -m3 -h "global_atomic" $d/21_final_isa.s; done
```

结论：token<1024 时 gemm2 确实应该是显存带宽受限，但当前生产配置（tile_m=64）只跑到 HBM 上限的 37–50%，不合理。瓶颈不在带宽本身，而在 occupancy 太低、每个 WG 里"加载 → 计算 → 写回"完全串行没有重叠，导致显存延迟藏不住。下面是我按 4096/256/256/8、uniform 路由实测的数据。

#### 1. 为什么应该是 membound

512 token 时：

| 数据 | 字节数 | 走哪 |
|---|---|---|
| W2 + scale（256 个专家全部命中） | 256 × 4096 × (128 + 8) ≈ **143 MB** | HBM，主体 |
| A（fp8，routed 行） | 4096 × 256 ≈ 1 MB | HBM；但 32 个 n-block 各读一遍，包括 padding 行，L2 读取量为 BM64 时 134 MB、BM32 时 67 MB |
| 输出原子加 | 4096 × 4096 × 2 B ≈ **33.5 MB**（每个输出元素被 topk=8 次累加） | 落在 L2 / 内存侧 |
| 最终输出 | 4 MB | HBM |

- 计算量 2 × 4096 × 4096 × 256 ≈ 8.6 GFLOP，算术强度约 60 flop/B，远低于 MI300X fp8 的平衡点（约 650 flop/B），所以是显存受限。
- 理论下限：143 MB ÷ 约 4.0 TB/s（实测 torch copy/sum）≈ **36 us**。

#### 2. 实测离下限有多远

| token | tile_m | m-blocks | 新 kernel us | 等效带宽 | 占上限 |
|---|---|---|---|---|---|
| 128 | 64 | 252 | 74.0 | 1.9 TB/s | 48% |
| 128 | 32 | 252 | 44.9 | 3.2 TB/s | 79% |
| 128 | **16** | 252 | **34.5** | **4.1 TB/s** | **约 100%** |
| 512 | 64 | 256 | 83.8 | 1.8 TB/s | 44% |
| 512 | **32** | 256 | **55.4** | 2.7 TB/s | 65% |
| 512 | 16 | 367 | 57.9 | 2.6 TB/s | 权重要重读约 1.43 倍 |
| 512 | CSV 生产配置（64，bnt2） | — | 97.8（CSV 记录值） | 约 1.5 TB/s | 37% |

字节数不变（权重都读一遍），只是 tile_m 变小，速度就快 1.5–2.1 倍。说明限制它的不是带宽。

#### 3. 原因

1. **LDS 卡住了 occupancy。** 写回时把 f32 结果暂存到 LDS，需要 BM × TILE_N × 4 B，比 A tile 还大，决定了整个 kernel 的 LDS 用量：

   | tile_m | LDS | VGPR | 每 CU 最多 WG 数 |
   |---|---|---|---|
   | 64 | 32 KB | 111 | 2 |
   | 32 | 16 KB | 67 | 4 |
   | 16 | 8 KB | 50 | 8 |

2. **K_TILES=1，每个 WG 内部没有任何重叠。** 流程是读 16 KB W2 → barrier → 解码 + MFMA → LDS → barrier → 原子加。一个 WG 只能一段一段串行走，延迟全靠别的 WG 来掩盖；BM64 时每 CU 只有 2 个 WG，在途数据不够。
3. **padding 行白做。** token 少时一个块里有效行很少（128 token 平均每专家 4 行），但 A 加载、MFMA、LDS 暂存仍按整个 BM 做，padding 行只在最后原子加时跳过。
4. **原子写回有固定成本。** 32 tile 下 token 从 128 增到 512，权重字节没变，时间却多了约 10.5 us，主要来自多出的约 25 MB 原子加（加上更多有效 A 行），折合约 2.4 TB/s。按此估算，512 token 时原子写回约占 14 us。

#### 4. 改进建议（按收益/成本排序）

1. **按 token 数选 tile_m（不改 kernel）。** token ≤ 256 用 16，512–1024 用 32。
   - 512 token 能从约 98 us 降到约 55 us，128 token 从 83 us 降到约 35 us（基本贴近上限）。
   - 前提：fp8r 的 stage1/stage2 注册表都要加上 16/32 并重新 tune。两个 stage 共用 block_m，stage1 在 32 时也更快。
2. **写回改为不经过 LDS。** 用一次 `shuffle_xor(1)` 让相邻 lane 交换数据，凑成连续两列，再直接从 MFMA 累加器发 `global_atomic_pk_add_bf16`。
   - LDS 降到只剩 A tile（BM32 时 8 KB），occupancy 不再被 LDS 限制；还能省掉一次 barrier 和一轮 LDS 读写。
   - 代价是写回阶段只有一半 lane 在发原子加。
   - 预计 BM32/64 时收益最大，也能让 TILE_N=256 可用，从而减半 A 的重读。
3. **跳过全 padding 的子块。** 用 gemm1 里 `dyn_m` 同样的思路：读 `sorted_ids[m_row + 16*i]`，只对有效的 16 行子块加载 A、做 MFMA、做 dequant。
   - 这样可以按 32 排序，同时在 token 少时得到接近 16 的效率，也解决了第 1 条里 block_m 必须和 stage1 一致的问题。
   - gemm2 的 VGPR 只有 50–111，不会出现 gemm1 那样 VGPR 涨过 168 的问题。
4. **持久化 WG，加载下一个 tile 时和当前 tile 的写回重叠。** 每个 CU 常驻 1–2 个 WG 循环处理多个 tile；当前 tile 做原子写回时，就先发出下一个 tile 的 W2 加载（K 很短，一个 tile 只占 16 KB 寄存器）。这一条在高 occupancy 方案（第 1–3 条）之后再评估。
5. **原子写回本身。** 写回量约为 8 × token × model_dim × 2 B，用 reduce 写回落 HBM 只会更贵，所以继续用原子加是合理的。可以再验证一项：让同一 n-block 列段的 tile 都映射到同一个 XCD，提高原子加在本 XCD L2 的命中。这需要先确认 gfx942 上原子加的内存模型和一致性，属于探索项。

**预期**：第 1 条立刻可用。第 2、3 条做完后，512 token 有望从约 55 us 降到 45 us 以下（约 3.2 TB/s 以上）。剩下的差距主要是原子写回的成本。


---

## 10. 请求（2026-10-28 10:38 UTC）

> 好的开始优化

Add the direct epilogue and wire it via an `epilog` option.

Simplify the LDS epilogue to reuse the shared helpers, then wire the option.

命令（Compare LDS vs direct epilogue across tiles at 128/512 tokens (min of 2).）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/sweep_g2.py <<'EOF'
import sys, importlib.util, collections
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_gemm2.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cfgs = eval(sys.argv[1]); reps = int(sys.argv[2])
best = collections.defaultdict(lambda: [1e9, 1e9, 0])
for _ in range(reps):
    for c in cfgs:
        c = dict(c); tok = c.pop("token")
        r = t.bench_a8w4_gemm2(tok, 4096, 256, 256, 8, **c)
        assert r['a8w4_gemm2 err'] <= t.TOL_ERR_RATIO and r['a8w4_gemm2 cos'] < 1e-4, r
        k = (tok,) + tuple(sorted(c.items()))
        b = best[k]; b[0] = min(b[0], r['a8w4_gemm2 us']); b[1] = min(b[1], r['port us']); b[2] = r['a8w4_gemm2 TB/s']
for k, (n, p, bw) in best.items():
    print("BEST", k, f"new={n:.1f} port={p:.1f}", flush=True)
EOF
timeout 3000 python /tmp/sweep_g2.py "[dict(token=t,tile_m=m,epilog=e) for t in (128,512) for m in (64,32,16) for e in ('lds','direct')]" 2 2>&1 | grep -E "BEST|Error|Traceback"
```

命令（Replace the f32-staging epilogue with bf16 staging (weights applied in MFMA layout) and update LDS sizing/docs (scripted multi-line replacement).）：
```bash
cd /sgl-workspace/aiter && python3 - <<'EOF'
p='op_tests/test_a8w4_gemm2.py'
s=open(p).read()
a=s.index('@flyc.jit\ndef _atomic_bf16_epilog(')
b=s.index('# =============================================================================\n# Kernel')
new='''@flyc.jit
def _atomic_bf16_epilog(
    lds_base_i32, accm, arg_out, arg_stids, arg_sweights, m_row, n_block, wave, lane,
    i32_M, BM, N_OUT, BN,
):
    """Coalesced scatter through LDS: apply the routing weight in the MFMA layout,
    stage the tile as bf16 [BM, BN] (same bf16 rounding point as the port's f32
    staging, half the LDS), re-read it as (8 rows x 32 lanes x 2 cols) and
    ``global_atomic_pk_add_bf16`` into ``out[token, n]`` (128 B per row per op)."""
    M_CHUNKS = BM // 16
    M_REPS = BM // 8  # 256 threads = 8 rows x 32 lanes per pass
    n_per_wave = BN // 4
    num_acc_n = n_per_wave // 16
    s_count = BN // 64  # each pass covers 64 cols (32 lanes x 2)
    lane_div_16 = lane // fx.Int32(16)
    lane_mod_16 = lane % fx.Int32(16)
    lds_bf16 = lds_typed_ptr(lds_base_i32, T.bf16)

    tx = fx.Int32(gpu.thread_id("x"))
    m_lane = tx // fx.Int32(32)
    col_start = (tx % fx.Int32(32)) * fx.Int32(2)

    stids = _flat_buffer(arg_stids, T.i32, 4)
    sweights = _flat_buffer(arg_sweights, T.f32, 4)
    load_i32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
    load_f32 = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Float32)
    # gfx942 has no buffer_atomic_pk_add_bf16 -> global packed atomic.
    out_base = _global_base_ptr1(arg_out)

    def load_scalar(atom, src, index, elem_ty):
        frag = fx.make_rmem_tensor(1, elem_ty)
        fx.copy(atom, src[None, index], frag)
        return Vec(frag.load())[0]

    packed = []
    for mr in range_constexpr(M_REPS):
        sorted_pos = m_row + fx.Int32(mr * 8) + m_lane
        packed.append(load_scalar(load_i32, stids, sorted_pos, fx.Int32))

    # MFMA acc layout (lane: col L%16, rows (L//16)*4 + v) -> weighted bf16 in LDS.
    for i in range_constexpr(M_CHUNKS):
        row_base = fx.Int32(i * 16) + lane_div_16 * fx.Int32(4)
        w = [
            load_scalar(load_f32, sweights, m_row + row_base + fx.Int32(v), fx.Float32)
            for v in range_constexpr(4)
        ]
        for J in range_constexpr(num_acc_n):
            col = wave * fx.Int32(n_per_wave) + fx.Int32(J * 16) + lane_mod_16
            vec = Vec(accm[i][J])
            bf4 = Vec.from_elements(
                [vec[v] * w[v] for v in range_constexpr(4)], fx.Float32
            ).to(fx.BFloat16)
            for v in range_constexpr(4):
                lds_bf16[(row_base + fx.Int32(v)) * fx.Int32(BN) + col] = bf4[v]

    gpu.barrier()

    for mr in range_constexpr(M_REPS):
        row_in_block = fx.Int32(mr * 8) + m_lane
        token_id = packed[mr] & fx.Int32(0x00FFFFFF)
        if token_id < i32_M:  # padding rows carry a sentinel token id
            row_base_addr = (
                token_id * fx.Int32(N_OUT) + n_block * fx.Int32(BN) + col_start
            )
            for s in range_constexpr(s_count):
                idx0 = row_in_block * fx.Int32(BN) + col_start + fx.Int32(s * 64)
                pk = lds_vec_load(
                    lds_base_i32,
                    idx0 * fx.Int32(2),
                    Vec.make_type(2, fx.BFloat16),
                    fx.BFloat16,
                    align=4,
                )
                llvm.AtomicRMWOp(
                    llvm.AtomicBinOp.fadd,
                    _gep1(out_base, (row_base_addr + fx.Int32(s * 64)) * fx.Int32(2)),
                    _raw(pk),
                    llvm.AtomicOrdering.monotonic,
                    syncscope="agent",
                    alignment=4,
                )


'''
s=s[:a]+new+s[b:]
s=s.replace('''    # LDS epilogue: the A tile and the f32 staging tile never coexist (barrier
    # between) -> max, not sum. Direct epilogue: A tile only.
    LDS_BYTES = BM * TILE_K if epilog == "direct" else max(BM * TILE_K, BM * TILE_N * 4)''','''    # LDS epilogue: the A tile and the bf16 staging tile never coexist (barrier
    # between) -> max, not sum. Direct epilogue: A tile only.
    LDS_BYTES = BM * TILE_K if epilog == "direct" else max(BM * TILE_K, BM * TILE_N * 2)''')
s=s.replace('''    occupancy); ``"lds"`` is the port's f32 LDS round trip (LDS = BM*TILE_N*4).''','''    occupancy, but only 32 B contiguous per row per atomic op); ``"lds"`` stages a
    weighted bf16 tile in LDS (BM*TILE_N*2, half the port's f32 staging) for 128 B
    contiguous atomics.''')
open(p,'w').write(s)
EOF
grep -n "LDS_BYTES =\|contiguous atomics" op_tests/test_a8w4_gemm2.py
```

命令（Benchmark the bf16-staging LDS epilogue.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd2 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd2 timeout 3000 python /tmp/sweep_g2.py "[dict(token=t,tile_m=m,epilog=e) for t in (128,512) for m in (64,32,16) for e in ('lds',)]" 2 2>&1 | grep -E "BEST|Error|Traceback|assert"; for d in /tmp/fd2/a8w4_gemm2*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Restructure gemm2 body into run_rows(rows) and add runtime row-variant dispatch (scripted re-indent).）：
```bash
cd /sgl-workspace/aiter && python3 - <<'EOF'
p='op_tests/test_a8w4_gemm2.py'
s=open(p).read()
a=s.index('        tx = fx.Int32(gpu.thread_id("x"))\n        a_src_tile, a_dst_tile = [], []')
b=s.index('    @fx.struct\n    class SharedStorage:')
old=s[a:b]
# pieces to keep verbatim
w_start=old.index('        # ---- W columns: wave owns TILE_N/4 output channels')
w_end=old.index('        # ---- accumulators')
w_block=old[w_start:w_end]
a_block=old[:w_start]                       # tx + A addressing + store_a_tile + load_a
acc_on=old[w_end:]                          # acc .. epilogue
# mma_atom stays shared: pull it out of acc_on
mma_line='        mma_atom = fx.make_mma_atom(fx.rocdl.MFMA(16, 16, 32, fx.Float8E4M3FNUZ))\n\n'
assert mma_line in acc_on
acc_on=acc_on.replace(mma_line,'')
def indent(t): return ''.join(('    '+l if l.strip() else l) for l in t.splitlines(True))
a_block=a_block.replace('        tx = fx.Int32(gpu.thread_id("x"))\n','')
a_block=a_block.replace('range_constexpr(A_LOADS)','range_constexpr(A_LOADS)')
acc_on=acc_on.replace('range(M_REPEAT)','range(M_REPEAT)')
new=('        tx = fx.Int32(gpu.thread_id("x"))\n\n'
 + w_block
 + mma_line
 + '        def run_rows(rows):\n'
 + '            """A load, K loop, dequant and scatter for the first ``rows`` rows."""\n'
 + '            M_REPEAT = rows // 16  # 16-row MFMA blocks\n'
 + '            A_LOADS = rows * TILE_K // (256 * 16)  # 16 B A copies per thread\n\n'
 + indent(a_block)
 + indent(acc_on).replace('                BM,\n                N_OUT,\n                TILE_N,','                rows,\n                N_OUT,\n                TILE_N,')
 + '''
        # ---- row-variant dispatch ------------------------------------------------
        if const_expr(dyn_rows):
            # Valid rows of a sorted block are contiguous from its start, so the
            # first 16-row sub-block whose first row is padding bounds the work.
            pad = {
                i: (
                    fx.Int32(
                        rocdl.readfirstlane(
                            T.i32,
                            _raw(_global_i32_at(arg_stids, m_row + fx.Int32(16 * i))),
                        )
                    )
                    & fx.Int32(0x00FFFFFF)
                )
                >= i32_M
                for i in range(1, BM // 16)
            }

            def _dispatch_from(i):
                # sub-blocks 0..i-1 hold valid rows; decide on sub-block i.
                if i == BM // 16:
                    run_rows(BM)
                    return
                cond = pad[i]

                @flyc.jit
                def _dispatch():
                    if cond:
                        run_rows(16 * i)
                    else:
                        _dispatch_from(i + 1)

                _dispatch()

            _dispatch_from(1)
        else:
            run_rows(BM)

''')
s=s[:a]+new+s[b:]
# compile-level constants that are now per-variant
s=s.replace('''    M_REPEAT = BM // 16  # 16-row MFMA blocks per tile
    N_REPEAT''','''    N_REPEAT''')
s=s.replace('''    A_LOADS = BM * TILE_K // (256 * 16)  # 16 B A copies per thread per tile
    # LDS epilogue''','''    # LDS epilogue''')
open(p,'w').write(s)
EOF
grep -n "M_REPEAT\|A_LOADS\|dyn_rows" op_tests/test_a8w4_gemm2.py | head -30
```

命令（Benchmark dyn_rows vs static at 128/512 tokens.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd2 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd2 timeout 3000 python /tmp/sweep_g2.py "[dict(token=t,tile_m=m,dyn_rows=d) for t in (128,512) for m in (64,32,16) for d in (False,True) if not (m==16 and d)]" 2 2>&1 | grep -E "BEST|Error|Traceback|assert|rror"; for d in /tmp/fd2/a8w4_gemm2*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

Now add the `dyn_rows` parameter through compile/launcher/bench/CLI.

命令（Get traceback for dyn_rows failure.）：
```bash
cd /sgl-workspace/aiter && timeout 600 python /tmp/sweep_g2.py "[dict(token=128,tile_m=64,dyn_rows=True)]" 1 2>&1 | grep -B 30 "IndexError" | grep -E "File|Error|line" | tail -15
```

命令（Re-run dyn_rows benchmark after fix.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd2 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd2 timeout 3000 python /tmp/sweep_g2.py "[dict(token=t,tile_m=m,dyn_rows=d) for t in (128,512) for m in (64,32,16) for d in (False,True) if not (m==16 and d)]" 2 2>&1 | grep -E "BEST|Error|Traceback|assert|rror"; for d in /tmp/fd2/a8w4_gemm2*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Check dyn_rows at larger token counts and hot routing for regressions.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/sweep_g2.py "[dict(token=t,tile_m=m,dyn_rows=d,routing=r) for t in (1024,2048) for r in ('uniform','hot') for m in (64,32) for d in (False,True)] + [dict(token=512,tile_m=m,dyn_rows=d,routing='hot') for m in (64,32) for d in (False,True)]" 2 2>&1 | grep -E "BEST|rror"
```

命令（Run pytest matrix and a direct-epilogue + dyn_rows correctness check.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_gemm2.py -q 2>&1 | tail -2 && timeout 1200 python /tmp/sweep_g2.py "[dict(token=512,tile_m=64,epilog='direct',dyn_rows=True), dict(token=512,tile_m=32,epilog='direct',dyn_rows=True)]" 1 2>&1 | grep -E "BEST|rror"
```

Also update module docstring and check correctness of `direct` path still works.

token<1024 时 gemm2 已经快了 34–46%，128 token 基本贴到带宽上限。最有用的一点是：沿用生产配置的 block_m=64，不用改排序、也不用重新 tune stage1，就能拿到大部分收益。pytest 8 个用例全过（含热点专家路由），所有改动都在 [op_tests/test_a8w4_gemm2.py](op_tests/test_a8w4_gemm2.py) 里。

**做了什么**
1. **写回暂存从 f32 改成 bf16**（缺省 `epilog="lds"`）：先在 MFMA 累加器的布局下乘好路由权重，再转成 bf16 存进 LDS。
   - 转 bf16 的时机和原版一样，数值完全相同。
   - 暂存只占原来一半 LDS（BM64 从 32 KB 降到 16 KB），每 CU 能跑的 WG 翻倍。原子加仍保持每行 128 B 连续。
2. **跳过全 padding 的 16 行子块**（`dyn_rows=True`）：每个 WG 先读各个 16 行子块首行的 `sorted_ids`，找到第一个全是 padding 的子块，A 加载、MFMA、dequant 和写回都只做到它之前为止。16、32、…、BM 几种行数都编进同一个 kernel，按运行时结果选。权重读取量不变。
3. **试过但没采用的：不经过 LDS、直接从累加器做原子加**（`epilog="direct"`，保留为可选项）。它在 BM64 上变快，但每条原子指令每行只覆盖 32 B 连续地址，BM32/16 时反而慢 12–20%，所以没设为缺省。
4. **修了一个坑**：嵌套的 `@flyc.jit` 函数不会因为传入的 Python 整数不同而重新生成。所以写回函数改成从累加器列表长度推算行数，而不是用传进来的 BM。

**结果**（uniform 路由，每个配置跑 2 轮取最小值，单位 us）

| token | CSV 生产 us2 | port BM64 | 新 BM64 不跳过 | **新 BM64 + 跳过** | **新 BM32 + 跳过** |
|---|---|---|---|---|---|
| 128 | 83.5 | 77.4 | 70.6 | **41.9** | **37.5** |
| 512 | 97.8 | 85.1 | 77.2 | **56.4** | **51.6** |
| 1024 | 112.4 | 95.6 | 83.2 | 72.3 | 75.1 |
| 2048 | 179.2 | 150.9 | **118.7** | 125.6 | 121.4 |

- **热点专家路由**：512 token 时 BM64 + 跳过从 port 的 95.5 降到 63.2；BM32 + 跳过降到 56.5。
- **离带宽上限**：128 token 时 37.5 us，对应约 3.7 TB/s，基本贴住上限（约 35 us）。512 token 时 51.6 us，离上限（约 36 us 的纯权重读取）还差约 15 us，主要是 33.5 MB 原子加的成本。
- **2048 token**：跳过 padding 子块反而略慢（BM64 慢约 6%），因为这时几乎每个块都是满的，多出的探测读取和代码体积就成了纯开销。
  - 缺省 `--tile` 两项都开了跳过（`64,128,1` 和 `32,128,1`），所以缺省 sweep 里 2048 token 测的是这条稍慢的路径。
  - 2048 token 及以上建议关掉跳过，用 BM64 + bf16 暂存，比 port 快 22%。

**命令行和测试**
- `--tile` 第三个值表示是否跳过 padding 子块，缺省 `64,128,1 32,128,1`。表里的 port 列就是不跳过、f32 暂存的原版基线。
- pytest 参数矩阵：tile_m {64, 32} × 跳过开关 × 两种路由。

**还没做**
- 持久化 WG，在做当前 tile 的原子写回时预取下一个 tile 的 W2。512 token 剩下约 15 us 的差距主要在原子加，这一条能否明显收回还需要实测，暂缓。
- 接入生产：在 fp8r 的 stage2 注册表里加上跳过 padding 子块和 bf16 暂存这两个开关。block_m=64 时不用动 stage1。


---

## 11. 请求（2026-10-28 10:49 UTC）

> 先把新gemm1和gemm2组合成完整的fused_moe, 接入test_flydsl_a16wfp4_silu_e2e测试用例，跟现有fused_moe的选择进行端到端对比

命令（Check how fused_moe picks the tuned config (env vars).）：
```bash
cd /sgl-workspace/aiter && env | grep -i -E "aiter|fmoe" ; grep -rn "AITER_CONFIG_FMOE" aiter/jit/core.py aiter/fused_moe.py 2>/dev/null | head -5
```

命令（Find which tuned fmoe CSVs contain the fp8r (a8w4) configs.）：
```bash
cd /sgl-workspace/aiter && ls aiter/configs/ | grep -i fmoe | head; ls aiter/configs/model_configs 2>/dev/null | grep -i -E "mimo|a8w4" | head; grep -l "afp8r" aiter/configs/*.csv aiter/configs/model_configs/*.csv 2>/dev/null | head
```

命令（See which config the default fused_moe uses for the 512-token Mimo shape.）：
```bash
cd /sgl-workspace/aiter && grep -h ",512,4096,256,256,8," aiter/configs/tuned_fmoe.csv aiter/configs/model_configs/*fmoe*.csv | cut -d, -f1-3,15,18,21 ; grep -n "model_configs" aiter/jit/core.py | head -5
```

Now add the combined pipeline and wire it into the e2e test.

命令（Run the e2e test with the default config (a16w4) and with the a8w4 tuned CSV as baseline.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest -s op_tests/test_flydsl_moe_a16wfp4.py::test_flydsl_a16wfp4_silu_e2e -q 2>&1 | grep -E "us |TB/s|passed|failed|Error|error" | tail -10; echo ===; AITER_CONFIG_FMOE=$PWD/mimo_v2.6_flash_a8w4_tuned_fmoe.csv timeout 1800 python -m pytest -s op_tests/test_flydsl_moe_a16wfp4.py::test_flydsl_a16wfp4_silu_e2e -q 2>&1 | grep -E "us |TB/s|passed|failed|Error|error" | tail -10
```

新的 gemm1 + gemm2 组成的 A8W4 fused_moe 已接入 `test_flydsl_a16wfp4_silu_e2e`。在 512 token 下比现有 fused_moe 快 1.45–1.58x，精度和现有 A8W4 路径完全一致，测试通过。

**实测**（token=512，4096/256/256/8）

| 实现 | 无环境变量（缺省走 a16w4 CSV） | `AITER_CONFIG_FMOE=mimo_v2.6_flash_a8w4_tuned_fmoe.csv` | cos_diff |
|---|---|---|---|
| fused_moe（当前配置选择的实现） | 237.5 us | 246.0 us | 9.4e-6（a16w4） / 9.95e-4（a8w4） |
| 新 A8W4，block_m=32 | **154.6 us（1.54x）** | **156.1 us（1.58x）** | 9.95e-4 |
| 新 A8W4，block_m=64 | 163.5 us（1.45x） | 161.4 us（1.52x） | 9.95e-4 |

- 新流水线的 cos_diff 和生产 A8W4 一样，都是 9.95e-4，误差来自 fp8 激活量化本身，阈值是 1e-2。
- 不设环境变量时，仓库缺省配置走的是 bf16 激活的 a16w4，精度更高（9.4e-6），但比新 A8W4 慢 1.5 倍。
- 新流水线的时间包含排序和两次 fp8 行量化，大致是：gemm1 约 84 us + gemm2 约 52 us + 排序/量化约 18 us。
- block_m=64 和 CSV 的分块大小相同，排序不用改，也能拿到 1.5x。

**改了什么**（只改了 [op_tests/test_flydsl_moe_a16wfp4.py](op_tests/test_flydsl_moe_a16wfp4.py)）
- `a8w4_prepare_weights(...)`：处理只和权重有关、生产中可缓存的部分——预排好的 mxfp4 W1/W2 与 scale 的 u8 视图，以及 W1 每个输出通道的最大指数。不计入计时。
- `a8w4_fused_moe(hidden_states, weights, topk_weights, topk_ids, block_m=32)`：完整流程依次是：
  1. `moe_sorting`，同时得到清零的输出 buffer
  2. 激活做 fp8 行量化
  3. 新 gemm1（gate+up 加 SiLU）
  4. 中间结果做 fp8 行量化（只处理有效行）
  5. 新 gemm2（原子加写回输出 buffer）
- `A8W4_E2E_CFGS` 记录两种 block_m 下两个 stage 的配置：
  - **block_m=32**：gemm1 预取 + XCD swizzle，gemm2 跳过全 padding 子块。
  - **block_m=64**：gemm1 用 `dyn_m`，gemm2 跳过全 padding 子块。
- 新 kernel 直接从同目录的 `test_a8w4_gemm1.py` / `test_a8w4_gemm2.py` 导入。
- **测试流程**：原有 fused_moe 的计时和断言不变。之后仅在 gfx942 上对两种 block_m 各跑一次新流水线（先预热编译、再计时），打印耗时、cos_diff 和加速比，并断言输出无 NaN、cos_diff < 1e-2。

两次运行的命令：

```bash
pytest -s op_tests/test_flydsl_moe_a16wfp4.py::test_flydsl_a16wfp4_silu_e2e
AITER_CONFIG_FMOE=$PWD/mimo_v2.6_flash_a8w4_tuned_fmoe.csv pytest -s op_tests/test_flydsl_moe_a16wfp4.py::test_flydsl_a16wfp4_silu_e2e
```


---

## 12. 请求（2026-10-28 12:49 UTC）

> 把gemm1和gemm2融合成一个kernel，gemm1的计算结果暂存到LDS中并按照per-token量化，然后直接加载到gemm2中继续计算，仿照已有的gemm1 & gemm2 实现为单个文件test_a8w4_fmoe.py

命令（First run of the fused kernel test at 512 tokens, plus register/LDS stats.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd3 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd3 timeout 1800 python op_tests/test_a8w4_fmoe.py -t 512 -r uniform 2>&1 | grep -E "^\|  |checkAllclose|Error|error|Traceback|File \"/sgl" | cut -c1-250 | tail -20; for d in /tmp/fd3/a8w4_fmoe*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:\|private_segment_fixed_size:\|vgpr_spill' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Inspect mismatch details between fused and 2-kernel outputs.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_fmoe.py -t 512 -r uniform 2>&1 | grep -E "delta|fused vs|^\|  " | python3 -c "
import sys
for l in sys.stdin:
    if l.startswith('|'):
        r=[c.strip() for c in l.strip().strip('|').split('|')]; print(r[10:])
    else: print(l.strip()[:200])
"
```

命令（Analyze where fused and 2-kernel outputs differ.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/dbg_fmoe.py <<'EOF'
import importlib.util, torch, sys
sys.path.insert(0, "op_tests")
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
cap = {}
orig = t.checkAllclose
def cc(a, b, **kw):
    cap['a'], cap['b'] = a, b
    return orig(a, b, printLog=False, **kw)
t.checkAllclose = cc
r = t.bench_a8w4_fmoe(512, 4096, 256, 256, 8)
a, b = cap['a'], cap['b']   # 2kernel, fused
d = (a - b).abs()
print("ref absmean", a.abs().mean().item(), "absmax", a.abs().max().item())
print("delta mean", d.mean().item(), "max", d.max().item())
bad = ~torch.isclose(a, b, rtol=2e-2, atol=1e-1)
rows = bad.any(1).nonzero().squeeze(1)
cols = bad.any(0).nonzero().squeeze(1)
print("bad rows", rows.numel(), rows[:20].tolist())
print("bad cols", cols.numel(), cols[:40].tolist())
rel = d / a.abs().clamp_min(1e-3)
print("median rel", rel.median().item())
r0 = rows[0].item()
print("row", r0, "a", a[r0, :8].tolist(), "b", b[r0, :8].tolist())
EOF
timeout 1800 python /tmp/dbg_fmoe.py 2>&1 | grep -v WARNING | tail -8
```

命令（Profile phase split (full vs gemm1-only) for num_waves 4/8.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/prof_fmoe.py <<'EOF'
import importlib.util, torch, sys
sys.path.insert(0, "op_tests")
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
from aiter.test_common import run_perftest
from aiter import dtypes, QuantType
import aiter
tok, H, I, E, K = int(sys.argv[1]), 4096, 256, 256, 8
torch.manual_seed(0)
inp = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
w1 = torch.randn((E, 2*I, H), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, H, I), dtype=dtypes.bf16, device="cuda")
score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
tw, ti = t.fused_topk(inp, score, K, True)
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, s1 = tq(w1, quant_dtype=dtypes.fp4x2); w2q, s2 = tq(w2, quant_dtype=dtypes.fp4x2)
del w1, w2
w1q = w1q.view(E, 2*I, H//2); w2q = w2q.view(E, H, I//2)
W = t.a8w4_prepare_weights(t.shuffle_weight_a16w4(w1q,16,False), t.shuffle_weight_a16w4(w2q,16,False),
                           t.shuffle_scale_a16w4(s1,E,False), t.shuffle_scale_a16w4(s2,E,False))
cfgs = eval(sys.argv[2])
for c in cfgs:
    c = dict(c)
    skip = c.pop("skip", False)
    if skip:
        orig = t.compile_a8w4_fmoe
        fn = lambda: t.a8w4_fmoe(inp, W, tw, ti, **c)
        # route compile through the skip flag
        t.compile_a8w4_fmoe = lambda **kw: orig(_skip_gemm2=True, **kw)
        fn(); torch.cuda.synchronize(); _, us = run_perftest(fn)
        t.compile_a8w4_fmoe = orig
    else:
        fn = lambda: t.a8w4_fmoe(inp, W, tw, ti, **c)
        fn(); torch.cuda.synchronize(); _, us = run_perftest(fn)
    print("RES", c, "skip_gemm2" if skip else "", f"{us:.1f}", flush=True)
EOF
timeout 1800 python /tmp/prof_fmoe.py 512 "[dict(num_waves=8), dict(num_waves=8, skip=True), dict(num_waves=4), dict(num_waves=4, skip=True)]" 2>&1 | grep RES
```

命令（Locate section markers for the rewrite.）：
```bash
cd /sgl-workspace/aiter && grep -n "Phase 1\|gemm1 epilogue\|Phase 2\|@fx.struct\|def load_a\|def _swizzle\|def load_w_codes" op_tests/test_a8w4_fmoe.py
```

命令（Rewrite phase 1 as a pipelined double-buffered K loop and phase 2 with one-slice W2 prefetch (scripted region replacement).）：
```bash
cd /sgl-workspace/aiter && python3 - <<'EOF'
p='op_tests/test_a8w4_fmoe.py'
s=open(p).read()

# ---------------- load_a gets a slot byte offset ----------------
old_load_a='''        def load_a(mi, ku, tile_k):
            """v8 fp8 A fragment of K-step ku from the swizzled region0 tile."""
            row = lane_mod_16 + fx.Int32(mi * 16)
            col = lane_div_16 * fx.Int32(32) + fx.Int32((ku // 4) * 128 + (ku % 4) * 8)
            off = (row * fx.Int32(tile_k) + _swizzle(row, col, tile_k)) // fx.Int32(8)
'''
new_load_a='''        def load_a(mi, ku, tile_k, slot_bytes=0):
            """v8 fp8 A fragment of K-step ku from a swizzled region0 tile."""
            row = lane_mod_16 + fx.Int32(mi * 16)
            col = lane_div_16 * fx.Int32(32) + fx.Int32((ku // 4) * 128 + (ku % 4) * 8)
            off = (row * fx.Int32(tile_k) + _swizzle(row, col, tile_k)) // fx.Int32(8)
            off = off + fx.Int32(slot_bytes) // fx.Int32(8)
'''
assert old_load_a in s; s=s.replace(old_load_a,new_load_a)

a=s.index('        # =====================================================================\n        # Phase 1: gemm1')
b=s.index('        # ---- gemm1 epilogue: dequant')
phase1='''        # =====================================================================
        # Phase 1: gemm1 (gate | up) over K = H, software-pipelined: tile kt+1 (A1
        # via VGPRs into the other LDS slot, W1 into staging VGPRs) is loaded while
        # kt computes; one barrier per tile.
        # =====================================================================
        x_tiles = fx.logical_divide(
            _global_i32_buffer_view(arg_x, fx.Int64(i32_ntok) * fx.Int64(H)),
            fx.make_layout(A1_COPY // 4, 1),
        )
        x_atom = fx.make_copy_atom(
            fx.rocdl.BufferCopy128b(2) if A1_COPY == 16 else fx.rocdl.BufferCopy64b(2),
            fx.Int32,
        )
        r0_tiles_a1 = r0_tiles16 if A1_COPY == 16 else r0_tiles8
        a1_write_atom = lds_write_atom if A1_COPY == 16 else lds_read_atom
        a_src_tile, a_dst_tile = [], []
        for i in range_constexpr(A1_LOADS):
            idx_b = tx * fx.Int32(A1_COPY) + fx.Int32(i * THREADS * A1_COPY)
            row = idx_b // fx.Int32(TILE_K1)
            col_bytes = idx_b % fx.Int32(TILE_K1)
            fused = fx.Int32(_global_i32_at(arg_stids, m_row + row))
            row_bytes = (fused & fx.Int32(0x00FFFFFF)) * fx.Int32(H)
            a_src_tile.append(
                (row_bytes + _swizzle(row, col_bytes, TILE_K1)) // fx.Int32(A1_COPY)
            )
            a_dst_tile.append((row * fx.Int32(TILE_K1) + col_bytes) // fx.Int32(A1_COPY))
        a1_regs = [
            fx.make_rmem_tensor(fx.make_layout(A1_COPY // 4, 1), fx.Int32)
            for _ in range(A1_LOADS)
        ]

        def load_a1_global(base_k):
            kc = base_k // fx.Int32(A1_COPY)
            for i in range_constexpr(A1_LOADS):
                fx.copy(x_atom, fx.slice(x_tiles, (None, a_src_tile[i] + kc)), a1_regs[i])

        def store_a1_lds(slot):
            sc = fx.Int32(slot) * fx.Int32(A1_SLOT // A1_COPY)
            for i in range_constexpr(A1_LOADS):
                fx.copy(
                    a1_write_atom,
                    a1_regs[i],
                    fx.slice(r0_tiles_a1, (None, a_dst_tile[i] + sc)),
                )

        w1_tiles = _global_i32_buffer_tiles(arg_w1, min(W1_BYTES, 0xFFFFFFFF), 4)
        w1_atom = fx.make_copy_atom(fx.rocdl.BufferCopy128b(b_cache_mod1), fx.Int32)
        ws1_tiles = _global_i32_buffer_tiles(arg_w1_scale, min(WS1_BYTES, 0xFFFFFFFF), 1)
        ws_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(0), fx.Int32)
        expert_off1 = e * fx.Int32(N_OUT1)
        out_cols1 = []  # this lane's intermediate column per ni
        w1_base, sc1_base, sc1_npack = {}, {}, {}
        for ni in range_constexpr(N_REPEAT1):
            n_local = wave * fx.Int32(I_PER_WAVE) + fx.Int32(ni * 16)
            out_cols1.append(n_local + lane_mod_16)
            for gu in range_constexpr(2):
                n0 = expert_off1 + n_local + (inter_i32 if gu else fx.Int32(0))
                w1_base[gu, ni] = (
                    (n0 // fx.Int32(16)) * fx.Int32(W1_K0 * 64)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                sc1_base[gu, ni] = (
                    (n0 // fx.Int32(32)) * fx.Int32(SC1_STRIDE)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                sc1_npack[gu, ni] = (n0 // fx.Int32(16)) % fx.Int32(2)
        exp1 = [
            [
                fx.Int32(
                    _global_i32_at(
                        arg_w1_exp,
                        expert_off1 + c + (inter_i32 if gu else fx.Int32(0)),
                    )
                )
                for c in out_cols1
            ]
            for gu in range(2)
        ]
        # W1 staging registers (raw fp4 dwordx4 + packed e8m0 dwords) of one tile.
        w1_regs = {
            (gu, ni, g): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
            for gu in range(2)
            for ni in range(N_REPEAT1)
            for g in range(K1_GROUPS)
        }
        s1_regs = {
            (gu, ni, g2): fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32)
            for gu in range(2)
            for ni in range(N_REPEAT1)
            for g2 in range((K1_GROUPS + 1) // 2)
        }

        def load_w1_global(base_k):
            s_off = (base_k // fx.Int32(256)) * fx.Int32(64)
            for (gu, ni, g2), r in s1_regs.items():
                idx = sc1_base[gu, ni] + s_off + fx.Int32(g2 * 64)
                fx.copy(ws_atom, fx.slice(ws1_tiles, (None, idx)), r)
            w_off = (base_k // fx.Int32(128)) * fx.Int32(64)
            for (gu, ni, g), r in w1_regs.items():
                idx = w1_base[gu, ni] + w_off + fx.Int32(g * 64)
                fx.copy(w1_atom, fx.slice(w1_tiles, (None, idx)), r)

        def read_w1():
            raw, codes = {}, {}
            for (gu, ni, g), r in w1_regs.items():
                v4 = fx.Vector(fx.memref_load_vec(r))
                raw[gu, ni, g] = [fx.Int32(v4[j]) for j in range(4)]
                packed = fx.Int32(fx.Vector(fx.memref_load_vec(s1_regs[gu, ni, g // 2]))[0])
                codes[gu, ni, g] = packed.shrui(
                    fx.Int32((g % 2) * 16) + sc1_npack[gu, ni] * fx.Int32(8)
                ) & fx.Int32(0xFF)
            return raw, codes

        acc_layout = fx.make_layout(4, 1)
        zero4 = fx.Vector.filled(4, 0.0, fx.Float32)
        acc1 = [
            [
                [fx.make_rmem_tensor(acc_layout, fx.Float32) for _ in range(N_REPEAT1)]
                for _ in range(M_REPEAT)
            ]
            for _ in range(2)
        ]
        for gu in range_constexpr(2):
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT1):
                    acc1[gu][mi][ni].store(zero4)

        def compute1(w_tile, slot):
            raw, codes = w_tile
            for ni in range_constexpr(N_REPEAT1):
                luts = [
                    [
                        _fp8_lut(codes[gu, ni, g], exp1[gu][ni], flush_tiny)
                        for g in range_constexpr(K1_GROUPS)
                    ]
                    for gu in range_constexpr(2)
                ]
                for ku in range_constexpr(K1_STEPS):
                    bs = [
                        _fp4x8_to_fp8x8(raw[gu, ni, ku // 4][ku % 4], luts[gu][ku // 4])
                        for gu in range_constexpr(2)
                    ]
                    for mi in range_constexpr(M_REPEAT):
                        a8 = load_a(mi, ku, TILE_K1, fx.Int32(slot) * fx.Int32(A1_SLOT))
                        for gu in range_constexpr(2):
                            _mma_fp8(mma_atom, acc1[gu][mi][ni], a8, bs[gu])

        def stage1(kt, slot, prefetch):
            rocdl.s_waitcnt(lgkmcnt=0)
            gpu.barrier()  # A1(kt) in LDS; slot (kt+1)%2 free
            w_tile = read_w1()
            if const_expr(prefetch):
                next_k = (kt + fx.Int32(1)) * fx.Int32(TILE_K1)
                load_a1_global(next_k)
                load_w1_global(next_k)
                rocdl.sched_barrier(0)  # keep the prefetch ahead of the MFMAs
            compute1(w_tile, slot)
            if const_expr(prefetch):
                store_a1_lds(fx.Int32(1) - slot)

        load_a1_global(fx.Int32(0))
        load_w1_global(fx.Int32(0))
        store_a1_lds(0)

        # range() lowers to scf.for only inside an AST-rewritten (@flyc.jit) function.
        @flyc.jit
        def _k1_loop(k_first):
            for kt in range(K1_TILES - 1):
                kt_i = k_first + fx.Int32(kt)
                stage1(kt_i, kt_i % fx.Int32(2), True)

        if const_expr(K1_TILES > 1):
            _k1_loop(fx.Int32(0))
        stage1(fx.Int32(K1_TILES - 1), (K1_TILES - 1) % 2, False)
        gpu.barrier()  # all A1 reads done: region0 becomes the A2 tile

'''
s=s[:a]+phase1+s[b:]

a=s.index('        def gemm2_tile(n_base):')
b=s.index('    @fx.struct')
phase2='''        # W2 staging registers of one TILE_N2 slice (prefetched one slice ahead).
        w2_regs = {
            (ni, g): fx.make_rmem_tensor(fx.make_layout(4, 1), fx.Int32)
            for ni in range(N_REPEAT2)
            for g in range(K2_GROUPS)
        }
        s2_regs = {
            (ni, g2): fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32)
            for ni in range(N_REPEAT2)
            for g2 in range((K2_GROUPS + 1) // 2)
        }
        e2_regs = [fx.make_rmem_tensor(fx.make_layout(1, 1), fx.Int32) for _ in range(N_REPEAT2)]
        e_atom = fx.make_copy_atom(fx.rocdl.BufferCopy32b(), fx.Int32)
        we2_tiles = _global_i32_buffer_tiles(arg_w2_exp, min(NE * H * 4, 0xFFFFFFFF), 1)

        def n2_col0(n_base, ni):
            return expert_off2 + n_base + wave * fx.Int32(N2_PER_WAVE) + fx.Int32(ni * 16)

        def load_w2_global(n_base):
            for ni in range_constexpr(N_REPEAT2):
                n0 = n2_col0(n_base, ni)
                fx.copy(e_atom, fx.slice(we2_tiles, (None, n0 + lane_mod_16)), e2_regs[ni])
                sc = (
                    (n0 // fx.Int32(32)) * fx.Int32(SC2_STRIDE)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                for g2 in range_constexpr((K2_GROUPS + 1) // 2):
                    fx.copy(
                        ws_atom,
                        fx.slice(ws2_tiles, (None, sc + fx.Int32(g2 * 64))),
                        s2_regs[ni, g2],
                    )
                base = (
                    (n0 // fx.Int32(16)) * fx.Int32(W2_K0 * 64)
                    + lane_div_16 * fx.Int32(16)
                    + lane_mod_16
                )
                for g in range_constexpr(K2_GROUPS):
                    fx.copy(
                        w2_atom,
                        fx.slice(w2_tiles, (None, base + fx.Int32(g * 64))),
                        w2_regs[ni, g],
                    )

        def read_w2(n_base):
            raw, codes, exps = [], [], []
            for ni in range_constexpr(N_REPEAT2):
                npack = (n2_col0(n_base, ni) // fx.Int32(16)) % fx.Int32(2)
                per_g, cod = [], []
                for g in range_constexpr(K2_GROUPS):
                    v4 = fx.Vector(fx.memref_load_vec(w2_regs[ni, g]))
                    per_g.append([fx.Int32(v4[j]) for j in range(4)])
                    packed = fx.Int32(fx.Vector(fx.memref_load_vec(s2_regs[ni, g // 2]))[0])
                    cod.append(
                        packed.shrui(fx.Int32((g % 2) * 16) + npack * fx.Int32(8))
                        & fx.Int32(0xFF)
                    )
                raw.append(per_g)
                codes.append(cod)
                exps.append(fx.Int32(fx.Vector(fx.memref_load_vec(e2_regs[ni]))[0]))
            return raw, codes, exps

        def stage2(n_base, prefetch):
            """One TILE_N2 slice: W2(n_base) is in the staging registers."""
            raw, codes, exps = read_w2(n_base)
            if const_expr(prefetch):
                load_w2_global(n_base + fx.Int32(TILE_N2))
                rocdl.sched_barrier(0)  # keep the prefetch ahead of the MFMAs
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT2):
                    acc2[mi][ni].store(zero4)
            for ni in range_constexpr(N_REPEAT2):
                luts = [
                    _fp8_lut(codes[ni][g], exps[ni], flush_tiny)
                    for g in range_constexpr(K2_GROUPS)
                ]
                for ku in range_constexpr(K2_STEPS):
                    b8 = _fp4x8_to_fp8x8(raw[ni][ku // 4][ku % 4], luts[ku // 4])
                    for mi in range_constexpr(M_REPEAT):
                        _mma_fp8(mma_atom, acc2[mi][ni], load_a(mi, ku, INTER), b8)
            # dequant * route weight -> bf16 stage [BM, TILE_N2] in region1
            f2 = [_channel_factor(x) for x in exps]
            for mi in range_constexpr(M_REPEAT):
                for ni in range_constexpr(N_REPEAT2):
                    v = Vec(acc2[mi][ni].load())
                    bf4 = Vec.from_elements(
                        [
                            v[k] * (row_a2s[mi][k] * f2[ni]) * row_w[mi][k]
                            for k in range_constexpr(4)
                        ],
                        fx.Float32,
                    ).to(fx.BFloat16)
                    col = wave * fx.Int32(N2_PER_WAVE) + fx.Int32(ni * 16) + lane_mod_16
                    for k in range_constexpr(4):
                        r = fx.Int32(mi * 16 + k) + lane_div_16 * fx.Int32(4)
                        r1_bf16[r * fx.Int32(TILE_N2) + col] = bf4[k]
            gpu.barrier()
            _scatter_rows(
                lds_r1, arg_out, arg_stids, m_row, n_base, i32_ntok, BM, THREADS, H,
                TILE_N2,
            )
            gpu.barrier()  # stage reads done before the next slice overwrites it

        load_w2_global(fx.Int32(0))

        @flyc.jit
        def _n2_loop(n_first):
            for nt in range(N2_TILES - 1):
                stage2((n_first + fx.Int32(nt)) * fx.Int32(TILE_N2), True)

        if const_expr(not _skip_gemm2):
            if const_expr(N2_TILES > 1):
                _n2_loop(fx.Int32(0))
            stage2(fx.Int32((N2_TILES - 1) * TILE_N2), False)

'''
s=s[:a]+phase2+s[b:]

# compile-level constants
s=s.replace('''    A1_LOADS = BM * TILE_K1 // (THREADS * 16)
''','''    # A1 gather: 16 B per thread copy when the tile allows it, else 8 B.
    A1_COPY = 16 if (BM * TILE_K1) % (THREADS * 16) == 0 else 8
    A1_LOADS = BM * TILE_K1 // (THREADS * A1_COPY)
    A1_SLOT = BM * TILE_K1  # one A1 tile; two slots (ping/pong) when K1_TILES > 1
''')
s=s.replace('''    assert (BM * TILE_K1) % (THREADS * 16) == 0, "A1 tile must be whole 16 B/thread"''','''    assert (BM * TILE_K1) % (THREADS * 8) == 0, "A1 tile must be whole 8 B/thread"''')
s=s.replace('''    R0 = max(BM * TILE_K1, BM * INTER)  # A1 tile -> A2 tile (fp8)''','''    R0 = max(BM * TILE_K1 * (2 if H > TILE_K1 else 1), BM * INTER)  # A1 x2 -> A2''')
open(p,'w').write(s)
EOF
grep -n "_skip_gemm2\|A1_COPY\|R0 = " op_tests/test_a8w4_fmoe.py | head
```

Now rewrite phase 1 (pipelined, double-buffered A1, variable copy width) and phase 2 (W2 prefetch).

命令（Profile pipelined fused kernel for 4/8/16 waves and phase split.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd3 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd3 timeout 1800 python /tmp/prof_fmoe.py 512 "[dict(num_waves=8), dict(num_waves=8, skip=True), dict(num_waves=16), dict(num_waves=16, skip=True), dict(num_waves=4)]" 2>&1 | grep -E "RES|Error|error" | head; for d in /tmp/fd3/a8w4_fmoe*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:\|private_segment_fixed_size:' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Set num_waves default to 16 and run the comparison matrix (fused vs 2-kernel vs fused_moe).）：
```bash
cd /sgl-workspace/aiter && sed -i 's/        default=\[(32, 8)\],/        default=[(32, 16)],/; s/    num_waves=8,\n):/XX/' op_tests/test_a8w4_fmoe.py && python3 - <<'EOF'
p='op_tests/test_a8w4_fmoe.py'
s=open(p).read()
s=s.replace('''    routing="uniform",
    block_m=32,
    num_waves=8,
):''','''    routing="uniform",
    block_m=32,
    num_waves=16,
):''')
s=s.replace('''    *,
    block_m=32,
    num_waves=8,
    n2_per_wave=32,''','''    *,
    block_m=32,
    num_waves=16,
    n2_per_wave=32,''')
s=s.replace('''    BM=32,
    NUM_WAVES=8,''','''    BM=32,
    NUM_WAVES=16,''')
open(p,'w').write(s)
EOF
grep -n "num_waves=16\|NUM_WAVES=16\|(32, 16)" op_tests/test_a8w4_fmoe.py; timeout 3000 python op_tests/test_a8w4_fmoe.py -t 128 512 2048 --tile 32,16 16,8 2>&1 | grep -E "^\|" | python3 -c "
import sys
rows=[[c.strip() for c in l.strip().strip('|').split('|')] for l in sys.stdin]
h=rows[0]; keep=['token','routing','block_m','num_waves','fused us','2kernel us','fused_moe us','fused cos','fused vs 2kernel err','speedup vs 2kernel']
idx=[h.index(k) for k in keep]
for r in [h]+rows[2:]: print(' | '.join(r[i] for i in idx))
"
```

命令（Locate LDS region definitions.）：
```bash
cd /sgl-workspace/aiter && grep -n "R2 = \|LDS_BYTES = \|lds_r2 = \|R0 + R1" op_tests/test_a8w4_fmoe.py
```

命令（Inspect host function signature for waves_per_eu plumbing.）：
```bash
cd /sgl-workspace/aiter && grep -n "    xcd_swizzle=1,\n    flush_tiny=True,\n):" op_tests/test_a8w4_fmoe.py; grep -n "def a8w4_fmoe" -A 12 op_tests/test_a8w4_fmoe.py | head -14; grep -n "num_waves=num_waves" op_tests/test_a8w4_fmoe.py
```

命令（Test occupancy variants (NW8 with waves_per_eu=4 for 2 WGs/CU) at 512/2048 tokens vs 2-kernel.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/prof2.py <<'EOF'
import importlib.util, torch, sys
sys.path.insert(0, "op_tests")
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
from aiter.test_common import run_perftest
from aiter import dtypes, QuantType
import aiter
H, I, E, K = 4096, 256, 256, 8
torch.manual_seed(0)
w1 = torch.randn((E, 2*I, H), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, H, I), dtype=dtypes.bf16, device="cuda")
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, s1 = tq(w1, quant_dtype=dtypes.fp4x2); w2q, s2 = tq(w2, quant_dtype=dtypes.fp4x2)
del w1, w2
w1q = w1q.view(E, 2*I, H//2); w2q = w2q.view(E, H, I//2)
W = t.a8w4_prepare_weights(t.shuffle_weight_a16w4(w1q,16,False), t.shuffle_weight_a16w4(w2q,16,False),
                           t.shuffle_scale_a16w4(s1,E,False), t.shuffle_scale_a16w4(s2,E,False))
two = t._two_kernel_moe()
W2k = {k: W[k] for k in ("w1","w2","w1_scale","w2_scale","w1_exp")}
for tok, routing in eval(sys.argv[1]):
    inp = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
    score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
    if routing == "hot":
        score[:, torch.randperm(E, device="cuda")[:E//32]] += 2.0
    tw, ti = t.fused_topk(inp, score, K, True)
    fn = lambda: two(inp, W2k, tw, ti, block_m=32); fn(); torch.cuda.synchronize()
    _, us2 = run_perftest(fn)
    for c in eval(sys.argv[2]):
        fn = lambda: t.a8w4_fmoe(inp, W, tw, ti, **c); fn(); torch.cuda.synchronize()
        _, us = run_perftest(fn)
        print("RES", tok, routing, c, f"fused={us:.1f} 2kernel={us2:.1f}", flush=True)
EOF
rm -rf /tmp/fd3 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd3 timeout 3000 python /tmp/prof2.py "[(512,'uniform'),(512,'hot'),(2048,'uniform')]" "[dict(num_waves=16), dict(num_waves=8), dict(num_waves=8, waves_per_eu=4), dict(num_waves=8, n2_per_wave=16, waves_per_eu=4)]" 2>&1 | grep -E "RES|rror"; for d in /tmp/fd3/a8w4_fmoe*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:\|private_segment_fixed_size:\|spill_count' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Run pytest for the fused kernel file.）：
```bash
cd /sgl-workspace/aiter && grep -n "help=\"block_m" op_tests/test_a8w4_fmoe.py; timeout 1800 python -m pytest op_tests/test_a8w4_fmoe.py -q 2>&1 | tail -2
```

融合 kernel 已写成 [op_tests/test_a8w4_fmoe.py](op_tests/test_a8w4_fmoe.py)，精度正确（pytest 2 个用例通过），但只在 128 token 时比现在的两 kernel 流水线快一点（约 3–7%）；512 token 均匀路由基本打平，有热点专家或 token 更多时反而慢 10–24%。对比当前生产 fused_moe（缺省配置），它快约 1.3–1.45 倍。

**结构**：一个 WG 处理一个排序后的 m-block（同一专家的 BM 行），依次做四步：
1. **gemm1**：fp8 激活 × W1 的全部 2×inter 列，K 方向做了双缓冲预取，乘 scale 后算 SiLU(gate)×up。
2. **暂存**：bf16 中间结果放进 LDS，取整位置和两 kernel 流水线一样。
3. **每行 fp8 量化**：一个 wave 负责一行，求最大值、生成 fp8 和行 scale，直接写成 gemm2 读 A 时用的 swizzle 布局。数学和 `quantize_rows` 逐位一致。
4. **gemm2**：A2 一直留在 LDS 里，按 model_dim 每次处理一段并预取下一段的 W2；乘 scale 和路由权重后，经 bf16 LDS 暂存做原子加写回。

LDS 分三段跨阶段复用：A1 双缓冲后来存 A2；bf16 中间结果后来做写回暂存；行 scale 放在 A2 后面的空余处。block_m=32、16 个 wave 时共 49 KB，没有寄存器溢出。

**精度**：和两 kernel 流水线对比，不匹配比例 ≤8e-6，差异只来自 bf16 原子加的顺序。和 bf16 参考的 cos_diff 约 1e-3，与现有 A8W4 路径一致。

**性能**（4096/256/256/8，单位 us；同一进程内交替测，单次噪声约 ±3%）

| token | 路由 | 融合 bm32/16 wave | 融合 bm16/8 wave | 两 kernel 流水线 | fused_moe（缺省配置） |
|---|---|---|---|---|---|
| 128 | uniform | 146 | **134** | 137 | 198 |
| 128 | hot | 132 | **122** | 130 | 190 |
| 512 | uniform | **152–160** | 209 | 153–158 | 227 |
| 512 | hot | 224–228 | 210 | **183** | 283 |
| 2048 | uniform | 363–368 | 431 | **326–330** | 494 |
| 2048 | hot | 366 | 441 | **325** | 499 |

**为什么融合没有更快**
- 融合省掉的只有中间结果约 6 MB 的读写、一次量化 kernel 和一次启动，合计约 10–15 us。
- 代价是并行度：WG 数只等于 m-block 数。512 token 均匀路由时只有 256 个，比 304 个 CU 还少；两 kernel 方案则是 m-block × n-block，有数千个 WG。
- 每个 WG 要串行读完一个专家的 W1（1 MB）和 W2（512 KB）。
- LDS 占 49 KB，每个 CU 只能放一个 WG，所以热点专家把 m-block 数推过 304 时（512 hot 有 312 个）会出现第二轮的尾部；不同 WG 之间也无法互相掩盖访存延迟。
- 试过 8 个 wave 加 `waves_per_eu=4` 让每个 CU 放两个 WG，但寄存器溢出 50 个左右，速度慢了一倍。

**命令**：
- `python op_tests/test_a8w4_fmoe.py`：参数风格和 gemm1/gemm2 一致，`--tile` 格式为 `block_m,num_waves`，缺省是 `32,16` 和 `16,8`。
- 结果表同时列出融合 kernel、两 kernel 流水线和 fused_moe 的耗时，以及相互的加速比。
- 两 kernel 对比项直接复用 e2e 测试里的 `a8w4_fused_moe`。

**如果要继续把融合做快**：
1. **把 W1 预取提前到 gemm2 阶段**：WG 持久化循环处理多个 m-block，在当前块的 gemm2 期间就开始拉下一个块的 W1，让两段访存重叠。
2. **把 gemm1 的寄存器压到 128 以下**：A1 改为按 ku 现读，同时去掉 W1 的寄存器暂存。这样配合 LDS 32 KB，每个 CU 可以放两个 WG。

两条都要较大改动。就目前的数据，均匀路由、token≤512 时融合版和两 kernel 基本持平，其他情况两 kernel 更快。


---

## 13. 请求（2026-10-28 13:36 UTC）

> gemm2的A2量化好后不能加载并一直存放在寄存器中吗？

命令（Compare A2-in-LDS vs A2-in-registers for both tile configs and check VGPR/spills.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd3 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd3 timeout 3000 python /tmp/prof2.py "[(128,'uniform'),(512,'uniform'),(512,'hot'),(2048,'uniform')]" "[dict(a2_in_regs=False), dict(a2_in_regs=True), dict(block_m=16,num_waves=8,a2_in_regs=False), dict(block_m=16,num_waves=8,a2_in_regs=True)]" 2>&1 | grep -E "RES|rror"; for d in /tmp/fd3/a8w4_fmoe*; do echo "$(basename $d) $(grep -h 'vgpr_count\|group_segment_fixed_size:\|spill_count' $d/21_final_isa.s | tr -s ' ' | tr '\n' ' ')"; done
```

命令（Re-run pytest with A2 held in registers (default).）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest op_tests/test_a8w4_fmoe.py -q 2>&1 | tail -1
```

可以，我已经实现了（`a2_in_regs=True`，现为缺省），结果正确、pytest 通过，但实测没有带来可测的加速。

**为什么放得下**
- 量化后的 A2 只有 BM × inter 个 fp8（bm32/i256 时 8 KB）。每个 wave 都要用到全部行和全部 K，按 MFMA 的 A 片段布局，每个 lane 只需 BM/16 × inter/32 × 2 个 VGPR，即 32 个。
- 现在的做法：requant 写进 LDS 后，每个 wave 一次性读成 `a2_frags`，之后 model_dim 的每一段都直接用这些寄存器，不再读 LDS。
- 这时第一阶段 gemm1 的累加器和 W1 暂存寄存器都已不用，所以寄存器峰值没涨（bm32/16 wave 从 126 降到 121，bm16/8 wave 保持 150），也没有溢出。

**实测**（单位 us）

| token | 路由 | bm32/16 wave：A2 在 LDS → 寄存器 | bm16/8 wave：A2 在 LDS → 寄存器 | 两 kernel 流水线 |
|---|---|---|---|---|
| 128 | uniform | 142.3 → 142.1 | 134.9 → 133.6 | 134.8 |
| 512 | uniform | 157.5 → 157.6 | 214.6 → 213.9 | 153.4 |
| 512 | hot | 218.9 → 219.3 | 212.3 → 211.8 | 179.7 |
| 2048 | uniform | 367.7 → 371.2 | 434.9 → 432.8 | 330.5 |

差异都在 ±1% 以内，属于噪声。

**为什么没变快**：gemm2 阶段卡在别处，读 A2 的 LDS 本来就不是瓶颈。
- 每个 wave 每段只有 16 条 `ds_read_b64`，而且和 MFMA、W2 解码重叠在一起，占比约 1–2%。
- 真正的限制是：每个 CU 只有一个 WG 在拉 W2（预取只能提前一段），每段还要做 bf16 暂存加原子写回，中间夹着两次 barrier。

**这一步唯一的实际好处**：gemm2 阶段 region0（A1/A2 区域）空出来了。可以把它用作写回暂存的第二块缓冲：两段交替使用 region0 和 region1，就能省掉每段的第二次 barrier，让第 j 段的原子写回和第 j+1 段的计算重叠。
- 前提是 bm32 时把每 wave 的列数从 32 改成 16，使暂存只需 16 KB、能放进 region0。
- 这比单纯省 LDS 读更可能见效，但仍解决不了每个 CU 只有一个 WG 的根本问题。要不要接着做这一步？


---

## 14. 请求（2026-10-28 13:41 UTC）

> 好的

命令（Locate final stage2 call.）：
```bash
cd /sgl-workspace/aiter && grep -n "stage2(fx.Int32((N2_TILES - 1) \* TILE_N2), False)" op_tests/test_a8w4_fmoe.py
```

命令（Benchmark double-buffered staging (bm32 n2_per_wave=16, bm16/8) vs previous configs.）：
```bash
cd /sgl-workspace/aiter && sed -i 's/fused = t.a8w4_fmoe/fused = t.a8w4_fmoe/' /tmp/prof2.py && timeout 3000 python /tmp/prof2.py "[(128,'uniform'),(512,'uniform'),(512,'hot'),(2048,'uniform')]" "[dict(), dict(n2_per_wave=16), dict(n2_per_wave=16, a2_in_regs=False), dict(block_m=16,num_waves=8)]" 2>&1 | grep -E "RES|rror"
```

命令（Re-check defaults and bm16 variants, then run pytest.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 python /tmp/prof2.py "[(128,'uniform'),(512,'uniform')]" "[dict(), dict(block_m=16,num_waves=8), dict(block_m=16,num_waves=8,n2_per_wave=32)]" 2>&1 | grep -E "RES|rror" ; timeout 1800 python -m pytest -q op_tests/test_a8w4_fmoe.py 2>&1 | tail -2
```

命令（Run pytest and CLI benchmark summary.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest -q op_tests/test_a8w4_fmoe.py 2>&1 | tail -1 && timeout 1800 python op_tests/test_a8w4_fmoe.py -t 128 512 2>&1 | grep -vE "WARNING|numa|system-opt|ended" | tail -12
```

Grep result was stale; code is correct. Final validation:

暂存双缓冲已经做好，正确性测试通过（pytest 2 passed）。在 bm32 上融合 kernel 快了约 2–4%，但 hot 路由和 2048 token 仍然比 2-kernel 慢。

**改动**（[op_tests/test_a8w4_fmoe.py](op_tests/test_a8w4_fmoe.py)）
- 新增编译期开关 `DB_STAGE`，条件是 A2 放在寄存器、有不止一个 slice，并且 `BM*TILE_N2*2 <= R0`。开启后：
  - 偶数 slice 的写回暂存用 region1，奇数 slice 用 region0。
  - 去掉每个 slice 中 scatter 之后的那次 barrier。
  - kernel 名加 `_db` 后缀。
- 为什么一个 barrier 就够：
  - slice j+2 会重用 slice j 的缓冲。任何 wave 要往这块缓冲写，必须先过 slice j+1 的 barrier；而每个 wave 到达这个 barrier 之前，已经读完了 slice j 的暂存。
  - A2 和行 scale 原本在 region0，它们在 slice 0 就已经全部用完，所以 slice 1 才开始写 region0 是安全的。
- 缺省参数改动：`compile_a8w4_fmoe` 的 `N2_PER_WAVE` 改为 16。`a8w4_fmoe` 的 `n2_per_wave=None` 时自动选择：
  - bm≥32 用 16，这样 16 KB 的暂存正好放进 region0；
  - bm16 用 32，因为实测这个配置用 16 反而稍慢。

**性能**（单位 us，`/tmp/prof2.py` 测得，单次测量有 ±3% 噪声）

| 场景 | 改前 bm32 | 双缓冲 bm32（npw16） | 2kernel |
|---|---|---|---|
| 128 uniform | 144.7 | 139.2 | 139.9 |
| 512 uniform | 159.1 | 153.9 | 156.4 |
| 512 hot | 220.4 | 216.7 | 178.4 |
| 2048 uniform | 366.5 | 358.9 | 323.5 |

- 128 token：bm16/nw8 约 133.5 us，是融合 kernel 最快的配置，比 2-kernel 快约 2–7%。
- 512 uniform：bm32 大致和 2-kernel 持平，约 1.47 倍于 fused_moe。

**结论**：hot 路由和 2048 token 的瓶颈还是 WG 太少，大约每个 CU 只有一个 WG（16 个 wave、约 49 KB LDS），而且 m-block 数量略多于 CU 数时会留下长尾。下一步可以考虑：
- 改成持久化 WG，在 gemm2 阶段预取下一个 m-block 的 W1；
- 把 VGPR 压到 ≤128、LDS 压到 ≤32 KB，让每个 CU 能放两个 WG。

经验已记到 repo memory。


---

## 15. 请求（2026-10-28 13:51 UTC）

> 为何单kernel的实现要每个CTA 16wave这么

用 16 个 wave 主要有两个原因：

- 融合本身要求一个 CTA 包下一个 m-block 的全部计算，所以 grid 很小，大约每个 CU 只有一个 CTA。
- 在这个前提下，16 个 wave 是 inter=256 时能切出的最大 wave 数，也是寄存器允许的上限。

**1. 融合迫使一个 CTA 包下整个 m-block**
- requant 要对每行的完整中间结果（inter 256 列）求 amax，所以一个 m-block 的 gemm1 输出（BM×512，gate 和 up 各 256 列）必须在同一个 CTA 内算完，并且留在 LDS 里。
- gemm2 同样要在这个 CTA 里把 BM×4096 的输出全部算完。
- 每个 CTA 的工作量，相当于 2-kernel 方案中 gemm1 的 4 个 CTA 加上 gemm2 的 32 个 CTA（tile_n 都是 128）。
- 所以 grid 只等于 m-block 数。512 token、bm32 时约 256–300 个，而 MI300X 有 304 个 CU，大约每个 CU 一个 CTA。

**2. 每个 CU 只有一个 CTA，CTA 内的 wave 数就是这个 CU 的全部并行度**
- 每个 m-block 要读一整个专家的权重：W1 约 1 MB，W2 约 0.5 MB。
- 这个阶段完全受带宽限制，要靠足够多的 wave 同时挂起访存，才能把 HBM 跑满。
- 当前约 121 VGPR，按 8 个一档取整到 128，每个 SIMD 最多 4 个 wave，4 个 SIMD 一共 16 个。所以 16 正好是单 CTA 能拿到的最大占用。

**3. 按 inter=256 切分，16 是上限**
- gemm1：每个 wave 负责 16 列 gate 和 16 列 up（`I_PER_WAVE = 256/16 = 16`），这已是 MFMA 的最小宽度，wave 数不能再多。
- gemm2：每个 slice 宽 16×16=256 列，4096 列需要 16 个串行 slice。wave 越少，slice 越多。
- requant：每个 wave 处理 BM/16 = 2 行。

**代价**
- 每次 `gpu.barrier` 都会让整个 CU 一起停下等待，因为这时没有第二个 CTA 能填空隙。phase 之间和 gemm2 的每个 slice 都有 barrier。
- m-block 数略多于 CU 数时，会剩下长尾。hot 路由和 2048 token 比 2-kernel 慢，主要就是这两点。

**换成 bm16/nw8 的实测**
- 128 token：约 133.5 us，比 bm32 快。m-block 多一倍，长尾更细。
- 512 token：约 209 us，明显变慢。每个专家平均约 16 个 token，bm16 时大量专家被拆成 2 个 block，整份专家权重要多读一遍，权重流量约增加 1.5–2 倍。

**纠正上一条建议**：上一条说"把 VGPR 压到 ≤128，让每个 CU 放两个 WG"，这在 nw16 时不成立。当前已经是 ≤128，正好占满 16 个 wave；nw16 想放两个 CTA，需要 ≤64 VGPR，做不到。可行的方向是：

- 用 **nw8，并且 VGPR ≤128、LDS ≤32 KB**，这样每个 CU 能放两个独立的 CTA，wave 总数仍是 16，但两个 CTA 的 barrier 互不牵制，可以互相掩盖。
- 为了不把权重流量翻倍，nw8 下仍要保持 bm32。代价是 gemm1 每个 wave 的列数翻倍（I_PER_WAVE=32），累加器变多，需要验证寄存器能否压到 128 以内。


---

## 16. 请求（2026-10-28 13:56 UTC）

> 那问一下16 wave或者 8wave在gemm1和gemm2的计算中是如何分工的

在 gemm1 和 gemm2 里，两种配置的分工方式相同：

- **N 方向按 wave 切开**：每个 wave 只负责一段输出列，这些列的权重只由这一个 wave 读一次，读进寄存器后在 BM 行上复用。
- **M 方向和 A 由全部 wave 共享**：每个 wave 都要读完整的 BM 行激活，gemm1 从 LDS 读，gemm2 读的是常驻寄存器的 A2。

下面以 Mimo shape 为例（H=4096，I=256，TILE_K1=256，所以 gemm1 有 16 个 K tile）。表中数字都可以从 `compile_a8w4_fmoe` 的常量推出来。用到的 MFMA 是 16x16x32 fp8。

##### 1. gemm1：x·W1（K=4096，N=2I=512，SEPARATED gate|up）

| | bm32 / nw16（缺省） | bm16 / nw8 |
|---|---|---|
| A1 搬运（global→LDS） | 32×256 B = 8 KB，1024 个线程每人 8 B，全 WG 协作 | 16×256 B = 4 KB，512 个线程每人 8 B |
| A1 读取 | 每个 wave 从 LDS 读整块 A1（32 行） | 每个 wave 读整块 A1（16 行） |
| 每个 wave 的输出列 | gate `[16w, 16w+16)` 和 up `[I+16w, …)`，`I_PER_WAVE=16` | gate 32 列和 up 32 列，`I_PER_WAVE=32` |
| 每个 wave、每个 K tile 读的 W1 | 32 行 × 128 B = 4 KB | 64 行 × 128 B = 8 KB |
| 整个 WG、每个 K tile 读的 W1 | 64 KB（512 列全覆盖） | 64 KB |
| 每个 wave、每个 K tile 的 MFMA 数 | 2(gate/up) × 2(mi) × 8(ku) = 32 | 2 × 1 × 2(ni) × 8 = 32 |
| acc1 | 16 个 f32 寄存器 | 16 个 f32 寄存器 |

- 流水线中 A1 在 LDS 里有 ping/pong 两个槽，W1 先预取到寄存器（`w1_regs`/`s1_regs`）。每个 K tile 只有一次 barrier。
- **Epilogue**：每个 wave 对自己负责的列做 dequant，计算 SiLU(g)·u，以 bf16 写入 region1 的对应列，然后全 WG 做一次 barrier。

##### 2. Requant：按行分给 wave

- 两种配置都是每个 wave 处理 `BM/NW = 2` 行（第 `wave` 行和第 `wave+NW` 行）。
- 每行 256 列由 64 个 lane 处理，每个 lane 4 列。lane 之间用 shuffle 求 amax，算出行 scale，结果写入 region0（A2，fp8，带 swizzle）和行 scale 区。
- 这里换了一种切法：gemm1 按列切，requant 按行切。中间结果必须经 LDS 转置一次，这也是一个 m-block 必须由同一个 WG 完成的原因。

##### 3. gemm2：A2·W2ᵀ（K=I=256，N=H=4096）

| | bm32 / nw16 | bm16 / nw8 |
|---|---|---|
| A2 | 每个 wave 把完整的 BM×256 读进寄存器（32 VGPR），之后一直复用 | 完整的 16×256（16 VGPR） |
| 每个 slice 的宽度 | `TILE_N2 = 16×16 = 256` | `8×32 = 256` |
| slice 数（串行） | 4096/256 = 16 | 16 |
| 每个 wave、每个 slice 的列数 | 16 列（`N2_PER_WAVE=16`） | 32 列 |
| 每个 wave、每个 slice 读的 W2 | 16×128 B = 2 KB | 4 KB |
| 每个 wave、每个 slice 的 MFMA 数 | 2(mi) × 8(ku) = 16 | 1 × 2(ni) × 8 = 16 |

- W2 提前一个 slice 预取到寄存器。
- **写回**：每个 wave 把乘过 a2_scale 和路由权重的 bf16 结果写进暂存区（region1/region0 交替使用），然后做一次 barrier。之后 `_scatter_rows` 换一种分工：
  - 每 32 个线程负责一行，每个线程处理 2 列 × 4 段，用 `global_atomic_pk_add_bf16` 写到对应 token 的输出行；
  - bm32 时 1024 线程正好一遍覆盖 32 行；bm16 时 512 线程一遍覆盖 16 行。
- 这里又从按列切换成按行切，所以需要先在 LDS 暂存再写回。

##### 4. 对比

- **每个 wave 的计算量完全相同**（gemm1 每个 K tile 32 个 MFMA，gemm2 每个 slice 16 个）。nw8 只是把 M 减半、把每个 wave 的 N 加倍。
- **权重复用度由 BM 决定**：每个权重字节在寄存器里被 BM 行复用。bm16 时一次加载只换来一半计算，而且权重读取次数随 m-block 数增加，所以 512 token 时 bm16/nw8 明显变慢。
- **如果用 bm32/nw8**：权重流量和 bm32/nw16 相同，但每个 wave 的 M 和 N 都翻倍。acc1 变成 32 个寄存器，W1 暂存寄存器也翻倍，每个 wave 每个 K tile 要做 64 个 MFMA。好处是一个 WG 只有 8 个 wave，VGPR ≤128 时每个 CU 能放两个 WG，两个 WG 的 barrier 可以互相掩盖。代价是寄存器压力，需要实测才能确定能否压到 128 以内。


---

## 17. 请求（2026-10-28 14:01 UTC）

> 有没有一种配置可以做到，每个CTA 4wave, 每个CU容纳两个CTA?

命令（Benchmark 4-wave and 8-wave CTA variants (bm32) and inspect VGPR/LDS usage from ISA dumps.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd4 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd4 timeout 3000 python /tmp/prof2.py "[(128,'uniform'),(512,'uniform'),(512,'hot'),(2048,'uniform')]" "[dict(), dict(num_waves=4,n2_per_wave=64), dict(num_waves=4,n2_per_wave=32), dict(num_waves=8,n2_per_wave=32)]" 2>&1 | grep -E "RES|rror|Traceback" ; for f in /tmp/fd4/*/21_final_isa.s; do echo "$(dirname $f | xargs basename | cut -c1-90) $(grep -E '^\s+\.(vgpr_count|agpr_count|sgpr_spill_count|vgpr_spill_count|group_segment_fixed_size):' $f | tr -s ' ' | tr '\n' ' ')"; done | grep fmoe
```

先实测一下：

命令（Force occupancy (2 waves/EU for nw4, 4 waves/EU for nw8) so two CTAs fit per CU; check spills and perf.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd5 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd5 timeout 3000 python /tmp/prof2.py "[(128,'uniform'),(512,'uniform'),(512,'hot'),(2048,'uniform')]" "[dict(num_waves=4,n2_per_wave=64,waves_per_eu=2), dict(num_waves=8,n2_per_wave=32,waves_per_eu=4)]" 2>&1 | grep -E "RES|rror|Traceback" ; for f in /tmp/fd5/*/21_final_isa.s; do echo "$(dirname $f | xargs basename | cut -c1-90) $(grep -E '^\s+\.(vgpr_count|agpr_count|vgpr_spill_count|group_segment_fixed_size|private_segment_fixed_size):' $f | tr -s ' ' | tr '\n' ' ')"; done | grep fmoe
```

结论：LDS 能装下两个，寄存器装不下；强行压寄存器会大量溢出到 scratch，速度慢将近一倍。而且在 token<1024 时，即使能放两个 CTA 也基本用不上。

**静态资源**（bm32，从 ISA dump 读出）

| 配置 | LDS | VGPR | 每个 CU 能放的 CTA 数 |
|---|---|---|---|
| nw16 / npw16（缺省） | 32 KB | 108 | 1（4 wave/SIMD × 4 SIMD = 16 wave） |
| nw8 / npw32 | 32 KB | 241 | 1（受寄存器限制） |
| nw4 / npw64 | 32 KB | 301 | 1（超过 256，每个 SIMD 只能放 1 个 wave） |

- 各约束都能满足：LDS 正好 32 KB，`BM%NW`、A1 拷贝、`TILE_N2=256` 都没问题。
- 4 个 wave 的 CTA 要每 CU 放两个，即每个 SIMD 2 个 wave，需要 VGPR ≤256（gfx942 每个 SIMD 共 512 个寄存器）。
- nw4 下每个 wave 负责 64 列 gate 和 64 列 up，寄存器主要花在：
  - acc1：64 个；
  - W1 暂存：W1 是预取一个 tile 的，正在用的这份（约 64）加上下一份预取（约 64）一共约 128，另外还有 scale；
  - 还有 LUT、通道指数和 A 片段，合计约 300。

**实测**（单位 us）

| 场景 | 缺省 nw16 | nw4（1 CTA/CU） | nw4 + `waves_per_eu=2` | nw8 + `waves_per_eu=4` | 2kernel |
|---|---|---|---|---|---|
| 128 | 139.9 | 164.5 | 262.5 | 272.6 | 133.3 |
| 512 uniform | 156.4 | 185.8 | 288.1 | 292.3 | 155.5 |
| 512 hot | 217.7 | 269.4 | 339.2 | 365.0 | 179.0 |
| 2048 | 356.0 | 451.3 | 596.4 | 608.3 | 320.4 |

- 强制每 CU 放两个 CTA 后，nw4 压到 256 VGPR，但溢出 40 个；nw8 压到 128，溢出 50 个。两者都慢了将近一倍。

**token<1024 时用不上的原因**：grid 只等于 m-block 数。bm32 时 512 token 大约 256–300 个 block，少于 304 个 CU，硬件派发会先给每个 CU 放一个。所以把 CTA 改成 4 个 wave，在这个范围内只会让每个 CU 从 16 个 wave 降到 4 个，实测确实变慢了（186 vs 156）。只有 block 数达到约 600 个以上时（2048 token 以上，或 hot 专家很集中），每 CU 两个 CTA 才会起作用。

**如果一定要做出 4 wave × 2 CTA 且不溢出**，必须把 VGPR 降到 ≤256，有两条路：
1. 去掉 phase 1 的 W1 寄存器预取（约省 64 个，可降到约 240），延迟改由同一 CU 上的另一个 CTA 来掩盖。
2. 把 TILE_K1 改成 128，W1 暂存减半。目前要求 K 必须是 256 的倍数，因为 e8m0 每个 dword 打包了两个 128-K group，需要改 scale 读取。

这两条都只对 block 数多的场景（2048 token、hot）可能有收益，对目标场景 token<1024 预计没有帮助。


---

## 18. 请求（2026-10-28 14:05 UTC）

> 尝试一下2

命令（Check the benchmark script for correctness checks.）：
```bash
cat /tmp/prof2.py
```

命令（Benchmark TILE_K1=128 variants (nw16/nw8/nw4) with correctness vs the 2-kernel path and dump VGPR/LDS.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd6 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd6 timeout 3000 python /tmp/prof2.py "[(512,'uniform'),(2048,'uniform')]" "[dict(), dict(tile_k1=128), dict(num_waves=4,n2_per_wave=64,tile_k1=128), dict(num_waves=4,n2_per_wave=32,tile_k1=128), dict(num_waves=8,n2_per_wave=32,tile_k1=128)]" 2>&1 | grep -E "RES|rror|Traceback" ; for f in /tmp/fd6/*/21_final_isa.s; do echo "$(dirname $f | xargs basename | cut -c1-90) $(grep -E '^\s+\.(vgpr_count|vgpr_spill_count|group_segment_fixed_size):' $f | tr -s ' ' | tr '\n' ' ')"; done | grep fmoe
```

命令（Benchmark TILE_K1=128 for nw4/nw8 with correctness, plus VGPR/LDS.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fd6 && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fd6 timeout 3000 python /tmp/prof2.py "[(128,'uniform'),(512,'uniform'),(512,'hot'),(2048,'uniform')]" "[dict(), dict(num_waves=4,n2_per_wave=64,tile_k1=128), dict(num_waves=4,n2_per_wave=32,tile_k1=128), dict(num_waves=8,n2_per_wave=32,tile_k1=128)]" 2>&1 | grep -E "RES|rror|Traceback" ; for f in /tmp/fd6/*/21_final_isa.s; do echo "$(dirname $f | xargs basename | cut -c1-90) $(grep -E '^\s+\.(vgpr_count|vgpr_spill_count|group_segment_fixed_size):' $f | tr -s ' ' | tr '\n' ' ')"; done | grep fmoe
```

nw16 下 128 宽的 A1 tile 不够每个线程分 8 B，去掉这一项重跑：

命令（Check run-to-run determinism and agreement of the tk128 variants against the default fused kernel at 2048 tokens.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/chk_tk.py <<'EOF'
import importlib.util, torch, sys
sys.path.insert(0, "op_tests")
spec = importlib.util.spec_from_file_location("t", "op_tests/test_a8w4_fmoe.py")
t = importlib.util.module_from_spec(spec); spec.loader.exec_module(t)
from aiter import dtypes, QuantType
import aiter
H, I, E, K = 4096, 256, 256, 8
torch.manual_seed(0)
w1 = torch.randn((E, 2*I, H), dtype=dtypes.bf16, device="cuda")
w2 = torch.randn((E, H, I), dtype=dtypes.bf16, device="cuda")
tq = aiter.get_torch_quant(QuantType.per_1x32)
w1q, s1 = tq(w1, quant_dtype=dtypes.fp4x2); w2q, s2 = tq(w2, quant_dtype=dtypes.fp4x2)
del w1, w2
w1q = w1q.view(E, 2*I, H//2); w2q = w2q.view(E, H, I//2)
W = t.a8w4_prepare_weights(t.shuffle_weight_a16w4(w1q,16,False), t.shuffle_weight_a16w4(w2q,16,False),
                           t.shuffle_scale_a16w4(s1,E,False), t.shuffle_scale_a16w4(s2,E,False))
tok = 2048
inp = torch.randn((tok, H), dtype=dtypes.bf16, device="cuda")
score = torch.randn((tok, E), dtype=dtypes.bf16, device="cuda")
tw, ti = t.fused_topk(inp, score, K, True)
ref = t.a8w4_fmoe(inp, W, tw, ti).float()
m = ref.abs().mean()
for c in [dict(), dict(num_waves=4,n2_per_wave=64,tile_k1=128), dict(num_waves=8,n2_per_wave=32,tile_k1=128)]:
    errs = []
    for _ in range(4):
        o = t.a8w4_fmoe(inp, W, tw, ti, **c).float()
        d = (o - ref).abs()
        errs.append(f"{(d.max()/m).item():.3g}/{(d.mean()/m).item():.2e}/{(d > 0.05*m).sum().item()}")
    print(c, errs)
EOF
timeout 1800 python /tmp/chk_tk.py 2>&1 | grep -E "^\{|Error"
```

`TILE_K1=128` 跑通了。不过 2048 token、nw4/npw64 这一项的 err 比其他配置高（0.111，其他约 0.074），下面确认是不是 bug：

命令（Regression test of the fused kernel.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python -m pytest -q op_tests/test_a8w4_fmoe.py 2>&1 | tail -1
```

差异与缺省 kernel 自身的运行间抖动同一量级（bf16 原子累加顺序不同造成），属于正常。再跑一下 pytest 回归：

`TILE_K1=128` 做好了，4 wave × 2 CTA/CU 能跑起来，没有溢出，但还是比缺省的 nw16 慢。8 wave × 2 CTA/CU 也能做到，只在 512 hot 上快了约 3%。

pytest 2 passed。新配置的输出和缺省 kernel 的差异，跟缺省 kernel 自己多跑几次之间的差异在同一量级（bf16 原子累加顺序不同造成），可以认为是对的。

**改动**（[op_tests/test_a8w4_fmoe.py](op_tests/test_a8w4_fmoe.py)）
- `TILE_K1` 的要求从 256 的倍数放宽到 128 的倍数。
- 一个 e8m0 dword 里装了两个 128-K group 的 scale。tile 只有一个 group 时，在 `read_w1(kt)` 里按 `kt%2` 运行时选取对应的字节。
- `a8w4_fmoe` 新增参数 `tile_k1=256`。
- nw16 不能用 128：bm32×128 的 A1 tile 不够 1024 个线程每人分 8 B，会触发断言。

**寄存器和 LDS**（bm32）

| 配置 | VGPR | 溢出 | LDS | 每 CU 能放的 CTA |
|---|---|---|---|---|
| nw16 tk256（缺省） | 108 | 0 | 32 KB | 1（16 wave） |
| nw8 tk128 npw32 | 126（原 241） | 0 | 24 KB | **2（共 16 wave）** |
| nw4 tk128 npw64 | 211（原 301） | 0 | 24 KB | **2（共 8 wave）** |

**性能**（us）

| 场景 | 缺省 nw16 | nw8 tk128 | nw4 tk128 npw64 | 原 nw4 tk256 | 2kernel |
|---|---|---|---|---|---|
| 128 | 138.6 | 153.6 | 165.3 | 164.5 | 144.0 |
| 512 uniform | 156.2 | 169.8 | 189.3 | 185.8 | 155.9 |
| 512 hot | 215.7 | **209.2** | 228.6 | 269.4 | 178.3 |
| 2048 | 352.3 | 359.3 | 397.0 | 451.3 | 329.0 |

- 和原来 tk256 的 nw4 比，m-block 多的场景快了不少：512 hot 从 269 降到 229，2048 从 451 降到 397。说明每 CU 放两个 CTA 确实有用。
- 但 ≤512 uniform 时 m-block 数少于 CU 数，大多数 CU 只分到一个 CTA，只有 4 或 8 个 wave，所以比 nw16 慢。
- nw8 tk128 是唯一在某个场景（512 hot）赢过缺省的配置。

融合 kernel 的瓶颈不在每个 CU 放几个 CTA，而在 m-block 太少：每个 m-block 都要读一整份专家权重（约 1.5 MB），再把它全部算完。所以缺省配置保持 nw16 tk256 不变，tk128 作为可选参数保留。


---

## 19. 请求（2026-10-28 14:12 UTC）

> 撤销刚才添加的对nw4的支持和优化

命令（Confirm the revert left no remnants and the tests pass.）：
```bash
cd /sgl-workspace/aiter && grep -nE "tile_k1|read_w1\(kt|% 128 == 0" op_tests/test_a8w4_fmoe.py; timeout 1800 python -m pytest -q op_tests/test_a8w4_fmoe.py 2>&1 | tail -1
```

`TILE_K1=128` 的支持已从 [op_tests/test_a8w4_fmoe.py](op_tests/test_a8w4_fmoe.py) 撤销，pytest 2 passed。

- `TILE_K1` 又要求是 256 的倍数。
- `read_w1()` 恢复原来按编译期 `g%2` 选 scale 字节的写法。
- `a8w4_fmoe` 去掉了 `tile_k1` 参数。

nw4 原本就没有专门的代码，所以撤销后它恢复成之前那样能编译但 VGPR 超过 256 的状态，不会被拦截。

这次实验的结论还留在 repo memory 里，已标注为已撤销。


---

## 20. 请求（2026-10-28 14:26 UTC）

> 现在的inter_dim=256其实是MoE TP8下的配置，因此gemm2后面还要接一个8ranks的all-reduce才能得到最终结果，实现一个新 test_a8w4_gemm2_tp.py，torchrun --nproc_per_node=8 启动，调用 test_a8w4_gemm2.py中的已有kernel，测试中使用torch.distributed完成allreduce，统计性能也测试all-reduce(gemm2+allreduce分别呈现)

命令（Check available GPUs and torchrun.）：
```bash
cd /sgl-workspace/aiter && python -c "import torch;print(torch.cuda.device_count(), torch.__version__)" 2>&1 | tail -1; which torchrun
```

命令（Smoke-run the new TP8 gemm2+allreduce test on 8 GPUs for one shape.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 torchrun --nproc_per_node=8 op_tests/test_a8w4_gemm2_tp.py -t 512 -r uniform --tile 64,128,1 2>&1 | grep -vE "NUMA|numa_balancing|system-optimization" | tail -30
```

命令（Single-GPU baseline of the same gemm2 config.）：
```bash
cd /sgl-workspace/aiter && timeout 1800 python op_tests/test_a8w4_gemm2.py -t 512 -r uniform --tile 64,128,1 2>&1 | grep -A3 "summary" | tail -2 | cut -c1-400
```

正确性通过（误差都在容差内），但 gemm2 耗时 138 us 远高于单卡测得的约 52 us，且比 gemm2+allreduce 还长，需要排查：

命令（Print per-rank timings to see whether one rank or all ranks are slow, and check GPU utilization.）：
```bash
cd /sgl-workspace/aiter && cat > /tmp/tp_dbg.py <<'EOF'
import os, sys, torch, torch.distributed as dist, logging
sys.path.insert(0, "op_tests")
import test_a8w4_gemm2_tp as m
import aiter
lr = int(os.environ["LOCAL_RANK"]); torch.cuda.set_device(lr)
dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
aiter.logger.setLevel(logging.ERROR)
orig = m._rank_max
vals = []
def rm(x):
    vals.append(float(x)); return orig(x)
m._rank_max = rm
m.bench_a8w4_gemm2_tp(512, 4096, 256, 256, 8, routing="uniform", tile_m=64, tile_n=128, dyn_rows=True)
print(f"rank{dist.get_rank()} gemm2={vals[0]:.1f} ar={vals[3]:.1f} both={vals[6]:.1f}", flush=True)
dist.destroy_process_group()
EOF
timeout 1800 torchrun --nproc_per_node=8 /tmp/tp_dbg.py 2>&1 | grep -E "^rank[0-9] gemm2"; rocm-smi --showuse 2>/dev/null | grep -E "GPU\[" | head -8
```

命令（Run the TP test over a few token counts to check stability of the reported timings.）：
```bash
cd /sgl-workspace/aiter && timeout 3000 torchrun --nproc_per_node=8 op_tests/test_a8w4_gemm2_tp.py -t 128 512 2048 -r uniform 2>&1 | grep -A20 "summary (markdown)" | grep -E "^\|" | sed -E 's/ +/ /g'
```

这次各 rank 的 gemm2 都在 57 us 左右，上次的 138 us 应该是某个 rank 的偶发异常值被 max 取到了。再完整跑一次确认：

I've added [op_tests/test_a8w4_gemm2_tp.py](op_tests/test_a8w4_gemm2_tp.py), and it runs on 8 GPUs with torchrun. All three checks pass (gemm2 alone, all-reduce alone, and both together). At 512 tokens the all-reduce takes about as long as gemm2 itself, so it doubles the layer's stage2 time.

**What the test does**
- Every rank gets the same tokens and routing. Each rank has its own W2 shard and its own stage-1 intermediate, and `inter_dim` means the per-rank shard (256 for Mimo TP8).
- Each rank calls the existing `a8w4_gemm2` kernel to write a partial result into the output buffer, then `dist.all_reduce` sums it in place across ranks, the way the model does it.
- Three things are timed separately: gemm2 alone, all-reduce alone, and gemm2 followed by all-reduce. Each shows us / TFLOPS / TB/s / err / cos. Each number is the slowest rank's time, and only rank 0 prints the table.
- For all-reduce, TB/s is bus bandwidth (the convention nccl-tests uses).
- Accuracy checks:
  - gemm2: each rank's partial against that rank's fp32 reference.
  - all-reduce alone: against an fp32 sum of the kernel's bf16 partials.
  - gemm2 + all-reduce: against the fp32 references summed over ranks.
- Command-line options and defaults are the same as [test_a8w4_gemm2.py](op_tests/test_a8w4_gemm2.py) (`-t/-s/--tile/-r`).

```
torchrun --nproc_per_node=8 op_tests/test_a8w4_gemm2_tp.py -t 128 512 2048 -r uniform
```

**Results** (uniform routing, tile_m=32 with `dyn_rows`, times in µs)

| tokens | output size | gemm2 | all-reduce (bus bandwidth) | gemm2 + all-reduce |
|---|---|---|---|---|
| 128 | 1 MB | 41.4 | 26.2 (0.07 TB/s) | 64.7 |
| 512 | 4 MB | 53.1 | 53.5 (0.14 TB/s) | 105.7 |
| 2048 | 16 MB | 125.7 | 148.6 (0.20 TB/s) | 253.3 |

- gemm2 + all-reduce is roughly the sum of the two, since they run one after the other.
- RCCL's bandwidth at these sizes is very low.

**Timing caveat:** on the very first run, the 512-token gemm2 came out at 138 µs. When I printed each rank separately, every rank was around 57 µs, and the next full run was normal. Because the table reports the slowest rank, a single bad measurement on one rank shows up directly, so treat an unusually high number with suspicion.

If the all-reduce cost needs to come down, the likely options are aiter's own all-reduce for small messages (`custom_all_reduce`) or reducing the output to fp8 before all-reducing.


---

## 21. 请求（2026-10-28 14:39 UTC）

> 现在在该测试文件下尝试进行一个优化，参考https://github.com/ROCm/FlyDSL/blob/main/kernels/monokernel/symmetric_allreduce.py 事先为各个gpu分配跟gemm2输出tensor大小相等的symmetric buffers，通过IPC把其他ranks的输出buffer导入到本地，然后让gemm2使用atomic写出时，同时向其他ranks的输出buffer的对应位置使用atomic写出，这样就避免了单独调用all-reduce，尝试该方法是否可以加速

命令（Look for a local copy of the FlyDSL symmetric allreduce reference.）：
```bash
find / -name "symmetric_allreduce.py" -not -path "*/proc/*" 2>/dev/null | head; ls /opt/venv/lib/python3.10/site-packages/flydsl/
```

命令（Download the reference symmetric allreduce source.）：
```bash
cd /tmp && curl -sSL --max-time 30 -o sym_ar.py https://raw.githubusercontent.com/ROCm/FlyDSL/main/kernels/monokernel/symmetric_allreduce.py; wc -l sym_ar.py; head -5 sym_ar.py
```

命令（Fetch the reference SymmetricPeerBuffer implementation (IPC setup).）：
```bash
cd /tmp && curl -sSL --max-time 30 -o sym_rt.py https://raw.githubusercontent.com/ROCm/FlyDSL/main/kernels/monokernel/runtime.py && wc -l sym_rt.py && grep -n "class SymmetricPeerBuffer" -A120 sym_rt.py | head -170
```

命令（Fetch the reference HIP IPC helpers.）：
```bash
cd /tmp && curl -sSL --max-time 30 -o sym_ipc.py https://raw.githubusercontent.com/ROCm/FlyDSL/main/kernels/monokernel/ipc.py && cat sym_ipc.py
```

命令（Check FlyDSL/MLIR llvm FenceOp and AtomicRMWOp signatures and gpu grid helpers.）：
```bash
cd /tmp && python - <<'EOF'
import inspect
from flydsl._mlir.dialects import llvm
print(inspect.signature(llvm.FenceOp.__init__))
print(inspect.signature(llvm.AtomicRMWOp.__init__))
print([m for m in dir(llvm.AtomicBinOp) if not m.startswith('_')][:30])
from flydsl.expr import gpu
print([m for m in dir(gpu) if 'dim' in m or 'grid' in m])
EOF
```

命令（Check available sleep/nop intrinsics and torch MemPool API.）：
```bash
cd /tmp && python -c "
from flydsl.expr import rocdl; print([m for m in dir(rocdl) if 'sleep' in m or 'nop' in m])
import torch; print(hasattr(torch.cuda,'MemPool'), hasattr(torch.cuda,'use_mem_pool'))
" 2>&1 | tail -2
```

Now the kernel hook in [test_a8w4_gemm2.py](op_tests/test_a8w4_gemm2.py) (multi-destination epilogue + device-side cross-rank completion barrier, off by default):

Now the compile function changes:


---

## 22. 请求（2026-10-28 14:48 UTC）

> 可能需要先做一个小实验测试是否atomic加可以跨卡生效

命令（Run the cross-GPU atomic probe on 8 GPUs (correctness + rough bandwidth, agent vs system scope).）：
```bash
cd /sgl-workspace/aiter && timeout 600 torchrun --nproc_per_node=8 /tmp/peer_atomic_probe.py 2>&1 | grep -vE "NUMA|numa_balancing|system-optimization|^\[aiter\] import" | tail -20
```

跨卡 atomic 本身是生效的，结果全部正确，但带宽太低，原方案会比 gemm2 + all-reduce 慢一个数量级以上。

**实验**（[/tmp/peer_atomic_probe.py](/tmp/peer_atomic_probe.py)）：每个 rank 向自己和其余 7 个 rank 的 4 MB buffer 的每个元素做 bf16x2 atomic 加 (rank+1)，重复 4 次，期望值为 4×36 = 144。

| scope | 目标 rank 数 | 结果 | 每次 launch | 跨卡总带宽（每 rank） |
|---|---|---|---|---|
| agent | 1（本卡） | 全对 | 6.4 us | — |
| agent | 8 | 8 个 rank 全部等于 144 | 279 us | **约 105 GB/s**（每条链路约 15 GB/s） |
| system | 1（本卡） | 全对 | 21 us | — |
| system | 8 | 全对 | 2045 us | 约 14 GB/s |

**结论**
- 通过 IPC 映射的对端 buffer 上，`global_atomic_pk_add_bf16` 是可以用的，本卡和远端的 atomic 混在一起累加也没有丢失。注意这只是在 kernel 边界加 host 同步的条件下验证的；如果在 kernel 内部用 flag 做同步，还需要另外验证。
- 跨卡 atomic 的有效带宽只有约 105 GB/s，用 system scope 时更差。
- 关键问题是 atomic 是按路由行发的，不是按 token。topk=8 时，每个 rank 发往对端的数据量是 topk ×（npes−1）× 输出大小：
  - 512 tokens：4096 行 × 4096 × 2 B × 7 ≈ 224 MB，按 105 GB/s 约 2.1 ms，而现在的 gemm2 + all-reduce 约 106 us。
  - 128 tokens：约 56 MB，约 0.5 ms，而现在约 65 us。

所以"gemm2 写出时直接 atomic 到所有 rank"这个方案不可行，我没有接着往下做。

**已撤销**：[op_tests/test_a8w4_gemm2.py](op_tests/test_a8w4_gemm2.py) 里写了一半的 peer 模式（多目标 epilogue 和跨卡完成同步）会让现有路径跑不通。我会把这部分改动恢复成原样，接下来就执行。

**如果还想去掉单独的 all-reduce，更可行的方向有两个**：
1. gemm2 先照常在本卡用 atomic 归约，kernel 尾部做一次全 grid 同步，然后每个 WG 用普通 store 把自己负责的那块最终结果推给对端，做法类似 FlyDSL symmetric_allreduce 的 mailbox。这样跨卡流量只有输出大小 × 7（512 tokens 时 28 MB），是现在方案的八分之一，而且普通 store 的带宽应该比 atomic 高，需要实测。
2. 保留两个 kernel，把 RCCL 换成 aiter 的 custom all-reduce 或 FlyDSL 的 symmetric all-reduce，先看 all-reduce 本身能从 53 us 降到多少。

要不要先测一下跨卡普通 store 的带宽，再决定走哪一条？

命令（Confirm the gemm2 file is back to its prior state and still passes.）：
```bash
cd /sgl-workspace/aiter && git diff --stat op_tests/test_a8w4_gemm2.py; grep -nE "out_addrs|_peer_grid_barrier|_flag_read" op_tests/test_a8w4_gemm2.py; timeout 1800 python -m pytest -q op_tests/test_a8w4_gemm2.py -k "uniform and True and 32" 2>&1 | tail -1
```

I've also reverted the half-finished peer-mode changes in [op_tests/test_a8w4_gemm2.py](op_tests/test_a8w4_gemm2.py). The file is back to what it was before, and its pytest case passes again.


---

## 23. 请求（2026-10-28 14:53 UTC）

> 好的，测一下跨卡普通 store 的带宽

命令（Measure cross-GPU plain store (push) and load (pull) bandwidth for several chunk sizes and cache policies.）：
```bash
cd /sgl-workspace/aiter && timeout 900 torchrun --nproc_per_node=8 /tmp/peer_store_probe.py 2>&1 | grep -E "^chunk|Error|error|Traceback" | head -60
```

命令（Re-run the probe with destination-interleaved workgroups plus a local-copy reference.）：
```bash
cd /sgl-workspace/aiter && timeout 900 torchrun --nproc_per_node=8 /tmp/peer_store_probe.py 2>&1 | grep -E "^chunk|Error|Traceback" | sed -E 's/ +/ /g'
```


> （transcript 缺少本请求的结论回复，原始输出与结论见 `results/comm_peer_store_probe.txt` 和 README §4.3：
> push 用 `sc1` 时每 rank 约 300–320 GB/s（约 45 GB/s/link），pull 约 110–120 GB/s；
> WG 必须轮流发往不同 peer，否则只用到一条链路。由此判断 two-shot 可行。）


---

## 24. 请求（2026-10-28 22:13 UTC，transcript 未记录原文，按会话摘要补）

> 把 two-shot 写成一个独立的 FlyDSL all-reduce kernel，先确认能否稳定在 30 us 左右

先看一下当前 TP 测试文件的结构，再把 two-shot kernel 加进去：

Now wire it into the benchmark as new candidates:

命令（First run of the two-shot all-reduce in the TP test (512 tokens), with a timeout to catch hangs.）：
```bash
cd /sgl-workspace/aiter && timeout 600 torchrun --nproc_per_node=8 op_tests/test_a8w4_gemm2_tp.py -t 512 -r uniform --tile 32,128,1 2>&1 | grep -E "Error|error|Traceback|checkAllclose|summary|^\|" | grep -v "NUMA" | sed -E 's/ +/ /g' | head -40
```

命令（Dump the two-shot kernel ISA to inspect fences/cache maintenance and flag atomics.）：
```bash
cd /sgl-workspace/aiter && python -c "
import inspect
from flydsl.expr import rocdl
print(inspect.signature(rocdl.s_waitcnt))
" 2>&1 | tail -1; cat > /tmp/ts_isa.py <<'EOF'
import os, sys, torch, torch.distributed as dist, logging
sys.path.insert(0, "op_tests")
import test_a8w4_gemm2_tp as m
lr = int(os.environ["LOCAL_RANK"]); torch.cuda.set_device(lr)
dist.init_process_group("nccl", device_id=torch.device("cuda", lr))
x = torch.randn(512, 4096, dtype=torch.bfloat16, device="cuda")
ar = m.TwoShotAllreduce(x.shape)
y = ar(x); torch.cuda.synchronize()
ref = x.float().clone(); dist.all_reduce(ref)
print("rank", dist.get_rank(), "maxdiff", (y.float() - ref).abs().max().item(), flush=True)
ar.close(); dist.destroy_process_group()
EOF
rm -rf /tmp/fdts && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fdts timeout 300 torchrun --nproc_per_node=8 /tmp/ts_isa.py 2>&1 | grep -E "maxdiff|Error" | head -3; f=$(ls /tmp/fdts/*twoshot*/21_final_isa.s | head -1); grep -nE "buffer_wbl2|buffer_inv|s_waitcnt vmcnt|global_atomic|buffer_store|s_sleep|s_barrier|\.vgpr_count" $f | head -60
```

two-shot 结果正确（与 fp32 求和的 err=0，cos 1.4e-6，比 RCCL 更准），但耗时 88.8 us，远没到 30 us。先看生成的 ISA，确认 fence 和 flag 原子操作的开销：

命令（Re-check correctness and confirm remote stores are no longer serialized.）：
```bash
cd /sgl-workspace/aiter && rm -rf /tmp/fdts && FLYDSL_DUMP_IR=1 FLYDSL_DUMP_DIR=/tmp/fdts timeout 300 torchrun --nproc_per_node=8 /tmp/ts_isa.py 2>&1 | grep -E "maxdiff|Error" | head -2; f=$(ls /tmp/fdts/*twoshot*/21_final_isa.s | head -1); grep -cE "s_waitcnt vmcnt\(0\)" $f; grep -nE "buffer_store|buffer_wbl2|s_barrier" $f | head -12
```

命令（Benchmark RCCL vs two-shot all-reduce (alone and after gemm2) at 128/512/2048 tokens.）：
```bash
cd /sgl-workspace/aiter && timeout 900 torchrun --nproc_per_node=8 op_tests/test_a8w4_gemm2_tp.py -t 128 512 2048 -r uniform --tile 32,128,1 2>&1 | grep -A8 "summary (markdown)" | grep -E "^\| +[0-9]" > /tmp/ts_res.txt; python - <<'EOF'
import re
for line in open("/tmp/ts_res.txt"):
    c = [x.strip() for x in line.strip().strip("|").split("|")]
    # columns: token ... then per-candidate groups of 5 (us, TFLOPS, TB/s, err, cos) after 'm-blocks'
    tok = c[0]; base = 15
    names = ["gemm2", "rccl_ar", "twoshot_ar", "gemm2+rccl", "gemm2+twoshot"]
    vals = {n: (float(c[base+5*i]), float(c[base+5*i+3]), float(c[base+5*i+4])) for i, n in enumerate(names)}
    print(tok, "  ".join(f"{n}={v[0]:.1f}us(err={v[1]:.1g},cos={v[2]:.1g})" for n, v in vals.items()))
EOF
```

远端 store 现在连续发出了。跑 128/512/2048 tokens：

命令（Benchmark light vs fence two-shot vs RCCL with multi-epoch correctness checks.）：
```bash
cd /sgl-workspace/aiter && timeout 600 torchrun --nproc_per_node=8 /tmp/ts_bench.py 128 256 512 1024 2048 2>&1 | grep -E "^tok|Error|Traceback"
```

写一个只测 all-reduce 的独立 benchmark 来快速迭代：用 CUDA event 计时，连续 200 个 epoch，每次输入不同，并逐次校验：

命令（Re-run one size to see the error output.）：
```bash
cd /sgl-workspace/aiter && timeout 600 torchrun --nproc_per_node=8 /tmp/ts_bench.py 512 2>&1 | grep -vE "NUMA|numa_balancing|system-optim|OMP_NUM|\*\*\*\*" | tail -30
```

命令（Benchmark all token sizes.）：
```bash
cd /sgl-workspace/aiter && timeout 900 torchrun --nproc_per_node=8 /tmp/ts_bench.py 128 256 512 1024 2048 2>&1 | grep -vE "NUMA|numa_balancing|system-optim|OMP_NUM|\*\*\*\*|import \[module|run.py:803" | tail -12
```

light 版本正确（200 个 epoch 全部通过），512 tokens 时 40.4 us，fence 版本 58.7 us，RCCL 在这种连续调用的测法下是 68 us。补跑其他尺寸：

命令（Re-measure light two-shot with WG-rotated destinations.）：
```bash
cd /sgl-workspace/aiter && LIGHT=1 timeout 900 torchrun --nproc_per_node=8 /tmp/ts_bench.py 128 256 512 1024 2048 2>&1 | grep -vE "NUMA|numa_balancing|system-optim|OMP_NUM|\*\*\*\*|import \[module|run.py:803" | tail -6
```

命令（Repeat the two-shot bench three times to check run-to-run stability.）：
```bash
cd /sgl-workspace/aiter && for i in 1 2 3; do LIGHT=1 timeout 600 torchrun --nproc_per_node=8 /tmp/ts_bench.py 128 512 2>&1 | grep -E "^tok"; done
```

512 tokens 降到 30.8 us，达到目标。再重复跑几次看是否稳定，然后在完整的 TP 测试里复测（测量方式不同：profiler 统计 kernel 时间）：

命令（Run the full TP test (profiler timing, correctness before/after timing) with the tuned two-shot kernel.）：
```bash
cd /sgl-workspace/aiter && timeout 900 torchrun --nproc_per_node=8 op_tests/test_a8w4_gemm2_tp.py -t 128 512 2048 -r uniform --tile 32,128,1 2>&1 | grep -A8 "summary (markdown)" | grep -E "^\| +[0-9]" > /tmp/ts_res.txt; python - <<'EOF'
for line in open("/tmp/ts_res.txt"):
    c = [x.strip() for x in line.strip().strip("|").split("|")]
    tok = c[0]; base = 15
    names = ["gemm2", "rccl_ar", "twoshot_ar", "gemm2+rccl", "gemm2+twoshot"]
    vals = {n: (float(c[base+5*i]), float(c[base+5*i+3])) for i, n in enumerate(names)}
    print(tok, "  ".join(f"{n}={v[0]:.1f}us(err={v[1]:.1g})" for n, v in vals.items()))
EOF
```

two-shot all-reduce 已经写成独立的 FlyDSL kernel，512 tokens（4 MB）时稳定在约 30.5 us，RCCL 是 53–67 us。结果在 200 个 epoch 的连续校验里全部正确，完整 TP 测试的计时前后两次检查也都通过。

**实现**（在 [op_tests/test_a8w4_gemm2_tp.py](op_tests/test_a8w4_gemm2_tp.py) 里）
- `SymmetricBuffer`：每个 rank 在独立的 MemPool 里分配一块内存，通过 HIP IPC 映射给所有 peer，得到一张 peer 地址表。
- `compile_twoshot_allreduce` 加上 `TwoShotAllreduce`：一个 kernel 内依次完成三步，WG c 负责每个分片的第 c 个 chunk。
  1. reduce-scatter：把各分片 push 到负责它的 rank，然后写 flag。
  2. 等到 8 个来源的 flag 都到齐，按固定的 rank 顺序用 fp32 求和再转成 bf16，所以每个 rank 得到逐位相同的结果。
  3. all-gather：把求和结果 push 给所有 rank，等对应 flag 到齐。
- 结果是本 rank symmetric buffer 中 gather 区域的视图，不需要额外拷贝。flag 存的是单调递增的 epoch。
- 新增两个候选：`twoshot_ar`（单独 all-reduce）和 `gemm2+twoshot_ar`。

**从 88.8 us 降到约 30.5 us（512 tokens）的三处改动**

| 改动 | 原因 | 512 tokens |
|---|---|---|
| 初版 | — | 88.8 us |
| peer 地址表在开头一次读完 | 地址表的 load 夹在远端 store 之间时，gfx9 上 load 和 store 共用同一个等待计数（vmcnt），编译器插 `vmcnt(0)`，8 条 store 变成串行 | 约 52 us |
| 轻量同步：store 用 `sc0\|sc1`、`s_waitcnt vmcnt(0)`、flag 用 monotonic 原子操作，结尾每个 WG 只做一次 acquire | release fence 让每个 wave 都写回整个 L2（`buffer_wbl2`），轮询 flag 时每次还要使 L2 失效 | 40.4 us |
| 目标 peer 按 (rank + WG 序号 + i) 轮转 | 原来只按 rank 轮转，所有 WG 同一时刻写同一个 peer，挤在一条 xGMI 链路上 | **30.5 us** |

**完整 TP 测试结果**（profiler 计时，tile_m=32 加 dyn_rows，单位 us）

| tokens | gemm2 | RCCL | **twoshot** | gemm2+RCCL | **gemm2+twoshot** |
|---|---|---|---|---|---|
| 128 | 41.5 | 25.1 | **12.1** | 63.5 | **50.5**（快 20%） |
| 512 | 53.6 | 53.3 | **31.0** | 104.9 | **79.6**（快 24%） |
| 2048 | 126.7 | 148.4 | **111.8** | 255.0 | **219.3**（快 14%） |

- 独立 benchmark（[/tmp/ts_bench.py](/tmp/ts_bench.py)）连跑三次，512 tokens 都在 30.4–30.6 us，128 tokens 都在 12.3–12.4 us。
- 精度：two-shot 与 fp32 精确求和相比 err=0，比 RCCL 的 bf16 累加更准。

下一步可以把这个 kernel 并进 gemm2 的尾部，省掉一次 kernel launch，并让 reduce-scatter 和 gemm2 的最后几个 tile 重叠。不过 gemm2 结束时需要先做一次全 grid 同步，收益要实测才知道。


---

## 25. 请求（2026-10-29 01:24 UTC）

> 总结之前关于卡间通讯的全部实验记录到doc-mimo目录下，包括实验代码,gemm1/gemm2/allreduce的kernel+测试，因为这些改动有价值但是难以upstream

命令（Check whether doc-mimo exists and list the experiment files to collect.）：
```bash
cd /sgl-workspace/aiter && ls -d doc-mimo docs/mimo* 2>/dev/null; ls doc-mimo 2>/dev/null; git status --short | head -30; ls /tmp/*.py | head -30
```

命令（Inspect doc-mimo, gitignore status, e2e diff size and fmoe imports.）：
```bash
cd /sgl-workspace/aiter && ls -la doc-mimo; git check-ignore -v doc-mimo/x.md; git diff --cached .gitignore | head; git diff --stat op_tests/test_flydsl_moe_a16wfp4.py; grep -nE "^from|^import|sys.path" op_tests/test_a8w4_fmoe.py | head -40
```

命令（Create doc-mimo with copies of the kernels/tests, the e2e patch, and the inter-GPU experiment scripts; list remaining hard-coded paths.）：
```bash
cd /sgl-workspace/aiter && mkdir -p doc-mimo/kernels doc-mimo/comm && cp op_tests/test_a8w4_gemm1.py op_tests/test_a8w4_gemm2.py op_tests/test_a8w4_gemm2_tp.py op_tests/test_a8w4_fmoe.py op_tests/test_flydsl_moe_a16wfp4.py doc-mimo/kernels/ && git diff op_tests/test_flydsl_moe_a16wfp4.py > doc-mimo/kernels/test_flydsl_moe_a16wfp4.e2e.patch && cp /tmp/peer_atomic_probe.py doc-mimo/comm/peer_atomic_probe.py && cp /tmp/peer_store_probe.py doc-mimo/comm/peer_store_probe.py && cp /tmp/ts_bench.py doc-mimo/comm/twoshot_bench.py && cp /tmp/ts_isa.py doc-mimo/comm/twoshot_isa_dump.py && git rev-parse --short HEAD && find doc-mimo -type f | sort && grep -nE "sys.path|/tmp|/sgl-workspace" doc-mimo/comm/*.py
```

命令（Verify no stale hard-coded paths remain.）：
```bash
cd /sgl-workspace/aiter && grep -rnE "/tmp|/sgl-workspace" doc-mimo/comm/ | grep -v "FLYDSL_DUMP_DIR=/tmp\|/tmp/fdts"; head -12 doc-mimo/comm/peer_atomic_probe.py | head -5
```

命令（Record environment versions and file sizes for the README.）：
```bash
cd /sgl-workspace/aiter && python -c "import flydsl,torch;print(getattr(flydsl,'__version__','?'), torch.__version__)" 2>&1 | tail -1; pip show flydsl 2>/dev/null | grep -i version; wc -l doc-mimo/kernels/*.py doc-mimo/comm/*.py
```

命令（Smoke-test the doc-mimo copies (gemm2 pytest case and the two-shot bench).）：
```bash
cd /sgl-workspace/aiter && timeout 900 python -m pytest -q doc-mimo/kernels/test_a8w4_gemm2.py -k "uniform and True and 32" -p no:cacheprovider 2>&1 | tail -1; timeout 600 torchrun --nproc_per_node=8 doc-mimo/comm/twoshot_bench.py 512 2>&1 | grep -E "^tok|Error|Traceback"
```

Quick check that the copies run from the new location:

Now the README:

I've put everything into `doc-mimo/`. I re-ran two of the copied files from their new location: the gemm2 test (one pytest case, passes) and the two-shot benchmark (512 tokens: 30.4 µs vs RCCL 69.4 µs, all checks pass). The rest were copied but not re-run there.

```
doc-mimo/
  README.md                              # summary, in Chinese
  kernels/
    test_a8w4_gemm1.py                   # gemm1 kernel + correctness/perf test
    test_a8w4_gemm2.py                   # gemm2 kernel + correctness/perf test
    test_a8w4_gemm2_tp.py                # 8-GPU gemm2 + RCCL / two-shot all-reduce (incl. IPC shared buffer)
    test_a8w4_fmoe.py                    # gemm1+gemm2 fused into one kernel
    test_flydsl_moe_a16wfp4.py           # end-to-end test with the a8w4 comparison (full file)
    test_flydsl_moe_a16wfp4.e2e.patch    # the same changes as a diff against the base commit
  comm/
    peer_atomic_probe.py                 # cross-GPU atomic: correctness + bandwidth
    peer_store_probe.py                  # cross-GPU plain store / load bandwidth
    twoshot_bench.py                     # two-shot all-reduce vs RCCL, checked over 200 rounds
    twoshot_isa_dump.py                  # dumps the two-shot kernel's assembly
```

- **The copies run from their new location.** Files in `kernels/` import each other from the same folder. I changed the hard-coded `/tmp` and `op_tests` paths in the `comm/` scripts to relative ones. The originals in `op_tests/` are untouched.
- **Environment recorded in the README:** aiter `812dbb29b`, FlyDSL 0.3.2, torch 2.9.1+rocm7.2.0, 8× MI300X.

[README.md](doc-mimo/README.md) has six sections:

1. **gemm1**: the three optimisations and their results.
2. **gemm2**: the write-back and row-skipping optimisations and their results.
3. **End-to-end and the fused single kernel**: the comparison with `fused_moe`, the fused-kernel results, why fusing didn't pay off, and the directions that were tried and dropped.
4. **Cross-GPU communication** (the main part):
   - the RCCL baseline;
   - the cross-GPU atomic experiment and why it doesn't work;
   - the store/load bandwidth measurements, including the slow first version where all writes hit one link;
   - the two-shot all-reduce design, its three speed-ups from 88.8 to 30.5 µs, and the final results.
5. **Lessons and pitfalls**: dumping assembly, measurement noise, FlyDSL quirks, cross-GPU access and memory ordering, the flag protocol.
6. **Next steps**, including merging the two-shot all-reduce into the tail of gemm2.


---

## 26. 请求（2026-10-29 01:32 UTC）

> 刚才/tmp下面的实验代码和对应实验结果也放到doc-mimo下面

命令（List /tmp to find remaining experiment scripts and result files.）：
```bash
cd /tmp && ls -la --time-style=+%m-%d_%H:%M | grep -vE "^d.* (\.|\.\.)$" | head -80
```

命令（Inspect remaining scripts, result files and dump directory sizes.）：
```bash
cd /tmp && ls *.py *.txt 2>/dev/null; du -sh att fd fd2 fd3 fd4 fd5 fd6 fdts aiter_configs 2>/dev/null; ls att fd fd2 fd3 fd4 fd5 fd6 fdts | head -80; find fd* -name "21_final_isa.s" | wc -l
```

命令（Read the remaining experiment scripts and the ATT log to describe them.）：
```bash
cd /tmp && for f in att_an.py sweep.py sweep2.py sweep_g2.py prof_fmoe.py dbg_fmoe.py chk_tk.py tp_dbg.py; do echo "=== $f"; cat $f; done; echo; head -30 att_log.txt; ls att/ui_output_agent_64551_dispatch_6005 | head; du -sh att/*.csv att/ui_output_agent_64551_dispatch_600*
```

命令（Inspect the conversation transcript format to extract recorded experiment outputs.）：
```bash
T=/root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec-2/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl; ls -la $T; wc -l $T; python3 - <<EOF
import json
p="$T"
rows=[json.loads(l) for l in open(p)]
print(rows[0].keys())
import collections
print(collections.Counter(r.get('type') for r in rows).most_common(10))
for r in rows[:3]: print(json.dumps(r)[:600])
EOF
```

命令（Inspect tool start/complete record structure in the transcript.）：
```bash
T=/root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec-2/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl; python3 - <<EOF
import json
rows=[json.loads(l) for l in open("$T")]
s=[r for r in rows if r['type']=='tool.execution_start']
c=[r for r in rows if r['type']=='tool.execution_complete']
print(json.dumps(s[5]['data'])[:800]); print(json.dumps(c[5]['data'])[:800])
EOF
```

命令（Check whether tool outputs are stored anywhere (transcript or session resources).）：
```bash
T=/root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec-2/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl; python3 - <<EOF
import json, collections
rows=[json.loads(l) for l in open("$T")]
c=[r for r in rows if r['type']=='tool.execution_complete']
print(collections.Counter(tuple(sorted(r['data'].keys())) for r in c))
a=[r for r in rows if r['type']=='assistant.message']
print(json.dumps(a[40]['data'])[:300])
txt=" ".join(json.dumps(r['data']) for r in a)
for k in ["RESULT","BEST","RES 51","new=","fused="]:
    print(k, txt.count(k))
EOF
ls /root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec/GitHub.copilot-chat/chat-session-resources/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8/ | wc -l
```

命令（List user requests captured by the transcript and check for newer transcripts.）：
```bash
T=/root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec-2/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl; python3 - <<EOF
import json
rows=[json.loads(l) for l in open("$T")]
for r in rows:
    if r['type']=='user.message': print(r['timestamp'], r['data']['content'][:100].replace("\n"," "))
EOF
ls -la /root/.vscode-server/data/User/workspaceStorage/*/GitHub.copilot-chat/transcripts/ 2>/dev/null | tail -5
```

命令（Check the newer transcript's coverage.）：
```bash
T=/root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl; python3 - <<EOF
import json
rows=[json.loads(l) for l in open("$T")]
print(len(rows), rows[0]['timestamp'], rows[-1]['timestamp'])
for r in rows:
    if r['type']=='user.message': print(r['timestamp'], r['data']['content'][:80].replace("\n"," "))
EOF
```

命令（Rebuild a chronological session log (requests, terminal commands, reported results) from the two chat transcripts.）：
```bash
mkdir -p /tmp/extract && cat > /tmp/extract/build_log.py <<'EOF'
"""Rebuild a chronological experiment log (requests, commands, reported results)
from the Copilot chat transcripts (tool outputs are not stored there)."""
import json, sys
OLD, NEW, OUT = sys.argv[1:4]

def load(p):
    return [json.loads(l) for l in open(p)]

old = load(OLD)
new = [r for r in load(NEW) if r["timestamp"] > "2026-10-28T22:12:13"]
events = old + new
out = ["# Mimo a8w4 实验会话记录（按时间顺序）\n",
       "由 Copilot 会话 transcript 自动整理：每个用户请求下列出执行过的终端命令和助手给出的分析/结果。",
       "注意：transcript 不保存工具的原始输出，数值结果以助手回复中的汇总为准；命令里的 /tmp/*.py 对应 experiments/scripts/。\n"]
n_req = 0
for r in events:
    t, d = r["type"], r["data"]
    if t == "user.message":
        n_req += 1
        out.append(f"\n---\n\n## {n_req}. 请求（{r['timestamp'][:16].replace('T', ' ')} UTC）\n")
        out.append("> " + d["content"].strip().replace("\n", "\n> ") + "\n")
    elif t == "assistant.message":
        for tr in d.get("toolRequests", []) or []:
            if tr.get("name") != "run_in_terminal":
                continue
            try:
                args = json.loads(tr["arguments"]) if isinstance(tr["arguments"], str) else tr["arguments"]
            except Exception:
                continue
            cmd = args.get("command", "").strip()
            if cmd:
                out.append(f"命令（{args.get('explanation', '').strip()}）：\n```bash\n{cmd}\n```\n")
        txt = (d.get("content") or "").strip()
        if txt:
            out.append(txt + "\n")
open(OUT, "w").write("\n".join(out))
print("requests", n_req, "lines", len(out))
EOF
python3 /tmp/extract/build_log.py /root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec-2/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl /root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl /tmp/extract/session_log.md && wc -c /tmp/extract/session_log.md && grep -n "^## " /tmp/extract/session_log.md
```

命令（Demote reply headings and inject the two requests missing from the transcripts, then rebuild the log.）：
```bash
cd /tmp/extract && python3 - <<'EOF'
import re
src = open("build_log.py").read()
src = src.replace('''        txt = (d.get("content") or "").strip()
        if txt:
            out.append(txt + "\\n")''', '''        txt = (d.get("content") or "").strip()
        if txt:
            # demote the reply's own headings below the request headings
            txt = re.sub(r"^(#+) ", lambda m: "#" * min(6, len(m.group(1)) + 2) + " ", txt, flags=re.M)
            out.append(txt + "\\n")''')
src = src.replace("import json, sys", "import json, re, sys")
# inject requests that the transcripts did not record as user.message
src = src.replace('''for r in events:
    t, d = r["type"], r["data"]''', '''MISSING = {
    "gemm1": "针对这个gemm1的 a8w4 moe kernel，先单独提取一个实现和对应测试用例到test_a8w4_gemm1.py，去除多余的a16w4的逻辑，该文件只需要kernel实现和正确性+perf测试（参照test_flydsl_a16wfp4_silu_e2e）",
    "twoshot": "把 two-shot 写成一个独立的 FlyDSL all-reduce kernel，先确认能否稳定在 30 us 左右",
}
injected = set()

def maybe_inject(r):
    global n_req
    d = r["data"]
    key = None
    if r["type"] == "assistant.message" and "gemm1" not in injected:
        for tr in d.get("toolRequests", []) or []:
            if tr.get("name") == "create_file" and "test_a8w4_gemm1.py" in str(tr.get("arguments")):
                key = "gemm1"
    if r in new and "twoshot" not in injected and r["type"] == "assistant.message":
        key = "twoshot"
    if key:
        injected.add(key)
        n_req += 1
        out.append(f"\\n---\\n\\n## {n_req}. 请求（{r['timestamp'][:16].replace('T', ' ')} UTC，transcript 未记录原文，按会话摘要补）\\n")
        out.append("> " + MISSING[key] + "\\n")

for r in events:
    maybe_inject(r)
    t, d = r["type"], r["data"]''')
open("build_log.py", "w").write(src)
EOF
python3 /tmp/extract/build_log.py /root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec-2/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl /root/.vscode-server/data/User/workspaceStorage/9f4d8d88b5e7d4b2fe8e743969a1e9ec/GitHub.copilot-chat/transcripts/cb4dd7c7-74bd-43c6-b854-32292d8a8ab8.jsonl /tmp/extract/session_log.md && grep -nE "^## " /tmp/extract/session_log.md
```

"""Reference for 512..4096 tokens: aiter fused_moe with each CK / asm candidate.

The reference branch picks CK 2-stage (bm16/32/64), asm stage1 + CK stage2 or
asm 1-stage kernels at these token counts (its model_configs CSV, tuned for
257/9 and 385/9). This script times every such candidate end to end
(sorting + quant + kernels, CUDA graph replay) on the 256/8 and 384/8 shapes,
one subprocess per candidate (some asm kernels fault), and keeps the fastest
correct one.

    python doc-mimo/experiments/bs_moe_tp8/ref_small.py --gpus 1 2 3 4 5 6 7
"""

import argparse
import json
import os
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
KDIR = os.path.join(HERE, "../../kernels")
MODELS = {"flash": (4096, 256, 256, 8), "pro": (6144, 256, 384, 8)}

CK = "moe_ck2stages_gemm{g}_{t}_MulABScaleExpertWeightA8W8blkscale_{v}_Nswizzle0_Quant4_MulRoutedWeight{w}{a}_F8_F8_B16"


def ck(g, t, v="v1"):
    return CK.format(g=g, t=t, v=v, w=0 if g == 1 else 1, a="_silu" if g == 1 else "")


def candidates():
    """(block_m, kernelName1, kernelName2, run_1stage, xbf16)."""
    out = []
    ck16 = ["128x16x128x128_1x2", "256x16x128x256_1x4"]
    for t1 in ck16:
        for t2 in ck16:
            out.append((16, ck(1, t1), ck(2, t2), 0, 0))
    out.append((32, ck(1, "256x32x128x128_1x4"), ck(2, "256x32x128x128_1x4"), 0, 0))
    for v1 in ("v1", "v3"):
        for v2 in ("v1", "v3"):
            out.append((64, ck(1, "256x64x128x128_1x4", v1), ck(2, "256x64x128x128_1x4", v2), 0, 0))
    s1 = "_ZN5aiter59fmoe_stage1_bf16_pertokenFp8_blockscale_g1u1_{}E"
    for m, tg, g2s in ((16, "4tg", ck16), (32, "3tg", ["256x32x128x128_1x4"]), (64, "2tg", ["256x64x128x128_1x4"])):
        for pf in ("pf2", "pf3"):
            for t2 in g2s:
                out.append((m, s1.format(f"{m}x128_{tg}_{pf}"), ck(2, t2), 0, 0))
    for name, m in (
        ("_ZN5aiter52fmoe_bf16_blockscaleFp8_g1u1_novs_silu_1tg_ps_32x256E", 32),
        ("_ZN5aiter50fmoe_bf16_blockscaleFp8_g1u1_vs_silu_1tg_ps_32x256E", 32),
        ("_ZN5aiter47fmoe_bf16_blockscaleFp8_g1u1_vs_ps_silu_32x128E", 32),
        ("_ZN5aiter49fmoe_bf16_blockscaleFp8_g1u1_novs_silu_1tg_32x256E", 32),
        ("_ZN5aiter47fmoe_bf16_blockscaleFp8_g1u1_vs_silu_1tg_32x256E", 32),
        ("_ZN5aiter43fmoe_bf16_blockscaleFp8_g1u1_vs_silu_32x384E", 32),
        ("_ZN5aiter45fmoe_bf16_blockscaleFp8_g1u1_novs_silu_32x384E", 32),
        ("_ZN5aiter50fmoe_bf16_blockscaleFp8_g1u1_vs_silu_1tg_ps_32x384E", 32),
        ("_ZN5aiter52fmoe_bf16_blockscaleFp8_g1u1_novs_silu_1tg_ps_32x384E", 32),
        ("_ZN5aiter47fmoe_bf16_blockscaleFp8_g1u1_vs_silu_1tg_64x384E", 64),
        ("_ZN5aiter50fmoe_bf16_blockscaleFp8_g1u1_vs_silu_1tg_ps_64x384E", 64),
        ("_ZN5aiter46fmoe_bf16_blockscaleFp8_g1u1_vs_ps_silu_64x256E", 64),
        ("_ZN5aiter46fmoe_bf16_blockscaleFp8_g1u1_vs_ps_silu_64x128E", 64),
        ("_ZN5aiter47fmoe_bf16_blockscaleFp8_g1u1_vs_pf2_silu_16x128E", 16),
        ("_ZN5aiter47fmoe_bf16_blockscaleFp8_g1u1_vs_pf2_silu_16x256E", 16),
    ):
        out.append((m, name, "", 1, 0))
    for name, m in (
        ("_ZN5aiter47fmoe_bf16_blockscaleBf16_g1u1_vs_ps_silu_32x128E", 32),
        ("_ZN5aiter47fmoe_bf16_blockscaleBf16_g1u1_vs_ps_silu_32x256E", 32),
        ("_ZN5aiter48fmoe_bf16_blockscaleBf16_g1u1_vs_pf2_silu_16x128E", 16),
        ("_ZN5aiter48fmoe_bf16_blockscaleBf16_g1u1_vs_pf2_silu_16x256E", 16),
    ):
        out.append((m, name, "", 1, 1))
    return out


HEADER = (
    "gfx,cu_num,token,model_dim,inter_dim,expert,topk,act_type,dtype,q_dtype_a,q_dtype_w,"
    "q_type,use_g1u1,doweight_stage1,block_m,ksplit,us1,kernelName1,err1,us2,kernelName2,"
    "err2,us,run_1stage,xbf16,flat,tflops,bw,_tag"
)


def write_cfg(path, model, tokens, cand):
    H, I, E, topk = MODELS[model]
    bm, k1, k2, one, xbf16 = cand
    row = (
        f"gfx950,256,{tokens},{H},{I},{E},{topk},ActivationType.Silu,torch.bfloat16,"
        f"torch.float8_e4m3fn,torch.float8_e4m3fn,QuantType.per_1x128,1,0,{bm},0,0,{k1},0.0%,"
        f"0,{k2},0.0%,0,{one},{xbf16},0,0,0,"
    )
    with open(path, "w") as f:
        f.write(HEADER + "\n" + row + "\n")


def child(model, tokens, iters, warm):
    import torch

    sys.path.insert(0, KDIR)
    from aiter import ActivationType, QuantType
    from aiter.fused_moe import fused_moe
    from test_bs_moe import check, make_case, ref_moe

    case = make_case(model, tokens)

    def run():
        return fused_moe(
            case["x"], case["w1"], case["w2"], case["topk_weights"], case["topk_ids"],
            activation=ActivationType.Silu, quant_type=QuantType.per_1x128,
            w1_scale=case["w1_scale"], w2_scale=case["w2_scale"],
        )

    out = run()
    torch.cuda.synchronize()
    g = torch.Generator(device="cuda").manual_seed(1)
    idx = torch.randperm(tokens, device="cuda", generator=g)[:256]
    rel, bad = check(out[idx], ref_moe(case, idx))
    res = dict(rel=rel, bad=bad, finite=bool(torch.isfinite(out).all()))

    for _ in range(warm):
        run()
    torch.cuda.synchronize()
    e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    e0.record()
    for _ in range(iters):
        run()
    e1.record()
    torch.cuda.synchronize()
    res["eager_us"] = e0.elapsed_time(e1) * 1000 / iters

    try:
        s = torch.cuda.Stream()
        s.wait_stream(torch.cuda.current_stream())
        with torch.cuda.stream(s):
            run()
        torch.cuda.current_stream().wait_stream(s)
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph):
            run()
        for _ in range(warm):
            graph.replay()
        torch.cuda.synchronize()
        ts = []
        for _ in range(5):
            e0.record()
            for _ in range(iters):
                graph.replay()
            e1.record()
            torch.cuda.synchronize()
            ts.append(e0.elapsed_time(e1) * 1000 / iters)
        res["graph_us"] = sorted(ts)[2]
    except Exception as exc:  # some paths sync on the host
        res["graph_err"] = str(exc)[:200]
    print("RESULT " + json.dumps(res), flush=True)


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--model", nargs="+", default=["flash", "pro"])
    p.add_argument("-t", type=int, nargs="+", default=[512, 1024, 2048, 4096])
    p.add_argument("--gpus", type=int, nargs="+", default=[0])
    p.add_argument("--iters", type=int, default=30)
    p.add_argument("--warm", type=int, default=40)
    p.add_argument("--only", type=int, nargs="*", help="candidate indices")
    p.add_argument("--out", default="/tmp/ref_small")
    p.add_argument("--child", nargs=2, metavar=("MODEL", "T"))
    a = p.parse_args()
    if a.child:
        child(a.child[0], int(a.child[1]), a.iters, a.warm)
        return

    os.makedirs(a.out, exist_ok=True)
    cands = candidates()
    jobs = [
        (m, t, i) for m in a.model for t in a.t for i in range(len(cands))
        if a.only is None or i in a.only
    ]
    running, results = {}, {}
    while jobs or running:
        for gpu in a.gpus:
            if gpu not in running and jobs:
                m, t, i = jobs.pop(0)
                cfg = f"{a.out}/cfg_{m}_{t}_{i}.csv"
                write_cfg(cfg, m, t, cands[i])
                env = dict(os.environ, AITER_CONFIG_FMOE=cfg, HIP_VISIBLE_DEVICES=str(gpu))
                log = open(f"{a.out}/log_{m}_{t}_{i}.txt", "w")
                cmd = [sys.executable, __file__, "--child", m, str(t),
                       "--iters", str(a.iters), "--warm", str(a.warm)]
                proc = subprocess.Popen(cmd, env=env, stdout=log, stderr=subprocess.STDOUT)
                running[gpu] = (proc, (m, t, i), time.time(), log)
        for gpu, (proc, key, t0, log) in list(running.items()):
            if proc.poll() is None and time.time() - t0 < 600:
                continue
            if proc.poll() is None:
                proc.kill()
            log.close()
            text = open(log.name).read()
            res = None
            for line in text.splitlines():
                if line.startswith("RESULT "):
                    res = json.loads(line[7:])
            used = [ln for ln in text.splitlines() if "[fused_moe] using" in ln]
            if res is not None:
                res["used"] = used[-1][-300:] if used else ""
            results[key] = res
            m, t, i = key
            print(f"{m:5s} T={t:5d} cand {i:2d} {cands[i][1][:60]:60s} -> "
                  f"{json.dumps(res)[:160] if res else 'FAILED'}", flush=True)
            del running[gpu]
        time.sleep(0.5)

    with open(f"{a.out}/results.json", "w") as f:
        json.dump({f"{m}|{t}|{i}": r for (m, t, i), r in results.items()}, f, indent=1)
    print("\nbest correct candidate per case (graph replay us; eager us):")
    for m in a.model:
        for t in a.t:
            ok = [
                (r.get("graph_us", r["eager_us"]), r["eager_us"], i)
                for (mm, tt, i), r in results.items()
                if mm == m and tt == t and r and r["finite"] and r["rel"] < 0.02
            ]
            if not ok:
                print(f"{m:5s} T={t:5d}: no correct candidate")
                continue
            ok.sort()
            g_us, e_us, i = ok[0]
            bm, k1, k2, one, xbf16 = cands[i]
            print(f"{m:5s} T={t:5d}: {g_us:7.1f} us (eager {e_us:7.1f})  bm{bm} "
                  f"{'1stage' if one else '2stage'}{' xbf16' if xbf16 else ''} {k1} {k2}")


if __name__ == "__main__":
    main()

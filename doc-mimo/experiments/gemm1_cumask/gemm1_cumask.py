"""gemm1 under a HIP stream CU mask: use only C of the 38 CUs per XCD.

KFD maps CU-mask bit j to XCC (j % 8), local CU (j // 8), so "C CUs per XCD" =
bits [0, 8*C). Placement is verified with the HW_ID probe kernel of
cu_scaling_bw.py (one WG per CU). Then the standalone a8w4 gemm1 (and the port) is
timed on streams masked to C = 38/36/32/28/24/19/16 CUs per XCD.

At 512 tokens / 256 experts / bm32 / tn128 the grid is 1024 WGs = 128 per XCD; the
standalone kernel fits 2 WGs per CU, so C=32 -> exactly 2 rounds (4 WGs per CU),
C=38 -> 76 slots, 3 or 4 WGs per CU.

    python doc-mimo/experiments/gemm1_cumask/gemm1_cumask.py
"""
import ctypes
import os
import sys

import torch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, "../../kernels"))
sys.path.insert(0, os.path.join(HERE, "../cu_scaling_bw"))  # HW_ID probe kernel

NXCD, CU_PER_XCD = 8, 38
hip = ctypes.CDLL("libamdhip64.so")


def masked_stream(c_per_xcd):
    n = NXCD * CU_PER_XCD
    words = (ctypes.c_uint32 * ((n + 31) // 32))()
    for j in range(NXCD * c_per_xcd):
        words[j // 32] |= 1 << (j % 32)
    s = ctypes.c_void_p()
    err = hip.hipExtStreamCreateWithCUMask(ctypes.byref(s), len(words), words)
    assert err == 0, f"hipExtStreamCreateWithCUMask failed: {err}"
    return torch.cuda.ExternalStream(s.value)


def verify(streams):
    import cu_scaling_bw as cb  # compiles the probe kernel, allocates its 2 GiB buffer

    for c, st in streams.items():
        with torch.cuda.stream(st):
            hw = torch.full((2 * 8 * 38,), -1, dtype=torch.int32, device="cuda")
            ctr = torch.zeros(1, dtype=torch.int32, device="cuda")
            cb.mod.rd(cb.buf, 1 << 16, 8, 38, 256, 4, hw, cb.out, 1, ctr, 64)
            torch.cuda.synchronize()
        loc = {}
        for hwid, xcc in hw.view(-1, 2).cpu().tolist():
            se, cu = (hwid >> 13) & 7, (hwid >> 8) & 0xF
            loc.setdefault(xcc & 0xF, set()).add((se, (hwid >> 12) & 1, cu))
        per_x = sorted(len(v) for v in loc.values())
        per_se = {}
        for x, v in loc.items():
            for se, sh, cu in v:
                per_se[x, se] = per_se.get((x, se), 0) + 1
        print(f"  mask {c:2d} CU/XCD: 304 WGs ran on {sum(per_x)} distinct CUs, per XCD "
              f"{per_x[0]}-{per_x[-1]}, per SE {min(per_se.values())}-{max(per_se.values())}")
    del cb.buf
    torch.cuda.empty_cache()


def grab_candidates(**kw):
    import test_a8w4_gemm1 as T

    fns = {}

    def fake_perftest(fn, *a, **k):
        name = ("a8w4_gemm1", "port", "a8w4_tile", "a8w4_fd1", "a8w4_fd2")[len(fns)]
        fns[name] = fn
        return fn(), 1.0

    T.run_perftest = fake_perftest
    r = T.bench_a8w4_gemm1(512, 4096, 512, 256, 8, routing="uniform", tile_m=32, **kw)
    assert r["bitexact vs port"] and r["a8w4_gemm1 err"] == 0
    return fns


def timeit(fn, st, reps=100):
    with torch.cuda.stream(st):
        for _ in range(5):
            fn()
        torch.cuda.synchronize()
        best = 1e18
        for _ in range(3):
            e0 = torch.cuda.Event(enable_timing=True)
            e1 = torch.cuda.Event(enable_timing=True)
            torch.cuda._sleep(2_000_000)
            e0.record(st)
            for _ in range(reps):
                fn()
            e1.record(st)
            torch.cuda.synchronize()
            best = min(best, e0.elapsed_time(e1) * 1e3 / reps)
    return best


if __name__ == "__main__":
    CS = (38, 36, 32, 28, 24, 19, 16)
    streams = {c: masked_stream(c) for c in CS}
    print("placement check (HW_ID probe, 1 WG per CU):")
    verify(streams)
    NBYTES = 256 * 1024 * (2048 + 128) + 512 * 4096 + 512 * 8 * 512 * 2
    for tn in (128, 64):
        fns = grab_candidates(tile_n=tn, b_cache_mod=2)
        print(f"\ntile_n={tn} (grid {256 * 512 // tn} WGs), b_cache_mod=2, us (TB/s):")
        print("  CU/XCD " + "".join(f"{c:>17}" for c in ("default stream",) + CS))
        for name in ("a8w4_gemm1", "port"):
            for rep in range(2):
                ts = [timeit(fns[name], torch.cuda.default_stream())]
                ts += [timeit(fns[name], streams[c]) for c in CS]
                print(f"  {name:<11}" + "".join(
                    f"{t:9.1f} ({NBYTES / t / 1e6:4.2f})" for t in ts), flush=True)

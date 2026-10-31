"""How many CUs (and XCDs) does a pure HBM read need to saturate bandwidth?

HIP kernel, one WG per CU guaranteed by 64 KB static LDS (= the whole CU LDS).
WG pid lands on XCD pid % 8 (round-robin dispatch); only WGs with
pid % 8 < NX and pid // 8 < NCU do work, so the active set is NX XCDs x NCU CUs.
Every active WG records HW_ID / XCC_ID so placement (distinct CUs, CUs per SE) is
verified. A fixed 2 GiB read (>> 256 MB MALL) is split either dynamically (dyn=1,
default: WGs claim 1 MB chunks from an atomic counter) or statically (dyn=0: slowest
WG sets the time); each thread keeps UNROLL x 16 B loads in flight.
Results: results/cu_scaling_bw.txt

    python doc-mimo/experiments/cu_scaling_bw/cu_scaling_bw.py
"""
import itertools
import os

import torch
from torch.utils.cpp_extension import load_inline

os.environ.setdefault("PYTORCH_ROCM_ARCH", "gfx942")
CUDA_SRC = r"""
#include <hip/hip_runtime.h>
#include <torch/extension.h>

template <int UNROLL>
__device__ __forceinline__ int rd_range(const int4* __restrict__ base, long n) {
  int acc = 0;
  const int step = blockDim.x * UNROLL;
  for (long i = threadIdx.x; i < n; i += step) {
    int4 v[UNROLL];
#pragma unroll
    for (int u = 0; u < UNROLL; ++u) {
      long j = i + (long)u * blockDim.x;
      v[u] = j < n ? base[j] : make_int4(0, 0, 0, 0);
    }
#pragma unroll
    for (int u = 0; u < UNROLL; ++u) acc ^= v[u].x ^ v[u].y ^ v[u].z ^ v[u].w;
  }
  return acc;
}

// dyn == 0: active WG w reads its own contiguous 1/nact of the buffer (slowest WG
// sets the time). dyn == 1: active WGs claim 1 MB chunks from an atomic counter.
template <int UNROLL>
__global__ void rd_kernel(const int4* __restrict__ p, long vec_per_wg, int nx, int ncu,
                          int* __restrict__ hw, int* __restrict__ out, int dyn,
                          int* __restrict__ ctr, int nchunks) {
  __shared__ int pad[16384];  // 64 KB: one WG per CU
  const int pid = blockIdx.x;
  const int x = pid % 8, c = pid / 8;
  if (x >= nx || c >= ncu) return;
  if (threadIdx.x == 0) {
    int hwid, xcc;
    asm volatile("s_getreg_b32 %0, hwreg(HW_REG_HW_ID)" : "=s"(hwid));
    asm volatile("s_getreg_b32 %0, hwreg(HW_REG_XCC_ID)" : "=s"(xcc));
    hw[2 * pid] = hwid;
    hw[2 * pid + 1] = xcc;
  }
  int acc = 0;
  if (dyn) {
    constexpr long CH = 65536;  // 1 MB of int4
    while (true) {
      if (threadIdx.x == 0) pad[0] = atomicAdd(ctr, 1);
      __syncthreads();
      const int ch = pad[0];
      __syncthreads();
      if (ch >= nchunks) break;
      acc ^= rd_range<UNROLL>(p + (long)ch * CH, CH);
    }
  } else {
    const long widx = (long)x * ncu + c;
    acc = rd_range<UNROLL>(p + widx * vec_per_wg, vec_per_wg);
  }
  pad[threadIdx.x] = acc;
  __syncthreads();
  if (pad[(threadIdx.x + 1) % blockDim.x] == 0x7eadbeef) out[0] = acc;  // keep loads live
}

void rd(torch::Tensor buf, int64_t vec_per_wg, int64_t nx, int64_t ncu, int64_t threads,
        int64_t unroll, torch::Tensor hw, torch::Tensor out, int64_t dyn, torch::Tensor ctr,
        int64_t nchunks) {
  dim3 grid(8 * ncu), block(threads);
  auto s = at::cuda::getCurrentCUDAStream();
  const int4* p = reinterpret_cast<const int4*>(buf.data_ptr());
  int* h = hw.data_ptr<int>();
  int* o = out.data_ptr<int>();
  int* c = ctr.data_ptr<int>();
  if (unroll == 4)
    rd_kernel<4><<<grid, block, 0, s>>>(p, vec_per_wg, nx, ncu, h, o, dyn, c, nchunks);
  else if (unroll == 8)
    rd_kernel<8><<<grid, block, 0, s>>>(p, vec_per_wg, nx, ncu, h, o, dyn, c, nchunks);
  else
    rd_kernel<16><<<grid, block, 0, s>>>(p, vec_per_wg, nx, ncu, h, o, dyn, c, nchunks);
}
"""
CPP_SRC = ("void rd(torch::Tensor buf, int64_t vec_per_wg, int64_t nx, int64_t ncu, "
           "int64_t threads, int64_t unroll, torch::Tensor hw, torch::Tensor out, "
           "int64_t dyn, torch::Tensor ctr, int64_t nchunks);")

mod = load_inline(
    name="cu_scaling_bw",
    cpp_sources=CPP_SRC,
    cuda_sources=CUDA_SRC.replace("#include <torch/extension.h>",
                                  "#include <torch/extension.h>\n#include <ATen/cuda/CUDAContext.h>"),
    functions=["rd"],
    extra_cuda_cflags=["-O3"],
    verbose=False,
)

TOTAL = 2 << 30  # bytes read per launch
buf = torch.randint(-2**31, 2**31 - 1, (TOTAL // 4,), dtype=torch.int32, device="cuda")
out = torch.zeros(1, dtype=torch.int32, device="cuda")


def run(nx, ncu, threads=1024, unroll=4, dyn=1, reps=20):
    nact = nx * ncu
    vec = TOTAL // 16 // nact
    nchunks = TOTAL // (1 << 20)
    hw = torch.full((2 * 8 * ncu,), -1, dtype=torch.int32, device="cuda")
    ctr = torch.zeros(reps + 1, dtype=torch.int32, device="cuda")

    def f(i=0):
        mod.rd(buf, vec, nx, ncu, threads, unroll, hw, out, dyn, ctr[i:i + 1], nchunks)

    f()
    torch.cuda.synchronize()
    # placement check: distinct (xcc, se, sh, cu) among active WGs
    h = hw.view(-1, 2).cpu().tolist()
    loc = set()
    for hwid, xcc in h:
        if hwid == -1:
            continue
        cu, sh, se = (hwid >> 8) & 0xF, (hwid >> 12) & 1, (hwid >> 13) & 0x7
        loc.add((xcc & 0xF, se, sh, cu))
    xccs = len({l[0] for l in loc})
    # max / min active CUs per SE (over all XCDs): spread of the placement
    per_se = {}
    for xcc, se, sh, cu in loc:
        per_se[xcc, se] = per_se.get((xcc, se), 0) + 1
    spread = (min(per_se.values()), max(per_se.values()), len(per_se)) if per_se else (0, 0, 0)
    best = 1e18
    for t in range(3):
        ctr.zero_()
        e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
        torch.cuda._sleep(1_000_000)
        e0.record()
        for i in range(reps):
            f(i)
        e1.record()
        torch.cuda.synchronize()
        best = min(best, e0.elapsed_time(e1) * 1e3 / reps)
    bw = TOTAL / best / 1e6 if dyn else nact * vec * 16 / best / 1e6
    return bw, best, len(loc), xccs, spread


if __name__ == "__main__":
    res = []

    def show(tag, nx, ncu, **kw):
        bw, us, ncu_seen, xccs, (smin, smax, nse) = run(nx, ncu, **kw)
        line = (f"{tag:<9} XCD={nx} CU/XCD={ncu:2d} total CU={nx * ncu:3d} "
                f"thr={kw.get('threads', 1024):4d} unroll={kw.get('unroll', 4):2d} "
                f"dyn={kw.get('dyn', 1)}: {bw:5.2f} TB/s ({us:7.1f} us)  placed on "
                f"{ncu_seen} CUs / {xccs} XCDs, CUs per SE {smin}-{smax} over {nse} SEs")
        print(line, flush=True)
        res.append(line)

    # A: all 8 XCDs, sweep CUs per XCD (dynamic chunks, best per-CU MLP config)
    for ncu in (1, 2, 3, 4, 5, 6, 8, 10, 12, 14, 16, 20, 24, 32, 38):
        show("A 8xcd", 8, ncu)
    # A': same with static split (slowest WG sets time)
    for ncu in (2, 3, 4, 6, 8, 16, 38):
        show("A' static", 8, ncu, dyn=0)
    # B: fewer XCDs, all 38 CUs -> per-XCD ceiling
    for nx in (1, 2, 3, 4, 5, 6, 7):
        show("B xcd", nx, 38)
    for nx, ncu in ((1, 8), (1, 16), (4, 16), (6, 16)):
        show("B xcd", nx, ncu)
    # C: per-CU parallelism (threads x unroll) at a few CU counts
    for ncu, thr, un in itertools.product((1, 4, 8, 16), (256, 512, 1024), (4, 16)):
        show("C mlp", 8, ncu, threads=thr, unroll=un)

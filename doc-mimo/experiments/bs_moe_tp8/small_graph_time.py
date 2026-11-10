"""bs_small vs bs_moe at small token counts: CUDA-graph replay (the method of ref_small.py)
next to the per-launch event timing of test_bs_moe.py.

    python doc-mimo/experiments/bs_moe_tp8/small_graph_time.py flash,pro 512,1024,2048,4096
"""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
from test_bs_moe import make_case, run_moe, time_stages  # noqa: E402

for model in sys.argv[1].split(","):
    for T in [int(t) for t in sys.argv[2].split(",")]:
        case = make_case(model, T)
        for small in (True, False):
            fns, out = run_moe(case, small=small)
            _, ev = time_stages(fns, iters=30, warm=40)

            def run():
                for _, f in fns:
                    f()

            s = torch.cuda.Stream()
            s.wait_stream(torch.cuda.current_stream())
            with torch.cuda.stream(s):
                run()
            torch.cuda.current_stream().wait_stream(s)
            g = torch.cuda.CUDAGraph()
            with torch.cuda.graph(g):
                run()
            for _ in range(40):
                g.replay()
            torch.cuda.synchronize()
            e0, e1 = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            ts = []
            for _ in range(5):
                e0.record()
                for _ in range(30):
                    g.replay()
                e1.record()
                torch.cuda.synchronize()
                ts.append(e0.elapsed_time(e1) * 1000 / 30)
            print(f"{model:5s} T={T:5d} {'bs_small' if small else 'bs_moe  '}: "
                  f"events {ev:7.1f} us  graph {sorted(ts)[2]:7.1f} us", flush=True)
            del g, fns, out
        del case
        torch.cuda.empty_cache()

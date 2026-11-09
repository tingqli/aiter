"""Upper bound of better weight (B) reuse in gemm1, measured inside the pipeline.

gemm1 runs with the real sorted_expert_ids or with every block mapped to expert 0
(B tiles shared by all tasks; output is wrong, timing shows the B-traffic cost).
"""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_bs_moe as t  # noqa: E402

model, T = sys.argv[1], int(sys.argv[2])
case = t.make_case(model, T)
fns, out = t.run_moe(case)
fns = dict(fns)
# The stages share one state dict (closure cell of the gemm1 stage).
cells = fns["gemm1"].__closure__
state = [c.cell_contents for c in cells if isinstance(c.cell_contents, dict) and "sort" in c.cell_contents][0]


se0 = torch.zeros_like(state["sort"][2])


def gemm1_zero():
    sort = state["sort"]
    state["sort"] = (sort[0], sort[1], se0, sort[3])
    fns["gemm1"]()
    state["sort"] = sort


for _ in range(2):  # alternate, so neither side gets the cold clocks
    for name, g in (("real", fns["gemm1"]), ("expert0", gemm1_zero)):
        seq = [("prep", fns["prep"]), ("gemm1", g), ("down", fns["down"]), ("reduce", fns["reduce"])]
        per, tot = t.time_stages(seq, warm=40)
        print(f"{model} T={T} {name:8s} " + " ".join(f"{n} {p:7.1f}" for (n, _), p in zip(seq, per)), flush=True)

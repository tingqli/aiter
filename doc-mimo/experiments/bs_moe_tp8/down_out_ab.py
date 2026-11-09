"""Down output path A/B inside the pipeline: route buffer + topk reduce ("store")
vs packed BF16 atomics into a zeroed out ("atomic"), for Down oc splits 2 / 4.

    python doc-mimo/experiments/bs_moe_tp8/down_out_ab.py flash 8192 16384 32768
"""
import os
import sys

import torch

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../kernels"))
import test_bs_moe as t  # noqa: E402

CONFIGS = [("store", 2), ("store", 4), ("atomic", 2), ("atomic", 4)]


def main():
    model, tokens = sys.argv[1], [int(v) for v in sys.argv[2:]]
    for T in tokens:
        case = t.make_case(model, T)
        idx = torch.randperm(T, device="cuda", generator=torch.Generator(device="cuda").manual_seed(1))[:256]
        ref = t.ref_moe(case, idx)
        runs = {}
        for mode, oc in CONFIGS:
            fns, out = t.run_moe(case, down_out=mode, down_splits=oc)
            torch.cuda.synchronize()
            rel, bad = t.check(out[idx], ref)
            runs[(mode, oc)] = (fns, rel, bad)
        for rnd in range(2):  # alternate, so no config gets the cold clocks
            for (mode, oc), (fns, rel, bad) in runs.items():
                per, tot = t.time_stages(fns, warm=40)
                parts = " ".join(f"{n} {p:6.1f}" for (n, _), p in zip(fns, per))
                print(f"{model} T={T:6d} {mode:6s} oc{oc} r{rnd}: {parts} | total {tot:7.1f}"
                      f" | rel {rel:.2e} bad {bad:.1e}", flush=True)
        del runs, case
        torch.cuda.empty_cache()


if __name__ == "__main__":
    main()

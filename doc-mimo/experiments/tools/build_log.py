"""Rebuild a chronological experiment log (requests, commands, reported results)
from the Copilot chat transcripts (tool outputs are not stored there)."""
import json, re, sys
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
MISSING = {
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
        out.append(f"\n---\n\n## {n_req}. 请求（{r['timestamp'][:16].replace('T', ' ')} UTC，transcript 未记录原文，按会话摘要补）\n")
        out.append("> " + MISSING[key] + "\n")

for r in events:
    maybe_inject(r)
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
            # demote the reply's own headings below the request headings
            txt = re.sub(r"^(#+) ", lambda m: "#" * min(6, len(m.group(1)) + 2) + " ", txt, flags=re.M)
            out.append(txt + "\n")
open(OUT, "w").write("\n".join(out))
print("requests", n_req, "lines", len(out))

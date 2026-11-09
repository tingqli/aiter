"""Which XCD does workgroup bx run on (MI350X)? Records HW_REG_XCC_ID per WG."""
import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir.dialects import llvm
from flydsl.expr.typing import T


def _sreg(asm):
    return fx.Int32(llvm.inline_asm(T.i32, [], asm, "=s", has_side_effects=True))


@flyc.kernel(known_block_size=[64, 1, 1])
def xcc_kernel(out: fx.Tensor):
    bx = fx.Int32(fx.block_idx.x)
    if fx.Int32(fx.thread_idx.x) == 0:
        out[bx * 2] = _sreg("s_getreg_b32 $0, hwreg(HW_REG_XCC_ID)")
        out[bx * 2 + 1] = _sreg("s_getreg_b32 $0, hwreg(HW_REG_HW_ID)")


@flyc.jit
def launch(out: fx.Tensor, n: fx.Constexpr[int], stream: fx.Stream = fx.Stream(None)):
    xcc_kernel(out).launch(grid=(n, 1, 1), block=(64, 1, 1), stream=stream)


for n in (256, 512, 2048):
    out = torch.full((2 * n,), -1, dtype=torch.int32, device="cuda")
    launch(out, n)
    torch.cuda.synchronize()
    xcc = out[0::2].cpu() & 0xF
    bx = torch.arange(n)
    print(n, "xcc == bx % 8:", bool((xcc == bx % 8).all()), "first 16:", xcc[:16].tolist())

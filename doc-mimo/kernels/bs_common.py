# SPDX-License-Identifier: MIT
# Copyright (C) 2024-2026, Advanced Micro Devices, Inc. All rights reserved.
"""Shared helpers for the gfx950 FP8 blockscale (W128x128 / A1x128) MoE kernels.

Ported from tq/moe_gemm_blockscale (50ed9814c2):
aiter/ops/flydsl/kernels/moe_gemm_2stage/gfx9_fp8/{common,a8w8_blockscale_common}.py
(only what the bs_* kernels use).
"""

import inspect

import flydsl.compiler as flyc
import flydsl.expr as fx
import torch
from flydsl._mlir import ir
from flydsl._mlir.dialects import llvm, rocdl
from flydsl._mlir.dialects.fly_rocdl import TargetAddressSpace
from flydsl.expr.meta import dsl_loc_tracing
from flydsl.expr.typing import Vector as Vec
from flydsl.expr.typing import (
    is_generic_address_space,
    is_target_address_space,
)

_TORCH_TO_FX = {
    torch.bfloat16: fx.BFloat16,
    torch.float32: fx.Float32,
    torch.int32: fx.Int32,
    torch.float8_e4m3fn: fx.Uint8,
    torch.uint8: fx.Uint8,
}


def _ptr(t):
    return flyc.from_c_void_p(_TORCH_TO_FX[t.dtype], t.data_ptr())


def rocdl_aux(value=0):
    return ir.IntegerAttr.get(fx.Int32.ir_type, value)


def get_device_cache_key():
    device = torch.cuda.current_device()
    properties = torch.cuda.get_device_properties(device)
    return (
        device,
        properties.name,
        properties.gcnArchName,
        properties.multi_processor_count,
    )


def pin_vgpr(value):
    """Pin a numeric scalar or vector to VGPRs with tied empty asm."""
    raw = value.ir_value()
    result = llvm.inline_asm(raw.type, [raw], "", "=v,0", has_side_effects=True)
    if isinstance(raw.type, ir.VectorType):
        return fx.Vector(result)
    return fx.Numeric.from_ir_type(raw.type)(result)


def llvm_extract_as_vector(element_type, *args):
    elements = []
    current_vec = None
    for arg in args:
        if isinstance(arg, (list, tuple)):
            assert current_vec is not None
            elements.append(
                element_type(llvm.extractvalue(element_type.ir_type, current_vec, arg))
            )
        else:
            current_vec = arg
    return fx.Vector.from_elements(elements, element_type)


def asm_mark(mark: str):
    """Scheduling fence + `s_nop 1` tagged with the caller's file:line (ISA marker)."""
    caller_frame = inspect.currentframe().f_back
    filename = caller_frame.f_code.co_filename
    lineno = caller_frame.f_lineno
    fx.rocdl.sched_barrier(0)
    llvm.inline_asm(
        ir.Type.parse("!llvm.void"),
        [],
        f"s_nop 1; {mark}  {filename}:{lineno}",
        "",
        has_side_effects=True,
    )
    fx.rocdl.sched_barrier(0)


def _offset_i32(value):
    if isinstance(value, (fx.Int32, fx.Uint32)):
        return value.ir_value()
    if (
        isinstance(value, ir.Value)
        and isinstance(value.type, ir.IntegerType)
        and value.type.width == 32
    ):
        return value
    if (
        isinstance(value, int)
        and not isinstance(value, bool)
        and -(1 << 31) <= value < (1 << 32)
    ):
        return fx.Uint32(value & 0xFFFFFFFF).ir_value()
    raise TypeError("offset requires a precomputed 32-bit SSA value or integer")


class BufferTensor(fx.Tensor):
    @dsl_loc_tracing
    def __getitem__(self, coord):
        result = super().__getitem__(coord)
        return type(self)(result) if isinstance(result, fx.Tensor) else result

    def _packet_bits(self):
        if not is_target_address_space(self.address_space, TargetAddressSpace.BufferDesc):
            raise TypeError("explicit buffer access requires a BufferDesc tensor")
        if (
            not self.layout.is_static
            or fx.rank(self.layout) != 1
            or self.stride.to_py_value() not in (1, (1,))
        ):
            raise ValueError("explicit buffer access requires a contiguous 1D packet")
        bits = fx.size(self).to_py_value() * self.dtype.width
        if bits not in (32, 64, 128):
            raise ValueError("buffer packets must be 32, 64, or 128 bits")
        return bits

    @dsl_loc_tracing
    def load(self, *, voffset_bytes=None, soffset_bytes=0, aux=0):
        if voffset_bytes is None:
            if not isinstance(soffset_bytes, int) or soffset_bytes != 0 or aux != 0:
                raise ValueError("explicit soffset/aux requires an explicit voffset_bytes")
            return super().load()
        bits = self._packet_bits()
        resource = fx.rocdl.get_buffer_rsrc(fx.get_iter(self))
        result = rocdl.RawPtrBufferLoadOp(
            ir.VectorType.get([bits // 32], fx.Uint32.ir_type),
            resource,
            _offset_i32(voffset_bytes),
            _offset_i32(soffset_bytes),
            aux=ir.IntegerAttr.get(fx.Int32.ir_type, aux),
        ).result
        return Vec(result).bitcast(self.dtype)


class LdsTensor(fx.Tensor):
    @dsl_loc_tracing
    def __getitem__(self, coord):
        result = super().__getitem__(coord)
        return type(self)(result) if isinstance(result, fx.Tensor) else result

    def _addressed(self, address_bytes, offset_bytes):
        if not is_generic_address_space(self.address_space, fx.AddressSpace.Shared):
            raise TypeError("explicit LDS access requires a shared-memory tensor")
        element_bytes = self.dtype.width // 8
        if not element_bytes or not isinstance(offset_bytes, int) or offset_bytes % element_bytes:
            raise ValueError("LDS offset must be a compile-time aligned byte count")
        pointer = fx.get_iter(self)
        if address_bytes is not None:
            pointer = fx.inttoptr(pointer.type, fx.Int32(_offset_i32(address_bytes)))
        if offset_bytes:
            pointer = pointer + offset_bytes // element_bytes
        return fx.make_view(pointer, self.layout)

    @dsl_loc_tracing
    def load(self, *, address_bytes=None, offset_bytes=0, into=None, copy_atom=None):
        source = self._addressed(address_bytes, offset_bytes)
        if into is None:
            if copy_atom is not None:
                raise ValueError("copy_atom requires an into fragment")
            return source.load()
        if copy_atom is None:
            raise ValueError("into requires an explicit copy_atom")
        fx.copy(copy_atom, source, into)

    @dsl_loc_tracing
    def store(self, vector, *, address_bytes=None, offset_bytes=0, copy_atom=None):
        destination = self._addressed(address_bytes, offset_bytes)
        if copy_atom is None:
            return destination.store(vector)
        fx.copy(copy_atom, vector, destination)


# doc-mimo: device-scope counters (bs_prep grid barrier, bs_gemm1 batch sync).
SYS = 17  # sc0 | sc1 buffer-load aux: system-coherent, sees device-scope atomics


def _gptr(ptr):
    return llvm.inttoptr(ir.Type.parse("!llvm.ptr<1>"), fx.ptrtoint(ptr).ir_value())


def gatomic(op, ptr, val):
    """Device-scope monotonic atomic RMW on a global int32; returns the old value."""
    return fx.Int32(
        llvm.AtomicRMWOp(
            op, _gptr(ptr), fx.Int32(val).ir_value(), llvm.AtomicOrdering.monotonic,
            syncscope="agent",
        ).res
    )


def gatomic_add(ptr, val):
    return gatomic(llvm.AtomicBinOp.add, ptr, val)


def gatomic_xchg(ptr, val):
    return gatomic(llvm.AtomicBinOp.xchg, ptr, val)


def ptr_rsrc(ptr, nbytes):
    """Buffer resource for nbytes at a raw pointer."""
    buf = fx.rocdl.make_buffer_tensor(
        fx.make_view(fx.recast_iter(fx.Uint8, ptr), fx.make_layout(nbytes, 1)), False
    )
    return fx.rocdl.get_buffer_rsrc(fx.get_iter(buf))

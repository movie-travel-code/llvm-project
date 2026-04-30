; Test that containsOpenMP() still reports true (so OpenMPOpt runs) when the
; module has the "openmp" flag and a device kernel, even if no OpenMP runtime
; call is present.
;
; RUN: opt -passes=openmp-opt-cgscc -pass-remarks-analysis=openmp-opt \
; RUN:   -openmp-print-gpu-kernels -disable-output < %s 2>&1 | FileCheck %s

; CHECK: remark: <unknown>:0:0: OpenMP GPU kernel omp_kernel
define ptx_kernel void @omp_kernel() "kernel" {
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 7, !"openmp", i32 50}

; Test that containsOpenMP() makes OpenMPOpt early-exit when the module has
; the "openmp" flag but contains neither a device kernel nor any call to an
; OpenMP runtime entry point. In that case the pass must not run and must
; leave the IR untouched (no Attributor-inferred function attributes).
;
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s

define void @plain_host_fn(i32 %x) {
; CHECK-LABEL: define void @plain_host_fn(
; CHECK-SAME: i32 %x) {
; CHECK-NEXT: ret void
;
  ret void
}

; The pass should not have run, so no Attributor attribute groups should have
; been materialized.
; CHECK-NOT: attributes #

!llvm.module.flags = !{!0}
!0 = !{i32 7, !"openmp", i32 50}

; Test that containsOpenMP() does NOT treat a module as "containing OpenMP"
; merely because an OpenMP runtime declaration appears in @llvm.used. Such
; uses are non-call (ConstantExpr) uses, so use_empty() would be false but no
; CallBase user exists. OpenMPOpt must early-exit and leave the IR untouched.
;
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s

declare void @__kmpc_fork_call(ptr, i32, ptr, ...)

@llvm.used = appending global [1 x ptr] [ptr @__kmpc_fork_call], section "llvm.metadata"

define void @plain_host_fn() {
; CHECK-LABEL: define void @plain_host_fn(
; CHECK-SAME: ) {
; CHECK-NEXT: ret void
;
  ret void
}

; No Attributor attribute groups should have been added since the pass did
; not run.
; CHECK-NOT: attributes #

!llvm.module.flags = !{!0}
!0 = !{i32 7, !"openmp", i32 50}

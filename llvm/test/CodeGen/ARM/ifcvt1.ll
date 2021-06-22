; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi -mcpu=cortex-a8 %s -o - | FileCheck %s -check-prefix=A8
; RUN: llc -mtriple=arm-eabi -mcpu=swift %s -o - | FileCheck %s -check-prefix=SWIFT

define i32 @t1(i32 %a, i32 %b) {
; A8-LABEL: t1:
; A8:       @ %bb.0:
; A8-NEXT:    cmp r0, #0
; A8-NEXT:    subeq r0, r1, #1
; A8-NEXT:    addne r0, r1, #1
; A8-NEXT:    bx lr
;
; SWIFT-LABEL: t1:
; SWIFT:       @ %bb.0:
; SWIFT-NEXT:    cmp r0, #0
; SWIFT-NEXT:    sub r0, r1, #1
; SWIFT-NEXT:    addne r0, r1, #1
; SWIFT-NEXT:    bx lr
	%tmp2 = icmp eq i32 %a, 0
	br i1 %tmp2, label %cond_false, label %cond_true

cond_true:
	%tmp5 = add i32 %b, 1
	ret i32 %tmp5

cond_false:
	%tmp7 = add i32 %b, -1
	ret i32 %tmp7
}
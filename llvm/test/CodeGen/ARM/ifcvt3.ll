; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm-eabi -mcpu=cortex-a8 %s -o - | FileCheck %s
; RUN: llc -mtriple=arm-eabi -mattr=+v4t %s -o - | FileCheck %s -check-prefix CHECK-V4-CMP
; RUN: llc -mtriple=arm-eabi -mattr=+v4t %s -o - | FileCheck %s -check-prefix CHECK-V4-BX

define i32 @t1(i32 %a, i32 %b, i32 %c, i32 %d) {
; CHECK-LABEL: t1:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    cmp r2, #7
; CHECK-NEXT:    cmpne r2, #1
; CHECK-NEXT:    addne r0, r1, r0
; CHECK-NEXT:    addeq r0, r0, r1
; CHECK-NEXT:    addeq r0, r0, #1
; CHECK-NEXT:    bx lr
;
; CHECK-V4-CMP-LABEL: t1:
; CHECK-V4-CMP:       @ %bb.0:
; CHECK-V4-CMP-NEXT:    cmp r2, #7
; CHECK-V4-CMP-NEXT:    cmpne r2, #1
; CHECK-V4-CMP-NEXT:    addne r0, r1, r0
; CHECK-V4-CMP-NEXT:    addeq r0, r0, r1
; CHECK-V4-CMP-NEXT:    addeq r0, r0, #1
; CHECK-V4-CMP-NEXT:    bx lr
;
; CHECK-V4-BX-LABEL: t1:
; CHECK-V4-BX:       @ %bb.0:
; CHECK-V4-BX-NEXT:    cmp r2, #7
; CHECK-V4-BX-NEXT:    cmpne r2, #1
; CHECK-V4-BX-NEXT:    addne r0, r1, r0
; CHECK-V4-BX-NEXT:    addeq r0, r0, r1
; CHECK-V4-BX-NEXT:    addeq r0, r0, #1
; CHECK-V4-BX-NEXT:    bx lr
	switch i32 %c, label %cond_next [
		 i32 1, label %cond_true
		 i32 7, label %cond_true
	]

cond_true:
	%tmp12 = add i32 %a, 1
	%tmp1518 = add i32 %tmp12, %b
	ret i32 %tmp1518

cond_next:
	%tmp15 = add i32 %b, %a
	ret i32 %tmp15
}

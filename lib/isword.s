	.include "ctype.i"

	.globl isword

	.xref _ChrCla2

	.text

isword:
	tst.w	 d0
	bmi.b	 isword1
	and.w	 #0x00ff,d0
	lea.l	 _ChrCla2(pc),a0
	move.b	 (a0,d0.w),d0
	and.w	 #_ISword,d0
	rts
isword1:
	clr.w	 d0
	rts

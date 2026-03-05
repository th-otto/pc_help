	.include "ctype.i"

	.globl isspace

	.xref _ChrCla1

	.text

isspace:
	and.w	 #0x00ff,d0
	lea.l	 _ChrCla1(pc),a0
	move.b	 (a0,d0.w),d0
	and.w	 #_ISspace,d0
	rts

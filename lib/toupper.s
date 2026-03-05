	.globl toupper

	.xref _UpcTab

	.text

toupper:
	clr.w    d1
	move.b	 d0,d1
	lea.l	 _UpcTab(pc),a0
	move.b	 (a0,d1.w),d0
	rts

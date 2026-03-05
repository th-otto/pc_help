	.globl _fpuinit

	.xdef _fpumode
	.xdef _fpuctrl
	.xdef _fpuvect

	.text

__fpuinit:
	lea.l	 buserr(pc),a0
	moveq.l	 #8,d0
	movea.l	 d0,a1
	move.l	 (a1),d0
	move.l	 a0,(a1)
	clr.w	 _fpumode
	lea.l	 (a7),a0
	move.w	 #3,0xfffffa42.w
	move.w	 #0x8000,_fpumode
	move.w	 #-1,_fpuctrl
buserr:
	lea.l	 (a0),a7
	move.l	 d0,(a1)
	rts

_fpuinit:
	move.l	 a2,-(a7)
	pea.l	 __fpuinit(pc)
	move.w	 #38,-(a7)
	trap 	 #14
	addq.w	 #6,a7
	movea.l	 (a7)+,a2
	rts

	.data

_fpuvect:
	.dc.l	0
	.dc.l	0
	.dc.l	0
	.dc.l	0
	.dc.l	0

_fpumode:		.dc.w	0
_fpuctrl:		.dc.w	0

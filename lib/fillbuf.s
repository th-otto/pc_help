	.include "stdio.i"
	
/* int _FillBuf(FILE *stream); */
	
	.globl _FillBuf

	.xref read

	.text
	
_FillBuf:
	movem.l    d3-d4/a3-a4,-(a7)
	movea.l    a0,a3
	movea.l    FILE_BufStart(a3),a4
_FillBuf1:
	movea.l    a4,a0
	move.w     FILE_Handle(a3),d0
	move.l     FILE_BufEnd(a3),d1
	sub.l      a4,d1
	bsr.w      read
	tst.l      d0
	bmi.s      _FillBuf10
	beq.s      _FillBuf9
	btst       #_FIOBIN,FILE_Flags(a3)
	bne.s      _FillBuf7
	movea.l    a4,a0
	move.l     d0,d1
	subq.l     #1,d1
	moveq.l    #13,d2
_FillBuf2:
	cmp.b      (a0)+,d2
	beq.s      _FillBuf3
	subq.l     #1,d1
	bpl.s      _FillBuf2
	bra.s      _FillBuf6
_FillBuf3:
	movea.l    a0,a1
_FillBuf4:
	subq.w     #1,a1
	subq.l     #1,d0
	subq.l     #1,d1
	bmi.s      _FillBuf6
_FillBuf5:
	move.b     (a0)+,d3
	move.b     d3,(a1)+
	cmp.b      d2,d3
	beq.s      _FillBuf4
	subq.l     #1,d1
	bpl.s      _FillBuf5
_FillBuf6:
	tst.l      d0
	beq.s      _FillBuf1
_FillBuf7:
	move.l     a4,FILE_BufPtr(a3)
	move.l     d0,d1
	adda.l     d1,a4
	move.l     a4,FILE_BufLvl(a3)
	clr.l      d0
_FillBuf8:
	movem.l    (a7)+,d3-d4/a3-a4
	rts
_FillBuf9:
	bset       #_FIOEOF,FILE_Flags(a3)
	moveq.l    #1,d0
	bra.s      _FillBuf8
_FillBuf10:
	moveq.l    #-1,d0
	bra.s      _FillBuf8

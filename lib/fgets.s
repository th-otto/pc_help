	.include "stdio.i"
	.include "errno.i"
		
	.globl fgets

	.xref errno
	.xref _FillBuf
	.xref _FlshBuf

	.text

fgets:
	movem.l    a2-a4,-(a7)
	movea.l    a0,a2
	movea.l    a1,a3
	btst       #_FIOREAD,FILE_Flags(a3)
	beq.s      fgets8
	move.w     d0,d1
	beq        fgets10
	btst       #_FIOUNBUF,FILE_Flags(a3)
	beq.s      fgets1
	lea.l      FILE_ChrBuf(a3),a1
	move.l     a1,FILE_BufStart(a3)
	move.l     a1,FILE_BufPtr(a3)
	move.l     a1,FILE_BufLvl(a3)
	addq.l     #1,a1
	move.l     a1,FILE_BufEnd(a3)
fgets1:
	subq.w     #2,d1
	bcs.s      fgets4
fgets2:
	movea.l    FILE_BufPtr(a3),a1
	movea.l    FILE_BufLvl(a3),a4
	moveq.l    #10,d2
fgets3:
	cmpa.l     a4,a1
	bcc.s      fgets4
	move.b     (a1)+,d0
	move.b     d0,(a0)+
	cmp.b      d2,d0
	dbeq       d1,fgets3
	bra.s      fgets6
fgets4:
	btst       #_FIODIRTY,FILE_Flags(a3)
	beq.s      fgets5
	movem.l    d1/a0-a1,-(a7)
	movea.l    a3,a0
	bsr.w      _FlshBuf
	movem.l    (a7)+,d1/a0-a1
	tst.w      d0
	bne.s      fgets9
fgets5:
	movem.l    d1/a0-a1,-(a7)
	movea.l    a3,a0
	bsr.w      _FillBuf
	movem.l    (a7)+,d1/a0-a1
	tst.w      d0
	beq.s      fgets2
	bmi.s      fgets9
	cmpa.l     a0,a2
	beq.s      fgets10
fgets6:
	move.l     a1,FILE_BufPtr(a3)
	clr.b      (a0)+
	movea.l    a2,a0
fgets7:
	movem.l    (a7)+,a2-a4
	rts
fgets8:
	move.w     #EACCES,errno
fgets9:
	bset       #_FIOERR,FILE_Flags(a3)
fgets10:
	suba.l     a0,a0
	bra.s      fgets7

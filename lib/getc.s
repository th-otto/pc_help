	.include "errno.i"
	.include "stdio.i"

	.globl getc
	.globl fgetc

	.xref _FlshBuf
	.xref _FillBuf
	.xref errno

	.text

getc:
fgetc:
	movea.l    FILE_BufPtr(a0),a1
	cmpa.l     FILE_BufLvl(a0),a1
	bcc.s      fgetc2
fgetc1:
	clr.w      d0
	move.b     (a1)+,d0
	move.l     a1,FILE_BufPtr(a0)
	rts
fgetc2:
	move.b     FILE_Flags(a0),d0
	btst       #_FIOREAD,d0
	beq.s      fgetc4
	btst       #_FIODIRTY,d0
	beq.s      fgetc3
	btst       #_FIOWRITE,d0
	beq.s      fgetc4
	move.l     a0,-(a7)
	bsr.w      _FlshBuf
	movea.l    (a7)+,a0
	tst.w      d0
	bne.s      fgetc5
fgetc3:
	move.l     a0,-(a7)
	bsr.w      _FillBuf
	movea.l    (a7)+,a0
	tst.w      d0
	bmi.s      fgetc5
	bne.s      fgetc6
	movea.l    FILE_BufPtr(a0),a1
	bra.s      fgetc1
fgetc4:
	move.w     #EACCES,errno
fgetc5:
	bset       #_FIOERR,FILE_Flags(a0)
fgetc6:
	moveq.l    #-1,d0
	rts

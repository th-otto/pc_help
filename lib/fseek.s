	.include "stdio.i"
	.include "errno.i"

	.globl fseek

	.xref _FlshBuf
	.xref lseek
	.xref errno

	.text

fseek:
	movem.l    d3-d4/a3,-(a7)
	movea.l    a0,a3
	move.l     d0,d3
	move.w     d1,d4
	cmp.w      #1,d4
	bne.s      fseek2
	add.l      FILE_BufPtr(a3),d3
	cmp.l      FILE_BufLvl(a3),d3
	bhi.s      fseek1
	cmp.l      FILE_BufStart(a3),d3
	bcs.s      fseek1
	move.l     d3,FILE_BufPtr(a3)
	bra.s      fseek4
fseek1:
	sub.l      FILE_BufLvl(a3),d3
fseek2:
	btst       #_FIODIRTY,FILE_Flags(a3)
	beq.s      fseek3
	btst       #_FIOWRITE,FILE_Flags(a3)
	beq.s      fseek6
	movea.l    a3,a0
	bsr.w      _FlshBuf
	tst.w      d0
	bne.s      fseek8
fseek3:
	move.l     d3,d1
	move.w     d4,d2
	move.w     FILE_Handle(a3),d0
	bsr.w      lseek
	tst.l      d0
	bmi.s      fseek8
	movea.l    FILE_BufStart(a3),a0
	move.l     a0,FILE_BufPtr(a3)
	move.l     a0,FILE_BufLvl(a3)
fseek4:
	bclr       #_FIOEOF,FILE_Flags(a3)
	moveq.l    #0,d0
fseek5:
	movem.l    (a7)+,d3-d4/a3
	rts
fseek6:
	move.w     #EACCES,errno
	bra.s      fseek8
fseek7:
	move.w     #EINVAL,errno
fseek8:
	bset       #_FIOERR,FILE_Flags(a3)
	moveq.l    #1,d0
	bra.s      fseek5

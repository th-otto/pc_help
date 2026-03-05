	.include "stdio.i"
	.include "errno.i"

/* size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream); */

	.globl fread

	.xref _FlshBuf
	.xref _FillBuf
	.xref errno
	
	.text

fread:
	movem.l    d3-d4/a2-a4/a6,-(a7)
	movea.l    a0,a2
	movea.l    a1,a3
	movea.l    FILE_BufPtr(a3),a4
	moveq.l    #0,d4
	move.l     d0,d3
	beq.s      fread6
	tst.l      d1
	beq.s      fread6
	btst       #_FIOREAD,FILE_Flags(a3)
	beq.s      fread8
	movea.l    FILE_BufLvl(a3),a6
fread1:
	move.l     d3,d2
fread2:
	cmpa.l     a6,a4
	bcc.s      fread4
fread3:
	move.b     (a4)+,(a2)+
	subq.l     #1,d2
	bne.s      fread2
	addq.l     #1,d4
	cmp.l      d1,d4
	bcs.s      fread1
	bra.s      fread6
fread4:
	btst       #_FIODIRTY,FILE_Flags(a3)
	beq.s      fread5
	move.l     d1,-(a7)
	move.l     d2,-(a7)
	movea.l    a3,a0
	bsr.w      _FlshBuf
	move.l     (a7)+,d2
	move.l     (a7)+,d1
	tst.w      d0
	bne.s      fread9
fread5:
	move.l     d1,-(a7)
	move.l     d2,-(a7)
	movea.l    a3,a0
	bsr.w      _FillBuf
	move.l     (a7)+,d2
	move.l     (a7)+,d1
	tst.w      d0
	bmi.s      fread9
	bne.s      fread6
	movea.l    FILE_BufPtr(a3),a4
	movea.l    FILE_BufLvl(a3),a6
	bra.s      fread3
fread6:
	move.l     a4,FILE_BufPtr(a3)
	move.l     d4,d0
fread7:
	movem.l    (a7)+,d3-d4/a2-a4/a6
	rts
fread8:
	move.w     #EACCES,errno
fread9:
	bset       #_FIOERR,FILE_Flags(a3)
	moveq.l    #-1,d0
	bra.s      fread7

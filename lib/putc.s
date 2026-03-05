	.include "stdio.i"
	.include "errno.i"

/* int putc(int c, FILE *stream); */
	
	.globl putc
	.globl fputc

	.xref errno
	.xref _FlshBuf

	.text

putc:
fputc:
	btst       #_FIOWRITE,FILE_Flags(a0)
	beq.s      putc2
	btst       #_FIOUNBUF,FILE_Flags(a0)
	bne.s      putc4
	movea.l    FILE_BufPtr(a0),a1
	move.b     d0,(a1)+
	move.l     a1,FILE_BufPtr(a0)
	and.w      #0xFF,d0
	cmpa.l     FILE_BufEnd(a0),a1
	bcc.s      putc1
	bset       #_FIODIRTY,FILE_Flags(a0)
	rts
putc1:
	move.w     d0,-(a7)
	move.l     a0,-(a7)
	bsr.w      _FlshBuf
	movea.l    (a7)+,a0
	move.w     (a7)+,d1
	tst.w      d0
	bne.s      putc3
	move.w     d1,d0
	rts
putc2:
	move.w     #EACCES,errno
putc3:
	bset       #_FIOERR,FILE_Flags(a0)
	moveq.l    #-1,d0
	rts
putc4:
	lea.l      FILE_ChrBuf(a0),a1
	move.b     d0,(a1)
	move.l     a1,FILE_BufStart(a0)
	move.l     a1,FILE_BufLvl(a0)
	addq.l     #1,a1
	move.l     a1,FILE_BufEnd(a0)
	move.l     a1,FILE_BufPtr(a0)
	bra.s      putc1

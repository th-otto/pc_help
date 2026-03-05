	.include "errno.i"

/* size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream); */

	.globl fwrite
	
	.xref _FlshBuf
	.xref errno

	.text

fwrite:
	movem.l    d3-d4/a2-a4/a6,-(a7)
	movea.l    a0,a2
	movea.l    a1,a3
	movea.l    (a3),a4
	move.l     d0,d3
	beq.s      fwrite5
	tst.l      d1
	beq.s      fwrite4
	btst       #1,18(a3)
	beq.s      fwrite6
	btst       #2,18(a1)
	bne.s      fwrite9
	bset       #6,18(a3)
	movea.l    12(a3),a6
	moveq.l    #0,d4
fwrite1:
	move.l     d3,d2
fwrite2:
	move.b     (a2)+,(a4)+
	cmpa.l     a6,a4
	bcc.s      fwrite3
	subq.l     #1,d2
	bne.s      fwrite2
	addq.l     #1,d4
	cmp.l      d1,d4
	bcs.s      fwrite1
	bra.s      fwrite4
fwrite3:
	move.l     a4,(a3)
	move.l     d1,-(a7)
	move.l     d2,-(a7)
	movea.l    a3,a0
	bsr.w      _FlshBuf
	move.l     (a7)+,d2
	move.l     (a7)+,d1
	tst.w      d0
	bmi.s      fwrite7
	bne.s      fwrite8
	movea.l    (a3),a4
	bset       #6,18(a3)
	subq.l     #1,d2
	bne.s      fwrite2
	addq.l     #1,d4
	cmp.l      d1,d4
	bne.s      fwrite1
	bclr       #6,18(a3)
fwrite4:
	move.l     a4,(a3)
	move.l     d1,d0
fwrite5:
	movem.l    (a7)+,d3-d4/a2-a4/a6
	rts
fwrite6:
	move.w     #EACCES,errno
fwrite7:
	bset       #5,18(a3)
	moveq.l    #-1,d0
	bra.s      fwrite5
fwrite8:
	bset       #5,18(a3)
	move.l     d4,d1
	bra.s      fwrite4
fwrite9:
	move.l     d0,d3
	moveq.l    #0,d4
	movea.l    d1,a6
fwrite10:
	move.l     a2,8(a3)
	move.l     a2,4(a3)
	lea.l      0(a2,d3.l),a2
	move.l     a2,12(a3)
	move.l     a2,(a3)
	bset       #6,18(a3)
	movea.l    a3,a0
	bsr.w      _FlshBuf
	tst.w      d0
	bmi.s      fwrite7
	bne.s      fwrite8
	addq.l     #1,d4
	cmp.l      a6,d4
	bne.s      fwrite10
	move.l     a6,d1
	bra.s      fwrite4

	.include "errno.i"

/* char *ultoa(unsigned long value, char *string, int radix); */

	.globl ultoa

	.xref errno
	
	.text

ultoa:
	move.l     d3,-(a7)
	move.l     a0,-(a7)
	suba.w     #34,a7
	move.w     d1,d2
	subq.w     #2,d2
	cmp.w      #34,d2
	bhi.s      ultoa6
	lea.l      34(a7),a1
	moveq.l    #-1,d2
	move.l     d0,d3
	swap       d3
	tst.w      d3
	bne.s      ultoa2
ultoa1:
	divu.w     d1,d0
	move.l     d0,d3
	swap       d3
	move.b     digits(pc,d3.w),-(a1)
	addq.w     #1,d2
	swap       d0
	clr.w      d0
	swap       d0
	bne.s      ultoa1
	bra.s      ultoa4
ultoa2:
	move.w     d4,-(a7)
ultoa3:
	move.l     d0,d3
	move.w     d0,d4
	clr.w      d3
	swap       d3
	divu.w     d1,d3
	move.w     d3,d0
	move.w     d4,d3
	divu.w     d1,d3
	swap       d0
	move.w     d3,d0
	swap       d3
	move.b     digits(pc,d3.w),-(a1)
	addq.w     #1,d2
	tst.l      d0
	bne.s      ultoa3
	move.w     (a7)+,d4
ultoa4:
	move.b     (a1)+,(a0)+
	dbf        d2,ultoa4
ultoa5:
	clr.b      (a0)+
	adda.w     #34,a7
	movea.l    (a7)+,a0
	move.l     (a7)+,d3
	rts
ultoa6:
	move.w     #EDOM,errno
	bra.s      ultoa5

digits: .ascii "0123456789abcdefghijklmnopqrstuvwxyz"

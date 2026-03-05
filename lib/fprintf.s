	.globl fprintf

/* int fprintf(FILE *stream, const char *format, ...); */

	.xref _PrintF
	.xref fwrite

	.text

fprintf:
	move.l     a6,-(a7)
	subq.w     #8,a7
	lea.l      (a7),a6
	move.l     a7,4(a6)
	move.l     a0,(a6)
	movea.l    a1,a0
	lea.l      16(a7),a1
	pea.l      fprintfw(pc)
	bsr.w      _PrintF
	addq.w     #4,a7
fprintf1:
	addq.w     #8,a7
	movea.l    (a7)+,a6
	rts

fprintfw:
	swap       d0
	clr.w      d0
	swap       d0
	movea.l    (a6),a1
	moveq.l    #1,d1
	bsr.w      fwrite
	tst.w      d0
	bmi.s      fprintfw1
	rts
fprintfw1:
	movea.l    4(a6),a7
	moveq.l    #-1,d0
	bra.s      fprintf1

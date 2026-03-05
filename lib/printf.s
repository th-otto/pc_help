	.globl printf

/* int printf(const char *format, ...); */

	.xref _PrintF
	.xref _StdOutF
	.xref fwrite

	.text

printf:
	move.l     a6,-(a7)
	subq.w     #4,a7
	lea.l      (a7),a6
	move.l     a7,(a6)
	lea.l      12(a7),a1
	pea.l      printfw(pc)
	bsr.w      _PrintF
	addq.w     #4,a7
printf1:
	addq.w     #4,a7
	movea.l    (a7)+,a6
	rts

printfw:
	swap       d0
	clr.w      d0
	swap       d0
	lea.l      _StdOutF,a1
	moveq.l    #1,d1
	bsr.w      fwrite
	tst.w      d0
	bmi.s      printfw1
	rts
printfw1:
	movea.l    (a6),a7
	moveq.l    #-1,d0
	bra.s      printf1

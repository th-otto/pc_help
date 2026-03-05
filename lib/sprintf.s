	.globl sprintf

/* int sprintf(char *str, const char *format, ...); */

	.xref _PrintF

	.text

sprintf:
	move.l     a6,-(a7)
	subq.w     #4,a7
	lea.l      (a7),a6
	move.l     a0,(a6)
	movea.l    a1,a0
	lea.l      12(a7),a1
	pea.l      sprintfw(pc)
	bsr.w      _PrintF
	addq.w     #4,a7
	movea.l    (a6),a0
	clr.b      (a0)
	addq.w     #4,a7
	movea.l    (a7)+,a6
	rts

sprintfw:
	movea.l    (a6),a1
	subq.w     #1,d0
	bcs.s      sprintfw2
sprintfw1:
	move.b     (a0)+,(a1)+
	dbf        d0,sprintfw1
	move.l     a1,(a6)
sprintfw2:
	rts

	.globl vsprintf

/* int vsprintf(char *str, const char *format, va_list ap); */

	.xref _PrintF

	.text

vsprintf:
	move.l     a6,-(a7)
	subq.w     #4,a7
	lea.l      (a7),a6
	move.l     a0,(a6)
	movea.l    a1,a0
	movea.l    12(a7),a1
	pea.l      vsprintfw(pc)
	bsr.w      _PrintF
	addq.w     #4,a7
	movea.l    (a6),a0
	clr.b      (a0)
	addq.w     #4,a7
	movea.l    (a7)+,a6
	rts

vsprintfw:
	movea.l    (a6),a1
	subq.w     #1,d0
	bcs.s      vsprintfw2
vsprintfw1:
	move.b     (a0)+,(a1)+
	dbf        d0,vsprintfw1
	move.l     a1,(a6)
vsprintfw2:
	rts

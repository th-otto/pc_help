	.globl strncpy

/* char *strncpy(char *dest, const char *src, size_t n); */

	.text

strncpy:
	move.l     a0,d1
strncpy1:
	subq.l     #1,d0
	bcs.s      strncpy3
	move.b     (a1)+,(a0)+
	bne.s      strncpy1
	clr.b      d2
	tst.l      d0
	beq.s      strncpy3
strncpy2:
	move.b     d2,(a0)+
	subq.l     #1,d0
	bne.s      strncpy2
strncpy3:
	movea.l    d1,a0
	rts

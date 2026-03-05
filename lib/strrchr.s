	.globl strrchr
	
/* char *strrchr(const char *s, int c); */

	.text

strrchr:
	suba.l     a1,a1
strrchr1:
	move.b     (a0)+,d1
	beq.s      strrchr2
	cmp.b      d0,d1
	bne.s      strrchr1
	lea.l      -1(a0),a1
	bra.s      strrchr1
strrchr2:
	tst.b      d0
	beq.s      strrchr3
	movea.l    a1,a0
	rts
strrchr3:
	subq.w     #1,a0
	rts

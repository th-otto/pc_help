	.globl strcpy

/* char *strcpy(char *dest, const char *src); */

	.text

strcpy:
	move.l     a0,d0
strcpy1:
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	beq.s      strcpy2
	move.b     (a1)+,(a0)+
	bne.s      strcpy1
strcpy2:
	movea.l    d0,a0
	rts

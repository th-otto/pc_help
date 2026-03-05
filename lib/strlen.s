	.globl strlen

/* size_t strlen(const char *s); */

	.text

strlen:
	movea.l	 a0,a1
strlen1:
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	beq.s	 strlen2
	tst.b	 (a0)+
	bne.b	 strlen1
strlen2:
	move.l	 a0,d0
	sub.l	 a1,d0
	subq.l	 #1,d0
	rts

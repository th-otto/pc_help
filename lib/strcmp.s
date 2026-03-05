	.globl strcmp

/* int strcmp(const char *s1, const char *s2); */

	.text

strcmp:
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	bne.s      strcmp1
	move.b     (a0)+,d0
	beq.s      strcmp3
	cmp.b      (a1)+,d0
	beq.s      strcmp
strcmp1:
	cmp.b      -(a1),d0
	bcs.s      strcmp2
	moveq.l    #1,d0
	rts
strcmp2:
	moveq.l    #-1,d0
	rts
strcmp3:
	tst.b      (a1)
	bne.s      strcmp2
	moveq.l    #0,d0
	rts

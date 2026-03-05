	.globl setjmp
	.globl longjmp

/* int setjmp(jmp_buf env); */
/* void longjmp(jmp_buf env, int val); */

	.text

	MODULE setjmp
	movea.l	 (a7)+,a1
	movem.l	 d3-d7/a1-a7,(a0)
	moveq.l	 #0,d0
	jmp		 (a1)
	ENDMOD

	MODULE longjmp
	movem.l	 (a0),d3-d7/a1-a7
	tst.w	 d0
	bne.s	 longjmp1
	moveq.l	 #1,d0
longjmp1:
	jmp		 (a1)
	ENDMOD

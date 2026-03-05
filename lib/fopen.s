	.globl fopen

	.xref freopen

	.text

	MODULE fopen

	moveq.l	 #0,d0
	move.l	 d0,-(a7)
	bsr		 freopen
	addq.w	 #4,a7
	rts

	ENDMOD

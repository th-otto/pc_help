	.globl isdigit

	.text

isdigit:
	sub.b	 #'0',d0
	cmp.b	 #9,d0
	sls.b	 d0
	ext.w	 d0
	rts

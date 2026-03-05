	.include "stdio.i"

	.globl feof

	.text

feof:
	btst.b	 #_FIOEOF,FILE_Flags(a0)
	sne.b	 d0
	ext.w	 d0
	rts

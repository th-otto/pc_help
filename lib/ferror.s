	.include "stdio.i"

	.globl ferror
	
	.text

ferror:
	btst.b	 #_FIOERR,FILE_Flags(a0)
	sne.b	 d0
	ext.w	 d0
	rts

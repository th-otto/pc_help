	.include "stdio.i"

/* void rewind(FILE *stream); */

	.globl rewind

	.xref fseek

	.text

rewind:
	bclr.b	 #_FIOERR,FILE_Flags(a0)
	moveq.l	 #0,d0
	moveq.l	 #0,d1
	bra		 fseek

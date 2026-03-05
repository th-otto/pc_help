	include "stdio.i"
	
	.globl _StdInF
	.globl _StdOutF
	.globl _StdErrF
	.globl _StdAuxF
	.globl _StdPrnF

stdinbufsize equ 80

	.data
	.even

_StdInF:
	dc.l stdinbuf
	dc.l stdinbuf
	dc.l stdinbuf
	dc.l stdinbuf+stdinbufsize
	dc.w 0
	dc.b 1<<_FIOREAD
	dc.b 0
	dc.b 0
	dc.b 0
	
stdinbuf: ds.b stdinbufsize

_StdOutF:
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.w 1
	dc.b (1<<_FIOWRITE)|(1<<_FIOUNBUF)
	dc.b 0
	dc.b 0
	dc.b 0

_StdErrF:
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.w 2
	dc.b (1<<_FIOWRITE)|(1<<_FIOUNBUF)
	dc.b 0
	dc.b 0
	dc.b 0

_StdAuxF:
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.w 2
	dc.b (1<<_FIOREAD)|(1<<_FIOWRITE)|(1<<_FIOUNBUF)
	dc.b 0
	dc.b 0
	dc.b 0

_StdPrnF:
	dc.l 0
	dc.l 0
	dc.l 0
	dc.l 0
	dc.w 3
	dc.b (1<<_FIOWRITE)|(1<<_FIOUNBUF)
	dc.b 0
	dc.b 0
	dc.b 0

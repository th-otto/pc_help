	.globl isatty

	.text

isatty:
	move.l     d3,-(a7)
	move.l     d4,-(a7)
	move.l     d5,-(a7)
	move.w     d0,d3
	move.w     #1,-(a7)
	move.w     d0,-(a7)
	clr.l      -(a7)
	move.w     #66,-(a7)
	trap       #1
	lea.l      10(a7),a7
	move.l     d0,d4
	clr.w      -(a7)
	move.w     d3,-(a7)
	move.l     #1,-(a7)
	move.w     #66,-(a7)
	trap       #1
	lea.l      10(a7),a7
	move.l     d0,d5
	clr.w      -(a7)
	move.w     d3,-(a7)
	move.l     d4,-(a7)
	move.w     #66,-(a7)
	trap       #1
	lea.l      10(a7),a7
	tst.l      d5
	seq        d0
	ext.w      d0
	move.l     (a7)+,d5
	move.l     (a7)+,d4
	move.l     (a7)+,d3
	rts

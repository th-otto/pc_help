	.globl remove
	.globl unlink

/* int unlink(const char *path); */
/* int remnove(const char *path); */

	.xref errno
	.xref _XltErr

	.text

remove:
unlink:
	move.l     a0,-(a7)
	move.w     #65,-(a7) /* Fdelete */
	trap       #1
	addq.w     #6,a7
	tst.l      d0
	bmi.s      remove1
	moveq.l    #0,d0
	rts
remove1:
	bsr.w      _XltErr
	move.w     d0,errno
	moveq.l    #-1,d0
	rts

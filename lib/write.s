	.include "errno.i"

/* ssize_t write(int fd, const void *buf, size_t count); */

	.globl write
	
	.xref _XltErr
	.xref errno

	.text

write:
	move.l     a0,-(a7)
	move.l     d1,-(a7)
	move.w     d0,-(a7)
	move.w     #64,-(a7)
	trap       #1
	lea.l      12(a7),a7
	tst.l      d0
	bmi.s      write1
	cmp.l      d1,d0
	bne.s      write2
	rts
write1:
	bsr.w      _XltErr
	move.w     d0,errno
	moveq.l    #-1,d0
	rts
write2:
	move.w     #ENOSPC,errno
	rts

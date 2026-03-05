	.include "stdio.i"
	.include "errno.i"

/* off_t lseek(int fd, off_t offset, int whence); */

	.globl lseek
	
	.xref errno
	.xref _XltErr

	.text

lseek:
	cmp.w      #2,d2
	bhi        lseek9
lseek1:
	movea.w    d0,a1
	move.w     d2,-(a7)
	move.w     a1,-(a7)
	move.l     d1,-(a7)
	move.w     #66,-(a7)
	trap       #1
	lea.l      10(a7),a7
	tst.l      d0
	bpl.w      lseek10
lseek2:
	cmp.l     #-64,d0
	bne.w      lseek7
	subq.w    #1,d2
	beq.s      lseek5
	bpl.s      lseek6
	move.w     #2,-(a7)
	move.w     a1,-(a7)
	moveq.l    #0,d0
	move.l     d0,-(a7)
	move.w     #66,-(a7)
	trap       #1
	lea.l      10(a7),a7
	tst.l      d0
	bmi.w      lseek7
lseek4:
	move.l    d0,d2
	bra.b     t0000a8
lseek5:
	move.w    #1,-(a7)
	move.w    a1,-(a7)
	moveq.l   #0,d0
	move.l    d0,-(a7)
	move.w    #66,-(a7)
	trap      #1
	lea.l     10(a7),a7
	tst.l     d0
	bmi.s     lseek7
	add.l     d1,d0
	move.l    d0,d1
	bmi.b     lseek7
	move.w    #2,-(a7)
	move.w    a1,-(a7)
	moveq.l   #0,d0
	move.l    d0,-(a7)
	move.w    #66,-(a7)
	trap      #1
	lea.l     10(a7),a7
	tst.l     d0
	bmi.s     lseek7
	move.l    d0,d2
	bra.s     t0000a8
lseek6:
	move.w    #2,-(a7)
	move.w    a1,-(a7)
	moveq.l   #0,d0
	move.l    d0,-(a7)
	move.w    #66,-(a7)
	trap      #1
	lea.l     10(a7),a7
	tst.l     d0
	bmi.s     lseek7
	move.l    d0,d2
	add.l     d0,d1
	bmi.b     lseek7
t0000a8:
	move.l    d1,d0
	sub.l     d2,d0
	move.l    d0,d2
	bmi.b     lseek7
t0000b0:
	pea.l     lseek(pc)
	move.l    #BUFSIZ,d0
	cmp.l     d0,d2
	bcs.b     t0000c2
	move.l    d0,-(a7)
	bra.b     t0000c4
t0000c2:
	move.l    d2,-(a7)
t0000c4:
	move.w    a1,-(a7)
	move.w     #64,-(a7)
	trap       #1
	lea.l      12(a7),a7
	tst.l      d0
	bmi        lseek7
	sub.l     #BUFSIZ,d2
	bhi.b     t0000b0
	move.l    d1,d0
lseek10:
	rts
lseek7:
	bsr.w      _XltErr
lseek8:
	move.w     d0,errno
	moveq.l    #-1,d0
	RTS
lseek9:
	move.w     #EINVAL,d0
	bra.s      lseek8

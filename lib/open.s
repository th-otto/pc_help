	.include "stdio.i"

/* int open(const char *path, int oflag, ...); */

	.globl open

	.xref errno
	.xref _XltErr

	.text

open:
	bclr       #7,d0 /* clear O_EXCL */

	movem.l    d3-d4/a3,-(a7)
	move.w     d0,d3
	movea.l    a0,a3
	moveq.l    #O_CREAT,d0
	and.w      d3,d0
	beq.s      open1
	moveq.l    #O_TRUNC,d0
	and.w      d3,d0
	bne.s      open4
open1:
	moveq.l    #O_ACCMODE,d0
	and.w      d3,d0
	move.w     d0,-(a7)
	move.l     a3,-(a7)
	move.w     #61,-(a7) /* Fopen */
	trap       #1
	addq.w     #8,a7
	tst.l      d0
	bmi.s      open3
	move.w     d0,d4
	bpl.s      open2
	bsr.s      open7
open2:
	moveq.l    #O_APPEND,d0
	and.w      d3,d0
	beq.s      open5
	move.w     #2,-(a7)
	move.w     d4,-(a7)
	moveq.l    #0,d0
	move.l     d0,-(a7)
	move.w     #66,-(a7) /* Fseek */
	trap       #1
	lea.l      10(a7),a7
	tst.l      d0
	bpl.s      open5
	bra.s      open8
open3:
	moveq.l    #-33,d1
	cmp.l      d0,d1
	bne.s      open8
	moveq.l    #O_CREAT,d1
	and.w      d3,d1
	beq.s      open8
open4:
	moveq.l    #O_ACCMODE,d0
	and.w      d3,d0
	seq        d0
	and.w      #1,d0
	move.w     d0,-(a7)
	move.l     a3,-(a7)
	move.w     #60,-(a7) /* Fcreate */
	trap       #1
	addq.w     #8,a7
	tst.l      d0
	bmi.s      open8
	move.w     d0,d4
	bpl.s      open5
	bsr.s      open7
open5:
	move.w     d4,d0
open6:
	movem.l    (a7)+,d3-d4/a3
	rts
open7:
	neg.w      d4
	move.w     d0,-(a7)
	move.w     #62,-(a7) /* Fclose */
	trap       #1
	addq.w     #4,a7
	rts
open8:
	bsr.w      _XltErr
	move.w     d0,errno
	moveq.l    #-1,d0
	bra.s      open6

	.globl read

/* ssize_t read(int fildes, void *buf, size_t nbyte); */
	
	.xref isatty
	.xref errno
	.xref _XltErr

	.data

eolflag: .dc.b 0
	.even
	
	.text

read:
	tst.w     d0
	bne.s     read0
	move.l    a0,-(a7)
	move.l    d1,-(a7)
	bsr       isatty
	tst.w     d0
	bne.s     read1_1
	clr.w     -(a7)
	bra.s     read1
read0:
	move.l    a0,-(a7)
	move.l    d1,-(a7)
	move.w    d0,-(a7)
read1:
	move.w     #63,-(a7)
	trap       #1
	lea.l      12(a7),a7
	tst.l      d0
	bmi.s      read2
	rts
read1_1:
	move.l    (A7)+,D0
	move.l    (A7)+,A0
	bra.s     read3
read2:
	bsr.w      _XltErr
	move.w     d0,errno
	moveq.l    #-1,d0
	rts
read3:
	movem.l    d3-d4/a3,-(a7)
	movea.l    a0,a3
	moveq.l    #0,d4
	move.l     d0,d3
	subq.l     #1,d3
	beq        read11
	bmi        read15
	tst.b      eolflag
	bmi.s      read9
	bne.s      read10
read4:
	bsr        readchar
	cmp.b      #8,d0
	beq.s      read6
	cmp.b      #13,d0
	beq.s      read7
	cmp.b      #26,d0
	beq.s      read8
	cmp.b      #' ',d0
	bcs.s      read4
read5:
	cmp.l      d3,d4
	bcc.s      read4
	addq.l     #1,d4
	move.b     d0,(a3)+
	bsr        echochar
	bra.s      read4
read6:
	tst.l      d4
	beq.s      read4
	subq.l     #1,d4
	subq.w     #1,a3
	moveq.l    #8,d0
	bsr        echochar
	moveq.l    #' ',d0
	bsr        echochar
	moveq.l    #8,d0
	bsr        echochar
	bra.s      read4
read7:
	addq.l     #1,d4
	moveq.l    #13,d0
	move.b     d0,(a3)+
	bsr        echochar
	move.b     #1,eolflag
	moveq.l    #10,d0
	bsr        echochar
	bra.s      read15
read8:
	tst.l      d4
	beq.s      read15
	move.b     #-1,eolflag
	bra.s      read15
read9:
	moveq.l    #0,d4
	clr.b      eolflag
	bra.s      read15
read10:
	moveq.l    #1,d4
	move.b     #10,(a3)+
	clr.b      eolflag
	bra.s      read15
read11:
	tst.b      eolflag
	bmi.s      read17
	bne.s      read18
read12:
	bsr.s      readchar
	moveq.l    #1,d4
	move.b     d0,(a3)
	cmp.b      #13,d0
	beq.s      read14
	cmp.b      #26,d0
	beq.s      read16
	cmp.b      #' ',d0
	bcs.s      read12
read13:
	bsr.s      echochar
	bra.s      read15
read14:
	moveq.l    #13,d0
	bsr.s      echochar
	move.b     #1,eolflag
	moveq.l    #10,d0
	bsr.s      echochar
read15:
	move.l     d4,d0
	movem.l    (a7)+,d3-d4/a3
	rts
read16:
	clr.b      (a3)
	moveq.l    #0,d4
	bra.s      read15
read17:
	moveq.l    #0,d4
	clr.b      eolflag
	bra.s      read15
read18:
	moveq.l    #1,d4
	move.b     #10,(a3)
	clr.b      eolflag
	bra.s      read15

readchar:
	move.w     #7,-(a7)
	trap       #1
	addq.w     #2,a7
	rts

echochar:
	move.w     d0,-(a7)
	move.w     #2,-(a7)
	trap       #1
	addq.w     #4,a7
	rts

	.globl close

	.xref errno
	.xref _XltErr

	.text

close:
	cmp.w      #2,d0
	bls.s      close1
	move.w     d0,-(a7)
	move.w     #62,-(a7) /* Fclose */
	trap       #1
	addq.w     #4,a7
	tst.l      d0
	bmi.s      close2
close1:
	moveq.l    #0,d0
	rts
close2:
	bsr.w      _XltErr
	move.w     d0,errno
	moveq.l    #-1,d0
	rts

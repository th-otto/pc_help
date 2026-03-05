	.globl getenv
	.xref _BasPag

	.text

getenv:
	move.l     a2,-(a7)
	movea.l    _BasPag,a1
	move.l     44(a1),d0
	beq.s      getenv6
	movea.l    d0,a1
	move.b     (a0)+,d0
	beq.s      getenv6
getenv1:
	move.b     (a1)+,d1
	beq.s      getenv6
	cmp.b      d0,d1
	bne.s      getenv3
	movea.l    a0,a2
getenv2:
	move.b     (a2)+,d2
	beq.s      getenv4
	move.b     (a1)+,d1
	beq.s      getenv1
	cmp.b      d1,d2
	beq.s      getenv2
getenv3:
	tst.b      (a1)+
	bne.s      getenv3
	bra.s      getenv1
getenv4:
	move.b     (a1)+,d1
	beq.s      getenv1
	cmp.b      #'=',d1
	bne.s      getenv3
	tst.b      (a1) /* BUG: will skip empty values */
	bne.s      getenv7
	addq.w     #1,a1
getenv7:
	movea.l    a1,a0
getenv5:
	movea.l    (a7)+,a2
	rts
getenv6:
	suba.l     a0,a0
	bra.s      getenv5

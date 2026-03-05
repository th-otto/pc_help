	.include "errno.i"

/* unsigned long int strtoul(const char *nptr, char **endptr, int base); */
	
	.globl strtoul
	
	.xref errno
	.xref _ChrCla1
	.xref _DigCnvT

	.text


strtoul:
	movem.l    d3/a2-a3,-(a7)
	movea.l    a0,a2
	cmp.w      #1,d0
	beq        strtoul8
	cmp.w      #36,d0
	bhi        strtoul8
	lea.l      _ChrCla1(pc),a3
	moveq.l    #0,d1
	moveq.l    #0,d2
strtoul1:
	move.b     (a2)+,d1
	beq        strtoul5
	tst.b      0(a3,d1.w)
	bmi.s      strtoul1
	subq.w     #1,a2
	move.b     (a2)+,d1
	beq.s      strtoul5
	tst.w      d0
	bne.s      strtoul2
	moveq.l    #10,d0
	cmp.b      #'0',d1
	bne.s      strtoul3
	moveq.l    #8,d0
	move.b     (a2)+,d1
	beq.s      strtoul5
	move.b     d1,d3
	and.b      #0xDF,d3
	cmp.b      #'X',d3
	bne.s      strtoul3
	moveq.l    #16,d0
	move.b     (a2)+,d1
	bne.s      strtoul3
	bra.s      strtoul5
strtoul2:
	cmp.w      #16,d0
	bne.s      strtoul3
	cmp.b      #'0',d1
	bne.s      strtoul3
	move.b     (a2)+,d1
	beq.s      strtoul5
	move.b     d1,d3
	and.b      #0xDF,d3
	cmp.b      #'X',d3
	bne.s      strtoul3
	move.b     (a2)+,d1
	beq.s      strtoul5
strtoul3:
	lea.l      _DigCnvT(pc),a3
	move.b     0(a3,d1.w),d1
	cmp.b      d0,d1
	bcc.s      strtoul5
	move.b     d1,d2
strtoul4:
	move.b     (a2)+,d1
	move.b     0(a3,d1.w),d1
	cmp.b      d0,d1
	bcc.s      strtoul5
	move.l     d2,d3
	swap       d3
	mulu.w     d0,d3
	swap       d3
	tst.w      d3
	bne.s      strtoul7
	mulu.w     d0,d2
	add.l      d3,d2
	add.l      d1,d2
	bcc.s      strtoul4
	bra.s      strtoul7
strtoul5:
	move.l     d2,d0
	move.l     a1,d3
	beq.s      strtoul6
	subq.w     #1,a2
	move.l     a2,(a1)
strtoul6:
	movem.l    (a7)+,d3/a2-a3
	rts
strtoul7:
	move.w     #ERANGE,errno
	moveq.l    #-1,d0
	bra.s      strtoul9
strtoul8:
	move.w     #EDOM,errno
	moveq.l    #0,d0
strtoul9:
	move.l     a1,d3
	beq.s      strtoul6
	move.l     a0,(a1)
	bra.s      strtoul6

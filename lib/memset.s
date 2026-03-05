	.globl memset

/* void *memset(void *s, int c, size_t n); */

	.text

memset:
	move.l     a0,-(a7)
	adda.l     d1,a0
	move.l     a0,d2
	btst       #0,d2
	beq.s      memset1
	subq.l     #1,d1
	bcs        memset7
	move.b     d0,-(a0)
memset1:
	move.b     d0,-(a7)
	move.w     (a7)+,d2
	move.b     d0,d2
	move.w     d2,d0
	swap       d2
	move.w     d0,d2
	move.l     d1,d0
	lsr.l      #8,d0
	lsr.l      #2,d0
	beq.s      memset3
	movem.l    d1/d3-d7/a2-a6,-(a7)
	move.l     d2,d1
	move.l     d2,d3
	move.l     d2,d4
	move.l     d2,d5
	move.l     d2,d6
	move.l     d2,d7
	movea.l    d2,a1
	movea.l    d2,a2
	movea.l    d2,a3
	movea.l    d2,a4
	movea.l    d2,a5
	movea.l    d2,a6
memset2:
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a6,-(a0)
	movem.l    d1-d7/a1-a2,-(a0)
	subq.l     #1,d0
	bne.s      memset2
	movem.l    (a7)+,d1/d3-d7/a2-a6
	and.w      #0x03FF,d1
memset3:
	move.w     d1,d0
	lsr.w      #2,d0
	beq.s      memset5
	subq.w     #1,d0
memset4:
	move.l     d2,-(a0)
	dbf        d0,memset4
memset5:
	and.w      #3,d1
	beq.s      memset7
	subq.w     #1,d1
memset6:
	move.b     d2,-(a0)
	dbf        d1,memset6
memset7:
	movea.l    (a7)+,a0
	rts

	.globl memcpy
	.globl memmove

/* void *memcpy(void *dst, const void *src, size_t n); */

	.text

memcpy:
memmove:
	tst.l      d0
	beq        memcpy20
	move.l     a0,-(a7)
	cmpa.l     a0,a1
	bhi        memcpy9
	beq        memcpy19
	adda.l     d0,a1
	adda.l     d0,a0
	move.w     a1,d1
	move.w     a0,d2
	btst       #0,d1
	beq.s      memcpy2
	btst       #0,d2
	bne.s      memcpy3
memcpy1:
	move.b     -(a1),-(a0)
	subq.l     #1,d0
	bne.s      memcpy1
	bra        memcpy19
memcpy2:
	btst       #0,d2
	bne.s      memcpy1
	bra.s      memcpy31
memcpy3:
	move.b     -(a1),-(a0)
	subq.l     #1,d0
	beq        memcpy19
memcpy31:
	move.l     d0,d1
	lsr.l      #5,d1
	lsr.l      #4,d1
	beq        memcpy5
	movem.l    d2-d7/a3-a6,-(a7)
memcpy4:
	movem.l    -40(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -80(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -120(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -160(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -200(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -240(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -280(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -320(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -360(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -400(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -440(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -480(a1),d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,-(a0)
	movem.l    -512(a1),d2-d7/a3-a4
	movem.l    d2-d7/a3-a4,-(a0)
	suba.w     #512,a1
	subq.l     #1,d1
	bne        memcpy4
	movem.l    (a7)+,d2-d7/a3-a6
memcpy5:
	move.w     d0,d1
	and.w      #511,d0
	lsr.w      #2,d0
	beq.s      memcpy7
	subq.w     #1,d0
memcpy6:
	move.l     -(a1),-(a0)
	dbf        d0,memcpy6
memcpy7:
	and.w      #3,d1
	beq        memcpy19
	subq.w     #1,d1
memcpy8:
	move.b     -(a1),-(a0)
	dbf        d1,memcpy8
	bra        memcpy19
memcpy9:
	move.w     a1,d1
	move.w     a0,d2
	btst       #0,d1
	beq.s      memcpy11
	btst       #0,d2
	bne.s      memcpy12
memcpy10:
	move.b     (a1)+,(a0)+
	subq.l     #1,d0
	bne.s      memcpy10
	bra        memcpy19
memcpy11:
	btst       #0,d2
	bne.s      memcpy10
	bra.s      memcpy13
memcpy12:
	move.b     (a1)+,(a0)+
	subq.l     #1,d0
memcpy13:
	move.l     d0,d1
	lsr.l      #5,d1
	lsr.l      #4,d1
	beq        memcpy15
	movem.l    d2-d7/a3-a6,-(a7)
memcpy14:
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,40(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,80(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,120(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,160(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,200(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,240(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,280(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,320(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,360(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,400(a0)
	movem.l    (a1)+,d2-d7/a3-a6
	movem.l    d2-d7/a3-a6,440(a0)
	movem.l    (a1)+,d2-d7/a3-a4
	movem.l    d2-d7/a3-a4,480(a0)
	adda.w     #512,a0
	subq.l     #1,d1
	bne        memcpy14
	movem.l    (a7)+,d2-d7/a3-a6
memcpy15:
	move.w     d0,d1
	and.w      #511,d0
	lsr.w      #2,d0
	beq.s      memcpy17
	subq.w     #1,d0
memcpy16:
	move.l     (a1)+,(a0)+
	dbf        d0,memcpy16
memcpy17:
	and.w      #3,d1
	beq.s      memcpy19
	subq.w     #1,d1
memcpy18:
	move.b     (a1)+,(a0)+
	dbf        d1,memcpy18
memcpy19:
	movea.l    (a7)+,a0
memcpy20:
	rts

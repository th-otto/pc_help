		.globl fast_copy_grect
		
		.xref physbase

		.text

/*
 * void fast_copy_grect(GRECT *gr, _WORD h);
 * Only used for ST monochrome resolution
 */
fast_copy_grect:
		movem.l d3-d6,-(a7)
		moveq	#80,d1
		mulu.w	2(a0),d1
		move.w	(a0),d2
		asr.w	#3,d2
		movea.l physbase,a1
		adda.w	d2,a1
		adda.w	d1,a1
		mulu.w	#80,d0
		move.w	4(a0),d1
		asr.w	#3,d1
		move.w	6(a0),d2
		moveq	#1,d3
		move.w	a1,d4
		and.w	d4,d3
		moveq	#80,d6
		tst.w	d0
		ble.s	fastcopy1
		moveq	#80,d4
		mulu.w	d2,d4
		sub.w	#80,d4
		adda.w	d4,a1
		moveq	#-80,d6
fastcopy1:
		sub.w	d1,d6
		movea.l a1,a0
		adda.w	d0,a0
		move.w	d1,d4
		sub.w	d3,d4
		move.w	d4,d5
		asr.w	#2,d5
		add.w	d5,d5
		neg.w	d5
		and.w	#3,d4
		add.w	d4,d4
		neg.w	d4
		bra.s	fastcopy6

fastcopy2:
		tst.w	d3
		beq.s	fastcopy3
		move.b	(a1)+,(a0)+
fastcopy3:
		jmp 	fastcopy4(pc,d5.w)

		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
		move.l	(a1)+,(a0)+
fastcopy4:
		jmp 	fastcopy5(pc,d4.w)

		move.b	(a1)+,(a0)+
		move.b	(a1)+,(a0)+
		move.b	(a1)+,(a0)+
fastcopy5:
		adda.w	d6,a1
		adda.w	d6,a0
fastcopy6:
		dbf 	d2,fastcopy2
		movem.l (a7)+,d3-d6
		rts

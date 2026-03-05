		.xref cur_memfd
		.xref _UpcTab

	.OFFSET 0
membuf_buf:  .ds.l 1
membuf_size: .ds.l 1

	.OFFSET 0
memfd_buf:        .ds.l 1
memfd_last_used:  .ds.l 1
memfd_inserted:   .ds.l 1
memfd_first_used: .ds.l 1
memfd_marks:      .ds.l 8

		.text

	.globl find_str_forward
find_str_forward:
		movem.l d3-d5/a2-a6,-(a7)
		tst.b	(a0)
		beq 	find_str_forward_19
		movea.l cur_memfd,a1
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a3
		adda.l	d0,a3
		cmp.l	memfd_inserted(a1),d0
		bcc.s	find_str_forward_1
		move.l	memfd_inserted(a1),d2
		sub.l	d0,d2
		bra.s	find_str_forward_2
find_str_forward_1:
		move.l	memfd_first_used(a1),d2
		sub.l	memfd_inserted(a1),d2
		move.l	memfd_last_used(a1),d3
		sub.l	d2,d3
		cmp.l	d3,d0
		bcc 	find_str_forward_20
		adda.l	d2,a3
		move.l	d3,d2
		sub.l	d0,d2
find_str_forward_2:
		tst.b	d1
		beq.s	find_str_forward_10

find_str_forward_3:
		movea.l a0,a4
		move.b	(a4)+,d3
		bra.s	find_str_forward_5
find_str_forward_4:
		addq.l	#1,d0
		subq.l	#1,d2
		cmp.b	(a3)+,d3
		beq.s	find_str_forward_6
find_str_forward_5:
		tst.l	d2
		bne.s	find_str_forward_4
		move.l	membuf_buf(a2),d1
		add.l	memfd_inserted(a1),d1
		cmpa.l	d1,a3
		bne 	find_str_forward_20
		move.l	memfd_last_used(a1),d2
		sub.l	memfd_first_used(a1),d2
		beq 	find_str_forward_20
		movea.l membuf_buf(a2),a3
		adda.l	memfd_first_used(a1),a3
		bra.s	find_str_forward_4
find_str_forward_6:
		movea.l a3,a5
		move.l	d2,d4
		bra.s	find_str_forward_8
find_str_forward_7:
		cmpm.b	(a3)+,(a4)+
		bne.s	find_str_forward_9
		subq.l	#1,d2
find_str_forward_8:
		tst.b	(a4)
		beq 	find_str_forward_18
		tst.l	d2
		bne.s	find_str_forward_7
		move.l	membuf_buf(a2),d1
		add.l	memfd_inserted(a1),d1
		cmpa.l	d1,a3
		bne 	find_str_forward_20
		move.l	memfd_last_used(a1),d2
		sub.l	memfd_first_used(a1),d2
		beq 	find_str_forward_20
		movea.l membuf_buf(a2),a3
		adda.l	memfd_first_used(a1),a3
		bra.s	find_str_forward_7
find_str_forward_9:
		movea.l a5,a3
		move.l	d4,d2
		bra.s	find_str_forward_3

find_str_forward_10:
		clr.w	d3
		clr.w	d5
		lea 	_UpcTab(pc),a5
find_str_forward_11:
		movea.l a0,a4
		move.b	(a4)+,d3
		move.b	0(a5,d3.w),d3
		bra.s	find_str_forward_13
find_str_forward_12:
		addq.l	#1,d0
		subq.l	#1,d2
		move.b	(a3)+,d5
		cmp.b	0(a5,d5.w),d3
		beq.s	find_str_forward_14
find_str_forward_13:
		tst.l	d2
		bne.s	find_str_forward_12
		move.l	membuf_buf(a2),d1
		add.l	memfd_inserted(a1),d1
		cmpa.l	d1,a3
		bne.s	find_str_forward_20
		move.l	memfd_last_used(a1),d2
		sub.l	memfd_first_used(a1),d2
		beq.s	find_str_forward_20
		movea.l membuf_buf(a2),a3
		adda.l	memfd_first_used(a1),a3
		bra.s	find_str_forward_12
find_str_forward_14:
		movea.l a3,a6
		move.l	d2,d4
		bra.s	find_str_forward_16
find_str_forward_15:
		move.b	(a4)+,d3
		move.b	0(a5,d3.w),d3
		move.b	(a3)+,d5
		cmp.b	0(a5,d5.w),d3
		bne.s	find_str_forward_17
		subq.l	#1,d2
find_str_forward_16:
		tst.b	(a4)
		beq.s	find_str_forward_18
		tst.l	d2
		bne.s	find_str_forward_15
		move.l	membuf_buf(a2),d1
		add.l	memfd_inserted(a1),d1
		cmpa.l	d1,a3
		bne.s	find_str_forward_20
		move.l	memfd_last_used(a1),d2
		sub.l	memfd_first_used(a1),d2
		beq.s	find_str_forward_20
		movea.l membuf_buf(a2),a3
		adda.l	memfd_first_used(a1),a3
		bra.s	find_str_forward_15
find_str_forward_17:
		movea.l a6,a3
		move.l	d4,d2
		bra.s	find_str_forward_11
find_str_forward_18:
		subq.l	#1,d0
find_str_forward_19:
		movem.l (a7)+,d3-d5/a2-a6
		rts
find_str_forward_20:
		moveq	#-9,d0 /* AL_HELP_KEYWORD */
		bra.s	find_str_forward_19


	.globl find_str_backward
find_str_backward:
		movem.l d3-d7/a2-a6,-(a7)
		moveq	#-1,d2
find_str_backward_1:
		tst.b	(a0)+
		dbeq	d2,find_str_backward_1
		not.l	d2
		beq 	find_str_backward_21
		subq.w	#1,a0
		movea.l cur_memfd,a1
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a3
		add.l	d2,d0
		adda.l	d0,a3
		cmp.l	memfd_inserted(a1),d0
		bcc.s	find_str_backward_2
		move.l	d0,d3
		bra.s	find_str_backward_4
find_str_backward_2:
		move.l	memfd_first_used(a1),d5
		sub.l	memfd_inserted(a1),d5
		move.l	memfd_last_used(a1),d4
		sub.l	d5,d4
		cmp.l	d0,d4
		bcc.s	find_str_backward_3
		move.l	d4,d0
find_str_backward_3:
		adda.l	d5,a3
		move.l	d0,d3
		sub.l	memfd_inserted(a1),d3
find_str_backward_4:
		tst.b	d1
		beq.s	find_str_backward_12

find_str_backward_5:
		move.w	d2,d6
		movea.l a0,a4
		move.b	-(a4),d5
		subq.w	#1,d6
		bra.s	find_str_backward_7
find_str_backward_6:
		subq.l	#1,d0
		subq.l	#1,d3
		cmp.b	-(a3),d5
		beq.s	find_str_backward_8
find_str_backward_7:
		tst.l	d3
		bne.s	find_str_backward_6
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a2
		adda.l	memfd_first_used(a1),a2
		cmpa.l	a2,a3
		bne 	find_str_backward_22
		move.l	memfd_inserted(a1),d1
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a3
		adda.l	d1,a3
		move.l	d1,d3
		beq 	find_str_backward_22
		bra.s	find_str_backward_6
find_str_backward_8:
		movea.l a3,a6
		move.l	d3,d7
		tst.w	d6
		beq 	find_str_backward_20
		bra.s	find_str_backward_10
find_str_backward_9:
		move.b	-(a3),d4
		cmp.b	-(a4),d4
		bne.s	find_str_backward_11
		subq.l	#1,d3
		subq.w	#1,d6
		beq 	find_str_backward_20
find_str_backward_10:
		tst.l	d3
		bne.s	find_str_backward_9
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a2
		adda.l	memfd_first_used(a1),a2
		cmpa.l	a2,a3
		bne 	find_str_backward_22
		move.l	memfd_inserted(a1),d1
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a3
		adda.l	d1,a3
		move.l	d1,d3
		beq 	find_str_backward_22
		bra.s	find_str_backward_9
find_str_backward_11:
		movea.l a6,a3
		move.l	d7,d3
		bra.s	find_str_backward_5

find_str_backward_12:
		clr.w	d4
		clr.w	d5
		lea 	_UpcTab(pc),a5
find_str_backward_13:
		move.w	d2,d6
		movea.l a0,a4
		move.b	-(a4),d5
		move.b	0(a5,d5.w),d5
		subq.w	#1,d6
		bra.s	find_str_backward_15
find_str_backward_14:
		subq.l	#1,d0
		subq.l	#1,d3
		move.b	-(a3),d4
		cmp.b	0(a5,d4.w),d5
		beq.s	find_str_backward_16
find_str_backward_15:
		tst.l	d3
		bne.s	find_str_backward_14
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a2
		adda.l	memfd_first_used(a1),a2
		cmpa.l	a2,a3
		bne.s	find_str_backward_22
		move.l	memfd_inserted(a1),d1
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a3
		adda.l	d1,a3
		move.l	d1,d3
		beq.s	find_str_backward_22
		bra.s	find_str_backward_14
find_str_backward_16:
		movea.l a3,a6
		move.l	d3,d7
		tst.w	d6
		beq.s	find_str_backward_20
		bra.s	find_str_backward_18
find_str_backward_17:
		move.b	-(a3),d4
		move.b	0(a5,d4.w),d4
		move.b	-(a4),d5
		cmp.b	0(a5,d5.w),d4
		bne.s	find_str_backward_19
		subq.l	#1,d3
		subq.w	#1,d6
		beq.s	find_str_backward_20
find_str_backward_18:
		tst.l	d3
		bne.s	find_str_backward_17
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a2
		adda.l	memfd_first_used(a1),a2
		cmpa.l	a2,a3
		bne.s	find_str_backward_22
		move.l	memfd_inserted(a1),d1
		movea.l memfd_buf(a1),a2
		movea.l membuf_buf(a2),a3
		adda.l	d1,a3
		move.l	d1,d3
		beq.s	find_str_backward_22
		bra.s	find_str_backward_17

find_str_backward_19:
		movea.l a6,a3
		move.l	d7,d3
		bra.s	find_str_backward_13
find_str_backward_20:
		sub.l	d2,d0
		addq.l	#1,d0
find_str_backward_21:
		movem.l (a7)+,d3-d7/a2-a6
		rts

find_str_backward_22:
		moveq	#-9,d0 /* AL_HELP_KEYWORD */
		bra.s	find_str_backward_21


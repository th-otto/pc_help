	.xref Fclose

	.text

/* FIXME: unused */
/* x_free: */
	move.l     a2,-(a7)
	move.l     a0,-(a7)
	move.w     #73,-(a7) /* Mfree */
	trap       #1
	addq.l     #6,a7
	clr.l      d0
	movea.l    (a7)+,a2
	rts

	.globl xclose
xclose:
	and.w      #$00FF,d0
	bsr        Fclose
	clr.l      d0
	rts


/* void binsearch_init(const void *table, int (*func)(), size_t num_entries, size_t entry_size) */
	.globl binsearch_init
binsearch_init:
		move.l	d0,binsearch_num_entries
		move.l	d1,binsearch_entry_size
		move.l	a0,binsearch_table
		move.l	a1,binsearch_cmp_func
		rts

/* int binsearch(const char *entry) */
	.globl binsearch
binsearch:
		movem.l d3-d7/a3-a6,-(a7)
		moveq	#0,d3
		move.l	binsearch_num_entries,d4
		subq.l	#1,d4
		bcs.s	binsearch_4
		move.l	binsearch_entry_size,d5
		beq.s	binsearch_4
		movea.l a0,a3
		movea.l binsearch_table,a4
		movea.l binsearch_cmp_func,a5
binsearch_1:
		move.l	d3,d6
		add.l	d4,d6
		lsr.l	#1,d6
		move.l	d5,d0
		move.l	d6,d1
		bsr 	ulmul_overflow
		tst.b	d0
		bne.s	binsearch_4
		lea 	0(a4,d1.l),a6
		movea.l a3,a0
		movea.l a6,a1
		jsr 	(a5)
		tst.b	d0
		beq.s	binsearch_5
		bpl.s	binsearch_2
		move.l	d6,d4
		subq.l	#1,d4
		bcs.s	binsearch_4
		bra.s	binsearch_3
binsearch_2:
		move.l	d6,d3
		addq.l	#1,d3
binsearch_3:
		cmp.l	d4,d3
		bls.s	binsearch_1
binsearch_4:
		st		d0
		bra.s	binsearch_6
binsearch_5:
		sf		d0
		movea.l a6,a0
binsearch_6:
		movem.l (a7)+,d3-d7/a3-a6
		rts

ulmul_overflow:
		move.l	d0,d2
		swap	d2
		tst.w	d2
		bne.s	ulmul_overflow_2
		move.l	d1,d2
		swap	d2
		tst.w	d2
		bne.s	ulmul_overflow_1
		mulu.w	d0,d1
		sf		d0
		rts
ulmul_overflow_1:
		mulu.w	d0,d2
		swap	d2
		tst.w	d2
		bne.s	ulmul_overflow_3
		mulu.w	d0,d1
		add.l	d2,d1
		bcs.s	ulmul_overflow_3
		sf		d0
		rts
ulmul_overflow_2:
		mulu.w	d1,d2
		swap	d2
		tst.w	d2
		bne.s	ulmul_overflow_3
		mulu.w	d0,d1
		add.l	d2,d1
		bcs.s	ulmul_overflow_3
		sf		d0
		rts
ulmul_overflow_3:
		st		d0
		moveq	#-1,d1
		rts


	.globl xopen
xopen:
	and.w      #3,d0
	move.w     d0,-(a7)
	move.l     a0,-(a7)
	move.w     #61,-(a7) ; Fopen
	trap       #1
	addq.w     #8,a7
	tst.l      d0
	bmi.s      xopen_1
	move.b     d0,d1
	moveq.l    #0,d0
	rts
xopen_1:
	cmp.w      #-33,d0
	beq.s      xopen_2
	cmp.w      #-35,d0
	beq.s      xopen_3
	cmp.w      #-100,d0
	beq.s      xopen_4
	moveq.l    #4,d0
	rts
xopen_2:
	moveq.l    #1,d0
	rts
xopen_3:
	moveq.l    #2,d0
	rts
xopen_4:
	moveq.l    #3,d0
	rts

	.globl xlseek
xlseek:
	and.w      #3,d1
	move.w     d1,-(a7)
	and.w      #255,d0
	move.w     d0,-(a7)
	move.l     d2,-(a7)
	move.w     #66,-(a7) /* Fseek */
	trap       #1
	lea.l      10(a7),a7
	move.l     d0,d1
	smi        d0
	rts

	.globl xread
xread:
	move.l     a0,-(a7)
	move.l     d1,-(a7)
	and.w      #$00FF,d0
	move.w     d0,-(a7)
	move.w     #$003F,-(a7) ; Fread
	trap       #1
	lea.l      12(a7),a7
	cmp.l      d1,d0
	bne.s      xread_1
	moveq.l    #0,d0
	rts
xread_1:
	tst.l      d0
	bpl.s      xread_2
	cmp.w      #-37,d0
	beq.s      xread_3
	cmp.w      #-36,d0
	beq.s      xread_4
	moveq.l    #0,d1
	moveq.l    #4,d0
	rts
xread_2:
	move.l     d0,d1
	moveq.l    #1,d0
	rts
xread_3:
	moveq.l    #0,d1
	moveq.l    #2,d0
	rts
xread_4:
	moveq.l    #0,d1
	moveq.l    #3,d0
	rts


		.bss
binsearch_num_entries:
	ds.l	1
binsearch_entry_size:
	ds.l	1
binsearch_cmp_func:
	ds.l	1
binsearch_table:
	ds.l	1

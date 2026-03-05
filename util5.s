/*
 * original assembler version of functions
 * dealing with reading help files.
 * Almost identical to the ones used by Pure-C IDE.
 *
 * A generic C-version of this can be found in pclplib.c
 */
ESC_CHR = 0x1d
HC_ENCRYPT = 0xa3

NUM_HELPFILES = 5

	.xref m_alloc
	.xref m_free
	.xref x_realloc
	.xref strlen
	.xref strcpy
	.xref strcat
	.xref xopen
	.xref xread
	.xref xclose
	.xref xlseek
	.xref strupr
	.xref strcmp
	.xref binsearch_init
	.xref binsearch

		.text

/* void help_init(const char *pc_dir) */
	.globl help_init
help_init:
	movem.l    d3-d4/a3-a5,-(a7)
	movea.l    a0,a3
	bsr        strlen
	add.w      #14,d0
	move.w     d0,d4
	mulu.w     #NUM_HELPFILES,d0
	bsr        m_alloc
	move.l     a0,d0
	beq.s      help_init_1
	movea.l    a0,a4
	moveq.l    #NUM_HELPFILES-1,d3
	lea.l      helplibfiles+(NUM_HELPFILES-1)*62,a5
help_init_2:
	movea.l    a4,a0
	movea.l    a3,a1
	bsr        strcpy
	movea.l    a4,a0
	movea.l    (a5),a1
	bsr        strcat
	move.l     a4,(a5)
	adda.w     d4,a4
	lea.l      -62(a5),a5
	dbf        d3,help_init_2
	moveq.l    #0,d0
help_init_3:
	movem.l    (a7)+,d3-d4/a3-a5
	rts
help_init_1:
	moveq.l    #-1,d0 /* AL_ERROR */
	bra.s      help_init_3


/* buffer for decoded screen */
screen_buffer:
		.dc.l 0

		.globl help_find_online
help_find_online:
		movem.l d3-d4/a2-a4/a6,-(a7)
		movea.l a0,a3
		movea.l a1,a4
		moveq	#ESC_CHR,d0
		cmp.b	(a0)+,d0
		bne.s	help_find_online_1
		move.b	(a0)+,d3
		rol.w	#8,d3
		move.b	(a0)+,d3
		cmp.w	#-1,d3
		beq.s	help_find_online_1
		bmi.s	help_find_online_3
		movea.l #index_page,a0
		move.l  #index_page_end-index_page,a3
		bra 	help_find_online_12

help_find_online_1:
		moveq	#32,d4 /* offsetof(hlpfile, caps_table) */
		bsr 	search_allfiles
		beq.s	help_find_online_2
		movea.l a3,a0
		bsr 	strupr
		moveq	#44,d4 /* offsetof(hlpfile, sens_table) */
		bsr 	search_allfiles
		beq.s	help_find_online_2
		bra 	help_find_online_13

help_find_online_2:
		move.w	4(a0),d3
		move.w	d3,d0
		move.b	d0,2(a3)
		lsr.w	#8,d0
		move.b	d0,1(a3)
help_find_online_3:
		move.w	d3,d4
		and.w	#7,d4
		and.w	#0x7FF8,d3
		lsr.w	#1,d3
		subq.w	#4,d3
		cmp.w	#4,d4
		bgt 	help_find_online_16
		mulu.w	#62,d4
		lea 	helplibfiles,a6
		lea 	0(a6,d4.w),a6
		tst.w	56(a6)
		bne.s	help_find_online_4
		bsr 	read_header
		tst.w	d0
		bne 	help_find_online_18
help_find_online_4:
		cmp.w	10(a6),d3
		bge 	help_find_online_16
		movea.l 4(a6),a2
		move.l	0(a2,d3.w),d4
		move.l	4(a2,d3.w),d3
		sub.l	d4,d3
		move.l	screen_buffer(pc),d0
		beq.s	help_find_online_5
		movea.l d0,a0
		bsr 	m_free
		tst.w	d0
		bne 	help_find_online_15
		moveq	#0,d0
		move.l	d0,screen_buffer
help_find_online_5:
		move.l	#0x00004000,d0
		bsr 	m_alloc
		move.l	a0,d0
		beq 	help_find_online_15
		movea.l a0,a3
.IFNE WITH_FIXES
		/* BUG: will otherwise leak already allocated buffer if seek/read fails */
		move.l	a3,screen_buffer
.ENDC
		sub.l	58(a6),d4
		move.w	56(a6),d0
		moveq	#1,d1
		move.l	d4,d2
		bsr 	xlseek
		tst.b   d0
		bne 	help_find_online_17
		add.l	d4,58(a6)
		move.w	56(a6),d0
		move.l	d3,d1
		movea.l a3,a2
		adda.w	#0x4000,a2
		suba.l	d1,a2
		movea.l a2,a0
		bsr 	xread
		tst.b   d0
		bne 	help_find_online_17
		add.l	d3,58(a6)
		move.l	a3,screen_buffer
		moveq	#0,d4
		moveq	#0,d0
		movea.l 12(a6),a0
help_find_online_6:
		bsr 	get_nibble
		cmp.b	#0x0C,d0
		blt.s	help_find_online_7
		bgt.s	help_find_online_8
		bsr 	get_byte
		move.b	d0,(a3)+
		bra.s	help_find_online_6

help_find_online_7:
		move.b	20(a6,d0.w),(a3)+
		bra.s	help_find_online_6

help_find_online_8:
		cmp.b	#0x0E,d0
		blt.s	help_find_online_9
		bgt.s	help_find_online_11
		move.b	#13,(a3)+ /* CR */
		move.b	#10,(a3)+ /* NL */
		bra.s	help_find_online_6

help_find_online_9:
		bsr 	get_byte
		lsl.w	#4,d0
		move.w	d0,d1
		bsr 	get_nibble
		or.w	d1,d0
		lsl.l	#2,d0
		move.l	4(a0,d0.l),d1
		move.l	0(a0,d0.l),d2
		sub.l	d2,d1
		subq.w	#1,d1
		lea 	0(a0,d2.l),a1
help_find_online_10:
		move.b	(a1)+,d0
		eori.b	#HC_ENCRYPT,d0
		move.b	d0,(a3)+
		dbf 	d1,help_find_online_10
		moveq	#0,d0
		bra.s	help_find_online_6

help_find_online_11:
        clr.b   (a3)
		movea.l screen_buffer,a0
		suba.l	a0,a3
		move.l	a3,d0
.IFNE WITH_FIXES
		addq.l #1,d0 /* BUG: must include the terminating zero */
.ENDC
		bsr 	x_realloc
		tst.w	d0
		bne.s	help_find_online_14
		movea.l screen_buffer,a0
help_find_online_12:
		move.l	a0,(a4)
		movea.l 28(a7),a1
		move.l	a3,(a1)
		moveq	#0,d0
help_find_online_13:
		movem.l (a7)+,d3-d4/a2-a4/a6
		rts

help_find_online_14:
		moveq	#-23,d0 /* AL_BAD_HELPFILE */
		bra.s	help_find_online_18

help_find_online_15:
		moveq	#-3,d0 /* AL_LOWMEM */
		bra.s	help_find_online_18

help_find_online_16:
		moveq	#-9,d0 /* AL_HELP_KEYWORD */
		bra.s	help_find_online_13

help_find_online_17:
		moveq	#-6,d0 /* AL_FILE_READ */
help_find_online_18:
		move.w	d0,d3
		bsr.s	help_exit
		move.w	d3,d0
		bra.s	help_find_online_13

	.globl help_exit
help_exit:
		movem.l d3-d4/a6,-(a7)
		moveq	#NUM_HELPFILES-1,d3
		moveq	#0,d4
		lea 	helplibfiles,a6
help_exit_1:
		move.l	4(a6),d0
		beq.s	help_exit_2
		movea.l d0,a0
		bsr 	m_free
		tst.w	d0
		bne.s	help_exit_6
		move.l	d4,4(a6)
help_exit_2:
		move.l	screen_buffer(pc),d0
		beq.s	help_exit_3
		movea.l d0,a0
		bsr 	m_free
		tst.w	d0
		bne.s	help_exit_6
		move.l	d4,screen_buffer
help_exit_3:
		move.w	56(a6),d0
		beq.s	help_exit_4
		bsr 	xclose
		tst.b	d0
		bne.s	help_exit_5
		move.w	d4,56(a6)
help_exit_4:
		adda.w	#62,a6
		dbf 	d3,help_exit_1
		movem.l (a7)+,d3-d4/a6
		rts
help_exit_5:
		moveq	#-8,d0 /* AL_FILE_CLOSE */
		bra.s	help_exit_4
help_exit_6:
		moveq	#-3,d0 /* AL_LOWMEM */
		bra.s	help_exit_4

get_nibble:
		tst.b	d4
		beq.s	get_nibble1
		move.b	d3,d0
		and.b	#0x0F,d0
		moveq	#0,d4
		rts
get_nibble1:
		move.b	(a2)+,d3
		move.b	d3,d0
		lsr.b	#4,d0
		moveq	#1,d4
		rts

get_byte:
		bsr.s 	get_nibble
		move.b	d0,d1
		lsl.b	#4,d1
		bsr.s 	get_nibble
		or.b	d1,d0
		rts

read_header:
		movem.l d3-d4/a3,-(a7)
		lea 	-88(a7),a7
		moveq	#0,d0
		movea.l (a6),a0
		bsr 	xopen
		tst.b	d0
		bne 	read_header_4
		move.w	d1,d3
		move.w	d3,d0
		moveq	#88,d1 /* read copyright & magic */
		movea.l a7,a0
		bsr 	xread
		tst.b   d0
		bne 	read_header_3
		cmpi.l	#0x48322E30,84(a7)
		bne 	read_header_6
		move.w	d3,d0
		moveq	#48,d1 /* read rest of header */
		lea 	8(a6),a0
		bsr     xread
		tst.b   d0
		bne.s	read_header_3
		move.l	8(a6),d0
		add.l	16(a6),d0
		add.l	36(a6),d0
		add.l	48(a6),d0
		move.l	d0,d4
		bsr 	m_alloc
		move.l	a0,d0
		beq.s	read_header_5
		movea.l a0,a3
		move.w	d3,d0
		move.l	d4,d1
		bsr 	xread
		tst.b   d0
		bne.s	read_header_2
		move.l	d4,58(a6)
		addi.l	#136,58(a6) /* sizeof(HLPHDR) */
		move.w	d3,56(a6)
		move.l	a3,4(a6)
		move.l	a3,d0
		add.l	8(a6),d0
		move.l	d0,12(a6)
		add.l	16(a6),d0
		move.l	d0,32(a6)
		add.l	36(a6),d0
		move.l	d0,44(a6)
		moveq	#0,d0
read_header_1:
		lea 	88(a7),a7
		movem.l (a7)+,d3-d4/a3
		rts
read_header_2:
		movea.l a3,a0
		bsr 	m_free
read_header_3:
		move.w	d3,d0
		bsr 	xclose
		moveq	#-6,d0 /* AL_FILE_READ */
		bra.s	read_header_1
read_header_4:
		moveq	#-24,d0 /* AL_HELP_NOT_FOUND */
		bra.s	read_header_1
read_header_5:
		move.w	d3,d0
		bsr 	xclose
		moveq	#-3,d0 /* AL_LOWMEM */
		bra.s	read_header_1
read_header_6:
		move.w	d3,d0
		bsr 	xclose
		moveq	#-23,d0 /* AL_BAD_HELPFILE */
		bra.s	read_header_1


search_allfiles:
		moveq	#NUM_HELPFILES-1,d3
		lea 	helplibfiles+(NUM_HELPFILES-1)*62,a6
search_allfiles_1:
		tst.w	56(a6)
		bne.s	search_allfiles_2
		bsr 	read_header
		tst.w	d0
		bne.s	search_allfiles_3
search_allfiles_2:
		bsr.s 	search_helpfile
		tst.b	d0
		beq.s	search_allfiles_4
search_allfiles_3:
		lea 	-62(a6),a6
		dbf 	d3,search_allfiles_1
search_allfiles_4:
		rts

search_helpfile:
		move.l	8(a6,d4.w),d0
		moveq	#6,d1
		movea.l 0(a6,d4.w),a0
		lea 	keyword_cmp,a1
		bsr 	binsearch_init
		movea.l a3,a0
		addq.l	#3,a0
		bsr 	binsearch
		tst.w	d0
		beq.s	search_helpfile_1
		move.w	#-9,d0 /* AL_HELP_KEYWORD */
search_helpfile_1:
		rts

keyword_cmp:
		adda.l	(a1),a1
		bsr 	strcmp
		rts

	.data

name_pc_hlp:
.IFNE WITH_FIXES
	.ascii	"PC.HLP"
.ELSE
	.ascii	"PD.HLP"
.ENDC
	.dc.b 0
name_c_hlp:
	.ascii	"C.HLP"
	.dc.b 0
name_lib_hlp:
	.ascii	"LIB.HLP"
	.dc.b 0
name_pasm_hlp:
	.ascii	"PASM.HLP"
	.dc.b 0
name_usr_hlp:
	.ascii	"USR.HLP"
	.dc.b 0
	.even
helplibfiles:
	dc.l	name_pc_hlp
	ds.b    58
	dc.l	name_c_hlp
	ds.b    58
	dc.l	name_lib_hlp
	ds.b    58
	dc.l	name_pasm_hlp
	ds.b    58
	dc.l	name_usr_hlp
	ds.b    58

index_page:
	dc.b	13,10,13,10,13,10
	.ascii "          "
	.dc.b ESC_CHR,0x80,0x10 /* Screen #2 of file #0 */
.IFNE WITH_FIXES
	.ascii "Pure C"
.ELSE
	.ascii "Pure Debugger"
.ENDC
	.dc.b ESC_CHR,13,10
	.ascii "          "
	.dc.b ESC_CHR,0x80,0x11 /* Screen #2 of file #1 */
	.ascii "C Language"
	.dc.b ESC_CHR,13,10
	.ascii "          "
	.dc.b ESC_CHR,0x80,0x12 /* Screen #2 of file #2 */
	.ascii "Libraries"
	.dc.b ESC_CHR,13,10
	.ascii "          "
	.dc.b ESC_CHR,0x80,0x13 /* Screen #2 of file #3 */
	.ascii "Assembler"
	.dc.b ESC_CHR,13,10
	.ascii "          "
	.dc.b ESC_CHR,0x80,0x14 /* Screen #2 of file #4 */
	.ascii "Userdefined Help"
	.dc.b ESC_CHR
.IFNE WITH_FIXES
index_page_end:
.ENDC
	.even
.IFEQ WITH_FIXES
/* BUG: len above will include terminating zero */
index_page_end:
.ENDC

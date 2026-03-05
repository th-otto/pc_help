				INCLUDE	"gem.i"

		.xref _aes

		GLOBL appl_init
		MODULE appl_init
		moveq.l    #10,d0
		bra        _aes
		ENDMOD
		
		
		GLOBL appl_write
		MODULE appl_write
		move.l     a0,_GemParBlk+addrin
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)
		moveq.l    #12,d0
		bra        _aes
		ENDMOD


		GLOBL appl_exit
		MODULE appl_exit
		moveq.l    #19,d0
		bra        _aes
		ENDMOD


		GLOBL evnt_timer
		MODULE evnt_timer
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)
		moveq.l    #24,d0
		bra        _aes
		ENDMOD


		GLOBL evnt_button
		MODULE	evnt_button
		move.l	a1,-(a7)
		move.l	a0,-(a7)
		movem.w	d0-d2,_GemParBlk+intin
		moveq.l #21,d0
		bsr		_aes
		movea.l (a7)+,a1
		move.w	(a0)+,(a1)
		movea.l (a7)+,a1
		move.w	(a0)+,(a1)
		movea.l 4(a7),a1
		move.w	(a0)+,(a1)
		movea.l 8(a7),a1
		move.w	(a0)+,(a1)
		rts
		ENDMOD


		GLOBL evnt_multi
		MODULE evnt_multi
		move.l     a0,_GemParBlk+addrin
		move.l     a1,-(a7)
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     d2,(a0)+
		move.w     8(a7),(a0)+
		move.w     10(a7),(a0)+
		move.w     12(a7),(a0)+
		move.w     14(a7),(a0)+
		move.w     16(a7),(a0)+
		move.w     18(a7),(a0)+
		move.w     20(a7),(a0)+
		move.w     22(a7),(a0)+
		move.w     24(a7),(a0)+
		move.w     26(a7),(a0)+
		move.w     28(a7),(a0)+
		move.w     30(a7),(a0)+
		move.w     32(a7),(a0)
		moveq.l    #25,d0
		bsr        _aes
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    30(a7),a1
		move.w     (a0)+,(a1)
		movea.l    34(a7),a1
		move.w     (a0)+,(a1)
		movea.l    38(a7),a1
		move.w     (a0)+,(a1)
		movea.l    42(a7),a1
		move.w     (a0)+,(a1)
		movea.l    46(a7),a1
		move.w     (a0)+,(a1)
		rts
		ENDMOD


		GLOBL objc_draw
		MODULE objc_draw
		move.l     a0,_GemParBlk+addrin
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     d2,(a0)+
		move.w     4(a7),(a0)+
		move.w     6(a7),(a0)+
		move.w     8(a7),(a0)+
		moveq.l    #42,d0
		bra        _aes
		ENDMOD


		GLOBL form_do
		MODULE form_do
		move.l     a0,_GemParBlk+addrin
		move.w     d0,_GemParBlk+intin
		moveq.l    #50,d0
		bra        _aes
		ENDMOD


		GLOBL form_dial
		MODULE form_dial
		move.l     a0,_GemParBlk+addrin
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     d2,(a0)+
		move.w     4(a7),(a0)+
		move.w     6(a7),(a0)+
		move.w     8(a7),(a0)+
		move.w     10(a7),(a0)+
		move.w     12(a7),(a0)+
		move.w     14(a7),(a0)
		moveq.l    #51,d0
		bra        _aes
		ENDMOD


		GLOBL form_center
		MODULE form_center
		move.l     a1,-(a7)
		move.l     a0,_GemParBlk+addrin
		moveq.l    #54,d0
		bsr        _aes
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    4(a7),a1
		move.w     (a0)+,(a1)
		movea.l    8(a7),a1
		move.w     (a0)+,(a1)
		movea.l    12(a7),a1
		move.w     (a0)+,(a1)
		rts
		ENDMOD


		GLOBL form_alert
		MODULE form_alert
		move.l     a0,_GemParBlk+addrin
		move.w     d0,_GemParBlk+intin
		moveq.l    #52,d0
		bra        _aes
		ENDMOD


		GLOBL rsrc_obfix
		MODULE rsrc_obfix
		move.l     a0,_GemParBlk+addrin
		move.w     d0,_GemParBlk+intin
		moveq.l    #114,d0
		bra        _aes
		ENDMOD


		GLOBL menu_register
		MODULE menu_register
		move.w     d0,_GemParBlk+intin
		move.l     a0,_GemParBlk+addrin
		moveq.l    #35,d0
		bra        _aes
		ENDMOD


		GLOBL graf_handle
		MODULE graf_handle
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		moveq.l    #77,d0
		bsr        _aes
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    4(a7),a1
		move.w     (a0)+,(a1)
		movea.l    8(a7),a1
		move.w     (a0)+,(a1)
		rts
		ENDMOD


		GLOBL graf_mouse
		MODULE graf_mouse
		move.l     a0,_GemParBlk+addrin
		move.w     d0,_GemParBlk+intin
		moveq.l    #78,d0
		bra        _aes
		ENDMOD


		GLOBL graf_mkstate
		MODULE graf_mkstate
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		moveq.l    #79,d0
		bsr        _aes
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    4(a7),a1
		move.w     (a0)+,(a1)
		movea.l    8(a7),a1
		move.w     (a0)+,(a1)
		rts
		ENDMOD


		GLOBL wind_get
		MODULE wind_get
		move.l     a2,-(a7)
		move.w     d1,-(a7)
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)
		moveq.l    #104,d0
		bsr        _aes
		move.w     (a7)+,d1
		lea.l      8(a7),a1
		subq.w     #1,d1
		and.w      #31,d1
		move.b     windgettab(pc,d1.w),d1
wind_get_1:
		movea.l    (a1)+,a2
		move.w     (a0)+,(a2)
		dbf        d1,wind_get_1
		movea.l    (a7)+,a2
		rts

windgettab:
		dc.b 0,0,0,3
		dc.b 3,3,3,0
		dc.b 0,0,3,3
		dc.b 0,0,0,0
		dc.b 3,0
		ENDMOD


		GLOBL wind_create
		MODULE wind_create
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     d2,(a0)+
		move.w     4(a7),(a0)+
		move.w     6(a7),(a0)
		moveq.l    #100,d0
		bra        _aes
		ENDMOD


		GLOBL wind_open
		MODULE wind_open
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     d2,(a0)+
		move.w     4(a7),(a0)+
		move.w     6(a7),(a0)
		moveq.l    #101,d0
		bra        _aes
		ENDMOD


		GLOBL wind_delete
		MODULE wind_delete
		move.w     d0,_GemParBlk+intin
		moveq.l    #103,d0
		bra        _aes
		ENDMOD


		GLOBL wind_set
		MODULE wind_set
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     4(a7),(a0)+
		move.w     6(a7),(a0)+
		move.w     8(a7),(a0)+
		move.w     10(a7),(a0)
		moveq.l    #105,d0
		bra.w      _aes
		ENDMOD


		GLOBL wind_calc
		MODULE wind_calc
		move.l     a1,-(a7)
		move.l     a0,-(a7)
		lea.l      _GemParBlk+intin,a0
		move.w     d0,(a0)+
		move.w     d1,(a0)+
		move.w     d2,(a0)+
		move.w     12(a7),(a0)+
		move.w     14(a7),(a0)+
		move.w     16(a7),(a0)
		moveq.l    #108,d0
		bsr.w      _aes
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    (a7)+,a1
		move.w     (a0)+,(a1)
		movea.l    10(a7),a1
		move.w     (a0)+,(a1)
		movea.l    14(a7),a1
		move.w     (a0)+,(a1)
		rts
		ENDMOD


		GLOBL wind_close
		MODULE wind_close
		move.w     d0,_GemParBlk+intin
		moveq.l    #102,d0
		bra.w      _aes
		ENDMOD


		GLOBL wind_update
		MODULE wind_update
		move.w     d0,_GemParBlk+intin
		moveq.l    #107,d0
		bra.w      _aes
		ENDMOD


		GLOBL scrp_read
		MODULE scrp_read
		move.l     a0,_GemParBlk+addrin
		moveq.l    #80,d0
		bra.w      _aes
		ENDMOD


		GLOBL scrp_write
		MODULE scrp_write
		move.l     a0,_GemParBlk+addrin
		moveq.l    #81,d0
		bra.w      _aes
		ENDMOD


				MODULE	_aes
				move.l	a2,-(a7)
				move.w	d0,_GemParBlk+control+a_opcode
				add.w d0,d0
				add.w d0,d0
				lea aestab-4*10(pc,d0.w),a0
				lea.l	_GemParBlk+control+a_nintin,a1
				clr.w      d0
				move.b     (a0)+,d0
				move.w     d0,(a1)+
				move.b     (a0)+,d0
				move.w     d0,(a1)+
				move.b     (a0)+,d0
				move.w     d0,(a1)+
				move.b     (a0)+,d0
				move.w     d0,(a1)+
				move.w	#$00c8,d0
				move.l	#aespb,d1
				trap	#2
				lea.l	_GemParBlk+intout,a0
				move.w	(a0)+,d0
				move.l	(a7)+,a2
				rts

_AesParBlk:
aespb:			dc.l	_GemParBlk+control
				dc.l	_GemParBlk+global
				dc.l	_GemParBlk+intin
				dc.l	_GemParBlk+intout
				dc.l	_GemParBlk+addrin
				dc.l	_GemParBlk+addrout

aestab:
				dc.b	0,1,0,0 ; appl_init
				dc.b	2,1,1,0 ; appl_read
				dc.b	2,1,1,0 ; appl_write
				dc.b	0,1,1,0 ; appl_find
				dc.b	2,1,1,0 ; appl_tplay
				dc.b	1,1,1,0 ; appl_trecord
				dc.b	0,0,0,0 ; appl_bvset
				dc.b	0,0,0,0 ; appl_yield
				dc.b	0,0,0,0 ; appl_search
				dc.b	0,1,0,0 ; appl_exit
				
				dc.b	0,1,0,0 ; evnt_keybd
				dc.b	3,5,0,0 ; evnt_button
				dc.b	5,5,0,0 ; evnt_mouse
				dc.b	0,1,1,0 ; evnt_mesag
				dc.b	2,1,0,0 ; evnt_timer
				dc.b	16,7,1,0 ; evnt_multi
				dc.b	2,1,0,0 ; evnt_dclick
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				
				dc.b	1,1,1,0 ; menu_bar
				dc.b	2,1,1,0 ; menu_icheck
				dc.b	2,1,1,0 ; menu_ienable
				dc.b	2,1,1,0 ; menu_tnormal
				dc.b	1,1,2,0 ; menu_text
				dc.b	1,1,1,0 ; menu_register
				dc.b	0,0,0,0 ; menu_unregister,menu_popup=2,1,2,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	2,1,1,0 ; objc_add
				dc.b	1,1,1,0 ; objc_delete
				dc.b	6,1,1,0 ; objc_draw
				dc.b	4,1,1,0 ; objc_find
				dc.b	1,3,1,0 ; objc_offset
				dc.b	2,1,1,0 ; objc_order
				dc.b	4,2,1,0 ; objc_edit
				dc.b	8,1,1,0 ; objc_change
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	1,1,1,0 ; form_do
				dc.b	9,1,1,0 ; form_dial
				dc.b	1,1,1,0 ; form_alert
				dc.b	1,1,0,0 ; form_error
				dc.b	0,5,1,0 ; form_center
				dc.b	3,3,1,0 ; form_keybd
				dc.b	2,2,1,0 ; form_button
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	4,3,0,0 ; graf_rubberbox
				dc.b	8,3,0,0 ; graf_dragbox
				dc.b	6,1,0,0 ; graf_movebox
				dc.b	8,1,0,0 ; graf_growbox
				dc.b	8,1,0,0 ; graf_shrinkbox
				dc.b	4,1,1,0 ; graf_watchbox
				dc.b	3,1,1,0 ; graf_slidebox
				dc.b	0,5,0,0 ; graf_handle
				dc.b	1,1,1,0 ; graf_mouse
				dc.b	0,5,0,0 ; graf_mkstate
				dc.b	0,1,1,0 ; scrp_read
				dc.b	0,1,1,0 ; scrp_write
				dc.b	0,0,0,0 ; scrp_clear
				dc.b	0,0,0,0 
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,2,2,0 ; fsel_input
				dc.b	0,2,3,0 ; fsel_exinput
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	5,1,0,0 ; wind_create
				dc.b	5,1,0,0 ; wind_open
				dc.b	1,1,0,0 ; wind_close
				dc.b	1,1,0,0 ; wind_delete
				dc.b	2,5,0,0 ; wind_get
				dc.b	6,1,0,0 ; wind_set
				dc.b	2,1,0,0 ; wind_find
				dc.b	1,1,0,0 ; wind_update
				dc.b	6,5,0,0 ; wind_calc
				dc.b	0,0,0,0 ; wind_new
				dc.b	0,1,1,0 ; rsrc_load
				dc.b	0,1,0,0 ; rsrc_free
				dc.b	2,1,0,1 ; rsrc_gaddr
				dc.b	2,1,1,0 ; rsrc_saddr
				dc.b	1,1,1,0 ; rsrc_obfix
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,0,0,0
				dc.b	0,1,2,0 ; shel_read
				dc.b	3,1,2,0 ; shel_write
				dc.b	1,1,1,0 ; shel_get
				dc.b	1,1,1,0 ; shel_put
				dc.b	0,1,1,0 ; shel_find
				dc.b	0,1,3,0 ; shel_envrn

				ENDMOD
				

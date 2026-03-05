				INCLUDE	"gem.i"

				.xref _VdiCtrl

				GLOBL	vq_extnd
				MODULE	vq_extnd
				move.l	a0,-(a7)
				lea		_GemParBlk+control,a0
				clr.w	v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				move.w	d1,intin(a0)
				move.w	#102,d1
				bsr		_VdiCtrl
				movea.l	(a7)+,a1
				move.w	d0,(a1)+
				moveq	#45-1-1,d1
vq_extnd1:		move.w	(a0)+,(a1)+
				dbf		d1,vq_extnd1
				lea		_GemParBlk+ptsout,a0
				moveq	#12-1,d1
vq_extnd2:		move.w	(a0)+,(a1)+
				dbf		d1,vq_extnd2
				rts
				ENDMOD


				GLOBL vro_cpyfm
				MODULE	vro_cpyfm
				move.l	a0,-(a7)
				lea		_GemParBlk,a0 
				move.w	#4,v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				move.l	a1,v_param(a0) /* src mfdb */
				move.l	8(a7),v_param+4(a0)  /* dest mfdb */
				move.w	d1,intin(a0) /* mode */
				move.l	(a7)+,a1        /* pxyarray */
				lea		ptsin(a0),a0
				move.w	(a1)+,(a0)+
				move.w	(a1)+,(a0)+
				move.w	(a1)+,(a0)+
				move.w	(a1)+,(a0)+
				move.w	(a1)+,(a0)+
				move.w	(a1)+,(a0)+
				move.w	(a1)+,(a0)+
				move.w	(a1),(a0)
				lea		_GemParBlk,a0 
				moveq	#109,d1 
				bra		_VdiCtrl
				ENDMOD


				GLOBL vr_recfl
				MODULE	vr_recfl
				lea		_GemParBlk+ptsin,a1
				move.w	(a0)+,(a1)+
				move.w	(a0)+,(a1)+
				move.w	(a0)+,(a1)+
				move.w	(a0),(a1)
				lea		_GemParBlk+control,a0
				move.w	#2,v_nptsin(a0)
				clr.w	v_nintin(a0)
				moveq	#114,d1
				bra		_VdiCtrl
				ENDMOD


				GLOBL vsf_color
				MODULE	vsf_color
				lea		_GemParBlk+control,a0
				clr.w	v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				move.w	d1,intin(a0)
				moveq	#25,d1
				bra		_VdiCtrl
				ENDMOD


				GLOBL vsf_interior
				MODULE	vsf_interior
				lea		_GemParBlk+control,a0
				move.w	d1,intin(a0)
				clr.w	v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				moveq	#23,d1
				bra		_VdiCtrl
				ENDMOD


				GLOBL vst_alignment
				MODULE	vst_alignment
				move.l	a1,-(a7)
				move.l	a0,-(a7)
				lea		_GemParBlk,a0
				clr.w	v_nptsin(a0)
				move.w	#2,v_nintin(a0)
				move.w	d1,intin(a0)
				move.w	d2,intin+2(a0)
				moveq	#39,d1
				bsr		_VdiCtrl
				lea		_GemParBlk+intout,a0
				movea.l (a7)+,a1
				move.w	(a0)+,(a1)
				movea.l (a7)+,a1
				move.w	(a0)+,(a1)
				rts
				ENDMOD


				GLOBL vst_effects
				MODULE	vst_effects
				lea		_GemParBlk,a0
				clr.w	v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				move.w	d1,intin(a0)
				moveq	#106,d1
				bra		_VdiCtrl
				ENDMOD


				GLOBL vswr_mode
				MODULE	vswr_mode
				lea		_GemParBlk,a0
				clr.w	v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				move.w	d1,intin(a0)
				moveq	#32,d1
				bra		_VdiCtrl
				ENDMOD


				GLOBL vs_clip			
				MODULE	vs_clip
				lea		_GemParBlk,a1
				move.w	#2,v_nptsin(a1)
				move.w	#1,v_nintin(a1)
				move.w	d1,intin(a1)
				lea		ptsin(a1),a1
				move.l	(a0)+,(a1)+
				move.l	(a0),(a1)
				lea		_GemParBlk,a0
				move.w	#129,d1
				bra		_VdiCtrl
				ENDMOD
				
				
				GLOBL v_clsvwk
				MODULE	v_clsvwk
				lea     _GemParBlk,a0
				clr.w   v_nptsin(a0)
		     	clr.w   v_nintin(a0)
		    	moveq   #101,d1
				bra     _VdiCtrl
				ENDMOD


				GLOBL v_gtext
				MODULE	v_gtext
				lea		_GemParBlk,a1
				move.w	d1,ptsin(a1)
				move.w	d2,ptsin+2(a1)
				move.w	#1,v_nptsin(a1)
				lea		intin(a1),a1
				moveq	#0,d1
				moveq	#-1,d2
v_gtext1:		move.b	(a0)+,d1
				addq.w	#1,d2
				move.w	d1,(a1)+
				bne		v_gtext1
				lea		_GemParBlk,a0
				move.w	d2,v_nintin(a0)
				moveq	#8,d1
				bra		_VdiCtrl
				ENDMOD


				GLOBL v_hide_c
				MODULE	v_hide_c
				lea	_GemParBlk,a0
				clr.w	v_nptsin(a0)
				clr.w	v_nintin(a0)
				moveq	#123,d1
				bra	_VdiCtrl
				ENDMOD



				GLOBL v_opnvwk
				MODULE	v_opnvwk
				move.w	(a1),_GemParBlk+v_handle
				move.l	a1,-(a7)
				lea     _GemParBlk,a1
				move.w	#100,v_opcode(a1)
				clr.w	v_nptsin(a1)
				move.w	#11,v_nintin(a1)
				lea		intin(a1),a1
				moveq	#11-1,d0
v_opnvwk1:		move.w	(a0)+,(a1)+
				dbf		d0,v_opnvwk1
				move.l	#vdipb,d1
				moveq	#$73,d0
				move.l	a2,-(a7)
				trap	#2
				move.l	(a7)+,a2
				movea.l (a7)+,a0
				move.w	_GemParBlk+v_handle,(a0)
				lea		_GemParBlk+intout,a0
				movea.l 4(a7),a1
				moveq	#45-1,d0
v_opnvwk2:		move.w	(a0)+,(a1)+
				dbf	d0,v_opnvwk2
				lea		_GemParBlk+ptsout,a0
				moveq	#12-1,d0
v_opnvwk3:		move.w	(a0)+,(a1)+
				dbf		d0,v_opnvwk3
				rts
vdipb:			dc.l	_GemParBlk+control
				dc.l	_GemParBlk+intin
				dc.l	_GemParBlk+ptsin
				dc.l	_GemParBlk+intout
				dc.l	_GemParBlk+ptsout
				ENDMOD


				GLOBL v_show_c
				MODULE	v_show_c
				lea	_GemParBlk,a0
				clr.w	v_nptsin(a0)
				move.w	#1,v_nintin(a0)
				move.w	d1,intin(a0)
				moveq	#122,d1
				bra	_VdiCtrl
				ENDMOD


				.xref _VdiParBlk
				GLOBL _VdiCtrl
				MODULE	_VdiCtrl
				move.l	a2,-(a7)
				move.w	d0,v_handle(a0)
				move.w	d1,v_opcode(a0)
				move.l	#_VdiParBlk,d1
				moveq	#$73,d0
				trap	#2
				lea		_GemParBlk+intout,a0
				move.w	(a0)+,d0
				move.l	(a7)+,a2
				rts
				ENDMOD


				DATA

	.globl _VdiParBlk
_VdiParBlk:		dc.l	_GemParBlk+control
				dc.l	_GemParBlk+intin
				dc.l	_GemParBlk+ptsin
				dc.l	_GemParBlk+intout
				dc.l	_GemParBlk+ptsout

				BSS

_GemParBlk:		ds.w	VDI_CNTRLMAX    ; control
aes_global:		ds.w	AES_GLOBMAX     ; global
				ds.w	VDI_INTINMAX    ; intin
				ds.w	VDI_INTOUTMAX   ; intout
				ds.w	VDI_PTSOUTMAX   ; ptsout
				ds.l	AES_ADDRINMAX   ; addrin
				ds.l	AES_ADDROUTMAX  ; addrout
				ds.w	VDI_PTSINMAX    ; ptsin

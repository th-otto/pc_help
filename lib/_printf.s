	.globl _PrintF

	.xref _OutChr
	.xref _OutStr
	.xref _OutCarD
	.xref _OutIntD
	.xref _OutCarH
	.xref _OutCarO
	.xref strtoul

NO_FLOAT = 1
__68881__ = 0

	.IFEQ NO_FLOAT
	.xref _OutFlt
	.xref _OutFix
	.xref _OutFixF

	.IFNE __68881__
SIZEOF_DOUBLE = 12
	.ELSE
SIZEOF_DOUBLE = 10
	.ENDC

	.ENDC

	.text

_PrintF:
	movem.l    d3-d6/a2-a4,-(a7)
	subq.w     #6,a7
	movea.l    a0,a2
	movea.l    a1,a3
	movea.l    38(a7),a4
	clr.w      d3
	moveq.l    #'%',d4
_PrintF1:
	moveq.l    #-1,d0
	movea.l    a2,a0
_PrintF2:
	addq.w     #1,d0
	move.b     (a2)+,d5
	beq        _PrintF15
	cmp.b      d4,d5
	bne.s      _PrintF2
	tst.w      d0
	beq.s      _PrintF3
	add.w      d0,d3
	ext.l      d0
	jsr        (a4)
_PrintF3:
	clr.w      d5
_PrintF4:
	move.b     (a2)+,d0
	beq        case_default
	clr.w      d1
	move.b     d0,d1
	sub.b      #' ',d1
	cmp.b      #16,d1
	bhi.s      _PrintF5
	move.b     printftab(pc,d1.w),d1
	bmi.s      _PrintF5
	or.b       d1,d5
	bra.s      _PrintF4

printftab: .dc.b 1,-1,-1,2,-1,-1,-1,-1,-1,-1,-1,4,-1,8,-1,-1,16,0

_PrintF5:
	moveq.l    #-1,d6
	cmp.b      #'*',d0
	bne.s      _PrintF6
	move.w     (a3)+,d6
	bra        _PrintF7
_PrintF6:
	move.b     d0,d1
	sub.b      #'0',d1
	cmp.b      #9,d1
	bhi.s      _PrintF8
	lea.l      -1(a2),a0
	lea.l      (a7),a1
	moveq.l    #10,d0
	bsr.w      strtoul
	movea.l    (a7),a2
	cmp.l      #32767,d0
	bhi        case_default
	move.w     d0,d6
_PrintF7:
	move.b     (a2)+,d0
	beq        case_default
_PrintF8:
	moveq.l    #-1,d2
	cmp.b      #'.',d0
	bne.s      _PrintF11
	move.b     (a2)+,d0
	cmp.b      #'*',d0
	bne.s      _PrintF9
	move.w     (a3)+,d2
	bra.s      _PrintF10
_PrintF9:
	sub.b      #'0',d0
	cmp.b      #9,d0
	bhi.s      _PrintF11
	lea.l      -1(a2),a0
	lea.l      (a7),a1
	moveq.l    #10,d0
	bsr.w      strtoul
	movea.l    (a7),a2
	cmp.l      #32767,d0
	bhi        case_default
	move.w     d0,d2
_PrintF10:
	move.b     (a2)+,d0
	beq        case_default
_PrintF11:
	move.b     d0,d1
	and.b      #0xDF,d1
	cmp.b      #'L',d1
	bne.s      _PrintF13
	bset       #15,d5
_PrintF12:
	move.b     (a2)+,d0
	beq        case_default
	bra.s      _PrintF14
_PrintF13:
	cmp.b      #'h',d0
	beq.s      _PrintF12
_PrintF14:
	cmp.b      d4,d0
	beq        case_perc
	moveq.l    #64,d1
	sub.b      d1,d0
	cmp.b      d1,d0
	bcc        case_default
	and.w      #0x3F,d0
	add.w      d0,d0
	move.w     J3(pc,d0.w),d0
	jmp        J3(pc,d0.w)
J3:
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_E-J3
	dc.w case_F-J3
	dc.w case_G-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_X-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_c-J3
	dc.w case_d-J3
	dc.w case_e-J3
	dc.w case_f-J3
	dc.w case_g-J3
	dc.w case_default-J3
	dc.w case_i-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_n-J3
	dc.w case_o-J3
	dc.w case_p-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_s-J3
	dc.w case_default-J3
	dc.w case_u-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_x-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3
	dc.w case_default-J3

case_n:
	movea.l    (a3)+,a0
	move.w     d3,(a0)
	bra        _PrintF1

case_perc:
	lea.l      4(a7),a0
	move.b     d4,(a0)
	bra.s      case_c_1

case_c:
	move.w     (a3)+,d0
	lea.l      4(a7),a0
	move.b     d0,(a0)
case_c_1:
	move.b     d5,d0
	move.w     d6,d1
	movea.l    a4,a1
	bsr.w      _OutChr
	add.w      d0,d3
	bra        _PrintF1

case_s:
	movea.l    (a3)+,a0
	move.b     d5,d0
	move.w     d6,d1
	movea.l    a4,a1
	bsr.w      _OutStr
	add.w      d0,d3
	bra        _PrintF1

case_u:
	tst.w      d5
	bpl.s      case_u_1
	move.l     (a3)+,d0
	bra.s      case_u_2
case_u_1:
	moveq.l    #0,d0
	move.w     (a3)+,d0
case_u_2:
	move.w     d2,-(a7)
	move.b     d5,d1
	move.w     d6,d2
	movea.l    a4,a0
	bsr.w      _OutCarD
	addq.w     #2,a7
	add.w      d0,d3
	bra        _PrintF1

case_d:
case_i:
	tst.w      d5
	bpl.s      case_d_1
	move.l     (a3)+,d0
	bra.s      case_d_2
case_d_1:
	move.w     (a3)+,d0
	ext.l      d0
case_d_2:
	move.w     d2,-(a7)
	move.b     d5,d1
	move.w     d6,d2
	movea.l    a4,a0
	bsr.w      _OutIntD
	addq.w     #2,a7
	add.w      d0,d3
	bra        _PrintF1

case_X:
	bset       #5,d5
case_x:
	tst.w      d5
	bpl.s      case_x_1
case_p:
	move.l     (a3)+,d0
	bra.s      case_x_2
case_x_1:
	moveq.l    #0,d0
	move.w     (a3)+,d0
case_x_2:
	move.w     d2,-(a7)
	move.b     d5,d1
	move.w     d6,d2
	movea.l    a4,a0
	bsr.w      _OutCarH
	addq.w     #2,a7
	add.w      d0,d3
	bra        _PrintF1

case_o:
	tst.w      d5
	bpl.s      case_o_1
	move.l     (a3)+,d0
	bra.s      case_o_2
case_o_1:
	moveq.l    #0,d0
	move.w     (a3)+,d0
case_o_2:
	move.w     d2,-(a7)
	move.b     d5,d1
	move.w     d6,d2
	movea.l    a4,a0
	bsr.w      _OutCarO
	addq.w     #2,a7
	add.w      d0,d3
	bra        _PrintF1

	.IFEQ NO_FLOAT
case_E:
	bset       #5,d5
case_e:
	lea.l      (a3),a0
	adda.w     #SIZEOF_DOUBLE,a3
	move.b     d5,d0
	move.w     d6,d1
	movea.l    a4,a1
	bsr.w      _OutFlt
	add.w      d0,d3
	bra        _PrintF1
case_f:
	lea.l      (a3),a0
	adda.w     #SIZEOF_DOUBLE,a3
	move.b     d5,d0
	move.w     d6,d1
	movea.l    a4,a1
	bsr.w      _OutFix
	add.w      d0,d3
	bra        _PrintF1

case_G:
	bset       #5,d5
case_g:
	lea.l      (a3),a0
	adda.w     #SIZEOF_DOUBLE,a3
	move.b     d5,d0
	move.w     d6,d1
	movea.l    a4,a1
	bsr.w      _OutFixF
	add.w      d0,d3
	bra        _PrintF1
	.ENDC

_PrintF15:
	add.w      d0,d3
	ext.l      d0
	jsr        (a4)
	move.w     d3,d0
_PrintF16:
	addq.w     #6,a7
	movem.l    (a7)+,d3-d6/a2-a4
	rts

	.IFNE NO_FLOAT

case_E:
case_G:
case_e:
case_f:
case_g:
	moveq.l    #0,d0
	move.w     d0,d1
	move.w     #-1,d2
	lea.l      fltwarn(pc),a0
	movea.l    a4,a1
	bsr.w      _OutStr
	.ENDC

case_F: /* FIXME: should be same as f */
case_default:
	moveq.l    #-1,d0
	bra.s      _PrintF16

fltwarn: .dc.b 13,10
	.ascii "Warning: use TCFLTLIB to get float support for printf."
	.dc.b 13,10,0
	.even


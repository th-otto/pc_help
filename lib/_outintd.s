	.globl _OutIntD
	.globl _OutCarD
	.globl _OutCarH
	.globl _OutCarO
	.globl _OutChr
	.globl _OutStr
	.globl OutZero
	.globl OutBlank

	.xref ultoa

_OutIntD:
	movem.l    d3-d4/a2,-(a7)
	lea.l      -24(a7),a7
	moveq.l    #10,d3
	tst.l      d0
	bpl.s      _OutIntD1
	move.b     #'-',6(a7)
	move.w     #1,8(a7)
	neg.l      d0
	bra        _OutCarO2
_OutIntD1:
	btst       #2,d1
	beq.s      _OutIntD2
	move.b     #'+',6(a7)
	move.w     #1,8(a7)
	bra        _OutCarO2
_OutIntD2:
	btst       #0,d1
	beq.s      _OutIntD3
	move.b     #' ',6(a7)
	move.w     #1,8(a7)
	bra.s      _OutCarO2
_OutIntD3:
	move.w     #0,8(a7)
	bra.s      _OutCarO2

_OutCarD:
	movem.l    d3-d4/a2,-(a7)
	lea.l      -24(a7),a7
	moveq.l    #10,d3
	move.w     #0,8(a7)
	bra.s      _OutCarO2

_OutCarH:
	movem.l    d3-d4/a2,-(a7)
	lea.l      -24(a7),a7
	moveq.l    #16,d3
	btst       #1,d1
	bne.s      _OutCarH1
	move.w     #0,8(a7)
	bra.s      _OutCarO2
_OutCarH1:
	move.b     #'0',6(a7)
	btst       #5,d1
	bne.s      _OutCarH2
	move.b     #'x',7(a7)
	move.w     #2,8(a7)
	bra.s      _OutCarO2
_OutCarH2:
	move.b     #'X',7(a7)
	move.w     #2,8(a7)
	bra.s      _OutCarO2

_OutCarO:
	movem.l    d3-d4/a2,-(a7)
	lea.l      -24(a7),a7
	moveq.l    #8,d3
	btst       #1,d1
	bne.s      _OutCarO1
	move.w     #0,8(a7)
	bra.s      _OutCarO2
_OutCarO1:
	move.b     #'0',6(a7)
	move.w     #1,8(a7)
_OutCarO2:
	movea.l    a0,a2
	move.w     d1,(a7)
	exg        d1,d3
	move.w     d2,d4
	bpl.s      _OutCarO3
	moveq.l    #0,d4
_OutCarO3:
	lea.l      10(a7),a0
	bsr.w      ultoa
	lea.l      10(a7),a0
	moveq.l    #-1,d0
_OutCarO4:
	tst.b      (a0)+
	dbeq       d0,_OutCarO4
	not.w      d0
	move.w     d0,22(a7)
	btst       #5,d3
	beq.s      _OutCarO6
	lea.l      10(a7),a0
	move.w     d0,d1
	subq.w     #1,d1
	bmi.s      _OutCarO6
	moveq.l    #'a',d2
_OutCarO5:
	cmp.b      (a0)+,d2
	dbls       d1,_OutCarO5
	bhi.s      _OutCarO6
	andi.b     #0xDF,-1(a0)
	dbf        d1,_OutCarO5
_OutCarO6:
	move.w     8(a7),d1
	add.w      d0,d1
	move.w     40(a7),d2
	bpl.s      _OutCarO7
	moveq.l    #1,d2
_OutCarO7:
	sub.w      d0,d2
	bpl.s      _OutCarO8
	moveq.l    #0,d2
_OutCarO8:
	add.w      d2,d1
	btst       #4,d3
	beq.s      _OutCarO9
	btst       #3,d3
	bne.s      _OutCarO9
	move.w     d4,d0
	sub.w      d1,d0
	ble.s      _OutCarO10
	add.w      d0,d1
	add.w      d0,d2
_OutCarO9:
	sub.w      d1,d4
	bge.s      _OutCarO11
_OutCarO10:
	moveq.l    #0,d4
_OutCarO11:
	move.w     d2,4(a7)
	move.w     d4,2(a7)
	bra.s      _OutStr8

_OutChr:
	movem.l    d3-d4/a2-a3,-(a7)
	movea.l    a0,a2
	movea.l    a1,a3
	clr.b      1(a0)
	moveq.l    #1,d3
	bra.s      _OutStr2

_OutStr:
	movem.l    d3-d4/a2-a3,-(a7)
	movea.l    a0,a2
	movea.l    a1,a3
	moveq.l    #-1,d3
_OutStr1:
	tst.b      (a0)+
	dbeq       d3,_OutStr1
	not.w      d3
_OutStr2:
	tst.w      d2
	bpl.s      _OutStr3
	move.w     d3,d2
_OutStr3:
	cmp.w      d3,d2
	bhi.s      _OutStr4
	move.w     d2,d3
_OutStr4:
	moveq.l    #0,d4
	tst.w      d1
	bmi.s      _OutStr5
	cmp.w      d3,d1
	bls.s      _OutStr5
	move.w     d1,d4
	sub.w      d3,d4
_OutStr5:
	btst       #3,d0
	bne.s      _OutStr6
	movea.l    a3,a0
	move.w     d4,d0
	bsr        OutBlank
	move.w     d3,d0
	movea.l    a2,a0
	jsr        (a3)
	bra.s      _OutStr7
_OutStr6:
	move.w     d3,d0
	movea.l    a2,a0
	jsr        (a3)
	move.w     d4,d0
	movea.l    a3,a0
	bsr.s      OutBlank
_OutStr7:
	move.w     d3,d0
	add.w      d4,d0
	movem.l    (a7)+,d3-d4/a2-a3
	rts
_OutStr8:
	move.w     (a7),d3
	moveq.l    #0,d4
	move.w     2(a7),d0
	beq.s      _OutStr9
	btst       #3,d3
	bne.s      _OutStr9
	add.w      d0,d4
	movea.l    a2,a0
	bsr.s      OutBlank
_OutStr9:
	move.w     8(a7),d0
	beq.s      _OutStr10
	add.w      d0,d4
	lea.l      6(a7),a0
	jsr        (a2)
_OutStr10:
	move.w     4(a7),d0
	beq.s      _OutStr11
	add.w      d0,d4
	movea.l    a2,a0
	bsr.s      OutZero
_OutStr11:
	move.w     22(a7),d0
	beq.s      _OutStr12
	add.w      d0,d4
	lea.l      10(a7),a0
	jsr        (a2)
_OutStr12:
	move.w     2(a7),d0
	beq.s      _OutStr13
	btst       #3,d3
	beq.s      _OutStr13
	add.w      d0,d4
	movea.l    a2,a0
	bsr.s      OutBlank
_OutStr13:
	move.w     d4,d0
	lea.l      24(a7),a7
	movem.l    (a7)+,d3-d4/a2
	rts

OutZero:
	movem.l    d3-d4/a2-a3,-(a7)
	lea.l      zeroes(pc),a2
	bra.s      OutBlank1

OutBlank:
	movem.l    d3-d4/a2-a3,-(a7)
	lea.l      blanks(pc),a2
OutBlank1:
	movea.l    a0,a3
	move.w     d0,d3
	beq.s      OutBlank4
	move.w     d0,d4
	lsr.w      #3,d3
	beq.s      OutBlank3
	subq.w     #1,d3
OutBlank2:
	movea.l    a2,a0
	moveq.l    #8,d0
	jsr        (a3)
	dbf        d3,OutBlank2
OutBlank3:
	movea.l    a2,a0
	move.w     d4,d0
	and.w      #7,d0
	beq.s      OutBlank4
	jsr        (a3)
OutBlank4:
	movem.l    (a7)+,d3-d4/a2-a3
	rts

zeroes: .ascii "00000000"
blanks: .ascii "        "

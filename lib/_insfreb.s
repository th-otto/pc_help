	.include "malloc.i"

	.globl _InsFreB

	.xref _MemCluL

	.text

_InsFreB:
	movem.l    a2-a3,-(a7)
	move.l     #(8192),d2
	lea.l      -8(a0),a1
	lea.l      _MemCluL,a2
	move.l     (a2),d0
	beq        _InsFreB13
_InsFreB1:
	move.l     a1,d1
	sub.l      d0,d1
	cmp.l      d2,d1
	bls.s      _InsFreB2
	movea.l    d0,a2
	move.l     (a2),d0
	bne.s      _InsFreB1
	bra        _InsFreB13
_InsFreB2:
	movea.l    d0,a3
	move.l     4(a3),d0
	beq.s      _InsFreB3
	cmpa.l     d0,a0
	bhi.s      _InsFreB5
	move.l     a0,d1
	add.l      4(a0),d1
	cmp.l      d0,d1
	bcs.s      _InsFreB3
	beq.s      _InsFreB4
	bra        _InsFreB13
_InsFreB3:
	move.l     d0,(a0)
	move.l     a0,4(a3)
	bra.s      _InsFreB11
_InsFreB4:
	movea.l    d0,a1
	move.l     4(a1),d1
	add.l      d1,4(a0)
	move.l     (a1),(a0)
	move.l     a0,4(a3)
	bra.s      _InsFreB10
_InsFreB5:
	movea.l    d0,a1
	move.l     (a1),d0
	beq.s      _InsFreB6
	cmpa.l     d0,a0
	bhi.s      _InsFreB5
_InsFreB6:
	move.l     a1,d1
	add.l      4(a1),d1
	cmp.l      a0,d1
	bcs.s      _InsFreB8
	beq.s      _InsFreB7
	bra.s      _InsFreB13
_InsFreB7:
	move.l     4(a0),d1
	add.l      d1,4(a1)
	bra.s      _InsFreB9
_InsFreB8:
	move.l     a0,(a1)
	move.l     d0,(a0)
	movea.l    a0,a1
_InsFreB9:
	move.l     a1,d1
	add.l      4(a1),d1
	cmp.l      d0,d1
	bne.s      _InsFreB10
	movea.l    d0,a0
	move.l     4(a0),d1
	add.l      d1,4(a1)
	move.l     (a0),(a1)
_InsFreB10:
	movea.l    4(a3),a0
	cmpi.l     #(8192+8),4(a0)
	bcs.s      _InsFreB11
	bhi.s      _InsFreB13
	move.l     (a3),(a2)
	move.l     a3,-(a7)
	move.w     #73,-(a7) /* Mfree */
	trap       #1
	addq.w     #6,a7
	tst.l      d0
	bne.s      _InsFreB13
_InsFreB11:
	sf         d0
_InsFreB12:
	movem.l    (a7)+,a2-a3
	rts
_InsFreB13:
	st         d0
	bra.s      _InsFreB12

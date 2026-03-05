	.include "time.i"

/* time_t _cnvDatSec(struct tm *tm) */

	.globl _cnvDatSec

	.xref _monDaySum

	.text

_cnvDatSec:
	movem.l    d3-d4/a2,-(a7)
	movea.l    a0,a2
	moveq.l    #-70,d0
	add.w      TM_year(a2),d0
	move.w     TM_mon(a2),d1
	bra.s      _cnvDatSec2
_cnvDatSec1:
	subq.w     #1,d0
	add.w      #12,d1
_cnvDatSec2:
	tst.w      d1
	bmi.s      _cnvDatSec1
	bra.s      _cnvDatSec4
_cnvDatSec3:
	addq.w     #1,d0
	sub.w      #12,d1
_cnvDatSec4:
	cmp.w      #12,d1
	bge.s      _cnvDatSec3
	tst.w      d0
	bpl.s      _cnvDatSec5
	moveq.l    #-1,d0
	bra.s      _cnvDatSec7
_cnvDatSec5:
	moveq.l    #1,d2
	add.w      d0,d2
	asr.w      #2,d2
	move.w     d0,d3
	muls.w     #365,d3
	add.w      d2,d3
	move.w     d1,d4
	ext.l      d4
	add.l      d4,d4
	lea.l      _monDaySum,a0
	add.w      0(a0,d4.l),d3
	add.w      TM_mday(a2),d3
	subq.w     #1,d3
	moveq.l    #2,d2
	add.w      d0,d2
	and.w      #3,d2
	bne.s      _cnvDatSec6
	cmp.w      #2,d1
	blt.s      _cnvDatSec6
	addq.w     #1,d3
_cnvDatSec6:
	move.w     d3,d1
	ext.l      d1
	move.l     d1,d0
	add.l      d0,d0
	add.l      d1,d0
	lsl.l      #3,d0
	move.w     TM_hour(a2),d2
	ext.l      d2
	add.l      d2,d0
	move.l     d0,d3
	move.l     d0,d1
	lsl.l      #4,d1
	sub.l      d0,d1
	lsl.l      #2,d1
	move.w     TM_min(a2),d4
	ext.l      d4
	add.l      d4,d1
	move.l     d1,d3
	move.l     d1,d2
	lsl.l      #4,d2
	sub.l      d1,d2
	lsl.l      #2,d2
	move.w     TM_sec(a2),d0
	ext.l      d0
	add.l      d0,d2
	move.l     d2,d0
_cnvDatSec7:
	movem.l    (a7)+,d3-d4/a2
	rts

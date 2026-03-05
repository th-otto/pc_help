	.include "time.i"

/* struct tm *_conSecDat(time_t t, int local) */

	.globl _conSecDat

	.xref _monDayLen
	.xref _ldiv
	.xref _lmod
	.xref daylight

	.bss

tm: ds.b TM_sizeof

	.text

DAYS_PER_4YEARS = 365*4+1
HOURS_PER_4YEARS = DAYS_PER_4YEARS*24

_conSecDat:
	movem.l    d3-d5/a2,-(a7)
	move.l     d0,d3
	move.w     d1,d5
	tst.l      d0
	bpl.s      _conSecDat1
	moveq.l    #0,d3
_conSecDat1:
	lea.l      tm,a2
	move.l     d3,d0
	moveq.l    #60,d1
	bsr.w      _lmod
	move.w     d0,TM_sec(a2)
	move.l     d3,d0
	moveq.l    #60,d1
	bsr.w      _ldiv
	move.l     d0,d3
	moveq.l    #60,d1
	bsr.w      _lmod
	move.w     d0,TM_min(a2)
	move.l     d3,d0
	moveq.l    #60,d1
	bsr.w      _ldiv
	move.l     d0,d3
	move.l     #HOURS_PER_4YEARS,d1
	bsr.w      _ldiv
	move.w     d0,d1
	lsl.w      #2,d1
	add.w      #70,d1
	move.w     d1,TM_year(a2)
	move.w     d0,d4
	muls.w     #DAYS_PER_4YEARS,d4
	move.l     d3,d0
	move.l     #HOURS_PER_4YEARS,d1
	bsr.w      _lmod
	move.l     d0,d3
_conSecDat2:
	move.w     #365*24,d0
	moveq.l    #3,d1
	and.w      TM_year(a2),d1
	bne.s      _conSecDat3
	add.w      #24,d0
_conSecDat3:
	move.w     d0,d1
	ext.l      d1
	cmp.l      d1,d3
	blt.s      _conSecDat4
	divs.w     #24,d1
	add.w      d1,d4
	addq.w     #1,TM_year(a2)
	move.w     d0,d2
	ext.l      d2
	sub.l      d2,d3
	bra.s      _conSecDat2
_conSecDat4:
	tst.w      d5
	beq.s      _conSecDat5
	move.w     daylight,d0
	beq.s      _conSecDat5
	addq.l     #1,d3
	move.w     #1,TM_isdst(a2)
	bra.s      _conSecDat6
_conSecDat5:
	clr.w      TM_isdst(a2)
_conSecDat6:
	move.l     d3,d0
	moveq.l    #24,d1
	bsr.w      _lmod
	move.w     d0,TM_hour(a2)
	move.l     d3,d0
	moveq.l    #24,d1
	bsr.w      _ldiv
	move.l     d0,d3
	move.w     d3,TM_yday(a2)
	moveq.l    #4,d1
	add.w      d3,d1
	add.w      d1,d4
	move.w     d4,d2
	ext.l      d2
	divs.w     #7,d2
	swap       d2
	move.w     d2,TM_wday(a2)
	addq.l     #1,d3
	moveq.l    #3,d0
	and.w      TM_year(a2),d0
	bne.s      _conSecDat8
	moveq.l    #60,d1
	cmp.l      d3,d1
	bge.s      _conSecDat7
	subq.l     #1,d3
	bra.s      _conSecDat8
_conSecDat7:
	moveq.l    #60,d0
	cmp.l      d3,d0
	bne.s      _conSecDat8
	move.w     #1,TM_mon(a2)
	move.w     #29,TM_mday(a2)
	bra.s      _conSecDat11
_conSecDat8:
	clr.w      TM_mon(a2)
	lea.l      _monDayLen,a0
	bra.s      _conSecDat10
_conSecDat9:
	move.w     TM_mon(a2),d0
	move.b     0(a0,d0.w),d1
	ext.w      d1
	ext.l      d1
	sub.l      d1,d3
	addq.w     #1,TM_mon(a2)
_conSecDat10:
	move.w     TM_mon(a2),d0
	move.b     0(a0,d0.w),d1
	ext.w      d1
	ext.l      d1
	cmp.l      d1,d3
	bgt.s      _conSecDat9
	move.w     d3,TM_mday(a2)
_conSecDat11:
	movea.l    a2,a0
	movem.l    (a7)+,d3-d5/a2
	rts

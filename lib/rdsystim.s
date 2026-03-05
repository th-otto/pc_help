	.include "time.i"

/* void _rdSysTim(struct tm *tm); */

	.globl _rdSysTim

	.text

_rdSysTim:
	move.l     a2,-(a7)
	move.l     a6,-(a7)
	movea.l    a0,a6
	move.w     #44,-(a7) /* Tgettime */
	trap       #1
	move.w     d0,(a7)
	move.w     #42,-(a7) /* Tgetdate */
	trap       #1
	addq.l     #2,a7
	swap       d0
	move.w     (a7)+,d0
	move.b     d0,d1
	and.w      #31,d1
	add.w      d1,d1
	move.w     d1,TM_sec(a6)
	lsr.l      #5,d0
	move.b     d0,d1
	and.w      #63,d1
	move.w     d1,TM_min(a6)
	lsr.l      #6,d0
	move.b     d0,d1
	and.w      #31,d1
	move.w     d1,TM_hour(a6)
	lsr.l      #5,d0
	move.b     d0,d1
	and.w      #31,d1
	move.w     d1,TM_mday(a6)
	lsr.w      #5,d0
	move.b     d0,d1
	and.w      #15,d1
	subq.w     #1,d1
	move.w     d1,TM_mon(a6)
	lsr.w      #4,d0
	move.b     d0,d1
	and.w      #127,d1
	add.w      #80,d1
	move.w     d1,TM_year(a6)
	move.l     (a7)+,a6
	move.l     (a7)+,a2
	rts

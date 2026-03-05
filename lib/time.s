	.include "time.i"

	.globl time

/* time_t time(time_t *tloc); */

	.xref _cnvDatSec
	.xref _rdSysTim
	.xref timezone
	.xref daylight

	.text

time:
	move.l     a3,-(a7)
	lea.l      -TM_sizeof(a7),a7
	movea.l    a0,a3
	lea.l      (a7),a0
	bsr.w      _rdSysTim
	cmpi.w     #138,TM_year(a7)
	ble.s      time1
	move.w     #80,TM_year(a7)
	clr.w      TM_sec(a7)
	clr.w      TM_min(a7)
	clr.w      TM_hour(a7)
	move.w     #1,TM_mday(a7)
	clr.w      TM_mon(a7)
time1:
	lea.l      (a7),a0
	bsr.w      _cnvDatSec
	move.w     daylight,d1
	beq.s      time2
	sub.l      #3600,d0
time2:
	sub.l      timezone,d0
	move.l     a3,d1
	beq.s      time3
	move.l     d0,(a3)
time3:
	lea.l      TM_sizeof(a7),a7
	movea.l    (a7)+,a3
	rts

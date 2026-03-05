	.include "stdio.i"

/* int _FlshBuf(FILE *stream); */
	
	.globl _FlshBuf
	
	.xref lseek
	.xref write

	.text
	
_FlshBuf:
	movem.l    d3/a3-a4,-(a7)
	movea.l    a0,a3
	movea.l    FILE_BufStart(a3),a4
	move.w     FILE_Handle(a3),d3
	move.l     FILE_BufLvl(a3),d1
	sub.l      a4,d1
	beq.s      _FlshBuf1
	move.w     d3,d0
	neg.l      d1
	moveq.l    #1,d2
	bsr.w      lseek
	tst.l      d0
	bmi        _FlshBuf8
_FlshBuf1:
	btst       #_FIOBIN,FILE_Flags(a3)
	bne.s      _FlshBuf5
	move.l     FILE_BufPtr(a3),d1
	sub.l      a4,d1
	subq.l     #1,d1
	movea.l    a4,a1
	movea.l    a1,a0
	moveq.l    #10,d0
_FlshBuf2:
	cmp.b      (a1)+,d0
	beq.s      _FlshBuf3
	subq.l     #1,d1
	bpl.s      _FlshBuf2
	bra.s      _FlshBuf4
_FlshBuf3:
	move.b     #13,-1(a1)
	move.l     d1,-(a7)
	move.l     a1,-(a7)
	move.l     a1,d1
	sub.l      a0,d1
	move.w     d3,d0
	bsr.w      write
	movea.l    (a7)+,a1
	move.l     (a7)+,d1
	tst.l      d0
	bmi.s      _FlshBuf8
	beq.s      _FlshBuf9
	lea.l      -1(a1),a0
	moveq.l    #10,d0
	move.b     d0,(a0)
	subq.l     #1,d1
	bpl.s      _FlshBuf2
_FlshBuf4:
	movem.l    d1/a0-a1,-(a7)
	move.l     a1,d1
	sub.l      a0,d1
	move.w     d3,d0
	bsr.w      write
	movem.l    (a7)+,d1/a0-a1
	tst.l      d0
	bmi.s      _FlshBuf8
	beq.s      _FlshBuf9
	bra.s      _FlshBuf6
_FlshBuf5:
	move.w     d3,d0
	move.l     FILE_BufPtr(a3),d1
	sub.l      a4,d1
	movea.l    a4,a0
	bsr.w      write
	tst.l      d0
	bmi.s      _FlshBuf8
	beq.s      _FlshBuf9
_FlshBuf6:
	move.l     a4,FILE_BufPtr(a3)
	move.l     a4,FILE_BufLvl(a3)
	bclr       #_FIODIRTY,FILE_Flags(a3)
	clr.w      d0
_FlshBuf7:
	movem.l    (a7)+,d3/a3-a4
	rts
_FlshBuf8:
	moveq.l    #-1,d0
	bra.s      _FlshBuf7
_FlshBuf9:
	moveq.l    #1,d0
	bra.s      _FlshBuf7

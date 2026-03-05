	.globl _FreeAll
	.xref _MemBlkL
	.xref _MemCluL
	
	.text

_FreeAll:
	move.l     a3,-(a7)
	lea        _MemBlkL,a3
_FreeAll1:
	move.l     a3,d0
	beq.s      _FreeAll2
	move.l     a3,-(a7)
	movea.l    (a3),a3
	move.w     #73,-(a7) /* Mfree */
	trap       #1
	addq.w     #6,a7
	bra.s      _FreeAll1
_FreeAll2:
	lea        _MemCluL,a3
_FreeAll3:
	move.l     a3,d0
	beq.s      _FreeAll4
	move.l     a3,-(a7)
	movea.l    (a3),a3
	move.w     #73,-(a7) /* Mfree */
	trap       #1
	addq.w     #6,a7
	bra.s      _FreeAll3
_FreeAll4:
	movea.l    (a7)+,a3
	rts

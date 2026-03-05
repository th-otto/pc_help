	.globl _RemoveT

/* void _RemoveT(FILE *stream); */
	
	.xref _TmpFile
	.xref remove
	.xref free

	.text

_RemoveT:
	pea.l      (a2)
	move.l     a0,d0
	lea.l      _TmpFile,a1
	movea.l    (a1),a2
	bra.s      _RemoveT2
_RemoveT1:
	movea.l    a2,a1
	movea.l    (a2),a2
_RemoveT2:
	move.l     a2,d1
	beq.s      _RemoveT3
	cmp.l      4(a2),d0
	bne.s      _RemoveT1
	move.l     (a2),(a1)
	lea.l      8(a2),a0
	bsr.w      remove
	movea.l    a2,a0
	bsr.w      free
_RemoveT3:
	movea.l    (a7)+,a2
	rts

	.globl qsort
	.xref _uldiv
	.xref _ulmul

/* void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *)) */

	.text

swap:
	move.b     (a1),d1
	move.b     (a0),(a1)+
	move.b     d1,(a0)+
	subq.l     #1,d0
	bne.s      swap
	rts

__qsort:
	movem.l    d3-d5/a2-a5,-(a7)
	movea.l    a0,a3
	move.l     d0,d3
	movea.l    a1,a2
	move.l     d1,d4
_qsort1:
	moveq.l    #2,d0
	cmp.l      d3,d0
	bcs.s      _qsort2
	cmp.l      d3,d0
	bne        _qsort18
	lea.l      0(a3,d4.l),a4
	movea.l    a4,a1
	movea.l    a3,a0
	jsr        (a2)
	tst.w      d0
	ble        _qsort18
	move.l     d4,d0
	movea.l    a4,a1
	movea.l    a3,a0
	jsr        swap(pc)
	bra        _qsort18
_qsort2:
	moveq.l    #-1,d0
	add.l      d3,d0
	move.l     d4,d1
	jsr        _ulmul(pc)
	lea.l      0(a3,d0.l),a4
	move.l     d3,d0
	lsr.l      #1,d0
	move.l     d4,d1
	jsr        _ulmul(pc)
	lea.l      0(a3,d0.l),a5
	movea.l    a4,a1
	movea.l    a5,a0
	jsr        (a2)
	tst.w      d0
	ble.s      _qsort3
	move.l     d4,d0
	movea.l    a4,a1
	movea.l    a5,a0
	jsr        swap(pc)
_qsort3:
	movea.l    a3,a1
	movea.l    a5,a0
	jsr        (a2)
	tst.w      d0
	ble.s      _qsort4
	move.l     d4,d0
	movea.l    a3,a1
	movea.l    a5,a0
	jsr        swap(pc)
	bra.s      _qsort5
_qsort4:
	movea.l    a4,a1
	movea.l    a3,a0
	jsr        (a2)
	tst.w      d0
	ble.s      _qsort5
	move.l     d4,d0
	movea.l    a4,a1
	movea.l    a3,a0
	jsr        swap(pc)
_qsort5:
	moveq.l    #3,d0
	cmp.l      d3,d0
	bne.s      _qsort6
	movea.l    a5,a1
	movea.l    a3,a0
	move.l     d4,d0
	jsr        swap(pc)
	bra        _qsort18
_qsort6:
	lea.l      0(a3,d4.l),a5
	bra.s      _qsort8
_qsort7:
	cmpa.l     a5,a4
	bls.s      _qsort13
	adda.l     d4,a5
_qsort8:
	movea.l    a3,a1
	movea.l    a5,a0
	jsr        (a2)
	tst.w      d0
	blt.s      _qsort7
	bra.s      _qsort11
_qsort9:
	movea.l    a4,a1
	movea.l    a3,a0
	jsr        (a2)
	tst.w      d0
	bgt.s      _qsort10
	suba.l     d4,a4
	bra.s      _qsort11
_qsort10:
	move.l     d4,d0
	movea.l    a4,a1
	movea.l    a5,a0
	jsr        swap(pc)
	adda.l     d4,a5
	suba.l     d4,a4
	bra.s      _qsort12
_qsort11:
	cmpa.l     a5,a4
	bhi.s      _qsort9
_qsort12:
	cmpa.l     a5,a4
	bhi.s      _qsort8
_qsort13:
	movea.l    a3,a1
	movea.l    a5,a0
	jsr        (a2)
	tst.w      d0
	bge.s      _qsort14
	move.l     d4,d0
	movea.l    a3,a1
	movea.l    a5,a0
	jsr        swap(pc)
_qsort14:
	move.l     a5,a0
	sub.l      a3,a0
	moveq      #0,d0
	move.w     a0,d0 /* BUG: truncated */
	move.l     d4,d1
	jsr        _uldiv(pc)
	move.l     d0,d5
	sub.l      d5,d3
	cmp.l      d3,d5
	bls.s      _qsort16
	moveq.l    #1,d1
	cmp.l      d3,d1
	bcc.s      _qsort15
	movea.l    a2,a1
	movea.l    a5,a0
	move.l     d3,d0
	move.l     d4,d1
	jsr        __qsort(pc)
_qsort15:
	move.l     d5,d3
	bra        _qsort1
_qsort16:
	moveq.l    #1,d0
	cmp.l      d5,d0
	bcc.s      _qsort17
	move.l     d4,d1
	movea.l    a2,a1
	movea.l    a3,a0
	move.l     d5,d0
	jsr        __qsort(pc)
_qsort17:
	movea.l    a5,a3
	bra        _qsort1
_qsort18:
	movem.l    (a7)+,d3-d5/a2-a5
	rts

qsort:
	tst.l      d1
	beq.s      qsort1
	jsr        __qsort(pc)
qsort1:
	rts

	.include "malloc.i"

/* void free(void *ptr); */

	.globl free

	.xref _InsFreB
	.xref _MemBlkL

	.text

free:
	move.l     a0,d0
	ble.s      free6
	subq.l     #malloc_sizeof,a0
	cmpi.l     #4096,4(a0)
	bcc.s      free1
	cmpi.l     #VAL_ALLOC,(a0)
	bne.s      free7
	bsr.w      _InsFreB
	tst.b      d0
	beq.s      free4
	bra.s      free7
free1:
	lea.l      _MemBlkL,a1
	move.l     (a1),d0
	beq.s      free7
free2:
	cmp.l      a0,d0
	beq.s      free3
	movea.l    d0,a1
	move.l     (a1),d0
	bne.s      free2
	bra.s      free7
free3:
	move.l     (a0),(a1)
	move.l     a0,-(a7)
	move.w     #73,-(a7) /* Mfree */
	trap       #1
	addq.w     #6,a7
	tst.l      d0
	bpl.s      free4
	bra.s      free7
free4:
	moveq.l    #0,d0
free5:
	rts
free6:
	cmpa.l     #MALLOC_ERR,a0
	beq.s      free4
free7:
	moveq.l    #-1,d0
	bra.s      free5

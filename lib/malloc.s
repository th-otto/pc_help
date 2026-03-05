	.include "malloc.i"
	.include "errno.i"

/* void *malloc(size_t size); */

	.globl malloc
	
	.xref _heapErr
	.xref _MemBlkL
	.xref _MemCluL
	.xref errno

	.text

malloc:
	move.l     d3,-(a7)
	move.l     a2,-(a7)
	move.l     d0,d3
	beq        malloc10
	addq.l     #8,d3
	addq.l     #1,d3
	and.b      #-2,d3
	cmp.l      #(4096),d3
	bcs.s      malloc1
	move.l     #-1,-(a7)
	move.w     #72,-(a7) ; Malloc
	trap       #1
	addq.w     #6,a7
	cmp.l      d3,d0
	bmi        malloc11
	move.l     d3,-(a7)
	move.w     #72,-(a7) ; Malloc
	trap       #1
	addq.w     #6,a7
	tst.l      d0
	ble        malloc11
	movea.l    d0,a0
	move.l     d3,4(a0)
	lea.l      _MemBlkL,a1
	move.l     (a1),(a0)
	move.l     a0,(a1)
	lea.l      8(a0),a0
	bra.s      malloc9
malloc1:
	lea.l      _MemCluL,a2
malloc2:
	movea.l    (a2),a2
	move.l     a2,d0
	bne.s      malloc3
	move.l     #8192+16,-(a7)
	move.w     #72,-(a7) ; Malloc
	trap       #1
	addq.w     #6,a7
	tst.l      d0
	ble.s      malloc11
	movea.l    d0,a2
	lea.l      8(a2),a0
	moveq.l    #0,d0
	move.l     d0,(a0)
	move.l     #(8192+8),4(a0)
	move.l     a0,4(a2)
	move.l     _MemCluL,(a2)
	move.l     a2,_MemCluL
malloc3:
	lea.l      4(a2),a0
	movea.l    (a0),a1
	bra.s      malloc5
malloc4:
	move.l     4(a1),d0
	sub.l      d3,d0
	bcc.s      malloc6
	movea.l    a1,a0
	movea.l    (a1),a1
malloc5:
	move.l     a1,d0
	bne.s      malloc4
	bra.s      malloc2
malloc6:
	moveq.l    #16,d1
	cmp.l      d1,d0
	bcc.s      malloc7
	move.l     (a1),(a0)
	bra.s      malloc8
malloc7:
	move.l     d0,4(a1)
	adda.l     d0,a1
	move.l     d3,4(a1)
malloc8:
	move.l     #VAL_ALLOC,(a1)
	lea.l      8(a1),a0
malloc9:
	movea.l    (a7)+,a2
	move.l     (a7)+,d3
	rts
malloc10:
	bmi.s      malloc11
	movea.l    #MALLOC_ERR,a0
	bra.s      malloc9
malloc11:
	suba.l     a0,a0
	move.w     #ENOMEM,errno
	bra.s      malloc9

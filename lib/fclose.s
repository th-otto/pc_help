	.include "stdio.i"
	.include "errno.i"
	
	.globl fclose
	
	.xref errno
	.xref close
	.xref free
	.xref _RemoveT
	.xref _FlshBuf

	.text
	
fclose:
	move.l     a3,-(a7)
	movea.l    a0,a3
	btst       #_FIODIRTY,FILE_Flags(a3)
	beq.s      fclose1
	btst       #_FIOWRITE,FILE_Flags(a3)
	beq.s      fclose4
	bsr.w      _FlshBuf
	tst.w      d0
	bne.s      fclose5
fclose1:
	move.w     FILE_Handle(a3),d0
	bsr.w      close
	tst.w      d0
	bmi.s      fclose5
	btst       #_FIOBUF,FILE_Flags(a3)
	beq.s      fclose2
	movea.l    FILE_BufStart(a3),a0
	bsr.w      free
fclose2:
	clr.w      d0
	move.w     d0,FILE_Flags(a3)
fclose3:
	movea.l    (a7)+,a3
	rts
fclose4:
	move.w     #EACCES,errno
fclose5:
	bset       #_FIOERR,FILE_Flags(a3)
	moveq.l    #-1,d0
	bra.s      fclose3

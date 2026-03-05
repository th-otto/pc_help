	.globl strupr

/* char *strupr(char *string); */
	
	.xref _UpcTab

	.text

strupr:
	move.l     a0,d1
	lea.l      _UpcTab(pc),a1
	clr.w      d0
strupr1:
	move.b     (a0),d0
	move.b     0(a1,d0.w),(a0)+
	bne.s      strupr1
	movea.l    d1,a0
	rts

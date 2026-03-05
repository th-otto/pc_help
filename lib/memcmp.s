	.globl memcmp

	.text

memcmp:
	subq.l     #1,d0
	bcs.s      memcmp2
	cmpm.b     (a1)+,(a0)+
	beq.s      memcmp
	bcs.s      memcmp1
	moveq.l    #1,d0
	rts
memcmp1:
	moveq.l    #-1,d0
	rts
memcmp2:
	moveq.l    #0,d0
	rts

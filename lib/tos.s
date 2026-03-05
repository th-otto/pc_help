
	GLOBL Fread
	MODULE Fread
		movem.l    d0-d1/a0/a2,-(a7)
		move.w     #$003F,(a7)
		trap       #1
		lea.l      12(a7),a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Fsetdta
	MODULE Fsetdta
		move.l     a2,-(a7)
		move.l     a0,-(a7)
		move.w     #$001A,-(a7)
		trap       #1
		addq.w     #6,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Fsfirst
	MODULE Fsfirst
		move.l     a2,-(a7)
		move.w     d0,-(a7)
		move.l     a0,-(a7)
		move.w     #$004E,-(a7)
		trap       #1
		addq.w     #8,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Fsnext
	MODULE Fsnext
		move.l     a2,-(a7)
		move.w     #$004F,-(a7)
		trap       #1
		addq.w     #2,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Crawio
	MODULE Crawio
		move.l     a2,-(a7)
		move.w     d0,-(a7)
		move.w     #$0006,-(a7)
		trap       #1
		addq.w     #4,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD

	GLOBL Fclose
	MODULE Fclose
		move.l     a2,-(a7)
		move.w     d0,-(a7)
		move.w     #$003E,-(a7)
		trap       #1
		addq.w     #4,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD

	
	GLOBL Cconws
	MODULE Cconws
		move.l     a2,-(a7)
		move.l     a0,-(a7)
		move.w     #$0009,-(a7) ; Cconws
		trap       #1
		addq.w     #6,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Dcreate
	MODULE Dcreate
		move.l     a2,-(a7)
		move.l     a0,-(a7)
		move.w     #$0039,-(a7)
		trap       #1
		addq.w     #6,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Malloc
	MODULE Malloc
		move.l     a2,-(a7)
		move.l     d0,-(a7)
		move.w     #$0048,-(a7)
		trap       #1
		addq.w     #6,a7
		movea.l    d0,a0
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Mshrink
	MODULE Mshrink
		move.l     a2,-(a7)
		move.l     d1,-(a7)
		move.l     a0,-(a7)
		move.w     d0,-(a7)
		move.w     #$004A,-(a7)
		trap       #1
		lea.l      12(a7),a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Fwrite
	MODULE Fwrite
		movem.l    d0-d1/a0/a2,-(a7)
		move.w     #$0040,(a7)
		trap       #1
		lea.l      12(a7),a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Super
	MODULE Super
		move.l     a2,-(a7)
		move.l     a0,-(a7)
		move.w     #$0020,-(a7)
		trap       #1
		addq.w     #6,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Fcreate
	MODULE Fcreate
		move.l     a2,-(a7)
		move.w     d0,-(a7)
		move.l     a0,-(a7)
		move.w     #$003C,-(a7)
		trap       #1
		addq.w     #8,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Fopen
	MODULE Fopen
		move.l     a2,-(a7)
		move.w     d0,-(a7)
		move.l     a0,-(a7)
		move.w     #$003D,-(a7)
		trap       #1
		addq.w     #8,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Mfree
	MODULE Mfree
		move.l     a2,-(a7)
		move.l     a0,-(a7)
		move.w     #$0049,-(a7)
		trap       #1
		addq.w     #6,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Logbase
	MODULE Logbase
		move.l     a2,-(a7)
		move.w     #$0003,-(a7)
		trap       #14
		addq.w     #2,a7
		movea.l    d0,a0
		movea.l    (a7)+,a2
		rts
	ENDMOD


	GLOBL Blitmode
	MODULE Blitmode
		move.l     a2,-(a7)
		move.w     d0,-(a7)
		move.w     #$0040,-(a7)
		trap       #14
		addq.w     #4,a7
		movea.l    (a7)+,a2
		rts
	ENDMOD


				GLOBL	Psignal
				MODULE	Psignal
				pea		(a2)
				pea     (a0)
				move.w	d0,-(a7)
				move.w	#$112,-(a7)
				trap	#1
				addq.l	#8,a7
				move.l	d0,a0
				move.l	(a7)+,a2
				rts
				ENDMOD
				
				GLOBL	Psigreturn
				MODULE	Psigreturn
				pea		(a2)
				move.w	#$11a,-(a7)
				trap	#1
				addq.l	#2,a7
				move.l	(a7)+,a2
				rts
				ENDMOD
				

				GLOBL	Supexec
				MODULE	Supexec				
				pea     (a2)
				pea     (a0)
				move.w	#$26,-(a7)
				trap	#14
				addq.w	#6,a7
				movea.l	(a7)+,a2
				rts
				ENDMOD

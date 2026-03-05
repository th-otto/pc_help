	.include "stdio.i"
	.include "errno.i"

	.globl freopen

	.xref fclose
	.xref malloc
	.xref free
	.xref _FilTab
	.xref _FilSysVec
	.xref open
	.xref errno
	.xref _StdOutF
	.xref _StdErrF
	.xref unlink
	.xref _TmpFilF

	.text

freopen:
	movem.l    d3/a3-a4,-(a7)
	movea.l    a0,a3
	movea.l    16(a7),a4
	movea.l    a1,a0
	bsr        getmode
	move.w     d0,d3
	bmi.s      freopen5
	move.l     a4,d0
	beq.s      freopen0
	movea.l    a4,a0
	bsr.w      fclose
	bra.s      freopen1
freopen0:
	bsr        searchfil
	tst.b      d0
	bne        freopen6
	movea.l    a0,a4
freopen1:
	move.l     #BUFSIZ,d0
	bsr.w      malloc
	move.l     a0,FILE_BufStart(a4)
	beq        freopen7
	move.w     d3,d0
	add.w      d0,d0
	move.w     modetab(pc,d0.w),d0
	movea.l    a3,a0
	bsr.w      open
	cmp.w      #-1,d0
	beq        freopen9
	move.w     d0,FILE_Handle(a4)
	move.b     flagtab(pc,d3.w),FILE_Flags(a4)
	sf         FILE_ungetFlag(a4)
	movea.l    FILE_BufStart(a4),a0
	move.l     a0,FILE_BufLvl(a4)
	move.l     a0,FILE_BufPtr(a4)
	adda.w     #BUFSIZ,a0
	move.l     a0,FILE_BufEnd(a4)
	lea.l      cleanfil(pc),a1
	move.l     a1,_FilSysVec
	movea.l    a4,a0
freopen4:
	movem.l    (a7)+,d3/a3-a4
	rts

freopen5:
	moveq.l    #EINVAL,d0
	bra.s      freopen8
freopen6:
	moveq.l    #EMFILE,d0
	bra.s      freopen8
freopen7:
	moveq.l    #ENOMEM,d0
freopen8:
	move.w     d0,errno
freopen9:
	movea.l    FILE_BufStart(a4),a0
	bsr.w      free
freopen10:
	suba.l     a0,a0
	bra.s      freopen4

modetab:
	.dc.w O_RDONLY
	.dc.w O_WRONLY+O_CREAT+O_TRUNC
	.dc.w O_WRONLY+O_CREAT+O_APPEND
	.dc.w O_RDWR
	.dc.w O_RDWR+O_CREAT+O_TRUNC
	.dc.w O_RDWR+O_CREAT+O_APPEND
	.dc.w O_RDONLY
	.dc.w O_WRONLY+O_CREAT+O_TRUNC
	.dc.w O_WRONLY+O_CREAT+O_APPEND
	.dc.w O_RDWR
	.dc.w O_RDWR+O_CREAT+O_TRUNC
	.dc.w O_RDWR+O_CREAT+O_APPEND

flagtab:
	.dc.b (1<<_FIOREAD)+(1<<_FIOBUF)
	.dc.b (1<<_FIOWRITE)+(1<<_FIOBUF)
	.dc.b (1<<_FIOWRITE)+(1<<_FIOBUF)
	.dc.b (1<<_FIOREAD)+(1<<_FIOWRITE)+(1<<_FIOBUF)
	.dc.b (1<<_FIOREAD)+(1<<_FIOWRITE)+(1<<_FIOBUF)
	.dc.b (1<<_FIOREAD)+(1<<_FIOWRITE)+(1<<_FIOBUF)
	.dc.b (1<<_FIOREAD)+(1<<_FIOBUF)+(1<<_FIOBIN)
	.dc.b (1<<_FIOWRITE)+(1<<_FIOBUF)+(1<<_FIOBIN)
	.dc.b (1<<_FIOWRITE)+(1<<_FIOBUF)+(1<<_FIOBIN)
	.dc.b (1<<_FIOREAD)+(1<<_FIOWRITE)+(1<<_FIOBUF)+(1<<_FIOBIN)
	.dc.b (1<<_FIOREAD)+(1<<_FIOWRITE)+(1<<_FIOBUF)+(1<<_FIOBIN)
	.dc.b (1<<_FIOREAD)+(1<<_FIOWRITE)+(1<<_FIOBUF)+(1<<_FIOBIN)

getmode:
	subq.w     #4,a7
	lea.l      (a7),a1
	clr.l      (a1)
	move.b     (a0)+,(a1)+
	move.b     (a0)+,(a1)+
	beq.s      getmode1
	move.b     (a0)+,(a1)+
	beq.s      getmode1
	move.b     (a0)+,(a1)+
getmode1:
	move.l     (a7),d0
	lea.l      modeidxtab(pc),a0
	moveq.l    #14,d1
	bra.s      getmode3
getmode2:
	addq.w     #2,a0
getmode3:
	cmp.l      (a0)+,d0
	dbeq       d1,getmode2
	bne.s      getmode5
	move.w     (a0),d0
getmode4:
	addq.w     #4,a7
	rts
getmode5:
	moveq.l    #-1,d0
	bra.s      getmode4

/* last element is index into modetab above */
modeidxtab:
	.dc.b 'r',0,0,0,0,0
	.dc.b 'w',0,0,0,0,1
	.dc.b 'a',0,0,0,0,2
	.dc.b 'r','+',0,0,0,3
	.dc.b 'w','+',0,0,0,4
	.dc.b 'a','+',0,0,0,5
	.dc.b 'r','b',0,0,0,6
	.dc.b 'w','b',0,0,0,7
	.dc.b 'a','b',0,0,0,8
	.dc.b 'r','+','b',0,0,9
	.dc.b 'r','b','+',0,0,9
	.dc.b 'w','+','b',0,0,10
	.dc.b 'w','b','+',0,0,10
	.dc.b 'a','+','b',0,0,11
	.dc.b 'a','b','+',0,0,11

searchfil:
	lea.l      _FilTab,a0
	moveq.l    #FOPEN_MAX-1,d0
	bra.s      searchfil2
searchfil1:
	lea.l      FILE_sizeof(a0),a0
searchfil2:
	moveq.l    #((1<<_FIOREAD)+(1<<_FIOWRITE)),d1
	and.b      FILE_Flags(a0),d1
	dbeq       d0,searchfil1
	sne        d0
	rts

cleanfil:
	move.w     d3,-(a7)
	move.l     a3,-(a7)
	lea.l      _StdOutF,a0
	bsr.w      fclose
	lea.l      _StdErrF,a0
	bsr.w      fclose
	lea.l      _FilTab,a3
	move.w     #FOPEN_MAX-1,d3
	bra.s      cleanfil2
cleanfil1:
	lea.l      FILE_sizeof(a3),a3
cleanfil2:
	moveq.l    #((1<<_FIOREAD)+(1<<_FIOWRITE)),d0
	and.b      FILE_Flags(a3),d0
	beq.s      cleanfil3
	movea.l    a3,a0
	bsr.w      fclose
cleanfil3:
	dbf        d3,cleanfil1
	tst.b      _TmpFilF
	beq.s      cleanfil4
	lea.l      _tmpname(pc),a0
	bsr        unlink
cleanfil4:

	movea.l    (a7)+,a3
	move.w     (a7)+,d3
	rts

_tmpname:
	.dc.b "_TMP_XXX.XXX",0,0

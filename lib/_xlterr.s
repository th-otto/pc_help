	.include "errno.i"

	.globl _XltErr

	.text

_XltErr:
	neg.w      d0
	sub.w      #32,d0
	cmp.w      #34,d0
	bhi.s      _XltErr1
	move.b     xlttbl(pc,d0.w),d0
	rts
_XltErr1:
	moveq.l    #EIO,d0
	rts

xlttbl:
	.dc.b EINVAL
	.dc.b ENOENT
	.dc.b ENOTDIR
	.dc.b EMFILE
	.dc.b EACCES
	.dc.b EBADF
	.dc.b EIO
	.dc.b ENOMEM
	.dc.b EINVMEM
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b ENODEV
	.dc.b EIO
	.dc.b EIO
	.dc.b ENOENT
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b EIO
	.dc.b ESPIPE
	.dc.b EIO
	.dc.b EPLFMT
	.dc.b ENOMEM

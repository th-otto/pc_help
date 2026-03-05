	.offset 0
FILE_BufPtr:    .ds.l 1
FILE_BufLvl:    .ds.l 1
FILE_BufStart:  .ds.l 1
FILE_BufEnd:    .ds.l 1
FILE_Handle:    .ds.w 1
FILE_Flags:     .ds.b 1
FILE_resv:      .ds.b 1
FILE_ChrBuf:    .ds.b 1
FILE_ungetFlag: .ds.b 1
FILE_sizeof:


_FIOREAD	= 0
_FIOWRITE	= 1
_FIOUNBUF	= 2
_FIOBUF		= 3
_FIOEOF		= 4
_FIOERR		= 5
_FIODIRTY	= 6
_FIOBIN		= 7

O_RDONLY    = 0x00
O_WRONLY    = 0x01
O_RDWR      = 0x02
O_APPEND    = 0x08
O_CREAT     = 0x20
O_TRUNC     = 0x40
O_EXCL      = 0x80

O_ACCMODE = (O_RDONLY+O_WRONLY+O_RDWR)

BUFSIZ = 1024

FOPEN_MAX = 32

_IOFBF      = 0
_IOLBF      = 1
_IONBF      = 2

L_tmpnam = 13

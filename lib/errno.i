EPERM   = 1       /* file permission denied     */
ENOENT  = 2       /* file not found             */
ESRCH	= 3	    /* No such process            */
EINTR	= 4	    /* Interrupted system call    */
EIO     = 5       /* general i/o error          */
ENXIO	= 6	    /* No such device or address  */
E2BIG   = 7       /* Argument list too long     */
/* #define ENOEXEC	8    / * Exec format error         */
EBADF   = 9       /* invalid file handle        */
EILLSPE = 10      /* illegal file specification */ /* should be ECHILD */
EINVMEM = 11      /* invalid heap block         */ /* should be EAGAIN */
ENOMEM  = 12      /* heap overflow              */
EACCES  = 13      /* file access mode error     */
EFAULT	= 14	    /* Bad address                */
ENOTBLK	= 15	    /* Bulk device r=ired       */
EBUSY	= 16	    /* Resource is busy           */
EEXIST  = 17      /* file already exists        */
EPLFMT  = 18      /* program load format error  */
ENODEV  = 19      /* device error               */
ENOTDIR = 20      /* path not found             */
EISDIR	= 21	    /* Is a directory 	          */
EINVAL  = 22      /* invalid parameter          */
ENFILE  = 23      /* file table overflow        */
EMFILE  = 24      /* too many open files        */
ENOTTY	= 25	    /* Not a terminal             */
ETXTBSY	= 26	    /* Text file is busy          */
EFBIG	= 27	    /* File is too large          */
ENOSPC  = 28      /* disk full                  */
ESPIPE  = 29      /* seek error                 */
EROFS   = 30      /* read only device           */
EMLINK	= 31	    /* Too many links             */
EPIPE	= 32	    /* Broken pipe                */
EDOM    = 33      /* domain error               */
ERANGE  = 34      /* range error                */
ENMFILE = 35      /* no more matching file      */ /* should be EDEADLK */

ENOEXEC = EPLFMT

sys_nerr = 35

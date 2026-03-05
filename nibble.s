	xref hc_putc

MAX_CODES equ 0x4679

	text

	xref screen_start
	xref hc_createfile
	xref hc_closeout
	xref hc_fread
	xref screenbuf_ptr
	xref screenbuf
	xref screen_cnt
	xref screen_table_offset
	xref hc_inbuf
	xref x163e2
	xref helphdr
	xref hclog
	xref hc_infile
	xref hc_flshbuf
	xref _lmod
	xref _StdErrF
	xref fprintf
	xref fputc

	globl write_compression_asm
write_compression_asm:
	movem.l    d3-d7/a2-a6,-(a7)
	subq.w     #8,a7
	clr.l      screen_start            /* screen_start = 0; */
	lea.l      hc_inbuf,a5
	lea.l      x163e2,a3               /* a3 = x163e2; */
	movea.l    (a3),a3 ; x163e2
	movea.l    screen_table_offset,a2  /* a2 = screen_table_offset; */
	lea.l      hc_tmp2,a0
	jsr        hc_createfile           /* hc_createfile(HC_TMP_COMPRESSED); */
	moveq.l    #0,d4                   /* i = 0; */
	move.w     screen_cnt,d6           /* d6 = screen_cnt * sizeof(uint32_t); */
	ext.l      d6
	lsl.l      #2,d6
	move.l     d6,(a7)                 /* for (i = 0; i < screen_cnt; i++ */
	bra        write_compression_1 
write_compression_16:
	move.l     4(a2,d4.l),d5           /*     screen_size = screen_table_offset[i + 1] - screen_table_offset[i]; */
	sub.l      0(a2,d4.l),d5
IFNE TEST_CODE
	movem.l    d2-d7/a2-a6,-(a7)
	move.l     d5,-(a7)
	move.l     0(a2,d4.l),-(a7)
	lsr.l      #2,d4
	move.l     d4,-(a7)
	lea        testcode_msg1(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        12(a7),a7
	/* input buffer may still contain garbage of previous screen */
	move.l     (a5),a0
	clr.b      0(a0,d5.l)
	clr.b      1(a0,d5.l)
	movem.l    (a7)+,d2-d7/a2-a6
ENDC	
	movea.l    hc_infile,a0            /*     if (hc_fread(hc_infile, screen_size, hc_inbuf) != screen_size) */
	movea.l    (a5),a1 ; hc_inbuf
	move.l     d5,d0
	jsr        hc_fread
	cmp.l      d5,d0
	beq.s      write_compression_2
	pea.l      tempfilename
	moveq.l    #5,d0 /* ERR_READ_ERROR */
	moveq.l    #0,d1
	jsr        hclog
	/* stack not corrected: hclog will exit() */
write_compression_2:
	movea.l    (a5),a6                 /*     a6 = hc_inbuf; */
	add.l      (a5),d5                 /*     inbuf_end = a6 + screen_size; */
	bra        write_compression_3     /*     while (a6 < inbuf_end) */
write_compression_15:                  /*     { */
	movea.l    a6,a4                   /*         a4 = a6; */
	moveq.l    #-1,d7                  /*         str_code = -1; */
	moveq.l    #0,d6  
	moveq.l    #0,d3
	move.b     (a4)+,d6                /*         prev_code = -*a4++; */
IFNE TEST_CODE
	movem.l    d2-d7/a2-a6,-(a7)
	move.w     d6,d0
	bsr        toprint
	move.w     d0,-(a7)
	move.w     d6,-(a7)
	lea        testcode_msg5(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        4(a7),a7
	movem.l    (a7)+,d2-d7/a2-a6
ENDC	
	neg.w      d6
write_compression_10:                  /*         do { */
	move.b     (a4)+,d3                /*             this_char = *a4++ */
	move.w     d3,d1                   /*             code = (this_char * 64) ^ prev_code; */
	lsl.w      #6,d1    
	eor.w      d6,d1
	moveq.l    #0,d0
	move.w     d1,d0
	move.l     #MAX_CODES,d1           /*             code = code % MAX_CODES; */
	jsr        _lmod
	lsl.l      #3,d0
	bne.s      write_compression_4     /*             if (code == 0) */
	moveq.l    #8,d1                   /*                 d1 = 1; */
	bra.s      write_compression_5
write_compression_4:                   /*             else */
	move.l     #MAX_CODES*8,d1         /*                 d1 = MAX_CODES - code; */
	sub.l      d0,d1
write_compression_5:                   /*             for (;;) { */
IFNE TEST_CODE
	movem.l    d0-d7/a2-a6,-(a7)
	moveq      #0,d1
	move.b     6(a3,d0.l),d1
	move.w     d1,-(a7)
	move.w     2(a3,d0.l),-(a7)
	lsr.l      #3,d0
	move.w     d0,-(a7)
	move.w     d3,d0
	bsr        toprint
	move.w     d0,-(a7)
	move.w     d3,-(a7)
	lea        testcode_msg6(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        10(a7),a7
	movem.l    (a7)+,d0-d7/a2-a6
ENDC	
	cmpi.w     #-256,2(a3,d0.l)        /*                 if (x163e2[code].prev_code == -256 ||
	                                                          (x163e2[code].prev_code == prev_code && x163e2[code].this_char == this_char)) */
	beq.s      write_compression_6     /*                     break; */
	cmp.w      2(a3,d0.l),d6
	bne.s      write_compression_7
	cmp.b      6(a3,d0.l),d3
	beq.s      write_compression_6
write_compression_7:
	sub.l      d1,d0                   /*                 code -= d1; */
	bge.s      write_compression_5     /*                 if (code < 0) */
	add.l      #MAX_CODES*8,d0         /*                    code += MAX_CODES; */
	bra.s      write_compression_5     /*             } */
write_compression_6:
	move.w     4(a3,d0.l),d1           /*             if (x163e2[code].str_code >= 0) */
	bmi.s      write_compression_8
	move.w     d1,d7                   /*                 str_code = 163e2[code].str_code; */
	move.l     d0,4(a7)                /*                 str_match = code; */ 
write_compression_8:
	move.l     d0,d6
	lsr.l      #3,d6                   /*             prev_code = code; */
	cmpi.w     #-1,4(a3,d0.l)          /*         } while (x163e2[code].str_code >= -1 && a4 < inbuf_end) */
	blt.s      write_compression_9
	cmpa.l     d5,a4
	bcs        write_compression_10
write_compression_9:
IFNE TEST_CODE
	movem.l    d2-d7/a2-a6,-(a7)
	move.l     a6,d0
	sub.l      hc_inbuf,d0
	move.l     d0,-(a7)
	move.l     a4,d0
	sub.l      hc_inbuf,d0
	move.l     d0,-(a7)
	move.w     d7,-(a7)
	move.w     d6,-(a7)
	lea        testcode_msg4(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        12(a7),a7
	movem.l    (a7)+,d2-d7/a2-a6
ENDC	
	tst.w      d7                      /*         if (str_code >= 0) { */
	bmi.s      write_compression_11
	moveq.l    #0,d1                   /*             a6 += x163e2[str_match].str_len; */
	move.l     4(a7),d0
	move.w     0(a3,d0.l),d1
	adda.l     d1,a6
	moveq.l    #13,d0                  /*             write_nibble(STR_TABLE); */
	bsr        write_nibble_asm
	move.w     d7,d0                   /*             write_nibble(str_code >> 8); */
	lsr.w      #8,d0
	bsr        write_nibble_asm
	move.b     d7,d0                   /*             write_nibble(str_code >> 4); */
	lsr.b      #4,d0
	bsr        write_nibble_asm
	move.b     d7,d0
	and.b      #0x0F,d0                /*             write_nibble(str_code & 0x0f); */
	bra.s      write_compression_12
write_compression_11:
	cmpi.b     #13,(a6)                /*         } else if (a6[0] == CR && a6[1] == NL) { */
	bne.s      write_compression_13
	cmpi.b     #10,1(a6)
	bne.s      write_compression_13
	addq.w     #2,a6                   /*             a6 += 2; */
	moveq.l    #14,d0                  /*             write_nibble(STR_NEWLINE); */
	bra.s      write_compression_12    /*         } else { */
write_compression_13:
	moveq.l    #11,d0
	lea.l      helphdr+100,a0
	move.b     (a6)+,d1                /*             c = *a6++ */
write_compression_14:
	cmp.b      0(a0,d0.w),d1           /*             if (c in helphdr.char_table); */
	beq.s      write_compression_12    /*                 write_nibble(index of c); */
	dbf        d0,write_compression_14
	moveq.l    #12,d0                  /*             else { */
	bsr.w      write_nibble_asm        /*                 write_nibble(CHAR_DIR); */
	moveq.l    #0,d0
	move.b     d1,d0                   /*                 write_nibble(c >> 4); */
	lsr.w      #4,d0
	bsr.w      write_nibble_asm
	moveq.l    #15,d0                  /*                 write_nibble(c & 0x0f); */
	and.b      d1,d0                   /*             } */
write_compression_12:
	bsr.w      write_nibble_asm        /*         } */
IFNE TEST_CODE
	lea        _StdErrF,a0
	moveq      #10,d0
	bsr        fputc
ENDC
write_compression_3:
	cmpa.l     d5,a6
	bcs        write_compression_15    /*     } */
	moveq.l    #15,d0                  /*     write_nibble(CHAR_EMPTY); */
	bsr.w      write_nibble_asm
	bsr.w      flush_nibble_asm        /*     flush_nibble(); */
	move.l     screen_start,0(a2,d4.l) /*     screen_table_offset[d4] = screen_start; */
	move.l     screenbuf_ptr,d1        /*     screen_start += screenbuf_ptr - screenbuf; */
	sub.l      screenbuf,d1
	add.l      d1,screen_start         /*     hc_flushbuf(); */
IFNE TEST_CODE
	movem.l    d2-d7/a2-a6,-(a7)
	move.l     a6,d0
	sub.l      hc_inbuf,d0
	move.l     d0,-(a7)
	move.l     d1,-(a7)
	move.l     0(a2,d4.l),-(a7)
	lsr.l      #2,d4
	move.l     d4,-(a7)
	lea        testcode_msg2(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        16(a7),a7
	movem.l    (a7)+,d2-d7/a2-a6
ENDC	
	jsr        hc_flshbuf
	addq.l     #4,d4
write_compression_1:
	cmp.l      (a7),d4
	blt        write_compression_16    /* } */
	move.l     screen_start,0(a2,d4.l) /* screen_table_offset[i] = screen_start */
	jsr        hc_closeout             /* hc_closeout(); */
IFNE TEST_CODE
	move.l     screen_start,-(a7)
	lea        testcode_msg3(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        4(a7),a7
ENDC	
	addq.w     #8,a7
	movem.l    (a7)+,d3-d7/a2-a6
	rts

IFNE TEST_CODE
toprint:
	cmp.w      #0x20,d0
	bcs.s      no_printable
	cmp.w      #0x7f,d0
	bcs.s      printable
no_printable:
	moveq      #'?',d0
printable:
	rts
ENDC

nibble: dc.b 0,0
oddflag: dc.b 0,0

	.globl write_nibble_asm
write_nibble_asm:
IFNE TEST_CODE
	movem.l    d0-d2/a0-a2,-(a7)
	and.w      #0xff,d0
	move.w     d0,-(a7)
	lea        testcode_nibble(pc),a1
	lea        _StdErrF,a0
	bsr        fprintf
	lea        2(a7),a7
	movem.l    (a7)+,d0-d2/a0-a2
ENDC
	tst.b      oddflag
	bne.s      write_nibble1
	lsl.b      #4,d0
	or.b       d0,nibble
	st         oddflag
	rts
write_nibble1:
	or.b       nibble(pc),d0
IFNE TEST_CODE
	move.l     screenbuf_ptr,a0
	move.b     d0,(a0)+
	move.l     a0,screenbuf_ptr
ELSE
	/*
	 * Note: dangerous. Calling code above assumes that d1 is preserved across call
	 */
	jsr        hc_putc
ENDC
	moveq.l    #0,d0
	move.l     d0,nibble /* also clears oddflag */
write_nibble2:
	rts

	.globl flush_nibble_asm
flush_nibble_asm:
	tst.b      oddflag
	beq.s      write_nibble2
	moveq.l    #0,d0
	bra.s      write_nibble1

IFNE TEST_CODE

testcode_msg1: dc.b "asm_write_compression: screen %ld: %lu %lu",10,0
testcode_msg2: dc.b 10,"asm_write_compression: compressed screen %ld: %lu %lu %lu",10,10,0
testcode_msg3: dc.b "asm_write_compression: total size: %lu",10,0
testcode_msg4: dc.b " prev_code %04x str_code=%d %lu %lu",10,"nibbles:",0
testcode_msg5: dc.b "char %02x %c",0
testcode_msg6: dc.b ", %02x %c %04x %04x %02x",0
testcode_nibble: dc.b " %02x",0
	even
ENDC
	
	.data
tempfilename: dc.b 'temporary file',0
hc_tmp2: dc.b 'hc.$2$',0
	.even


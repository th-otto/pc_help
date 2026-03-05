; ph_branch = 0x601a
; ph_tlen = 0x00004658
; ph_dlen = 0x00001334
; ph_blen = 0x00001d26
; ph_slen = 0x0000120c
; ph_res1 = 0x00000000
; ph_prgflags = 0x00000007
; ph_absflag = 0x0000
; first relocation = 0x00000002
; relocation bytes = 0x00000327


x10000:
[00010000] 6060                      bra.s      x10000_1
[00010002] 0001 599a                 ori.b      #$9A,d1
[00010006] 0000 1000                 ori.b      #$00,d0
[0001000a] 0000                      dc.w       $0000
[0001000c] 0000                      dc.w       $0000
[0001000e] 0000 3e3e                 ori.b      #$3E,d0
[00010012] 3e3e                      move.w     ???,d7
[00010014] 2050                      movea.l    (a0),a0
[00010016] 5552                      subq.w     #2,(a2)
[00010018] 452d 4320                 chk.l      17184(a5),d2 ; 68020+ only
[0001001c] 3c3c 3c3c                 move.w     #$3C3C,d6
[00010020] 2020                      move.l     -(a0),d0
[00010022] 666f                      bne.s      x10000_2 ; ; branch to odd address
[00010024] 7220                      moveq.l    #32,d1
[00010026] 4154                      lea.l      (a4),b0 ; apollo only
[00010028] 4152                      lea.l      (a2),b0 ; apollo only
[0001002a] 492d 5354                 chk.l      21332(a5),d4 ; 68020+ only
[0001002e] 2020                      move.l     -(a0),d0
[00010030] 2020                      move.l     -(a0),d0
[00010032] 5665                      addq.w     #3,-(a5)
[00010034] 7273                      moveq.l    #115,d1
[00010036] 696f                      bvs.s      x10000_3 ; ; branch to odd address
[00010038] 6e20                      bgt.s      x10000_4
[0001003a] 2031 2e30                 move.l     48(a1,d2.l*8),d0 ; 68020+ only
[0001003e] 2020                      move.l     -(a0),d0
[00010040] 2843                      movea.l    d3,a4
[00010042] 2938 382d                 move.l     ($0000382D).w,-(a4)
[00010046] 3930 2042                 move.w     66(a0,d2.w),-(a4)
[0001004a] 6f72                      ble.s      x10000_5
[0001004c] 6c61                      bge.s      x10000_6 ; ; branch to odd address
[0001004e] 6e64                      bgt.s      x10000_7
[00010050] 2049                      movea.l    a1,a0
[00010052] 6e74                      bgt.s      x10000_8
[00010054] 6572                      bcs.s      x10000_8
[00010056] 6e61                      bgt.s      x10000_9 ; ; branch to odd address
[00010058] 7469                      moveq.l    #105,d2
x10000_4:
[0001005a] 6f6e                      ble.s      x10000_10
[0001005c] 616c                      bsr.s      $000100CA
[0001005e] 2020                      move.l     -(a0),d0
[00010060] 0000 2648                 ori.b      #$48,d0
x10000_1:
[00010064] 200b                      move.l     a3,d0
[00010066] 6608                      bne.s      x10000_11
[00010068] 266f 0004                 movea.l    4(a7),a3
[0001006c] 7001                      moveq.l    #1,d0
[0001006e] 6002                      bra.s      x10000_12
x10000_11:
[00010070] 4240                      clr.w      d0
x10000_12:
[00010072] 23cb 0001 598c            move.l     a3,_BasPag
[00010078] 33c0 0001 5990            move.w     d0,_app
[0001007e] 206b 000c                 movea.l    12(a3),a0
[00010082] d1eb 0014                 adda.l     20(a3),a0
[00010086] d1eb 001c                 adda.l     28(a3),a0
[0001008a] d0fc 0100                 adda.w     #$0100,a0
[0001008e] 23c8 0001 5996            move.l     a0,_PgmSize
x10000_2:
[00010094] 200b                      move.l     a3,d0
[00010096] d088                      add.l      a0,d0
[00010098] c03c 00fc                 and.b      #$FC,d0
[0001009c] 2e40                      movea.l    d0,a7
[0001009e] 90bc 0000 0f00            sub.l      #$00000F00,d0
[000100a4] 23c0 0001 5992            move.l     d0,_StkLim
x10000_3:
[000100aa] 4a79 0001 5990            tst.w      _app
x10000_6:
[000100b0] 6700 00ae                 beq        x10000_13
x10000_7:
[000100b4] 90bc 0000 00fa            sub.l      #$000000FA,d0
x10000_9:
[000100ba] c03c 00fc                 and.b      #$FC,d0
x10000_5:
[000100be] 2240                      movea.l    d0,a1
[000100c0] 2849                      movea.l    a1,a4
[000100c2] 246b 002c                 movea.l    44(a3),a2
[000100c6] 22ca                      move.l     a2,(a1)+
x10000_8:
[000100c8] 4a1a                      tst.b      (a2)+
x10000_10:
[000100ca] 66fc                      bne.s      x10000_8
[000100cc] 22ca                      move.l     a2,(a1)+
[000100ce] 4a1a                      tst.b      (a2)+
[000100d0] 66f6                      bne.s      x10000_8
[000100d2] 42a1                      clr.l      -(a1)
[000100d4] 2f08                      move.l     a0,-(a7)
[000100d6] 2f0b                      move.l     a3,-(a7)
[000100d8] 3f3c 0000                 move.w     #$0000,-(a7)
[000100dc] 3f3c 004a                 move.w     #$004A,-(a7) ; Mshrink
[000100e0] 4e41                      trap       #1
[000100e2] 4fef 000c                 lea.l      12(a7),a7
[000100e6] 41eb 0080                 lea.l      128(a3),a0
[000100ea] 1210                      move.b     (a0),d1
[000100ec] b23c 007e                 cmp.b      #$7E,d1
[000100f0] 6b0e                      bmi.s      x10000_14
[000100f2] 5288                      addq.l     #1,a0
[000100f4] 72ff                      moveq.l    #-1,d1
x10000_15:
[000100f6] 5241                      addq.w     #1,d1
[000100f8] 1018                      move.b     (a0)+,d0
[000100fa] 66fa                      bne.s      x10000_15
[000100fc] 41eb 0080                 lea.l      128(a3),a0
x10000_14:
[00010100] 363c 0001                 move.w     #$0001,d3
[00010104] 4881                      ext.w      d1
[00010106] 43f0 1001                 lea.l      1(a0,d1.w),a1
[0001010a] 4211                      clr.b      (a1)
[0001010c] 42a7                      clr.l      -(a7)
[0001010e] 6036                      bra.s      x10000_16
x10000_20:
[00010110] 0c11 0021                 cmpi.b     #$21,(a1)
[00010114] 6a10                      bpl.s      x10000_17
[00010116] 4211                      clr.b      (a1)
[00010118] 4a29 0001                 tst.b      1(a1)
[0001011c] 6708                      beq.s      x10000_17
[0001011e] 4869 0001                 pea.l      1(a1)
[00010122] 5243                      addq.w     #1,d3
[00010124] 6020                      bra.s      x10000_16
x10000_17:
[00010126] 0c11 0022                 cmpi.b     #$22,(a1)
[0001012a] 661a                      bne.s      x10000_16
[0001012c] 12bc 0000                 move.b     #$00,(a1)
x10000_18:
[00010130] 5349                      subq.w     #1,a1
[00010132] 0c11 0022                 cmpi.b     #$22,(a1)
[00010136] 57c9 fff8                 dbeq       d1,x10000_18
[0001013a] 5341                      subq.w     #1,d1
[0001013c] 6b0e                      bmi.s      x10000_19
[0001013e] 4869 0001                 pea.l      1(a1)
[00010142] 5243                      addq.w     #1,d3
[00010144] 4211                      clr.b      (a1)
x10000_16:
[00010146] 5389                      subq.l     #1,a1
[00010148] 51c9 ffc6                 dbf        d1,x10000_20
x10000_19:
[0001014c] 4a29 0001                 tst.b      1(a1)
[00010150] 6706                      beq.s      x10000_21
[00010152] 4869 0001                 pea.l      1(a1)
[00010156] 5243                      addq.w     #1,d3
x10000_21:
[00010158] 4879 0001 0060            pea.l      $00010060
[0001015e] 244f                      movea.l    a7,a2
x10000_13:
[00010160] 4eb9 0001 285e            jsr        _fpuinit
[00010166] 3003                      move.w     d3,d0
[00010168] 204a                      movea.l    a2,a0
[0001016a] 224c                      movea.l    a4,a1
[0001016c] 4eb9 0001 0198            jsr        main

exit:
[00010172] 3f00                      move.w     d0,-(a7)
[00010174] 2039 0001 465a            move.l     _AtExitVec,d0
[0001017a] 6704                      beq.s      exit_1
[0001017c] 2040                      movea.l    d0,a0
[0001017e] 4e90                      jsr        (a0)
exit_1:
[00010180] 2039 0001 465e            move.l     _FilSysVec,d0
[00010186] 6704                      beq.s      exit_2
[00010188] 2040                      movea.l    d0,a0
[0001018a] 4e90                      jsr        (a0)
exit_2:
[0001018c] 4eb9 0001 3da2            jsr        _FreeAll
[00010192] 3f3c 004c                 move.w     #$004C,-(a7) ; Pterm
[00010196] 4e41                      trap       #1

main:
[00010198] 48e7 1820                 movem.l    d3-d4/a2,-(a7)
[0001019c] 3600                      move.w     d0,d3
[0001019e] 2448                      movea.l    a0,a2
[000101a0] 4eb9 0001 0204            jsr        print_banner
[000101a6] 204a                      movea.l    a2,a0
[000101a8] 3003                      move.w     d3,d0
[000101aa] 4eb9 0001 023a            jsr        read_commandfile
[000101b0] 3800                      move.w     d0,d4
[000101b2] 6608                      bne.s      main_1
[000101b4] 4eb9 0001 0218            jsr        usage
[000101ba] 601a                      bra.s      main_2
main_1:
[000101bc] 43f9 0001 5a06            lea.l      $00015A06,a1
[000101c2] 3204                      move.w     d4,d1
[000101c4] 3039 0001 4666            move.w     file_index,d0
[000101ca] 2079 0001 5a02            movea.l    helpfiles,a0
[000101d0] 4eb9 0001 04e6            jsr        compile_help
main_2:
[000101d6] 3039 0001 466c            move.w     options.verbose,d0
[000101dc] 6718                      beq.s      main_3
[000101de] 43f9 0001 4674            lea.l      $00014674,a1
[000101e4] 41f9 0001 5928            lea.l      stdout,a0
[000101ea] 4eb9 0001 29c8            jsr        fprintf
[000101f0] 4eb9 0001 4602            jsr        getch
main_3:
[000101f6] 4240                      clr.w      d0
[000101f8] 4eb9 0001 0172            jsr        exit
[000101fe] 4cdf 0418                 movem.l    (a7)+,d3-d4/a2
[00010202] 4e75                      rts

print_banner:
[00010204] 43f9 0001 467d            lea.l      $0001467D,a1
[0001020a] 41f9 0001 5928            lea.l      stdout,a0
[00010210] 4eb9 0001 29c8            jsr        fprintf
[00010216] 4e75                      rts

usage:
[00010218] 43f9 0001 46c0            lea.l      $000146C0,a1
[0001021e] 41f9 0001 5928            lea.l      stdout,a0
[00010224] 4eb9 0001 29c8            jsr        fprintf
[0001022a] 3039 0001 466c            move.w     options.verbose,d0
[00010230] 6606                      bne.s      usage_1
[00010232] 4eb9 0001 4602            jsr        getch
usage_1:
[00010238] 4e75                      rts

read_commandfile:
[0001023a] 48e7 1e3e                 movem.l    d3-d6/a2-a6,-(a7)
[0001023e] 4fef fe7c                 lea.l      -388(a7),a7
[00010242] 2448                      movea.l    a0,a2
[00010244] 76ff                      moveq.l    #-1,d3
[00010246] 4244                      clr.w      d4
[00010248] b07c 0001                 cmp.w      #$0001,d0
[0001024c] 6e06                      bgt.s      read_commandfile_1
[0001024e] 3004                      move.w     d4,d0
[00010250] 6000 028a                 bra        read_commandfile_2
read_commandfile_1:
[00010254] 705c                      moveq.l    #92,d0
[00010256] 206a 0004                 movea.l    4(a2),a0
[0001025a] 4eb9 0001 39e6            jsr        strrchr
[00010260] 2648                      movea.l    a0,a3
[00010262] 200b                      move.l     a3,d0
[00010264] 671a                      beq.s      read_commandfile_3
[00010266] 2a0b                      move.l     a3,d5
[00010268] 9aaa 0004                 sub.l      4(a2),d5
[0001026c] 5285                      addq.l     #1,d5
[0001026e] 2005                      move.l     d5,d0
[00010270] 226a 0004                 movea.l    4(a2),a1
[00010274] 41ef 0004                 lea.l      4(a7),a0
[00010278] 4eb9 0001 3ac6            jsr        strncpy
[0001027e] 6002                      bra.s      read_commandfile_4
read_commandfile_3:
[00010280] 7a00                      moveq.l    #0,d5
read_commandfile_4:
[00010282] 4237 5004                 clr.b      4(a7,d5.w)
[00010286] 4def 0084                 lea.l      132(a7),a6
[0001028a] 49f9 0001 466a            lea.l      options.create_log,a4
[00010290] 43f9 0001 4891            lea.l      $00014891,a1
[00010296] 206a 0004                 movea.l    4(a2),a0
[0001029a] 4eb9 0001 3266            jsr        fopen
[000102a0] 2e88                      move.l     a0,(a7)
[000102a2] 6600 020a                 bne        read_commandfile_5
[000102a6] 2f2a 0004                 move.l     4(a2),-(a7)
[000102aa] 4241                      clr.w      d1
[000102ac] 7002                      moveq.l    #2,d0
[000102ae] 4eb9 0001 0c4e            jsr        hclog
[000102b4] 584f                      addq.w     #4,a7
[000102b6] 6000 01f6                 bra        read_commandfile_5
read_commandfile_30:
[000102ba] 204e                      movea.l    a6,a0
[000102bc] 4eb9 0001 3a9c            jsr        strlen
[000102c2] 0c36 000a 00ff            cmpi.b     #$0A,-1(a6,d0.w)
[000102c8] 6604                      bne.s      read_commandfile_6
[000102ca] 4236 00ff                 clr.b      -1(a6,d0.w)
read_commandfile_6:
[000102ce] 2a4e                      movea.l    a6,a5
[000102d0] 6002                      bra.s      read_commandfile_7
read_commandfile_8:
[000102d2] 524d                      addq.w     #1,a5
read_commandfile_7:
[000102d4] 0c15 0020                 cmpi.b     #$20,(a5)
[000102d8] 67f8                      beq.s      read_commandfile_8
[000102da] 0c15 0009                 cmpi.b     #$09,(a5)
[000102de] 67f2                      beq.s      read_commandfile_8
[000102e0] 0c15 003b                 cmpi.b     #$3B,(a5)
[000102e4] 6700 01c8                 beq        read_commandfile_5
[000102e8] 1015                      move.b     (a5),d0
[000102ea] 6700 01c2                 beq        read_commandfile_5
[000102ee] 264d                      movea.l    a5,a3
[000102f0] 6002                      bra.s      read_commandfile_9
read_commandfile_11:
[000102f2] 524b                      addq.w     #1,a3
read_commandfile_9:
[000102f4] 0c13 0020                 cmpi.b     #$20,(a3)
[000102f8] 6710                      beq.s      read_commandfile_10
[000102fa] 0c13 0009                 cmpi.b     #$09,(a3)
[000102fe] 670a                      beq.s      read_commandfile_10
[00010300] 0c13 003b                 cmpi.b     #$3B,(a3)
[00010304] 6704                      beq.s      read_commandfile_10
[00010306] 1013                      move.b     (a3),d0
[00010308] 66e8                      bne.s      read_commandfile_11
read_commandfile_10:
[0001030a] 4213                      clr.b      (a3)
[0001030c] 4a44                      tst.w      d4
[0001030e] 6600 0110                 bne        read_commandfile_12
[00010312] 47ed 0001                 lea.l      1(a5),a3
[00010316] 6000 00fc                 bra        read_commandfile_13
read_commandfile_24:
[0001031a] 4240                      clr.w      d0
[0001031c] 1013                      move.b     (a3),d0
[0001031e] 4eb9 0001 414e            jsr        toupper
[00010324] 907c 002d                 sub.w      #$002D,d0
[00010328] b07c 002a                 cmp.w      #$002A,d0
[0001032c] 6200 00d2                 bhi        read_commandfile_14
[00010330] d040                      add.w      d0,d0
[00010332] 303b 0006                 move.w     $0001033A(pc,d0.w),d0
[00010336] 4efb 0002                 jmp        $0001033A(pc,d0.w)
J1: ; not found: 0001033a
[0001033a] 00d8                      dc.w $00d8   ; read_commandfile_15-J1
[0001033c] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001033e] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010340] 0056                      dc.w $0056   ; read_commandfile_16-J1
[00010342] 0056                      dc.w $0056   ; read_commandfile_16-J1
[00010344] 0056                      dc.w $0056   ; read_commandfile_16-J1
[00010346] 0056                      dc.w $0056   ; read_commandfile_16-J1
[00010348] 0056                      dc.w $0056   ; read_commandfile_16-J1
[0001034a] 0056                      dc.w $0056   ; read_commandfile_16-J1
[0001034c] 0056                      dc.w $0056   ; read_commandfile_16-J1
[0001034e] 0056                      dc.w $0056   ; read_commandfile_16-J1
[00010350] 0066                      dc.w $0066   ; read_commandfile_17-J1
[00010352] 0066                      dc.w $0066   ; read_commandfile_17-J1
[00010354] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010356] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010358] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001035a] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001035c] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001035e] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010360] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010362] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010364] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010366] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010368] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001036a] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001036c] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001036e] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010370] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010372] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010374] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010376] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010378] 007a                      dc.w $007a   ; read_commandfile_18-J1
[0001037a] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001037c] 00b6                      dc.w $00b6   ; read_commandfile_19-J1
[0001037e] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010380] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010382] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010384] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010386] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[00010388] 0080                      dc.w $0080   ; read_commandfile_20-J1
[0001038a] 00c6                      dc.w $00c6   ; read_commandfile_14-J1
[0001038c] 00ae                      dc.w $00ae   ; read_commandfile_21-J1
[0001038e] 00be                      dc.w $00be   ; read_commandfile_22-J1
read_commandfile_16:
[00010390] 4240                      clr.w      d0
[00010392] 1013                      move.b     (a3),d0
[00010394] d07c ffd0                 add.w      #$FFD0,d0
[00010398] 3940 fffc                 move.w     d0,-4(a4) ; file_index
[0001039c] 6000 0074                 bra.w      read_commandfile_15
read_commandfile_17:
[000103a0] 4240                      clr.w      d0
[000103a2] 1013                      move.b     (a3),d0
[000103a4] 3f00                      move.w     d0,-(a7)
[000103a6] 7201                      moveq.l    #1,d1
[000103a8] 7015                      moveq.l    #21,d0
[000103aa] 4eb9 0001 0c4e            jsr        hclog
[000103b0] 544f                      addq.w     #2,a7
[000103b2] 605e                      bra.s      read_commandfile_15
read_commandfile_18:
[000103b4] 38bc 0001                 move.w     #$0001,(a4) ; options.create_log
[000103b8] 6058                      bra.s      read_commandfile_15
read_commandfile_20:
[000103ba] 524b                      addq.w     #1,a3
[000103bc] 0c13 003d                 cmpi.b     #$3D,(a3)
[000103c0] 6610                      bne.s      read_commandfile_23
[000103c2] 524b                      addq.w     #1,a3
[000103c4] 4240                      clr.w      d0
[000103c6] 1013                      move.b     (a3),d0
[000103c8] d07c ffd0                 add.w      #$FFD0,d0
[000103cc] 3940 0008                 move.w     d0,8(a4) ; options.tabsize
[000103d0] 6040                      bra.s      read_commandfile_15
read_commandfile_23:
[000103d2] 4240                      clr.w      d0
[000103d4] 102b ffff                 move.b     -1(a3),d0
[000103d8] 3f00                      move.w     d0,-(a7)
[000103da] 7201                      moveq.l    #1,d1
[000103dc] 7013                      moveq.l    #19,d0
[000103de] 4eb9 0001 0c4e            jsr        hclog
[000103e4] 544f                      addq.w     #2,a7
[000103e6] 602a                      bra.s      read_commandfile_15
read_commandfile_21:
[000103e8] 397c 0001 0002            move.w     #$0001,2(a4) ; options.verbose
[000103ee] 6022                      bra.s      read_commandfile_15
read_commandfile_19:
[000103f0] 397c ffff fffe            move.w     #$FFFF,-2(a4) ; generate_help
[000103f6] 601a                      bra.s      read_commandfile_15
read_commandfile_22:
[000103f8] 397c 0001 0006            move.w     #$0001,6(a4) ; options.break_make
[000103fe] 6012                      bra.s      read_commandfile_15
read_commandfile_14:
[00010400] 4240                      clr.w      d0
[00010402] 1013                      move.b     (a3),d0
[00010404] 3f00                      move.w     d0,-(a7)
[00010406] 7201                      moveq.l    #1,d1
[00010408] 7014                      moveq.l    #20,d0
[0001040a] 4eb9 0001 0c4e            jsr        hclog
[00010410] 544f                      addq.w     #2,a7
read_commandfile_15:
[00010412] 524b                      addq.w     #1,a3
read_commandfile_13:
[00010414] 1013                      move.b     (a3),d0
[00010416] 6600 ff02                 bne        read_commandfile_24
[0001041a] 7801                      moveq.l    #1,d4
[0001041c] 6000 0090                 bra        read_commandfile_5
read_commandfile_12:
[00010420] b67c 003e                 cmp.w      #$003E,d3
[00010424] 6e00 0078                 bgt.w      read_commandfile_25
[00010428] 204d                      movea.l    a5,a0
[0001042a] 4eb9 0001 3a9c            jsr        strlen
[00010430] 2c00                      move.l     d0,d6
[00010432] 0c2d 003a 0001            cmpi.b     #$3A,1(a5)
[00010438] 6708                      beq.s      read_commandfile_26
[0001043a] 0c15 005c                 cmpi.b     #$5C,(a5)
[0001043e] 6702                      beq.s      read_commandfile_26
[00010440] dc85                      add.l      d5,d6
read_commandfile_26:
[00010442] 7001                      moveq.l    #1,d0
[00010444] d086                      add.l      d6,d0
[00010446] 4eb9 0001 3c60            jsr        malloc
[0001044c] 2648                      movea.l    a0,a3
[0001044e] 200b                      move.l     a3,d0
[00010450] 660a                      bne.s      read_commandfile_27
[00010452] 4241                      clr.w      d1
[00010454] 7003                      moveq.l    #3,d0
[00010456] 4eb9 0001 0c4e            jsr        hclog
read_commandfile_27:
[0001045c] 0c2d 003a 0001            cmpi.b     #$3A,1(a5)
[00010462] 671e                      beq.s      read_commandfile_28
[00010464] 0c15 005c                 cmpi.b     #$5C,(a5)
[00010468] 6718                      beq.s      read_commandfile_28
[0001046a] 43ef 0004                 lea.l      4(a7),a1
[0001046e] 204b                      movea.l    a3,a0
[00010470] 4eb9 0001 3a56            jsr        strcpy
[00010476] 224d                      movea.l    a5,a1
[00010478] 204b                      movea.l    a3,a0
[0001047a] 4eb9 0001 399e            jsr        strcat
[00010480] 600a                      bra.s      read_commandfile_29
read_commandfile_28:
[00010482] 224d                      movea.l    a5,a1
[00010484] 204b                      movea.l    a3,a0
[00010486] 4eb9 0001 3a56            jsr        strcpy
read_commandfile_29:
[0001048c] 5243                      addq.w     #1,d3
[0001048e] 3003                      move.w     d3,d0
[00010490] e548                      lsl.w      #2,d0
[00010492] 41f9 0001 5a02            lea.l      helpfiles,a0
[00010498] 218b 0000                 move.l     a3,0(a0,d0.w)
[0001049c] 6010                      bra.s      read_commandfile_5
read_commandfile_25:
[0001049e] 2f2a 0004                 move.l     4(a2),-(a7)
[000104a2] 4241                      clr.w      d1
[000104a4] 7006                      moveq.l    #6,d0
[000104a6] 4eb9 0001 0c4e            jsr        hclog
[000104ac] 584f                      addq.w     #4,a7
read_commandfile_5:
[000104ae] 2257                      movea.l    (a7),a1
[000104b0] 303c 0100                 move.w     #$0100,d0
[000104b4] 204e                      movea.l    a6,a0
[000104b6] 4eb9 0001 2f90            jsr        fgets
[000104bc] 2008                      move.l     a0,d0
[000104be] 6600 fdfa                 bne        read_commandfile_30
[000104c2] 2057                      movea.l    (a7),a0
[000104c4] 4eb9 0001 3436            jsr        fclose
[000104ca] 3039 0001 5b12            move.w     errors_thisfile,d0
[000104d0] 6708                      beq.s      read_commandfile_31
[000104d2] 70fe                      moveq.l    #-2,d0
[000104d4] 4eb9 0001 0172            jsr        exit
read_commandfile_31:
[000104da] 3003                      move.w     d3,d0
read_commandfile_2:
[000104dc] 4fef 0184                 lea.l      388(a7),a7
[000104e0] 4cdf 7c78                 movem.l    (a7)+,d3-d6/a2-a6
[000104e4] 4e75                      rts

compile_help:
[000104e6] 48e7 1838                 movem.l    d3-d4/a2-a4,-(a7)
[000104ea] 2448                      movea.l    a0,a2
[000104ec] 3600                      move.w     d0,d3
[000104ee] 3801                      move.w     d1,d4
[000104f0] 2849                      movea.l    a1,a4
[000104f2] 47f9 0001 59c2            lea.l      outfile_name,a3
[000104f8] 224a                      movea.l    a2,a1
[000104fa] 204b                      movea.l    a3,a0
[000104fc] 4eb9 0001 3a56            jsr        strcpy
[00010502] 204b                      movea.l    a3,a0
[00010504] 4eb9 0001 3bb2            jsr        strupr
[0001050a] 33c3 0001 4666            move.w     d3,file_index
[00010510] 4eb9 0001 0558            jsr        alloc_buffers
[00010516] 3039 0001 466a            move.w     options.create_log,d0
[0001051c] 6706                      beq.s      compile_help_1
[0001051e] 4eb9 0001 0b36            jsr        log_open
compile_help_1:
[00010524] 204c                      movea.l    a4,a0
[00010526] 3004                      move.w     d4,d0
[00010528] 4eb9 0001 07ae            jsr        compile_files
[0001052e] 4eb9 0001 0bac            jsr        hc_closeout
[00010534] 4eb9 0001 0bbe            jsr        log_close
[0001053a] 41f9 0001 4893            lea.l      $00014893,a0
[00010540] 4eb9 0001 367c            jsr        unlink
[00010546] 41f9 0001 489a            lea.l      $0001489A,a0
[0001054c] 4eb9 0001 367c            jsr        unlink
[00010552] 4cdf 1c18                 movem.l    (a7)+,d3-d4/a2-a4
[00010556] 4e75                      rts

alloc_buffers:
[00010558] 2f0a                      move.l     a2,-(a7)
[0001055a] 4eb9 0001 14f4            jsr        init_keyword_hash
[00010560] 4eb9 0001 1c2a            jsr        clear_index
[00010566] 45f9 0001 59b2            lea.l      hc_inbuf,a2
[0001056c] 203c 0000 8000            move.l     #$00008000,d0
[00010572] 4eb9 0001 3c60            jsr        malloc
[00010578] 2488                      move.l     a0,(a2) ; hc_inbuf
[0001057a] 660a                      bne.s      alloc_buffers_1
[0001057c] 4241                      clr.w      d1
[0001057e] 7003                      moveq.l    #3,d0
[00010580] 4eb9 0001 0c4e            jsr        hclog
alloc_buffers_1:
[00010586] 2052                      movea.l    (a2),a0 ; hc_inbuf
[00010588] 41e8 4000                 lea.l      16384(a0),a0
[0001058c] 2548 0004                 move.l     a0,4(a2) ; screenbuf
[00010590] 2548 000c                 move.l     a0,12(a2) ; screenbuf_ptr
[00010594] 2548 0008                 move.l     a0,8(a2) ; hc_inbuf_ptr
[00010598] 203c 0000 4000            move.l     #$00004000,d0
[0001059e] 4eb9 0001 3c60            jsr        malloc
[000105a4] 23c8 0001 62f6            move.l     a0,screen_table_offset
[000105aa] 660a                      bne.s      alloc_buffers_2
[000105ac] 4241                      clr.w      d1
[000105ae] 7003                      moveq.l    #3,d0
[000105b0] 4eb9 0001 0c4e            jsr        hclog
alloc_buffers_2:
[000105b6] 203c 0000 6000            move.l     #$00006000,d0
[000105bc] 4eb9 0001 3c60            jsr        malloc
[000105c2] 23c8 0001 63d2            move.l     a0,caps_table
[000105c8] 660a                      bne.s      alloc_buffers_3
[000105ca] 4241                      clr.w      d1
[000105cc] 7003                      moveq.l    #3,d0
[000105ce] 4eb9 0001 0c4e            jsr        hclog
alloc_buffers_3:
[000105d4] 203c 0000 6000            move.l     #$00006000,d0
[000105da] 4eb9 0001 3c60            jsr        malloc
[000105e0] 23c8 0001 63da            move.l     a0,sens_table
[000105e6] 660a                      bne.s      alloc_buffers_4
[000105e8] 4241                      clr.w      d1
[000105ea] 7003                      moveq.l    #3,d0
[000105ec] 4eb9 0001 0c4e            jsr        hclog
alloc_buffers_4:
[000105f2] 7000                      moveq.l    #0,d0
[000105f4] 23c0 0001 63de            move.l     d0,sens_cnt
[000105fa] 23c0 0001 63d6            move.l     d0,caps_cnt
[00010600] 245f                      movea.l    (a7)+,a2
[00010602] 4e75                      rts

pass1:
[00010604] 48e7 1838                 movem.l    d3-d4/a2-a4,-(a7)
[00010608] 4fef ff00                 lea.l      -256(a7),a7
[0001060c] 3800                      move.w     d0,d4
[0001060e] 2648                      movea.l    a0,a3
[00010610] 45f9 0001 4674            lea.l      $00014674,a2
[00010616] 41ea 022d                 lea.l      557(a2),a0 ; $000148A1
[0001061a] 4eb9 0001 0b0c            jsr        hc_createfile
[00010620] 4eb9 0001 1e8a            jsr        generate_copyright
[00010626] 4eb9 0001 1e60            jsr        parse_index_page
[0001062c] 4243                      clr.w      d3
[0001062e] 49f9 0001 466a            lea.l      options.create_log,a4
[00010634] 604e                      bra.s      pass1_1
pass1_3:
[00010636] 4eb9 0001 06d2            jsr        reset_file
[0001063c] 3003                      move.w     d3,d0
[0001063e] 48c0                      ext.l      d0
[00010640] e588                      lsl.l      #2,d0
[00010642] 2073 0800                 movea.l    0(a3,d0.l),a0
[00010646] 4eb9 0001 0ad0            jsr        hc_openfile
[0001064c] 302c 0002                 move.w     2(a4),d0 ; options.verbose
[00010650] 671e                      beq.s      pass1_2
[00010652] 2f39 0001 4942            move.l     err_filename,-(a7)
[00010658] 43ea 0234                 lea.l      564(a2),a1 ; $000148A8
[0001065c] 41ef 0004                 lea.l      4(a7),a0
[00010660] 4eb9 0001 2a06            jsr        sprintf
[00010666] 584f                      addq.w     #4,a7
[00010668] 41d7                      lea.l      (a7),a0
[0001066a] 4eb9 0001 0d74            jsr        logstr
pass1_2:
[00010670] 4eb9 0001 0d9c            jsr        parse_file
[00010676] 4eb9 0001 0bf0            jsr        hc_closein
[0001067c] 4eb9 0001 071a            jsr        check_errors
[00010682] 5243                      addq.w     #1,d3
pass1_1:
[00010684] b644                      cmp.w      d4,d3
[00010686] 6dae                      blt.s      pass1_3
[00010688] 302c fffe                 move.w     -2(a4),d0 ; generate_help
[0001068c] 671c                      beq.s      pass1_4
[0001068e] 322c 0002                 move.w     2(a4),d1 ; options.verbose
[00010692] 6710                      beq.s      pass1_5
[00010694] 43ea 0243                 lea.l      579(a2),a1 ; $000148B7
[00010698] 41f9 0001 5928            lea.l      stdout,a0
[0001069e] 4eb9 0001 29c8            jsr        fprintf
pass1_5:
[000106a4] 4eb9 0001 196a            jsr        generate_index
pass1_4:
[000106aa] 3039 0001 5072            move.w     screen_cnt,d0
[000106b0] 48c0                      ext.l      d0
[000106b2] e588                      lsl.l      #2,d0
[000106b4] 2079 0001 62f6            movea.l    screen_table_offset,a0
[000106ba] 21b9 0001 5078 0800       move.l     screen_start,0(a0,d0.l)
[000106c2] 4eb9 0001 0bac            jsr        hc_closeout
[000106c8] 4fef 0100                 lea.l      256(a7),a7
[000106cc] 4cdf 1c18                 movem.l    (a7)+,d3-d4/a2-a4
[000106d0] 4e75                      rts

reset_file:
[000106d2] 3039 0001 5b12            move.w     errors_thisfile,d0
[000106d8] 6706                      beq.s      reset_file_1
[000106da] 4279 0001 4668            clr.w      generate_help
reset_file_1:
[000106e0] 7001                      moveq.l    #1,d0
[000106e2] 23c0 0001 5f1a            move.l     d0,input_lineno
[000106e8] 23c0 0001 5b0e            move.l     d0,err_lineno
[000106ee] 4241                      clr.w      d1
[000106f0] 33c1 0001 5b14            move.w     d1,warnings_thisfile
[000106f6] 33c1 0001 5b12            move.w     d1,errors_thisfile
[000106fc] 23fc 0000 4000 0001 4662  move.l     #$00004000,hc_inbuf_size
[00010706] 2079 0001 59b6            movea.l    screenbuf,a0
[0001070c] 23c8 0001 59be            move.l     a0,screenbuf_ptr
[00010712] 23c8 0001 59ba            move.l     a0,hc_inbuf_ptr
[00010718] 4e75                      rts

check_errors:
[0001071a] 2f0a                      move.l     a2,-(a7)
[0001071c] 4fef ff00                 lea.l      -256(a7),a7
[00010720] 45f9 0001 4674            lea.l      $00014674,a2
[00010726] 41ea 0255                 lea.l      597(a2),a0 ; $000148C9
[0001072a] 4eb9 0001 0d74            jsr        logstr
[00010730] 3039 0001 5b12            move.w     errors_thisfile,d0
[00010736] 671a                      beq.s      check_errors_1
[00010738] 3f00                      move.w     d0,-(a7)
[0001073a] 43ea 0258                 lea.l      600(a2),a1 ; $000148CC
[0001073e] 41ef 0002                 lea.l      2(a7),a0
[00010742] 4eb9 0001 2a06            jsr        sprintf
[00010748] 544f                      addq.w     #2,a7
[0001074a] 41d7                      lea.l      (a7),a0
[0001074c] 4eb9 0001 0d74            jsr        logstr
check_errors_1:
[00010752] 3039 0001 5b14            move.w     warnings_thisfile,d0
[00010758] 671a                      beq.s      check_errors_2
[0001075a] 3f00                      move.w     d0,-(a7)
[0001075c] 43ea 0265                 lea.l      613(a2),a1 ; $000148D9
[00010760] 41ef 0002                 lea.l      2(a7),a0
[00010764] 4eb9 0001 2a06            jsr        sprintf
[0001076a] 544f                      addq.w     #2,a7
[0001076c] 41d7                      lea.l      (a7),a0
[0001076e] 4eb9 0001 0d74            jsr        logstr
check_errors_2:
[00010774] 41ea 0007                 lea.l      7(a2),a0 ; $0001467B
[00010778] 4eb9 0001 0d74            jsr        logstr
[0001077e] 3039 0001 5b12            move.w     errors_thisfile,d0
[00010784] 6706                      beq.s      check_errors_3
[00010786] 4eb9 0001 0d34            jsr        cleanup
check_errors_3:
[0001078c] 3039 0001 4670            move.w     options.break_make,d0
[00010792] 670e                      beq.s      check_errors_4
[00010794] 3239 0001 5b14            move.w     warnings_thisfile,d1
[0001079a] 6706                      beq.s      check_errors_4
[0001079c] 4eb9 0001 0d34            jsr        cleanup
check_errors_4:
[000107a2] 6100 ff2e                 bsr        reset_file
[000107a6] 4fef 0100                 lea.l      256(a7),a7
[000107aa] 245f                      movea.l    (a7)+,a2
[000107ac] 4e75                      rts

compile_files:
[000107ae] 48e7 1038                 movem.l    d3/a2-a4,-(a7)
[000107b2] 4fef ff00                 lea.l      -256(a7),a7
[000107b6] 3600                      move.w     d0,d3
[000107b8] 2848                      movea.l    a0,a4
[000107ba] 45f9 0001 4674            lea.l      $00014674,a2
[000107c0] 47f9 0001 5928            lea.l      stdout,a3
[000107c6] 43ea 0273                 lea.l      627(a2),a1 ; $000148E7
[000107ca] 204b                      movea.l    a3,a0
[000107cc] 4eb9 0001 29c8            jsr        fprintf
[000107d2] 204c                      movea.l    a4,a0
[000107d4] 3003                      move.w     d3,d0
[000107d6] 6100 fe2c                 bsr        pass1
[000107da] 49f9 0001 4668            lea.l      generate_help,a4
[000107e0] 3014                      move.w     (a4),d0 ; generate_help
[000107e2] 672a                      beq.s      compile_files_1
[000107e4] 43ea 027d                 lea.l      637(a2),a1 ; $000148F1
[000107e8] 204b                      movea.l    a3,a0
[000107ea] 4eb9 0001 29c8            jsr        fprintf
[000107f0] 302c 0004                 move.w     4(a4),d0 ; options.verbose
[000107f4] 670a                      beq.s      compile_files_2
[000107f6] 41ea 0288                 lea.l      648(a2),a0 ; $000148FC
[000107fa] 4eb9 0001 0d74            jsr        logstr
compile_files_2:
[00010800] 41ea 022d                 lea.l      557(a2),a0 ; $000148A1
[00010804] 4eb9 0001 1752            jsr        do_references
[0001080a] 6100 ff0e                 bsr        check_errors
compile_files_1:
[0001080e] 3014                      move.w     (a4),d0 ; generate_help
[00010810] 6f28                      ble.s      compile_files_3
[00010812] 43ea 029c                 lea.l      668(a2),a1 ; $00014910
[00010816] 204b                      movea.l    a3,a0
[00010818] 4eb9 0001 29c8            jsr        fprintf
[0001081e] 302c 0004                 move.w     4(a4),d0 ; options.verbose
[00010822] 670a                      beq.s      compile_files_4
[00010824] 41ea 02a7                 lea.l      679(a2),a0 ; $0001491B
[00010828] 4eb9 0001 0d74            jsr        logstr
compile_files_4:
[0001082e] 4eb9 0001 1f0e            jsr        do_compress
[00010834] 6100 fee4                 bsr        check_errors
[00010838] 600a                      bra.s      compile_files_5
compile_files_3:
[0001083a] 41ea 022d                 lea.l      557(a2),a0 ; $000148A1
[0001083e] 4eb9 0001 367c            jsr        unlink
compile_files_5:
[00010844] 3014                      move.w     (a4),d0 ; generate_help
[00010846] 6f3a                      ble.s      compile_files_6
[00010848] 43ea 02b5                 lea.l      693(a2),a1 ; $00014929
[0001084c] 204b                      movea.l    a3,a0
[0001084e] 4eb9 0001 29c8            jsr        fprintf
[00010854] 302c 0004                 move.w     4(a4),d0 ; options.verbose
[00010858] 671e                      beq.s      compile_files_7
[0001085a] 4879 0001 59c2            pea.l      outfile_name
[00010860] 43ea 02c0                 lea.l      704(a2),a1 ; $00014934
[00010864] 41ef 0004                 lea.l      4(a7),a0
[00010868] 4eb9 0001 2a06            jsr        sprintf
[0001086e] 584f                      addq.w     #4,a7
[00010870] 41d7                      lea.l      (a7),a0
[00010872] 4eb9 0001 0d74            jsr        logstr
compile_files_7:
[00010878] 4eb9 0001 157e            jsr        write_help
[0001087e] 6100 fe9a                 bsr        check_errors
compile_files_6:
[00010882] 4fef 0100                 lea.l      256(a7),a7
[00010886] 4cdf 1c08                 movem.l    (a7)+,d3/a2-a4
[0001088a] 4e75                      rts

hc_getc:
[0001088c] 3f03                      move.w     d3,-(a7)
[0001088e] 2039 0001 4662            move.l     hc_inbuf_size,d0
[00010894] 2079 0001 59b2            movea.l    hc_inbuf,a0
[0001089a] d1c0                      adda.l     d0,a0
[0001089c] 2279 0001 59ba            movea.l    hc_inbuf_ptr,a1
[000108a2] b3c8                      cmpa.l     a0,a1
[000108a4] 642a                      bcc.s      hc_getc_1
[000108a6] 52b9 0001 59ba            addq.l     #1,hc_inbuf_ptr
[000108ac] 1611                      move.b     (a1),d3
[000108ae] b63c 000d                 cmp.b      #$0D,d3
[000108b2] 6618                      bne.s      hc_getc_2
[000108b4] 52b9 0001 5f1a            addq.l     #1,input_lineno
[000108ba] 3239 0001 5038            move.w     in_link,d1
[000108c0] 670a                      beq.s      hc_getc_2
[000108c2] 700f                      moveq.l    #15,d0
[000108c4] 7201                      moveq.l    #1,d1
[000108c6] 4eb9 0001 0c4e            jsr        hclog
hc_getc_2:
[000108cc] 1003                      move.b     d3,d0
[000108ce] 6016                      bra.s      hc_getc_3
hc_getc_1:
[000108d0] 0cb9 0000 4000 0001 4662  cmpi.l     #$00004000,hc_inbuf_size
[000108da] 6704                      beq.s      hc_getc_4
[000108dc] 701a                      moveq.l    #26,d0
[000108de] 6006                      bra.s      hc_getc_3
hc_getc_4:
[000108e0] 4eb9 0001 09b8            jsr        hc_fillbuf
hc_getc_3:
[000108e6] 361f                      move.w     (a7)+,d3
[000108e8] 4e75                      rts

hc_putc:
[000108ea] 2079 0001 59be            movea.l    screenbuf_ptr,a0
[000108f0] 52b9 0001 59be            addq.l     #1,screenbuf_ptr
[000108f6] 1080                      move.b     d0,(a0)
[000108f8] 2079 0001 59b6            movea.l    screenbuf,a0
[000108fe] 41e8 4000                 lea.l      16384(a0),a0
[00010902] 2279 0001 59be            movea.l    screenbuf_ptr,a1
[00010908] b3c8                      cmpa.l     a0,a1
[0001090a] 652a                      bcs.s      hc_putc_1
[0001090c] 7201                      moveq.l    #1,d1
[0001090e] 700c                      moveq.l    #12,d0
[00010910] 4eb9 0001 0c4e            jsr        hclog
[00010916] 3039 0001 5034            move.w     in_screen,d0
[0001091c] 670a                      beq.s      hc_putc_2
[0001091e] 72ff                      moveq.l    #-1,d1
[00010920] 7002                      moveq.l    #2,d0
[00010922] 4eb9 0001 10d0            jsr        hc_skipto
hc_putc_2:
[00010928] 23f9 0001 59b6 0001 59be  move.l     screenbuf,screenbuf_ptr
[00010932] 4240                      clr.w      d0
[00010934] 4e75                      rts
hc_putc_1:
[00010936] 7001                      moveq.l    #1,d0
[00010938] 4e75                      rts

hc_putw:
[0001093a] 554f                      subq.w     #2,a7
[0001093c] 3e80                      move.w     d0,(a7)
[0001093e] 1017                      move.b     (a7),d0
[00010940] 6100 ffa8                 bsr.w      hc_putc
[00010944] 4a40                      tst.w      d0
[00010946] 670a                      beq.s      hc_putw_1
[00010948] 102f 0001                 move.b     1(a7),d0
[0001094c] 6100 ff9c                 bsr.w      hc_putc
[00010950] 6002                      bra.s      hc_putw_2
hc_putw_1:
[00010952] 4240                      clr.w      d0
hc_putw_2:
[00010954] 544f                      addq.w     #2,a7
[00010956] 4e75                      rts

hc_puts:
[00010958] 48e7 1030                 movem.l    d3/a2-a3,-(a7)
[0001095c] 2448                      movea.l    a0,a2
[0001095e] 4eb9 0001 3a9c            jsr        strlen
[00010964] 2600                      move.l     d0,d3
[00010966] 47f9 0001 59be            lea.l      screenbuf_ptr,a3
[0001096c] 2053                      movea.l    (a3),a0 ; screenbuf_ptr
[0001096e] d1c3                      adda.l     d3,a0
[00010970] 2279 0001 59b6            movea.l    screenbuf,a1
[00010976] 43e9 4000                 lea.l      16384(a1),a1
[0001097a] b1c9                      cmpa.l     a1,a0
[0001097c] 6526                      bcs.s      hc_puts_1
[0001097e] 7201                      moveq.l    #1,d1
[00010980] 700c                      moveq.l    #12,d0
[00010982] 4eb9 0001 0c4e            jsr        hclog
[00010988] 3039 0001 5034            move.w     in_screen,d0
[0001098e] 670a                      beq.s      hc_puts_2
[00010990] 72ff                      moveq.l    #-1,d1
[00010992] 7002                      moveq.l    #2,d0
[00010994] 4eb9 0001 10d0            jsr        hc_skipto
hc_puts_2:
[0001099a] 26b9 0001 59b6            move.l     screenbuf,(a3) ; screenbuf_ptr
[000109a0] 4240                      clr.w      d0
[000109a2] 600e                      bra.s      hc_puts_3
hc_puts_1:
[000109a4] 224a                      movea.l    a2,a1
[000109a6] 2053                      movea.l    (a3),a0 ; screenbuf_ptr
[000109a8] 4eb9 0001 3a56            jsr        strcpy
[000109ae] d793                      add.l      d3,(a3) ; screenbuf_ptr
[000109b0] 7001                      moveq.l    #1,d0
hc_puts_3:
[000109b2] 4cdf 0c08                 movem.l    (a7)+,d3/a2-a3
[000109b6] 4e75                      rts

hc_fillbuf:
[000109b8] 3f03                      move.w     d3,-(a7)
[000109ba] 2f0a                      move.l     a2,-(a7)
[000109bc] 45f9 0001 4662            lea.l      hc_inbuf_size,a2
[000109c2] 2279 0001 59b2            movea.l    hc_inbuf,a1
[000109c8] 203c 0000 4000            move.l     #$00004000,d0
[000109ce] 2079 0001 5b02            movea.l    hc_infile,a0
[000109d4] 4eb9 0001 0a94            jsr        hc_fread
[000109da] 2480                      move.l     d0,(a2) ; hc_inbuf_size
[000109dc] 2079 0001 5b02            movea.l    hc_infile,a0
[000109e2] 4eb9 0001 2f84            jsr        ferror
[000109e8] 4a40                      tst.w      d0
[000109ea] 6712                      beq.s      hc_fillbuf_1
[000109ec] 2f39 0001 4942            move.l     err_filename,-(a7)
[000109f2] 4241                      clr.w      d1
[000109f4] 7005                      moveq.l    #5,d0
[000109f6] 4eb9 0001 0c4e            jsr        hclog
[000109fc] 584f                      addq.w     #4,a7
hc_fillbuf_1:
[000109fe] 0c92 0000 4000            cmpi.l     #$00004000,(a2) ; hc_inbuf_size
[00010a04] 6410                      bcc.s      hc_fillbuf_2
[00010a06] 2012                      move.l     (a2),d0 ; hc_inbuf_size
[00010a08] 2079 0001 59b2            movea.l    hc_inbuf,a0
[00010a0e] 11bc 001a 0800            move.b     #$1A,0(a0,d0.l)
[00010a14] 5292                      addq.l     #1,(a2) ; hc_inbuf_size
hc_fillbuf_2:
[00010a16] 23f9 0001 59b2 0001 59ba  move.l     hc_inbuf,hc_inbuf_ptr
[00010a20] 2079 0001 59ba            movea.l    hc_inbuf_ptr,a0
[00010a26] 52b9 0001 59ba            addq.l     #1,hc_inbuf_ptr
[00010a2c] 1610                      move.b     (a0),d3
[00010a2e] b63c 000d                 cmp.b      #$0D,d3
[00010a32] 6618                      bne.s      hc_fillbuf_3
[00010a34] 52b9 0001 5f1a            addq.l     #1,input_lineno
[00010a3a] 3039 0001 5038            move.w     in_link,d0
[00010a40] 670a                      beq.s      hc_fillbuf_3
[00010a42] 7201                      moveq.l    #1,d1
[00010a44] 700f                      moveq.l    #15,d0
[00010a46] 4eb9 0001 0c4e            jsr        hclog
hc_fillbuf_3:
[00010a4c] 1003                      move.b     d3,d0
[00010a4e] 245f                      movea.l    (a7)+,a2
[00010a50] 361f                      move.w     (a7)+,d3
[00010a52] 4e75                      rts

hc_flshbuf:
[00010a54] 2279 0001 59b6            movea.l    screenbuf,a1
[00010a5a] 2039 0001 59be            move.l     screenbuf_ptr,d0
[00010a60] 90b9 0001 59b6            sub.l      screenbuf,d0
[00010a66] 2079 0001 5b06            movea.l    hc_outfile,a0
[00010a6c] 4eb9 0001 0aaa            jsr        hc_fwrite
[00010a72] 4a40                      tst.w      d0
[00010a74] 6612                      bne.s      hc_flshbuf_1
[00010a76] 4879 0001 4946            pea.l      $00014946
[00010a7c] 4241                      clr.w      d1
[00010a7e] 7004                      moveq.l    #4,d0
[00010a80] 4eb9 0001 0c4e            jsr        hclog
[00010a86] 584f                      addq.w     #4,a7
hc_flshbuf_1:
[00010a88] 23f9 0001 59b6 0001 59be  move.l     screenbuf,screenbuf_ptr
[00010a92] 4e75                      rts

hc_fread:
[00010a94] 2f0a                      move.l     a2,-(a7)
[00010a96] 2448                      movea.l    a0,a2
[00010a98] 2200                      move.l     d0,d1
[00010a9a] 2049                      movea.l    a1,a0
[00010a9c] 7001                      moveq.l    #1,d0
[00010a9e] 224a                      movea.l    a2,a1
[00010aa0] 4eb9 0001 30f8            jsr        fread
[00010aa6] 245f                      movea.l    (a7)+,a2
[00010aa8] 4e75                      rts

hc_fwrite:
[00010aaa] 2f03                      move.l     d3,-(a7)
[00010aac] 2f0a                      move.l     a2,-(a7)
[00010aae] 2448                      movea.l    a0,a2
[00010ab0] 2600                      move.l     d0,d3
[00010ab2] 2200                      move.l     d0,d1
[00010ab4] 2049                      movea.l    a1,a0
[00010ab6] 7001                      moveq.l    #1,d0
[00010ab8] 224a                      movea.l    a2,a1
[00010aba] 4eb9 0001 302e            jsr        fwrite
[00010ac0] b680                      cmp.l      d0,d3
[00010ac2] 6704                      beq.s      hc_fwrite_1
[00010ac4] 4240                      clr.w      d0
[00010ac6] 6002                      bra.s      hc_fwrite_2
hc_fwrite_1:
[00010ac8] 7001                      moveq.l    #1,d0
hc_fwrite_2:
[00010aca] 245f                      movea.l    (a7)+,a2
[00010acc] 261f                      move.l     (a7)+,d3
[00010ace] 4e75                      rts

hc_openfile:
[00010ad0] 2f0a                      move.l     a2,-(a7)
[00010ad2] 2448                      movea.l    a0,a2
[00010ad4] 23c8 0001 4942            move.l     a0,err_filename
[00010ada] 4eb9 0001 3bb2            jsr        strupr
[00010ae0] 43f9 0001 4952            lea.l      $00014952,a1
[00010ae6] 204a                      movea.l    a2,a0
[00010ae8] 4eb9 0001 3266            jsr        fopen
[00010aee] 23c8 0001 5b02            move.l     a0,hc_infile
[00010af4] 6612                      bne.s      hc_openfile_1
[00010af6] 2f39 0001 4942            move.l     err_filename,-(a7)
[00010afc] 4241                      clr.w      d1
[00010afe] 7001                      moveq.l    #1,d0
[00010b00] 4eb9 0001 0c4e            jsr        hclog
[00010b06] 584f                      addq.w     #4,a7
hc_openfile_1:
[00010b08] 245f                      movea.l    (a7)+,a2
[00010b0a] 4e75                      rts

hc_createfile:
[00010b0c] 2f0a                      move.l     a2,-(a7)
[00010b0e] 2448                      movea.l    a0,a2
[00010b10] 43f9 0001 4955            lea.l      $00014955,a1
[00010b16] 4eb9 0001 3266            jsr        fopen
[00010b1c] 23c8 0001 5b06            move.l     a0,hc_outfile
[00010b22] 660e                      bne.s      hc_createfile_1
[00010b24] 2f0a                      move.l     a2,-(a7)
[00010b26] 4241                      clr.w      d1
[00010b28] 4240                      clr.w      d0
[00010b2a] 4eb9 0001 0c4e            jsr        hclog
[00010b30] 584f                      addq.w     #4,a7
hc_createfile_1:
[00010b32] 245f                      movea.l    (a7)+,a2
[00010b34] 4e75                      rts

log_open:
[00010b36] 2f0a                      move.l     a2,-(a7)
[00010b38] 594f                      subq.w     #4,a7
[00010b3a] 45f9 0001 4946            lea.l      $00014946,a2
[00010b40] 43ea 0019                 lea.l      25(a2),a1 ; $0001495F
[00010b44] 41ea 0012                 lea.l      18(a2),a0 ; $00014958
[00010b48] 4eb9 0001 3266            jsr        fopen
[00010b4e] 23c8 0001 5b0a            move.l     a0,logfile
[00010b54] 6610                      bne.s      log_open_1
[00010b56] 486a 0012                 pea.l      18(a2) ; $00014958
[00010b5a] 4241                      clr.w      d1
[00010b5c] 4240                      clr.w      d0
[00010b5e] 4eb9 0001 0c4e            jsr        hclog
[00010b64] 584f                      addq.w     #4,a7
log_open_1:
[00010b66] 41d7                      lea.l      (a7),a0
[00010b68] 4eb9 0001 462a            jsr        getdate
[00010b6e] 3f17                      move.w     (a7),-(a7)
[00010b70] 4240                      clr.w      d0
[00010b72] 102f 0005                 move.b     5(a7),d0
[00010b76] 48c0                      ext.l      d0
[00010b78] e588                      lsl.l      #2,d0
[00010b7a] 41f9 0001 570a            lea.l      month_names,a0
[00010b80] 2f30 08fc                 move.l     -4(a0,d0.l),-(a7)
[00010b84] 4241                      clr.w      d1
[00010b86] 122f 0008                 move.b     8(a7),d1
[00010b8a] 3f01                      move.w     d1,-(a7)
[00010b8c] 4879 0001 59c2            pea.l      outfile_name
[00010b92] 43ea 001b                 lea.l      27(a2),a1 ; $00014961
[00010b96] 2079 0001 5b0a            movea.l    logfile,a0
[00010b9c] 4eb9 0001 29c8            jsr        fprintf
[00010ba2] 4fef 000c                 lea.l      12(a7),a7
[00010ba6] 584f                      addq.w     #4,a7
[00010ba8] 245f                      movea.l    (a7)+,a2
[00010baa] 4e75                      rts

hc_closeout:
[00010bac] 2039 0001 5b06            move.l     hc_outfile,d0
[00010bb2] 6708                      beq.s      hc_closeout_1
[00010bb4] 2040                      movea.l    d0,a0
[00010bb6] 4eb9 0001 3436            jsr        fclose
hc_closeout_1:
[00010bbc] 4e75                      rts

log_close:
[00010bbe] 2039 0001 5b0a            move.l     logfile,d0
[00010bc4] 6728                      beq.s      log_close_1
[00010bc6] 2f39 0001 4b62            move.l     warnings_total,-(a7)
[00010bcc] 2f39 0001 4b5e            move.l     errors_total,-(a7)
[00010bd2] 43f9 0001 4a7c            lea.l      $00014A7C,a1
[00010bd8] 2040                      movea.l    d0,a0
[00010bda] 4eb9 0001 29c8            jsr        fprintf
[00010be0] 504f                      addq.w     #8,a7
[00010be2] 2079 0001 5b0a            movea.l    logfile,a0
[00010be8] 4eb9 0001 3436            jsr        fclose
log_close_1:
[00010bee] 4e75                      rts

hc_closein:
[00010bf0] 42b9 0001 4942            clr.l      err_filename
[00010bf6] 2039 0001 5b02            move.l     hc_infile,d0
[00010bfc] 6708                      beq.s      hc_closein_1
[00010bfe] 2040                      movea.l    d0,a0
[00010c00] 4eb9 0001 3436            jsr        fclose
hc_closein_1:
[00010c06] 4e75                      rts

hc_copyfile:
[00010c08] 2f0a                      move.l     a2,-(a7)
[00010c0a] 2f0b                      move.l     a3,-(a7)
[00010c0c] 2448                      movea.l    a0,a2
[00010c0e] 6100 fec0                 bsr        hc_openfile
[00010c12] 45f9 0001 59b2            lea.l      hc_inbuf,a2
[00010c18] 47f9 0001 5b02            lea.l      hc_infile,a3
[00010c1e] 6018                      bra.s      hc_copyfile_1
hc_copyfile_2:
[00010c20] 2252                      movea.l    (a2),a1 ; hc_inbuf
[00010c22] 203c 0000 4000            move.l     #$00004000,d0
[00010c28] 2053                      movea.l    (a3),a0 ; hc_infile
[00010c2a] 6100 fe68                 bsr        hc_fread
[00010c2e] 206b 0004                 movea.l    4(a3),a0 ; hc_outfile
[00010c32] 2252                      movea.l    (a2),a1 ; hc_inbuf
[00010c34] 6100 fe74                 bsr        hc_fwrite
hc_copyfile_1:
[00010c38] 2053                      movea.l    (a3),a0 ; hc_infile
[00010c3a] 4eb9 0001 2f78            jsr        feof
[00010c40] 4a40                      tst.w      d0
[00010c42] 67dc                      beq.s      hc_copyfile_2
[00010c44] 6100 ffaa                 bsr.w      hc_closein
[00010c48] 265f                      movea.l    (a7)+,a3
[00010c4a] 245f                      movea.l    (a7)+,a2
[00010c4c] 4e75                      rts

hclog:
[00010c4e] 48e7 1830                 movem.l    d3-d4/a2-a3,-(a7)
[00010c52] 4fef ff00                 lea.l      -256(a7),a7
[00010c56] 3800                      move.w     d0,d4
[00010c58] 3601                      move.w     d1,d3
[00010c5a] 45ef 0114                 lea.l      276(a7),a2
[00010c5e] 47f9 0001 4bd2            lea.l      $00014BD2,a3
[00010c64] 4a43                      tst.w      d3
[00010c66] 660c                      bne.s      hclog_1
[00010c68] 41eb 0292                 lea.l      658(a3),a0 ; $00014E64
[00010c6c] 4eb9 0001 0d74            jsr        logstr
[00010c72] 6074                      bra.s      hclog_2
hclog_1:
[00010c74] b67c 0001                 cmp.w      #$0001,d3
[00010c78] 6618                      bne.s      hclog_3
[00010c7a] 41eb 029a                 lea.l      666(a3),a0 ; $00014E6C
[00010c7e] 4eb9 0001 0d74            jsr        logstr
[00010c84] 5279 0001 5b12            addq.w     #1,errors_thisfile
[00010c8a] 52b9 0001 4b5e            addq.l     #1,errors_total
[00010c90] 6016                      bra.s      hclog_4
hclog_3:
[00010c92] 41eb 02a1                 lea.l      673(a3),a0 ; $00014E73
[00010c96] 4eb9 0001 0d74            jsr        logstr
[00010c9c] 5279 0001 5b14            addq.w     #1,warnings_thisfile
[00010ca2] 52b9 0001 4b62            addq.l     #1,warnings_total
hclog_4:
[00010ca8] 2039 0001 4942            move.l     err_filename,d0
[00010cae] 6738                      beq.s      hclog_2
[00010cb0] 2f00                      move.l     d0,-(a7)
[00010cb2] 43eb 02aa                 lea.l      682(a3),a1 ; $00014E7C
[00010cb6] 41ef 0004                 lea.l      4(a7),a0
[00010cba] 4eb9 0001 2a06            jsr        sprintf
[00010cc0] 584f                      addq.w     #4,a7
[00010cc2] 41d7                      lea.l      (a7),a0
[00010cc4] 4eb9 0001 0d74            jsr        logstr
[00010cca] 2f39 0001 5b0e            move.l     err_lineno,-(a7)
[00010cd0] 43eb 02ae                 lea.l      686(a3),a1 ; $00014E80
[00010cd4] 41ef 0004                 lea.l      4(a7),a0
[00010cd8] 4eb9 0001 2a06            jsr        sprintf
[00010cde] 584f                      addq.w     #4,a7
[00010ce0] 41d7                      lea.l      (a7),a0
[00010ce2] 4eb9 0001 0d74            jsr        logstr
hclog_2:
[00010ce8] 2f0a                      move.l     a2,-(a7)
[00010cea] 3004                      move.w     d4,d0
[00010cec] e548                      lsl.w      #2,d0
[00010cee] 41f9 0001 4b66            lea.l      errmsg,a0
[00010cf4] 2270 0000                 movea.l    0(a0,d0.w),a1
[00010cf8] 41ef 0004                 lea.l      4(a7),a0
[00010cfc] 4eb9 0001 2a38            jsr        vsprintf
[00010d02] 584f                      addq.w     #4,a7
[00010d04] 41d7                      lea.l      (a7),a0
[00010d06] 4eb9 0001 0d74            jsr        logstr
[00010d0c] 41eb 02b4                 lea.l      692(a3),a0 ; $00014E86
[00010d10] 4eb9 0001 0d74            jsr        logstr
[00010d16] 4a43                      tst.w      d3
[00010d18] 6610                      bne.s      hclog_5
[00010d1a] 41eb 02b6                 lea.l      694(a3),a0 ; $00014E88
[00010d1e] 4eb9 0001 0d74            jsr        logstr
[00010d24] 4eb9 0001 0d34            jsr        cleanup
hclog_5:
[00010d2a] 4fef 0100                 lea.l      256(a7),a7
[00010d2e] 4cdf 0c18                 movem.l    (a7)+,d3-d4/a2-a3
[00010d32] 4e75                      rts

cleanup:
[00010d34] 4eb9 0001 0bbe            jsr        log_close
[00010d3a] 4eb9 0001 0bf0            jsr        hc_closein
[00010d40] 4eb9 0001 0bac            jsr        hc_closeout
[00010d46] 41f9 0001 4e9c            lea.l      $00014E9C,a0
[00010d4c] 4eb9 0001 367c            jsr        unlink
[00010d52] 41f9 0001 4ea3            lea.l      $00014EA3,a0
[00010d58] 4eb9 0001 367c            jsr        unlink
[00010d5e] 41f9 0001 4eaa            lea.l      $00014EAA,a0
[00010d64] 4eb9 0001 367c            jsr        unlink
[00010d6a] 70ff                      moveq.l    #-1,d0
[00010d6c] 4eb9 0001 0172            jsr        exit
[00010d72] 4e75                      rts

logstr:
[00010d74] 2f0a                      move.l     a2,-(a7)
[00010d76] 2448                      movea.l    a0,a2
[00010d78] 2039 0001 5b0a            move.l     logfile,d0
[00010d7e] 670a                      beq.s      logstr_1
[00010d80] 2248                      movea.l    a0,a1
[00010d82] 2040                      movea.l    d0,a0
[00010d84] 4eb9 0001 29c8            jsr        fprintf
logstr_1:
[00010d8a] 224a                      movea.l    a2,a1
[00010d8c] 41f9 0001 5928            lea.l      stdout,a0
[00010d92] 4eb9 0001 29c8            jsr        fprintf
[00010d98] 245f                      movea.l    (a7)+,a2
[00010d9a] 4e75                      rts

parse_file:
[00010d9c] 48e7 1c3e                 movem.l    d3-d5/a2-a6,-(a7)
[00010da0] 4fef ff00                 lea.l      -256(a7),a7
[00010da4] 7601                      moveq.l    #1,d3
parse_file_9:
[00010da6] 4df9 0001 5928            lea.l      stdout,a6
[00010dac] 4bf9 0001 5b16            lea.l      cur_identifier,a5
[00010db2] 49f9 0001 5f16            lea.l      hc_curtok,a4
[00010db8] 47f9 0001 5072            lea.l      screen_cnt,a3
[00010dbe] 45f9 0001 5034            lea.l      in_screen,a2
[00010dc4] 4eb9 0001 1100            jsr        hc_gettok
[00010dca] b07c 000f                 cmp.w      #$000F,d0
[00010dce] 6200 0246                 bhi        parse_file_1
[00010dd2] d040                      add.w      d0,d0
[00010dd4] 303b 0006                 move.w     $00010DDC(pc,d0.w),d0
[00010dd8] 4efb 0002                 jmp        $00010DDC(pc,d0.w)
J2: ; not found: 00010ddc
[00010ddc] 0020                      dc.w $0020   ; parse_file_2-J2
[00010dde] 0034                      dc.w $0034   ; parse_file_3-J2
[00010de0] 00f4                      dc.w $00f4   ; parse_file_4-J2
[00010de2] 012c                      dc.w $012c   ; parse_file_5-J2
[00010de4] 023a                      dc.w $023a   ; parse_file_1-J2
[00010de6] 023a                      dc.w $023a   ; parse_file_1-J2
[00010de8] 023a                      dc.w $023a   ; parse_file_1-J2
[00010dea] 023a                      dc.w $023a   ; parse_file_1-J2
[00010dec] 01aa                      dc.w $01aa   ; parse_file_6-J2
[00010dee] 01c8                      dc.w $01c8   ; parse_file_7-J2
[00010df0] 0172                      dc.w $0172   ; parse_file_8-J2
[00010df2] 023a                      dc.w $023a   ; parse_file_1-J2
[00010df4] 023a                      dc.w $023a   ; parse_file_1-J2
[00010df6] ffca                      dc.w $ffca   ; parse_file_9-J2
[00010df8] 022a                      dc.w $022a   ; parse_file_10-J2
[00010dfa] ffca                      dc.w $ffca   ; parse_file_9-J2
parse_file_2:
[00010dfc] 3012                      move.w     (a2),d0 ; in_screen
[00010dfe] 6700 0224                 beq        parse_file_11
[00010e02] 7201                      moveq.l    #1,d1
[00010e04] 700b                      moveq.l    #11,d0
[00010e06] 4eb9 0001 0c4e            jsr        hclog
[00010e0c] 6000 0216                 bra        parse_file_11
parse_file_3:
[00010e10] 5253                      addq.w     #1,(a3) ; screen_cnt
[00010e12] 7801                      moveq.l    #1,d4
[00010e14] 3004                      move.w     d4,d0
[00010e16] 4eb9 0001 1088            jsr        parse_parameters
[00010e1c] 4a40                      tst.w      d0
[00010e1e] 6700 008e                 beq        parse_file_12
parse_file_23:
[00010e22] 3014                      move.w     (a4),d0 ; hc_curtok
[00010e24] 5940                      subq.w     #4,d0
[00010e26] 6758                      beq.s      parse_file_13
[00010e28] 5f40                      subq.w     #7,d0
[00010e2a] 6708                      beq.s      parse_file_14
[00010e2c] 5340                      subq.w     #1,d0
[00010e2e] 6702                      beq.s      parse_file_15
[00010e30] 605c                      bra.s      parse_file_16
parse_file_15:
[00010e32] 7602                      moveq.l    #2,d3
parse_file_14:
[00010e34] 4240                      clr.w      d0
[00010e36] 4eb9 0001 1088            jsr        parse_parameters
[00010e3c] 4a40                      tst.w      d0
[00010e3e] 673c                      beq.s      parse_file_17
[00010e40] 0c54 0004                 cmpi.w     #$0004,(a4) ; hc_curtok
[00010e44] 661c                      bne.s      parse_file_18
[00010e46] b67c 0002                 cmp.w      #$0002,d3
[00010e4a] 6608                      bne.s      parse_file_19
[00010e4c] 204d                      movea.l    a5,a0
[00010e4e] 4eb9 0001 3bb2            jsr        strupr
parse_file_19:
[00010e54] 3203                      move.w     d3,d1
[00010e56] 3013                      move.w     (a3),d0 ; screen_cnt
[00010e58] 204d                      movea.l    a5,a0
[00010e5a] 4eb9 0001 1c3c            jsr        add_index_entry
[00010e60] 600c                      bra.s      parse_file_20
parse_file_18:
[00010e62] 7201                      moveq.l    #1,d1
[00010e64] 7010                      moveq.l    #16,d0
[00010e66] 4eb9 0001 0c4e            jsr        hclog
[00010e6c] 4244                      clr.w      d4
parse_file_20:
[00010e6e] 4240                      clr.w      d0
[00010e70] 4eb9 0001 102e            jsr        next_parameter
[00010e76] 4a40                      tst.w      d0
[00010e78] 6702                      beq.s      parse_file_17
[00010e7a] 4244                      clr.w      d4
parse_file_17:
[00010e7c] 7601                      moveq.l    #1,d3
[00010e7e] 601a                      bra.s      parse_file_21
parse_file_13:
[00010e80] 4241                      clr.w      d1
[00010e82] 3013                      move.w     (a3),d0 ; screen_cnt
[00010e84] 204d                      movea.l    a5,a0
[00010e86] 4eb9 0001 1c3c            jsr        add_index_entry
[00010e8c] 600c                      bra.s      parse_file_21
parse_file_16:
[00010e8e] 7201                      moveq.l    #1,d1
[00010e90] 7010                      moveq.l    #16,d0
[00010e92] 4eb9 0001 0c4e            jsr        hclog
[00010e98] 4244                      clr.w      d4
parse_file_21:
[00010e9a] 4a44                      tst.w      d4
[00010e9c] 6712                      beq.s      parse_file_22
[00010e9e] 7001                      moveq.l    #1,d0
[00010ea0] 4eb9 0001 102e            jsr        next_parameter
[00010ea6] 4a40                      tst.w      d0
[00010ea8] 6600 ff78                 bne        parse_file_23
[00010eac] 6002                      bra.s      parse_file_22
parse_file_12:
[00010eae] 4244                      clr.w      d4
parse_file_22:
[00010eb0] 4a44                      tst.w      d4
[00010eb2] 670e                      beq.s      parse_file_24
[00010eb4] 34bc 0001                 move.w     #$0001,(a2) ; in_screen
[00010eb8] 4eb9 0001 148c            jsr        skip_space
[00010ebe] 6000 fee6                 bra        parse_file_9
parse_file_24:
[00010ec2] 72fe                      moveq.l    #-2,d1
[00010ec4] 7001                      moveq.l    #1,d0
[00010ec6] 4eb9 0001 10d0            jsr        hc_skipto
[00010ecc] 6000 fed8                 bra        parse_file_9
parse_file_4:
[00010ed0] 4252                      clr.w      (a2) ; in_screen
[00010ed2] 3013                      move.w     (a3),d0 ; screen_cnt
[00010ed4] 48c0                      ext.l      d0
[00010ed6] e588                      lsl.l      #2,d0
[00010ed8] 2079 0001 62f6            movea.l    screen_table_offset,a0
[00010ede] 21b9 0001 5078 08fc       move.l     screen_start,-4(a0,d0.l)
[00010ee6] 2039 0001 59be            move.l     screenbuf_ptr,d0
[00010eec] 90b9 0001 59b6            sub.l      screenbuf,d0
[00010ef2] d1b9 0001 5078            add.l      d0,screen_start
[00010ef8] 4eb9 0001 0a54            jsr        hc_flshbuf
[00010efe] 42b9 0001 5074            clr.l      last_indexentry_name
[00010f04] 6000 fea0                 bra        parse_file_9
parse_file_5:
[00010f08] 3a12                      move.w     (a2),d5 ; in_screen
[00010f0a] 4252                      clr.w      (a2) ; in_screen
[00010f0c] 7001                      moveq.l    #1,d0
[00010f0e] 4eb9 0001 1088            jsr        parse_parameters
[00010f14] 4a40                      tst.w      d0
[00010f16] 6700 00e8                 beq        parse_file_25
parse_file_28:
[00010f1a] 0c54 0004                 cmpi.w     #$0004,(a4) ; hc_curtok
[00010f1e] 6614                      bne.s      parse_file_26
[00010f20] 4855                      pea.l      (a5) ; cur_identifier
[00010f22] 43f9 0001 4eb4            lea.l      $00014EB4,a1
[00010f28] 204e                      movea.l    a6,a0
[00010f2a] 4eb9 0001 29c8            jsr        fprintf
[00010f30] 584f                      addq.w     #4,a7
[00010f32] 600a                      bra.s      parse_file_27
parse_file_26:
[00010f34] 7201                      moveq.l    #1,d1
[00010f36] 7010                      moveq.l    #16,d0
[00010f38] 4eb9 0001 0c4e            jsr        hclog
parse_file_27:
[00010f3e] 7001                      moveq.l    #1,d0
[00010f40] 4eb9 0001 102e            jsr        next_parameter
[00010f46] 4a40                      tst.w      d0
[00010f48] 66d0                      bne.s      parse_file_28
[00010f4a] 6000 00b4                 bra        parse_file_25
parse_file_8:
[00010f4e] 43f9 0001 4ec0            lea.l      $00014EC0,a1
[00010f54] 41f9 0001 593e            lea.l      stderr,a0
[00010f5a] 4eb9 0001 29c8            jsr        fprintf
[00010f60] 41f9 0001 58c2            lea.l      $000158C2,a0
[00010f66] 4eb9 0001 317e            jsr        fgetc
[00010f6c] b03c 006e                 cmp.b      #$6E,d0
[00010f70] 6708                      beq.s      parse_file_29
[00010f72] b03c 004e                 cmp.b      #$4E,d0
[00010f76] 6600 fe2e                 bne        parse_file_9
parse_file_29:
[00010f7a] 4240                      clr.w      d0
[00010f7c] 4eb9 0001 0172            jsr        exit
[00010f82] 6000 fe22                 bra        parse_file_9
parse_file_6:
[00010f86] 3012                      move.w     (a2),d0 ; in_screen
[00010f88] 670c                      beq.s      parse_file_30
[00010f8a] 91c8                      suba.l     a0,a0
[00010f8c] 4eb9 0001 1388            jsr        parse_link
[00010f92] 6000 fe12                 bra        parse_file_9
parse_file_30:
[00010f96] 7201                      moveq.l    #1,d1
[00010f98] 700d                      moveq.l    #13,d0
[00010f9a] 4eb9 0001 0c4e            jsr        hclog
[00010fa0] 6000 fe04                 bra        parse_file_9
parse_file_7:
[00010fa4] 3a12                      move.w     (a2),d5 ; in_screen
[00010fa6] 4252                      clr.w      (a2) ; in_screen
[00010fa8] 4a45                      tst.w      d5
[00010faa] 674a                      beq.s      parse_file_31
[00010fac] 4240                      clr.w      d0
[00010fae] 4eb9 0001 1088            jsr        parse_parameters
[00010fb4] 4a40                      tst.w      d0
[00010fb6] 673e                      beq.s      parse_file_31
[00010fb8] 0c54 0004                 cmpi.w     #$0004,(a4) ; hc_curtok
[00010fbc] 6620                      bne.s      parse_file_32
[00010fbe] 224d                      movea.l    a5,a1
[00010fc0] 41d7                      lea.l      (a7),a0
[00010fc2] 4eb9 0001 3a56            jsr        strcpy
[00010fc8] 4240                      clr.w      d0
[00010fca] 4eb9 0001 102e            jsr        next_parameter
[00010fd0] 3485                      move.w     d5,(a2) ; in_screen
[00010fd2] 41d7                      lea.l      (a7),a0
[00010fd4] 4eb9 0001 1388            jsr        parse_link
[00010fda] 6000 fdca                 bra        parse_file_9
parse_file_32:
[00010fde] 7201                      moveq.l    #1,d1
[00010fe0] 7010                      moveq.l    #16,d0
[00010fe2] 4eb9 0001 0c4e            jsr        hclog
[00010fe8] 72fe                      moveq.l    #-2,d1
[00010fea] 7008                      moveq.l    #8,d0
[00010fec] 4eb9 0001 10d0            jsr        hc_skipto
[00010ff2] 6000 fdb2                 bra        parse_file_9
parse_file_31:
[00010ff6] 7201                      moveq.l    #1,d1
[00010ff8] 700d                      moveq.l    #13,d0
[00010ffa] 4eb9 0001 0c4e            jsr        hclog
parse_file_25:
[00011000] 3485                      move.w     d5,(a2) ; in_screen
[00011002] 6000 fda2                 bra        parse_file_9
parse_file_10:
[00011006] 3012                      move.w     (a2),d0 ; in_screen
[00011008] 678c                      beq.s      parse_file_30
[0001100a] 701a                      moveq.l    #26,d0
[0001100c] 4eb9 0001 08ea            jsr        hc_putc
[00011012] 6000 fd92                 bra        parse_file_9
parse_file_1:
[00011016] 7201                      moveq.l    #1,d1
[00011018] 7008                      moveq.l    #8,d0
[0001101a] 4eb9 0001 0c4e            jsr        hclog
[00011020] 6000 fd84                 bra        parse_file_9
parse_file_11:
[00011024] 4fef 0100                 lea.l      256(a7),a7
[00011028] 4cdf 7c38                 movem.l    (a7)+,d3-d5/a2-a6
[0001102c] 4e75                      rts

next_parameter:
[0001102e] 2f03                      move.l     d3,-(a7)
[00011030] 3f04                      move.w     d4,-(a7)
[00011032] 3800                      move.w     d0,d4
[00011034] 4243                      clr.w      d3
next_parameter_8:
[00011036] 4eb9 0001 1100            jsr        hc_gettok
[0001103c] 3039 0001 5f16            move.w     hc_curtok,d0
[00011042] 5b40                      subq.w     #5,d0
[00011044] 670a                      beq.s      next_parameter_1
[00011046] 5340                      subq.w     #1,d0
[00011048] 6712                      beq.s      next_parameter_2
[0001104a] 5340                      subq.w     #1,d0
[0001104c] 6712                      beq.s      next_parameter_3
[0001104e] 6030                      bra.s      next_parameter_4
next_parameter_1:
[00011050] 7201                      moveq.l    #1,d1
[00011052] 7017                      moveq.l    #23,d0
[00011054] 4eb9 0001 0c4e            jsr        hclog
[0001105a] 6024                      bra.s      next_parameter_4
next_parameter_2:
[0001105c] 4240                      clr.w      d0
[0001105e] 6022                      bra.s      next_parameter_5
next_parameter_3:
[00011060] 4a44                      tst.w      d4
[00011062] 660a                      bne.s      next_parameter_6
[00011064] 7201                      moveq.l    #1,d1
[00011066] 7018                      moveq.l    #24,d0
[00011068] 4eb9 0001 0c4e            jsr        hclog
next_parameter_6:
[0001106e] 4a43                      tst.w      d3
[00011070] 670a                      beq.s      next_parameter_7
[00011072] 7202                      moveq.l    #2,d1
[00011074] 7019                      moveq.l    #25,d0
[00011076] 4eb9 0001 0c4e            jsr        hclog
next_parameter_7:
[0001107c] 7601                      moveq.l    #1,d3
[0001107e] 60b6                      bra.s      next_parameter_8
next_parameter_4:
[00011080] 7001                      moveq.l    #1,d0
next_parameter_5:
[00011082] 381f                      move.w     (a7)+,d4
[00011084] 261f                      move.l     (a7)+,d3
[00011086] 4e75                      rts

parse_parameters:
[00011088] 3f03                      move.w     d3,-(a7)
[0001108a] 3600                      move.w     d0,d3
[0001108c] 4eb9 0001 1100            jsr        hc_gettok
[00011092] 0c79 0005 0001 5f16       cmpi.w     #$0005,hc_curtok
[0001109a] 6716                      beq.s      parse_parameters_1
[0001109c] 7201                      moveq.l    #1,d1
[0001109e] 7009                      moveq.l    #9,d0
[000110a0] 4eb9 0001 0c4e            jsr        hclog
[000110a6] 7202                      moveq.l    #2,d1
[000110a8] 7006                      moveq.l    #6,d0
[000110aa] 4eb9 0001 10d0            jsr        hc_skipto
[000110b0] 6014                      bra.s      parse_parameters_2
parse_parameters_1:
[000110b2] 3003                      move.w     d3,d0
[000110b4] 6100 ff78                 bsr        next_parameter
[000110b8] 4a40                      tst.w      d0
[000110ba] 660e                      bne.s      parse_parameters_3
[000110bc] 7201                      moveq.l    #1,d1
[000110be] 7009                      moveq.l    #9,d0
[000110c0] 4eb9 0001 0c4e            jsr        hclog
parse_parameters_2:
[000110c6] 4240                      clr.w      d0
[000110c8] 6002                      bra.s      parse_parameters_4
parse_parameters_3:
[000110ca] 7001                      moveq.l    #1,d0
parse_parameters_4:
[000110cc] 361f                      move.w     (a7)+,d3
[000110ce] 4e75                      rts

hc_skipto:
[000110d0] 3f03                      move.w     d3,-(a7)
[000110d2] 3f04                      move.w     d4,-(a7)
[000110d4] 3600                      move.w     d0,d3
[000110d6] 3801                      move.w     d1,d4
[000110d8] 6006                      bra.s      hc_skipto_1
hc_skipto_3:
[000110da] 4eb9 0001 1100            jsr        hc_gettok
hc_skipto_1:
[000110e0] 3039 0001 5f16            move.w     hc_curtok,d0
[000110e6] 670c                      beq.s      hc_skipto_2
[000110e8] b640                      cmp.w      d0,d3
[000110ea] 6708                      beq.s      hc_skipto_2
[000110ec] b879 0001 5f18            cmp.w      hc_curscope,d4
[000110f2] 66e6                      bne.s      hc_skipto_3
hc_skipto_2:
[000110f4] 4eb9 0001 1256            jsr        hc_backtok
[000110fa] 381f                      move.w     (a7)+,d4
[000110fc] 361f                      move.w     (a7)+,d3
[000110fe] 4e75                      rts

hc_gettok:
[00011100] 48e7 1838                 movem.l    d3-d4/a2-a4,-(a7)
[00011104] 49f9 0001 5f16            lea.l      hc_curtok,a4
[0001110a] 23ec 0004 0001 5b0e       move.l     4(a4),err_lineno ; input_lineno
[00011112] 45f9 0001 466a            lea.l      options.create_log,a2
[00011118] 47f9 0001 4ef2            lea.l      character_class,a3
[0001111e] 302b 0144                 move.w     324(a3),d0 ; backtok
[00011122] 6708                      beq.s      hc_gettok_1
[00011124] 426b 0144                 clr.w      324(a3) ; backtok
[00011128] 6000 00ec                 bra        hc_gettok_2
hc_gettok_1:
[0001112c] 4eb9 0001 088c            jsr        hc_getc
[00011132] 1600                      move.b     d0,d3
[00011134] 322b 0142                 move.w     322(a3),d1 ; in_screen
[00011138] 6700 0088                 beq        hc_gettok_3
[0001113c] b03c 001a                 cmp.b      #$1A,d0
[00011140] 6700 0080                 beq        hc_gettok_3 ; possibly optimized to short
hc_gettok_12:
[00011144] 4240                      clr.w      d0
[00011146] 1003                      move.b     d3,d0
[00011148] 907c 0009                 sub.w      #$0009,d0
[0001114c] 673a                      beq.s      hc_gettok_4
[0001114e] 907c 0014                 sub.w      #$0014,d0
[00011152] 6708                      beq.s      hc_gettok_5
[00011154] 907c 003f                 sub.w      #$003F,d0
[00011158] 6716                      beq.s      hc_gettok_6
[0001115a] 6052                      bra.s      hc_gettok_7
hc_gettok_5:
[0001115c] 4240                      clr.w      d0
[0001115e] 1003                      move.b     d3,d0
[00011160] 3f00                      move.w     d0,-(a7)
[00011162] 7201                      moveq.l    #1,d1
[00011164] 7016                      moveq.l    #22,d0
[00011166] 4eb9 0001 0c4e            jsr        hclog
[0001116c] 544f                      addq.w     #2,a7
[0001116e] 6046                      bra.s      hc_gettok_8
hc_gettok_6:
[00011170] 4eb9 0001 088c            jsr        hc_getc
[00011176] 1600                      move.b     d0,d3
[00011178] b03c 005c                 cmp.b      #$5C,d0
[0001117c] 6644                      bne.s      hc_gettok_3
[0001117e] 705c                      moveq.l    #92,d0
[00011180] 4eb9 0001 08ea            jsr        hc_putc
[00011186] 602e                      bra.s      hc_gettok_8
hc_gettok_4:
[00011188] 302a 0008                 move.w     8(a2),d0 ; options.tabsize
[0001118c] 6716                      beq.s      hc_gettok_9
[0001118e] 4244                      clr.w      d4
[00011190] 600a                      bra.s      hc_gettok_10
hc_gettok_11:
[00011192] 7020                      moveq.l    #32,d0
[00011194] 4eb9 0001 08ea            jsr        hc_putc
[0001119a] 5244                      addq.w     #1,d4
hc_gettok_10:
[0001119c] b86a 0008                 cmp.w      8(a2),d4 ; options.tabsize
[000111a0] 6df0                      blt.s      hc_gettok_11
[000111a2] 6012                      bra.s      hc_gettok_8
hc_gettok_9:
[000111a4] 7009                      moveq.l    #9,d0
[000111a6] 4eb9 0001 08ea            jsr        hc_putc
[000111ac] 6008                      bra.s      hc_gettok_8
hc_gettok_7:
[000111ae] 1003                      move.b     d3,d0
[000111b0] 4eb9 0001 08ea            jsr        hc_putc
hc_gettok_8:
[000111b6] 4eb9 0001 088c            jsr        hc_getc
[000111bc] 1600                      move.b     d0,d3
[000111be] 6000 ff84                 bra.w      hc_gettok_12
hc_gettok_3:
[000111c2] 4240                      clr.w      d0
[000111c4] 1003                      move.b     d3,d0
[000111c6] 1033 0000                 move.b     0(a3,d0.w),d0
[000111ca] 426c 0002                 clr.w      2(a4) ; hc_curscope
[000111ce] 4241                      clr.w      d1
[000111d0] 1200                      move.b     d0,d1
[000111d2] 5941                      subq.w     #4,d1
[000111d4] b27c 0010                 cmp.w      #$0010,d1
[000111d8] 6200 ff52                 bhi        hc_gettok_1
[000111dc] d241                      add.w      d1,d1
[000111de] 323b 1006                 move.w     $000111E6(pc,d1.w),d1
[000111e2] 4efb 1002                 jmp        $000111E6(pc,d1.w)
J3: ; not found: 000111e6
[000111e6] 003e                      dc.w $003e   ; hc_gettok_13-J3
[000111e8] 0050                      dc.w $0050   ; hc_gettok_14-J3
[000111ea] 0060                      dc.w $0060   ; hc_gettok_15-J3
[000111ec] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111ee] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111f0] 005a                      dc.w $005a   ; hc_gettok_16-J3
[000111f2] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111f4] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111f6] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111f8] 0022                      dc.w $0022   ; hc_gettok_17-J3
[000111fa] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111fc] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[000111fe] 0034                      dc.w $0034   ; hc_gettok_18-J3
[00011200] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[00011202] ff46                      dc.w $ff46   ; hc_gettok_1-J3
[00011204] 0044                      dc.w $0044   ; hc_gettok_19-J3
[00011206] 004a                      dc.w $004a   ; hc_gettok_20-J3
hc_gettok_17:
[00011208] 1003                      move.b     d3,d0
[0001120a] 4eb9 0001 127a            jsr        parse_identifier
[00011210] 4eb9 0001 1328            jsr        parse_keyword
hc_gettok_2:
[00011216] 3014                      move.w     (a4),d0 ; hc_curtok
[00011218] 6036                      bra.s      hc_gettok_21
hc_gettok_18:
[0001121a] 4eb9 0001 142a            jsr        parse_braces
[00011220] 6000 ff0a                 bra        hc_gettok_1
hc_gettok_13:
[00011224] 4240                      clr.w      d0
[00011226] 3880                      move.w     d0,(a4) ; hc_curtok
[00011228] 6026                      bra.s      hc_gettok_21
hc_gettok_19:
[0001122a] 7005                      moveq.l    #5,d0
[0001122c] 3880                      move.w     d0,(a4) ; hc_curtok
[0001122e] 6020                      bra.s      hc_gettok_21
hc_gettok_20:
[00011230] 7006                      moveq.l    #6,d0
[00011232] 3880                      move.w     d0,(a4) ; hc_curtok
[00011234] 601a                      bra.s      hc_gettok_21
hc_gettok_14:
[00011236] 4eb9 0001 12b6            jsr        parse_string
[0001123c] 7004                      moveq.l    #4,d0
[0001123e] 6010                      bra.s      hc_gettok_21
hc_gettok_16:
[00011240] 7007                      moveq.l    #7,d0
[00011242] 3880                      move.w     d0,(a4) ; hc_curtok
[00011244] 600a                      bra.s      hc_gettok_21
hc_gettok_15:
[00011246] 397c 0002 0002            move.w     #$0002,2(a4) ; hc_curscope
[0001124c] 7008                      moveq.l    #8,d0
[0001124e] 3880                      move.w     d0,(a4) ; hc_curtok
hc_gettok_21:
[00011250] 4cdf 1c18                 movem.l    (a7)+,d3-d4/a2-a4
[00011254] 4e75                      rts

hc_backtok:
[00011256] 33fc 0001 0001 5036       move.w     #$0001,backtok
[0001125e] 4e75                      rts

hc_back:
[00011260] 53b9 0001 59ba            subq.l     #1,hc_inbuf_ptr
[00011266] 2079 0001 59ba            movea.l    hc_inbuf_ptr,a0
[0001126c] 0c10 000d                 cmpi.b     #$0D,(a0)
[00011270] 6606                      bne.s      hc_back_1
[00011272] 53b9 0001 5f1a            subq.l     #1,input_lineno
hc_back_1:
[00011278] 4e75                      rts

parse_identifier:
[0001127a] 48e7 1030                 movem.l    d3/a2-a3,-(a7)
[0001127e] 1600                      move.b     d0,d3
[00011280] 45f9 0001 5b16            lea.l      cur_identifier,a2
parse_identifier_1:
[00011286] 47f9 0001 4ef2            lea.l      character_class,a3
[0001128c] 14c3                      move.b     d3,(a2)+
[0001128e] 4eb9 0001 088c            jsr        hc_getc
[00011294] 1600                      move.b     d0,d3
[00011296] 4241                      clr.w      d1
[00011298] 1200                      move.b     d0,d1
[0001129a] 0c33 000d 1000            cmpi.b     #$0D,0(a3,d1.w)
[000112a0] 67e4                      beq.s      parse_identifier_1
[000112a2] 0c33 000c 1000            cmpi.b     #$0C,0(a3,d1.w)
[000112a8] 67dc                      beq.s      parse_identifier_1
[000112aa] 4212                      clr.b      (a2) ; cur_identifier
[000112ac] 6100 ffb2                 bsr.w      hc_back
[000112b0] 4cdf 0c08                 movem.l    (a7)+,d3/a2-a3
[000112b4] 4e75                      rts

parse_string:
[000112b6] 48e7 1030                 movem.l    d3/a2-a3,-(a7)
[000112ba] 45f9 0001 5b16            lea.l      cur_identifier,a2
parse_string_3:
[000112c0] 47f9 0001 4ef2            lea.l      character_class,a3
[000112c6] 4eb9 0001 088c            jsr        hc_getc
[000112cc] 1600                      move.b     d0,d3
[000112ce] b03c 005c                 cmp.b      #$5C,d0
[000112d2] 6610                      bne.s      parse_string_1
[000112d4] 4eb9 0001 088c            jsr        hc_getc
[000112da] 14c0                      move.b     d0,(a2)+
[000112dc] 4eb9 0001 088c            jsr        hc_getc
[000112e2] 1600                      move.b     d0,d3
parse_string_1:
[000112e4] 14c3                      move.b     d3,(a2)+
[000112e6] 4240                      clr.w      d0
[000112e8] 1003                      move.b     d3,d0
[000112ea] 0c33 0005 0000            cmpi.b     #$05,0(a3,d0.w)
[000112f0] 6708                      beq.s      parse_string_2
[000112f2] 0c33 0002 0000            cmpi.b     #$02,0(a3,d0.w)
[000112f8] 66c6                      bne.s      parse_string_3
parse_string_2:
[000112fa] 4240                      clr.w      d0
[000112fc] 1003                      move.b     d3,d0
[000112fe] 0c33 0002 0000            cmpi.b     #$02,0(a3,d0.w)
[00011304] 660a                      bne.s      parse_string_4
[00011306] 7201                      moveq.l    #1,d1
[00011308] 7012                      moveq.l    #18,d0
[0001130a] 4eb9 0001 0c4e            jsr        hclog
parse_string_4:
[00011310] 4222                      clr.b      -(a2)
[00011312] 33fc 0004 0001 5f16       move.w     #$0004,hc_curtok
[0001131a] 33fc 0001 0001 5f18       move.w     #$0001,hc_curscope
[00011322] 4cdf 0c08                 movem.l    (a7)+,d3/a2-a3
[00011326] 4e75                      rts

parse_keyword:
[00011328] 2f0a                      move.l     a2,-(a7)
[0001132a] 2f0b                      move.l     a3,-(a7)
[0001132c] 45f9 0001 5b16            lea.l      cur_identifier,a2
[00011332] 303c 00d3                 move.w     #$00D3,d0
[00011336] 204a                      movea.l    a2,a0
[00011338] 4eb9 0001 14b8            jsr        calchash
[0001133e] 3200                      move.w     d0,d1
[00011340] 48c1                      ext.l      d1
[00011342] e589                      lsl.l      #2,d1
[00011344] 41f9 0001 5f1e            lea.l      keyword_hash,a0
[0001134a] 2670 1800                 movea.l    0(a0,d1.l),a3
[0001134e] 6014                      bra.s      parse_keyword_1
parse_keyword_3:
[00011350] 226b 0002                 movea.l    2(a3),a1
[00011354] 204a                      movea.l    a2,a0
[00011356] 4eb9 0001 3a02            jsr        strcmp
[0001135c] 4a40                      tst.w      d0
[0001135e] 6708                      beq.s      parse_keyword_2
[00011360] 266b 0006                 movea.l    6(a3),a3
parse_keyword_1:
[00011364] 200b                      move.l     a3,d0
[00011366] 66e8                      bne.s      parse_keyword_3
parse_keyword_2:
[00011368] 200b                      move.l     a3,d0
[0001136a] 670c                      beq.s      parse_keyword_4
[0001136c] 357c 0002 0402            move.w     #$0002,1026(a2) ; hc_curscope
[00011372] 3553 0400                 move.w     (a3),1024(a2) ; hc_curtok
[00011376] 600a                      bra.s      parse_keyword_5
parse_keyword_4:
[00011378] 70ff                      moveq.l    #-1,d0
[0001137a] 3540 0402                 move.w     d0,1026(a2) ; hc_curscope
[0001137e] 3540 0400                 move.w     d0,1024(a2) ; hc_curtok
parse_keyword_5:
[00011382] 265f                      movea.l    (a7)+,a3
[00011384] 245f                      movea.l    (a7)+,a2
[00011386] 4e75                      rts

parse_link:
[00011388] 48e7 1030                 movem.l    d3/a2-a3,-(a7)
[0001138c] 554f                      subq.w     #2,a7
[0001138e] 2648                      movea.l    a0,a3
[00011390] 33fc 0001 0001 5038       move.w     #$0001,in_link
[00011398] 701d                      moveq.l    #29,d0
[0001139a] 4eb9 0001 08ea            jsr        hc_putc
[000113a0] 2479 0001 59be            movea.l    screenbuf_ptr,a2
[000113a6] 70ff                      moveq.l    #-1,d0
[000113a8] 4eb9 0001 093a            jsr        hc_putw
[000113ae] 200b                      move.l     a3,d0
[000113b0] 6606                      bne.s      parse_link_1
[000113b2] 2679 0001 59be            movea.l    screenbuf_ptr,a3
parse_link_1:
[000113b8] 6100 fd46                 bsr        hc_gettok
[000113bc] 0c79 0008 0001 5f16       cmpi.w     #$0008,hc_curtok
[000113c4] 670e                      beq.s      parse_link_2
[000113c6] 7201                      moveq.l    #1,d1
[000113c8] 700e                      moveq.l    #14,d0
[000113ca] 4eb9 0001 0c4e            jsr        hclog
[000113d0] 6100 fe84                 bsr        hc_backtok
parse_link_2:
[000113d4] 2079 0001 59be            movea.l    screenbuf_ptr,a0
[000113da] 4210                      clr.b      (a0)
[000113dc] 204b                      movea.l    a3,a0
[000113de] 4eb9 0001 1dde            jsr        get_index_screen_code
[000113e4] 3600                      move.w     d0,d3
[000113e6] 6624                      bne.s      parse_link_3
[000113e8] 220a                      move.l     a2,d1
[000113ea] 92b9 0001 59b6            sub.l      screenbuf,d1
[000113f0] d2b9 0001 5078            add.l      screen_start,d1
[000113f6] 2279 0001 4942            movea.l    err_filename,a1
[000113fc] 204b                      movea.l    a3,a0
[000113fe] 2039 0001 5f1a            move.l     input_lineno,d0
[00011404] 4eb9 0001 16d6            jsr        add_name
[0001140a] 6008                      bra.s      parse_link_4
parse_link_3:
[0001140c] 3e83                      move.w     d3,(a7)
[0001140e] 14d7                      move.b     (a7),(a2)+
[00011410] 14af 0001                 move.b     1(a7),(a2)
parse_link_4:
[00011414] 701d                      moveq.l    #29,d0
[00011416] 4eb9 0001 08ea            jsr        hc_putc
[0001141c] 4279 0001 5038            clr.w      in_link
[00011422] 544f                      addq.w     #2,a7
[00011424] 4cdf 0c08                 movem.l    (a7)+,d3/a2-a3
[00011428] 4e75                      rts

parse_braces:
[0001142a] 3f03                      move.w     d3,-(a7)
[0001142c] 2f0a                      move.l     a2,-(a7)
[0001142e] 45f9 0001 4eb2            lea.l      brace_level,a2
[00011434] 5252                      addq.w     #1,(a2) ; brace_level
parse_braces_6:
[00011436] 4eb9 0001 088c            jsr        hc_getc
[0001143c] 1600                      move.b     d0,d3
[0001143e] 3239 0001 5034            move.w     in_screen,d1
[00011444] 6710                      beq.s      parse_braces_1
[00011446] b03c 005c                 cmp.b      #$5C,d0
[0001144a] 6636                      bne.s      parse_braces_2
[0001144c] 4eb9 0001 088c            jsr        hc_getc
[00011452] 1600                      move.b     d0,d3
[00011454] 600e                      bra.s      parse_braces_3
parse_braces_1:
[00011456] b63c 005c                 cmp.b      #$5C,d3
[0001145a] 6608                      bne.s      parse_braces_3
[0001145c] 4eb9 0001 088c            jsr        hc_getc
[00011462] 601e                      bra.s      parse_braces_2
parse_braces_3:
[00011464] 4240                      clr.w      d0
[00011466] 1003                      move.b     d3,d0
[00011468] 907c 007b                 sub.w      #$007B,d0
[0001146c] 670a                      beq.s      parse_braces_4
[0001146e] 5540                      subq.w     #2,d0
[00011470] 6702                      beq.s      parse_braces_5
[00011472] 600e                      bra.s      parse_braces_2
parse_braces_5:
[00011474] 5352                      subq.w     #1,(a2) ; brace_level
[00011476] 600a                      bra.s      parse_braces_2
parse_braces_4:
[00011478] 3039 0001 466e            move.w     options.x1466e,d0
[0001147e] 6702                      beq.s      parse_braces_2
[00011480] 5252                      addq.w     #1,(a2) ; brace_level
parse_braces_2:
[00011482] 3012                      move.w     (a2),d0 ; brace_level
[00011484] 66b0                      bne.s      parse_braces_6
[00011486] 245f                      movea.l    (a7)+,a2
[00011488] 361f                      move.w     (a7)+,d3
[0001148a] 4e75                      rts

skip_space:
[0001148c] 2f0a                      move.l     a2,-(a7)
skip_space_1:
[0001148e] 45f9 0001 4ef2            lea.l      character_class,a2
[00011494] 4eb9 0001 088c            jsr        hc_getc
[0001149a] 4241                      clr.w      d1
[0001149c] 1200                      move.b     d0,d1
[0001149e] 1032 1000                 move.b     0(a2,d1.w),d0
[000114a2] b03c 0003                 cmp.b      #$03,d0
[000114a6] 67e6                      beq.s      skip_space_1
[000114a8] b03c 0002                 cmp.b      #$02,d0
[000114ac] 67e0                      beq.s      skip_space_1
[000114ae] 4eb9 0001 1260            jsr        hc_back
[000114b4] 245f                      movea.l    (a7)+,a2
[000114b6] 4e75                      rts

calchash:
[000114b8] 48e7 1830                 movem.l    d3-d4/a2-a3,-(a7)
[000114bc] 2448                      movea.l    a0,a2
[000114be] 3800                      move.w     d0,d4
[000114c0] 7600                      moveq.l    #0,d3
[000114c2] 2648                      movea.l    a0,a3
calchash_1:
[000114c4] 101b                      move.b     (a3)+,d0
[000114c6] 66fc                      bne.s      calchash_1
[000114c8] 4240                      clr.w      d0
[000114ca] 1012                      move.b     (a2),d0
[000114cc] 4241                      clr.w      d1
[000114ce] 122b fffe                 move.b     -2(a3),d1
[000114d2] eb49                      lsl.w      #5,d1
[000114d4] d041                      add.w      d1,d0
[000114d6] 48c0                      ext.l      d0
[000114d8] 240b                      move.l     a3,d2
[000114da] 948a                      sub.l      a2,d2
[000114dc] e18a                      lsl.l      #8,d2
[000114de] d082                      add.l      d2,d0
[000114e0] 7200                      moveq.l    #0,d1
[000114e2] 3204                      move.w     d4,d1
[000114e4] 4eb9 0001 4594            jsr        _lmod
[000114ea] 2600                      move.l     d0,d3
[000114ec] 3003                      move.w     d3,d0
[000114ee] 4cdf 0c18                 movem.l    (a7)+,d3-d4/a2-a3
[000114f2] 4e75                      rts

init_keyword_hash:
[000114f4] 48e7 1038                 movem.l    d3/a2-a4,-(a7)
[000114f8] 45f9 0001 5f1e            lea.l      keyword_hash,a2
[000114fe] 223c 0000 00d3            move.l     #$000000D3,d1
[00011504] 4240                      clr.w      d0
[00011506] 204a                      movea.l    a2,a0
[00011508] 4eb9 0001 408e            jsr        memset
[0001150e] 47f9 0001 4ff2            lea.l      keywords,a3
[00011514] 605c                      bra.s      init_keyword_hash_1
init_keyword_hash_7:
[00011516] 303c 00d3                 move.w     #$00D3,d0
[0001151a] 206b 0002                 movea.l    2(a3),a0 ; $00014FF4
[0001151e] 6100 ff98                 bsr.w      calchash
[00011522] 3600                      move.w     d0,d3
[00011524] 700a                      moveq.l    #10,d0
[00011526] 4eb9 0001 3c60            jsr        malloc
[0001152c] 2848                      movea.l    a0,a4
[0001152e] 200c                      move.l     a4,d0
[00011530] 660a                      bne.s      init_keyword_hash_2
[00011532] 4241                      clr.w      d1
[00011534] 7003                      moveq.l    #3,d0
[00011536] 4eb9 0001 0c4e            jsr        hclog
init_keyword_hash_2:
[0001153c] 3893                      move.w     (a3),(a4) ; keywords
[0001153e] 296b 0002 0002            move.l     2(a3),2(a4) ; $00014FF4
[00011544] 42ac 0006                 clr.l      6(a4)
[00011548] 3003                      move.w     d3,d0
[0001154a] e548                      lsl.w      #2,d0
[0001154c] 2232 0000                 move.l     0(a2,d0.w),d1
[00011550] 6606                      bne.s      init_keyword_hash_3
[00011552] 258c 0000                 move.l     a4,0(a2,d0.w)
[00011556] 6018                      bra.s      init_keyword_hash_4
init_keyword_hash_3:
[00011558] 3003                      move.w     d3,d0
[0001155a] e548                      lsl.w      #2,d0
[0001155c] 2072 0000                 movea.l    0(a2,d0.w),a0
[00011560] 6004                      bra.s      init_keyword_hash_5
init_keyword_hash_6:
[00011562] 2068 0006                 movea.l    6(a0),a0
init_keyword_hash_5:
[00011566] 2028 0006                 move.l     6(a0),d0
[0001156a] 66f6                      bne.s      init_keyword_hash_6
[0001156c] 214c 0006                 move.l     a4,6(a0)
init_keyword_hash_4:
[00011570] 5c4b                      addq.w     #6,a3
init_keyword_hash_1:
[00011572] 202b 0002                 move.l     2(a3),d0
[00011576] 669e                      bne.s      init_keyword_hash_7
[00011578] 4cdf 1c08                 movem.l    (a7)+,d3/a2-a4
[0001157c] 4e75                      rts

write_help:
[0001157e] 48e7 003e                 movem.l    a2-a6,-(a7)
[00011582] 41f9 0001 59c2            lea.l      outfile_name,a0
[00011588] 4eb9 0001 0b0c            jsr        hc_createfile
[0001158e] 45f9 0001 5084            lea.l      $00015084,a2
[00011594] 47f9 0001 626a            lea.l      helphdr,a3
[0001159a] 7050                      moveq.l    #80,d0
[0001159c] 224a                      movea.l    a2,a1
[0001159e] 204b                      movea.l    a3,a0
[000115a0] 4eb9 0001 3ac6            jsr        strncpy
[000115a6] 7008                      moveq.l    #8,d0
[000115a8] 43ea 0044                 lea.l      68(a2),a1 ; $000150C8
[000115ac] 41eb 0050                 lea.l      80(a3),a0 ; $000162BA
[000115b0] 4eb9 0001 3ac6            jsr        strncpy
[000115b6] 49f9 0001 5072            lea.l      screen_cnt,a4
[000115bc] 7001                      moveq.l    #1,d0
[000115be] d054                      add.w      (a4),d0 ; screen_cnt
[000115c0] 48c0                      ext.l      d0
[000115c2] e588                      lsl.l      #2,d0
[000115c4] 2740 0058                 move.l     d0,88(a3) ; helphdr.scr_tab_size
[000115c8] d0bc 0000 0088            add.l      #$00000088,d0
[000115ce] 2740 005c                 move.l     d0,92(a3) ; helphdr.str_offset
[000115d2] d0ab 0060                 add.l      96(a3),d0 ; helphdr.str_size
[000115d6] 2740 0070                 move.l     d0,112(a3) ; helphdr.caps_offset
[000115da] 4bf9 0001 54f2            lea.l      caps_size,a5
[000115e0] 2015                      move.l     (a5),d0 ; caps_size
[000115e2] 7202                      moveq.l    #2,d1
[000115e4] 4eb9 0001 4594            jsr        _lmod
[000115ea] 4a80                      tst.l      d0
[000115ec] 6702                      beq.s      write_help_1
[000115ee] 5295                      addq.l     #1,(a5) ; caps_size
write_help_1:
[000115f0] 2239 0001 63d6            move.l     caps_cnt,d1
[000115f6] 2001                      move.l     d1,d0
[000115f8] d080                      add.l      d0,d0
[000115fa] d081                      add.l      d1,d0
[000115fc] d080                      add.l      d0,d0
[000115fe] d095                      add.l      (a5),d0 ; caps_size
[00011600] 2740 0074                 move.l     d0,116(a3) ; helphdr.caps_size
[00011604] 2741 0078                 move.l     d1,120(a3) ; helphdr.caps_cnt
[00011608] 242b 0070                 move.l     112(a3),d2 ; helphdr.caps_offset
[0001160c] d4ab 0074                 add.l      116(a3),d2 ; helphdr.caps_size
[00011610] 2742 007c                 move.l     d2,124(a3) ; helphdr.sens_offset
[00011614] 4df9 0001 54f6            lea.l      sens_size,a6
[0001161a] 2016                      move.l     (a6),d0 ; sens_size
[0001161c] 7202                      moveq.l    #2,d1
[0001161e] 4eb9 0001 4594            jsr        _lmod
[00011624] 4a80                      tst.l      d0
[00011626] 6702                      beq.s      write_help_2
[00011628] 5296                      addq.l     #1,(a6) ; sens_size
write_help_2:
[0001162a] 2239 0001 63de            move.l     sens_cnt,d1
[00011630] 2001                      move.l     d1,d0
[00011632] d080                      add.l      d0,d0
[00011634] d081                      add.l      d1,d0
[00011636] d080                      add.l      d0,d0
[00011638] d096                      add.l      (a6),d0 ; sens_size
[0001163a] 2740 0080                 move.l     d0,128(a3) ; helphdr.sens_size
[0001163e] 2741 0084                 move.l     d1,132(a3) ; helphdr.sens_cnt
[00011642] 224b                      movea.l    a3,a1
[00011644] 2079 0001 5b06            movea.l    hc_outfile,a0
[0001164a] 203c 0000 0088            move.l     #$00000088,d0
[00011650] 4eb9 0001 0aaa            jsr        hc_fwrite
[00011656] 202b 007c                 move.l     124(a3),d0 ; helphdr.sens_offset
[0001165a] d0ab 0080                 add.l      128(a3),d0 ; helphdr.sens_size
[0001165e] 4241                      clr.w      d1
[00011660] 6010                      bra.s      write_help_3
write_help_4:
[00011662] 3401                      move.w     d1,d2
[00011664] 48c2                      ext.l      d2
[00011666] e58a                      lsl.l      #2,d2
[00011668] 206b 008c                 movea.l    140(a3),a0 ; screen_table_offset
[0001166c] d1b0 2800                 add.l      d0,0(a0,d2.l)
[00011670] 5241                      addq.w     #1,d1
write_help_3:
[00011672] b254                      cmp.w      (a4),d1 ; screen_cnt
[00011674] 6fec                      ble.s      write_help_4
[00011676] 226b 008c                 movea.l    140(a3),a1 ; screen_table_offset
[0001167a] 7001                      moveq.l    #1,d0
[0001167c] d054                      add.w      (a4),d0 ; screen_cnt
[0001167e] 48c0                      ext.l      d0
[00011680] e588                      lsl.l      #2,d0
[00011682] 2079 0001 5b06            movea.l    hc_outfile,a0
[00011688] 4eb9 0001 0aaa            jsr        hc_fwrite
[0001168e] 41ea 004d                 lea.l      77(a2),a0 ; $000150D1
[00011692] 4eb9 0001 0c08            jsr        hc_copyfile
[00011698] 2215                      move.l     (a5),d1 ; caps_size
[0001169a] 2039 0001 63d6            move.l     caps_cnt,d0
[000116a0] 2079 0001 63d2            movea.l    caps_table,a0
[000116a6] 4eb9 0001 185c            jsr        write_table
[000116ac] 2216                      move.l     (a6),d1 ; sens_size
[000116ae] 2039 0001 63de            move.l     sens_cnt,d0
[000116b4] 2079 0001 63da            movea.l    sens_table,a0
[000116ba] 4eb9 0001 185c            jsr        write_table
[000116c0] 41ea 0054                 lea.l      84(a2),a0 ; $000150D8
[000116c4] 4eb9 0001 0c08            jsr        hc_copyfile
[000116ca] 4eb9 0001 0bac            jsr        hc_closeout
[000116d0] 4cdf 7c00                 movem.l    (a7)+,a2-a6
[000116d4] 4e75                      rts

add_name:
[000116d6] 48e7 183c                 movem.l    d3-d4/a2-a5,-(a7)
[000116da] 2648                      movea.l    a0,a3
[000116dc] 2a49                      movea.l    a1,a5
[000116de] 2600                      move.l     d0,d3
[000116e0] 2801                      move.l     d1,d4
[000116e2] 7014                      moveq.l    #20,d0
[000116e4] 4eb9 0001 3c60            jsr        malloc
[000116ea] 2448                      movea.l    a0,a2
[000116ec] 204b                      movea.l    a3,a0
[000116ee] 4eb9 0001 3a9c            jsr        strlen
[000116f4] 5280                      addq.l     #1,d0
[000116f6] 4eb9 0001 3c60            jsr        malloc
[000116fc] 2848                      movea.l    a0,a4
[000116fe] 200a                      move.l     a2,d0
[00011700] 6704                      beq.s      add_name_1
[00011702] 220c                      move.l     a4,d1
[00011704] 660a                      bne.s      add_name_2
add_name_1:
[00011706] 4241                      clr.w      d1
[00011708] 7003                      moveq.l    #3,d0
[0001170a] 4eb9 0001 0c4e            jsr        hclog
add_name_2:
[00011710] 224b                      movea.l    a3,a1
[00011712] 204c                      movea.l    a4,a0
[00011714] 4eb9 0001 3a56            jsr        strcpy
[0001171a] 248c                      move.l     a4,(a2)
[0001171c] 254d 0004                 move.l     a5,4(a2)
[00011720] 2543 0008                 move.l     d3,8(a2)
[00011724] 2544 000c                 move.l     d4,12(a2)
[00011728] 42aa 0010                 clr.l      16(a2)
[0001172c] 41f9 0001 62f2            lea.l      namelist_tail,a0
[00011732] 2039 0001 507c            move.l     namelist,d0
[00011738] 670a                      beq.s      add_name_3
[0001173a] 2250                      movea.l    (a0),a1 ; namelist_tail
[0001173c] 234a 0010                 move.l     a2,16(a1)
[00011740] 208a                      move.l     a2,(a0) ; namelist_tail
[00011742] 6008                      bra.s      add_name_4
add_name_3:
[00011744] 208a                      move.l     a2,(a0) ; namelist_tail
[00011746] 23ca 0001 507c            move.l     a2,namelist
add_name_4:
[0001174c] 4cdf 3c18                 movem.l    (a7)+,d3-d4/a2-a5
[00011750] 4e75                      rts

do_references:
[00011752] 48e7 0034                 movem.l    a2-a3/a5,-(a7)
[00011756] 4fef fefe                 lea.l      -258(a7),a7
[0001175a] 2648                      movea.l    a0,a3
[0001175c] 2039 0001 507c            move.l     namelist,d0
[00011762] 6700 00ba                 beq        do_references_1
[00011766] 43f9 0001 50df            lea.l      $000150DF,a1
[0001176c] 4eb9 0001 3266            jsr        fopen
[00011772] 2448                      movea.l    a0,a2
[00011774] 200a                      move.l     a2,d0
[00011776] 6612                      bne.s      do_references_2
[00011778] 4879 0001 50e3            pea.l      $000150E3
[0001177e] 4241                      clr.w      d1
[00011780] 7004                      moveq.l    #4,d0
[00011782] 4eb9 0001 0c4e            jsr        hclog
[00011788] 584f                      addq.w     #4,a7
do_references_2:
[0001178a] 2679 0001 507c            movea.l    namelist,a3
[00011790] 4bef 0002                 lea.l      2(a7),a5
[00011794] 6070                      bra.s      do_references_3
do_references_5:
[00011796] 4241                      clr.w      d1
[00011798] 202b 000c                 move.l     12(a3),d0
[0001179c] 204a                      movea.l    a2,a0
[0001179e] 4eb9 0001 31e2            jsr        fseek
[000117a4] 2053                      movea.l    (a3),a0
[000117a6] 4eb9 0001 1dde            jsr        get_index_screen_code
[000117ac] 3e80                      move.w     d0,(a7)
[000117ae] 6b44                      bmi.s      do_references_4
[000117b0] 2253                      movea.l    (a3),a1
[000117b2] 204d                      movea.l    a5,a0
[000117b4] 4eb9 0001 3a56            jsr        strcpy
[000117ba] 204d                      movea.l    a5,a0
[000117bc] 4eb9 0001 3bb2            jsr        strupr
[000117c2] 204d                      movea.l    a5,a0
[000117c4] 4eb9 0001 1dde            jsr        get_index_screen_code
[000117ca] 3e80                      move.w     d0,(a7)
[000117cc] 6b26                      bmi.s      do_references_4
[000117ce] 41f9 0001 4942            lea.l      err_filename,a0
[000117d4] 20ab 0004                 move.l     4(a3),(a0) ; err_filename
[000117d8] 41f9 0001 5b0e            lea.l      err_lineno,a0
[000117de] 20ab 0008                 move.l     8(a3),(a0) ; err_lineno
[000117e2] 2f13                      move.l     (a3),-(a7)
[000117e4] 7202                      moveq.l    #2,d1
[000117e6] 701a                      moveq.l    #26,d0
[000117e8] 4eb9 0001 0c4e            jsr        hclog
[000117ee] 584f                      addq.w     #4,a7
[000117f0] 3ebc ffff                 move.w     #$FFFF,(a7)
do_references_4:
[000117f4] 224a                      movea.l    a2,a1
[000117f6] 7201                      moveq.l    #1,d1
[000117f8] 7002                      moveq.l    #2,d0
[000117fa] 41d7                      lea.l      (a7),a0
[000117fc] 4eb9 0001 302e            jsr        fwrite
[00011802] 266b 0010                 movea.l    16(a3),a3
do_references_3:
[00011806] 200b                      move.l     a3,d0
[00011808] 668c                      bne.s      do_references_5
[0001180a] 204a                      movea.l    a2,a0
[0001180c] 4eb9 0001 3436            jsr        fclose
[00011812] 2079 0001 507c            movea.l    namelist,a0
[00011818] 4eb9 0001 1828            jsr        free_namelist
do_references_1:
[0001181e] 4fef 0102                 lea.l      258(a7),a7
[00011822] 4cdf 2c00                 movem.l    (a7)+,a2-a3/a5
[00011826] 4e75                      rts

free_namelist:
[00011828] 2f0a                      move.l     a2,-(a7)
[0001182a] 2f0b                      move.l     a3,-(a7)
[0001182c] 2448                      movea.l    a0,a2
[0001182e] 6016                      bra.s      free_namelist_1
free_namelist_2:
[00011830] 266a 0010                 movea.l    16(a2),a3
[00011834] 2052                      movea.l    (a2),a0
[00011836] 4eb9 0001 3d48            jsr        free
[0001183c] 204a                      movea.l    a2,a0
[0001183e] 4eb9 0001 3d48            jsr        free
[00011844] 244b                      movea.l    a3,a2
free_namelist_1:
[00011846] 200a                      move.l     a2,d0
[00011848] 66e6                      bne.s      free_namelist_2
[0001184a] 265f                      movea.l    (a7)+,a3
[0001184c] 245f                      movea.l    (a7)+,a2
[0001184e] 4e75                      rts

namecmp:
[00011850] 2251                      movea.l    (a1),a1
[00011852] 2050                      movea.l    (a0),a0
[00011854] 4eb9 0001 3a02            jsr        strcmp
[0001185a] 4e75                      rts

write_table:
[0001185c] 48e7 1f38                 movem.l    d3-d7/a2-a4,-(a7)
[00011860] 594f                      subq.w     #4,a7
[00011862] 2448                      movea.l    a0,a2
[00011864] 2800                      move.l     d0,d4
[00011866] 2e81                      move.l     d1,(a7)
[00011868] 7600                      moveq.l    #0,d3
[0001186a] 2a00                      move.l     d0,d5
[0001186c] da85                      add.l      d5,d5
[0001186e] da80                      add.l      d0,d5
[00011870] da85                      add.l      d5,d5
[00011872] 4a85                      tst.l      d5
[00011874] 6700 00ec                 beq        write_table_1
[00011878] 43fa ffd6                 lea.l      namecmp(pc),a1
[0001187c] 7206                      moveq.l    #6,d1
[0001187e] 4eb9 0001 29be            jsr        qsort
[00011884] 47f9 0001 59b2            lea.l      hc_inbuf,a3
[0001188a] 49f9 0001 59ba            lea.l      hc_inbuf_ptr,a4
[00011890] 2893                      move.l     (a3),(a4) ; hc_inbuf,hc_inbuf_ptr
[00011892] 2c04                      move.l     d4,d6
[00011894] dc86                      add.l      d6,d6
[00011896] dc84                      add.l      d4,d6
[00011898] dc86                      add.l      d6,d6
write_table_4:
[0001189a] 2003                      move.l     d3,d0
[0001189c] d080                      add.l      d0,d0
[0001189e] d083                      add.l      d3,d0
[000118a0] d080                      add.l      d0,d0
[000118a2] 2072 0800                 movea.l    0(a2,d0.l),a0
[000118a6] 4eb9 0001 3a9c            jsr        strlen
[000118ac] 2e00                      move.l     d0,d7
[000118ae] 5287                      addq.l     #1,d7
[000118b0] 2054                      movea.l    (a4),a0 ; hc_inbuf_ptr
[000118b2] d1c7                      adda.l     d7,a0
[000118b4] 2253                      movea.l    (a3),a1 ; hc_inbuf
[000118b6] d3fc 0000 8000            adda.l     #$00008000,a1
[000118bc] 43d1                      lea.l      (a1),a1
[000118be] b1c9                      cmpa.l     a1,a0
[000118c0] 642a                      bcc.s      write_table_2
[000118c2] 2003                      move.l     d3,d0
[000118c4] d080                      add.l      d0,d0
[000118c6] d083                      add.l      d3,d0
[000118c8] d080                      add.l      d0,d0
[000118ca] 2272 0800                 movea.l    0(a2,d0.l),a1
[000118ce] 2054                      movea.l    (a4),a0 ; hc_inbuf_ptr
[000118d0] 4eb9 0001 3a56            jsr        strcpy
[000118d6] 2003                      move.l     d3,d0
[000118d8] d080                      add.l      d0,d0
[000118da] d083                      add.l      d3,d0
[000118dc] d080                      add.l      d0,d0
[000118de] 2072 0800                 movea.l    0(a2,d0.l),a0
[000118e2] 4eb9 0001 3d48            jsr        free
[000118e8] df94                      add.l      d7,(a4) ; hc_inbuf_ptr
[000118ea] 600a                      bra.s      write_table_3
write_table_2:
[000118ec] 4241                      clr.w      d1
[000118ee] 7003                      moveq.l    #3,d0
[000118f0] 4eb9 0001 0c4e            jsr        hclog
write_table_3:
[000118f6] 2003                      move.l     d3,d0
[000118f8] d080                      add.l      d0,d0
[000118fa] d083                      add.l      d3,d0
[000118fc] d080                      add.l      d0,d0
[000118fe] 2586 0800                 move.l     d6,0(a2,d0.l)
[00011902] 2206                      move.l     d6,d1
[00011904] d287                      add.l      d7,d1
[00011906] 5d81                      subq.l     #6,d1
[00011908] 2c01                      move.l     d1,d6
[0001190a] 5283                      addq.l     #1,d3
[0001190c] b883                      cmp.l      d3,d4
[0001190e] 6e8a                      bgt.s      write_table_4
[00011910] 49f9 0001 59c2            lea.l      outfile_name,a4
[00011916] 224a                      movea.l    a2,a1
[00011918] 2005                      move.l     d5,d0
[0001191a] 2079 0001 5b06            movea.l    hc_outfile,a0
[00011920] 4eb9 0001 0aaa            jsr        hc_fwrite
[00011926] 4a40                      tst.w      d0
[00011928] 660e                      bne.s      write_table_5
[0001192a] 4854                      pea.l      (a4) ; outfile_name
[0001192c] 4241                      clr.w      d1
[0001192e] 7004                      moveq.l    #4,d0
[00011930] 4eb9 0001 0c4e            jsr        hclog
[00011936] 584f                      addq.w     #4,a7
write_table_5:
[00011938] 2253                      movea.l    (a3),a1 ; hc_inbuf
[0001193a] 2017                      move.l     (a7),d0
[0001193c] 2079 0001 5b06            movea.l    hc_outfile,a0
[00011942] 4eb9 0001 0aaa            jsr        hc_fwrite
[00011948] 4a40                      tst.w      d0
[0001194a] 660e                      bne.s      write_table_6
[0001194c] 4854                      pea.l      (a4) ; outfile_name
[0001194e] 4241                      clr.w      d1
[00011950] 7004                      moveq.l    #4,d0
[00011952] 4eb9 0001 0c4e            jsr        hclog
[00011958] 584f                      addq.w     #4,a7
write_table_6:
[0001195a] 204a                      movea.l    a2,a0
[0001195c] 4eb9 0001 3d48            jsr        free
write_table_1:
[00011962] 584f                      addq.w     #4,a7
[00011964] 4cdf 1cf8                 movem.l    (a7)+,d3-d7/a2-a4
[00011968] 4e75                      rts

generate_index:
[0001196a] 48e7 181c                 movem.l    d3-d4/a3-a5,-(a7)
[0001196e] 4fef fff6                 lea.l      -10(a7),a7
[00011972] 49f9 0001 54fa            lea.l      no_index_entry,a4
[00011978] 41ec 0242                 lea.l      578(a4),a0 ; $0001573C
[0001197c] 43d7                      lea.l      (a7),a1
[0001197e] 12d8                      move.b     (a0)+,(a1)+
[00011980] 12d8                      move.b     (a0)+,(a1)+
[00011982] 12d8                      move.b     (a0)+,(a1)+
[00011984] 12d8                      move.b     (a0)+,(a1)+
[00011986] 12d8                      move.b     (a0)+,(a1)+
[00011988] 12d8                      move.b     (a0)+,(a1)+
[0001198a] 12d8                      move.b     (a0)+,(a1)+
[0001198c] 12d8                      move.b     (a0)+,(a1)+
[0001198e] 12d8                      move.b     (a0)+,(a1)+
[00011990] 12d8                      move.b     (a0)+,(a1)+
[00011992] 4243                      clr.w      d3
[00011994] 47f9 0001 62fa            lea.l      nameindex,a3
[0001199a] 4bf9 0001 59b2            lea.l      hc_inbuf,a5
[000119a0] 6000 0078                 bra.w      generate_index_1
generate_index_7:
[000119a4] b67c 001a                 cmp.w      #$001A,d3
[000119a8] 660e                      bne.s      generate_index_2
[000119aa] 43f9 0001 57dd            lea.l      $000157DD,a1
[000119b0] 41d7                      lea.l      (a7),a0
[000119b2] 4eb9 0001 3a56            jsr        strcpy
generate_index_2:
[000119b8] 3003                      move.w     d3,d0
[000119ba] e748                      lsl.w      #3,d0
[000119bc] 2233 0004                 move.l     4(a3,d0.w),d1
[000119c0] 670c                      beq.s      generate_index_3
[000119c2] 41d7                      lea.l      (a7),a0
[000119c4] 3003                      move.w     d3,d0
[000119c6] 4eb9 0001 1aa0            jsr        generate_index_entries
[000119cc] 6048                      bra.s      generate_index_4
generate_index_3:
[000119ce] 302c 0240                 move.w     576(a4),d0 ; $0001573A
[000119d2] 6636                      bne.s      generate_index_5
[000119d4] b67c 001a                 cmp.w      #$001A,d3
[000119d8] 6c08                      bge.s      generate_index_6
[000119da] 7241                      moveq.l    #65,d1
[000119dc] d203                      add.b      d3,d1
[000119de] 1941 0008                 move.b     d1,8(a4) ; $00015502
generate_index_6:
[000119e2] 7043                      moveq.l    #67,d0
[000119e4] 224c                      movea.l    a4,a1
[000119e6] 2055                      movea.l    (a5),a0 ; hc_inbuf
[000119e8] 4eb9 0001 3ea4            jsr        memcpy
[000119ee] 41f9 0001 59ba            lea.l      hc_inbuf_ptr,a0
[000119f4] 2095                      move.l     (a5),(a0) ; hc_inbuf,hc_inbuf_ptr
[000119f6] 4eb9 0001 0d9c            jsr        parse_file
[000119fc] 397c 0001 0240            move.w     #$0001,576(a4) ; $0001573A
[00011a02] 3839 0001 5072            move.w     screen_cnt,d4
[00011a08] 600c                      bra.s      generate_index_4
generate_index_5:
[00011a0a] 4241                      clr.w      d1
[00011a0c] 3004                      move.w     d4,d0
[00011a0e] 41d7                      lea.l      (a7),a0
[00011a10] 4eb9 0001 1c3c            jsr        add_index_entry
generate_index_4:
[00011a16] 5217                      addq.b     #1,(a7)
[00011a18] 5243                      addq.w     #1,d3
generate_index_1:
[00011a1a] b67c 001b                 cmp.w      #$001B,d3
[00011a1e] 6d00 ff84                 blt.w      generate_index_7
[00011a22] 4eb9 0001 1a32            jsr        free_index
[00011a28] 4fef 000a                 lea.l      10(a7),a7
[00011a2c] 4cdf 3818                 movem.l    (a7)+,d3-d4/a3-a5
[00011a30] 4e75                      rts

free_index:
[00011a32] 48e7 1038                 movem.l    d3/a2-a4,-(a7)
[00011a36] 4243                      clr.w      d3
[00011a38] 45f9 0001 62fa            lea.l      nameindex,a2
[00011a3e] 601e                      bra.s      free_index_1
free_index_4:
[00011a40] 3003                      move.w     d3,d0
[00011a42] e748                      lsl.w      #3,d0
[00011a44] 2672 0000                 movea.l    0(a2,d0.w),a3
[00011a48] 600e                      bra.s      free_index_2
free_index_3:
[00011a4a] 286b 0006                 movea.l    6(a3),a4
[00011a4e] 204b                      movea.l    a3,a0
[00011a50] 4eb9 0001 3d48            jsr        free
[00011a56] 264c                      movea.l    a4,a3
free_index_2:
[00011a58] 200b                      move.l     a3,d0
[00011a5a] 66ee                      bne.s      free_index_3
[00011a5c] 5243                      addq.w     #1,d3
free_index_1:
[00011a5e] b67c 001b                 cmp.w      #$001B,d3
[00011a62] 6ddc                      blt.s      free_index_4
[00011a64] 4cdf 1c08                 movem.l    (a7)+,d3/a2-a4
[00011a68] 4e75                      rts

format_index_entry:
[00011a6a] 4242                      clr.w      d2
[00011a6c] 6004                      bra.s      format_index_entry_1
format_index_entry_3:
[00011a6e] 10d9                      move.b     (a1)+,(a0)+
[00011a70] 5242                      addq.w     #1,d2
format_index_entry_1:
[00011a72] 4a11                      tst.b      (a1)
[00011a74] 6704                      beq.s      format_index_entry_2
[00011a76] b042                      cmp.w      d2,d0
[00011a78] 6ef4                      bgt.s      format_index_entry_3
format_index_entry_2:
[00011a7a] b042                      cmp.w      d2,d0
[00011a7c] 6f06                      ble.s      format_index_entry_4
[00011a7e] 10fc 001d                 move.b     #$1D,(a0)+
[00011a82] 6006                      bra.s      format_index_entry_5
format_index_entry_4:
[00011a84] 117c 001d ffff            move.b     #$1D,-1(a0)
format_index_entry_5:
[00011a8a] 5242                      addq.w     #1,d2
[00011a8c] 4a81                      tst.l      d1
[00011a8e] 670c                      beq.s      format_index_entry_6
[00011a90] 6006                      bra.s      format_index_entry_7
format_index_entry_8:
[00011a92] 10fc 0020                 move.b     #$20,(a0)+
[00011a96] 5242                      addq.w     #1,d2
format_index_entry_7:
[00011a98] b042                      cmp.w      d2,d0
[00011a9a] 6ef6                      bgt.s      format_index_entry_8
format_index_entry_6:
[00011a9c] 4210                      clr.b      (a0)
[00011a9e] 4e75                      rts

generate_index_entries:
[00011aa0] 48e7 1836                 movem.l    d3-d4/a2-a3/a5-a6,-(a7)
[00011aa4] 4fef ffbc                 lea.l      -68(a7),a7
[00011aa8] 2f48 0040                 move.l     a0,64(a7)
[00011aac] 3600                      move.w     d0,d3
[00011aae] 23c8 0001 5074            move.l     a0,last_indexentry_name
[00011ab4] 721f                      moveq.l    #31,d1
[00011ab6] 41ef 0020                 lea.l      32(a7),a0
[00011aba] 4240                      clr.w      d0
[00011abc] 4eb9 0001 408e            jsr        memset
[00011ac2] 721f                      moveq.l    #31,d1
[00011ac4] 4240                      clr.w      d0
[00011ac6] 41d7                      lea.l      (a7),a0
[00011ac8] 4eb9 0001 408e            jsr        memset
[00011ace] 4bf9 0001 62fa            lea.l      nameindex,a5
[00011ad4] 3003                      move.w     d3,d0
[00011ad6] e748                      lsl.w      #3,d0
[00011ad8] 2c75 0000                 movea.l    0(a5,d0.w),a6
[00011adc] 244e                      movea.l    a6,a2
[00011ade] 4244                      clr.w      d4
[00011ae0] 6006                      bra.s      generate_index_entries_1
generate_index_entries_2:
[00011ae2] 2c6e 0006                 movea.l    6(a6),a6
[00011ae6] 5244                      addq.w     #1,d4
generate_index_entries_1:
[00011ae8] 3004                      move.w     d4,d0
[00011aea] 48c0                      ext.l      d0
[00011aec] 3203                      move.w     d3,d1
[00011aee] e749                      lsl.w      #3,d1
[00011af0] 2435 1004                 move.l     4(a5,d1.w),d2
[00011af4] e28a                      lsr.l      #1,d2
[00011af6] b082                      cmp.l      d2,d0
[00011af8] 65e8                      bcs.s      generate_index_entries_2
[00011afa] 7001                      moveq.l    #1,d0
[00011afc] b0b5 1004                 cmp.l      4(a5,d1.w),d0
[00011b00] 6604                      bne.s      generate_index_entries_3
[00011b02] 9dce                      suba.l     a6,a6
[00011b04] 6010                      bra.s      generate_index_entries_4
generate_index_entries_3:
[00011b06] 7001                      moveq.l    #1,d0
[00011b08] 3203                      move.w     d3,d1
[00011b0a] e749                      lsl.w      #3,d1
[00011b0c] c0b5 1004                 and.l      4(a5,d1.w),d0
[00011b10] 6704                      beq.s      generate_index_entries_4
[00011b12] 2c6e 0006                 movea.l    6(a6),a6
generate_index_entries_4:
[00011b16] 264e                      movea.l    a6,a3
[00011b18] 23f9 0001 59b6 0001 59be  move.l     screenbuf,screenbuf_ptr
[00011b22] 700d                      moveq.l    #13,d0
[00011b24] 4eb9 0001 08ea            jsr        hc_putc
[00011b2a] 700a                      moveq.l    #10,d0
[00011b2c] 4eb9 0001 08ea            jsr        hc_putc
[00011b32] 4244                      clr.w      d4
[00011b34] 6000 008c                 bra        generate_index_entries_5
generate_index_entries_7:
[00011b38] 220b                      move.l     a3,d1
[00011b3a] 701e                      moveq.l    #30,d0
[00011b3c] 2252                      movea.l    (a2),a1
[00011b3e] 41ef 0020                 lea.l      32(a7),a0
[00011b42] 6100 ff26                 bsr        format_index_entry
[00011b46] 41f9 0001 57e7            lea.l      $000157E7,a0
[00011b4c] 4eb9 0001 0958            jsr        hc_puts
[00011b52] 701d                      moveq.l    #29,d0
[00011b54] 4eb9 0001 08ea            jsr        hc_putc
[00011b5a] 302a 0004                 move.w     4(a2),d0
[00011b5e] 4eb9 0001 093a            jsr        hc_putw
[00011b64] 41ef 0020                 lea.l      32(a7),a0
[00011b68] 4eb9 0001 0958            jsr        hc_puts
[00011b6e] 200e                      move.l     a6,d0
[00011b70] 673a                      beq.s      generate_index_entries_6
[00011b72] 7200                      moveq.l    #0,d1
[00011b74] 2256                      movea.l    (a6),a1
[00011b76] 41d7                      lea.l      (a7),a0
[00011b78] 701e                      moveq.l    #30,d0
[00011b7a] 6100 feee                 bsr        format_index_entry
[00011b7e] 41f9 0001 57e7            lea.l      $000157E7,a0
[00011b84] 4eb9 0001 0958            jsr        hc_puts
[00011b8a] 701d                      moveq.l    #29,d0
[00011b8c] 4eb9 0001 08ea            jsr        hc_putc
[00011b92] 302e 0004                 move.w     4(a6),d0
[00011b96] 4eb9 0001 093a            jsr        hc_putw
[00011b9c] 41d7                      lea.l      (a7),a0
[00011b9e] 4eb9 0001 0958            jsr        hc_puts
[00011ba4] 2c6e 0006                 movea.l    6(a6),a6
[00011ba8] 264e                      movea.l    a6,a3
[00011baa] 5244                      addq.w     #1,d4
generate_index_entries_6:
[00011bac] 700d                      moveq.l    #13,d0
[00011bae] 4eb9 0001 08ea            jsr        hc_putc
[00011bb4] 700a                      moveq.l    #10,d0
[00011bb6] 4eb9 0001 08ea            jsr        hc_putc
[00011bbc] 246a 0006                 movea.l    6(a2),a2
[00011bc0] 5244                      addq.w     #1,d4
generate_index_entries_5:
[00011bc2] 3004                      move.w     d4,d0
[00011bc4] 48c0                      ext.l      d0
[00011bc6] 3203                      move.w     d3,d1
[00011bc8] e749                      lsl.w      #3,d1
[00011bca] b0b5 1004                 cmp.l      4(a5,d1.w),d0
[00011bce] 6500 ff68                 bcs        generate_index_entries_7
[00011bd2] 5279 0001 5072            addq.w     #1,screen_cnt
[00011bd8] 206f 0040                 movea.l    64(a7),a0
[00011bdc] 3039 0001 5072            move.w     screen_cnt,d0
[00011be2] 4241                      clr.w      d1
[00011be4] 4eb9 0001 1c3c            jsr        add_index_entry
[00011bea] 3039 0001 5072            move.w     screen_cnt,d0
[00011bf0] 48c0                      ext.l      d0
[00011bf2] e588                      lsl.l      #2,d0
[00011bf4] 2079 0001 62f6            movea.l    screen_table_offset,a0
[00011bfa] 21b9 0001 5078 08fc       move.l     screen_start,-4(a0,d0.l)
[00011c02] 2039 0001 59be            move.l     screenbuf_ptr,d0
[00011c08] 90b9 0001 59b6            sub.l      screenbuf,d0
[00011c0e] d1b9 0001 5078            add.l      d0,screen_start
[00011c14] 4eb9 0001 0a54            jsr        hc_flshbuf
[00011c1a] 42b9 0001 5074            clr.l      last_indexentry_name
[00011c20] 4fef 0044                 lea.l      68(a7),a7
[00011c24] 4cdf 6c18                 movem.l    (a7)+,d3-d4/a2-a3/a5-a6
[00011c28] 4e75                      rts

clear_index:
[00011c2a] 721b                      moveq.l    #27,d1
[00011c2c] 4240                      clr.w      d0
[00011c2e] 41f9 0001 62fa            lea.l      nameindex,a0
[00011c34] 4eb9 0001 408e            jsr        memset
[00011c3a] 4e75                      rts

add_index_entry:
[00011c3c] 48e7 1c3e                 movem.l    d3-d5/a2-a6,-(a7)
[00011c40] 594f                      subq.w     #4,a7
[00011c42] 2648                      movea.l    a0,a3
[00011c44] 3800                      move.w     d0,d4
[00011c46] 3a01                      move.w     d1,d5
[00011c48] 4242                      clr.w      d2
[00011c4a] 1410                      move.b     (a0),d2
[00011c4c] d442                      add.w      d2,d2
[00011c4e] 43f9 0001 50f2            lea.l      name_to_index,a1
[00011c54] 3631 2000                 move.w     0(a1,d2.w),d3
[00011c58] 49f9 0001 62fa            lea.l      nameindex,a4
[00011c5e] 3003                      move.w     d3,d0
[00011c60] e748                      lsl.w      #3,d0
[00011c62] 52b4 0004                 addq.l     #1,4(a4,d0.w)
[00011c66] 700a                      moveq.l    #10,d0
[00011c68] 4eb9 0001 3c60            jsr        malloc
[00011c6e] 2a48                      movea.l    a0,a5
[00011c70] 200d                      move.l     a5,d0
[00011c72] 660a                      bne.s      add_index_entry_1
[00011c74] 4241                      clr.w      d1
[00011c76] 7003                      moveq.l    #3,d0
[00011c78] 4eb9 0001 0c4e            jsr        hclog
add_index_entry_1:
[00011c7e] 204b                      movea.l    a3,a0
[00011c80] 4eb9 0001 3a9c            jsr        strlen
[00011c86] 5280                      addq.l     #1,d0
[00011c88] 4eb9 0001 3c60            jsr        malloc
[00011c8e] 2c48                      movea.l    a0,a6
[00011c90] 200e                      move.l     a6,d0
[00011c92] 660a                      bne.s      add_index_entry_2
[00011c94] 4241                      clr.w      d1
[00011c96] 7003                      moveq.l    #3,d0
[00011c98] 4eb9 0001 0c4e            jsr        hclog
add_index_entry_2:
[00011c9e] 224b                      movea.l    a3,a1
[00011ca0] 204e                      movea.l    a6,a0
[00011ca2] 4eb9 0001 3a56            jsr        strcpy
[00011ca8] 2a8e                      move.l     a6,(a5)
[00011caa] 026d 7fff 0004            andi.w     #$7FFF,4(a5)
[00011cb0] 006d 8000 0004            ori.w      #$8000,4(a5)
[00011cb6] 3004                      move.w     d4,d0
[00011cb8] 026d 8007 0004            andi.w     #$8007,4(a5)
[00011cbe] c07c 0fff                 and.w      #$0FFF,d0
[00011cc2] e748                      lsl.w      #3,d0
[00011cc4] 816d 0004                 or.w       d0,4(a5)
[00011cc8] 3039 0001 4666            move.w     file_index,d0
[00011cce] 026d fff8 0004            andi.w     #$FFF8,4(a5)
[00011cd4] c07c 0007                 and.w      #$0007,d0
[00011cd8] 816d 0004                 or.w       d0,4(a5)
[00011cdc] 42ad 0006                 clr.l      6(a5)
[00011ce0] 3204                      move.w     d4,d1
[00011ce2] 48c1                      ext.l      d1
[00011ce4] 2039 0001 5746            move.l     $00015746,d0
[00011cea] b280                      cmp.l      d0,d1
[00011cec] 670c                      beq.s      add_index_entry_3
[00011cee] 23c1 0001 5746            move.l     d1,$00015746
[00011cf4] 23ce 0001 5074            move.l     a6,last_indexentry_name
add_index_entry_3:
[00011cfa] 3003                      move.w     d3,d0
[00011cfc] e748                      lsl.w      #3,d0
[00011cfe] 2234 0000                 move.l     0(a4,d0.w),d1
[00011d02] 6606                      bne.s      add_index_entry_4
[00011d04] 298d 0000                 move.l     a5,0(a4,d0.w)
[00011d08] 6056                      bra.s      add_index_entry_5
add_index_entry_4:
[00011d0a] 3003                      move.w     d3,d0
[00011d0c] e748                      lsl.w      #3,d0
[00011d0e] 2474 0000                 movea.l    0(a4,d0.w),a2
[00011d12] 41f4 0000                 lea.l      0(a4,d0.w),a0
[00011d16] 2e88                      move.l     a0,(a7)
[00011d18] 603a                      bra.s      add_index_entry_6
add_index_entry_10:
[00011d1a] 224b                      movea.l    a3,a1
[00011d1c] 2052                      movea.l    (a2),a0
[00011d1e] 4eb9 0001 1e26            jsr        index_namecmp
[00011d24] 3800                      move.w     d0,d4
[00011d26] 4a40                      tst.w      d0
[00011d28] 661e                      bne.s      add_index_entry_7
[00011d2a] 224b                      movea.l    a3,a1
[00011d2c] 2052                      movea.l    (a2),a0
[00011d2e] 4eb9 0001 3a02            jsr        strcmp
[00011d34] 4a40                      tst.w      d0
[00011d36] 6610                      bne.s      add_index_entry_7
[00011d38] 2f0b                      move.l     a3,-(a7)
[00011d3a] 7201                      moveq.l    #1,d1
[00011d3c] 7011                      moveq.l    #17,d0
[00011d3e] 4eb9 0001 0c4e            jsr        hclog
[00011d44] 584f                      addq.w     #4,a7
[00011d46] 606e                      bra.s      add_index_entry_8
add_index_entry_7:
[00011d48] 4a44                      tst.w      d4
[00011d4a] 6e0c                      bgt.s      add_index_entry_9
[00011d4c] 41ea 0006                 lea.l      6(a2),a0
[00011d50] 2e88                      move.l     a0,(a7)
[00011d52] 2450                      movea.l    (a0),a2
add_index_entry_6:
[00011d54] 200a                      move.l     a2,d0
[00011d56] 66c2                      bne.s      add_index_entry_10
add_index_entry_9:
[00011d58] 2057                      movea.l    (a7),a0
[00011d5a] 208d                      move.l     a5,(a0)
[00011d5c] 2b4a 0006                 move.l     a2,6(a5)
add_index_entry_5:
[00011d60] ba7c 0001                 cmp.w      #$0001,d5
[00011d64] 6626                      bne.s      add_index_entry_11
[00011d66] 224d                      movea.l    a5,a1
[00011d68] 202c 00dc                 move.l     220(a4),d0 ; caps_cnt
[00011d6c] 206c 00d8                 movea.l    216(a4),a0 ; caps_table
[00011d70] 4eb9 0001 1dbe            jsr        add_search_key
[00011d76] 52ac 00dc                 addq.l     #1,220(a4) ; caps_cnt
[00011d7a] 204e                      movea.l    a6,a0
[00011d7c] 4eb9 0001 3a9c            jsr        strlen
[00011d82] 5280                      addq.l     #1,d0
[00011d84] d1b9 0001 54f2            add.l      d0,caps_size
[00011d8a] 602a                      bra.s      add_index_entry_8
add_index_entry_11:
[00011d8c] ba7c 0002                 cmp.w      #$0002,d5
[00011d90] 6624                      bne.s      add_index_entry_8
[00011d92] 224d                      movea.l    a5,a1
[00011d94] 202c 00e4                 move.l     228(a4),d0 ; sens_cnt
[00011d98] 206c 00e0                 movea.l    224(a4),a0 ; sens_table
[00011d9c] 4eb9 0001 1dbe            jsr        add_search_key
[00011da2] 52ac 00e4                 addq.l     #1,228(a4) ; sens_cnt
[00011da6] 204e                      movea.l    a6,a0
[00011da8] 4eb9 0001 3a9c            jsr        strlen
[00011dae] 5280                      addq.l     #1,d0
[00011db0] d1b9 0001 54f6            add.l      d0,sens_size
add_index_entry_8:
[00011db6] 584f                      addq.w     #4,a7
[00011db8] 4cdf 7c38                 movem.l    (a7)+,d3-d5/a2-a6
[00011dbc] 4e75                      rts

add_search_key:
[00011dbe] 2f0a                      move.l     a2,-(a7)
[00011dc0] 2f0b                      move.l     a3,-(a7)
[00011dc2] 2648                      movea.l    a0,a3
[00011dc4] 2449                      movea.l    a1,a2
[00011dc6] 2200                      move.l     d0,d1
[00011dc8] d281                      add.l      d1,d1
[00011dca] d280                      add.l      d0,d1
[00011dcc] d281                      add.l      d1,d1
[00011dce] 2791 1800                 move.l     (a1),0(a3,d1.l)
[00011dd2] 37aa 0004 1804            move.w     4(a2),4(a3,d1.l)
[00011dd8] 265f                      movea.l    (a7)+,a3
[00011dda] 245f                      movea.l    (a7)+,a2
[00011ddc] 4e75                      rts

get_index_screen_code:
[00011dde] 2f0a                      move.l     a2,-(a7)
[00011de0] 2f0b                      move.l     a3,-(a7)
[00011de2] 2448                      movea.l    a0,a2
[00011de4] 4240                      clr.w      d0
[00011de6] 1010                      move.b     (a0),d0
[00011de8] d040                      add.w      d0,d0
[00011dea] 43f9 0001 50f2            lea.l      name_to_index,a1
[00011df0] 3231 0000                 move.w     0(a1,d0.w),d1
[00011df4] e749                      lsl.w      #3,d1
[00011df6] 41f9 0001 62fa            lea.l      nameindex,a0
[00011dfc] 2670 1000                 movea.l    0(a0,d1.w),a3
[00011e00] 6018                      bra.s      get_index_screen_code_1
get_index_screen_code_4:
[00011e02] 2253                      movea.l    (a3),a1
[00011e04] 204a                      movea.l    a2,a0
[00011e06] 4eb9 0001 3a02            jsr        strcmp
[00011e0c] 4a40                      tst.w      d0
[00011e0e] 6606                      bne.s      get_index_screen_code_2
[00011e10] 302b 0004                 move.w     4(a3),d0
[00011e14] 600a                      bra.s      get_index_screen_code_3
get_index_screen_code_2:
[00011e16] 266b 0006                 movea.l    6(a3),a3
get_index_screen_code_1:
[00011e1a] 200b                      move.l     a3,d0
[00011e1c] 66e4                      bne.s      get_index_screen_code_4
[00011e1e] 4240                      clr.w      d0
get_index_screen_code_3:
[00011e20] 265f                      movea.l    (a7)+,a3
[00011e22] 245f                      movea.l    (a7)+,a2
[00011e24] 4e75                      rts

index_namecmp:
[00011e26] 2f0a                      move.l     a2,-(a7)
[00011e28] 45f9 0001 52f2            lea.l      uppercase_table,a2
[00011e2e] 600c                      bra.s      index_namecmp_1
index_namecmp_4:
[00011e30] 1010                      move.b     (a0),d0
[00011e32] 6604                      bne.s      index_namecmp_2
[00011e34] 4240                      clr.w      d0
[00011e36] 6024                      bra.s      index_namecmp_3
index_namecmp_2:
[00011e38] 5248                      addq.w     #1,a0
[00011e3a] 5249                      addq.w     #1,a1
index_namecmp_1:
[00011e3c] 4240                      clr.w      d0
[00011e3e] 1010                      move.b     (a0),d0
[00011e40] d040                      add.w      d0,d0
[00011e42] 3232 0000                 move.w     0(a2,d0.w),d1
[00011e46] 4242                      clr.w      d2
[00011e48] 1411                      move.b     (a1),d2
[00011e4a] d442                      add.w      d2,d2
[00011e4c] b272 2000                 cmp.w      0(a2,d2.w),d1
[00011e50] 67de                      beq.s      index_namecmp_4
[00011e52] 4240                      clr.w      d0
[00011e54] 1010                      move.b     (a0),d0
[00011e56] 4241                      clr.w      d1
[00011e58] 1211                      move.b     (a1),d1
[00011e5a] 9041                      sub.w      d1,d0
index_namecmp_3:
[00011e5c] 245f                      movea.l    (a7)+,a2
[00011e5e] 4e75                      rts

parse_index_page:
[00011e60] 203c 0000 01c5            move.l     #$000001C5,d0
[00011e66] 43f9 0001 553d            lea.l      $0001553D,a1
[00011e6c] 2079 0001 59b2            movea.l    hc_inbuf,a0
[00011e72] 4eb9 0001 3ea4            jsr        memcpy
[00011e78] 23f9 0001 59b2 0001 59ba  move.l     hc_inbuf,hc_inbuf_ptr
[00011e82] 4eb9 0001 0d9c            jsr        parse_file
[00011e88] 4e75                      rts

generate_copyright:
[00011e8a] 2f0a                      move.l     a2,-(a7)
[00011e8c] 2f0b                      move.l     a3,-(a7)
[00011e8e] 594f                      subq.w     #4,a7
[00011e90] 45f9 0001 59c2            lea.l      outfile_name,a2
[00011e96] 705c                      moveq.l    #92,d0
[00011e98] 204a                      movea.l    a2,a0
[00011e9a] 4eb9 0001 39e6            jsr        strrchr
[00011ea0] 2648                      movea.l    a0,a3
[00011ea2] 200b                      move.l     a3,d0
[00011ea4] 6604                      bne.s      generate_copyright_1
[00011ea6] 264a                      movea.l    a2,a3
[00011ea8] 6002                      bra.s      generate_copyright_2
generate_copyright_1:
[00011eaa] 524b                      addq.w     #1,a3
generate_copyright_2:
[00011eac] 41d7                      lea.l      (a7),a0
[00011eae] 4eb9 0001 462a            jsr        getdate
[00011eb4] 2f39 0001 5706            move.l     $00015706,-(a7)
[00011eba] 3f2f 0004                 move.w     4(a7),-(a7)
[00011ebe] 4240                      clr.w      d0
[00011ec0] 102f 0009                 move.b     9(a7),d0
[00011ec4] e548                      lsl.w      #2,d0
[00011ec6] 41f9 0001 570a            lea.l      month_names,a0
[00011ecc] 2f30 00fc                 move.l     -4(a0,d0.w),-(a7)
[00011ed0] 4241                      clr.w      d1
[00011ed2] 122f 000c                 move.b     12(a7),d1
[00011ed6] 3f01                      move.w     d1,-(a7)
[00011ed8] 2f0b                      move.l     a3,-(a7)
[00011eda] 2f39 0001 5702            move.l     $00015702,-(a7)
[00011ee0] 43f9 0001 57ed            lea.l      $000157ED,a1
[00011ee6] 2079 0001 59b2            movea.l    hc_inbuf,a0
[00011eec] 4eb9 0001 2a06            jsr        sprintf
[00011ef2] 4fef 0014                 lea.l      20(a7),a7
[00011ef6] 23f9 0001 59b2 0001 59ba  move.l     hc_inbuf,hc_inbuf_ptr
[00011f00] 4eb9 0001 0d9c            jsr        parse_file
[00011f06] 584f                      addq.w     #4,a7
[00011f08] 265f                      movea.l    (a7)+,a3
[00011f0a] 245f                      movea.l    (a7)+,a2
[00011f0c] 4e75                      rts

do_compress:
[00011f0e] 48e7 1f3e                 movem.l    d3-d7/a2-a6,-(a7)
[00011f12] 4243                      clr.w      d3
[00011f14] 45f9 0001 63e2            lea.l      x163e2,a2
[00011f1a] 47f9 0001 63ea            lea.l      x163ea,a3
[00011f20] 203c 0002 33c8            move.l     #$000233C8,d0
[00011f26] 4eb9 0001 3c60            jsr        malloc
[00011f2c] 2488                      move.l     a0,(a2) ; x163e2
[00011f2e] 203c 0002 33c8            move.l     #$000233C8,d0
[00011f34] 4eb9 0001 3c60            jsr        malloc
[00011f3a] 2688                      move.l     a0,(a3) ; x163ea
[00011f3c] 49eb fffc                 lea.l      -4(a3),a4 ; char_counts
[00011f40] 203c 0000 0800            move.l     #$00000800,d0
[00011f46] 4eb9 0001 3c60            jsr        malloc
[00011f4c] 2888                      move.l     a0,(a4) ; char_counts
[00011f4e] 2012                      move.l     (a2),d0 ; x163e2
[00011f50] 6708                      beq.s      do_compress_1
[00011f52] 2213                      move.l     (a3),d1 ; x163ea
[00011f54] 6704                      beq.s      do_compress_1
[00011f56] 2408                      move.l     a0,d2
[00011f58] 660a                      bne.s      do_compress_2
do_compress_1:
[00011f5a] 4241                      clr.w      d1
[00011f5c] 7003                      moveq.l    #3,d0
[00011f5e] 4eb9 0001 0c4e            jsr        hclog
do_compress_2:
[00011f64] 4eb9 0001 24b6            jsr        init_tables
[00011f6a] 203c 0000 4679            move.l     #$00004679,d0
[00011f70] 2053                      movea.l    (a3),a0 ; x163ea
[00011f72] 4eb9 0001 24e6            jsr        init_codeinfo
[00011f78] 203c 0000 0100            move.l     #$00000100,d0
[00011f7e] 2054                      movea.l    (a4),a0 ; char_counts
[00011f80] 4eb9 0001 24e6            jsr        init_codeinfo
[00011f86] 43f9 0001 581b            lea.l      $0001581B,a1
[00011f8c] 41f9 0001 5814            lea.l      $00015814,a0
[00011f92] 4eb9 0001 3266            jsr        fopen
[00011f98] 23c8 0001 5b02            move.l     a0,hc_infile
[00011f9e] 660a                      bne.s      do_compress_3
[00011fa0] 4241                      clr.w      d1
[00011fa2] 7001                      moveq.l    #1,d0
[00011fa4] 4eb9 0001 0c4e            jsr        hclog
do_compress_3:
[00011faa] 3039 0001 466c            move.w     options.verbose,d0
[00011fb0] 6712                      beq.s      do_compress_4
[00011fb2] 43f9 0001 581e            lea.l      $0001581E,a1
[00011fb8] 41f9 0001 593e            lea.l      stderr,a0
[00011fbe] 4eb9 0001 29c8            jsr        fprintf
do_compress_4:
[00011fc4] 7800                      moveq.l    #0,d4
[00011fc6] 6000 00e6                 bra        do_compress_5
do_compress_11:
[00011fca] 2004                      move.l     d4,d0
[00011fcc] e588                      lsl.l      #2,d0
[00011fce] 2079 0001 62f6            movea.l    screen_table_offset,a0
[00011fd4] 2230 0804                 move.l     4(a0,d0.l),d1
[00011fd8] 92b0 0800                 sub.l      0(a0,d0.l),d1
[00011fdc] 23c1 0001 4662            move.l     d1,hc_inbuf_size
[00011fe2] 2f01                      move.l     d1,-(a7)
[00011fe4] 2279 0001 59b2            movea.l    hc_inbuf,a1
[00011fea] 2079 0001 5b02            movea.l    hc_infile,a0
[00011ff0] 2001                      move.l     d1,d0
[00011ff2] 4eb9 0001 0a94            jsr        hc_fread
[00011ff8] b09f                      cmp.l      (a7)+,d0
[00011ffa] 6712                      beq.s      do_compress_6
[00011ffc] 4879 0001 5843            pea.l      $00015843
[00012002] 4241                      clr.w      d1
[00012004] 7005                      moveq.l    #5,d0
[00012006] 4eb9 0001 0c4e            jsr        hclog
[0001200c] 584f                      addq.w     #4,a7
do_compress_6:
[0001200e] 4df9 0001 59ba            lea.l      hc_inbuf_ptr,a6
[00012014] 2cb9 0001 59b2            move.l     hc_inbuf,(a6) ; hc_inbuf_ptr
[0001201a] 7c01                      moveq.l    #1,d6
[0001201c] 2056                      movea.l    (a6),a0 ; hc_inbuf_ptr
[0001201e] 4247                      clr.w      d7
[00012020] 1e10                      move.b     (a0),d7
[00012022] 4447                      neg.w      d7
[00012024] 5296                      addq.l     #1,(a6) ; hc_inbuf_ptr
[00012026] 4240                      clr.w      d0
[00012028] 1010                      move.b     (a0),d0
[0001202a] 48c0                      ext.l      d0
[0001202c] e788                      lsl.l      #3,d0
[0001202e] 2054                      movea.l    (a4),a0 ; char_counts
[00012030] 52b0 0800                 addq.l     #1,0(a0,d0.l)
[00012034] 6062                      bra.s      do_compress_7
do_compress_10:
[00012036] 2056                      movea.l    (a6),a0 ; hc_inbuf_ptr
[00012038] 5296                      addq.l     #1,(a6) ; hc_inbuf_ptr
[0001203a] 4245                      clr.w      d5
[0001203c] 1a10                      move.b     (a0),d5
[0001203e] 3205                      move.w     d5,d1
[00012040] 3007                      move.w     d7,d0
[00012042] 4eb9 0001 24fe            jsr        x124fe
[00012048] 7200                      moveq.l    #0,d1
[0001204a] 3205                      move.w     d5,d1
[0001204c] e789                      lsl.l      #3,d1
[0001204e] 2054                      movea.l    (a4),a0 ; char_counts
[00012050] 52b0 1800                 addq.l     #1,0(a0,d1.l)
[00012054] 5246                      addq.w     #1,d6
[00012056] 2400                      move.l     d0,d2
[00012058] e78a                      lsl.l      #3,d2
[0001205a] 2052                      movea.l    (a2),a0 ; x163e2
[0001205c] 0c70 ff00 2802            cmpi.w     #$FF00,2(a0,d2.l)
[00012062] 6704                      beq.s      do_compress_8
[00012064] 3e00                      move.w     d0,d7
[00012066] 6030                      bra.s      do_compress_7
do_compress_8:
[00012068] b67c 3ffe                 cmp.w      #$3FFE,d3
[0001206c] 6218                      bhi.s      do_compress_9
[0001206e] 5243                      addq.w     #1,d3
[00012070] 2200                      move.l     d0,d1
[00012072] e789                      lsl.l      #3,d1
[00012074] 2052                      movea.l    (a2),a0 ; x163e2
[00012076] 3186 1800                 move.w     d6,0(a0,d1.l)
[0001207a] 2052                      movea.l    (a2),a0 ; x163e2
[0001207c] 3187 1802                 move.w     d7,2(a0,d1.l)
[00012080] 2052                      movea.l    (a2),a0 ; x163e2
[00012082] 1185 1806                 move.b     d5,6(a0,d1.l)
do_compress_9:
[00012086] 7000                      moveq.l    #0,d0
[00012088] 3007                      move.w     d7,d0
[0001208a] e788                      lsl.l      #3,d0
[0001208c] 2053                      movea.l    (a3),a0 ; x163ea
[0001208e] 52b0 0800                 addq.l     #1,0(a0,d0.l)
[00012092] 3e05                      move.w     d5,d7
[00012094] 4447                      neg.w      d7
[00012096] 7c01                      moveq.l    #1,d6
do_compress_7:
[00012098] 2039 0001 4662            move.l     hc_inbuf_size,d0
[0001209e] 2079 0001 59b2            movea.l    hc_inbuf,a0
[000120a4] d1c0                      adda.l     d0,a0
[000120a6] 2256                      movea.l    (a6),a1 ; hc_inbuf_ptr
[000120a8] b3c8                      cmpa.l     a0,a1
[000120aa] 658a                      bcs.s      do_compress_10
[000120ac] 5284                      addq.l     #1,d4
do_compress_5:
[000120ae] 3039 0001 5072            move.w     screen_cnt,d0
[000120b4] 48c0                      ext.l      d0
[000120b6] b880                      cmp.l      d0,d4
[000120b8] 6d00 ff10                 blt        do_compress_11
[000120bc] 3239 0001 466c            move.w     options.verbose,d1
[000120c2] 6712                      beq.s      do_compress_12
[000120c4] 43f9 0001 5852            lea.l      $00015852,a1
[000120ca] 41f9 0001 593e            lea.l      stderr,a0
[000120d0] 4eb9 0001 29c8            jsr        fprintf
do_compress_12:
[000120d6] 7800                      moveq.l    #0,d4
[000120d8] 6048                      bra.s      do_compress_13
do_compress_17:
[000120da] 2004                      move.l     d4,d0
[000120dc] e788                      lsl.l      #3,d0
[000120de] 2052                      movea.l    (a2),a0 ; x163e2
[000120e0] 0c70 0004 0800            cmpi.w     #$0004,0(a0,d0.l)
[000120e6] 6d0a                      blt.s      do_compress_14
[000120e8] 2253                      movea.l    (a3),a1 ; x163ea
[000120ea] 7202                      moveq.l    #2,d1
[000120ec] b2b1 0800                 cmp.l      0(a1,d0.l),d1
[000120f0] 6f0c                      ble.s      do_compress_15
do_compress_14:
[000120f2] 2004                      move.l     d4,d0
[000120f4] e788                      lsl.l      #3,d0
[000120f6] 2053                      movea.l    (a3),a0 ; x163ea
[000120f8] 42b0 0800                 clr.l      0(a0,d0.l)
[000120fc] 6022                      bra.s      do_compress_16
do_compress_15:
[000120fe] 2204                      move.l     d4,d1
[00012100] e789                      lsl.l      #3,d1
[00012102] 2053                      movea.l    (a3),a0 ; x163ea
[00012104] 2030 1800                 move.l     0(a0,d1.l),d0
[00012108] 2252                      movea.l    (a2),a1 ; x163e2
[0001210a] 3231 1800                 move.w     0(a1,d1.l),d1
[0001210e] 48c1                      ext.l      d1
[00012110] 4eb9 0001 44d6            jsr        _lmul
[00012116] 2204                      move.l     d4,d1
[00012118] e789                      lsl.l      #3,d1
[0001211a] 2053                      movea.l    (a3),a0 ; x163ea
[0001211c] 2180 1800                 move.l     d0,0(a0,d1.l)
do_compress_16:
[00012120] 5284                      addq.l     #1,d4
do_compress_13:
[00012122] b8bc 0000 4679            cmp.l      #$00004679,d4
[00012128] 6db0                      blt.s      do_compress_17
[0001212a] 43f9 0001 24b0            lea.l      codecmp,a1
[00012130] 7208                      moveq.l    #8,d1
[00012132] 203c 0000 1000            move.l     #$00001000,d0
[00012138] 2053                      movea.l    (a3),a0 ; x163ea
[0001213a] 4eb9 0001 256a            jsr        sort_codes
[00012140] 2053                      movea.l    (a3),a0 ; x163ea
[00012142] 7004                      moveq.l    #4,d0
[00012144] b0a8 7ff8                 cmp.l      32760(a0),d0
[00012148] 6c06                      bge.s      do_compress_18
[0001214a] 2a28 7ff8                 move.l     32760(a0),d5
[0001214e] 6002                      bra.s      do_compress_19
do_compress_18:
[00012150] 7a04                      moveq.l    #4,d5
do_compress_19:
[00012152] 283c 0000 1000            move.l     #$00001000,d4
[00012158] 6000 00ae                 bra        do_compress_20
do_compress_28:
[0001215c] 2004                      move.l     d4,d0
[0001215e] e788                      lsl.l      #3,d0
[00012160] 2053                      movea.l    (a3),a0 ; x163ea
[00012162] bab0 0800                 cmp.l      0(a0,d0.l),d5
[00012166] 6c00 009e                 bge        do_compress_21
[0001216a] 2e3c 0000 07ff            move.l     #$000007FF,d7
[00012170] 2c3c 0000 0400            move.l     #$00000400,d6
do_compress_26:
[00012176] 2007                      move.l     d7,d0
[00012178] e788                      lsl.l      #3,d0
[0001217a] 2053                      movea.l    (a3),a0 ; x163ea
[0001217c] 2230 0800                 move.l     0(a0,d0.l),d1
[00012180] 2404                      move.l     d4,d2
[00012182] e78a                      lsl.l      #3,d2
[00012184] b2b0 2800                 cmp.l      0(a0,d2.l),d1
[00012188] 6738                      beq.s      do_compress_22
[0001218a] 2630 08f8                 move.l     -8(a0,d0.l),d3
[0001218e] b6b0 2800                 cmp.l      0(a0,d2.l),d3
[00012192] 6f06                      ble.s      do_compress_23
[00012194] b2b0 2800                 cmp.l      0(a0,d2.l),d1
[00012198] 6d28                      blt.s      do_compress_22
do_compress_23:
[0001219a] 2007                      move.l     d7,d0
[0001219c] e788                      lsl.l      #3,d0
[0001219e] 2053                      movea.l    (a3),a0 ; x163ea
[000121a0] 2230 0800                 move.l     0(a0,d0.l),d1
[000121a4] 2404                      move.l     d4,d2
[000121a6] e78a                      lsl.l      #3,d2
[000121a8] b2b0 2800                 cmp.l      0(a0,d2.l),d1
[000121ac] 6f04                      ble.s      do_compress_24
[000121ae] de86                      add.l      d6,d7
[000121b0] 6002                      bra.s      do_compress_25
do_compress_24:
[000121b2] 9e86                      sub.l      d6,d7
do_compress_25:
[000121b4] 2006                      move.l     d6,d0
[000121b6] 7202                      moveq.l    #2,d1
[000121b8] 4eb9 0001 4520            jsr        _ldiv
[000121be] 2c00                      move.l     d0,d6
[000121c0] 60b4                      bra.s      do_compress_26
do_compress_22:
[000121c2] 203c 0000 0fff            move.l     #$00000FFF,d0
[000121c8] 9087                      sub.l      d7,d0
[000121ca] e788                      lsl.l      #3,d0
[000121cc] 2207                      move.l     d7,d1
[000121ce] e789                      lsl.l      #3,d1
[000121d0] 2253                      movea.l    (a3),a1 ; x163ea
[000121d2] d3c1                      adda.l     d1,a1
[000121d4] 2053                      movea.l    (a3),a0 ; x163ea
[000121d6] 41f0 1808                 lea.l      8(a0,d1.l),a0
[000121da] 4eb9 0001 3ea4            jsr        memcpy
[000121e0] 2004                      move.l     d4,d0
[000121e2] e788                      lsl.l      #3,d0
[000121e4] 2053                      movea.l    (a3),a0 ; x163ea
[000121e6] d1c0                      adda.l     d0,a0
[000121e8] 2207                      move.l     d7,d1
[000121ea] e789                      lsl.l      #3,d1
[000121ec] 2253                      movea.l    (a3),a1 ; x163ea
[000121ee] d3c1                      adda.l     d1,a1
[000121f0] 22d8                      move.l     (a0)+,(a1)+
[000121f2] 22d8                      move.l     (a0)+,(a1)+
[000121f4] 2053                      movea.l    (a3),a0 ; x163ea
[000121f6] 7404                      moveq.l    #4,d2
[000121f8] b4a8 7ff8                 cmp.l      32760(a0),d2
[000121fc] 6c06                      bge.s      do_compress_27
[000121fe] 2a28 7ff8                 move.l     32760(a0),d5
[00012202] 6002                      bra.s      do_compress_21
do_compress_27:
[00012204] 7a04                      moveq.l    #4,d5
do_compress_21:
[00012206] 5284                      addq.l     #1,d4
do_compress_20:
[00012208] b8bc 0000 4679            cmp.l      #$00004679,d4
[0001220e] 6d00 ff4c                 blt        do_compress_28
[00012212] 283c 0000 0fff            move.l     #$00000FFF,d4
[00012218] 6002                      bra.s      do_compress_29
do_compress_31:
[0001221a] 5384                      subq.l     #1,d4
do_compress_29:
[0001221c] 4a84                      tst.l      d4
[0001221e] 6f0c                      ble.s      do_compress_30
[00012220] 2004                      move.l     d4,d0
[00012222] e788                      lsl.l      #3,d0
[00012224] 2053                      movea.l    (a3),a0 ; x163ea
[00012226] 2230 0800                 move.l     0(a0,d0.l),d1
[0001222a] 67ee                      beq.s      do_compress_31
do_compress_30:
[0001222c] 7c01                      moveq.l    #1,d6
[0001222e] dc84                      add.l      d4,d6
[00012230] 7001                      moveq.l    #1,d0
[00012232] d086                      add.l      d6,d0
[00012234] e588                      lsl.l      #2,d0
[00012236] 4eb9 0001 3c60            jsr        malloc
[0001223c] 2c48                      movea.l    a0,a6
[0001223e] 200e                      move.l     a6,d0
[00012240] 660a                      bne.s      do_compress_32
[00012242] 4241                      clr.w      d1
[00012244] 7003                      moveq.l    #3,d0
[00012246] 4eb9 0001 0c4e            jsr        hclog
do_compress_32:
[0001224c] 7001                      moveq.l    #1,d0
[0001224e] d086                      add.l      d6,d0
[00012250] e588                      lsl.l      #2,d0
[00012252] 2c80                      move.l     d0,(a6)
[00012254] 7800                      moveq.l    #0,d4
[00012256] 6022                      bra.s      do_compress_33
do_compress_34:
[00012258] 2004                      move.l     d4,d0
[0001225a] e788                      lsl.l      #3,d0
[0001225c] 2053                      movea.l    (a3),a0 ; x163ea
[0001225e] 2230 0804                 move.l     4(a0,d0.l),d1
[00012262] e789                      lsl.l      #3,d1
[00012264] 2252                      movea.l    (a2),a1 ; x163e2
[00012266] 3431 1800                 move.w     0(a1,d1.l),d2
[0001226a] 48c2                      ext.l      d2
[0001226c] 2604                      move.l     d4,d3
[0001226e] e58b                      lsl.l      #2,d3
[00012270] d4b6 3800                 add.l      0(a6,d3.l),d2
[00012274] 2d82 3804                 move.l     d2,4(a6,d3.l)
[00012278] 5284                      addq.l     #1,d4
do_compress_33:
[0001227a] bc84                      cmp.l      d4,d6
[0001227c] 6eda                      bgt.s      do_compress_34
[0001227e] 41f9 0001 586a            lea.l      $0001586A,a0
[00012284] 4eb9 0001 0b0c            jsr        hc_createfile
[0001228a] 3039 0001 466c            move.w     options.verbose,d0
[00012290] 6712                      beq.s      do_compress_35
[00012292] 43f9 0001 5871            lea.l      $00015871,a1
[00012298] 41f9 0001 593e            lea.l      stderr,a0
[0001229e] 4eb9 0001 29c8            jsr        fprintf
do_compress_35:
[000122a4] 224e                      movea.l    a6,a1
[000122a6] 7001                      moveq.l    #1,d0
[000122a8] d086                      add.l      d6,d0
[000122aa] e588                      lsl.l      #2,d0
[000122ac] 2079 0001 5b06            movea.l    hc_outfile,a0
[000122b2] 4eb9 0001 0aaa            jsr        hc_fwrite
[000122b8] 4a40                      tst.w      d0
[000122ba] 6612                      bne.s      do_compress_36
[000122bc] 4879 0001 5843            pea.l      $00015843
[000122c2] 4241                      clr.w      d1
[000122c4] 7004                      moveq.l    #4,d0
[000122c6] 4eb9 0001 0c4e            jsr        hclog
[000122cc] 584f                      addq.w     #4,a7
do_compress_36:
[000122ce] 2006                      move.l     d6,d0
[000122d0] e788                      lsl.l      #3,d0
[000122d2] 2053                      movea.l    (a3),a0 ; x163ea
[000122d4] 7204                      moveq.l    #4,d1
[000122d6] b2b0 08f8                 cmp.l      -8(a0,d0.l),d1
[000122da] 6c06                      bge.s      do_compress_37
[000122dc] 2a30 08f8                 move.l     -8(a0,d0.l),d5
[000122e0] 6002                      bra.s      do_compress_38
do_compress_37:
[000122e2] 7a04                      moveq.l    #4,d5
do_compress_38:
[000122e4] 7800                      moveq.l    #0,d4
[000122e6] 6000 00e4                 bra        do_compress_39
do_compress_45:
[000122ea] 2004                      move.l     d4,d0
[000122ec] e788                      lsl.l      #3,d0
[000122ee] 2053                      movea.l    (a3),a0 ; x163ea
[000122f0] bab0 0800                 cmp.l      0(a0,d0.l),d5
[000122f4] 6e00 00d4                 bgt        do_compress_40
[000122f8] 2e30 0804                 move.l     4(a0,d0.l),d7
[000122fc] 2207                      move.l     d7,d1
[000122fe] e789                      lsl.l      #3,d1
[00012300] 2252                      movea.l    (a2),a1 ; x163e2
[00012302] 3384 1804                 move.w     d4,4(a1,d1.l)
[00012306] 2053                      movea.l    (a3),a0 ; x163ea
[00012308] 2030 0800                 move.l     0(a0,d0.l),d0
[0001230c] 2252                      movea.l    (a2),a1 ; x163e2
[0001230e] 3231 1800                 move.w     0(a1,d1.l),d1
[00012312] 48c1                      ext.l      d1
[00012314] 4eb9 0001 4520            jsr        _ldiv
[0001231a] 2207                      move.l     d7,d1
[0001231c] e789                      lsl.l      #3,d1
[0001231e] 2052                      movea.l    (a2),a0 ; x163e2
[00012320] 3430 1800                 move.w     0(a0,d1.l),d2
[00012324] 2a79 0001 59b6            movea.l    screenbuf,a5
[0001232a] dac2                      adda.w     d2,a5
[0001232c] 23cd 0001 59be            move.l     a5,screenbuf_ptr
[00012332] 4215                      clr.b      (a5)
[00012334] 603e                      bra.s      do_compress_41
do_compress_43:
[00012336] 2207                      move.l     d7,d1
[00012338] e789                      lsl.l      #3,d1
[0001233a] 2052                      movea.l    (a2),a0 ; x163e2
[0001233c] 1430 1806                 move.b     6(a0,d1.l),d2
[00012340] 163c 00a3                 move.b     #$A3,d3
[00012344] b702                      eor.b      d3,d2
[00012346] 1b02                      move.b     d2,-(a5)
[00012348] 4242                      clr.w      d2
[0001234a] 1415                      move.b     (a5),d2
[0001234c] 48c2                      ext.l      d2
[0001234e] e78a                      lsl.l      #3,d2
[00012350] 2054                      movea.l    (a4),a0 ; char_counts
[00012352] 91b0 2800                 sub.l      d0,0(a0,d2.l)
[00012356] 2052                      movea.l    (a2),a0 ; x163e2
[00012358] 0c70 ffff 1804            cmpi.w     #$FFFF,4(a0,d1.l)
[0001235e] 6c06                      bge.s      do_compress_42
[00012360] 31bc ffff 1804            move.w     #$FFFF,4(a0,d1.l)
do_compress_42:
[00012366] 2207                      move.l     d7,d1
[00012368] e789                      lsl.l      #3,d1
[0001236a] 2052                      movea.l    (a2),a0 ; x163e2
[0001236c] 3430 1802                 move.w     2(a0,d1.l),d2
[00012370] 48c2                      ext.l      d2
[00012372] 2e02                      move.l     d2,d7
do_compress_41:
[00012374] 2207                      move.l     d7,d1
[00012376] e789                      lsl.l      #3,d1
[00012378] 2052                      movea.l    (a2),a0 ; x163e2
[0001237a] 3430 1802                 move.w     2(a0,d1.l),d2
[0001237e] 6ab6                      bpl.s      do_compress_43
[00012380] 1630 1806                 move.b     6(a0,d1.l),d3
[00012384] 143c 00a3                 move.b     #$A3,d2
[00012388] b503                      eor.b      d2,d3
[0001238a] 1b03                      move.b     d3,-(a5)
[0001238c] 4243                      clr.w      d3
[0001238e] 1615                      move.b     (a5),d3
[00012390] 48c3                      ext.l      d3
[00012392] e78b                      lsl.l      #3,d3
[00012394] 2054                      movea.l    (a4),a0 ; char_counts
[00012396] 91b0 3800                 sub.l      d0,0(a0,d3.l)
[0001239a] 2052                      movea.l    (a2),a0 ; x163e2
[0001239c] 1630 1803                 move.b     3(a0,d1.l),d3
[000123a0] 4403                      neg.b      d3
[000123a2] b503                      eor.b      d2,d3
[000123a4] 1b03                      move.b     d3,-(a5)
[000123a6] 4243                      clr.w      d3
[000123a8] 1615                      move.b     (a5),d3
[000123aa] 48c3                      ext.l      d3
[000123ac] e78b                      lsl.l      #3,d3
[000123ae] 2054                      movea.l    (a4),a0 ; char_counts
[000123b0] 91b0 3800                 sub.l      d0,0(a0,d3.l)
[000123b4] 2052                      movea.l    (a2),a0 ; x163e2
[000123b6] 0c70 ffff 1804            cmpi.w     #$FFFF,4(a0,d1.l)
[000123bc] 6c06                      bge.s      do_compress_44
[000123be] 31bc ffff 1804            move.w     #$FFFF,4(a0,d1.l)
do_compress_44:
[000123c4] 4eb9 0001 0a54            jsr        hc_flshbuf
do_compress_40:
[000123ca] 5284                      addq.l     #1,d4
do_compress_39:
[000123cc] bc84                      cmp.l      d4,d6
[000123ce] 6e00 ff1a                 bgt        do_compress_45
[000123d2] 2006                      move.l     d6,d0
[000123d4] e588                      lsl.l      #2,d0
[000123d6] 2236 0800                 move.l     0(a6,d0.l),d1
[000123da] 23c1 0001 62ca            move.l     d1,helphdr.str_size
[000123e0] c2bc 0000 0001            and.l      #$00000001,d1
[000123e6] 671c                      beq.s      do_compress_46
[000123e8] 52b9 0001 62ca            addq.l     #1,helphdr.str_size
[000123ee] 2279 0001 5b06            movea.l    hc_outfile,a1
[000123f4] 7201                      moveq.l    #1,d1
[000123f6] 2079 0001 59be            movea.l    screenbuf_ptr,a0
[000123fc] 7001                      moveq.l    #1,d0
[000123fe] 4eb9 0001 302e            jsr        fwrite
do_compress_46:
[00012404] 4eb9 0001 0bac            jsr        hc_closeout
[0001240a] 204e                      movea.l    a6,a0
[0001240c] 4eb9 0001 3d48            jsr        free
[00012412] 2053                      movea.l    (a3),a0 ; x163ea
[00012414] 4eb9 0001 3d48            jsr        free
[0001241a] 720c                      moveq.l    #12,d1
[0001241c] 4240                      clr.w      d0
[0001241e] 41f9 0001 62ce            lea.l      helphdr.char_table,a0
[00012424] 4eb9 0001 408e            jsr        memset
[0001242a] 7000                      moveq.l    #0,d0
[0001242c] 2054                      movea.l    (a4),a0 ; char_counts
[0001242e] 2140 0068                 move.l     d0,104(a0)
[00012432] 2054                      movea.l    (a4),a0 ; char_counts
[00012434] 2140 0050                 move.l     d0,80(a0)
[00012438] 2054                      movea.l    (a4),a0 ; char_counts
[0001243a] 2080                      move.l     d0,(a0)
[0001243c] 43f9 0001 24b0            lea.l      codecmp,a1
[00012442] 7208                      moveq.l    #8,d1
[00012444] 2054                      movea.l    (a4),a0 ; char_counts
[00012446] 203c 0000 0100            move.l     #$00000100,d0
[0001244c] 4eb9 0001 256a            jsr        sort_codes
[00012452] 7800                      moveq.l    #0,d4
[00012454] 6014                      bra.s      do_compress_47
do_compress_48:
[00012456] 2004                      move.l     d4,d0
[00012458] e788                      lsl.l      #3,d0
[0001245a] 2054                      movea.l    (a4),a0 ; char_counts
[0001245c] 43f9 0001 626a            lea.l      helphdr,a1
[00012462] 13b0 0807 4064            move.b     7(a0,d0.l),100(a1,d4.w)
[00012468] 5284                      addq.l     #1,d4
do_compress_47:
[0001246a] 700c                      moveq.l    #12,d0
[0001246c] b084                      cmp.l      d4,d0
[0001246e] 6ee6                      bgt.s      do_compress_48
[00012470] 2054                      movea.l    (a4),a0 ; char_counts
[00012472] 4eb9 0001 3d48            jsr        free
[00012478] 2079 0001 5b02            movea.l    hc_infile,a0
[0001247e] 4eb9 0001 31d4            jsr        rewind
[00012484] 4eb9 0001 2654            jsr        write_compression
[0001248a] 2079 0001 5b02            movea.l    hc_infile,a0
[00012490] 4eb9 0001 3436            jsr        fclose
[00012496] 2052                      movea.l    (a2),a0 ; x163e2
[00012498] 4eb9 0001 3d48            jsr        free
[0001249e] 41f9 0001 5814            lea.l      $00015814,a0
[000124a4] 4eb9 0001 367c            jsr        unlink
[000124aa] 4cdf 7cf8                 movem.l    (a7)+,d3-d7/a2-a6
[000124ae] 4e75                      rts

codecmp:
[000124b0] 2011                      move.l     (a1),d0
[000124b2] 9090                      sub.l      (a0),d0
[000124b4] 4e75                      rts

init_tables:
[000124b6] 7000                      moveq.l    #0,d0
[000124b8] 41f9 0001 63e2            lea.l      x163e2,a0
[000124be] 601c                      bra.s      init_tables_1
init_tables_2:
[000124c0] 2200                      move.l     d0,d1
[000124c2] e789                      lsl.l      #3,d1
[000124c4] 2250                      movea.l    (a0),a1 ; x163e2
[000124c6] 4271 1800                 clr.w      0(a1,d1.l)
[000124ca] 2250                      movea.l    (a0),a1 ; x163e2
[000124cc] 33bc ff00 1802            move.w     #$FF00,2(a1,d1.l)
[000124d2] 2250                      movea.l    (a0),a1 ; x163e2
[000124d4] 33bc fffe 1804            move.w     #$FFFE,4(a1,d1.l)
[000124da] 5280                      addq.l     #1,d0
init_tables_1:
[000124dc] b0bc 0000 4679            cmp.l      #$00004679,d0
[000124e2] 6ddc                      blt.s      init_tables_2
[000124e4] 4e75                      rts

init_codeinfo:
[000124e6] 7200                      moveq.l    #0,d1
[000124e8] 600e                      bra.s      init_codeinfo_1
init_codeinfo_2:
[000124ea] 2401                      move.l     d1,d2
[000124ec] e78a                      lsl.l      #3,d2
[000124ee] 42b0 2800                 clr.l      0(a0,d2.l)
[000124f2] 2181 2804                 move.l     d1,4(a0,d2.l)
[000124f6] 5281                      addq.l     #1,d1
init_codeinfo_1:
[000124f8] b081                      cmp.l      d1,d0
[000124fa] 6eee                      bgt.s      init_codeinfo_2
[000124fc] 4e75                      rts

x124fe:
[000124fe] 48e7 1c00                 movem.l    d3-d5,-(a7)
[00012502] 3600                      move.w     d0,d3
[00012504] 3801                      move.w     d1,d4
[00012506] ed49                      lsl.w      #6,d1
[00012508] b141                      eor.w      d0,d1
[0001250a] 7a00                      moveq.l    #0,d5
[0001250c] 3a01                      move.w     d1,d5
[0001250e] 2005                      move.l     d5,d0
[00012510] 223c 0000 4679            move.l     #$00004679,d1
[00012516] 4eb9 0001 4594            jsr        _lmod
[0001251c] 2a00                      move.l     d0,d5
[0001251e] 4a85                      tst.l      d5
[00012520] 6604                      bne.s      x124fe_1
[00012522] 7001                      moveq.l    #1,d0
[00012524] 6008                      bra.s      x124fe_2
x124fe_1:
[00012526] 203c 0000 4679            move.l     #$00004679,d0
[0001252c] 9085                      sub.l      d5,d0
x124fe_2:
[0001252e] 41f9 0001 63e2            lea.l      x163e2,a0
[00012534] 2205                      move.l     d5,d1
[00012536] e789                      lsl.l      #3,d1
[00012538] 2250                      movea.l    (a0),a1 ; x163e2
[0001253a] 0c71 ff00 1802            cmpi.w     #$FF00,2(a1,d1.l)
[00012540] 6710                      beq.s      x124fe_3
[00012542] b671 1802                 cmp.w      2(a1,d1.l),d3
[00012546] 660e                      bne.s      x124fe_4
[00012548] 4242                      clr.w      d2
[0001254a] 1431 1806                 move.b     6(a1,d1.l),d2
[0001254e] b842                      cmp.w      d2,d4
[00012550] 6604                      bne.s      x124fe_4
x124fe_3:
[00012552] 2005                      move.l     d5,d0
[00012554] 600e                      bra.s      x124fe_5
x124fe_4:
[00012556] 9a80                      sub.l      d0,d5
[00012558] 4a85                      tst.l      d5
[0001255a] 6ad2                      bpl.s      x124fe_2
[0001255c] dabc 0000 4679            add.l      #$00004679,d5
[00012562] 60ca                      bra.s      x124fe_2
x124fe_5:
[00012564] 4cdf 0038                 movem.l    (a7)+,d3-d5
[00012568] 4e75                      rts

sort_codes:
[0001256a] 48e7 1e3c                 movem.l    d3-d6/a2-a5,-(a7)
[0001256e] 514f                      subq.w     #8,a7
[00012570] 2f48 0004                 move.l     a0,4(a7)
[00012574] 2600                      move.l     d0,d3
[00012576] 2801                      move.l     d1,d4
[00012578] 2449                      movea.l    a1,a2
[0001257a] 7402                      moveq.l    #2,d2
[0001257c] b480                      cmp.l      d0,d2
[0001257e] 6200 00ba                 bhi        sort_codes_1
[00012582] 91c1                      suba.l     d1,a0
[00012584] 2e88                      move.l     a0,(a7)
[00012586] e288                      lsr.l      #1,d0
[00012588] 4eb9 0001 445c            jsr        _ulmul
[0001258e] 2a00                      move.l     d0,d5
[00012590] 2857                      movea.l    (a7),a4
[00012592] d9c5                      adda.l     d5,a4
[00012594] d9c5                      adda.l     d5,a4
[00012596] 7201                      moveq.l    #1,d1
[00012598] c283                      and.l      d3,d1
[0001259a] 6744                      beq.s      sort_codes_2
[0001259c] d9c4                      adda.l     d4,a4
[0001259e] 6040                      bra.s      sort_codes_2
sort_codes_7:
[000125a0] 2c05                      move.l     d5,d6
[000125a2] 2a57                      movea.l    (a7),a5
[000125a4] dbc6                      adda.l     d6,a5
[000125a6] 602e                      bra.s      sort_codes_3
sort_codes_6:
[000125a8] dc86                      add.l      d6,d6
[000125aa] b9cb                      cmpa.l     a3,a4
[000125ac] 6710                      beq.s      sort_codes_4
[000125ae] 224b                      movea.l    a3,a1
[000125b0] 41f3 4800                 lea.l      0(a3,d4.l),a0
[000125b4] 4e92                      jsr        (a2)
[000125b6] 4a80                      tst.l      d0
[000125b8] 6f04                      ble.s      sort_codes_4
[000125ba] d7c4                      adda.l     d4,a3
[000125bc] dc84                      add.l      d4,d6
sort_codes_4:
[000125be] 224b                      movea.l    a3,a1
[000125c0] 204d                      movea.l    a5,a0
[000125c2] 4e92                      jsr        (a2)
[000125c4] 4a80                      tst.l      d0
[000125c6] 6a16                      bpl.s      sort_codes_5
[000125c8] 2004                      move.l     d4,d0
[000125ca] 224b                      movea.l    a3,a1
[000125cc] 204d                      movea.l    a5,a0
[000125ce] 4eb9 0001 2642            jsr        swap
[000125d4] 2a4b                      movea.l    a3,a5
sort_codes_3:
[000125d6] 47f5 6800                 lea.l      0(a5,d6.l),a3
[000125da] b9cb                      cmpa.l     a3,a4
[000125dc] 64ca                      bcc.s      sort_codes_6
sort_codes_5:
[000125de] 9a84                      sub.l      d4,d5
sort_codes_2:
[000125e0] b885                      cmp.l      d5,d4
[000125e2] 66bc                      bne.s      sort_codes_7
[000125e4] 604e                      bra.s      sort_codes_8
sort_codes_13:
[000125e6] 2a6f 0004                 movea.l    4(a7),a5
[000125ea] 2c04                      move.l     d4,d6
[000125ec] 602e                      bra.s      sort_codes_9
sort_codes_12:
[000125ee] dc86                      add.l      d6,d6
[000125f0] b9cb                      cmpa.l     a3,a4
[000125f2] 6710                      beq.s      sort_codes_10
[000125f4] 224b                      movea.l    a3,a1
[000125f6] 41f3 4800                 lea.l      0(a3,d4.l),a0
[000125fa] 4e92                      jsr        (a2)
[000125fc] 4a80                      tst.l      d0
[000125fe] 6f04                      ble.s      sort_codes_10
[00012600] d7c4                      adda.l     d4,a3
[00012602] dc84                      add.l      d4,d6
sort_codes_10:
[00012604] 224b                      movea.l    a3,a1
[00012606] 204d                      movea.l    a5,a0
[00012608] 4e92                      jsr        (a2)
[0001260a] 4a80                      tst.l      d0
[0001260c] 6a16                      bpl.s      sort_codes_11
[0001260e] 2004                      move.l     d4,d0
[00012610] 224b                      movea.l    a3,a1
[00012612] 204d                      movea.l    a5,a0
[00012614] 4eb9 0001 2642            jsr        swap
[0001261a] 2a4b                      movea.l    a3,a5
sort_codes_9:
[0001261c] 47f5 6800                 lea.l      0(a5,d6.l),a3
[00012620] b9cb                      cmpa.l     a3,a4
[00012622] 64ca                      bcc.s      sort_codes_12
sort_codes_11:
[00012624] 2004                      move.l     d4,d0
[00012626] 224c                      movea.l    a4,a1
[00012628] 206f 0004                 movea.l    4(a7),a0
[0001262c] 4eb9 0001 2642            jsr        swap
[00012632] 99c4                      suba.l     d4,a4
sort_codes_8:
[00012634] b9ef 0004                 cmpa.l     4(a7),a4
[00012638] 66ac                      bne.s      sort_codes_13
sort_codes_1:
[0001263a] 504f                      addq.w     #8,a7
[0001263c] 4cdf 3c78                 movem.l    (a7)+,d3-d6/a2-a5
[00012640] 4e75                      rts

swap:
[00012642] 6006                      bra.s      swap_1
swap_2:
[00012644] 1210                      move.b     (a0),d1
[00012646] 10d1                      move.b     (a1),(a0)+
[00012648] 12c1                      move.b     d1,(a1)+
swap_1:
[0001264a] 2200                      move.l     d0,d1
[0001264c] 5380                      subq.l     #1,d0
[0001264e] 4a81                      tst.l      d1
[00012650] 66f2                      bne.s      swap_2
[00012652] 4e75                      rts

write_compression:
[00012654] 48e7 1f3e                 movem.l    d3-d7/a2-a6,-(a7)
[00012658] 514f                      subq.w     #8,a7
[0001265a] 42b9 0001 5078            clr.l      screen_start
[00012660] 4bf9 0001 59b2            lea.l      hc_inbuf,a5
[00012666] 47f9 0001 63e2            lea.l      x163e2,a3
[0001266c] 2653                      movea.l    (a3),a3 ; x163e2
[0001266e] 2479 0001 62f6            movea.l    screen_table_offset,a2
[00012674] 41f9 0001 58a3            lea.l      $000158A3,a0
[0001267a] 4eb9 0001 0b0c            jsr        hc_createfile
[00012680] 7800                      moveq.l    #0,d4
[00012682] 3c39 0001 5072            move.w     screen_cnt,d6
[00012688] 48c6                      ext.l      d6
[0001268a] e58e                      lsl.l      #2,d6
[0001268c] 2e86                      move.l     d6,(a7)
[0001268e] 6000 0146                 bra        write_compression_1
write_compression_16:
[00012692] 2a32 4804                 move.l     4(a2,d4.l),d5
[00012696] 9ab2 4800                 sub.l      0(a2,d4.l),d5
[0001269a] 2079 0001 5b02            movea.l    hc_infile,a0
[000126a0] 2255                      movea.l    (a5),a1 ; hc_inbuf
[000126a2] 2005                      move.l     d5,d0
[000126a4] 4eb9 0001 0a94            jsr        hc_fread
[000126aa] b085                      cmp.l      d5,d0
[000126ac] 6710                      beq.s      write_compression_2
[000126ae] 4879 0001 5894            pea.l      $00015894
[000126b4] 7005                      moveq.l    #5,d0
[000126b6] 7200                      moveq.l    #0,d1
[000126b8] 4eb9 0001 0c4e            jsr        hclog
write_compression_2:
[000126be] 2c55                      movea.l    (a5),a6 ; hc_inbuf
[000126c0] da95                      add.l      (a5),d5 ; hc_inbuf
[000126c2] 6000 00e0                 bra        write_compression_3
write_compression_15:
[000126c6] 284e                      movea.l    a6,a4
[000126c8] 7eff                      moveq.l    #-1,d7
[000126ca] 7c00                      moveq.l    #0,d6
[000126cc] 7600                      moveq.l    #0,d3
[000126ce] 1c1c                      move.b     (a4)+,d6
[000126d0] 4446                      neg.w      d6
write_compression_10:
[000126d2] 161c                      move.b     (a4)+,d3
[000126d4] 3203                      move.w     d3,d1
[000126d6] ed49                      lsl.w      #6,d1
[000126d8] bd41                      eor.w      d6,d1
[000126da] 7000                      moveq.l    #0,d0
[000126dc] 3001                      move.w     d1,d0
[000126de] 223c 0000 4679            move.l     #$00004679,d1
[000126e4] 4eb9 0001 4594            jsr        _lmod
[000126ea] e788                      lsl.l      #3,d0
[000126ec] 6604                      bne.s      write_compression_4
[000126ee] 7208                      moveq.l    #8,d1
[000126f0] 6008                      bra.s      write_compression_5
write_compression_4:
[000126f2] 223c 0002 33c8            move.l     #$000233C8,d1
[000126f8] 9280                      sub.l      d0,d1
write_compression_5:
[000126fa] 0c73 ff00 0802            cmpi.w     #$FF00,2(a3,d0.l)
[00012700] 6718                      beq.s      write_compression_6
[00012702] bc73 0802                 cmp.w      2(a3,d0.l),d6
[00012706] 6606                      bne.s      write_compression_7
[00012708] b633 0806                 cmp.b      6(a3,d0.l),d3
[0001270c] 670c                      beq.s      write_compression_6
write_compression_7:
[0001270e] 9081                      sub.l      d1,d0
[00012710] 6ce8                      bge.s      write_compression_5
[00012712] d0bc 0002 33c8            add.l      #$000233C8,d0
[00012718] 60e0                      bra.s      write_compression_5
write_compression_6:
[0001271a] 3233 0804                 move.w     4(a3,d0.l),d1
[0001271e] 6b06                      bmi.s      write_compression_8
[00012720] 3e01                      move.w     d1,d7
[00012722] 2f40 0004                 move.l     d0,4(a7)
write_compression_8:
[00012726] 2c00                      move.l     d0,d6
[00012728] e68e                      lsr.l      #3,d6
[0001272a] 0c73 ffff 0804            cmpi.w     #$FFFF,4(a3,d0.l)
[00012730] 6d04                      blt.s      write_compression_9
[00012732] b9c5                      cmpa.l     d5,a4
[00012734] 659c                      bcs.s      write_compression_10
write_compression_9:
[00012736] 4a47                      tst.w      d7
[00012738] 6b2a                      bmi.s      write_compression_11
[0001273a] 7200                      moveq.l    #0,d1
[0001273c] 202f 0004                 move.l     4(a7),d0
[00012740] 3233 0800                 move.w     0(a3,d0.l),d1
[00012744] ddc1                      adda.l     d1,a6
[00012746] 700d                      moveq.l    #13,d0
[00012748] 6100 00ac                 bsr        write_nibble
[0001274c] 3007                      move.w     d7,d0
[0001274e] e048                      lsr.w      #8,d0
[00012750] 6100 00a4                 bsr        write_nibble
[00012754] 1007                      move.b     d7,d0
[00012756] e808                      lsr.b      #4,d0
[00012758] 6100 009c                 bsr        write_nibble
[0001275c] 1007                      move.b     d7,d0
[0001275e] c03c 000f                 and.b      #$0F,d0
[00012762] 603c                      bra.s      write_compression_12
write_compression_11:
[00012764] 0c16 000d                 cmpi.b     #$0D,(a6)
[00012768] 660e                      bne.s      write_compression_13
[0001276a] 0c2e 000a 0001            cmpi.b     #$0A,1(a6)
[00012770] 6606                      bne.s      write_compression_13
[00012772] 544e                      addq.w     #2,a6
[00012774] 700e                      moveq.l    #14,d0
[00012776] 6028                      bra.s      write_compression_12
write_compression_13:
[00012778] 700b                      moveq.l    #11,d0
[0001277a] 41f9 0001 62ce            lea.l      helphdr.char_table,a0
[00012780] 121e                      move.b     (a6)+,d1
write_compression_14:
[00012782] b230 0000                 cmp.b      0(a0,d0.w),d1
[00012786] 6718                      beq.s      write_compression_12
[00012788] 51c8 fff8                 dbf        d0,write_compression_14
[0001278c] 700c                      moveq.l    #12,d0
[0001278e] 6100 0066                 bsr.w      write_nibble
[00012792] 7000                      moveq.l    #0,d0
[00012794] 1001                      move.b     d1,d0
[00012796] e848                      lsr.w      #4,d0
[00012798] 6100 005c                 bsr.w      write_nibble
[0001279c] 700f                      moveq.l    #15,d0
[0001279e] c001                      and.b      d1,d0
write_compression_12:
[000127a0] 6100 0054                 bsr.w      write_nibble
write_compression_3:
[000127a4] bdc5                      cmpa.l     d5,a6
[000127a6] 6500 ff1e                 bcs        write_compression_15
[000127aa] 700f                      moveq.l    #15,d0
[000127ac] 6100 0048                 bsr.w      write_nibble
[000127b0] 6100 0070                 bsr.w      flush_nibble
[000127b4] 25b9 0001 5078 4800       move.l     screen_start,0(a2,d4.l)
[000127bc] 2239 0001 59be            move.l     screenbuf_ptr,d1
[000127c2] 92b9 0001 59b6            sub.l      screenbuf,d1
[000127c8] d3b9 0001 5078            add.l      d1,screen_start
[000127ce] 4eb9 0001 0a54            jsr        hc_flshbuf
[000127d4] 5884                      addq.l     #4,d4
write_compression_1:
[000127d6] b897                      cmp.l      (a7),d4
[000127d8] 6d00 feb8                 blt        write_compression_16
[000127dc] 25b9 0001 5078 4800       move.l     screen_start,0(a2,d4.l)
[000127e4] 4eb9 0001 0bac            jsr        hc_closeout
[000127ea] 504f                      addq.w     #8,a7
[000127ec] 4cdf 7cf8                 movem.l    (a7)+,d3-d7/a2-a6
[000127f0] 4e75                      rts

x127f2:
[000127f2] 0000                      dc.w       $0000
[000127f4] 0000                      dc.w       $0000

write_nibble:
[000127f6] 4a39 0001 27f4            tst.b      $000127F4
[000127fc] 6610                      bne.s      write_nibble_1
[000127fe] e908                      lsl.b      #4,d0
[00012800] 8139 0001 27f2            or.b       d0,$000127F2
[00012806] 50f9 0001 27f4            st         $000127F4
[0001280c] 4e75                      rts
write_nibble_1:
[0001280e] 803a ffe2                 or.b       $000127F2(pc),d0
[00012812] 4eb9 0001 08ea            jsr        hc_putc
[00012818] 7000                      moveq.l    #0,d0
[0001281a] 23c0 0001 27f2            move.l     d0,$000127F2
[00012820] 4e75                      rts

flush_nibble_2: ; not found: 0001280e
flush_nibble_1: ; not found: 00012820
flush_nibble:
[00012822] 4a39 0001 27f4            tst.b      $000127F4
[00012828] 67f6                      beq.s      $00012820
[0001282a] 7000                      moveq.l    #0,d0
[0001282c] 60e0                      bra.s      $0001280E

__fpuinit:
[0001282e] 41fa 0028                 lea.l      $00012858(pc),a0
[00012832] 7008                      moveq.l    #8,d0
[00012834] 2240                      movea.l    d0,a1
[00012836] 2011                      move.l     (a1),d0
[00012838] 2288                      move.l     a0,(a1)
[0001283a] 4279 0001 58be            clr.w      $000158BE
[00012840] 41d7                      lea.l      (a7),a0
[00012842] 31fc 0003 fa42            move.w     #$0003,($FFFFFA42).w
[00012848] 33fc 8000 0001 58be       move.w     #$8000,$000158BE
[00012850] 33fc ffff 0001 58c0       move.w     #$FFFF,$000158C0
[00012858] 4fd0                      lea.l      (a0),a7
[0001285a] 2280                      move.l     d0,(a1)
[0001285c] 4e75                      rts

_fpuinit:
[0001285e] 2f0a                      move.l     a2,-(a7)
[00012860] 487a ffcc                 pea.l      __fpuinit(pc)
[00012864] 3f3c 0026                 move.w     #$0026,-(a7) ; Supexec
[00012868] 4e4e                      trap       #14
[0001286a] 5c4f                      addq.w     #6,a7
[0001286c] 245f                      movea.l    (a7)+,a2
[0001286e] 4e75                      rts

swap:
[00012870] 1211                      move.b     (a1),d1
[00012872] 12d0                      move.b     (a0),(a1)+
[00012874] 10c1                      move.b     d1,(a0)+
[00012876] 5380                      subq.l     #1,d0
[00012878] 66f6                      bne.s      swap
[0001287a] 4e75                      rts

__qsort:
[0001287c] 48e7 1c3c                 movem.l    d3-d5/a2-a5,-(a7)
[00012880] 2648                      movea.l    a0,a3
[00012882] 2600                      move.l     d0,d3
[00012884] 2449                      movea.l    a1,a2
[00012886] 2801                      move.l     d1,d4
__qsort_17:
[00012888] 7002                      moveq.l    #2,d0
[0001288a] b083                      cmp.l      d3,d0
[0001288c] 6524                      bcs.s      __qsort_1
[0001288e] b083                      cmp.l      d3,d0
[00012890] 6600 0126                 bne        __qsort_2
[00012894] 49f3 4800                 lea.l      0(a3,d4.l),a4
[00012898] 224c                      movea.l    a4,a1
[0001289a] 204b                      movea.l    a3,a0
[0001289c] 4e92                      jsr        (a2)
[0001289e] 4a40                      tst.w      d0
[000128a0] 6f00 0116                 ble        __qsort_2
[000128a4] 2004                      move.l     d4,d0
[000128a6] 224c                      movea.l    a4,a1
[000128a8] 204b                      movea.l    a3,a0
[000128aa] 4eba ffc4                 jsr        swap(pc)
[000128ae] 6000 0108                 bra        __qsort_2
__qsort_1:
[000128b2] 70ff                      moveq.l    #-1,d0
[000128b4] d083                      add.l      d3,d0
[000128b6] 2204                      move.l     d4,d1
[000128b8] 4eba 1ba2                 jsr        _ulmul(pc)
[000128bc] 49f3 0800                 lea.l      0(a3,d0.l),a4
[000128c0] 2003                      move.l     d3,d0
[000128c2] e288                      lsr.l      #1,d0
[000128c4] 2204                      move.l     d4,d1
[000128c6] 4eba 1b94                 jsr        _ulmul(pc)
[000128ca] 4bf3 0800                 lea.l      0(a3,d0.l),a5
[000128ce] 224c                      movea.l    a4,a1
[000128d0] 204d                      movea.l    a5,a0
[000128d2] 4e92                      jsr        (a2)
[000128d4] 4a40                      tst.w      d0
[000128d6] 6f0a                      ble.s      __qsort_3
[000128d8] 2004                      move.l     d4,d0
[000128da] 224c                      movea.l    a4,a1
[000128dc] 204d                      movea.l    a5,a0
[000128de] 4eba ff90                 jsr        swap(pc)
__qsort_3:
[000128e2] 224b                      movea.l    a3,a1
[000128e4] 204d                      movea.l    a5,a0
[000128e6] 4e92                      jsr        (a2)
[000128e8] 4a40                      tst.w      d0
[000128ea] 6f0c                      ble.s      __qsort_4
[000128ec] 2004                      move.l     d4,d0
[000128ee] 224b                      movea.l    a3,a1
[000128f0] 204d                      movea.l    a5,a0
[000128f2] 4eba ff7c                 jsr        swap(pc)
[000128f6] 6014                      bra.s      __qsort_5
__qsort_4:
[000128f8] 224c                      movea.l    a4,a1
[000128fa] 204b                      movea.l    a3,a0
[000128fc] 4e92                      jsr        (a2)
[000128fe] 4a40                      tst.w      d0
[00012900] 6f0a                      ble.s      __qsort_5
[00012902] 2004                      move.l     d4,d0
[00012904] 224c                      movea.l    a4,a1
[00012906] 204b                      movea.l    a3,a0
[00012908] 4eba ff66                 jsr        swap(pc)
__qsort_5:
[0001290c] 7003                      moveq.l    #3,d0
[0001290e] b083                      cmp.l      d3,d0
[00012910] 660e                      bne.s      __qsort_6
[00012912] 224d                      movea.l    a5,a1
[00012914] 204b                      movea.l    a3,a0
[00012916] 2004                      move.l     d4,d0
[00012918] 4eba ff56                 jsr        swap(pc)
[0001291c] 6000 009a                 bra        __qsort_2
__qsort_6:
[00012920] 4bf3 4800                 lea.l      0(a3,d4.l),a5
[00012924] 6006                      bra.s      __qsort_7
__qsort_9:
[00012926] b9cd                      cmpa.l     a5,a4
[00012928] 6334                      bls.s      __qsort_8
[0001292a] dbc4                      adda.l     d4,a5
__qsort_7:
[0001292c] 224b                      movea.l    a3,a1
[0001292e] 204d                      movea.l    a5,a0
[00012930] 4e92                      jsr        (a2)
[00012932] 4a40                      tst.w      d0
[00012934] 6df0                      blt.s      __qsort_9
[00012936] 601e                      bra.s      __qsort_10
__qsort_13:
[00012938] 224c                      movea.l    a4,a1
[0001293a] 204b                      movea.l    a3,a0
[0001293c] 4e92                      jsr        (a2)
[0001293e] 4a40                      tst.w      d0
[00012940] 6e04                      bgt.s      __qsort_11
[00012942] 99c4                      suba.l     d4,a4
[00012944] 6010                      bra.s      __qsort_10
__qsort_11:
[00012946] 2004                      move.l     d4,d0
[00012948] 224c                      movea.l    a4,a1
[0001294a] 204d                      movea.l    a5,a0
[0001294c] 4eba ff22                 jsr        swap(pc)
[00012950] dbc4                      adda.l     d4,a5
[00012952] 99c4                      suba.l     d4,a4
[00012954] 6004                      bra.s      __qsort_12
__qsort_10:
[00012956] b9cd                      cmpa.l     a5,a4
[00012958] 62de                      bhi.s      __qsort_13
__qsort_12:
[0001295a] b9cd                      cmpa.l     a5,a4
[0001295c] 62ce                      bhi.s      __qsort_7
__qsort_8:
[0001295e] 224b                      movea.l    a3,a1
[00012960] 204d                      movea.l    a5,a0
[00012962] 4e92                      jsr        (a2)
[00012964] 4a40                      tst.w      d0
[00012966] 6c0a                      bge.s      __qsort_14
[00012968] 2004                      move.l     d4,d0
[0001296a] 224b                      movea.l    a3,a1
[0001296c] 204d                      movea.l    a5,a0
[0001296e] 4eba ff00                 jsr        swap(pc)
__qsort_14:
[00012972] 204d                      movea.l    a5,a0
[00012974] 91cb                      suba.l     a3,a0
[00012976] 7000                      moveq.l    #0,d0
[00012978] 3008                      move.w     a0,d0
[0001297a] 2204                      move.l     d4,d1
[0001297c] 4eba 1b06                 jsr        _uldiv(pc)
[00012980] 2a00                      move.l     d0,d5
[00012982] 9685                      sub.l      d5,d3
[00012984] ba83                      cmp.l      d3,d5
[00012986] 6318                      bls.s      __qsort_15
[00012988] 7201                      moveq.l    #1,d1
[0001298a] b283                      cmp.l      d3,d1
[0001298c] 640c                      bcc.s      __qsort_16
[0001298e] 224a                      movea.l    a2,a1
[00012990] 204d                      movea.l    a5,a0
[00012992] 2003                      move.l     d3,d0
[00012994] 2204                      move.l     d4,d1
[00012996] 4eba fee4                 jsr        __qsort(pc)
__qsort_16:
[0001299a] 2605                      move.l     d5,d3
[0001299c] 6000 feea                 bra        __qsort_17
__qsort_15:
[000129a0] 7001                      moveq.l    #1,d0
[000129a2] b085                      cmp.l      d5,d0
[000129a4] 640c                      bcc.s      __qsort_18
[000129a6] 2204                      move.l     d4,d1
[000129a8] 224a                      movea.l    a2,a1
[000129aa] 204b                      movea.l    a3,a0
[000129ac] 2005                      move.l     d5,d0
[000129ae] 4eba fecc                 jsr        __qsort(pc)
__qsort_18:
[000129b2] 264d                      movea.l    a5,a3
[000129b4] 6000 fed2                 bra        __qsort_17
__qsort_2:
[000129b8] 4cdf 3c38                 movem.l    (a7)+,d3-d5/a2-a5
[000129bc] 4e75                      rts

qsort:
[000129be] 4a81                      tst.l      d1
[000129c0] 6704                      beq.s      qsort_1
[000129c2] 4eba feb8                 jsr        __qsort(pc)
qsort_1:
[000129c6] 4e75                      rts

fprintf:
[000129c8] 2f0e                      move.l     a6,-(a7)
[000129ca] 514f                      subq.w     #8,a7
[000129cc] 4dd7                      lea.l      (a7),a6
[000129ce] 2d4f 0004                 move.l     a7,4(a6)
[000129d2] 2c88                      move.l     a0,(a6)
[000129d4] 2049                      movea.l    a1,a0
[000129d6] 43ef 0010                 lea.l      16(a7),a1
[000129da] 487a 000e                 pea.l      $000129EA(pc)
[000129de] 6100 008a                 bsr        _PrintF
[000129e2] 584f                      addq.w     #4,a7
[000129e4] 504f                      addq.w     #8,a7
[000129e6] 2c5f                      movea.l    (a7)+,a6
[000129e8] 4e75                      rts

x129ea_2: ; not found: 000129e4
[000129ea] 4840                      swap       d0
[000129ec] 4240                      clr.w      d0
[000129ee] 4840                      swap       d0
[000129f0] 2256                      movea.l    (a6),a1
[000129f2] 7201                      moveq.l    #1,d1
[000129f4] 6100 0638                 bsr        fwrite
[000129f8] 4a40                      tst.w      d0
[000129fa] 6b02                      bmi.s      x129ea_1
[000129fc] 4e75                      rts
x129ea_1:
[000129fe] 2e6e 0004                 movea.l    4(a6),a7
[00012a02] 70ff                      moveq.l    #-1,d0
[00012a04] 60de                      bra.s      $000129E4

sprintf:
[00012a06] 2f0e                      move.l     a6,-(a7)
[00012a08] 594f                      subq.w     #4,a7
[00012a0a] 4dd7                      lea.l      (a7),a6
[00012a0c] 2c88                      move.l     a0,(a6)
[00012a0e] 2049                      movea.l    a1,a0
[00012a10] 43ef 000c                 lea.l      12(a7),a1
[00012a14] 487a 0012                 pea.l      $00012A28(pc)
[00012a18] 6100 0050                 bsr.w      _PrintF
[00012a1c] 584f                      addq.w     #4,a7
[00012a1e] 2056                      movea.l    (a6),a0
[00012a20] 4210                      clr.b      (a0)
[00012a22] 584f                      addq.w     #4,a7
[00012a24] 2c5f                      movea.l    (a7)+,a6
[00012a26] 4e75                      rts

x12a28:
[00012a28] 2256                      movea.l    (a6),a1
[00012a2a] 5340                      subq.w     #1,d0
[00012a2c] 6508                      bcs.s      x12a28_1
x12a28_2:
[00012a2e] 12d8                      move.b     (a0)+,(a1)+
[00012a30] 51c8 fffc                 dbf        d0,x12a28_2
[00012a34] 2c89                      move.l     a1,(a6)
x12a28_1:
[00012a36] 4e75                      rts

vsprintf:
[00012a38] 2f0e                      move.l     a6,-(a7)
[00012a3a] 594f                      subq.w     #4,a7
[00012a3c] 4dd7                      lea.l      (a7),a6
[00012a3e] 2c88                      move.l     a0,(a6)
[00012a40] 2049                      movea.l    a1,a0
[00012a42] 226f 000c                 movea.l    12(a7),a1
[00012a46] 487a 0012                 pea.l      $00012A5A(pc)
[00012a4a] 6100 001e                 bsr.w      _PrintF
[00012a4e] 584f                      addq.w     #4,a7
[00012a50] 2056                      movea.l    (a6),a0
[00012a52] 4210                      clr.b      (a0)
[00012a54] 584f                      addq.w     #4,a7
[00012a56] 2c5f                      movea.l    (a7)+,a6
[00012a58] 4e75                      rts

x12a5a:
[00012a5a] 2256                      movea.l    (a6),a1
[00012a5c] 5340                      subq.w     #1,d0
[00012a5e] 6508                      bcs.s      x12a5a_1
x12a5a_2:
[00012a60] 12d8                      move.b     (a0)+,(a1)+
[00012a62] 51c8 fffc                 dbf        d0,x12a5a_2
[00012a66] 2c89                      move.l     a1,(a6)
x12a5a_1:
[00012a68] 4e75                      rts

_PrintF:
[00012a6a] 48e7 1e38                 movem.l    d3-d6/a2-a4,-(a7)
[00012a6e] 5d4f                      subq.w     #6,a7
[00012a70] 2448                      movea.l    a0,a2
[00012a72] 2649                      movea.l    a1,a3
[00012a74] 286f 0026                 movea.l    38(a7),a4
[00012a78] 4243                      clr.w      d3
[00012a7a] 7825                      moveq.l    #37,d4
_PrintF_26:
[00012a7c] 70ff                      moveq.l    #-1,d0
[00012a7e] 204a                      movea.l    a2,a0
_PrintF_2:
[00012a80] 5240                      addq.w     #1,d0
[00012a82] 1a1a                      move.b     (a2)+,d5
[00012a84] 6700 0232                 beq        _PrintF_1
[00012a88] ba04                      cmp.b      d4,d5
[00012a8a] 66f4                      bne.s      _PrintF_2
[00012a8c] 4a40                      tst.w      d0
[00012a8e] 6706                      beq.s      _PrintF_3
[00012a90] d640                      add.w      d0,d3
[00012a92] 48c0                      ext.l      d0
[00012a94] 4e94                      jsr        (a4)
_PrintF_3:
[00012a96] 4245                      clr.w      d5
_PrintF_6:
[00012a98] 101a                      move.b     (a2)+,d0
[00012a9a] 6700 023e                 beq        _PrintF_4
[00012a9e] 4241                      clr.w      d1
[00012aa0] 1200                      move.b     d0,d1
[00012aa2] 923c 0020                 sub.b      #$20,d1
[00012aa6] b23c 0010                 cmp.b      #$10,d1
[00012aaa] 621c                      bhi.s      _PrintF_5
[00012aac] 123b 1008                 move.b     $00012AB6(pc,d1.w),d1
[00012ab0] 6b16                      bmi.s      _PrintF_5
[00012ab2] 8a01                      or.b       d1,d5
[00012ab4] 60e2                      bra.s      _PrintF_6
[00012ab6] 01ff                      bset       d0,???
[00012ab8] ff02                      dc.w       $FF02 ; illegal
[00012aba] ffff ffff ffff ff04       vperm      #$FFFFFF04,e23,e23,e23
[00012ac2] ff08                      dc.w       $FF08 ; illegal
[00012ac4] ffff 1000 7cff b03c       vperm      #$7CFFB03C,e8,e9,e8
_PrintF_5:
[00012acc] 002a 6604 3c1b            ori.b      #$04,15387(a2)
[00012ad2] 6026                      bra.s      _PrintF_7
[00012ad4] 1200                      move.b     d0,d1
[00012ad6] 923c 0030                 sub.b      #$30,d1
[00012ada] b23c 0009                 cmp.b      #$09,d1
[00012ade] 6220                      bhi.s      _PrintF_8
[00012ae0] 41ea ffff                 lea.l      -1(a2),a0
[00012ae4] 43d7                      lea.l      (a7),a1
[00012ae6] 700a                      moveq.l    #10,d0
[00012ae8] 6100 0ff6                 bsr        strtoul
[00012aec] 2457                      movea.l    (a7),a2
[00012aee] b0bc 0000 7fff            cmp.l      #$00007FFF,d0
[00012af4] 6200 01e4                 bhi        _PrintF_4
[00012af8] 3c00                      move.w     d0,d6
_PrintF_7:
[00012afa] 101a                      move.b     (a2)+,d0
[00012afc] 6700 01dc                 beq        _PrintF_4
_PrintF_8:
[00012b00] 74ff                      moveq.l    #-1,d2
[00012b02] b03c 002e                 cmp.b      #$2E,d0
[00012b06] 6636                      bne.s      _PrintF_9
[00012b08] 101a                      move.b     (a2)+,d0
[00012b0a] b03c 002a                 cmp.b      #$2A,d0
[00012b0e] 6604                      bne.s      _PrintF_10
[00012b10] 341b                      move.w     (a3)+,d2
[00012b12] 6024                      bra.s      _PrintF_11
_PrintF_10:
[00012b14] 903c 0030                 sub.b      #$30,d0
[00012b18] b03c 0009                 cmp.b      #$09,d0
[00012b1c] 6220                      bhi.s      _PrintF_9
[00012b1e] 41ea ffff                 lea.l      -1(a2),a0
[00012b22] 43d7                      lea.l      (a7),a1
[00012b24] 700a                      moveq.l    #10,d0
[00012b26] 6100 0fb8                 bsr        strtoul
[00012b2a] 2457                      movea.l    (a7),a2
[00012b2c] b0bc 0000 7fff            cmp.l      #$00007FFF,d0
[00012b32] 6200 01a6                 bhi        _PrintF_4
[00012b36] 3400                      move.w     d0,d2
_PrintF_11:
[00012b38] 101a                      move.b     (a2)+,d0
[00012b3a] 6700 019e                 beq        _PrintF_4
_PrintF_9:
[00012b3e] 1200                      move.b     d0,d1
[00012b40] c23c 00df                 and.b      #$DF,d1
[00012b44] b23c 004c                 cmp.b      #$4C,d1
[00012b48] 660c                      bne.s      _PrintF_12
[00012b4a] 08c5 000f                 bset       #15,d5
_PrintF_14:
[00012b4e] 101a                      move.b     (a2)+,d0
[00012b50] 6700 0188                 beq        _PrintF_4
[00012b54] 6006                      bra.s      _PrintF_13
_PrintF_12:
[00012b56] b03c 0068                 cmp.b      #$68,d0
[00012b5a] 67f2                      beq.s      _PrintF_14
_PrintF_13:
[00012b5c] b004                      cmp.b      d4,d0
[00012b5e] 6700 00a2                 beq        _PrintF_15
[00012b62] 7240                      moveq.l    #64,d1
[00012b64] 9001                      sub.b      d1,d0
[00012b66] b001                      cmp.b      d1,d0
[00012b68] 6400 0170                 bcc        _PrintF_4
[00012b6c] c07c 003f                 and.w      #$003F,d0
[00012b70] d040                      add.w      d0,d0
[00012b72] 303b 0006                 move.w     $00012B7A(pc,d0.w),d0
[00012b76] 4efb 0002                 jmp        $00012B7A(pc,d0.w)
J4: ; not found: 00012b7a
[00012b7a] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b7c] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b7e] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b80] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b82] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b84] 014e                      dc.w $014e   ; _PrintF_16-J4
[00012b86] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b88] 014e                      dc.w $014e   ; _PrintF_16-J4
[00012b8a] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b8c] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b8e] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b90] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b92] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b94] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b96] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b98] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b9a] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b9c] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012b9e] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012ba0] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012ba2] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012ba4] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012ba6] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012ba8] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012baa] 00fa                      dc.w $00fa   ; _PrintF_17-J4
[00012bac] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bae] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bb0] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bb2] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bb4] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bb6] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bb8] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bba] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bbc] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bbe] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bc0] 0090                      dc.w $0090   ; _PrintF_18-J4
[00012bc2] 00da                      dc.w $00da   ; _PrintF_19-J4
[00012bc4] 014e                      dc.w $014e   ; _PrintF_16-J4
[00012bc6] 014e                      dc.w $014e   ; _PrintF_16-J4
[00012bc8] 014e                      dc.w $014e   ; _PrintF_16-J4
[00012bca] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bcc] 00da                      dc.w $00da   ; _PrintF_19-J4
[00012bce] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bd0] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bd2] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bd4] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bd6] 0080                      dc.w $0080   ; _PrintF_20-J4
[00012bd8] 011e                      dc.w $011e   ; _PrintF_21-J4
[00012bda] 0102                      dc.w $0102   ; _PrintF_22-J4
[00012bdc] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bde] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012be0] 00a8                      dc.w $00a8   ; _PrintF_23-J4
[00012be2] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012be4] 00ba                      dc.w $00ba   ; _PrintF_24-J4
[00012be6] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012be8] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bea] 00fe                      dc.w $00fe   ; _PrintF_25-J4
[00012bec] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bee] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bf0] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bf2] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bf4] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bf6] 0160                      dc.w $0160   ; _PrintF_4-J4
[00012bf8] 0160                      dc.w $0160   ; _PrintF_4-J4
_PrintF_20:
[00012bfa] 205b                      movea.l    (a3)+,a0
[00012bfc] 3083                      move.w     d3,(a0)
[00012bfe] 6000 fe7c                 bra        _PrintF_26
_PrintF_15:
[00012c02] 41ef 0004                 lea.l      4(a7),a0
[00012c06] 1084                      move.b     d4,(a0)
[00012c08] 6008                      bra.s      _PrintF_27
_PrintF_18:
[00012c0a] 301b                      move.w     (a3)+,d0
[00012c0c] 41ef 0004                 lea.l      4(a7),a0
[00012c10] 1080                      move.b     d0,(a0)
_PrintF_27:
[00012c12] 1005                      move.b     d5,d0
[00012c14] 3206                      move.w     d6,d1
[00012c16] 224c                      movea.l    a4,a1
[00012c18] 6100 024e                 bsr        _OutChr
[00012c1c] d640                      add.w      d0,d3
[00012c1e] 6000 fe5c                 bra        _PrintF_26
_PrintF_23:
[00012c22] 205b                      movea.l    (a3)+,a0
[00012c24] 1005                      move.b     d5,d0
[00012c26] 3206                      move.w     d6,d1
[00012c28] 224c                      movea.l    a4,a1
[00012c2a] 6100 024c                 bsr        _OutStr
[00012c2e] d640                      add.w      d0,d3
[00012c30] 6000 fe4a                 bra        _PrintF_26
_PrintF_24:
[00012c34] 4a45                      tst.w      d5
[00012c36] 6a04                      bpl.s      _PrintF_28
[00012c38] 201b                      move.l     (a3)+,d0
[00012c3a] 6004                      bra.s      _PrintF_29
_PrintF_28:
[00012c3c] 7000                      moveq.l    #0,d0
[00012c3e] 301b                      move.w     (a3)+,d0
_PrintF_29:
[00012c40] 3f02                      move.w     d2,-(a7)
[00012c42] 1205                      move.b     d5,d1
[00012c44] 3406                      move.w     d6,d2
[00012c46] 204c                      movea.l    a4,a0
[00012c48] 6100 0122                 bsr        _OutCarD
[00012c4c] 544f                      addq.w     #2,a7
[00012c4e] d640                      add.w      d0,d3
[00012c50] 6000 fe2a                 bra        _PrintF_26
_PrintF_19:
[00012c54] 4a45                      tst.w      d5
[00012c56] 6a04                      bpl.s      _PrintF_30
[00012c58] 201b                      move.l     (a3)+,d0
[00012c5a] 6004                      bra.s      _PrintF_31
_PrintF_30:
[00012c5c] 301b                      move.w     (a3)+,d0
[00012c5e] 48c0                      ext.l      d0
_PrintF_31:
[00012c60] 3f02                      move.w     d2,-(a7)
[00012c62] 1205                      move.b     d5,d1
[00012c64] 3406                      move.w     d6,d2
[00012c66] 204c                      movea.l    a4,a0
[00012c68] 6100 00b0                 bsr        _OutIntD
[00012c6c] 544f                      addq.w     #2,a7
[00012c6e] d640                      add.w      d0,d3
[00012c70] 6000 fe0a                 bra        _PrintF_26
_PrintF_17:
[00012c74] 08c5 0005                 bset       #5,d5
_PrintF_25:
[00012c78] 4a45                      tst.w      d5
[00012c7a] 6a04                      bpl.s      _PrintF_32
_PrintF_22:
[00012c7c] 201b                      move.l     (a3)+,d0
[00012c7e] 6004                      bra.s      _PrintF_33
_PrintF_32:
[00012c80] 7000                      moveq.l    #0,d0
[00012c82] 301b                      move.w     (a3)+,d0
_PrintF_33:
[00012c84] 3f02                      move.w     d2,-(a7)
[00012c86] 1205                      move.b     d5,d1
[00012c88] 3406                      move.w     d6,d2
[00012c8a] 204c                      movea.l    a4,a0
[00012c8c] 6100 00f0                 bsr        _OutCarH
[00012c90] 544f                      addq.w     #2,a7
[00012c92] d640                      add.w      d0,d3
[00012c94] 6000 fde6                 bra        _PrintF_26
_PrintF_21:
[00012c98] 4a45                      tst.w      d5
[00012c9a] 6a04                      bpl.s      _PrintF_34
[00012c9c] 201b                      move.l     (a3)+,d0
[00012c9e] 6004                      bra.s      _PrintF_35
_PrintF_34:
[00012ca0] 7000                      moveq.l    #0,d0
[00012ca2] 301b                      move.w     (a3)+,d0
_PrintF_35:
[00012ca4] 3f02                      move.w     d2,-(a7)
[00012ca6] 1205                      move.b     d5,d1
[00012ca8] 3406                      move.w     d6,d2
[00012caa] 204c                      movea.l    a4,a0
[00012cac] 6100 0110                 bsr        _OutCarO
[00012cb0] 544f                      addq.w     #2,a7
[00012cb2] d640                      add.w      d0,d3
[00012cb4] 6000 fdc6                 bra        _PrintF_26
_PrintF_1:
[00012cb8] d640                      add.w      d0,d3
[00012cba] 48c0                      ext.l      d0
[00012cbc] 4e94                      jsr        (a4)
[00012cbe] 3003                      move.w     d3,d0
_PrintF_36:
[00012cc0] 5c4f                      addq.w     #6,a7
[00012cc2] 4cdf 1c78                 movem.l    (a7)+,d3-d6/a2-a4
[00012cc6] 4e75                      rts
_PrintF_16:
[00012cc8] 7000                      moveq.l    #0,d0
[00012cca] 3200                      move.w     d0,d1
[00012ccc] 343c ffff                 move.w     #$FFFF,d2
[00012cd0] 41fa 000c                 lea.l      $00012CDE(pc),a0
[00012cd4] 224c                      movea.l    a4,a1
[00012cd6] 6100 01a0                 bsr        _OutStr
_PrintF_4:
[00012cda] 70ff                      moveq.l    #-1,d0
[00012cdc] 60e2                      bra.s      _PrintF_36
[00012cde] 0d0a 5761                 movep.w    22369(a2),d6
[00012ce2] 726e                      moveq.l    #110,d1
[00012ce4] 696e                      bvs.s      _PrintF_37
[00012ce6] 673a                      beq.s      _PrintF_38
[00012ce8] 2075 7365 2054            movea.l    ([$2054,a5],zd7.w*2),a0 ; 68020+ only; reserved OD=1
[00012cee] 4346                      lea.l      d6,b1 ; apollo only
[00012cf0] 4c54 4c49                 divs.l     (a4),a1:d4 ; apollo only
[00012cf4] 4220                      clr.b      -(a0)
[00012cf6] 746f                      moveq.l    #111,d2
[00012cf8] 2067                      movea.l    -(a7),a0
[00012cfa] 6574                      bcs.s      _PrintF_39
[00012cfc] 2066                      movea.l    -(a6),a0
[00012cfe] 6c6f                      bge.s      _PrintF_40 ; ; branch to odd address
[00012d00] 6174                      bsr.s      $00012D76
[00012d02] 2073 7570 706f 7274       movea.l    ($706F7274,a3,zd7.w*4),a0 ; 68020+ only
[00012d0a] 2066                      movea.l    -(a6),a0
[00012d0c] 6f72                      ble.s      _PrintF_41
[00012d0e] 2070 7269                 movea.l    105(a0,d7.w*2),a0 ; 68020+ only
[00012d12] 6e74                      bgt.s      _PrintF_42
[00012d14] 662e                      bne.s      _PrintF_43
[00012d16] 0d0a 0000                 movep.w    0(a2),d6
_PrintF_38: ; not found: 00012d22
_PrintF_43: ; not found: 00012d44
_PrintF_37: ; not found: 00012d54
_PrintF_40: ; not found: 00012d6f
_PrintF_39: ; not found: 00012d70
_PrintF_41: ; not found: 00012d80
_PrintF_42: ; not found: 00012d88

_OutIntD:
[00012d1a] 48e7 1820                 movem.l    d3-d4/a2,-(a7)
[00012d1e] 4fef ffe8                 lea.l      -24(a7),a7
[00012d22] 760a                      moveq.l    #10,d3
[00012d24] 4a80                      tst.l      d0
[00012d26] 6a12                      bpl.s      _OutIntD_1
[00012d28] 1f7c 002d 0006            move.b     #$2D,6(a7)
[00012d2e] 3f7c 0001 0008            move.w     #$0001,8(a7)
[00012d34] 4480                      neg.l      d0
[00012d36] 6000 00aa                 bra        _OutIntD_2
_OutIntD_1:
[00012d3a] 0801 0002                 btst       #2,d1
[00012d3e] 6710                      beq.s      _OutIntD_3
[00012d40] 1f7c 002b 0006            move.b     #$2B,6(a7)
[00012d46] 3f7c 0001 0008            move.w     #$0001,8(a7)
[00012d4c] 6000 0094                 bra        _OutIntD_2
_OutIntD_3:
[00012d50] 0801 0000                 btst       #0,d1
[00012d54] 670e                      beq.s      _OutIntD_4
[00012d56] 1f7c 0020 0006            move.b     #$20,6(a7)
[00012d5c] 3f7c 0001 0008            move.w     #$0001,8(a7)
[00012d62] 607e                      bra.s      _OutIntD_2
_OutIntD_4:
[00012d64] 3f7c 0000 0008            move.w     #$0000,8(a7)
[00012d6a] 6076                      bra.s      _OutIntD_2
_OutIntD_2: ; not found: 00012de2

_OutCarD:
[00012d6c] 48e7 1820                 movem.l    d3-d4/a2,-(a7)
[00012d70] 4fef ffe8                 lea.l      -24(a7),a7
[00012d74] 760a                      moveq.l    #10,d3
[00012d76] 3f7c 0000 0008            move.w     #$0000,8(a7)
[00012d7c] 6064                      bra.s      _OutCarD_1
_OutCarD_1: ; not found: 00012de2

_OutCarH:
[00012d7e] 48e7 1820                 movem.l    d3-d4/a2,-(a7)
[00012d82] 4fef ffe8                 lea.l      -24(a7),a7
[00012d86] 7610                      moveq.l    #16,d3
[00012d88] 0801 0001                 btst       #1,d1
[00012d8c] 6608                      bne.s      _OutCarH_1
[00012d8e] 3f7c 0000 0008            move.w     #$0000,8(a7)
[00012d94] 604c                      bra.s      _OutCarH_2
_OutCarH_1:
[00012d96] 1f7c 0030 0006            move.b     #$30,6(a7)
[00012d9c] 0801 0005                 btst       #5,d1
[00012da0] 660e                      bne.s      _OutCarH_3
[00012da2] 1f7c 0078 0007            move.b     #$78,7(a7)
[00012da8] 3f7c 0002 0008            move.w     #$0002,8(a7)
[00012dae] 6032                      bra.s      _OutCarH_2
_OutCarH_3:
[00012db0] 1f7c 0058 0007            move.b     #$58,7(a7)
[00012db6] 3f7c 0002 0008            move.w     #$0002,8(a7)
[00012dbc] 6024                      bra.s      _OutCarH_2
_OutCarH_2: ; not found: 00012de2

_OutCarO:
[00012dbe] 48e7 1820                 movem.l    d3-d4/a2,-(a7)
[00012dc2] 4fef ffe8                 lea.l      -24(a7),a7
[00012dc6] 7608                      moveq.l    #8,d3
[00012dc8] 0801 0001                 btst       #1,d1
[00012dcc] 6608                      bne.s      _OutCarO_1
[00012dce] 3f7c 0000 0008            move.w     #$0000,8(a7)
[00012dd4] 600c                      bra.s      _OutCarO_2
_OutCarO_1:
[00012dd6] 1f7c 0030 0006            move.b     #$30,6(a7)
[00012ddc] 3f7c 0001 0008            move.w     #$0001,8(a7)
_OutCarO_2:
[00012de2] 2448                      movea.l    a0,a2
[00012de4] 3e81                      move.w     d1,(a7)
[00012de6] c343                      exg        d1,d3
[00012de8] 3802                      move.w     d2,d4
[00012dea] 6a02                      bpl.s      _OutCarO_3
[00012dec] 7800                      moveq.l    #0,d4
_OutCarO_3:
[00012dee] 41ef 000a                 lea.l      10(a7),a0
[00012df2] 6100 0dd2                 bsr        ultoa
[00012df6] 41ef 000a                 lea.l      10(a7),a0
[00012dfa] 70ff                      moveq.l    #-1,d0
_OutCarO_4:
[00012dfc] 4a18                      tst.b      (a0)+
[00012dfe] 57c8 fffc                 dbeq       d0,_OutCarO_4
[00012e02] 4640                      not.w      d0
[00012e04] 3f40 0016                 move.w     d0,22(a7)
[00012e08] 0803 0005                 btst       #5,d3
[00012e0c] 671e                      beq.s      _OutCarO_5
[00012e0e] 41ef 000a                 lea.l      10(a7),a0
[00012e12] 3200                      move.w     d0,d1
[00012e14] 5341                      subq.w     #1,d1
[00012e16] 6b14                      bmi.s      _OutCarO_5
[00012e18] 7461                      moveq.l    #97,d2
_OutCarO_6:
[00012e1a] b418                      cmp.b      (a0)+,d2
[00012e1c] 53c9 fffc                 dbls       d1,_OutCarO_6
[00012e20] 620a                      bhi.s      _OutCarO_5
[00012e22] 0228 00df ffff            andi.b     #$DF,-1(a0)
[00012e28] 51c9 fff0                 dbf        d1,_OutCarO_6
_OutCarO_5:
[00012e2c] 322f 0008                 move.w     8(a7),d1
[00012e30] d240                      add.w      d0,d1
[00012e32] 342f 0028                 move.w     40(a7),d2
[00012e36] 6a02                      bpl.s      _OutCarO_7
[00012e38] 7401                      moveq.l    #1,d2
_OutCarO_7:
[00012e3a] 9440                      sub.w      d0,d2
[00012e3c] 6a02                      bpl.s      _OutCarO_8
[00012e3e] 7400                      moveq.l    #0,d2
_OutCarO_8:
[00012e40] d242                      add.w      d2,d1
[00012e42] 0803 0004                 btst       #4,d3
[00012e46] 6710                      beq.s      _OutCarO_9
[00012e48] 0803 0003                 btst       #3,d3
[00012e4c] 660a                      bne.s      _OutCarO_9
[00012e4e] 3004                      move.w     d4,d0
[00012e50] 9041                      sub.w      d1,d0
[00012e52] 6f08                      ble.s      _OutCarO_10
[00012e54] d240                      add.w      d0,d1
[00012e56] d440                      add.w      d0,d2
_OutCarO_9:
[00012e58] 9841                      sub.w      d1,d4
[00012e5a] 6c02                      bge.s      _OutCarO_11
_OutCarO_10:
[00012e5c] 7800                      moveq.l    #0,d4
_OutCarO_11:
[00012e5e] 3f42 0004                 move.w     d2,4(a7)
[00012e62] 3f44 0002                 move.w     d4,2(a7)
[00012e66] 6068                      bra.s      _OutCarO_12
_OutCarO_12: ; not found: 00012ed0

_OutChr:
[00012e68] 48e7 1830                 movem.l    d3-d4/a2-a3,-(a7)
[00012e6c] 2448                      movea.l    a0,a2
[00012e6e] 2649                      movea.l    a1,a3
[00012e70] 4228 0001                 clr.b      1(a0)
[00012e74] 7601                      moveq.l    #1,d3
[00012e76] 6012                      bra.s      _OutChr_1
_OutChr_1: ; not found: 00012e8a

_OutStr:
[00012e78] 48e7 1830                 movem.l    d3-d4/a2-a3,-(a7)
[00012e7c] 2448                      movea.l    a0,a2
[00012e7e] 2649                      movea.l    a1,a3
[00012e80] 76ff                      moveq.l    #-1,d3
_OutStr_1:
[00012e82] 4a18                      tst.b      (a0)+
[00012e84] 57cb fffc                 dbeq       d3,_OutStr_1
[00012e88] 4643                      not.w      d3
[00012e8a] 4a42                      tst.w      d2
[00012e8c] 6a02                      bpl.s      _OutStr_2
[00012e8e] 3403                      move.w     d3,d2
_OutStr_2:
[00012e90] b443                      cmp.w      d3,d2
[00012e92] 6202                      bhi.s      _OutStr_3
[00012e94] 3602                      move.w     d2,d3
_OutStr_3:
[00012e96] 7800                      moveq.l    #0,d4
[00012e98] 4a41                      tst.w      d1
[00012e9a] 6b08                      bmi.s      _OutStr_4
[00012e9c] b243                      cmp.w      d3,d1
[00012e9e] 6304                      bls.s      _OutStr_4
[00012ea0] 3801                      move.w     d1,d4
[00012ea2] 9843                      sub.w      d3,d4
_OutStr_4:
[00012ea4] 0800 0003                 btst       #3,d0
[00012ea8] 6610                      bne.s      _OutStr_5
[00012eaa] 204b                      movea.l    a3,a0
[00012eac] 3004                      move.w     d4,d0
[00012eae] 6100 0086                 bsr        OutBlank
[00012eb2] 3003                      move.w     d3,d0
[00012eb4] 204a                      movea.l    a2,a0
[00012eb6] 4e93                      jsr        (a3)
[00012eb8] 600c                      bra.s      _OutStr_6
_OutStr_5:
[00012eba] 3003                      move.w     d3,d0
[00012ebc] 204a                      movea.l    a2,a0
[00012ebe] 4e93                      jsr        (a3)
[00012ec0] 3004                      move.w     d4,d0
[00012ec2] 204b                      movea.l    a3,a0
[00012ec4] 6170                      bsr.s      OutBlank
_OutStr_6:
[00012ec6] 3003                      move.w     d3,d0
[00012ec8] d044                      add.w      d4,d0
[00012eca] 4cdf 0c18                 movem.l    (a7)+,d3-d4/a2-a3
[00012ece] 4e75                      rts

x12ed0:
[00012ed0] 3617                      move.w     (a7),d3
[00012ed2] 7800                      moveq.l    #0,d4
[00012ed4] 302f 0002                 move.w     2(a7),d0
[00012ed8] 670c                      beq.s      x12ed0_1
[00012eda] 0803 0003                 btst       #3,d3
[00012ede] 6606                      bne.s      x12ed0_1
[00012ee0] d840                      add.w      d0,d4
[00012ee2] 204a                      movea.l    a2,a0
[00012ee4] 6150                      bsr.s      OutBlank
x12ed0_1:
[00012ee6] 302f 0008                 move.w     8(a7),d0
[00012eea] 6708                      beq.s      x12ed0_2
[00012eec] d840                      add.w      d0,d4
[00012eee] 41ef 0006                 lea.l      6(a7),a0
[00012ef2] 4e92                      jsr        (a2)
x12ed0_2:
[00012ef4] 302f 0004                 move.w     4(a7),d0
[00012ef8] 6706                      beq.s      x12ed0_3
[00012efa] d840                      add.w      d0,d4
[00012efc] 204a                      movea.l    a2,a0
[00012efe] 612c                      bsr.s      OutZero
x12ed0_3:
[00012f00] 302f 0016                 move.w     22(a7),d0
[00012f04] 6708                      beq.s      x12ed0_4
[00012f06] d840                      add.w      d0,d4
[00012f08] 41ef 000a                 lea.l      10(a7),a0
[00012f0c] 4e92                      jsr        (a2)
x12ed0_4:
[00012f0e] 302f 0002                 move.w     2(a7),d0
[00012f12] 670c                      beq.s      x12ed0_5
[00012f14] 0803 0003                 btst       #3,d3
[00012f18] 6706                      beq.s      x12ed0_5
[00012f1a] d840                      add.w      d0,d4
[00012f1c] 204a                      movea.l    a2,a0
[00012f1e] 6116                      bsr.s      OutBlank
x12ed0_5:
[00012f20] 3004                      move.w     d4,d0
[00012f22] 4fef 0018                 lea.l      24(a7),a7
[00012f26] 4cdf 0418                 movem.l    (a7)+,d3-d4/a2
[00012f2a] 4e75                      rts

OutZero:
[00012f2c] 48e7 1830                 movem.l    d3-d4/a2-a3,-(a7)
[00012f30] 45fa 0036                 lea.l      $00012F68(pc),a2
[00012f34] 6008                      bra.s      OutZero_1
OutZero_1: ; not found: 00012f3e

OutBlank:
[00012f36] 48e7 1830                 movem.l    d3-d4/a2-a3,-(a7)
[00012f3a] 45fa 0034                 lea.l      $00012F70(pc),a2
[00012f3e] 2648                      movea.l    a0,a3
[00012f40] 3600                      move.w     d0,d3
[00012f42] 671e                      beq.s      OutBlank_1
[00012f44] 3800                      move.w     d0,d4
[00012f46] e64b                      lsr.w      #3,d3
[00012f48] 670c                      beq.s      OutBlank_2
[00012f4a] 5343                      subq.w     #1,d3
OutBlank_3:
[00012f4c] 204a                      movea.l    a2,a0
[00012f4e] 7008                      moveq.l    #8,d0
[00012f50] 4e93                      jsr        (a3)
[00012f52] 51cb fff8                 dbf        d3,OutBlank_3
OutBlank_2:
[00012f56] 204a                      movea.l    a2,a0
[00012f58] 3004                      move.w     d4,d0
[00012f5a] c07c 0007                 and.w      #$0007,d0
[00012f5e] 6702                      beq.s      OutBlank_1
[00012f60] 4e93                      jsr        (a3)
OutBlank_1:
[00012f62] 4cdf 0c18                 movem.l    (a7)+,d3-d4/a2-a3
[00012f66] 4e75                      rts

x12f68:
[00012f68] 3030 3030                 move.w     48(a0,d3.w),d0
[00012f6c] 3030 3030                 move.w     48(a0,d3.w),d0
[00012f70] 2020                      move.l     -(a0),d0
[00012f72] 2020                      move.l     -(a0),d0
[00012f74] 2020                      move.l     -(a0),d0
[00012f76] 2020                      move.l     -(a0),d0

feof:
[00012f78] 0828 0004 0012            btst       #4,18(a0)
[00012f7e] 56c0                      sne        d0
[00012f80] 4880                      ext.w      d0
[00012f82] 4e75                      rts

ferror:
[00012f84] 0828 0005 0012            btst       #5,18(a0)
[00012f8a] 56c0                      sne        d0
[00012f8c] 4880                      ext.w      d0
[00012f8e] 4e75                      rts

fgets:
[00012f90] 48e7 0038                 movem.l    a2-a4,-(a7)
[00012f94] 2448                      movea.l    a0,a2
[00012f96] 2649                      movea.l    a1,a3
[00012f98] 082b 0000 0012            btst       #0,18(a3)
[00012f9e] 677c                      beq.s      fgets_1
[00012fa0] 3200                      move.w     d0,d1
[00012fa2] 6700 0086                 beq        fgets_2
[00012fa6] 082b 0002 0012            btst       #2,18(a3)
[00012fac] 6714                      beq.s      fgets_3
[00012fae] 43eb 0014                 lea.l      20(a3),a1
[00012fb2] 2749 0008                 move.l     a1,8(a3)
[00012fb6] 2689                      move.l     a1,(a3)
[00012fb8] 2749 0004                 move.l     a1,4(a3)
[00012fbc] 5289                      addq.l     #1,a1
[00012fbe] 2749 000c                 move.l     a1,12(a3)
fgets_3:
[00012fc2] 5541                      subq.w     #2,d1
[00012fc4] 6518                      bcs.s      fgets_4
fgets_9:
[00012fc6] 2253                      movea.l    (a3),a1
[00012fc8] 286b 0004                 movea.l    4(a3),a4
[00012fcc] 740a                      moveq.l    #10,d2
fgets_5:
[00012fce] b3cc                      cmpa.l     a4,a1
[00012fd0] 640c                      bcc.s      fgets_4
[00012fd2] 1019                      move.b     (a1)+,d0
[00012fd4] 10c0                      move.b     d0,(a0)+
[00012fd6] b002                      cmp.b      d2,d0
[00012fd8] 57c9 fff4                 dbeq       d1,fgets_5
[00012fdc] 6032                      bra.s      fgets_6
fgets_4:
[00012fde] 082b 0006 0012            btst       #6,18(a3)
[00012fe4] 6712                      beq.s      fgets_7
[00012fe6] 48e7 40c0                 movem.l    d1/a0-a1,-(a7)
[00012fea] 204b                      movea.l    a3,a0
[00012fec] 6100 0510                 bsr        _FlshBuf
[00012ff0] 4cdf 0302                 movem.l    (a7)+,d1/a0-a1
[00012ff4] 4a40                      tst.w      d0
[00012ff6] 662c                      bne.s      fgets_8
fgets_7:
[00012ff8] 48e7 40c0                 movem.l    d1/a0-a1,-(a7)
[00012ffc] 204b                      movea.l    a3,a0
[00012ffe] 6100 048a                 bsr        _FillBuf
[00013002] 4cdf 0302                 movem.l    (a7)+,d1/a0-a1
[00013006] 4a40                      tst.w      d0
[00013008] 67bc                      beq.s      fgets_9
[0001300a] 6b18                      bmi.s      fgets_8
[0001300c] b5c8                      cmpa.l     a0,a2
[0001300e] 671a                      beq.s      fgets_2
fgets_6:
[00013010] 2689                      move.l     a1,(a3)
[00013012] 4218                      clr.b      (a0)+
[00013014] 204a                      movea.l    a2,a0
fgets_10:
[00013016] 4cdf 1c00                 movem.l    (a7)+,a2-a4
[0001301a] 4e75                      rts
fgets_1:
[0001301c] 33fc 000d 0001 4658       move.w     #$000D,errno
fgets_8:
[00013024] 08eb 0005 0012            bset       #5,18(a3)
fgets_2:
[0001302a] 91c8                      suba.l     a0,a0
[0001302c] 60e8                      bra.s      fgets_10

fwrite:
[0001302e] 48e7 183a                 movem.l    d3-d4/a2-a4/a6,-(a7)
[00013032] 2448                      movea.l    a0,a2
[00013034] 2649                      movea.l    a1,a3
[00013036] 2853                      movea.l    (a3),a4
[00013038] 2600                      move.l     d0,d3
[0001303a] 6766                      beq.s      fwrite_1
[0001303c] 4a81                      tst.l      d1
[0001303e] 675e                      beq.s      fwrite_2
[00013040] 082b 0001 0012            btst       #1,18(a3)
[00013046] 6760                      beq.s      fwrite_3
[00013048] 0829 0002 0012            btst       #2,18(a1)
[0001304e] 6674                      bne.s      fwrite_4
[00013050] 08eb 0006 0012            bset       #6,18(a3)
[00013056] 2c6b 000c                 movea.l    12(a3),a6
[0001305a] 7800                      moveq.l    #0,d4
fwrite_7:
[0001305c] 2403                      move.l     d3,d2
fwrite_6:
[0001305e] 18da                      move.b     (a2)+,(a4)+
[00013060] b9ce                      cmpa.l     a6,a4
[00013062] 640c                      bcc.s      fwrite_5
[00013064] 5382                      subq.l     #1,d2
[00013066] 66f6                      bne.s      fwrite_6
[00013068] 5284                      addq.l     #1,d4
[0001306a] b881                      cmp.l      d1,d4
[0001306c] 65ee                      bcs.s      fwrite_7
[0001306e] 602e                      bra.s      fwrite_2
fwrite_5:
[00013070] 268c                      move.l     a4,(a3)
[00013072] 2f01                      move.l     d1,-(a7)
[00013074] 2f02                      move.l     d2,-(a7)
[00013076] 204b                      movea.l    a3,a0
[00013078] 6100 0484                 bsr        _FlshBuf
[0001307c] 241f                      move.l     (a7)+,d2
[0001307e] 221f                      move.l     (a7)+,d1
[00013080] 4a40                      tst.w      d0
[00013082] 6b2c                      bmi.s      fwrite_8
[00013084] 6634                      bne.s      fwrite_9
[00013086] 2853                      movea.l    (a3),a4
[00013088] 08eb 0006 0012            bset       #6,18(a3)
[0001308e] 5382                      subq.l     #1,d2
[00013090] 66cc                      bne.s      fwrite_6
[00013092] 5284                      addq.l     #1,d4
[00013094] b881                      cmp.l      d1,d4
[00013096] 66c4                      bne.s      fwrite_7
[00013098] 08ab 0006 0012            bclr       #6,18(a3)
fwrite_2:
[0001309e] 268c                      move.l     a4,(a3)
[000130a0] 2001                      move.l     d1,d0
fwrite_1:
[000130a2] 4cdf 5c18                 movem.l    (a7)+,d3-d4/a2-a4/a6
[000130a6] 4e75                      rts
fwrite_3:
[000130a8] 33fc 000d 0001 4658       move.w     #$000D,errno
fwrite_8:
[000130b0] 08eb 0005 0012            bset       #5,18(a3)
[000130b6] 70ff                      moveq.l    #-1,d0
[000130b8] 60e8                      bra.s      fwrite_1
fwrite_9:
[000130ba] 08eb 0005 0012            bset       #5,18(a3)
[000130c0] 2204                      move.l     d4,d1
[000130c2] 60da                      bra.s      fwrite_2
fwrite_4:
[000130c4] 2600                      move.l     d0,d3
[000130c6] 7800                      moveq.l    #0,d4
[000130c8] 2c41                      movea.l    d1,a6
fwrite_10:
[000130ca] 274a 0008                 move.l     a2,8(a3)
[000130ce] 274a 0004                 move.l     a2,4(a3)
[000130d2] 45f2 3800                 lea.l      0(a2,d3.l),a2
[000130d6] 274a 000c                 move.l     a2,12(a3)
[000130da] 268a                      move.l     a2,(a3)
[000130dc] 08eb 0006 0012            bset       #6,18(a3)
[000130e2] 204b                      movea.l    a3,a0
[000130e4] 6100 0418                 bsr        _FlshBuf
[000130e8] 4a40                      tst.w      d0
[000130ea] 6bc4                      bmi.s      fwrite_8
[000130ec] 66cc                      bne.s      fwrite_9
[000130ee] 5284                      addq.l     #1,d4
[000130f0] b88e                      cmp.l      a6,d4
[000130f2] 66d6                      bne.s      fwrite_10
[000130f4] 220e                      move.l     a6,d1
[000130f6] 60a6                      bra.s      fwrite_2

fread:
[000130f8] 48e7 183a                 movem.l    d3-d4/a2-a4/a6,-(a7)
[000130fc] 2448                      movea.l    a0,a2
[000130fe] 2649                      movea.l    a1,a3
[00013100] 2853                      movea.l    (a3),a4
[00013102] 7800                      moveq.l    #0,d4
[00013104] 2600                      move.l     d0,d3
[00013106] 675a                      beq.s      fread_1
[00013108] 4a81                      tst.l      d1
[0001310a] 6756                      beq.s      fread_1
[0001310c] 082b 0000 0012            btst       #0,18(a3)
[00013112] 6758                      beq.s      fread_2
[00013114] 2c6b 0004                 movea.l    4(a3),a6
fread_5:
[00013118] 2403                      move.l     d3,d2
fread_4:
[0001311a] b9ce                      cmpa.l     a6,a4
[0001311c] 640e                      bcc.s      fread_3
fread_8:
[0001311e] 14dc                      move.b     (a4)+,(a2)+
[00013120] 5382                      subq.l     #1,d2
[00013122] 66f6                      bne.s      fread_4
[00013124] 5284                      addq.l     #1,d4
[00013126] b881                      cmp.l      d1,d4
[00013128] 65ee                      bcs.s      fread_5
[0001312a] 6036                      bra.s      fread_1
fread_3:
[0001312c] 082b 0006 0012            btst       #6,18(a3)
[00013132] 6712                      beq.s      fread_6
[00013134] 2f01                      move.l     d1,-(a7)
[00013136] 2f02                      move.l     d2,-(a7)
[00013138] 204b                      movea.l    a3,a0
[0001313a] 6100 03c2                 bsr        _FlshBuf
[0001313e] 241f                      move.l     (a7)+,d2
[00013140] 221f                      move.l     (a7)+,d1
[00013142] 4a40                      tst.w      d0
[00013144] 662e                      bne.s      fread_7
fread_6:
[00013146] 2f01                      move.l     d1,-(a7)
[00013148] 2f02                      move.l     d2,-(a7)
[0001314a] 204b                      movea.l    a3,a0
[0001314c] 6100 033c                 bsr        _FillBuf
[00013150] 241f                      move.l     (a7)+,d2
[00013152] 221f                      move.l     (a7)+,d1
[00013154] 4a40                      tst.w      d0
[00013156] 6b1c                      bmi.s      fread_7
[00013158] 6608                      bne.s      fread_1
[0001315a] 2853                      movea.l    (a3),a4
[0001315c] 2c6b 0004                 movea.l    4(a3),a6
[00013160] 60bc                      bra.s      fread_8
fread_1:
[00013162] 268c                      move.l     a4,(a3)
[00013164] 2004                      move.l     d4,d0
fread_9:
[00013166] 4cdf 5c18                 movem.l    (a7)+,d3-d4/a2-a4/a6
[0001316a] 4e75                      rts
fread_2:
[0001316c] 33fc 000d 0001 4658       move.w     #$000D,errno
fread_7:
[00013174] 08eb 0005 0012            bset       #5,18(a3)
[0001317a] 70ff                      moveq.l    #-1,d0
[0001317c] 60e8                      bra.s      fread_9

fgetc:
[0001317e] 2250                      movea.l    (a0),a1
[00013180] b3e8 0004                 cmpa.l     4(a0),a1
[00013184] 6408                      bcc.s      fgetc_1
fgetc_6:
[00013186] 4240                      clr.w      d0
[00013188] 1019                      move.b     (a1)+,d0
[0001318a] 2089                      move.l     a1,(a0)
[0001318c] 4e75                      rts
fgetc_1:
[0001318e] 1028 0012                 move.b     18(a0),d0
[00013192] 0800 0000                 btst       #0,d0
[00013196] 672a                      beq.s      fgetc_2
[00013198] 0800 0006                 btst       #6,d0
[0001319c] 6712                      beq.s      fgetc_3
[0001319e] 0800 0001                 btst       #1,d0
[000131a2] 671e                      beq.s      fgetc_2
[000131a4] 2f08                      move.l     a0,-(a7)
[000131a6] 6100 0356                 bsr        _FlshBuf
[000131aa] 205f                      movea.l    (a7)+,a0
[000131ac] 4a40                      tst.w      d0
[000131ae] 661a                      bne.s      fgetc_4
fgetc_3:
[000131b0] 2f08                      move.l     a0,-(a7)
[000131b2] 6100 02d6                 bsr        _FillBuf
[000131b6] 205f                      movea.l    (a7)+,a0
[000131b8] 4a40                      tst.w      d0
[000131ba] 6b0e                      bmi.s      fgetc_4
[000131bc] 6612                      bne.s      fgetc_5
[000131be] 2250                      movea.l    (a0),a1
[000131c0] 60c4                      bra.s      fgetc_6
fgetc_2:
[000131c2] 33fc 000d 0001 4658       move.w     #$000D,errno
fgetc_4:
[000131ca] 08e8 0005 0012            bset       #5,18(a0)
fgetc_5:
[000131d0] 70ff                      moveq.l    #-1,d0
[000131d2] 4e75                      rts

rewind:
[000131d4] 08a8 0005 0012            bclr       #5,18(a0)
[000131da] 7000                      moveq.l    #0,d0
[000131dc] 7200                      moveq.l    #0,d1
[000131de] 6000 0002                 bra.w      fseek

fseek:
[000131e2] 48e7 1810                 movem.l    d3-d4/a3,-(a7)
[000131e6] 2648                      movea.l    a0,a3
[000131e8] 2600                      move.l     d0,d3
[000131ea] 3801                      move.w     d1,d4
[000131ec] b87c 0001                 cmp.w      #$0001,d4
[000131f0] 6616                      bne.s      fseek_1
[000131f2] d693                      add.l      (a3),d3
[000131f4] b6ab 0004                 cmp.l      4(a3),d3
[000131f8] 620a                      bhi.s      fseek_2
[000131fa] b6ab 0008                 cmp.l      8(a3),d3
[000131fe] 6504                      bcs.s      fseek_2
[00013200] 2683                      move.l     d3,(a3)
[00013202] 6038                      bra.s      fseek_3
fseek_2:
[00013204] 96ab 0004                 sub.l      4(a3),d3
fseek_1:
[00013208] 082b 0006 0012            btst       #6,18(a3)
[0001320e] 6712                      beq.s      fseek_4
[00013210] 082b 0001 0012            btst       #1,18(a3)
[00013216] 6732                      beq.s      fseek_5
[00013218] 204b                      movea.l    a3,a0
[0001321a] 6100 02e2                 bsr        _FlshBuf
[0001321e] 4a40                      tst.w      d0
[00013220] 663a                      bne.s      fseek_6
fseek_4:
[00013222] 2203                      move.l     d3,d1
[00013224] 3404                      move.w     d4,d2
[00013226] 302b 0010                 move.w     16(a3),d0
[0001322a] 6100 05f6                 bsr        lseek
[0001322e] 4a80                      tst.l      d0
[00013230] 6b2a                      bmi.s      fseek_6
[00013232] 206b 0008                 movea.l    8(a3),a0
[00013236] 2688                      move.l     a0,(a3)
[00013238] 2748 0004                 move.l     a0,4(a3)
fseek_3:
[0001323c] 08ab 0004 0012            bclr       #4,18(a3)
[00013242] 7000                      moveq.l    #0,d0
fseek_7:
[00013244] 4cdf 0818                 movem.l    (a7)+,d3-d4/a3
[00013248] 4e75                      rts
fseek_5:
[0001324a] 33fc 000d 0001 4658       move.w     #$000D,errno
[00013252] 6008                      bra.s      fseek_6
[00013254] 33fc 0016 0001 4658       move.w     #$0016,errno
fseek_6:
[0001325c] 08eb 0005 0012            bset       #5,18(a3)
[00013262] 7001                      moveq.l    #1,d0
[00013264] 60de                      bra.s      fseek_7

fopen:
[00013266] 7000                      moveq.l    #0,d0
[00013268] 2f00                      move.l     d0,-(a7)
[0001326a] 6100 0006                 bsr.w      freopen
[0001326e] 584f                      addq.w     #4,a7
[00013270] 4e75                      rts

freopen:
[00013272] 48e7 1018                 movem.l    d3/a3-a4,-(a7)
[00013276] 2648                      movea.l    a0,a3
[00013278] 286f 0010                 movea.l    16(a7),a4
[0001327c] 2049                      movea.l    a1,a0
[0001327e] 6100 00b2                 bsr        getmode
[00013282] 3600                      move.w     d0,d3
[00013284] 6b6c                      bmi.s      freopen_1
[00013286] 200c                      move.l     a4,d0
[00013288] 6708                      beq.s      freopen_2
[0001328a] 204c                      movea.l    a4,a0
[0001328c] 6100 01a8                 bsr        fclose
[00013290] 600a                      bra.s      freopen_3
freopen_2:
[00013292] 6100 0128                 bsr        $000133BC
[00013296] 4a00                      tst.b      d0
[00013298] 665c                      bne.s      freopen_4
[0001329a] 2848                      movea.l    a0,a4
freopen_3:
[0001329c] 203c 0000 0400            move.l     #$00000400,d0
[000132a2] 6100 09bc                 bsr        malloc
[000132a6] 2948 0008                 move.l     a0,8(a4)
[000132aa] 674e                      beq.s      freopen_5
[000132ac] 3003                      move.w     d3,d0
[000132ae] d040                      add.w      d0,d0
[000132b0] 303b 005c                 move.w     $0001330E(pc,d0.w),d0
[000132b4] 204b                      movea.l    a3,a0
[000132b6] 6100 02fc                 bsr        open
[000132ba] b07c ffff                 cmp.w      #$FFFF,d0
[000132be] 6742                      beq.s      freopen_6
[000132c0] 3940 0010                 move.w     d0,16(a4)
[000132c4] 197b 3060 0012            move.b     $00013326(pc,d3.w),18(a4)
[000132ca] 51ec 0015                 sf         21(a4)
[000132ce] 206c 0008                 movea.l    8(a4),a0
[000132d2] 2948 0004                 move.l     a0,4(a4)
[000132d6] 2888                      move.l     a0,(a4)
[000132d8] d0fc 0400                 adda.w     #$0400,a0
[000132dc] 2948 000c                 move.l     a0,12(a4)
[000132e0] 43fa 00f6                 lea.l      cleanfil(pc),a1
[000132e4] 23c9 0001 465e            move.l     a1,_FilSysVec
[000132ea] 204c                      movea.l    a4,a0
freopen_8:
[000132ec] 4cdf 1808                 movem.l    (a7)+,d3/a3-a4
[000132f0] 4e75                      rts
freopen_1:
[000132f2] 7016                      moveq.l    #22,d0
[000132f4] 6006                      bra.s      freopen_7
freopen_4:
[000132f6] 7018                      moveq.l    #24,d0
[000132f8] 6002                      bra.s      freopen_7
freopen_5:
[000132fa] 700c                      moveq.l    #12,d0
freopen_7:
[000132fc] 33c0 0001 4658            move.w     d0,errno
freopen_6:
[00013302] 206c 0008                 movea.l    8(a4),a0
[00013306] 6100 0a40                 bsr        free
[0001330a] 91c8                      suba.l     a0,a0
[0001330c] 60de                      bra.s      freopen_8
[0001330e] 0000 0061                 ori.b      #$61,d0
[00013312] 0029 0002 0062            ori.b      #$02,98(a1)
[00013318] 002a 0000 0061            ori.b      #$00,97(a2)
[0001331e] 0029 0002 0062            ori.b      #$02,98(a1)
[00013324] 002a 090a 0a0b            ori.b      #$0A,2571(a2)
[0001332a] 0b0b 898a                 movep.w    -30326(a3),d5
[0001332e] 8a8b                      or.l       a3,d5 ; apollo only
[00013330] 8b8b 594f                 unpk       -a3,-a5,#$594F
[00013334] 43d7                      lea.l      (a7),a1
[00013336] 4291                      clr.l      (a1)
[00013338] 12d8                      move.b     (a0)+,(a1)+
[0001333a] 12d8                      move.b     (a0)+,(a1)+
[0001333c] 6706                      beq.s      freopen_9
[0001333e] 12d8                      move.b     (a0)+,(a1)+
[00013340] 6702                      beq.s      freopen_9
[00013342] 12d8                      move.b     (a0)+,(a1)+
freopen_9:
[00013344] 2017                      move.l     (a7),d0
[00013346] 41fa 001a                 lea.l      $00013362(pc),a0
[0001334a] 720e                      moveq.l    #14,d1
[0001334c] 6002                      bra.s      freopen_10
freopen_11:
[0001334e] 5448                      addq.w     #2,a0
freopen_10:
[00013350] b098                      cmp.l      (a0)+,d0
[00013352] 57c9 fffa                 dbeq       d1,freopen_11
[00013356] 6606                      bne.s      freopen_12
[00013358] 3010                      move.w     (a0),d0
freopen_13:
[0001335a] 584f                      addq.w     #4,a7
[0001335c] 4e75                      rts
freopen_12:
[0001335e] 70ff                      moveq.l    #-1,d0
[00013360] 60f8                      bra.s      freopen_13
[00013362] 7200                      moveq.l    #0,d1
[00013364] 0000                      dc.w       $0000
[00013366] 0000 7700                 ori.b      #$00,d0
[0001336a] 0000 0001                 ori.b      #$01,d0
[0001336e] 6100 0000                 bsr.w      $00013370
[00013372] 0002 722b                 ori.b      #$2B,d2
[00013376] 0000 0003                 ori.b      #$03,d0
[0001337a] 772b                      ???
[0001337c] 0000 0004                 ori.b      #$04,d0
[00013380] 612b                      bsr.s      $000133AD ; ; branch to odd address
[00013382] 0000 0005                 ori.b      #$05,d0
[00013386] 7262                      moveq.l    #98,d1
[00013388] 0000 0006                 ori.b      #$06,d0
[0001338c] 7762                      ???
[0001338e] 0000 0007                 ori.b      #$07,d0
[00013392] 6162                      bsr.s      $000133F6
[00013394] 0000 0008                 ori.b      #$08,d0
[00013398] 722b                      moveq.l    #43,d1
[0001339a] 6200 0009                 bhi.w      freopen_14
[0001339e] 7262                      moveq.l    #98,d1
[000133a0] 2b00                      move.l     d0,-(a5)
[000133a2] 0009 772b                 ori.b      #$2B,a1 ; apollo only
freopen_14:
[000133a6] 6200 000a                 bhi.w      freopen_15
[000133aa] 7762                      ???
[000133ac] 2b00                      move.l     d0,-(a5)
[000133ae] 000a 612b                 ori.b      #$2B,a2 ; apollo only
freopen_15:
[000133b2] 6200 000b                 bhi.w      freopen_16
[000133b6] 6162                      bsr.s      $0001341A
[000133b8] 2b00                      move.l     d0,-(a5)
[000133ba] 000b 41f9                 ori.b      #$F9,a3 ; apollo only
[000133be] 0001 63ee                 ori.b      #$EE,d1
freopen_16:
[000133c2] 701f                      moveq.l    #31,d0
[000133c4] 6004                      bra.s      freopen_17
freopen_17: ; not found: 000133ca

searchfil:
[000133c6] 41e8 0016                 lea.l      22(a0),a0
[000133ca] 7203                      moveq.l    #3,d1
[000133cc] c228 0012                 and.b      18(a0),d1
[000133d0] 57c8 fff4                 dbeq       d0,searchfil
[000133d4] 56c0                      sne        d0
[000133d6] 4e75                      rts

cleanfil:
[000133d8] 3f03                      move.w     d3,-(a7)
[000133da] 2f0b                      move.l     a3,-(a7)
[000133dc] 41f9 0001 5928            lea.l      stdout,a0
[000133e2] 6100 0052                 bsr.w      fclose
[000133e6] 41f9 0001 593e            lea.l      stderr,a0
[000133ec] 6100 0048                 bsr.w      fclose
[000133f0] 47f9 0001 63ee            lea.l      _FilTab,a3
[000133f6] 363c 001f                 move.w     #$001F,d3
[000133fa] 6004                      bra.s      cleanfil_1
cleanfil_3:
[000133fc] 47eb 0016                 lea.l      22(a3),a3 ; $00016404
cleanfil_1:
[00013400] 7003                      moveq.l    #3,d0
[00013402] c02b 0012                 and.b      18(a3),d0 ; $00016416
[00013406] 6706                      beq.s      cleanfil_2
[00013408] 204b                      movea.l    a3,a0
[0001340a] 6100 002a                 bsr.w      fclose
cleanfil_2:
[0001340e] 51cb ffec                 dbf        d3,cleanfil_3
[00013412] 4a39 0001 5982            tst.b      $00015982
[00013418] 6708                      beq.s      cleanfil_4
[0001341a] 41fa 000c                 lea.l      $00013428(pc),a0
[0001341e] 6100 025c                 bsr        unlink
cleanfil_4:
[00013422] 265f                      movea.l    (a7)+,a3
[00013424] 361f                      move.w     (a7)+,d3
[00013426] 4e75                      rts

x13428:
[00013428] 5f54                      subq.w     #7,(a4)
[0001342a] 4d50                      lea.l      (a0),b6 ; apollo only
[0001342c] 5f58                      subq.w     #7,(a0)+
[0001342e] 5858                      addq.w     #4,(a0)+
[00013430] 2e58                      movea.l    (a0)+,a7
[00013432] 5858                      addq.w     #4,(a0)+
[00013434] 0000                      dc.w       $0000

fclose:
[00013436] 2f0b                      move.l     a3,-(a7)
[00013438] 2648                      movea.l    a0,a3
[0001343a] 082b 0006 0012            btst       #6,18(a3)
[00013440] 6710                      beq.s      fclose_1
[00013442] 082b 0001 0012            btst       #1,18(a3)
[00013448] 672e                      beq.s      fclose_2
[0001344a] 6100 00b2                 bsr        _FlshBuf
[0001344e] 4a40                      tst.w      d0
[00013450] 662e                      bne.s      fclose_3
fclose_1:
[00013452] 302b 0010                 move.w     16(a3),d0
[00013456] 6100 01fe                 bsr        close
[0001345a] 4a40                      tst.w      d0
[0001345c] 6b22                      bmi.s      fclose_3
[0001345e] 082b 0003 0012            btst       #3,18(a3)
[00013464] 6708                      beq.s      fclose_4
[00013466] 206b 0008                 movea.l    8(a3),a0
[0001346a] 6100 08dc                 bsr        free
fclose_4:
[0001346e] 4240                      clr.w      d0
[00013470] 3740 0012                 move.w     d0,18(a3)
fclose_5:
[00013474] 265f                      movea.l    (a7)+,a3
[00013476] 4e75                      rts
fclose_2:
[00013478] 33fc 000d 0001 4658       move.w     #$000D,errno
fclose_3:
[00013480] 08eb 0005 0012            bset       #5,18(a3)
[00013486] 70ff                      moveq.l    #-1,d0
[00013488] 60ea                      bra.s      fclose_5

_FillBuf:
[0001348a] 48e7 1818                 movem.l    d3-d4/a3-a4,-(a7)
[0001348e] 2648                      movea.l    a0,a3
[00013490] 286b 0008                 movea.l    8(a3),a4
_FillBuf_9:
[00013494] 204c                      movea.l    a4,a0
[00013496] 302b 0010                 move.w     16(a3),d0
[0001349a] 222b 000c                 move.l     12(a3),d1
[0001349e] 928c                      sub.l      a4,d1
[000134a0] 6100 01fa                 bsr        read
[000134a4] 4a80                      tst.l      d0
[000134a6] 6b52                      bmi.s      _FillBuf_1
[000134a8] 6746                      beq.s      _FillBuf_2
[000134aa] 082b 0007 0012            btst       #7,18(a3)
[000134b0] 662c                      bne.s      _FillBuf_3
[000134b2] 204c                      movea.l    a4,a0
[000134b4] 2200                      move.l     d0,d1
[000134b6] 5381                      subq.l     #1,d1
[000134b8] 740d                      moveq.l    #13,d2
_FillBuf_5:
[000134ba] b418                      cmp.b      (a0)+,d2
[000134bc] 6706                      beq.s      _FillBuf_4
[000134be] 5381                      subq.l     #1,d1
[000134c0] 6af8                      bpl.s      _FillBuf_5
[000134c2] 6016                      bra.s      _FillBuf_6
_FillBuf_4:
[000134c4] 2248                      movea.l    a0,a1
_FillBuf_7:
[000134c6] 5349                      subq.w     #1,a1
[000134c8] 5380                      subq.l     #1,d0
[000134ca] 5381                      subq.l     #1,d1
[000134cc] 6b0c                      bmi.s      _FillBuf_6
_FillBuf_8:
[000134ce] 1618                      move.b     (a0)+,d3
[000134d0] 12c3                      move.b     d3,(a1)+
[000134d2] b602                      cmp.b      d2,d3
[000134d4] 67f0                      beq.s      _FillBuf_7
[000134d6] 5381                      subq.l     #1,d1
[000134d8] 6af4                      bpl.s      _FillBuf_8
_FillBuf_6:
[000134da] 4a80                      tst.l      d0
[000134dc] 67b6                      beq.s      _FillBuf_9
_FillBuf_3:
[000134de] 268c                      move.l     a4,(a3)
[000134e0] 2200                      move.l     d0,d1
[000134e2] d9c1                      adda.l     d1,a4
[000134e4] 274c 0004                 move.l     a4,4(a3)
[000134e8] 4280                      clr.l      d0
_FillBuf_10:
[000134ea] 4cdf 1818                 movem.l    (a7)+,d3-d4/a3-a4
[000134ee] 4e75                      rts
_FillBuf_2:
[000134f0] 08eb 0004 0012            bset       #4,18(a3)
[000134f6] 7001                      moveq.l    #1,d0
[000134f8] 60f0                      bra.s      _FillBuf_10
_FillBuf_1:
[000134fa] 70ff                      moveq.l    #-1,d0
[000134fc] 60ec                      bra.s      _FillBuf_10

_FlshBuf:
[000134fe] 48e7 1018                 movem.l    d3/a3-a4,-(a7)
[00013502] 2648                      movea.l    a0,a3
[00013504] 286b 0008                 movea.l    8(a3),a4
[00013508] 362b 0010                 move.w     16(a3),d3
[0001350c] 222b 0004                 move.l     4(a3),d1
[00013510] 928c                      sub.l      a4,d1
[00013512] 6710                      beq.s      _FlshBuf_1
[00013514] 3003                      move.w     d3,d0
[00013516] 4481                      neg.l      d1
[00013518] 7401                      moveq.l    #1,d2
[0001351a] 6100 0306                 bsr        lseek
[0001351e] 4a80                      tst.l      d0
[00013520] 6b00 008a                 bmi        _FlshBuf_2
_FlshBuf_1:
[00013524] 082b 0007 0012            btst       #7,18(a3)
[0001352a] 665a                      bne.s      _FlshBuf_3
[0001352c] 2213                      move.l     (a3),d1
[0001352e] 928c                      sub.l      a4,d1
[00013530] 5381                      subq.l     #1,d1
[00013532] 224c                      movea.l    a4,a1
[00013534] 2049                      movea.l    a1,a0
[00013536] 700a                      moveq.l    #10,d0
_FlshBuf_5:
[00013538] b019                      cmp.b      (a1)+,d0
[0001353a] 6706                      beq.s      _FlshBuf_4
[0001353c] 5381                      subq.l     #1,d1
[0001353e] 6af8                      bpl.s      _FlshBuf_5
[00013540] 602a                      bra.s      _FlshBuf_6
_FlshBuf_4:
[00013542] 137c 000d ffff            move.b     #$0D,-1(a1)
[00013548] 2f01                      move.l     d1,-(a7)
[0001354a] 2f09                      move.l     a1,-(a7)
[0001354c] 2209                      move.l     a1,d1
[0001354e] 9288                      sub.l      a0,d1
[00013550] 3003                      move.w     d3,d0
[00013552] 6100 029c                 bsr        write
[00013556] 225f                      movea.l    (a7)+,a1
[00013558] 221f                      move.l     (a7)+,d1
[0001355a] 4a80                      tst.l      d0
[0001355c] 6b4e                      bmi.s      _FlshBuf_2
[0001355e] 6750                      beq.s      _FlshBuf_7
[00013560] 41e9 ffff                 lea.l      -1(a1),a0
[00013564] 700a                      moveq.l    #10,d0
[00013566] 1080                      move.b     d0,(a0)
[00013568] 5381                      subq.l     #1,d1
[0001356a] 6acc                      bpl.s      _FlshBuf_5
_FlshBuf_6:
[0001356c] 48e7 40c0                 movem.l    d1/a0-a1,-(a7)
[00013570] 2209                      move.l     a1,d1
[00013572] 9288                      sub.l      a0,d1
[00013574] 3003                      move.w     d3,d0
[00013576] 6100 0278                 bsr        write
[0001357a] 4cdf 0302                 movem.l    (a7)+,d1/a0-a1
[0001357e] 4a80                      tst.l      d0
[00013580] 6b2a                      bmi.s      _FlshBuf_2
[00013582] 672c                      beq.s      _FlshBuf_7
[00013584] 6012                      bra.s      _FlshBuf_8
_FlshBuf_3:
[00013586] 3003                      move.w     d3,d0
[00013588] 2213                      move.l     (a3),d1
[0001358a] 928c                      sub.l      a4,d1
[0001358c] 204c                      movea.l    a4,a0
[0001358e] 6100 0260                 bsr        write
[00013592] 4a80                      tst.l      d0
[00013594] 6b16                      bmi.s      _FlshBuf_2
[00013596] 6718                      beq.s      _FlshBuf_7
_FlshBuf_8:
[00013598] 268c                      move.l     a4,(a3)
[0001359a] 274c 0004                 move.l     a4,4(a3)
[0001359e] 08ab 0006 0012            bclr       #6,18(a3)
[000135a4] 4240                      clr.w      d0
_FlshBuf_9:
[000135a6] 4cdf 1808                 movem.l    (a7)+,d3/a3-a4
[000135aa] 4e75                      rts
_FlshBuf_2:
[000135ac] 70ff                      moveq.l    #-1,d0
[000135ae] 60f6                      bra.s      _FlshBuf_9
_FlshBuf_7:
[000135b0] 7001                      moveq.l    #1,d0
[000135b2] 60f2                      bra.s      _FlshBuf_9

open:
[000135b4] 0880 0007                 bclr       #7,d0
[000135b8] 48e7 1810                 movem.l    d3-d4/a3,-(a7)
[000135bc] 3600                      move.w     d0,d3
[000135be] 2648                      movea.l    a0,a3
[000135c0] 7020                      moveq.l    #32,d0
[000135c2] c043                      and.w      d3,d0
[000135c4] 6706                      beq.s      open_1
[000135c6] 7040                      moveq.l    #64,d0
[000135c8] c043                      and.w      d3,d0
[000135ca] 6646                      bne.s      open_2
open_1:
[000135cc] 7003                      moveq.l    #3,d0
[000135ce] c043                      and.w      d3,d0
[000135d0] 3f00                      move.w     d0,-(a7)
[000135d2] 2f0b                      move.l     a3,-(a7)
[000135d4] 3f3c 003d                 move.w     #$003D,-(a7) ; Fopen
[000135d8] 4e41                      trap       #1
[000135da] 504f                      addq.w     #8,a7
[000135dc] 4a80                      tst.l      d0
[000135de] 6b26                      bmi.s      open_3
[000135e0] 3800                      move.w     d0,d4
[000135e2] 6a02                      bpl.s      open_4
[000135e4] 6154                      bsr.s      $0001363A
open_4:
[000135e6] 7008                      moveq.l    #8,d0
[000135e8] c043                      and.w      d3,d0
[000135ea] 6746                      beq.s      open_5
[000135ec] 3f3c 0002                 move.w     #$0002,-(a7)
[000135f0] 3f04                      move.w     d4,-(a7)
[000135f2] 7000                      moveq.l    #0,d0
[000135f4] 2f00                      move.l     d0,-(a7)
[000135f6] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[000135fa] 4e41                      trap       #1
[000135fc] 4fef 000a                 lea.l      10(a7),a7
[00013600] 4a80                      tst.l      d0
[00013602] 6a2e                      bpl.s      open_5
[00013604] 6042                      bra.s      open_6
open_3:
[00013606] 72df                      moveq.l    #-33,d1
[00013608] b280                      cmp.l      d0,d1
[0001360a] 663c                      bne.s      open_6
[0001360c] 7220                      moveq.l    #32,d1
[0001360e] c243                      and.w      d3,d1
[00013610] 6736                      beq.s      open_6
open_2:
[00013612] 7003                      moveq.l    #3,d0
[00013614] c043                      and.w      d3,d0
[00013616] 57c0                      seq        d0
[00013618] c07c 0001                 and.w      #$0001,d0
[0001361c] 3f00                      move.w     d0,-(a7)
[0001361e] 2f0b                      move.l     a3,-(a7)
[00013620] 3f3c 003c                 move.w     #$003C,-(a7) ; Fcreate
[00013624] 4e41                      trap       #1
[00013626] 504f                      addq.w     #8,a7
[00013628] 4a80                      tst.l      d0
[0001362a] 6b1c                      bmi.s      open_6
[0001362c] 3800                      move.w     d0,d4
[0001362e] 6a02                      bpl.s      open_5
[00013630] 6108                      bsr.s      $0001363A
open_5:
[00013632] 3004                      move.w     d4,d0
open_7:
[00013634] 4cdf 0818                 movem.l    (a7)+,d3-d4/a3
[00013638] 4e75                      rts
[0001363a] 4444                      neg.w      d4
[0001363c] 3f00                      move.w     d0,-(a7)
[0001363e] 3f3c 003e                 move.w     #$003E,-(a7) ; Fclose
[00013642] 4e41                      trap       #1
[00013644] 584f                      addq.w     #4,a7
[00013646] 4e75                      rts
open_6:
[00013648] 6100 031a                 bsr        _XltErr
[0001364c] 33c0 0001 4658            move.w     d0,errno
[00013652] 70ff                      moveq.l    #-1,d0
[00013654] 60de                      bra.s      open_7

close:
[00013656] b07c 0002                 cmp.w      #$0002,d0
[0001365a] 630e                      bls.s      close_1
[0001365c] 3f00                      move.w     d0,-(a7)
[0001365e] 3f3c 003e                 move.w     #$003E,-(a7) ; Fclose
[00013662] 4e41                      trap       #1
[00013664] 584f                      addq.w     #4,a7
[00013666] 4a80                      tst.l      d0
[00013668] 6b04                      bmi.s      close_2
close_1:
[0001366a] 7000                      moveq.l    #0,d0
[0001366c] 4e75                      rts
close_2:
[0001366e] 6100 02f4                 bsr        _XltErr
[00013672] 33c0 0001 4658            move.w     d0,errno
[00013678] 70ff                      moveq.l    #-1,d0
[0001367a] 4e75                      rts

unlink:
[0001367c] 2f08                      move.l     a0,-(a7)
[0001367e] 3f3c 0041                 move.w     #$0041,-(a7) ; Fdelete
[00013682] 4e41                      trap       #1
[00013684] 5c4f                      addq.w     #6,a7
[00013686] 4a80                      tst.l      d0
[00013688] 6b04                      bmi.s      unlink_1
[0001368a] 7000                      moveq.l    #0,d0
[0001368c] 4e75                      rts
unlink_1:
[0001368e] 6100 02d4                 bsr        _XltErr
[00013692] 33c0 0001 4658            move.w     d0,errno
[00013698] 70ff                      moveq.l    #-1,d0
[0001369a] 4e75                      rts

read:
[0001369c] 4a40                      tst.w      d0
[0001369e] 6610                      bne.s      read_1
[000136a0] 2f08                      move.l     a0,-(a7)
[000136a2] 2f01                      move.l     d1,-(a7)
[000136a4] 6100 026e                 bsr        isatty
[000136a8] 4a40                      tst.w      d0
[000136aa] 661a                      bne.s      read_2
[000136ac] 4267                      clr.w      -(a7)
[000136ae] 6006                      bra.s      read_3
read_1:
[000136b0] 2f08                      move.l     a0,-(a7)
[000136b2] 2f01                      move.l     d1,-(a7)
[000136b4] 3f00                      move.w     d0,-(a7)
read_3:
[000136b6] 3f3c 003f                 move.w     #$003F,-(a7) ; Fread
[000136ba] 4e41                      trap       #1
[000136bc] 4fef 000c                 lea.l      12(a7),a7
[000136c0] 4a80                      tst.l      d0
[000136c2] 6b08                      bmi.s      read_4
[000136c4] 4e75                      rts
read_2:
[000136c6] 201f                      move.l     (a7)+,d0
[000136c8] 205f                      movea.l    (a7)+,a0
[000136ca] 600e                      bra.s      read_5
read_4:
[000136cc] 6100 0296                 bsr        _XltErr
[000136d0] 33c0 0001 4658            move.w     d0,errno
[000136d6] 70ff                      moveq.l    #-1,d0
[000136d8] 4e75                      rts
read_5:
[000136da] 48e7 1810                 movem.l    d3-d4/a3,-(a7)
[000136de] 2648                      movea.l    a0,a3
[000136e0] 7800                      moveq.l    #0,d4
[000136e2] 2600                      move.l     d0,d3
[000136e4] 5383                      subq.l     #1,d3
[000136e6] 6700 0096                 beq        read_6
[000136ea] 6b00 00c8                 bmi        read_7
[000136ee] 4a39 0001 5980            tst.b      $00015980
[000136f4] 6b70                      bmi.s      read_8
[000136f6] 6678                      bne.s      read_9
read_13:
[000136f8] 6100 00e0                 bsr        $000137DA
[000136fc] b03c 0008                 cmp.b      #$08,d0
[00013700] 6720                      beq.s      read_10
[00013702] b03c 000d                 cmp.b      #$0D,d0
[00013706] 6736                      beq.s      read_11
[00013708] b03c 001a                 cmp.b      #$1A,d0
[0001370c] 674a                      beq.s      read_12
[0001370e] b03c 0020                 cmp.b      #$20,d0
[00013712] 65e4                      bcs.s      read_13
[00013714] b883                      cmp.l      d3,d4
[00013716] 64e0                      bcc.s      read_13
[00013718] 5284                      addq.l     #1,d4
[0001371a] 16c0                      move.b     d0,(a3)+
[0001371c] 6100 00c6                 bsr        echochar
[00013720] 60d6                      bra.s      read_13
read_10:
[00013722] 4a84                      tst.l      d4
[00013724] 67d2                      beq.s      read_13
[00013726] 5384                      subq.l     #1,d4
[00013728] 534b                      subq.w     #1,a3
[0001372a] 7008                      moveq.l    #8,d0
[0001372c] 6100 00b6                 bsr        echochar
[00013730] 7020                      moveq.l    #32,d0
[00013732] 6100 00b0                 bsr        echochar
[00013736] 7008                      moveq.l    #8,d0
[00013738] 6100 00aa                 bsr        echochar
[0001373c] 60ba                      bra.s      read_13
read_11:
[0001373e] 5284                      addq.l     #1,d4
[00013740] 700d                      moveq.l    #13,d0
[00013742] 16c0                      move.b     d0,(a3)+
[00013744] 6100 009e                 bsr        echochar
[00013748] 13fc 0001 0001 5980       move.b     #$01,$00015980
[00013750] 700a                      moveq.l    #10,d0
[00013752] 6100 0090                 bsr        echochar
[00013756] 605c                      bra.s      read_7
read_12:
[00013758] 4a84                      tst.l      d4
[0001375a] 6758                      beq.s      read_7
[0001375c] 13fc ffff 0001 5980       move.b     #$FF,$00015980
[00013764] 604e                      bra.s      read_7
read_8:
[00013766] 7800                      moveq.l    #0,d4
[00013768] 4239 0001 5980            clr.b      $00015980
[0001376e] 6044                      bra.s      read_7
read_9:
[00013770] 7801                      moveq.l    #1,d4
[00013772] 16fc 000a                 move.b     #$0A,(a3)+
[00013776] 4239 0001 5980            clr.b      $00015980
[0001377c] 6036                      bra.s      read_7
read_6:
[0001377e] 4a39 0001 5980            tst.b      $00015980
[00013784] 6b3c                      bmi.s      read_14
[00013786] 6644                      bne.s      read_15
read_18:
[00013788] 6150                      bsr.s      $000137DA
[0001378a] 7801                      moveq.l    #1,d4
[0001378c] 1680                      move.b     d0,(a3)
[0001378e] b03c 000d                 cmp.b      #$0D,d0
[00013792] 6710                      beq.s      read_16
[00013794] b03c 001a                 cmp.b      #$1A,d0
[00013798] 6722                      beq.s      read_17
[0001379a] b03c 0020                 cmp.b      #$20,d0
[0001379e] 65e8                      bcs.s      read_18
[000137a0] 6142                      bsr.s      echochar
[000137a2] 6010                      bra.s      read_7
read_16:
[000137a4] 700d                      moveq.l    #13,d0
[000137a6] 613c                      bsr.s      echochar
[000137a8] 13fc 0001 0001 5980       move.b     #$01,$00015980
[000137b0] 700a                      moveq.l    #10,d0
[000137b2] 6130                      bsr.s      echochar
read_7:
[000137b4] 2004                      move.l     d4,d0
[000137b6] 4cdf 0818                 movem.l    (a7)+,d3-d4/a3
[000137ba] 4e75                      rts
read_17:
[000137bc] 4213                      clr.b      (a3)
[000137be] 7800                      moveq.l    #0,d4
[000137c0] 60f2                      bra.s      read_7
read_14:
[000137c2] 7800                      moveq.l    #0,d4
[000137c4] 4239 0001 5980            clr.b      $00015980
[000137ca] 60e8                      bra.s      read_7
read_15:
[000137cc] 7801                      moveq.l    #1,d4
[000137ce] 16bc 000a                 move.b     #$0A,(a3)
[000137d2] 4239 0001 5980            clr.b      $00015980
[000137d8] 60da                      bra.s      read_7
[000137da] 3f3c 0007                 move.w     #$0007,-(a7) ; Crawcin
[000137de] 4e41                      trap       #1
[000137e0] 544f                      addq.w     #2,a7
[000137e2] 4e75                      rts

echochar:
[000137e4] 3f00                      move.w     d0,-(a7)
[000137e6] 3f3c 0002                 move.w     #$0002,-(a7) ; Cconout
[000137ea] 4e41                      trap       #1
[000137ec] 584f                      addq.w     #4,a7
[000137ee] 4e75                      rts

write:
[000137f0] 2f08                      move.l     a0,-(a7)
[000137f2] 2f01                      move.l     d1,-(a7)
[000137f4] 3f00                      move.w     d0,-(a7)
[000137f6] 3f3c 0040                 move.w     #$0040,-(a7) ; Fwrite
[000137fa] 4e41                      trap       #1
[000137fc] 4fef 000c                 lea.l      12(a7),a7
[00013800] 4a80                      tst.l      d0
[00013802] 6b06                      bmi.s      write_1
[00013804] b081                      cmp.l      d1,d0
[00013806] 6610                      bne.s      write_2
[00013808] 4e75                      rts
write_1:
[0001380a] 6100 0158                 bsr        _XltErr
[0001380e] 33c0 0001 4658            move.w     d0,errno
[00013814] 70ff                      moveq.l    #-1,d0
[00013816] 4e75                      rts
write_2:
[00013818] 33fc 001c 0001 4658       move.w     #$001C,errno
[00013820] 4e75                      rts

lseek:
[00013822] b47c 0002                 cmp.w      #$0002,d2
[00013826] 6200 00e6                 bhi        lseek_1
[0001382a] 3240                      movea.w    d0,a1
[0001382c] 3f02                      move.w     d2,-(a7)
[0001382e] 3f09                      move.w     a1,-(a7)
[00013830] 2f01                      move.l     d1,-(a7)
[00013832] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[00013836] 4e41                      trap       #1
[00013838] 4fef 000a                 lea.l      10(a7),a7
[0001383c] 4a80                      tst.l      d0
[0001383e] 6a00 00be                 bpl        lseek_2
[00013842] b0bc ffff ffc0            cmp.l      #$FFFFFFC0,d0
[00013848] 6600 00b6                 bne        lseek_3
[0001384c] 5342                      subq.w     #1,d2
[0001384e] 6720                      beq.s      lseek_4
[00013850] 6a58                      bpl.s      lseek_5
[00013852] 3f3c 0002                 move.w     #$0002,-(a7)
[00013856] 3f09                      move.w     a1,-(a7)
[00013858] 7000                      moveq.l    #0,d0
[0001385a] 2f00                      move.l     d0,-(a7)
[0001385c] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[00013860] 4e41                      trap       #1
[00013862] 4fef 000a                 lea.l      10(a7),a7
[00013866] 4a80                      tst.l      d0
[00013868] 6b00 0096                 bmi        lseek_3
[0001386c] 2400                      move.l     d0,d2
[0001386e] 6058                      bra.s      lseek_6
lseek_4:
[00013870] 3f3c 0001                 move.w     #$0001,-(a7)
[00013874] 3f09                      move.w     a1,-(a7)
[00013876] 7000                      moveq.l    #0,d0
[00013878] 2f00                      move.l     d0,-(a7)
[0001387a] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[0001387e] 4e41                      trap       #1
[00013880] 4fef 000a                 lea.l      10(a7),a7
[00013884] 4a80                      tst.l      d0
[00013886] 6b78                      bmi.s      lseek_3
[00013888] d081                      add.l      d1,d0
[0001388a] 2200                      move.l     d0,d1
[0001388c] 6b72                      bmi.s      lseek_3
[0001388e] 3f3c 0002                 move.w     #$0002,-(a7)
[00013892] 3f09                      move.w     a1,-(a7)
[00013894] 7000                      moveq.l    #0,d0
[00013896] 2f00                      move.l     d0,-(a7)
[00013898] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[0001389c] 4e41                      trap       #1
[0001389e] 4fef 000a                 lea.l      10(a7),a7
[000138a2] 4a80                      tst.l      d0
[000138a4] 6b5a                      bmi.s      lseek_3
[000138a6] 2400                      move.l     d0,d2
[000138a8] 601e                      bra.s      lseek_6
lseek_5:
[000138aa] 3f3c 0002                 move.w     #$0002,-(a7)
[000138ae] 3f09                      move.w     a1,-(a7)
[000138b0] 7000                      moveq.l    #0,d0
[000138b2] 2f00                      move.l     d0,-(a7)
[000138b4] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[000138b8] 4e41                      trap       #1
[000138ba] 4fef 000a                 lea.l      10(a7),a7
[000138be] 4a80                      tst.l      d0
[000138c0] 6b3e                      bmi.s      lseek_3
[000138c2] 2400                      move.l     d0,d2
[000138c4] d280                      add.l      d0,d1
[000138c6] 6b38                      bmi.s      lseek_3
lseek_6:
[000138c8] 2001                      move.l     d1,d0
[000138ca] 9082                      sub.l      d2,d0
[000138cc] 2400                      move.l     d0,d2
[000138ce] 6b30                      bmi.s      lseek_3
lseek_9:
[000138d0] 487a ff50                 pea.l      lseek(pc)
[000138d4] 203c 0000 0400            move.l     #$00000400,d0
[000138da] b480                      cmp.l      d0,d2
[000138dc] 6504                      bcs.s      lseek_7
[000138de] 2f00                      move.l     d0,-(a7)
[000138e0] 6002                      bra.s      lseek_8
lseek_7:
[000138e2] 2f02                      move.l     d2,-(a7)
lseek_8:
[000138e4] 3f09                      move.w     a1,-(a7)
[000138e6] 3f3c 0040                 move.w     #$0040,-(a7) ; Fwrite
[000138ea] 4e41                      trap       #1
[000138ec] 4fef 000c                 lea.l      12(a7),a7
[000138f0] 4a80                      tst.l      d0
[000138f2] 6b0c                      bmi.s      lseek_3
[000138f4] 94bc 0000 0400            sub.l      #$00000400,d2
[000138fa] 62d4                      bhi.s      lseek_9
[000138fc] 2001                      move.l     d1,d0
lseek_2:
[000138fe] 4e75                      rts
lseek_3:
[00013900] 6100 0062                 bsr.w      _XltErr
lseek_10:
[00013904] 33c0 0001 4658            move.w     d0,errno
[0001390a] 70ff                      moveq.l    #-1,d0
[0001390c] 4e75                      rts
lseek_1:
[0001390e] 303c 0016                 move.w     #$0016,d0
[00013912] 60f0                      bra.s      lseek_10

isatty:
[00013914] 2f03                      move.l     d3,-(a7)
[00013916] 2f04                      move.l     d4,-(a7)
[00013918] 2f05                      move.l     d5,-(a7)
[0001391a] 3600                      move.w     d0,d3
[0001391c] 3f3c 0001                 move.w     #$0001,-(a7)
[00013920] 3f00                      move.w     d0,-(a7)
[00013922] 42a7                      clr.l      -(a7)
[00013924] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[00013928] 4e41                      trap       #1
[0001392a] 4fef 000a                 lea.l      10(a7),a7
[0001392e] 2800                      move.l     d0,d4
[00013930] 4267                      clr.w      -(a7)
[00013932] 3f03                      move.w     d3,-(a7)
[00013934] 2f3c 0000 0001            move.l     #$00000001,-(a7)
[0001393a] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[0001393e] 4e41                      trap       #1
[00013940] 4fef 000a                 lea.l      10(a7),a7
[00013944] 2a00                      move.l     d0,d5
[00013946] 4267                      clr.w      -(a7)
[00013948] 3f03                      move.w     d3,-(a7)
[0001394a] 2f04                      move.l     d4,-(a7)
[0001394c] 3f3c 0042                 move.w     #$0042,-(a7) ; Fseek
[00013950] 4e41                      trap       #1
[00013952] 4fef 000a                 lea.l      10(a7),a7
[00013956] 4a85                      tst.l      d5
[00013958] 57c0                      seq        d0
[0001395a] 4880                      ext.w      d0
[0001395c] 2a1f                      move.l     (a7)+,d5
[0001395e] 281f                      move.l     (a7)+,d4
[00013960] 261f                      move.l     (a7)+,d3
[00013962] 4e75                      rts

_XltErr:
[00013964] 4440                      neg.w      d0
[00013966] 907c 0020                 sub.w      #$0020,d0
[0001396a] b07c 0022                 cmp.w      #$0022,d0
[0001396e] 6206                      bhi.s      _XltErr_1
[00013970] 103b 0008                 move.b     $0001397A(pc,d0.w),d0
[00013974] 4e75                      rts
_XltErr_1:
[00013976] 7005                      moveq.l    #5,d0
[00013978] 4e75                      rts

x1397a:
[0001397a] 1602                      move.b     d2,d3
[0001397c] 1418                      move.b     (a0)+,d2
[0001397e] 0d09 050c                 movep.w    1292(a1),d6
[00013982] 0b05                      btst       d5,d5
[00013984] 0505                      btst       d2,d5
[00013986] 0505                      btst       d2,d5
[00013988] 1305                      move.b     d5,-(a1)
[0001398a] 0502                      btst       d2,d2
[0001398c] 0505                      btst       d2,d5
[0001398e] 0505                      btst       d2,d5
[00013990] 0505                      btst       d2,d5
[00013992] 0505                      btst       d2,d5
[00013994] 0505                      btst       d2,d5
[00013996] 0505                      btst       d2,d5
[00013998] 0505                      btst       d2,d5
[0001399a] 1d05                      move.b     d5,-(a6)
[0001399c] 120c                      move.l     b4,d1 ; apollo only

strcat:
[0001399e] 2008                      move.l     a0,d0
strcat_2:
[000139a0] 4a18                      tst.b      (a0)+
[000139a2] 671c                      beq.s      strcat_1
[000139a4] 4a18                      tst.b      (a0)+
[000139a6] 6718                      beq.s      strcat_1
[000139a8] 4a18                      tst.b      (a0)+
[000139aa] 6714                      beq.s      strcat_1
[000139ac] 4a18                      tst.b      (a0)+
[000139ae] 6710                      beq.s      strcat_1
[000139b0] 4a18                      tst.b      (a0)+
[000139b2] 670c                      beq.s      strcat_1
[000139b4] 4a18                      tst.b      (a0)+
[000139b6] 6708                      beq.s      strcat_1
[000139b8] 4a18                      tst.b      (a0)+
[000139ba] 6704                      beq.s      strcat_1
[000139bc] 4a18                      tst.b      (a0)+
[000139be] 66e0                      bne.s      strcat_2
strcat_1:
[000139c0] 5348                      subq.w     #1,a0
strcat_4:
[000139c2] 10d9                      move.b     (a1)+,(a0)+
[000139c4] 671c                      beq.s      strcat_3
[000139c6] 10d9                      move.b     (a1)+,(a0)+
[000139c8] 6718                      beq.s      strcat_3
[000139ca] 10d9                      move.b     (a1)+,(a0)+
[000139cc] 6714                      beq.s      strcat_3
[000139ce] 10d9                      move.b     (a1)+,(a0)+
[000139d0] 6710                      beq.s      strcat_3
[000139d2] 10d9                      move.b     (a1)+,(a0)+
[000139d4] 670c                      beq.s      strcat_3
[000139d6] 10d9                      move.b     (a1)+,(a0)+
[000139d8] 6708                      beq.s      strcat_3
[000139da] 10d9                      move.b     (a1)+,(a0)+
[000139dc] 6704                      beq.s      strcat_3
[000139de] 10d9                      move.b     (a1)+,(a0)+
[000139e0] 66e0                      bne.s      strcat_4
strcat_3:
[000139e2] 2040                      movea.l    d0,a0
[000139e4] 4e75                      rts

strrchr:
[000139e6] 93c9                      suba.l     a1,a1
strrchr_2:
[000139e8] 1218                      move.b     (a0)+,d1
[000139ea] 670a                      beq.s      strrchr_1
[000139ec] b200                      cmp.b      d0,d1
[000139ee] 66f8                      bne.s      strrchr_2
[000139f0] 43e8 ffff                 lea.l      -1(a0),a1
[000139f4] 60f2                      bra.s      strrchr_2
strrchr_1:
[000139f6] 4a00                      tst.b      d0
[000139f8] 6704                      beq.s      strrchr_3
[000139fa] 2049                      movea.l    a1,a0
[000139fc] 4e75                      rts
strrchr_3:
[000139fe] 5348                      subq.w     #1,a0
[00013a00] 4e75                      rts

strcmp:
[00013a02] 1018                      move.b     (a0)+,d0
[00013a04] 6748                      beq.s      strcmp_1
[00013a06] b019                      cmp.b      (a1)+,d0
[00013a08] 6638                      bne.s      strcmp_2
[00013a0a] 1018                      move.b     (a0)+,d0
[00013a0c] 6740                      beq.s      strcmp_1
[00013a0e] b019                      cmp.b      (a1)+,d0
[00013a10] 6630                      bne.s      strcmp_2
[00013a12] 1018                      move.b     (a0)+,d0
[00013a14] 6738                      beq.s      strcmp_1
[00013a16] b019                      cmp.b      (a1)+,d0
[00013a18] 6628                      bne.s      strcmp_2
[00013a1a] 1018                      move.b     (a0)+,d0
[00013a1c] 6730                      beq.s      strcmp_1
[00013a1e] b019                      cmp.b      (a1)+,d0
[00013a20] 6620                      bne.s      strcmp_2
[00013a22] 1018                      move.b     (a0)+,d0
[00013a24] 6728                      beq.s      strcmp_1
[00013a26] b019                      cmp.b      (a1)+,d0
[00013a28] 6618                      bne.s      strcmp_2
[00013a2a] 1018                      move.b     (a0)+,d0
[00013a2c] 6720                      beq.s      strcmp_1
[00013a2e] b019                      cmp.b      (a1)+,d0
[00013a30] 6610                      bne.s      strcmp_2
[00013a32] 1018                      move.b     (a0)+,d0
[00013a34] 6718                      beq.s      strcmp_1
[00013a36] b019                      cmp.b      (a1)+,d0
[00013a38] 6608                      bne.s      strcmp_2
[00013a3a] 1018                      move.b     (a0)+,d0
[00013a3c] 6710                      beq.s      strcmp_1
[00013a3e] b019                      cmp.b      (a1)+,d0
[00013a40] 67c0                      beq.s      strcmp
strcmp_2:
[00013a42] b021                      cmp.b      -(a1),d0
[00013a44] 6504                      bcs.s      strcmp_3
[00013a46] 7001                      moveq.l    #1,d0
[00013a48] 4e75                      rts
strcmp_3:
[00013a4a] 70ff                      moveq.l    #-1,d0
[00013a4c] 4e75                      rts
strcmp_1:
[00013a4e] 4a11                      tst.b      (a1)
[00013a50] 66f8                      bne.s      strcmp_3
[00013a52] 7000                      moveq.l    #0,d0
[00013a54] 4e75                      rts

strcpy:
[00013a56] 2008                      move.l     a0,d0
strcpy_2:
[00013a58] 10d9                      move.b     (a1)+,(a0)+
[00013a5a] 673c                      beq.s      strcpy_1
[00013a5c] 10d9                      move.b     (a1)+,(a0)+
[00013a5e] 6738                      beq.s      strcpy_1
[00013a60] 10d9                      move.b     (a1)+,(a0)+
[00013a62] 6734                      beq.s      strcpy_1
[00013a64] 10d9                      move.b     (a1)+,(a0)+
[00013a66] 6730                      beq.s      strcpy_1
[00013a68] 10d9                      move.b     (a1)+,(a0)+
[00013a6a] 672c                      beq.s      strcpy_1
[00013a6c] 10d9                      move.b     (a1)+,(a0)+
[00013a6e] 6728                      beq.s      strcpy_1
[00013a70] 10d9                      move.b     (a1)+,(a0)+
[00013a72] 6724                      beq.s      strcpy_1
[00013a74] 10d9                      move.b     (a1)+,(a0)+
[00013a76] 6720                      beq.s      strcpy_1
[00013a78] 10d9                      move.b     (a1)+,(a0)+
[00013a7a] 671c                      beq.s      strcpy_1
[00013a7c] 10d9                      move.b     (a1)+,(a0)+
[00013a7e] 6718                      beq.s      strcpy_1
[00013a80] 10d9                      move.b     (a1)+,(a0)+
[00013a82] 6714                      beq.s      strcpy_1
[00013a84] 10d9                      move.b     (a1)+,(a0)+
[00013a86] 6710                      beq.s      strcpy_1
[00013a88] 10d9                      move.b     (a1)+,(a0)+
[00013a8a] 670c                      beq.s      strcpy_1
[00013a8c] 10d9                      move.b     (a1)+,(a0)+
[00013a8e] 6708                      beq.s      strcpy_1
[00013a90] 10d9                      move.b     (a1)+,(a0)+
[00013a92] 6704                      beq.s      strcpy_1
[00013a94] 10d9                      move.b     (a1)+,(a0)+
[00013a96] 66c0                      bne.s      strcpy_2
strcpy_1:
[00013a98] 2040                      movea.l    d0,a0
[00013a9a] 4e75                      rts

strlen:
[00013a9c] 2248                      movea.l    a0,a1
strlen_2:
[00013a9e] 4a18                      tst.b      (a0)+
[00013aa0] 671c                      beq.s      strlen_1
[00013aa2] 4a18                      tst.b      (a0)+
[00013aa4] 6718                      beq.s      strlen_1
[00013aa6] 4a18                      tst.b      (a0)+
[00013aa8] 6714                      beq.s      strlen_1
[00013aaa] 4a18                      tst.b      (a0)+
[00013aac] 6710                      beq.s      strlen_1
[00013aae] 4a18                      tst.b      (a0)+
[00013ab0] 670c                      beq.s      strlen_1
[00013ab2] 4a18                      tst.b      (a0)+
[00013ab4] 6708                      beq.s      strlen_1
[00013ab6] 4a18                      tst.b      (a0)+
[00013ab8] 6704                      beq.s      strlen_1
[00013aba] 4a18                      tst.b      (a0)+
[00013abc] 66e0                      bne.s      strlen_2
strlen_1:
[00013abe] 2008                      move.l     a0,d0
[00013ac0] 9089                      sub.l      a1,d0
[00013ac2] 5380                      subq.l     #1,d0
[00013ac4] 4e75                      rts

strncpy:
[00013ac6] 2208                      move.l     a0,d1
strncpy_2:
[00013ac8] 5380                      subq.l     #1,d0
[00013aca] 6510                      bcs.s      strncpy_1
[00013acc] 10d9                      move.b     (a1)+,(a0)+
[00013ace] 66f8                      bne.s      strncpy_2
[00013ad0] 4202                      clr.b      d2
[00013ad2] 4a80                      tst.l      d0
[00013ad4] 6706                      beq.s      strncpy_1
strncpy_3:
[00013ad6] 10c2                      move.b     d2,(a0)+
[00013ad8] 5380                      subq.l     #1,d0
[00013ada] 66fa                      bne.s      strncpy_3
strncpy_1:
[00013adc] 2041                      movea.l    d1,a0
[00013ade] 4e75                      rts

strtoul:
[00013ae0] 48e7 1030                 movem.l    d3/a2-a3,-(a7)
[00013ae4] 2448                      movea.l    a0,a2
[00013ae6] b07c 0001                 cmp.w      #$0001,d0
[00013aea] 6700 00b4                 beq        strtoul_1
[00013aee] b07c 0024                 cmp.w      #$0024,d0
[00013af2] 6200 00ac                 bhi        strtoul_1
[00013af6] 47fa 0764                 lea.l      _ChrCla1(pc),a3
[00013afa] 7200                      moveq.l    #0,d1
[00013afc] 7400                      moveq.l    #0,d2
strtoul_3:
[00013afe] 121a                      move.b     (a2)+,d1
[00013b00] 6700 0082                 beq        strtoul_2
[00013b04] 4a33 1000                 tst.b      0(a3,d1.w)
[00013b08] 6bf4                      bmi.s      strtoul_3
[00013b0a] 534a                      subq.w     #1,a2
[00013b0c] 121a                      move.b     (a2)+,d1
[00013b0e] 6774                      beq.s      strtoul_2
[00013b10] 4a40                      tst.w      d0
[00013b12] 6622                      bne.s      strtoul_4
[00013b14] 700a                      moveq.l    #10,d0
[00013b16] b23c 0030                 cmp.b      #$30,d1
[00013b1a] 663a                      bne.s      strtoul_5
[00013b1c] 7008                      moveq.l    #8,d0
[00013b1e] 121a                      move.b     (a2)+,d1
[00013b20] 6762                      beq.s      strtoul_2
[00013b22] 1601                      move.b     d1,d3
[00013b24] c63c 00df                 and.b      #$DF,d3
[00013b28] b63c 0058                 cmp.b      #$58,d3
[00013b2c] 6628                      bne.s      strtoul_5
[00013b2e] 7010                      moveq.l    #16,d0
[00013b30] 121a                      move.b     (a2)+,d1
[00013b32] 6622                      bne.s      strtoul_5
[00013b34] 604e                      bra.s      strtoul_2
strtoul_4:
[00013b36] b07c 0010                 cmp.w      #$0010,d0
[00013b3a] 661a                      bne.s      strtoul_5
[00013b3c] b23c 0030                 cmp.b      #$30,d1
[00013b40] 6614                      bne.s      strtoul_5
[00013b42] 121a                      move.b     (a2)+,d1
[00013b44] 673e                      beq.s      strtoul_2
[00013b46] 1601                      move.b     d1,d3
[00013b48] c63c 00df                 and.b      #$DF,d3
[00013b4c] b63c 0058                 cmp.b      #$58,d3
[00013b50] 6604                      bne.s      strtoul_5
[00013b52] 121a                      move.b     (a2)+,d1
[00013b54] 672e                      beq.s      strtoul_2
strtoul_5:
[00013b56] 47fa 0804                 lea.l      _DigCnvT(pc),a3
[00013b5a] 1233 1000                 move.b     0(a3,d1.w),d1
[00013b5e] b200                      cmp.b      d0,d1
[00013b60] 6422                      bcc.s      strtoul_2
[00013b62] 1401                      move.b     d1,d2
strtoul_7:
[00013b64] 121a                      move.b     (a2)+,d1
[00013b66] 1233 1000                 move.b     0(a3,d1.w),d1
[00013b6a] b200                      cmp.b      d0,d1
[00013b6c] 6416                      bcc.s      strtoul_2
[00013b6e] 2602                      move.l     d2,d3
[00013b70] 4843                      swap       d3
[00013b72] c6c0                      mulu.w     d0,d3
[00013b74] 4843                      swap       d3
[00013b76] 4a43                      tst.w      d3
[00013b78] 661a                      bne.s      strtoul_6
[00013b7a] c4c0                      mulu.w     d0,d2
[00013b7c] d483                      add.l      d3,d2
[00013b7e] d481                      add.l      d1,d2
[00013b80] 64e2                      bcc.s      strtoul_7
[00013b82] 6010                      bra.s      strtoul_6
strtoul_2:
[00013b84] 2002                      move.l     d2,d0
[00013b86] 2609                      move.l     a1,d3
[00013b88] 6704                      beq.s      strtoul_8
[00013b8a] 534a                      subq.w     #1,a2
[00013b8c] 228a                      move.l     a2,(a1)
strtoul_8:
[00013b8e] 4cdf 0c08                 movem.l    (a7)+,d3/a2-a3
[00013b92] 4e75                      rts
strtoul_6:
[00013b94] 33fc 0022 0001 4658       move.w     #$0022,errno
[00013b9c] 70ff                      moveq.l    #-1,d0
[00013b9e] 600a                      bra.s      strtoul_9
strtoul_1:
[00013ba0] 33fc 0021 0001 4658       move.w     #$0021,errno
[00013ba8] 7000                      moveq.l    #0,d0
strtoul_9:
[00013baa] 2609                      move.l     a1,d3
[00013bac] 67e0                      beq.s      strtoul_8
[00013bae] 2288                      move.l     a0,(a1)
[00013bb0] 60dc                      bra.s      strtoul_8

strupr:
[00013bb2] 2208                      move.l     a0,d1
[00013bb4] 43fa 05a6                 lea.l      _UpcTab(pc),a1
[00013bb8] 4240                      clr.w      d0
strupr_1:
[00013bba] 1010                      move.b     (a0),d0
[00013bbc] 10f1 0000                 move.b     0(a1,d0.w),(a0)+
[00013bc0] 66f8                      bne.s      strupr_1
[00013bc2] 2041                      movea.l    d1,a0
[00013bc4] 4e75                      rts

ultoa:
[00013bc6] 2f03                      move.l     d3,-(a7)
[00013bc8] 2f08                      move.l     a0,-(a7)
[00013bca] 9efc 0022                 suba.w     #$0022,a7
[00013bce] 3401                      move.w     d1,d2
[00013bd0] 5542                      subq.w     #2,d2
[00013bd2] b47c 0022                 cmp.w      #$0022,d2
[00013bd6] 625a                      bhi.s      ultoa_1
[00013bd8] 43ef 0022                 lea.l      34(a7),a1
[00013bdc] 74ff                      moveq.l    #-1,d2
[00013bde] 2600                      move.l     d0,d3
[00013be0] 4843                      swap       d3
[00013be2] 4a43                      tst.w      d3
[00013be4] 6616                      bne.s      ultoa_2
ultoa_3:
[00013be6] 80c1                      divu.w     d1,d0
[00013be8] 2600                      move.l     d0,d3
[00013bea] 4843                      swap       d3
[00013bec] 133b 304e                 move.b     $00013C3C(pc,d3.w),-(a1)
[00013bf0] 5242                      addq.w     #1,d2
[00013bf2] 4840                      swap       d0
[00013bf4] 4240                      clr.w      d0
[00013bf6] 4840                      swap       d0
[00013bf8] 66ec                      bne.s      ultoa_3
[00013bfa] 6024                      bra.s      ultoa_4
ultoa_2:
[00013bfc] 3f04                      move.w     d4,-(a7)
ultoa_5:
[00013bfe] 2600                      move.l     d0,d3
[00013c00] 3800                      move.w     d0,d4
[00013c02] 4243                      clr.w      d3
[00013c04] 4843                      swap       d3
[00013c06] 86c1                      divu.w     d1,d3
[00013c08] 3003                      move.w     d3,d0
[00013c0a] 3604                      move.w     d4,d3
[00013c0c] 86c1                      divu.w     d1,d3
[00013c0e] 4840                      swap       d0
[00013c10] 3003                      move.w     d3,d0
[00013c12] 4843                      swap       d3
[00013c14] 133b 3026                 move.b     $00013C3C(pc,d3.w),-(a1)
[00013c18] 5242                      addq.w     #1,d2
[00013c1a] 4a80                      tst.l      d0
[00013c1c] 66e0                      bne.s      ultoa_5
[00013c1e] 381f                      move.w     (a7)+,d4
ultoa_4:
[00013c20] 10d9                      move.b     (a1)+,(a0)+
[00013c22] 51ca fffc                 dbf        d2,ultoa_4
ultoa_6:
[00013c26] 4218                      clr.b      (a0)+
[00013c28] defc 0022                 adda.w     #$0022,a7
[00013c2c] 205f                      movea.l    (a7)+,a0
[00013c2e] 261f                      move.l     (a7)+,d3
[00013c30] 4e75                      rts
ultoa_1:
[00013c32] 33fc 0021 0001 4658       move.w     #$0021,errno
[00013c3a] 60ea                      bra.s      ultoa_6
[00013c3c] 3031 3233                 move.w     51(a1,d3.w*2),d0 ; 68020+ only
[00013c40] 3435 3637                 move.w     55(a5,d3.w*8),d2 ; 68020+ only
[00013c44] 3839 6162 6364            move.w     $61626364,d4
[00013c4a] 6566                      bcs.s      ultoa_7
[00013c4c] 6768                      beq.s      ultoa_8
[00013c4e] 696a                      bvs.s      ultoa_9
[00013c50] 6b6c                      bmi.s      ultoa_10
[00013c52] 6d6e                      blt.s      ultoa_11
[00013c54] 6f70                      ble.s      ultoa_12
[00013c56] 7172                      ???
[00013c58] 7374                      ???
[00013c5a] 7576                      ???
[00013c5c] 7778                      ???
[00013c5e] 797a                      ???
ultoa_7: ; not found: 00013cb2
ultoa_8: ; not found: 00013cb6
ultoa_9: ; not found: 00013cba
ultoa_10: ; not found: 00013cbe
ultoa_11: ; not found: 00013cc2
ultoa_12: ; not found: 00013cc6

malloc:
[00013c60] 2f03                      move.l     d3,-(a7)
[00013c62] 2f0a                      move.l     a2,-(a7)
[00013c64] 2600                      move.l     d0,d3
[00013c66] 6700 00ca                 beq        malloc_1
[00013c6a] 5083                      addq.l     #8,d3
[00013c6c] 5283                      addq.l     #1,d3
[00013c6e] c63c 00fe                 and.b      #$FE,d3
[00013c72] b6bc 0000 1000            cmp.l      #$00001000,d3
[00013c78] 653a                      bcs.s      malloc_2
[00013c7a] 2f3c ffff ffff            move.l     #$FFFFFFFF,-(a7)
[00013c80] 3f3c 0048                 move.w     #$0048,-(a7) ; Malloc
[00013c84] 4e41                      trap       #1
[00013c86] 5c4f                      addq.w     #6,a7
[00013c88] b083                      cmp.l      d3,d0
[00013c8a] 6b00 00b0                 bmi        malloc_3
[00013c8e] 2f03                      move.l     d3,-(a7)
[00013c90] 3f3c 0048                 move.w     #$0048,-(a7) ; Malloc
[00013c94] 4e41                      trap       #1
[00013c96] 5c4f                      addq.w     #6,a7
[00013c98] 4a80                      tst.l      d0
[00013c9a] 6f00 00a0                 ble        malloc_3
[00013c9e] 2040                      movea.l    d0,a0
[00013ca0] 2143 0004                 move.l     d3,4(a0)
[00013ca4] 43f9 0001 5984            lea.l      _MemBlkL,a1
[00013caa] 2091                      move.l     (a1),(a0) ; _MemBlkL
[00013cac] 2288                      move.l     a0,(a1) ; _MemBlkL
[00013cae] 41e8 0008                 lea.l      8(a0),a0
[00013cb2] 6078                      bra.s      malloc_4
malloc_2:
[00013cb4] 45f9 0001 5988            lea.l      _MemCluL,a2
malloc_9:
[00013cba] 2452                      movea.l    (a2),a2 ; _MemCluL
[00013cbc] 200a                      move.l     a2,d0
[00013cbe] 6634                      bne.s      malloc_5
[00013cc0] 2f3c 0000 2010            move.l     #$00002010,-(a7)
[00013cc6] 3f3c 0048                 move.w     #$0048,-(a7) ; Malloc
[00013cca] 4e41                      trap       #1
[00013ccc] 5c4f                      addq.w     #6,a7
[00013cce] 4a80                      tst.l      d0
[00013cd0] 6f6a                      ble.s      malloc_3
[00013cd2] 2440                      movea.l    d0,a2
[00013cd4] 41ea 0008                 lea.l      8(a2),a0
[00013cd8] 7000                      moveq.l    #0,d0
[00013cda] 2080                      move.l     d0,(a0)
[00013cdc] 217c 0000 2008 0004       move.l     #$00002008,4(a0)
[00013ce4] 2548 0004                 move.l     a0,4(a2)
[00013ce8] 24b9 0001 5988            move.l     _MemCluL,(a2)
[00013cee] 23ca 0001 5988            move.l     a2,_MemCluL
malloc_5:
[00013cf4] 41ea 0004                 lea.l      4(a2),a0
[00013cf8] 2250                      movea.l    (a0),a1
[00013cfa] 600c                      bra.s      malloc_6
malloc_8:
[00013cfc] 2029 0004                 move.l     4(a1),d0
[00013d00] 9083                      sub.l      d3,d0
[00013d02] 640a                      bcc.s      malloc_7
[00013d04] 2049                      movea.l    a1,a0
[00013d06] 2251                      movea.l    (a1),a1
malloc_6:
[00013d08] 2009                      move.l     a1,d0
[00013d0a] 66f0                      bne.s      malloc_8
[00013d0c] 60ac                      bra.s      malloc_9
malloc_7:
[00013d0e] 7210                      moveq.l    #16,d1
[00013d10] b081                      cmp.l      d1,d0
[00013d12] 6404                      bcc.s      malloc_10
[00013d14] 2091                      move.l     (a1),(a0)
[00013d16] 600a                      bra.s      malloc_11
malloc_10:
[00013d18] 2340 0004                 move.l     d0,4(a1)
[00013d1c] d3c0                      adda.l     d0,a1
[00013d1e] 2343 0004                 move.l     d3,4(a1)
malloc_11:
[00013d22] 22bc 94f1 6e07            move.l     #$94F16E07,(a1)
[00013d28] 41e9 0008                 lea.l      8(a1),a0
malloc_4:
[00013d2c] 245f                      movea.l    (a7)+,a2
[00013d2e] 261f                      move.l     (a7)+,d3
[00013d30] 4e75                      rts
malloc_1:
[00013d32] 6b08                      bmi.s      malloc_3
[00013d34] 207c fff0 0000            movea.l    #$FFF00000,a0
[00013d3a] 60f0                      bra.s      malloc_4
malloc_3:
[00013d3c] 91c8                      suba.l     a0,a0
[00013d3e] 33fc 000c 0001 4658       move.w     #$000C,errno
[00013d46] 60e4                      bra.s      malloc_4

free:
[00013d48] 2008                      move.l     a0,d0
[00013d4a] 6f4a                      ble.s      free_1
[00013d4c] 5188                      subq.l     #8,a0
[00013d4e] 0ca8 0000 1000 0004       cmpi.l     #$00001000,4(a0)
[00013d56] 6412                      bcc.s      free_2
[00013d58] 0c90 94f1 6e07            cmpi.l     #$94F16E07,(a0)
[00013d5e] 663e                      bne.s      free_3
[00013d60] 6100 0076                 bsr.w      _InsFreB
[00013d64] 4a00                      tst.b      d0
[00013d66] 672a                      beq.s      free_4
[00013d68] 6034                      bra.s      free_3
free_2:
[00013d6a] 43f9 0001 5984            lea.l      _MemBlkL,a1
[00013d70] 2011                      move.l     (a1),d0 ; _MemBlkL
[00013d72] 672a                      beq.s      free_3
free_6:
[00013d74] b088                      cmp.l      a0,d0
[00013d76] 6708                      beq.s      free_5
[00013d78] 2240                      movea.l    d0,a1
[00013d7a] 2011                      move.l     (a1),d0
[00013d7c] 66f6                      bne.s      free_6
[00013d7e] 601e                      bra.s      free_3
free_5:
[00013d80] 2290                      move.l     (a0),(a1)
[00013d82] 2f08                      move.l     a0,-(a7)
[00013d84] 3f3c 0049                 move.w     #$0049,-(a7) ; Mfree
[00013d88] 4e41                      trap       #1
[00013d8a] 5c4f                      addq.w     #6,a7
[00013d8c] 4a80                      tst.l      d0
[00013d8e] 6a02                      bpl.s      free_4
[00013d90] 600c                      bra.s      free_3
free_4:
[00013d92] 7000                      moveq.l    #0,d0
free_7:
[00013d94] 4e75                      rts
free_1:
[00013d96] b1fc fff0 0000            cmpa.l     #$FFF00000,a0
[00013d9c] 67f4                      beq.s      free_4
free_3:
[00013d9e] 70ff                      moveq.l    #-1,d0
[00013da0] 60f2                      bra.s      free_7

_FreeAll:
[00013da2] 2f0b                      move.l     a3,-(a7)
[00013da4] 47f9 0001 5984            lea.l      _MemBlkL,a3
_FreeAll_2:
[00013daa] 200b                      move.l     a3,d0
[00013dac] 670e                      beq.s      _FreeAll_1
[00013dae] 2f0b                      move.l     a3,-(a7)
[00013db0] 2653                      movea.l    (a3),a3 ; _MemBlkL
[00013db2] 3f3c 0049                 move.w     #$0049,-(a7) ; Mfree
[00013db6] 4e41                      trap       #1
[00013db8] 5c4f                      addq.w     #6,a7
[00013dba] 60ee                      bra.s      _FreeAll_2
_FreeAll_1:
[00013dbc] 47f9 0001 5988            lea.l      _MemCluL,a3
_FreeAll_4:
[00013dc2] 200b                      move.l     a3,d0
[00013dc4] 670e                      beq.s      _FreeAll_3
[00013dc6] 2f0b                      move.l     a3,-(a7)
[00013dc8] 2653                      movea.l    (a3),a3 ; _MemCluL
[00013dca] 3f3c 0049                 move.w     #$0049,-(a7) ; Mfree
[00013dce] 4e41                      trap       #1
[00013dd0] 5c4f                      addq.w     #6,a7
[00013dd2] 60ee                      bra.s      _FreeAll_4
_FreeAll_3:
[00013dd4] 265f                      movea.l    (a7)+,a3
[00013dd6] 4e75                      rts

_InsFreB:
[00013dd8] 48e7 0030                 movem.l    a2-a3,-(a7)
[00013ddc] 243c 0000 2000            move.l     #$00002000,d2
[00013de2] 43e8 fff8                 lea.l      -8(a0),a1
[00013de6] 45f9 0001 5988            lea.l      _MemCluL,a2
[00013dec] 2012                      move.l     (a2),d0 ; _MemCluL
[00013dee] 6700 00b0                 beq        _InsFreB_1
_InsFreB_3:
[00013df2] 2209                      move.l     a1,d1
[00013df4] 9280                      sub.l      d0,d1
[00013df6] b282                      cmp.l      d2,d1
[00013df8] 630a                      bls.s      _InsFreB_2
[00013dfa] 2440                      movea.l    d0,a2
[00013dfc] 2012                      move.l     (a2),d0
[00013dfe] 66f2                      bne.s      _InsFreB_3
[00013e00] 6000 009e                 bra        _InsFreB_1
_InsFreB_2:
[00013e04] 2640                      movea.l    d0,a3
[00013e06] 202b 0004                 move.l     4(a3),d0
[00013e0a] 6714                      beq.s      _InsFreB_4
[00013e0c] b1c0                      cmpa.l     d0,a0
[00013e0e] 622a                      bhi.s      _InsFreB_5
[00013e10] 2208                      move.l     a0,d1
[00013e12] d2a8 0004                 add.l      4(a0),d1
[00013e16] b280                      cmp.l      d0,d1
[00013e18] 6506                      bcs.s      _InsFreB_4
[00013e1a] 670c                      beq.s      _InsFreB_6
[00013e1c] 6000 0082                 bra        _InsFreB_1
_InsFreB_4:
[00013e20] 2080                      move.l     d0,(a0)
[00013e22] 2748 0004                 move.l     a0,4(a3)
[00013e26] 6070                      bra.s      _InsFreB_7
_InsFreB_6:
[00013e28] 2240                      movea.l    d0,a1
[00013e2a] 2229 0004                 move.l     4(a1),d1
[00013e2e] d3a8 0004                 add.l      d1,4(a0)
[00013e32] 2091                      move.l     (a1),(a0)
[00013e34] 2748 0004                 move.l     a0,4(a3)
[00013e38] 603e                      bra.s      _InsFreB_8
_InsFreB_5:
[00013e3a] 2240                      movea.l    d0,a1
[00013e3c] 2011                      move.l     (a1),d0
[00013e3e] 6704                      beq.s      _InsFreB_9
[00013e40] b1c0                      cmpa.l     d0,a0
[00013e42] 62f6                      bhi.s      _InsFreB_5
_InsFreB_9:
[00013e44] 2209                      move.l     a1,d1
[00013e46] d2a9 0004                 add.l      4(a1),d1
[00013e4a] b288                      cmp.l      a0,d1
[00013e4c] 650e                      bcs.s      _InsFreB_10
[00013e4e] 6702                      beq.s      _InsFreB_11
[00013e50] 604e                      bra.s      _InsFreB_1
_InsFreB_11:
[00013e52] 2228 0004                 move.l     4(a0),d1
[00013e56] d3a9 0004                 add.l      d1,4(a1)
[00013e5a] 6006                      bra.s      _InsFreB_12
_InsFreB_10:
[00013e5c] 2288                      move.l     a0,(a1)
[00013e5e] 2080                      move.l     d0,(a0)
[00013e60] 2248                      movea.l    a0,a1
_InsFreB_12:
[00013e62] 2209                      move.l     a1,d1
[00013e64] d2a9 0004                 add.l      4(a1),d1
[00013e68] b280                      cmp.l      d0,d1
[00013e6a] 660c                      bne.s      _InsFreB_8
[00013e6c] 2040                      movea.l    d0,a0
[00013e6e] 2228 0004                 move.l     4(a0),d1
[00013e72] d3a9 0004                 add.l      d1,4(a1)
[00013e76] 2290                      move.l     (a0),(a1)
_InsFreB_8:
[00013e78] 206b 0004                 movea.l    4(a3),a0
[00013e7c] 0ca8 0000 2008 0004       cmpi.l     #$00002008,4(a0)
[00013e84] 6512                      bcs.s      _InsFreB_7
[00013e86] 6218                      bhi.s      _InsFreB_1
[00013e88] 2493                      move.l     (a3),(a2)
[00013e8a] 2f0b                      move.l     a3,-(a7)
[00013e8c] 3f3c 0049                 move.w     #$0049,-(a7) ; Mfree
[00013e90] 4e41                      trap       #1
[00013e92] 5c4f                      addq.w     #6,a7
[00013e94] 4a80                      tst.l      d0
[00013e96] 6608                      bne.s      _InsFreB_1
_InsFreB_7:
[00013e98] 51c0                      sf         d0
_InsFreB_13:
[00013e9a] 4cdf 0c00                 movem.l    (a7)+,a2-a3
[00013e9e] 4e75                      rts
_InsFreB_1:
[00013ea0] 50c0                      st         d0
[00013ea2] 60f6                      bra.s      _InsFreB_13

memcpy:
[00013ea4] 4a80                      tst.l      d0
[00013ea6] 6700 01e4                 beq        memcpy_1
[00013eaa] 2f08                      move.l     a0,-(a7)
[00013eac] b3c8                      cmpa.l     a0,a1
[00013eae] 6200 00f8                 bhi        memcpy_2
[00013eb2] 6700 01d6                 beq        memcpy_3
[00013eb6] d3c0                      adda.l     d0,a1
[00013eb8] d1c0                      adda.l     d0,a0
[00013eba] 3209                      move.w     a1,d1
[00013ebc] 3408                      move.w     a0,d2
[00013ebe] 0801 0000                 btst       #0,d1
[00013ec2] 6710                      beq.s      memcpy_4
[00013ec4] 0802 0000                 btst       #0,d2
[00013ec8] 6612                      bne.s      memcpy_5
memcpy_6:
[00013eca] 1121                      move.b     -(a1),-(a0)
[00013ecc] 5380                      subq.l     #1,d0
[00013ece] 66fa                      bne.s      memcpy_6
[00013ed0] 6000 01b8                 bra        memcpy_3
memcpy_4:
[00013ed4] 0802 0000                 btst       #0,d2
[00013ed8] 66f0                      bne.s      memcpy_6
[00013eda] 6008                      bra.s      memcpy_7
memcpy_5:
[00013edc] 1121                      move.b     -(a1),-(a0)
[00013ede] 5380                      subq.l     #1,d0
[00013ee0] 6700 01a8                 beq        memcpy_3
memcpy_7:
[00013ee4] 2200                      move.l     d0,d1
[00013ee6] ea89                      lsr.l      #5,d1
[00013ee8] e889                      lsr.l      #4,d1
[00013eea] 6700 0096                 beq        memcpy_8
[00013eee] 48e7 3f1e                 movem.l    d2-d7/a3-a6,-(a7)
memcpy_9:
[00013ef2] 4ce9 78fc ffd8            movem.l    -40(a1),d2-d7/a3-a6
[00013ef8] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013efc] 4ce9 78fc ffb0            movem.l    -80(a1),d2-d7/a3-a6
[00013f02] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f06] 4ce9 78fc ff88            movem.l    -120(a1),d2-d7/a3-a6
[00013f0c] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f10] 4ce9 78fc ff60            movem.l    -160(a1),d2-d7/a3-a6
[00013f16] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f1a] 4ce9 78fc ff38            movem.l    -200(a1),d2-d7/a3-a6
[00013f20] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f24] 4ce9 78fc ff10            movem.l    -240(a1),d2-d7/a3-a6
[00013f2a] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f2e] 4ce9 78fc fee8            movem.l    -280(a1),d2-d7/a3-a6
[00013f34] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f38] 4ce9 78fc fec0            movem.l    -320(a1),d2-d7/a3-a6
[00013f3e] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f42] 4ce9 78fc fe98            movem.l    -360(a1),d2-d7/a3-a6
[00013f48] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f4c] 4ce9 78fc fe70            movem.l    -400(a1),d2-d7/a3-a6
[00013f52] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f56] 4ce9 78fc fe48            movem.l    -440(a1),d2-d7/a3-a6
[00013f5c] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f60] 4ce9 78fc fe20            movem.l    -480(a1),d2-d7/a3-a6
[00013f66] 48e0 3f1e                 movem.l    d2-d7/a3-a6,-(a0)
[00013f6a] 4ce9 18fc fe00            movem.l    -512(a1),d2-d7/a3-a4
[00013f70] 48e0 3f18                 movem.l    d2-d7/a3-a4,-(a0)
[00013f74] 92fc 0200                 suba.w     #$0200,a1
[00013f78] 5381                      subq.l     #1,d1
[00013f7a] 6600 ff76                 bne        memcpy_9
[00013f7e] 4cdf 78fc                 movem.l    (a7)+,d2-d7/a3-a6
memcpy_8:
[00013f82] 3200                      move.w     d0,d1
[00013f84] c07c 01ff                 and.w      #$01FF,d0
[00013f88] e448                      lsr.w      #2,d0
[00013f8a] 6708                      beq.s      memcpy_10
[00013f8c] 5340                      subq.w     #1,d0
memcpy_11:
[00013f8e] 2121                      move.l     -(a1),-(a0)
[00013f90] 51c8 fffc                 dbf        d0,memcpy_11
memcpy_10:
[00013f94] c27c 0003                 and.w      #$0003,d1
[00013f98] 6700 00f0                 beq        memcpy_3
[00013f9c] 5341                      subq.w     #1,d1
memcpy_12:
[00013f9e] 1121                      move.b     -(a1),-(a0)
[00013fa0] 51c9 fffc                 dbf        d1,memcpy_12
[00013fa4] 6000 00e4                 bra        memcpy_3
memcpy_2:
[00013fa8] 3209                      move.w     a1,d1
[00013faa] 3408                      move.w     a0,d2
[00013fac] 0801 0000                 btst       #0,d1
[00013fb0] 6710                      beq.s      memcpy_13
[00013fb2] 0802 0000                 btst       #0,d2
[00013fb6] 6612                      bne.s      memcpy_14
memcpy_15:
[00013fb8] 10d9                      move.b     (a1)+,(a0)+
[00013fba] 5380                      subq.l     #1,d0
[00013fbc] 66fa                      bne.s      memcpy_15
[00013fbe] 6000 00ca                 bra        memcpy_3
memcpy_13:
[00013fc2] 0802 0000                 btst       #0,d2
[00013fc6] 66f0                      bne.s      memcpy_15
[00013fc8] 6004                      bra.s      memcpy_16
memcpy_14:
[00013fca] 10d9                      move.b     (a1)+,(a0)+
[00013fcc] 5380                      subq.l     #1,d0
memcpy_16:
[00013fce] 2200                      move.l     d0,d1
[00013fd0] ea89                      lsr.l      #5,d1
[00013fd2] e889                      lsr.l      #4,d1
[00013fd4] 6700 0094                 beq        memcpy_17
[00013fd8] 48e7 3f1e                 movem.l    d2-d7/a3-a6,-(a7)
memcpy_18:
[00013fdc] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00013fe0] 48d0 78fc                 movem.l    d2-d7/a3-a6,(a0)
[00013fe4] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00013fe8] 48e8 78fc 0028            movem.l    d2-d7/a3-a6,40(a0)
[00013fee] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00013ff2] 48e8 78fc 0050            movem.l    d2-d7/a3-a6,80(a0)
[00013ff8] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00013ffc] 48e8 78fc 0078            movem.l    d2-d7/a3-a6,120(a0)
[00014002] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00014006] 48e8 78fc 00a0            movem.l    d2-d7/a3-a6,160(a0)
[0001400c] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00014010] 48e8 78fc 00c8            movem.l    d2-d7/a3-a6,200(a0)
[00014016] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[0001401a] 48e8 78fc 00f0            movem.l    d2-d7/a3-a6,240(a0)
[00014020] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00014024] 48e8 78fc 0118            movem.l    d2-d7/a3-a6,280(a0)
[0001402a] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[0001402e] 48e8 78fc 0140            movem.l    d2-d7/a3-a6,320(a0)
[00014034] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00014038] 48e8 78fc 0168            movem.l    d2-d7/a3-a6,360(a0)
[0001403e] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[00014042] 48e8 78fc 0190            movem.l    d2-d7/a3-a6,400(a0)
[00014048] 4cd9 78fc                 movem.l    (a1)+,d2-d7/a3-a6
[0001404c] 48e8 78fc 01b8            movem.l    d2-d7/a3-a6,440(a0)
[00014052] 4cd9 18fc                 movem.l    (a1)+,d2-d7/a3-a4
[00014056] 48e8 18fc 01e0            movem.l    d2-d7/a3-a4,480(a0)
[0001405c] d0fc 0200                 adda.w     #$0200,a0
[00014060] 5381                      subq.l     #1,d1
[00014062] 6600 ff78                 bne        memcpy_18
[00014066] 4cdf 78fc                 movem.l    (a7)+,d2-d7/a3-a6
memcpy_17:
[0001406a] 3200                      move.w     d0,d1
[0001406c] c07c 01ff                 and.w      #$01FF,d0
[00014070] e448                      lsr.w      #2,d0
[00014072] 6708                      beq.s      memcpy_19
[00014074] 5340                      subq.w     #1,d0
memcpy_20:
[00014076] 20d9                      move.l     (a1)+,(a0)+
[00014078] 51c8 fffc                 dbf        d0,memcpy_20
memcpy_19:
[0001407c] c27c 0003                 and.w      #$0003,d1
[00014080] 6708                      beq.s      memcpy_3
[00014082] 5341                      subq.w     #1,d1
memcpy_21:
[00014084] 10d9                      move.b     (a1)+,(a0)+
[00014086] 51c9 fffc                 dbf        d1,memcpy_21
memcpy_3:
[0001408a] 205f                      movea.l    (a7)+,a0
memcpy_1:
[0001408c] 4e75                      rts

memset:
[0001408e] 2f08                      move.l     a0,-(a7)
[00014090] d1c1                      adda.l     d1,a0
[00014092] 2408                      move.l     a0,d2
[00014094] 0802 0000                 btst       #0,d2
[00014098] 6708                      beq.s      memset_1
[0001409a] 5381                      subq.l     #1,d1
[0001409c] 6500 00ac                 bcs        memset_2
[000140a0] 1100                      move.b     d0,-(a0)
memset_1:
[000140a2] 1f00                      move.b     d0,-(a7)
[000140a4] 341f                      move.w     (a7)+,d2
[000140a6] 1400                      move.b     d0,d2
[000140a8] 3002                      move.w     d2,d0
[000140aa] 4842                      swap       d2
[000140ac] 3400                      move.w     d0,d2
[000140ae] 2001                      move.l     d1,d0
[000140b0] e088                      lsr.l      #8,d0
[000140b2] e488                      lsr.l      #2,d0
[000140b4] 6778                      beq.s      memset_3
[000140b6] 48e7 5f3e                 movem.l    d1/d3-d7/a2-a6,-(a7)
[000140ba] 2202                      move.l     d2,d1
[000140bc] 2602                      move.l     d2,d3
[000140be] 2802                      move.l     d2,d4
[000140c0] 2a02                      move.l     d2,d5
[000140c2] 2c02                      move.l     d2,d6
[000140c4] 2e02                      move.l     d2,d7
[000140c6] 2242                      movea.l    d2,a1
[000140c8] 2442                      movea.l    d2,a2
[000140ca] 2642                      movea.l    d2,a3
[000140cc] 2842                      movea.l    d2,a4
[000140ce] 2a42                      movea.l    d2,a5
[000140d0] 2c42                      movea.l    d2,a6
memset_4:
[000140d2] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140d6] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140da] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140de] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140e2] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140e6] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140ea] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140ee] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140f2] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140f6] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140fa] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[000140fe] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[00014102] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[00014106] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[0001410a] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[0001410e] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[00014112] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[00014116] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[0001411a] 48e0 7f7e                 movem.l    d1-d7/a1-a6,-(a0)
[0001411e] 48e0 7f60                 movem.l    d1-d7/a1-a2,-(a0)
[00014122] 5380                      subq.l     #1,d0
[00014124] 66ac                      bne.s      memset_4
[00014126] 4cdf 7cfa                 movem.l    (a7)+,d1/d3-d7/a2-a6
[0001412a] c27c 03ff                 and.w      #$03FF,d1
memset_3:
[0001412e] 3001                      move.w     d1,d0
[00014130] e448                      lsr.w      #2,d0
[00014132] 6708                      beq.s      memset_5
[00014134] 5340                      subq.w     #1,d0
memset_6:
[00014136] 2102                      move.l     d2,-(a0)
[00014138] 51c8 fffc                 dbf        d0,memset_6
memset_5:
[0001413c] c27c 0003                 and.w      #$0003,d1
[00014140] 6708                      beq.s      memset_2
[00014142] 5341                      subq.w     #1,d1
memset_7:
[00014144] 1102                      move.b     d2,-(a0)
[00014146] 51c9 fffc                 dbf        d1,memset_7
memset_2:
[0001414a] 205f                      movea.l    (a7)+,a0
[0001414c] 4e75                      rts

toupper:
[0001414e] 4241                      clr.w      d1
[00014150] 1200                      move.b     d0,d1
[00014152] 41fa 0008                 lea.l      _UpcTab(pc),a0
[00014156] 1030 1000                 move.b     0(a0,d1.w),d0
[0001415a] 4e75                      rts

_UpcTab:
[0001415c] 0001 0203                 ori.b      #$03,d1
[00014160] 0405 0607                 subi.b     #$07,d5
[00014164] 0809 0a0b                 btst       #2571,a1
[00014168] 0c0d 0e0f                 cmpi.b     #$0F,a5 ; apollo only
[0001416c] 1011                      move.b     (a1),d0
[0001416e] 1213                      move.b     (a3),d1
[00014170] 1415                      move.b     (a5),d2
[00014172] 1617                      move.b     (a7),d3
[00014174] 1819                      move.b     (a1)+,d4
[00014176] 1a1b                      move.b     (a3)+,d5
[00014178] 1c1d                      move.b     (a5)+,d6
[0001417a] 1e1f                      move.b     (a7)+,d7
[0001417c] 2021                      move.l     -(a1),d0
[0001417e] 2223                      move.l     -(a3),d1
[00014180] 2425                      move.l     -(a5),d2
[00014182] 2627                      move.l     -(a7),d3
[00014184] 2829 2a2b                 move.l     10795(a1),d4
[00014188] 2c2d 2e2f                 move.l     11823(a5),d6
[0001418c] 3031 3233                 move.w     51(a1,d3.w*2),d0 ; 68020+ only
[00014190] 3435 3637                 move.w     55(a5,d3.w*8),d2 ; 68020+ only
[00014194] 3839 3a3b 3c3d            move.w     $3A3B3C3D,d4
[0001419a] 3e3f                      move.w     ???,d7
[0001419c] 4041                      negx.w     d1
[0001419e] 4243                      clr.w      d3
[000141a0] 4445                      neg.w      d5
[000141a2] 4647                      not.w      d7
[000141a4] 4849                      bkpt       #1
[000141a6] 4a4b                      tst.w      a3 ; 68020+ only
[000141a8] 4c4d 4e4f                 divs.l     a5,a7:d4 ; apollo only
[000141ac] 5051                      addq.w     #8,(a1)
[000141ae] 5253                      addq.w     #1,(a3)
[000141b0] 5455                      addq.w     #2,(a5)
[000141b2] 5657                      addq.w     #3,(a7)
[000141b4] 5859                      addq.w     #4,(a1)+
[000141b6] 5a5b                      addq.w     #5,(a3)+
[000141b8] 5c5d                      addq.w     #6,(a5)+
[000141ba] 5e5f                      addq.w     #7,(a7)+
[000141bc] 6041                      bra.s      _UpcTab_1 ; ; branch to odd address
[000141be] 4243                      clr.w      d3
[000141c0] 4445                      neg.w      d5
[000141c2] 4647                      not.w      d7
[000141c4] 4849                      bkpt       #1
[000141c6] 4a4b                      tst.w      a3 ; 68020+ only
[000141c8] 4c4d 4e4f                 divs.l     a5,a7:d4 ; apollo only
[000141cc] 5051                      addq.w     #8,(a1)
[000141ce] 5253                      addq.w     #1,(a3)
[000141d0] 5455                      addq.w     #2,(a5)
[000141d2] 5657                      addq.w     #3,(a7)
[000141d4] 5859                      addq.w     #4,(a1)+
[000141d6] 5a7b 7c7d                 addq.w     #5,$00014255(pc,d7.l*4) ; 68020+ only
[000141da] 7e7f                      moveq.l    #127,d7
[000141dc] 8081                      or.l       d1,d0
[000141de] 8283                      or.l       d3,d1
[000141e0] 8485                      or.l       d5,d2
[000141e2] 8687                      or.l       d7,d3
[000141e4] 8889                      or.l       a1,d4 ; apollo only
[000141e6] 8a8b                      or.l       a3,d5 ; apollo only
[000141e8] 8c8d                      or.l       a5,d6 ; apollo only
[000141ea] 8e8f                      or.l       a7,d7 ; apollo only
[000141ec] 9091                      sub.l      (a1),d0
[000141ee] 9293                      sub.l      (a3),d1
[000141f0] 9495                      sub.l      (a5),d2
[000141f2] 9697                      sub.l      (a7),d3
[000141f4] 9899                      sub.l      (a1)+,d4
[000141f6] 9a9b                      sub.l      (a3)+,d5
[000141f8] 9c9d                      sub.l      (a5)+,d6
[000141fa] 9e9f                      sub.l      (a7)+,d7
[000141fc] a0a1                      ALINE      #$00A1
[000141fe] a2a3                      ALINE      #$02A3
_UpcTab_1:
[00014200] a4a5                      ALINE      #$04A5
[00014202] a6a7                      ALINE      #$06A7
[00014204] a8a9                      ALINE      #$08A9
[00014206] aaab                      ALINE      #$0AAB
[00014208] acad                      ALINE      #$0CAD
[0001420a] aeaf                      ALINE      #$0EAF
[0001420c] b0b1 b2b3                 cmp.l      -77(a1,a3.w*2),d0 ; 68020+ only
[00014210] b4b5 b6b7                 cmp.l      -73(a5,a3.w*8),d2 ; 68020+ only
[00014214] b8b9 babb bcbd            cmp.l      $BABBBCBD,d4
[0001421a] bebf                      cmp.l      ???,d7
[0001421c] c0c1                      mulu.w     d1,d0
[0001421e] c2c3                      mulu.w     d3,d1
[00014220] c4c5                      mulu.w     d5,d2
[00014222] c6c7                      mulu.w     d7,d3
[00014224] c8c9                      mulu.w     a1,d4
[00014226] cacb                      mulu.w     a3,d5
[00014228] cccd                      mulu.w     a5,d6
[0001422a] cecf                      mulu.w     a7,d7
[0001422c] d0d1                      adda.w     (a1),a0
[0001422e] d2d3                      adda.w     (a3),a1
[00014230] d4d5                      adda.w     (a5),a2
[00014232] d6d7                      adda.w     (a7),a3
[00014234] d8d9                      adda.w     (a1)+,a4
[00014236] dadb                      adda.w     (a3)+,a5
[00014238] dcdd                      adda.w     (a5)+,a6
[0001423a] dedf                      adda.w     (a7)+,a7
[0001423c] e0e1                      asr.w      -(a1)
[0001423e] e2e3                      lsr.w      -(a3)
[00014240] e4e5                      roxr.w     -(a5)
[00014242] e6e7                      ror.w      -(a7)
[00014244] e8e9 eaeb eced            bftst      -4883(a1){d?:d?} ; 68020+ only
[0001424a] eeef f0f1 f2f3            bfset      -3341(a7){3:d?} ; 68020+ only
[00014250] f4f5                      cpushp     bc,(a5)
[00014252] f6f7                      dc.w       $F6F7 ; illegal
[00014254] f8f9 fafb fcfd            lpB??.l    _UpcTab_2
[0001425a] feff 4040 4040 4040       vperm      #$40404040,d0,e12,e8
[00014262] 4040                      negx.w     d0
[00014264] 40c0                      move.w     sr,d0
[00014266] c0c0                      mulu.w     d0,d0
[00014268] c0c0                      mulu.w     d0,d0
[0001426a] 4040                      negx.w     d0
[0001426c] 4040                      negx.w     d0
[0001426e] 4040                      negx.w     d0
[00014270] 4040                      negx.w     d0
[00014272] 4040                      negx.w     d0
[00014274] 4040                      negx.w     d0
[00014276] 4040                      negx.w     d0
[00014278] 4040                      negx.w     d0
[0001427a] 4040                      negx.w     d0
[0001427c] 8001                      or.b       d1,d0
[0001427e] 0101                      btst       d0,d1
[00014280] 0101                      btst       d0,d1
[00014282] 0101                      btst       d0,d1
[00014284] 0101                      btst       d0,d1
[00014286] 0101                      btst       d0,d1
[00014288] 0101                      btst       d0,d1
[0001428a] 0101                      btst       d0,d1
[0001428c] 1212                      move.b     (a2),d1
[0001428e] 1212                      move.b     (a2),d1
[00014290] 1212                      move.b     (a2),d1
[00014292] 1212                      move.b     (a2),d1
[00014294] 1212                      move.b     (a2),d1
[00014296] 0101                      btst       d0,d1
[00014298] 0101                      btst       d0,d1
[0001429a] 0101                      btst       d0,d1
[0001429c] 003a 3a3a 3a3a            ori.b      #$3A,$00017CD8(pc) ; apollo only
[000142a2] 3a38 3838                 move.w     ($00003838).w,d5
[000142a6] 3838 3838                 move.w     ($00003838).w,d4
[000142aa] 3838 3838                 move.w     ($00003838).w,d4
[000142ae] 3838 3838                 move.w     ($00003838).w,d4
[000142b2] 3838 3838                 move.w     ($00003838).w,d4
[000142b6] 3801                      move.w     d1,d4
[000142b8] 0101                      btst       d0,d1
[000142ba] 0101                      btst       d0,d1
[000142bc] 0136 3636                 btst       d0,54(a6,d3.w*8) ; 68020+ only
[000142c0] 3636 3634                 move.w     52(a6,d3.w*8),d3 ; 68020+ only
[000142c4] 3434 3434                 move.w     52(a4,d3.w*4),d2 ; 68020+ only
[000142c8] 3434 3434                 move.w     52(a4,d3.w*4),d2 ; 68020+ only
[000142cc] 3434 3434                 move.w     52(a4,d3.w*4),d2 ; 68020+ only
[000142d0] 3434 3434                 move.w     52(a4,d3.w*4),d2 ; 68020+ only
[000142d4] 3434 3401                 move.w     1(a4,d3.w*4),d2 ; 68020+ only
[000142d8] 0101                      btst       d0,d1
[000142da] 0140                      bchg       d0,d0
[000142dc] 0804 0404                 btst       #1028,d4
[000142e0] 0404 0404                 subi.b     #$04,d4
[000142e4] 0404 0404                 subi.b     #$04,d4
[000142e8] 0404 0808                 subi.b     #$08,d4
[000142ec] 0804 0804                 btst       #2052,d4
[000142f0] 0404 0404                 subi.b     #$04,d4
[000142f4] 0404 0404                 subi.b     #$04,d4
[000142f8] 0804 0404                 btst       #1028,d4
[000142fc] 0404 0404                 subi.b     #$04,d4
[00014300] 0408 0400                 subi.b     #$00,a0 ; apollo only
[00014304] 0000                      dc.w       $0000
[00014306] 0000                      dc.w       $0000
[00014308] 0000                      dc.w       $0000
[0001430a] 0000 0404                 ori.b      #$04,d0
[0001430e] 0804 0408                 btst       #1032,d4
[00014312] 0808 0800                 btst       #2048,a0
[00014316] 0000                      dc.w       $0000
[00014318] 0000                      dc.w       $0000
[0001431a] 0000 0008                 ori.b      #$08,d0
[0001431e] 0000                      dc.w       $0000
[00014320] 0000                      dc.w       $0000
[00014322] 0000                      dc.w       $0000
[00014324] 0000                      dc.w       $0000
[00014326] 0000                      dc.w       $0000
[00014328] 0000                      dc.w       $0000
[0001432a] 0000                      dc.w       $0000
[0001432c] 0000                      dc.w       $0000
[0001432e] 0000                      dc.w       $0000
[00014330] 0000                      dc.w       $0000
[00014332] 0000                      dc.w       $0000
[00014334] 0000                      dc.w       $0000
[00014336] 0000                      dc.w       $0000
[00014338] 0000                      dc.w       $0000
[0001433a] 0000                      dc.w       $0000
[0001433c] 0000                      dc.w       $0000
[0001433e] 0000                      dc.w       $0000
[00014340] 0000                      dc.w       $0000
[00014342] 0000                      dc.w       $0000
[00014344] 0000                      dc.w       $0000
[00014346] 0000                      dc.w       $0000
[00014348] 0000                      dc.w       $0000
[0001434a] 0000                      dc.w       $0000
[0001434c] 0000                      dc.w       $0000
[0001434e] 0000                      dc.w       $0000
[00014350] 0000                      dc.w       $0000
[00014352] 0000                      dc.w       $0000
[00014354] 0000                      dc.w       $0000
[00014356] 0000                      dc.w       $0000
[00014358] 0000                      dc.w       $0000
[0001435a] 0000                      dc.w       $0000
_UpcTab_2: ; not found: fafd3f53

_DigCnvT:
[0001435c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014364] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001436c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014374] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001437c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014384] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001438c] 0001 0203                 ori.b      #$03,d1
[00014390] 0405 0607                 subi.b     #$07,d5
[00014394] 0809 ffff                 btst       #-1,a1
[00014398] ffff ffff ff0a 0b0c       vperm      #$FF0A0B0C,e23,e23,e23
[000143a0] 0d0e 0f10                 movep.w    3856(a6),d6
[000143a4] 1112                      move.b     (a2),-(a0)
[000143a6] 1314                      move.b     (a4),-(a1)
[000143a8] 1516                      move.b     (a6),-(a2)
[000143aa] 1718                      move.b     (a0)+,-(a3)
[000143ac] 191a                      move.b     (a2)+,-(a4)
[000143ae] 1b1c                      move.b     (a4)+,-(a5)
[000143b0] 1d1e                      move.b     (a6)+,-(a6)
[000143b2] 1f20                      move.b     -(a0),-(a7)
[000143b4] 2122                      move.l     -(a2),-(a0)
[000143b6] 23ff ffff ffff            move.l     ???,$FFFFFFFF
[000143bc] ff0a 0b0c                 pavgb.q    e18,d0,e3
[000143c0] 0d0e 0f10                 movep.w    3856(a6),d6
[000143c4] 1112                      move.b     (a2),-(a0)
[000143c6] 1314                      move.b     (a4),-(a1)
[000143c8] 1516                      move.b     (a6),-(a2)
[000143ca] 1718                      move.b     (a0)+,-(a3)
[000143cc] 191a                      move.b     (a2)+,-(a4)
[000143ce] 1b1c                      move.b     (a4)+,-(a5)
[000143d0] 1d1e                      move.b     (a6)+,-(a6)
[000143d2] 1f20                      move.b     -(a0),-(a7)
[000143d4] 2122                      move.l     -(a2),-(a0)
[000143d6] 23ff ffff ffff            move.l     ???,$FFFFFFFF
[000143dc] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[000143e4] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[000143ec] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[000143f4] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[000143fc] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014404] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001440c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014414] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001441c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014424] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001442c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014434] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001443c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014444] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[0001444c] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23
[00014454] ffff ffff ffff ffff       vperm      #$FFFFFFFF,e23,e23,e23

_ulmul:
[0001445c] 2400                      move.l     d0,d2
[0001445e] 4842                      swap       d2
[00014460] 4a42                      tst.w      d2
[00014462] 6616                      bne.s      _ulmul_1
[00014464] 2401                      move.l     d1,d2
[00014466] 4842                      swap       d2
[00014468] 4a42                      tst.w      d2
[0001446a] 6604                      bne.s      _ulmul_2
[0001446c] c0c1                      mulu.w     d1,d0
[0001446e] 4e75                      rts
_ulmul_2:
[00014470] c4c0                      mulu.w     d0,d2
[00014472] 4842                      swap       d2
[00014474] c0c1                      mulu.w     d1,d0
[00014476] d082                      add.l      d2,d0
[00014478] 4e75                      rts
_ulmul_1:
[0001447a] c4c1                      mulu.w     d1,d2
[0001447c] 4842                      swap       d2
[0001447e] c0c1                      mulu.w     d1,d0
[00014480] d082                      add.l      d2,d0
[00014482] 4e75                      rts

_uldiv:
[00014484] 2401                      move.l     d1,d2
[00014486] 4842                      swap       d2
[00014488] 4a42                      tst.w      d2
[0001448a] 6628                      bne.s      _uldiv_1
[0001448c] 2400                      move.l     d0,d2
[0001448e] 4842                      swap       d2
[00014490] 4a42                      tst.w      d2
[00014492] 660a                      bne.s      _uldiv_2
[00014494] 80c1                      divu.w     d1,d0
[00014496] 4840                      swap       d0
[00014498] 4240                      clr.w      d0
[0001449a] 4840                      swap       d0
[0001449c] 4e75                      rts
_uldiv_2:
[0001449e] 4240                      clr.w      d0
[000144a0] 4840                      swap       d0
[000144a2] 4842                      swap       d2
[000144a4] 80c1                      divu.w     d1,d0
[000144a6] 3040                      movea.w    d0,a0
[000144a8] 3002                      move.w     d2,d0
[000144aa] 80c1                      divu.w     d1,d0
[000144ac] 4840                      swap       d0
[000144ae] 3008                      move.w     a0,d0
[000144b0] 4840                      swap       d0
[000144b2] 4e75                      rts
_uldiv_1:
[000144b4] 2041                      movea.l    d1,a0
[000144b6] 4840                      swap       d0
[000144b8] 7200                      moveq.l    #0,d1
[000144ba] 3200                      move.w     d0,d1
[000144bc] 4240                      clr.w      d0
[000144be] 740f                      moveq.l    #15,d2
[000144c0] d080                      add.l      d0,d0
[000144c2] d381                      addx.l     d1,d1
_uldiv_4:
[000144c4] 9288                      sub.l      a0,d1
[000144c6] 6402                      bcc.s      _uldiv_3
[000144c8] d288                      add.l      a0,d1
_uldiv_3:
[000144ca] d180                      addx.l     d0,d0
[000144cc] d381                      addx.l     d1,d1
[000144ce] 51ca fff4                 dbf        d2,_uldiv_4
[000144d2] 4640                      not.w      d0
[000144d4] 4e75                      rts

_lmul:
[000144d6] 2400                      move.l     d0,d2
[000144d8] 6a02                      bpl.s      _lmul_1
[000144da] 4480                      neg.l      d0
_lmul_1:
[000144dc] b382                      eor.l      d1,d2
[000144de] 2042                      movea.l    d2,a0
[000144e0] 4a81                      tst.l      d1
[000144e2] 6a02                      bpl.s      _lmul_2
[000144e4] 4481                      neg.l      d1
_lmul_2:
[000144e6] 2400                      move.l     d0,d2
[000144e8] 4842                      swap       d2
[000144ea] 4a42                      tst.w      d2
[000144ec] 6622                      bne.s      _lmul_3
[000144ee] 2401                      move.l     d1,d2
[000144f0] 4842                      swap       d2
[000144f2] 4a42                      tst.w      d2
[000144f4] 660a                      bne.s      _lmul_4
[000144f6] c0c1                      mulu.w     d1,d0
[000144f8] 2408                      move.l     a0,d2
[000144fa] 6a02                      bpl.s      _lmul_5
[000144fc] 4480                      neg.l      d0
_lmul_5:
[000144fe] 4e75                      rts
_lmul_4:
[00014500] c4c0                      mulu.w     d0,d2
[00014502] 4842                      swap       d2
[00014504] c0c1                      mulu.w     d1,d0
[00014506] d082                      add.l      d2,d0
[00014508] 2408                      move.l     a0,d2
[0001450a] 6a02                      bpl.s      _lmul_6
[0001450c] 4480                      neg.l      d0
_lmul_6:
[0001450e] 4e75                      rts
_lmul_3:
[00014510] c4c1                      mulu.w     d1,d2
[00014512] 4842                      swap       d2
[00014514] c0c1                      mulu.w     d1,d0
[00014516] d082                      add.l      d2,d0
[00014518] 2408                      move.l     a0,d2
[0001451a] 6a02                      bpl.s      _lmul_7
[0001451c] 4480                      neg.l      d0
_lmul_7:
[0001451e] 4e75                      rts

_ldiv:
[00014520] 2400                      move.l     d0,d2
[00014522] 6a02                      bpl.s      _ldiv_1
[00014524] 4480                      neg.l      d0
_ldiv_1:
[00014526] b382                      eor.l      d1,d2
[00014528] 2242                      movea.l    d2,a1
[0001452a] 4a81                      tst.l      d1
[0001452c] 6a02                      bpl.s      _ldiv_2
[0001452e] 4481                      neg.l      d1
_ldiv_2:
[00014530] 2401                      move.l     d1,d2
[00014532] 4842                      swap       d2
[00014534] 4a42                      tst.w      d2
[00014536] 6634                      bne.s      _ldiv_3
[00014538] 2400                      move.l     d0,d2
[0001453a] 4842                      swap       d2
[0001453c] 4a42                      tst.w      d2
[0001453e] 6610                      bne.s      _ldiv_4
[00014540] 80c1                      divu.w     d1,d0
[00014542] 4840                      swap       d0
[00014544] 4240                      clr.w      d0
[00014546] 4840                      swap       d0
[00014548] 2409                      move.l     a1,d2
[0001454a] 6a02                      bpl.s      _ldiv_5
[0001454c] 4480                      neg.l      d0
_ldiv_5:
[0001454e] 4e75                      rts
_ldiv_4:
[00014550] 4240                      clr.w      d0
[00014552] 4840                      swap       d0
[00014554] 4842                      swap       d2
[00014556] 80c1                      divu.w     d1,d0
[00014558] 3040                      movea.w    d0,a0
[0001455a] 3002                      move.w     d2,d0
[0001455c] 80c1                      divu.w     d1,d0
[0001455e] 4840                      swap       d0
[00014560] 3008                      move.w     a0,d0
[00014562] 4840                      swap       d0
[00014564] 2409                      move.l     a1,d2
[00014566] 6a02                      bpl.s      _ldiv_6
[00014568] 4480                      neg.l      d0
_ldiv_6:
[0001456a] 4e75                      rts
_ldiv_3:
[0001456c] 2041                      movea.l    d1,a0
[0001456e] 4840                      swap       d0
[00014570] 7200                      moveq.l    #0,d1
[00014572] 3200                      move.w     d0,d1
[00014574] 4240                      clr.w      d0
[00014576] 740f                      moveq.l    #15,d2
[00014578] d080                      add.l      d0,d0
[0001457a] d381                      addx.l     d1,d1
_ldiv_8:
[0001457c] 9288                      sub.l      a0,d1
[0001457e] 6402                      bcc.s      _ldiv_7
[00014580] d288                      add.l      a0,d1
_ldiv_7:
[00014582] d180                      addx.l     d0,d0
[00014584] d381                      addx.l     d1,d1
[00014586] 51ca fff4                 dbf        d2,_ldiv_8
[0001458a] 4640                      not.w      d0
[0001458c] 2409                      move.l     a1,d2
[0001458e] 6a02                      bpl.s      _ldiv_9
[00014590] 4480                      neg.l      d0
_ldiv_9:
[00014592] 4e75                      rts

_lmod:
[00014594] 2240                      movea.l    d0,a1
[00014596] 2400                      move.l     d0,d2
[00014598] 6a02                      bpl.s      _lmod_1
[0001459a] 4480                      neg.l      d0
_lmod_1:
[0001459c] 4a81                      tst.l      d1
[0001459e] 6a02                      bpl.s      _lmod_2
[000145a0] 4481                      neg.l      d1
_lmod_2:
[000145a2] 2401                      move.l     d1,d2
[000145a4] 4842                      swap       d2
[000145a6] 4a42                      tst.w      d2
[000145a8] 662e                      bne.s      _lmod_3
[000145aa] 2400                      move.l     d0,d2
[000145ac] 4842                      swap       d2
[000145ae] 4a42                      tst.w      d2
[000145b0] 660e                      bne.s      _lmod_4
[000145b2] 80c1                      divu.w     d1,d0
[000145b4] 4240                      clr.w      d0
[000145b6] 4840                      swap       d0
[000145b8] 2409                      move.l     a1,d2
[000145ba] 6a02                      bpl.s      _lmod_5
[000145bc] 4480                      neg.l      d0
_lmod_5:
[000145be] 4e75                      rts
_lmod_4:
[000145c0] 4240                      clr.w      d0
[000145c2] 4840                      swap       d0
[000145c4] 4842                      swap       d2
[000145c6] 80c1                      divu.w     d1,d0
[000145c8] 3002                      move.w     d2,d0
[000145ca] 80c1                      divu.w     d1,d0
[000145cc] 4240                      clr.w      d0
[000145ce] 4840                      swap       d0
[000145d0] 2409                      move.l     a1,d2
[000145d2] 6a02                      bpl.s      _lmod_6
[000145d4] 4480                      neg.l      d0
_lmod_6:
[000145d6] 4e75                      rts
_lmod_3:
[000145d8] 2041                      movea.l    d1,a0
[000145da] 2200                      move.l     d0,d1
[000145dc] 4240                      clr.w      d0
[000145de] 4840                      swap       d0
[000145e0] 4841                      swap       d1
[000145e2] 4241                      clr.w      d1
[000145e4] 740f                      moveq.l    #15,d2
[000145e6] d281                      add.l      d1,d1
[000145e8] d180                      addx.l     d0,d0
_lmod_8:
[000145ea] 9088                      sub.l      a0,d0
[000145ec] 6402                      bcc.s      _lmod_7
[000145ee] d088                      add.l      a0,d0
_lmod_7:
[000145f0] d381                      addx.l     d1,d1
[000145f2] d180                      addx.l     d0,d0
[000145f4] 51ca fff4                 dbf        d2,_lmod_8
[000145f8] e290                      roxr.l     #1,d0
[000145fa] 2409                      move.l     a1,d2
[000145fc] 6a02                      bpl.s      _lmod_9
[000145fe] 4480                      neg.l      d0
_lmod_9:
[00014600] 4e75                      rts

getch:
[00014602] 3039 0001 66ae            move.w     $000166AE,d0
[00014608] 6618                      bne.s      getch_1
[0001460a] 2f0a                      move.l     a2,-(a7)
[0001460c] 3f3c 0008                 move.w     #$0008,-(a7) ; Cnecin
[00014610] 4e41                      trap       #1
[00014612] 544f                      addq.w     #2,a7
[00014614] 245f                      movea.l    (a7)+,a2
[00014616] 4a40                      tst.w      d0
[00014618] 6606                      bne.s      getch_2
[0001461a] 23c0 0001 66ae            move.l     d0,$000166AE
getch_2:
[00014620] 4e75                      rts
getch_1:
[00014622] 4279 0001 66ae            clr.w      $000166AE
[00014628] 4e75                      rts

getdate:
[0001462a] 2f0a                      move.l     a2,-(a7)
[0001462c] 2248                      movea.l    a0,a1
[0001462e] 3f3c 002a                 move.w     #$002A,-(a7) ; Tgetdate
[00014632] 4e41                      trap       #1
[00014634] 544f                      addq.w     #2,a7
[00014636] 3200                      move.w     d0,d1
[00014638] c03c 001f                 and.b      #$1F,d0
[0001463c] 1340 0002                 move.b     d0,2(a1)
[00014640] ea49                      lsr.w      #5,d1
[00014642] 3001                      move.w     d1,d0
[00014644] c03c 000f                 and.b      #$0F,d0
[00014648] 1340 0003                 move.b     d0,3(a1)
[0001464c] e849                      lsr.w      #4,d1
[0001464e] d27c 07bc                 add.w      #$07BC,d1
[00014652] 3281                      move.w     d1,(a1)
[00014654] 245f                      movea.l    (a7)+,a2
[00014656] 4e75                      rts

	.data
errno:
[00014658]                           dc.b $00
[00014659]                           dc.b $00
_AtExitVec:
[0001465a]                           dc.b $00
[0001465b]                           dc.b $00
[0001465c]                           dc.b $00
[0001465d]                           dc.b $00
_FilSysVec:
[0001465e]                           dc.b $00
[0001465f]                           dc.b $00
[00014660]                           dc.b $00
[00014661]                           dc.b $00
hc_inbuf_size:
[00014662]                           dc.b $00
[00014663]                           dc.b $00
[00014664]                           dc.w $4000
file_index:
[00014666]                           dc.b $00
[00014667]                           dc.b $04
generate_help:
[00014668]                           dc.b $00
[00014669]                           dc.b $01
options.create_log:
[0001466a]                           dc.b $00
[0001466b]                           dc.b $00
options.verbose:
[0001466c]                           dc.b $00
[0001466d]                           dc.b $00
options.x1466e:
[0001466e]                           dc.b $00
[0001466f]                           dc.b $00
options.break_make:
[00014670]                           dc.b $00
[00014671]                           dc.b $00
options.tabsize:
[00014672]                           dc.b $00
[00014673]                           dc.b $04
[00014674]                           dc.b $0a,'ready.',$0a,0
[0001467d]                           dc.b $0a,' Help Compiler                    (c) 1990 Borland Germany GmbH',$0a,$0a,0
[000146c0]                           dc.b 'usage: HC commandfile',$0a,$0a,'commandfile format:',$0a,$0a,$09,'-[options]',$0a,$09,'(path and) filename of help file',$0a,$09,'list of (paths and) filenames of the sources',$0a,$0a,$09,'options:',$0a,$09,'L',$09,$09,'create log file',$0a,$09,'N',$09,$09,'do not generate help file',$0a,$09,'V',$09,$09,'verbose message output',$0a,$09,'W',$09,$09,'break make on warnings',$0a,$09,'T=x',$09,'expand tabs to x blanks (0 < x <= 9, default: 4)',$0a,$0a,$0a,'note: use one line for the entire options and',$0a,'      separate lines for each filename,',$0a,'      comments start with a semicolon and',$0a,'      end at the end of line',$0a,0
[00014891]                           dc.b $72
[00014892]                           dc.b $00
[00014893]                           dc.b 'hc.$2$',0
[0001489a]                           dc.b 'hc.$3$',0
[000148a1]                           dc.b 'hc.$1$',0
[000148a8]                           dc.b $09,'scanning %s',$0a,$0a,0
[000148b7]                           dc.b $0a,$09,'creating index',$0a,0
[000148c9]                           dc.b $0a
[000148ca]                           dc.w $0900
[000148cc]                           dc.b '%d Error(s)',$09,0
[000148d9]                           dc.b '%d Warning(s)',0
[000148e7]                           dc.b $09,'pass 1:',$0a,0
[000148f1]                           dc.b $0a,$09,'pass 2:',$0a,0
[000148fc]                           dc.b $09,'doing references',$0a,$0a,0
[00014910]                           dc.b $0a,$09,'pass 3:',$0a,0
[0001491b]                           dc.b $09,'compressing',$0a,0
[00014929]                           dc.b $0a,$09,'pass 4:',$0a,0
[00014934]                           dc.b $09,'creating %s',$0a,0
err_filename:
[00014942]                           dc.b $00
[00014943]                           dc.b $00
[00014944]                           dc.b $00
[00014945]                           dc.b $00
[00014946]                           dc.b 'output file',0
[00014952]                           dc.w $7262
[00014954]                           dc.b $00
[00014955]                           dc.b $77
[00014956]                           dc.w $6200
[00014958]                           dc.b 'HC.LOG',0
[0001495f]                           dc.b $77
[00014960]                           dc.b $00
[00014961]                           dc.b $0a,' Help Compiler                                   (c) 1990 Borland Germany GmbH',$0a,$0a,'-------------------------------------------------------------------------------',$0a,$09,'log file for %s',$0a,$09,'date:        %d.%s %d',$0a,'-------------------------------------------------------------------------------',$0a,$0a,0
[00014a7c]                           dc.b $0a,$0a,'-------------------------------------------------------------------------------',$0a,$09,'total number of errors:   %ld',$0a,$09,'total number of warnings: %ld',$0a,'-------------------------------------------------------------------------------',$0a,0
[00014b5d]                           dc.b $00
errors_total:
[00014b5e]                           dc.b $00
[00014b5f]                           dc.b $00
[00014b60]                           dc.b $00
[00014b61]                           dc.b $00
warnings_total:
[00014b62]                           dc.b $00
[00014b63]                           dc.b $00
[00014b64]                           dc.b $00
[00014b65]                           dc.b $00
errmsg:
[00014b66] 00014bd2                  dc.l $00014bd2 ; no symbol found
[00014b6a] 00014bf2                  dc.l $00014bf2 ; no symbol found
[00014b6e] 00014c12                  dc.l $00014c12 ; no symbol found
[00014b72] 00014c33                  dc.l $00014c33 ; no symbol found
[00014b76] 00014c41                  dc.l $00014c41 ; no symbol found
[00014b7a] 00014c55                  dc.l $00014c55 ; no symbol found
[00014b7e] 00014c68                  dc.l $00014c68 ; no symbol found
[00014b82] 00014c8e                  dc.l $00014c8e ; no symbol found
[00014b86] 00014c9f                  dc.l $00014c9f ; no symbol found
[00014b8a] 00014cb1                  dc.l $00014cb1 ; no symbol found
[00014b8e] 00014cc8                  dc.l $00014cc8 ; no symbol found
[00014b92] 00014ce2                  dc.l $00014ce2 ; no symbol found
[00014b96] 00014cf8                  dc.l $00014cf8 ; no symbol found
[00014b9a] 00014d08                  dc.l $00014d08 ; no symbol found
[00014b9e] 00014d22                  dc.l $00014d22 ; no symbol found
[00014ba2] 00014d3c                  dc.l $00014d3c ; no symbol found
[00014ba6] 00014d50                  dc.l $00014d50 ; no symbol found
[00014baa] 00014d64                  dc.l $00014d64 ; no symbol found
[00014bae] 00014d84                  dc.l $00014d84 ; no symbol found
[00014bb2] 00014d9a                  dc.l $00014d9a ; no symbol found
[00014bb6] 00014db5                  dc.l $00014db5 ; no symbol found
[00014bba] 00014dd2                  dc.l $00014dd2 ; no symbol found
[00014bbe] 00014dee                  dc.l $00014dee ; no symbol found
[00014bc2] 00014e0b                  dc.l $00014e0b ; no symbol found
[00014bc6] 00014e1d                  dc.l $00014e1d ; no symbol found
[00014bca] 00014e31                  dc.l $00014e31 ; no symbol found
[00014bce] 00014e43                  dc.l $00014e43 ; no symbol found
[00014bd2]                           dc.b 'unable to open output file "%s"',0
[00014bf2]                           dc.b 'unable to open source file "%s"',0
[00014c12]                           dc.b 'unable to open project file "%s"',0
[00014c33]                           dc.b 'out of memory',0
[00014c41]                           dc.b 'write error on "%s"',0
[00014c55]                           dc.b 'read error on "%"s',0
[00014c68]                           dc.b 'too many source files in project "%s"',0
[00014c8e]                           dc.b 'too many screens',0
[00014c9f]                           dc.b 'unknown statement',0
[00014cb1]                           dc.b 'missing parameter list',0
[00014cc8]                           dc.b 'incomplete parameter list',0
[00014ce2]                           dc.b 'missing end of screen',0
[00014cf8]                           dc.b 'screen too long',0
[00014d08]                           dc.b 'wrong scope for statement',0
[00014d22]                           dc.b 'pending keyword delimiter',0
[00014d3c]                           dc.b 'can',$27,'t break keyword',0
[00014d50]                           dc.b 'wrong argument type',0
[00014d64]                           dc.b 'doubly defined screen name "%s"',0
[00014d84]                           dc.b 'pending end of string',0
[00014d9a]                           dc.b $27,'=',$27,' expected in -%c option',0
[00014db5]                           dc.b 'illegal option character: %c',0
[00014dd2]                           dc.b 'file index out of range: %c',0
[00014dee]                           dc.b 'use of illegal character: %d',0
[00014e0b]                           dc.b 'perenthesis error',0
[00014e1d]                           dc.b 'too many parameters',0
[00014e31]                           dc.b 'missing parameter',0
[00014e43]                           dc.b 'reference to unknown screen "%s"',0
[00014e64]                           dc.b 'Fatal: ',0
[00014e6c]                           dc.b 'Error ',0
[00014e73]                           dc.b 'Warning ',0
[00014e7c]                           dc.b '%s ',0
[00014e80]                           dc.b '%ld: ',0
[00014e86]                           dc.w $0a00
[00014e88]                           dc.b $09,'program aborted!',$0a,$0a,0
[00014e9c]                           dc.b 'hc.$1$',0
[00014ea3]                           dc.b 'hc.$2$',0
[00014eaa]                           dc.b 'hc.$3$',0
[00014eb1]                           dc.b $00
brace_level:
[00014eb2]                           dc.b $00
[00014eb3]                           dc.b $00
[00014eb4]                           dc.w $afaf
[00014eb6]                           dc.w $afaf
[00014eb8]                           dc.w $afaf
[00014eba]                           dc.w $af20
[00014ebc]                           dc.b '%s',$0a,0
[00014ec0]                           dc.w $afaf
[00014ec2]                           dc.w $afaf
[00014ec4]                           dc.w $afaf
[00014ec6]                           dc.w $af20
[00014ec8]                           dc.b 'do you want to continue, [y]es or [n]o ? ',0
character_class:
[00014ef2]                           dc.b $00
[00014ef3]                           dc.b $00
[00014ef4]                           dc.b $00
[00014ef5]                           dc.b $00
[00014ef6]                           dc.b $00
[00014ef7]                           dc.b $00
[00014ef8]                           dc.b $00
[00014ef9]                           dc.b $00
[00014efa]                           dc.b $00
[00014efb]                           dc.b $03
[00014efc]                           dc.w $0300
[00014efe]                           dc.b $00
[00014eff]                           dc.b $02
[00014f00]                           dc.b $00
[00014f01]                           dc.b $00
[00014f02]                           dc.b $00
[00014f03]                           dc.b $00
[00014f04]                           dc.b $00
[00014f05]                           dc.b $00
[00014f06]                           dc.b $00
[00014f07]                           dc.b $00
[00014f08]                           dc.b $00
[00014f09]                           dc.b $00
[00014f0a]                           dc.b $00
[00014f0b]                           dc.b $00
[00014f0c]                           dc.w $0400
[00014f0e]                           dc.b $00
[00014f0f]                           dc.b $00
[00014f10]                           dc.b $00
[00014f11]                           dc.b $00
[00014f12]                           dc.w $0300
[00014f14]                           dc.w $0506
[00014f16]                           dc.b $00
[00014f17]                           dc.b $00
[00014f18]                           dc.b $00
[00014f19]                           dc.b $00
[00014f1a]                           dc.w $1314
[00014f1c]                           dc.w $0708
[00014f1e]                           dc.w $090a
[00014f20]                           dc.b $00
[00014f21]                           dc.b $0b
[00014f22]                           dc.w $0c0c
[00014f24]                           dc.w $0c0c
[00014f26]                           dc.w $0c0c
[00014f28]                           dc.w $0c0c
[00014f2a]                           dc.w $0c0c
[00014f2c]                           dc.b $00
[00014f2d]                           dc.b $0e
[00014f2e]                           dc.b $00
[00014f2f]                           dc.b $0f
[00014f30]                           dc.b $00
[00014f31]                           dc.b $00
[00014f32]                           dc.b $00
[00014f33]                           dc.b $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,0
[00014f4e]                           dc.w $1200
[00014f50]                           dc.b $00
[00014f51]                           dc.b $0d
[00014f52]                           dc.b $00
[00014f53]                           dc.b $0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d,$0d
[00014f6d]                           dc.b $10
[00014f6e]                           dc.b $00
[00014f6f]                           dc.b $11
[00014f70]                           dc.b $00
[00014f71]                           dc.b $00
[00014f72]                           dc.b $00
[00014f73]                           dc.b $00
[00014f74]                           dc.b $00
[00014f75]                           dc.b $00
[00014f76]                           dc.b $00
[00014f77]                           dc.b $00
[00014f78]                           dc.b $00
[00014f79]                           dc.b $00
[00014f7a]                           dc.b $00
[00014f7b]                           dc.b $00
[00014f7c]                           dc.b $00
[00014f7d]                           dc.b $00
[00014f7e]                           dc.b $00
[00014f7f]                           dc.b $00
[00014f80]                           dc.b $00
[00014f81]                           dc.b $00
[00014f82]                           dc.b $00
[00014f83]                           dc.b $00
[00014f84]                           dc.b $00
[00014f85]                           dc.b $00
[00014f86]                           dc.b $00
[00014f87]                           dc.b $00
[00014f88]                           dc.b $00
[00014f89]                           dc.b $00
[00014f8a]                           dc.b $00
[00014f8b]                           dc.b $00
[00014f8c]                           dc.b $00
[00014f8d]                           dc.b $00
[00014f8e]                           dc.b $00
[00014f8f]                           dc.b $00
[00014f90]                           dc.b $00
[00014f91]                           dc.b $00
[00014f92]                           dc.b $00
[00014f93]                           dc.b $00
[00014f94]                           dc.b $00
[00014f95]                           dc.b $00
[00014f96]                           dc.b $00
[00014f97]                           dc.b $00
[00014f98]                           dc.b $00
[00014f99]                           dc.b $00
[00014f9a]                           dc.b $00
[00014f9b]                           dc.b $00
[00014f9c]                           dc.b $00
[00014f9d]                           dc.b $00
[00014f9e]                           dc.b $00
[00014f9f]                           dc.b $00
[00014fa0]                           dc.b $00
[00014fa1]                           dc.b $00
[00014fa2]                           dc.b $00
[00014fa3]                           dc.b $00
[00014fa4]                           dc.b $00
[00014fa5]                           dc.b $00
[00014fa6]                           dc.b $00
[00014fa7]                           dc.b $00
[00014fa8]                           dc.b $00
[00014fa9]                           dc.b $00
[00014faa]                           dc.b $00
[00014fab]                           dc.b $00
[00014fac]                           dc.b $00
[00014fad]                           dc.b $00
[00014fae]                           dc.b $00
[00014faf]                           dc.b $00
[00014fb0]                           dc.b $00
[00014fb1]                           dc.b $00
[00014fb2]                           dc.b $00
[00014fb3]                           dc.b $00
[00014fb4]                           dc.b $00
[00014fb5]                           dc.b $00
[00014fb6]                           dc.b $00
[00014fb7]                           dc.b $00
[00014fb8]                           dc.b $00
[00014fb9]                           dc.b $00
[00014fba]                           dc.b $00
[00014fbb]                           dc.b $00
[00014fbc]                           dc.b $00
[00014fbd]                           dc.b $00
[00014fbe]                           dc.b $00
[00014fbf]                           dc.b $00
[00014fc0]                           dc.b $00
[00014fc1]                           dc.b $00
[00014fc2]                           dc.b $00
[00014fc3]                           dc.b $00
[00014fc4]                           dc.b $00
[00014fc5]                           dc.b $00
[00014fc6]                           dc.b $00
[00014fc7]                           dc.b $00
[00014fc8]                           dc.b $00
[00014fc9]                           dc.b $00
[00014fca]                           dc.b $00
[00014fcb]                           dc.b $00
[00014fcc]                           dc.b $00
[00014fcd]                           dc.b $00
[00014fce]                           dc.b $00
[00014fcf]                           dc.b $00
[00014fd0]                           dc.b $00
[00014fd1]                           dc.b $00
[00014fd2]                           dc.b $00
[00014fd3]                           dc.b $00
[00014fd4]                           dc.b $00
[00014fd5]                           dc.b $00
[00014fd6]                           dc.b $00
[00014fd7]                           dc.b $00
[00014fd8]                           dc.b $00
[00014fd9]                           dc.b $00
[00014fda]                           dc.b $00
[00014fdb]                           dc.b $00
[00014fdc]                           dc.b $00
[00014fdd]                           dc.b $00
[00014fde]                           dc.b $00
[00014fdf]                           dc.b $00
[00014fe0]                           dc.b $00
[00014fe1]                           dc.b $00
[00014fe2]                           dc.b $00
[00014fe3]                           dc.b $00
[00014fe4]                           dc.b $00
[00014fe5]                           dc.b $00
[00014fe6]                           dc.b $00
[00014fe7]                           dc.b $00
[00014fe8]                           dc.b $00
[00014fe9]                           dc.b $00
[00014fea]                           dc.b $00
[00014feb]                           dc.b $00
[00014fec]                           dc.b $00
[00014fed]                           dc.b $00
[00014fee]                           dc.b $00
[00014fef]                           dc.b $00
[00014ff0]                           dc.b $00
[00014ff1]                           dc.b $00
keywords:
[00014ff2]                           dc.b $00
[00014ff3]                           dc.b $01
[00014ff4] 0001503a                  dc.l $0001503a ; no symbol found
[00014ff8]                           dc.b $00
[00014ff9]                           dc.b $02
[00014ffa] 00015041                  dc.l $00015041 ; no symbol found
[00014ffe]                           dc.b $00
[00014fff]                           dc.b $03
[00015000] 00015045                  dc.l $00015045 ; no symbol found
[00015004]                           dc.b $00
[00015005]                           dc.b $09
[00015006] 0001504b                  dc.l $0001504b ; no symbol found
[0001500a]                           dc.b $00
[0001500b]                           dc.b $0a
[0001500c] 00015050                  dc.l $00015050 ; no symbol found
[00015010]                           dc.b $00
[00015011]                           dc.b $0b
[00015012] 00015055                  dc.l $00015055 ; no symbol found
[00015016]                           dc.b $00
[00015017]                           dc.b $0c
[00015018] 00015058                  dc.l $00015058 ; no symbol found
[0001501c]                           dc.b $00
[0001501d]                           dc.b $0d
[0001501e] 00015062                  dc.l $00015062 ; no symbol found
[00015022]                           dc.b $00
[00015023]                           dc.b $0e
[00015024] 00015069                  dc.l $00015069 ; no symbol found
[00015028]                           dc.b $00
[00015029]                           dc.b $0f
[0001502a] 0001506d                  dc.l $0001506d ; no symbol found
[0001502e]                           dc.b $00
[0001502f]                           dc.b $00
[00015030]                           dc.b $00
[00015031]                           dc.b $00
[00015032]                           dc.b $00
[00015033]                           dc.b $00
in_screen:
[00015034]                           dc.b $00
[00015035]                           dc.b $00
backtok:
[00015036]                           dc.b $00
[00015037]                           dc.b $00
in_link:
[00015038]                           dc.b $00
[00015039]                           dc.b $00
[0001503a]                           dc.b 'screen',0
[00015041]                           dc.b 'end',0
[00015045]                           dc.b 'print',0
[0001504b]                           dc.b 'link',0
[00015050]                           dc.b 'wait',0
[00015055]                           dc.b 'capsensitive',0
[00015062]                           dc.b 'extern',0
[00015069]                           dc.b 'EOF',0
[0001506d]                           dc.b 'nop',0
[00015071]                           dc.b $00
screen_cnt:
[00015072]                           dc.b $00
[00015073]                           dc.b $00
last_indexentry_name:
[00015074]                           dc.b $00
[00015075]                           dc.b $00
[00015076]                           dc.b $00
[00015077]                           dc.b $00
screen_start:
[00015078]                           dc.b $00
[00015079]                           dc.b $00
[0001507a]                           dc.b $00
[0001507b]                           dc.b $00
namelist:
[0001507c]                           dc.b $00
[0001507d]                           dc.b $00
[0001507e]                           dc.b $00
[0001507f]                           dc.b $00
unused_15080:
[00015080]                           dc.b $00
[00015081]                           dc.b $00
[00015082]                           dc.b $00
[00015083]                           dc.b $00
[00015084]                           dc.b 'Help System Version 2.0 (c) 1990 Borland International, Inc.',$0d,$0a,$0d,$0a
[000150c4]                           dc.w $0c1a
[000150c6]                           dc.b $00
[000150c7]                           dc.b $00
[000150c8]                           dc.w $bd39
[000150ca]                           dc.b '0BH2.0',0
[000150d1]                           dc.b 'hc.$3$',0
[000150d8]                           dc.b 'hc.$2$',0
[000150df]                           dc.b 'rb+',0
[000150e3]                           dc.b 'temporary file',0
name_to_index:
[000150f2]                           dc.b $00
[000150f3]                           dc.b $1a
[000150f4]                           dc.b $00
[000150f5]                           dc.b $1a
[000150f6]                           dc.b $00
[000150f7]                           dc.b $1a
[000150f8]                           dc.b $00
[000150f9]                           dc.b $1a
[000150fa]                           dc.b $00
[000150fb]                           dc.b $1a
[000150fc]                           dc.b $00
[000150fd]                           dc.b $1a
[000150fe]                           dc.b $00
[000150ff]                           dc.b $1a
[00015100]                           dc.b $00
[00015101]                           dc.b $1a
[00015102]                           dc.b $00
[00015103]                           dc.b $1a
[00015104]                           dc.b $00
[00015105]                           dc.b $1a
[00015106]                           dc.b $00
[00015107]                           dc.b $1a
[00015108]                           dc.b $00
[00015109]                           dc.b $1a
[0001510a]                           dc.b $00
[0001510b]                           dc.b $1a
[0001510c]                           dc.b $00
[0001510d]                           dc.b $1a
[0001510e]                           dc.b $00
[0001510f]                           dc.b $1a
[00015110]                           dc.b $00
[00015111]                           dc.b $1a
[00015112]                           dc.b $00
[00015113]                           dc.b $1a
[00015114]                           dc.b $00
[00015115]                           dc.b $1a
[00015116]                           dc.b $00
[00015117]                           dc.b $1a
[00015118]                           dc.b $00
[00015119]                           dc.b $1a
[0001511a]                           dc.b $00
[0001511b]                           dc.b $1a
[0001511c]                           dc.b $00
[0001511d]                           dc.b $1a
[0001511e]                           dc.b $00
[0001511f]                           dc.b $1a
[00015120]                           dc.b $00
[00015121]                           dc.b $1a
[00015122]                           dc.b $00
[00015123]                           dc.b $1a
[00015124]                           dc.b $00
[00015125]                           dc.b $1a
[00015126]                           dc.b $00
[00015127]                           dc.b $1a
[00015128]                           dc.b $00
[00015129]                           dc.b $1a
[0001512a]                           dc.b $00
[0001512b]                           dc.b $1a
[0001512c]                           dc.b $00
[0001512d]                           dc.b $1a
[0001512e]                           dc.b $00
[0001512f]                           dc.b $1a
[00015130]                           dc.b $00
[00015131]                           dc.b $1a
[00015132]                           dc.b $00
[00015133]                           dc.b $1a
[00015134]                           dc.b $00
[00015135]                           dc.b $1a
[00015136]                           dc.b $00
[00015137]                           dc.b $1a
[00015138]                           dc.b $00
[00015139]                           dc.b $1a
[0001513a]                           dc.b $00
[0001513b]                           dc.b $1a
[0001513c]                           dc.b $00
[0001513d]                           dc.b $1a
[0001513e]                           dc.b $00
[0001513f]                           dc.b $1a
[00015140]                           dc.b $00
[00015141]                           dc.b $1a
[00015142]                           dc.b $00
[00015143]                           dc.b $1a
[00015144]                           dc.b $00
[00015145]                           dc.b $1a
[00015146]                           dc.b $00
[00015147]                           dc.b $1a
[00015148]                           dc.b $00
[00015149]                           dc.b $1a
[0001514a]                           dc.b $00
[0001514b]                           dc.b $1a
[0001514c]                           dc.b $00
[0001514d]                           dc.b $1a
[0001514e]                           dc.b $00
[0001514f]                           dc.b $1a
[00015150]                           dc.b $00
[00015151]                           dc.b $1a
[00015152]                           dc.b $00
[00015153]                           dc.b $1a
[00015154]                           dc.b $00
[00015155]                           dc.b $1a
[00015156]                           dc.b $00
[00015157]                           dc.b $1a
[00015158]                           dc.b $00
[00015159]                           dc.b $1a
[0001515a]                           dc.b $00
[0001515b]                           dc.b $1a
[0001515c]                           dc.b $00
[0001515d]                           dc.b $1a
[0001515e]                           dc.b $00
[0001515f]                           dc.b $1a
[00015160]                           dc.b $00
[00015161]                           dc.b $1a
[00015162]                           dc.b $00
[00015163]                           dc.b $1a
[00015164]                           dc.b $00
[00015165]                           dc.b $1a
[00015166]                           dc.b $00
[00015167]                           dc.b $1a
[00015168]                           dc.b $00
[00015169]                           dc.b $1a
[0001516a]                           dc.b $00
[0001516b]                           dc.b $1a
[0001516c]                           dc.b $00
[0001516d]                           dc.b $1a
[0001516e]                           dc.b $00
[0001516f]                           dc.b $1a
[00015170]                           dc.b $00
[00015171]                           dc.b $1a
[00015172]                           dc.b $00
[00015173]                           dc.b $1a
[00015174]                           dc.b $00
[00015175]                           dc.b $00
[00015176]                           dc.b $00
[00015177]                           dc.b $01
[00015178]                           dc.b $00
[00015179]                           dc.b $02
[0001517a]                           dc.b $00
[0001517b]                           dc.b $03
[0001517c]                           dc.b $00
[0001517d]                           dc.b $04
[0001517e]                           dc.b $00
[0001517f]                           dc.b $05
[00015180]                           dc.b $00
[00015181]                           dc.b $06
[00015182]                           dc.b $00
[00015183]                           dc.b $07
[00015184]                           dc.b $00
[00015185]                           dc.b $08
[00015186]                           dc.b $00
[00015187]                           dc.b $09
[00015188]                           dc.b $00
[00015189]                           dc.b $0a
[0001518a]                           dc.b $00
[0001518b]                           dc.b $0b
[0001518c]                           dc.b $00
[0001518d]                           dc.b $0c
[0001518e]                           dc.b $00
[0001518f]                           dc.b $0d
[00015190]                           dc.b $00
[00015191]                           dc.b $0e
[00015192]                           dc.b $00
[00015193]                           dc.b $0f
[00015194]                           dc.b $00
[00015195]                           dc.b $10
[00015196]                           dc.b $00
[00015197]                           dc.b $11
[00015198]                           dc.b $00
[00015199]                           dc.b $12
[0001519a]                           dc.b $00
[0001519b]                           dc.b $13
[0001519c]                           dc.b $00
[0001519d]                           dc.b $14
[0001519e]                           dc.b $00
[0001519f]                           dc.b $15
[000151a0]                           dc.b $00
[000151a1]                           dc.b $16
[000151a2]                           dc.b $00
[000151a3]                           dc.b $17
[000151a4]                           dc.b $00
[000151a5]                           dc.b $18
[000151a6]                           dc.b $00
[000151a7]                           dc.b $19
[000151a8]                           dc.b $00
[000151a9]                           dc.b $1a
[000151aa]                           dc.b $00
[000151ab]                           dc.b $1a
[000151ac]                           dc.b $00
[000151ad]                           dc.b $1a
[000151ae]                           dc.b $00
[000151af]                           dc.b $1a
[000151b0]                           dc.b $00
[000151b1]                           dc.b $1a
[000151b2]                           dc.b $00
[000151b3]                           dc.b $1a
[000151b4]                           dc.b $00
[000151b5]                           dc.b $00
[000151b6]                           dc.b $00
[000151b7]                           dc.b $01
[000151b8]                           dc.b $00
[000151b9]                           dc.b $02
[000151ba]                           dc.b $00
[000151bb]                           dc.b $03
[000151bc]                           dc.b $00
[000151bd]                           dc.b $04
[000151be]                           dc.b $00
[000151bf]                           dc.b $05
[000151c0]                           dc.b $00
[000151c1]                           dc.b $06
[000151c2]                           dc.b $00
[000151c3]                           dc.b $07
[000151c4]                           dc.b $00
[000151c5]                           dc.b $08
[000151c6]                           dc.b $00
[000151c7]                           dc.b $09
[000151c8]                           dc.b $00
[000151c9]                           dc.b $0a
[000151ca]                           dc.b $00
[000151cb]                           dc.b $0b
[000151cc]                           dc.b $00
[000151cd]                           dc.b $0c
[000151ce]                           dc.b $00
[000151cf]                           dc.b $0d
[000151d0]                           dc.b $00
[000151d1]                           dc.b $0e
[000151d2]                           dc.b $00
[000151d3]                           dc.b $0f
[000151d4]                           dc.b $00
[000151d5]                           dc.b $10
[000151d6]                           dc.b $00
[000151d7]                           dc.b $11
[000151d8]                           dc.b $00
[000151d9]                           dc.b $12
[000151da]                           dc.b $00
[000151db]                           dc.b $13
[000151dc]                           dc.b $00
[000151dd]                           dc.b $14
[000151de]                           dc.b $00
[000151df]                           dc.b $15
[000151e0]                           dc.b $00
[000151e1]                           dc.b $16
[000151e2]                           dc.b $00
[000151e3]                           dc.b $17
[000151e4]                           dc.b $00
[000151e5]                           dc.b $18
[000151e6]                           dc.b $00
[000151e7]                           dc.b $19
[000151e8]                           dc.b $00
[000151e9]                           dc.b $1a
[000151ea]                           dc.b $00
[000151eb]                           dc.b $1a
[000151ec]                           dc.b $00
[000151ed]                           dc.b $1a
[000151ee]                           dc.b $00
[000151ef]                           dc.b $1a
[000151f0]                           dc.b $00
[000151f1]                           dc.b $1a
[000151f2]                           dc.b $00
[000151f3]                           dc.b $1a
[000151f4]                           dc.b $00
[000151f5]                           dc.b $14
[000151f6]                           dc.b $00
[000151f7]                           dc.b $1a
[000151f8]                           dc.b $00
[000151f9]                           dc.b $1a
[000151fa]                           dc.b $00
[000151fb]                           dc.b $00
[000151fc]                           dc.b $00
[000151fd]                           dc.b $1a
[000151fe]                           dc.b $00
[000151ff]                           dc.b $1a
[00015200]                           dc.b $00
[00015201]                           dc.b $1a
[00015202]                           dc.b $00
[00015203]                           dc.b $1a
[00015204]                           dc.b $00
[00015205]                           dc.b $1a
[00015206]                           dc.b $00
[00015207]                           dc.b $1a
[00015208]                           dc.b $00
[00015209]                           dc.b $1a
[0001520a]                           dc.b $00
[0001520b]                           dc.b $1a
[0001520c]                           dc.b $00
[0001520d]                           dc.b $1a
[0001520e]                           dc.b $00
[0001520f]                           dc.b $00
[00015210]                           dc.b $00
[00015211]                           dc.b $1a
[00015212]                           dc.b $00
[00015213]                           dc.b $1a
[00015214]                           dc.b $00
[00015215]                           dc.b $1a
[00015216]                           dc.b $00
[00015217]                           dc.b $1a
[00015218]                           dc.b $00
[00015219]                           dc.b $1a
[0001521a]                           dc.b $00
[0001521b]                           dc.b $0e
[0001521c]                           dc.b $00
[0001521d]                           dc.b $1a
[0001521e]                           dc.b $00
[0001521f]                           dc.b $1a
[00015220]                           dc.b $00
[00015221]                           dc.b $1a
[00015222]                           dc.b $00
[00015223]                           dc.b $1a
[00015224]                           dc.b $00
[00015225]                           dc.b $0e
[00015226]                           dc.b $00
[00015227]                           dc.b $14
[00015228]                           dc.b $00
[00015229]                           dc.b $1a
[0001522a]                           dc.b $00
[0001522b]                           dc.b $1a
[0001522c]                           dc.b $00
[0001522d]                           dc.b $1a
[0001522e]                           dc.b $00
[0001522f]                           dc.b $1a
[00015230]                           dc.b $00
[00015231]                           dc.b $1a
[00015232]                           dc.b $00
[00015233]                           dc.b $1a
[00015234]                           dc.b $00
[00015235]                           dc.b $1a
[00015236]                           dc.b $00
[00015237]                           dc.b $1a
[00015238]                           dc.b $00
[00015239]                           dc.b $1a
[0001523a]                           dc.b $00
[0001523b]                           dc.b $1a
[0001523c]                           dc.b $00
[0001523d]                           dc.b $1a
[0001523e]                           dc.b $00
[0001523f]                           dc.b $1a
[00015240]                           dc.b $00
[00015241]                           dc.b $1a
[00015242]                           dc.b $00
[00015243]                           dc.b $1a
[00015244]                           dc.b $00
[00015245]                           dc.b $1a
[00015246]                           dc.b $00
[00015247]                           dc.b $1a
[00015248]                           dc.b $00
[00015249]                           dc.b $1a
[0001524a]                           dc.b $00
[0001524b]                           dc.b $1a
[0001524c]                           dc.b $00
[0001524d]                           dc.b $1a
[0001524e]                           dc.b $00
[0001524f]                           dc.b $1a
[00015250]                           dc.b $00
[00015251]                           dc.b $1a
[00015252]                           dc.b $00
[00015253]                           dc.b $1a
[00015254]                           dc.b $00
[00015255]                           dc.b $1a
[00015256]                           dc.b $00
[00015257]                           dc.b $1a
[00015258]                           dc.b $00
[00015259]                           dc.b $1a
[0001525a]                           dc.b $00
[0001525b]                           dc.b $1a
[0001525c]                           dc.b $00
[0001525d]                           dc.b $1a
[0001525e]                           dc.b $00
[0001525f]                           dc.b $1a
[00015260]                           dc.b $00
[00015261]                           dc.b $1a
[00015262]                           dc.b $00
[00015263]                           dc.b $1a
[00015264]                           dc.b $00
[00015265]                           dc.b $1a
[00015266]                           dc.b $00
[00015267]                           dc.b $1a
[00015268]                           dc.b $00
[00015269]                           dc.b $1a
[0001526a]                           dc.b $00
[0001526b]                           dc.b $1a
[0001526c]                           dc.b $00
[0001526d]                           dc.b $1a
[0001526e]                           dc.b $00
[0001526f]                           dc.b $1a
[00015270]                           dc.b $00
[00015271]                           dc.b $1a
[00015272]                           dc.b $00
[00015273]                           dc.b $1a
[00015274]                           dc.b $00
[00015275]                           dc.b $1a
[00015276]                           dc.b $00
[00015277]                           dc.b $1a
[00015278]                           dc.b $00
[00015279]                           dc.b $1a
[0001527a]                           dc.b $00
[0001527b]                           dc.b $1a
[0001527c]                           dc.b $00
[0001527d]                           dc.b $1a
[0001527e]                           dc.b $00
[0001527f]                           dc.b $1a
[00015280]                           dc.b $00
[00015281]                           dc.b $1a
[00015282]                           dc.b $00
[00015283]                           dc.b $1a
[00015284]                           dc.b $00
[00015285]                           dc.b $1a
[00015286]                           dc.b $00
[00015287]                           dc.b $1a
[00015288]                           dc.b $00
[00015289]                           dc.b $1a
[0001528a]                           dc.b $00
[0001528b]                           dc.b $1a
[0001528c]                           dc.b $00
[0001528d]                           dc.b $1a
[0001528e]                           dc.b $00
[0001528f]                           dc.b $1a
[00015290]                           dc.b $00
[00015291]                           dc.b $1a
[00015292]                           dc.b $00
[00015293]                           dc.b $1a
[00015294]                           dc.b $00
[00015295]                           dc.b $1a
[00015296]                           dc.b $00
[00015297]                           dc.b $1a
[00015298]                           dc.b $00
[00015299]                           dc.b $1a
[0001529a]                           dc.b $00
[0001529b]                           dc.b $1a
[0001529c]                           dc.b $00
[0001529d]                           dc.b $1a
[0001529e]                           dc.b $00
[0001529f]                           dc.b $1a
[000152a0]                           dc.b $00
[000152a1]                           dc.b $1a
[000152a2]                           dc.b $00
[000152a3]                           dc.b $1a
[000152a4]                           dc.b $00
[000152a5]                           dc.b $1a
[000152a6]                           dc.b $00
[000152a7]                           dc.b $1a
[000152a8]                           dc.b $00
[000152a9]                           dc.b $1a
[000152aa]                           dc.b $00
[000152ab]                           dc.b $1a
[000152ac]                           dc.b $00
[000152ad]                           dc.b $1a
[000152ae]                           dc.b $00
[000152af]                           dc.b $1a
[000152b0]                           dc.b $00
[000152b1]                           dc.b $1a
[000152b2]                           dc.b $00
[000152b3]                           dc.b $1a
[000152b4]                           dc.b $00
[000152b5]                           dc.b $1a
[000152b6]                           dc.b $00
[000152b7]                           dc.b $1a
[000152b8]                           dc.b $00
[000152b9]                           dc.b $1a
[000152ba]                           dc.b $00
[000152bb]                           dc.b $1a
[000152bc]                           dc.b $00
[000152bd]                           dc.b $1a
[000152be]                           dc.b $00
[000152bf]                           dc.b $1a
[000152c0]                           dc.b $00
[000152c1]                           dc.b $1a
[000152c2]                           dc.b $00
[000152c3]                           dc.b $1a
[000152c4]                           dc.b $00
[000152c5]                           dc.b $1a
[000152c6]                           dc.b $00
[000152c7]                           dc.b $1a
[000152c8]                           dc.b $00
[000152c9]                           dc.b $1a
[000152ca]                           dc.b $00
[000152cb]                           dc.b $1a
[000152cc]                           dc.b $00
[000152cd]                           dc.b $1a
[000152ce]                           dc.b $00
[000152cf]                           dc.b $1a
[000152d0]                           dc.b $00
[000152d1]                           dc.b $1a
[000152d2]                           dc.b $00
[000152d3]                           dc.b $1a
[000152d4]                           dc.b $00
[000152d5]                           dc.b $1a
[000152d6]                           dc.b $00
[000152d7]                           dc.b $1a
[000152d8]                           dc.b $00
[000152d9]                           dc.b $1a
[000152da]                           dc.b $00
[000152db]                           dc.b $1a
[000152dc]                           dc.b $00
[000152dd]                           dc.b $1a
[000152de]                           dc.b $00
[000152df]                           dc.b $1a
[000152e0]                           dc.b $00
[000152e1]                           dc.b $1a
[000152e2]                           dc.b $00
[000152e3]                           dc.b $1a
[000152e4]                           dc.b $00
[000152e5]                           dc.b $1a
[000152e6]                           dc.b $00
[000152e7]                           dc.b $1a
[000152e8]                           dc.b $00
[000152e9]                           dc.b $1a
[000152ea]                           dc.b $00
[000152eb]                           dc.b $1a
[000152ec]                           dc.b $00
[000152ed]                           dc.b $1a
[000152ee]                           dc.b $00
[000152ef]                           dc.b $1a
[000152f0]                           dc.b $00
[000152f1]                           dc.b $1a
uppercase_table:
[000152f2]                           dc.b $00
[000152f3]                           dc.b $00
[000152f4]                           dc.b $00
[000152f5]                           dc.b $01
[000152f6]                           dc.b $00
[000152f7]                           dc.b $02
[000152f8]                           dc.b $00
[000152f9]                           dc.b $03
[000152fa]                           dc.b $00
[000152fb]                           dc.b $04
[000152fc]                           dc.b $00
[000152fd]                           dc.b $05
[000152fe]                           dc.b $00
[000152ff]                           dc.b $06
[00015300]                           dc.b $00
[00015301]                           dc.b $07
[00015302]                           dc.b $00
[00015303]                           dc.b $08
[00015304]                           dc.b $00
[00015305]                           dc.b $09
[00015306]                           dc.b $00
[00015307]                           dc.b $0a
[00015308]                           dc.b $00
[00015309]                           dc.b $0b
[0001530a]                           dc.b $00
[0001530b]                           dc.b $0c
[0001530c]                           dc.b $00
[0001530d]                           dc.b $0d
[0001530e]                           dc.b $00
[0001530f]                           dc.b $0e
[00015310]                           dc.b $00
[00015311]                           dc.b $0f
[00015312]                           dc.b $00
[00015313]                           dc.b $10
[00015314]                           dc.b $00
[00015315]                           dc.b $11
[00015316]                           dc.b $00
[00015317]                           dc.b $12
[00015318]                           dc.b $00
[00015319]                           dc.b $13
[0001531a]                           dc.b $00
[0001531b]                           dc.b $14
[0001531c]                           dc.b $00
[0001531d]                           dc.b $15
[0001531e]                           dc.b $00
[0001531f]                           dc.b $16
[00015320]                           dc.b $00
[00015321]                           dc.b $17
[00015322]                           dc.b $00
[00015323]                           dc.b $18
[00015324]                           dc.b $00
[00015325]                           dc.b $19
[00015326]                           dc.b $00
[00015327]                           dc.b $1a
[00015328]                           dc.b $00
[00015329]                           dc.b $1b
[0001532a]                           dc.b $00
[0001532b]                           dc.b $1c
[0001532c]                           dc.b $00
[0001532d]                           dc.b $1d
[0001532e]                           dc.b $00
[0001532f]                           dc.b $1e
[00015330]                           dc.b $00
[00015331]                           dc.b $1f
[00015332]                           dc.b $00
[00015333]                           dc.b $20
[00015334]                           dc.b $00
[00015335]                           dc.b $21
[00015336]                           dc.b $00
[00015337]                           dc.b $22
[00015338]                           dc.b $00
[00015339]                           dc.b $23
[0001533a]                           dc.b $00
[0001533b]                           dc.b $24
[0001533c]                           dc.b $00
[0001533d]                           dc.b $25
[0001533e]                           dc.b $00
[0001533f]                           dc.b $26
[00015340]                           dc.b $00
[00015341]                           dc.b $27
[00015342]                           dc.b $00
[00015343]                           dc.b $28
[00015344]                           dc.b $00
[00015345]                           dc.b $29
[00015346]                           dc.b $00
[00015347]                           dc.b $2a
[00015348]                           dc.b $00
[00015349]                           dc.b $2b
[0001534a]                           dc.b $00
[0001534b]                           dc.b $2c
[0001534c]                           dc.b $00
[0001534d]                           dc.b $2d
[0001534e]                           dc.b $00
[0001534f]                           dc.b $2e
[00015350]                           dc.b $00
[00015351]                           dc.b $2f
[00015352]                           dc.b $00
[00015353]                           dc.b $30
[00015354]                           dc.b $00
[00015355]                           dc.b $31
[00015356]                           dc.b $00
[00015357]                           dc.b $32
[00015358]                           dc.b $00
[00015359]                           dc.b $33
[0001535a]                           dc.b $00
[0001535b]                           dc.b $34
[0001535c]                           dc.b $00
[0001535d]                           dc.b $35
[0001535e]                           dc.b $00
[0001535f]                           dc.b $36
[00015360]                           dc.b $00
[00015361]                           dc.b $37
[00015362]                           dc.b $00
[00015363]                           dc.b $38
[00015364]                           dc.b $00
[00015365]                           dc.b $39
[00015366]                           dc.b $00
[00015367]                           dc.b $3a
[00015368]                           dc.b $00
[00015369]                           dc.b $3b
[0001536a]                           dc.b $00
[0001536b]                           dc.b $3c
[0001536c]                           dc.b $00
[0001536d]                           dc.b $3d
[0001536e]                           dc.b $00
[0001536f]                           dc.b $3e
[00015370]                           dc.b $00
[00015371]                           dc.b $3f
[00015372]                           dc.b $00
[00015373]                           dc.b $40
[00015374]                           dc.b $00
[00015375]                           dc.b $41
[00015376]                           dc.b $00
[00015377]                           dc.b $42
[00015378]                           dc.b $00
[00015379]                           dc.b $43
[0001537a]                           dc.b $00
[0001537b]                           dc.b $44
[0001537c]                           dc.b $00
[0001537d]                           dc.b $45
[0001537e]                           dc.b $00
[0001537f]                           dc.b $46
[00015380]                           dc.b $00
[00015381]                           dc.b $47
[00015382]                           dc.b $00
[00015383]                           dc.b $48
[00015384]                           dc.b $00
[00015385]                           dc.b $49
[00015386]                           dc.b $00
[00015387]                           dc.b $4a
[00015388]                           dc.b $00
[00015389]                           dc.b $4b
[0001538a]                           dc.b $00
[0001538b]                           dc.b $4c
[0001538c]                           dc.b $00
[0001538d]                           dc.b $4d
[0001538e]                           dc.b $00
[0001538f]                           dc.b $4e
[00015390]                           dc.b $00
[00015391]                           dc.b $4f
[00015392]                           dc.b $00
[00015393]                           dc.b $50
[00015394]                           dc.b $00
[00015395]                           dc.b $51
[00015396]                           dc.b $00
[00015397]                           dc.b $52
[00015398]                           dc.b $00
[00015399]                           dc.b $53
[0001539a]                           dc.b $00
[0001539b]                           dc.b $54
[0001539c]                           dc.b $00
[0001539d]                           dc.b $55
[0001539e]                           dc.b $00
[0001539f]                           dc.b $56
[000153a0]                           dc.b $00
[000153a1]                           dc.b $57
[000153a2]                           dc.b $00
[000153a3]                           dc.b $58
[000153a4]                           dc.b $00
[000153a5]                           dc.b $59
[000153a6]                           dc.b $00
[000153a7]                           dc.b $5a
[000153a8]                           dc.b $00
[000153a9]                           dc.b $5b
[000153aa]                           dc.b $00
[000153ab]                           dc.b $5c
[000153ac]                           dc.b $00
[000153ad]                           dc.b $5d
[000153ae]                           dc.b $00
[000153af]                           dc.b $5e
[000153b0]                           dc.b $00
[000153b1]                           dc.b $5f
[000153b2]                           dc.b $00
[000153b3]                           dc.b $60
[000153b4]                           dc.b $00
[000153b5]                           dc.b $41
[000153b6]                           dc.b $00
[000153b7]                           dc.b $42
[000153b8]                           dc.b $00
[000153b9]                           dc.b $43
[000153ba]                           dc.b $00
[000153bb]                           dc.b $44
[000153bc]                           dc.b $00
[000153bd]                           dc.b $45
[000153be]                           dc.b $00
[000153bf]                           dc.b $46
[000153c0]                           dc.b $00
[000153c1]                           dc.b $47
[000153c2]                           dc.b $00
[000153c3]                           dc.b $48
[000153c4]                           dc.b $00
[000153c5]                           dc.b $49
[000153c6]                           dc.b $00
[000153c7]                           dc.b $4a
[000153c8]                           dc.b $00
[000153c9]                           dc.b $4b
[000153ca]                           dc.b $00
[000153cb]                           dc.b $4c
[000153cc]                           dc.b $00
[000153cd]                           dc.b $4d
[000153ce]                           dc.b $00
[000153cf]                           dc.b $4e
[000153d0]                           dc.b $00
[000153d1]                           dc.b $4f
[000153d2]                           dc.b $00
[000153d3]                           dc.b $50
[000153d4]                           dc.b $00
[000153d5]                           dc.b $51
[000153d6]                           dc.b $00
[000153d7]                           dc.b $52
[000153d8]                           dc.b $00
[000153d9]                           dc.b $53
[000153da]                           dc.b $00
[000153db]                           dc.b $54
[000153dc]                           dc.b $00
[000153dd]                           dc.b $55
[000153de]                           dc.b $00
[000153df]                           dc.b $56
[000153e0]                           dc.b $00
[000153e1]                           dc.b $57
[000153e2]                           dc.b $00
[000153e3]                           dc.b $58
[000153e4]                           dc.b $00
[000153e5]                           dc.b $59
[000153e6]                           dc.b $00
[000153e7]                           dc.b $5a
[000153e8]                           dc.b $00
[000153e9]                           dc.b $7b
[000153ea]                           dc.b $00
[000153eb]                           dc.b $7c
[000153ec]                           dc.b $00
[000153ed]                           dc.b $7d
[000153ee]                           dc.b $00
[000153ef]                           dc.b $7e
[000153f0]                           dc.b $00
[000153f1]                           dc.b $7f
[000153f2]                           dc.b $00
[000153f3]                           dc.b $80
[000153f4]                           dc.b $00
[000153f5]                           dc.b $55
[000153f6]                           dc.b $00
[000153f7]                           dc.b $82
[000153f8]                           dc.b $00
[000153f9]                           dc.b $83
[000153fa]                           dc.b $00
[000153fb]                           dc.b $41
[000153fc]                           dc.b $00
[000153fd]                           dc.b $85
[000153fe]                           dc.b $00
[000153ff]                           dc.b $86
[00015400]                           dc.b $00
[00015401]                           dc.b $87
[00015402]                           dc.b $00
[00015403]                           dc.b $88
[00015404]                           dc.b $00
[00015405]                           dc.b $89
[00015406]                           dc.b $00
[00015407]                           dc.b $8a
[00015408]                           dc.b $00
[00015409]                           dc.b $8b
[0001540a]                           dc.b $00
[0001540b]                           dc.b $8c
[0001540c]                           dc.b $00
[0001540d]                           dc.b $8d
[0001540e]                           dc.b $00
[0001540f]                           dc.b $41
[00015410]                           dc.b $00
[00015411]                           dc.b $8f
[00015412]                           dc.b $00
[00015413]                           dc.b $90
[00015414]                           dc.b $00
[00015415]                           dc.b $91
[00015416]                           dc.b $00
[00015417]                           dc.b $92
[00015418]                           dc.b $00
[00015419]                           dc.b $93
[0001541a]                           dc.b $00
[0001541b]                           dc.b $4f
[0001541c]                           dc.b $00
[0001541d]                           dc.b $95
[0001541e]                           dc.b $00
[0001541f]                           dc.b $96
[00015420]                           dc.b $00
[00015421]                           dc.b $97
[00015422]                           dc.b $00
[00015423]                           dc.b $98
[00015424]                           dc.b $00
[00015425]                           dc.b $4f
[00015426]                           dc.b $00
[00015427]                           dc.b $55
[00015428]                           dc.b $00
[00015429]                           dc.b $9b
[0001542a]                           dc.b $00
[0001542b]                           dc.b $9c
[0001542c]                           dc.b $00
[0001542d]                           dc.b $9d
[0001542e]                           dc.b $00
[0001542f]                           dc.b $9e
[00015430]                           dc.b $00
[00015431]                           dc.b $9f
[00015432]                           dc.b $00
[00015433]                           dc.b $a0
[00015434]                           dc.b $00
[00015435]                           dc.b $a1
[00015436]                           dc.b $00
[00015437]                           dc.b $a2
[00015438]                           dc.b $00
[00015439]                           dc.b $a3
[0001543a]                           dc.b $00
[0001543b]                           dc.b $a4
[0001543c]                           dc.b $00
[0001543d]                           dc.b $a5
[0001543e]                           dc.b $00
[0001543f]                           dc.b $a6
[00015440]                           dc.b $00
[00015441]                           dc.b $a7
[00015442]                           dc.b $00
[00015443]                           dc.b $a8
[00015444]                           dc.b $00
[00015445]                           dc.b $a9
[00015446]                           dc.b $00
[00015447]                           dc.b $aa
[00015448]                           dc.b $00
[00015449]                           dc.b $ab
[0001544a]                           dc.b $00
[0001544b]                           dc.b $ac
[0001544c]                           dc.b $00
[0001544d]                           dc.b $ad
[0001544e]                           dc.b $00
[0001544f]                           dc.b $ae
[00015450]                           dc.b $00
[00015451]                           dc.b $af
[00015452]                           dc.b $00
[00015453]                           dc.b $b0
[00015454]                           dc.b $00
[00015455]                           dc.b $b1
[00015456]                           dc.b $00
[00015457]                           dc.b $b2
[00015458]                           dc.b $00
[00015459]                           dc.b $b3
[0001545a]                           dc.b $00
[0001545b]                           dc.b $b4
[0001545c]                           dc.b $00
[0001545d]                           dc.b $b5
[0001545e]                           dc.b $00
[0001545f]                           dc.b $b6
[00015460]                           dc.b $00
[00015461]                           dc.b $b7
[00015462]                           dc.b $00
[00015463]                           dc.b $b8
[00015464]                           dc.b $00
[00015465]                           dc.b $b9
[00015466]                           dc.b $00
[00015467]                           dc.b $ba
[00015468]                           dc.b $00
[00015469]                           dc.b $bb
[0001546a]                           dc.b $00
[0001546b]                           dc.b $bc
[0001546c]                           dc.b $00
[0001546d]                           dc.b $bd
[0001546e]                           dc.b $00
[0001546f]                           dc.b $be
[00015470]                           dc.b $00
[00015471]                           dc.b $bf
[00015472]                           dc.b $00
[00015473]                           dc.b $c0
[00015474]                           dc.b $00
[00015475]                           dc.b $c1
[00015476]                           dc.b $00
[00015477]                           dc.b $c2
[00015478]                           dc.b $00
[00015479]                           dc.b $c3
[0001547a]                           dc.b $00
[0001547b]                           dc.b $c4
[0001547c]                           dc.b $00
[0001547d]                           dc.b $c5
[0001547e]                           dc.b $00
[0001547f]                           dc.b $c6
[00015480]                           dc.b $00
[00015481]                           dc.b $c7
[00015482]                           dc.b $00
[00015483]                           dc.b $c8
[00015484]                           dc.b $00
[00015485]                           dc.b $c9
[00015486]                           dc.b $00
[00015487]                           dc.b $ca
[00015488]                           dc.b $00
[00015489]                           dc.b $cb
[0001548a]                           dc.b $00
[0001548b]                           dc.b $cc
[0001548c]                           dc.b $00
[0001548d]                           dc.b $cd
[0001548e]                           dc.b $00
[0001548f]                           dc.b $ce
[00015490]                           dc.b $00
[00015491]                           dc.b $cf
[00015492]                           dc.b $00
[00015493]                           dc.b $d0
[00015494]                           dc.b $00
[00015495]                           dc.b $d1
[00015496]                           dc.b $00
[00015497]                           dc.b $d2
[00015498]                           dc.b $00
[00015499]                           dc.b $d3
[0001549a]                           dc.b $00
[0001549b]                           dc.b $d4
[0001549c]                           dc.b $00
[0001549d]                           dc.b $d5
[0001549e]                           dc.b $00
[0001549f]                           dc.b $d6
[000154a0]                           dc.b $00
[000154a1]                           dc.b $d7
[000154a2]                           dc.b $00
[000154a3]                           dc.b $d8
[000154a4]                           dc.b $00
[000154a5]                           dc.b $d9
[000154a6]                           dc.b $00
[000154a7]                           dc.b $da
[000154a8]                           dc.b $00
[000154a9]                           dc.b $db
[000154aa]                           dc.b $00
[000154ab]                           dc.b $dc
[000154ac]                           dc.b $00
[000154ad]                           dc.b $dd
[000154ae]                           dc.b $00
[000154af]                           dc.b $de
[000154b0]                           dc.b $00
[000154b1]                           dc.b $df
[000154b2]                           dc.b $00
[000154b3]                           dc.b $e0
[000154b4]                           dc.b $00
[000154b5]                           dc.b $e1
[000154b6]                           dc.b $00
[000154b7]                           dc.b $e2
[000154b8]                           dc.b $00
[000154b9]                           dc.b $e3
[000154ba]                           dc.b $00
[000154bb]                           dc.b $e4
[000154bc]                           dc.b $00
[000154bd]                           dc.b $e5
[000154be]                           dc.b $00
[000154bf]                           dc.b $e6
[000154c0]                           dc.b $00
[000154c1]                           dc.b $e7
[000154c2]                           dc.b $00
[000154c3]                           dc.b $e8
[000154c4]                           dc.b $00
[000154c5]                           dc.b $e9
[000154c6]                           dc.b $00
[000154c7]                           dc.b $ea
[000154c8]                           dc.b $00
[000154c9]                           dc.b $eb
[000154ca]                           dc.b $00
[000154cb]                           dc.b $ec
[000154cc]                           dc.b $00
[000154cd]                           dc.b $ed
[000154ce]                           dc.b $00
[000154cf]                           dc.b $ee
[000154d0]                           dc.b $00
[000154d1]                           dc.b $ef
[000154d2]                           dc.b $00
[000154d3]                           dc.b $f0
[000154d4]                           dc.b $00
[000154d5]                           dc.b $f1
[000154d6]                           dc.b $00
[000154d7]                           dc.b $f2
[000154d8]                           dc.b $00
[000154d9]                           dc.b $f3
[000154da]                           dc.b $00
[000154db]                           dc.b $f4
[000154dc]                           dc.b $00
[000154dd]                           dc.b $f5
[000154de]                           dc.b $00
[000154df]                           dc.b $f6
[000154e0]                           dc.b $00
[000154e1]                           dc.b $f7
[000154e2]                           dc.b $00
[000154e3]                           dc.b $f8
[000154e4]                           dc.b $00
[000154e5]                           dc.b $f9
[000154e6]                           dc.b $00
[000154e7]                           dc.b $fa
[000154e8]                           dc.b $00
[000154e9]                           dc.b $fb
[000154ea]                           dc.b $00
[000154eb]                           dc.b $fc
[000154ec]                           dc.b $00
[000154ed]                           dc.b $fd
[000154ee]                           dc.b $00
[000154ef]                           dc.b $fe
[000154f0]                           dc.b $00
[000154f1]                           dc.b $ff
caps_size:
[000154f2]                           dc.b $00
[000154f3]                           dc.b $00
[000154f4]                           dc.b $00
[000154f5]                           dc.b $00
sens_size:
[000154f6]                           dc.b $00
[000154f7]                           dc.b $00
[000154f8]                           dc.b $00
[000154f9]                           dc.b $00
no_index_entry:
[000154fa]                           dc.b 'screen("a..")Zu diesem Buchstaben ist kein Eintrag vorhanden.\end'
[0001553b]                           dc.b $1a
[0001553c]                           dc.b $00
[0001553d]                           dc.b 'screen("Index")Index der verf'
[0001555a]                           dc.w $8167
[0001555c]                           dc.b 'baren Schl'
[00015566]                           dc.w $8173
[00015568]                           dc.b 'selw'
[0001556c]                           dc.w $9472
[0001556e]                           dc.b 'ter:',$0d,$0a,$0d,$0a,'     \#A..\#       \#B..\#       \#C..\#      \#D..\#',$0d,$0a,$0d,$0a,'     \#E..\#       \#F..\#       \#G..\#      \#H..\#',$0d,$0a,$0d,$0a,'     \#I..\#       \#J..\#       \#K..\#      \#L..\#',$0d,$0a,$0d,$0a,'     \#M..\#       \#N..\#       \#O..\#      \#P..\#',$0d,$0a,$0d,$0a,'     \#Q..\#       \#R..\#       \#S..\#      \#T..\#',$0d,$0a,$0d,$0a,'     \#U..\#       \#V..\#       \#W..\#      \#X..\#',$0d,$0a,$0d,$0a,'     \#Y..\#       \#Z..\#',$0d,$0a,$0d,$0a,'     \#Sonstiges\#\end'
[00015700]                           dc.w $1a00
[00015702] 0001574a                  dc.l $0001574a ; no symbol found
[00015706] 0001575e                  dc.l $0001575e ; no symbol found
month_names:
[0001570a] 0001578a                  dc.l $0001578a ; no symbol found
[0001570e] 00015791                  dc.l $00015791 ; no symbol found
[00015712] 00015799                  dc.l $00015799 ; no symbol found
[00015716] 0001579e                  dc.l $0001579e ; no symbol found
[0001571a] 000157a4                  dc.l $000157a4 ; no symbol found
[0001571e] 000157a8                  dc.l $000157a8 ; no symbol found
[00015722] 000157ad                  dc.l $000157ad ; no symbol found
[00015726] 000157b2                  dc.l $000157b2 ; no symbol found
[0001572a] 000157b9                  dc.l $000157b9 ; no symbol found
[0001572e] 000157c3                  dc.l $000157c3 ; no symbol found
[00015732] 000157cb                  dc.l $000157cb ; no symbol found
[00015736] 000157d4                  dc.l $000157d4 ; no symbol found
[0001573a]                           dc.b $00
[0001573b]                           dc.b $00
[0001573c]                           dc.b 'A..',0
[00015740]                           dc.b $00
[00015741]                           dc.b $00
[00015742]                           dc.b $00
[00015743]                           dc.b $00
[00015744]                           dc.b $00
[00015745]                           dc.b $00
[00015746]                           dc.w $ffff
[00015748]                           dc.w $ffff
[0001574a]                           dc.b 'screen("Copyright")',0
[0001575e]                           dc.b $0d,$0a,'(c) 1990 Borland International, Inc.\end'
[00015788]                           dc.w $1a00
[0001578a]                           dc.b 'Januar',0
[00015791]                           dc.b 'Februar',0
[00015799]                           dc.b $4d
[0001579a]                           dc.w $8472
[0001579c]                           dc.w $7a00
[0001579e]                           dc.b 'April',0
[000157a4]                           dc.b 'Mai',0
[000157a8]                           dc.b 'Juni',0
[000157ad]                           dc.b 'Juli',0
[000157b2]                           dc.b 'August',0
[000157b9]                           dc.b 'September',0
[000157c3]                           dc.b 'Oktober',0
[000157cb]                           dc.b 'November',0
[000157d4]                           dc.b 'Dezember',0
[000157dd]                           dc.b 'Sonstiges',0
[000157e7]                           dc.b '     ',0
[000157ed]                           dc.b '%s%s wurde '
[000157f8]                           dc.w $8162
[000157fa]                           dc.b 'ersetzt am %d.%s %d.',$0d,$0a,'%s',0
[00015813]                           dc.b $00
[00015814]                           dc.b 'hc.$1$',0
[0001581b]                           dc.b $72
[0001581c]                           dc.w $6200
[0001581e]                           dc.b $0a,$09,'reading uncompressed help screens',$0a,0
[00015843]                           dc.b 'temporary file',0
[00015852]                           dc.b $09,'computing compression',$0a,0
[0001586a]                           dc.b 'hc.$3$',0
[00015871]                           dc.b $09,'writing compressed help screens',$0a,0
[00015893]                           dc.b $00
[00015894]                           dc.b 'temporary file',0
[000158a3]                           dc.b 'hc.$2$',0
[000158aa]                           dc.b $00
[000158ab]                           dc.b $00
[000158ac]                           dc.b $00
[000158ad]                           dc.b $00
[000158ae]                           dc.b $00
[000158af]                           dc.b $00
[000158b0]                           dc.b $00
[000158b1]                           dc.b $00
[000158b2]                           dc.b $00
[000158b3]                           dc.b $00
[000158b4]                           dc.b $00
[000158b5]                           dc.b $00
[000158b6]                           dc.b $00
[000158b7]                           dc.b $00
[000158b8]                           dc.b $00
[000158b9]                           dc.b $00
[000158ba]                           dc.b $00
[000158bb]                           dc.b $00
[000158bc]                           dc.b $00
[000158bd]                           dc.b $00
[000158be]                           dc.b $00
[000158bf]                           dc.b $00
[000158c0]                           dc.b $00
[000158c1]                           dc.b $00
[000158c2] 000158d8                  dc.l $000158d8 ; no symbol found
[000158c6] 000158d8                  dc.l $000158d8 ; no symbol found
[000158ca] 000158d8                  dc.l $000158d8 ; no symbol found
[000158ce] 00015928                  dc.l stdout
[000158d2]                           dc.b $00
[000158d3]                           dc.b $00
[000158d4]                           dc.w $0100
[000158d6]                           dc.b $00
[000158d7]                           dc.b $00
[000158d8]                           dc.b $00
[000158d9]                           dc.b $00
[000158da]                           dc.b $00
[000158db]                           dc.b $00
[000158dc]                           dc.b $00
[000158dd]                           dc.b $00
[000158de]                           dc.b $00
[000158df]                           dc.b $00
[000158e0]                           dc.b $00
[000158e1]                           dc.b $00
[000158e2]                           dc.b $00
[000158e3]                           dc.b $00
[000158e4]                           dc.b $00
[000158e5]                           dc.b $00
[000158e6]                           dc.b $00
[000158e7]                           dc.b $00
[000158e8]                           dc.b $00
[000158e9]                           dc.b $00
[000158ea]                           dc.b $00
[000158eb]                           dc.b $00
[000158ec]                           dc.b $00
[000158ed]                           dc.b $00
[000158ee]                           dc.b $00
[000158ef]                           dc.b $00
[000158f0]                           dc.b $00
[000158f1]                           dc.b $00
[000158f2]                           dc.b $00
[000158f3]                           dc.b $00
[000158f4]                           dc.b $00
[000158f5]                           dc.b $00
[000158f6]                           dc.b $00
[000158f7]                           dc.b $00
[000158f8]                           dc.b $00
[000158f9]                           dc.b $00
[000158fa]                           dc.b $00
[000158fb]                           dc.b $00
[000158fc]                           dc.b $00
[000158fd]                           dc.b $00
[000158fe]                           dc.b $00
[000158ff]                           dc.b $00
[00015900]                           dc.b $00
[00015901]                           dc.b $00
[00015902]                           dc.b $00
[00015903]                           dc.b $00
[00015904]                           dc.b $00
[00015905]                           dc.b $00
[00015906]                           dc.b $00
[00015907]                           dc.b $00
[00015908]                           dc.b $00
[00015909]                           dc.b $00
[0001590a]                           dc.b $00
[0001590b]                           dc.b $00
[0001590c]                           dc.b $00
[0001590d]                           dc.b $00
[0001590e]                           dc.b $00
[0001590f]                           dc.b $00
[00015910]                           dc.b $00
[00015911]                           dc.b $00
[00015912]                           dc.b $00
[00015913]                           dc.b $00
[00015914]                           dc.b $00
[00015915]                           dc.b $00
[00015916]                           dc.b $00
[00015917]                           dc.b $00
[00015918]                           dc.b $00
[00015919]                           dc.b $00
[0001591a]                           dc.b $00
[0001591b]                           dc.b $00
[0001591c]                           dc.b $00
[0001591d]                           dc.b $00
[0001591e]                           dc.b $00
[0001591f]                           dc.b $00
[00015920]                           dc.b $00
[00015921]                           dc.b $00
[00015922]                           dc.b $00
[00015923]                           dc.b $00
[00015924]                           dc.b $00
[00015925]                           dc.b $00
[00015926]                           dc.b $00
[00015927]                           dc.b $00
stdout:
[00015928]                           dc.b $00
[00015929]                           dc.b $00
[0001592a]                           dc.b $00
[0001592b]                           dc.b $00
[0001592c]                           dc.b $00
[0001592d]                           dc.b $00
[0001592e]                           dc.b $00
[0001592f]                           dc.b $00
[00015930]                           dc.b $00
[00015931]                           dc.b $00
[00015932]                           dc.b $00
[00015933]                           dc.b $00
[00015934]                           dc.b $00
[00015935]                           dc.b $00
[00015936]                           dc.b $00
[00015937]                           dc.b $00
[00015938]                           dc.b $00
[00015939]                           dc.b $01
[0001593a]                           dc.w $0600
[0001593c]                           dc.b $00
[0001593d]                           dc.b $00
stderr:
[0001593e]                           dc.b $00
[0001593f]                           dc.b $00
[00015940]                           dc.b $00
[00015941]                           dc.b $00
[00015942]                           dc.b $00
[00015943]                           dc.b $00
[00015944]                           dc.b $00
[00015945]                           dc.b $00
[00015946]                           dc.b $00
[00015947]                           dc.b $00
[00015948]                           dc.b $00
[00015949]                           dc.b $00
[0001594a]                           dc.b $00
[0001594b]                           dc.b $00
[0001594c]                           dc.b $00
[0001594d]                           dc.b $00
[0001594e]                           dc.w $ffff
[00015950]                           dc.w $0600
[00015952]                           dc.b $00
[00015953]                           dc.b $00
[00015954]                           dc.b $00
[00015955]                           dc.b $00
[00015956]                           dc.b $00
[00015957]                           dc.b $00
[00015958]                           dc.b $00
[00015959]                           dc.b $00
[0001595a]                           dc.b $00
[0001595b]                           dc.b $00
[0001595c]                           dc.b $00
[0001595d]                           dc.b $00
[0001595e]                           dc.b $00
[0001595f]                           dc.b $00
[00015960]                           dc.b $00
[00015961]                           dc.b $00
[00015962]                           dc.b $00
[00015963]                           dc.b $00
[00015964]                           dc.b $00
[00015965]                           dc.b $02
[00015966]                           dc.w $0700
[00015968]                           dc.b $00
[00015969]                           dc.b $00
[0001596a]                           dc.b $00
[0001596b]                           dc.b $00
[0001596c]                           dc.b $00
[0001596d]                           dc.b $00
[0001596e]                           dc.b $00
[0001596f]                           dc.b $00
[00015970]                           dc.b $00
[00015971]                           dc.b $00
[00015972]                           dc.b $00
[00015973]                           dc.b $00
[00015974]                           dc.b $00
[00015975]                           dc.b $00
[00015976]                           dc.b $00
[00015977]                           dc.b $00
[00015978]                           dc.b $00
[00015979]                           dc.b $00
[0001597a]                           dc.b $00
[0001597b]                           dc.b $03
[0001597c]                           dc.w $0600
[0001597e]                           dc.b $00
[0001597f]                           dc.b $00
[00015980]                           dc.b $00
[00015981]                           dc.b $00
[00015982]                           dc.b $00
[00015983]                           dc.b $00
_MemBlkL:
[00015984]                           dc.b $00
[00015985]                           dc.b $00
[00015986]                           dc.b $00
[00015987]                           dc.b $00
_MemCluL:
[00015988]                           dc.b $00
[00015989]                           dc.b $00
[0001598a]                           dc.b $00
[0001598b]                           dc.b $00
;
00010172 T exit
00010198 T main
00010204 T print_banner
00010218 T usage
0001023a T read_commandfile
000104e6 T compile_help
00010558 T alloc_buffers
00010604 T pass1
000106d2 T reset_file
0001071a T check_errors
000107ae T compile_files
0001088c T hc_getc
000108ea T hc_putc
0001093a T hc_putw
00010958 T hc_puts
000109b8 T hc_fillbuf
00010a54 T hc_flshbuf
00010a94 T hc_fread
00010aaa T hc_fwrite
00010ad0 T hc_openfile
00010b0c T hc_createfile
00010b36 T log_open
00010bac T hc_closeout
00010bbe T log_close
00010bf0 T hc_closein
00010c08 T hc_copyfile
00010c4e T hclog
00010d34 T cleanup
00010d74 T logstr
00010d9c T parse_file
0001102e t next_parameter
00011088 t parse_parameters
000110d0 T hc_skipto
00011100 T hc_gettok
00011256 T hc_backtok
00011260 T hc_back
0001127a T parse_identifier
000112b6 T parse_string
00011328 T parse_keyword
00011388 T parse_link
0001142a t parse_braces
0001148c T skip_space
000114b8 T calchash
000114f4 T init_keyword_hash
0001157e T write_help
000116d6 T add_name
00011752 T do_references
00011828 T free_namelist
00011850 t namecmp
0001185c T write_table
0001196a T generate_index
00011a32 T free_index
00011a6a T format_index_entry
00011aa0 T generate_index_entries
00011c2a T clear_index
00011c3c T add_index_entry
00011dbe t add_search_key
00011dde T get_index_screen_code
00011e26 T index_namecmp
00011e60 T parse_index_page
00011e8a T generate_copyright
00011f0e T do_compress
000124b0 t codecmp
000124b6 t init_tables
000124e6 t init_codeinfo
000124fe t x124fe
0001256a t sort_codes
00012642 t swap
00012654 t write_compression
000127f6 T write_nibble
00012822 T flush_nibble
0001282e t __fpuinit
0001285e t _fpuinit
00012870 t swap
0001287c t __qsort
000129be T qsort
000129c8 T fprintf
00012a06 T sprintf
00012a38 T vsprintf
00012a6a T _PrintF
00012d1a T _OutIntD
00012d6c T _OutCarD
00012d7e T _OutCarH
00012dbe T _OutCarO
00012e68 T _OutChr
00012e78 T _OutStr
00012f2c T OutZero
00012f36 T OutBlank
00012f78 T feof
00012f84 T ferror
00012f90 T fgets
0001302e T fwrite
000130f8 T fread
0001317e T fgetc
000131d4 T rewind
000131e2 T fseek
00013266 T fopen
00013272 T freopen
00013332 t getmode
000133c6 t searchfil
000133d8 t cleanfil
00013436 T fclose
0001348a T _FillBuf
000134fe T _FlshBuf
000135b4 T open
00013656 T close
0001367c T unlink
0001369c T read
000137e4 T echochar
000137f0 T write
00013822 T lseek
00013914 T isatty
00013964 T _XltErr
0001399e T strcat
000139e6 T strrchr
00013a02 T strcmp
00013a56 T strcpy
00013a9c T strlen
00013ac6 T strncpy
00013ae0 T strtoul
00013bb2 T strupr
00013bc6 T ultoa
00013c60 T malloc
00013d48 T free
00013da2 T _FreeAll
00013dd8 T _InsFreB
00013ea4 T memcpy
0001408e T memset
0001414e T toupper
0001415c T _UpcTab
0001425c T _ChrCla1
0001435c T _DigCnvT
0001445c T _ulmul
00014484 T _uldiv
000144d6 T _lmul
00014520 T _ldiv
00014594 T _lmod
00014602 T getch
0001462a T getdate
00014658 D errno
0001465a D _AtExitVec
0001465e D _FilSysVec
00014662 D hc_inbuf_size
00014666 D file_index
00014668 D generate_help
0001466a D options.create_log
0001466c D options.verbose
0001466e D options.x1466e
00014670 D options.break_make
00014672 D options.tabsize
00014942 D err_filename
00014b5e D errors_total
00014b62 D warnings_total
00014b66 D errmsg
00014eb2 D brace_level
00014ef2 D character_class
00014ff2 D keywords
00015034 D in_screen
00015036 d backtok
00015038 D in_link
00015072 D screen_cnt
00015074 D last_indexentry_name
00015078 D screen_start
0001507c D namelist
00015080 D unused_15080
000150f2 d name_to_index
000152f2 d uppercase_table
000154f2 D caps_size
000154f6 D sens_size
000154fa d no_index_entry
0001570a D month_names
00015928 D stdout
0001593e D stderr
00015984 D _MemBlkL
00015988 D _MemCluL
0001598c B _BasPag
00015990 B _app
00015992 B _StkLim
00015996 B _PgmSize
0001599a B _RedirTab
000159b2 B hc_inbuf
000159b6 B screenbuf
000159ba B hc_inbuf_ptr
000159be B screenbuf_ptr
000159c2 B outfile_name
00015a02 B helpfiles
00015b02 B hc_infile
00015b06 B hc_outfile
00015b0a B logfile
00015b0e B err_lineno
00015b12 B errors_thisfile
00015b14 B warnings_thisfile
00015b16 B cur_identifier
00015f16 B hc_curtok
00015f18 B hc_curscope
00015f1a B input_lineno
00015f1e B keyword_hash
0001626a B helphdr
000162c2 B helphdr.scr_tab_size
000162c6 B helphdr.str_offset
000162ca B helphdr.str_size
000162ce B helphdr.char_table
000162da B helphdr.caps_offset
000162de B helphdr.caps_size
000162e2 B helphdr.caps_cnt
000162e6 B helphdr.sens_offset
000162ea B helphdr.sens_size
000162ee B helphdr.sens_cnt
000162f2 b namelist_tail
000162f6 B screen_table_offset
000162fa b nameindex
000163d2 B caps_table
000163d6 B caps_cnt
000163da B sens_table
000163de B sens_cnt
000163e2 B x163e2
000163e6 B char_counts
000163ea B x163ea
000163ee B _FilTab
;

/*
 * GEM resource C output of pchlprsc
 *
 * created by ORCS 2.18
 */

#ifndef _LONG_PTR
#  define _LONG_PTR LONG
#endif

#ifndef OS_NORMAL
#  define OS_NORMAL 0x0000
#endif
#ifndef OS_SELECTED
#  define OS_SELECTED 0x0001
#endif
#ifndef OS_CROSSED
#  define OS_CROSSED 0x0002
#endif
#ifndef OS_CHECKED
#  define OS_CHECKED 0x0004
#endif
#ifndef OS_DISABLED
#  define OS_DISABLED 0x0008
#endif
#ifndef OS_OUTLINED
#  define OS_OUTLINED 0x0010
#endif
#ifndef OS_SHADOWED
#  define OS_SHADOWED 0x0020
#endif
#ifndef OS_WHITEBAK
#  define OS_WHITEBAK 0x0040
#endif
#ifndef OS_DRAW3D
#  define OS_DRAW3D 0x0080
#endif

#ifndef OF_NONE
#  define OF_NONE 0x0000
#endif
#ifndef OF_SELECTABLE
#  define OF_SELECTABLE 0x0001
#endif
#ifndef OF_DEFAULT
#  define OF_DEFAULT 0x0002
#endif
#ifndef OF_EXIT
#  define OF_EXIT 0x0004
#endif
#ifndef OF_EDITABLE
#  define OF_EDITABLE 0x0008
#endif
#ifndef OF_RBUTTON
#  define OF_RBUTTON 0x0010
#endif
#ifndef OF_LASTOB
#  define OF_LASTOB 0x0020
#endif
#ifndef OF_TOUCHEXIT
#  define OF_TOUCHEXIT 0x0040
#endif
#ifndef OF_HIDETREE
#  define OF_HIDETREE 0x0080
#endif
#ifndef OF_INDIRECT
#  define OF_INDIRECT 0x0100
#endif
#ifndef OF_FL3DIND
#  define OF_FL3DIND 0x0200
#endif
#ifndef OF_FL3DBAK
#  define OF_FL3DBAK 0x0400
#endif
#ifndef OF_FL3DACT
#  define OF_FL3DACT 0x0600
#endif
#ifndef OF_MOVEABLE
#  define OF_MOVEABLE 0x0800
#endif
#ifndef OF_POPUP
#  define OF_POPUP 0x1000
#endif

#ifndef G_SWBUTTON
#  define G_SWBUTTON 34
#endif
#ifndef G_POPUP
#  define G_POPUP 35
#endif
#ifndef G_EDIT
#  define G_EDIT 37
#endif
#ifndef G_SHORTCUT
#  define G_SHORTCUT 38
#endif
#ifndef G_SLIST
#  define G_SLIST 39
#endif
#ifndef G_EXTBOX
#  define G_EXTBOX 40
#endif
#ifndef G_OBLINK
#  define G_OBLINK 41
#endif

#ifndef WHITEBAK
#  define WHITEBAK OS_WHITEBAK
#endif
#ifndef DRAW3D
#  define DRAW3D OS_DRAW3D
#endif
#ifndef FL3DIND
#  define FL3DIND OF_FL3DIND
#endif
#ifndef FL3DBAK
#  define FL3DBAK OF_FL3DBAK
#endif
#ifndef FL3DACT
#  define FL3DACT OF_FL3DACT
#endif

#ifndef C_UNION
#ifdef __PORTAES_H__
#  define C_UNION(x) { (_LONG_PTR)(x) }
#endif
#ifdef __GEMLIB__
#  define C_UNION(x) { (_LONG_PTR)(x) }
#endif
#ifdef __PUREC__
#  define C_UNION(x) { (_LONG_PTR)(x) }
#endif
#ifdef __ALCYON__
#  define C_UNION(x) x
#endif
#endif
#ifndef C_UNION
#  define C_UNION(x) (_LONG_PTR)(x)
#endif

#define T0OBJ 0
#define FREEBB 0
#define FREEIMG 0
#define FREESTR 13

BYTE *rs_strings[] = {
	(BYTE *)"Turbo Help 1.1",
	(BYTE *)"\275 1990 by Borland International Inc.",
	(BYTE *)"\0_______________________________________________________________",
	(BYTE *)"Keyword: _______________________________________________________________",
	(BYTE *)"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
	(BYTE *)"Cancel",
	(BYTE *)"OK",
	(BYTE *)"C Language",
	(BYTE *)"Libraries",
	(BYTE *)"Options",
	(BYTE *)"Assembler",
	(BYTE *)"Index",
	(BYTE *)"Type in your keyword or click any predefined key button."
};

LONG rs_frstr[] = {
	0
};

BITBLK rs_bitblk[] = {
	{ 0, 0, 0, 0, 0, 0 }
};

LONG rs_frimg[] = {
	0
};

ICONBLK rs_iconblk[] = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
};

TEDINFO rs_tedinfo[] = {
	{ (BYTE *)2L, (BYTE *)3L, (BYTE *)4L, 3, 6, 2, 0x1180, 0x0, -1, 64,73 }
};

OBJECT rs_object[] = {
	{ -1, 1, 11, G_BOX, OF_NONE, OS_OUTLINED, C_UNION(0x21100L), 0xfd00,0x0602, 0x004e,0x000f },
	{ 2, -1, -1, G_BUTTON, OF_SELECTABLE, OS_SHADOWED, C_UNION(0x0L), 0x0010,0x0001, 0x002c,0x0001 },
	{ 3, -1, -1, G_STRING, OF_NONE, OS_NORMAL, C_UNION(0x1L), 0x0014,0x0004, 0x0024,0x0001 },
	{ 4, -1, -1, G_FBOXTEXT, OF_EDITABLE, OS_NORMAL, C_UNION(0x0L), 0x0002,0x000b, 0x004a,0x0001 },
	{ 5, -1, -1, G_BUTTON, 0x5, OS_NORMAL, C_UNION(0x5L), 0x0038,0x000d, 0x0008,0x0001 },
	{ 6, -1, -1, G_BUTTON, 0x7, OS_NORMAL, C_UNION(0x6L), 0x0043,0x000d, 0x0008,0x0001 },
	{ 7, -1, -1, G_BUTTON, 0x5, OS_NORMAL, C_UNION(0x7L), 0x0002,0x0009, 0x000c,0x0001 },
	{ 8, -1, -1, G_BUTTON, 0x5, OS_NORMAL, C_UNION(0x8L), 0x0012,0x0009, 0x000c,0x0001 },
	{ 9, -1, -1, G_BUTTON, 0x5, OS_NORMAL, C_UNION(0x9L), 0x0021,0x0009, 0x000c,0x0001 },
	{ 10, -1, -1, G_BUTTON, 0x5, OS_NORMAL, C_UNION(0xAL), 0x0030,0x0009, 0x000c,0x0001 },
	{ 11, -1, -1, G_BUTTON, 0x5, OS_NORMAL, C_UNION(0xBL), 0x0040,0x0009, 0x000c,0x0001 },
	{ 0, -1, -1, G_STRING, OF_LASTOB, OS_NORMAL, C_UNION(0xCL), 0x000b,0x0006, 0x0038,0x0001 }
};

#define NUM_STRINGS 13
#define NUM_FRSTR 0
#define NUM_UD 0
#define NUM_IMAGES 0
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 0
#define NUM_CIB 0
#define NUM_TI 1
#define NUM_OBS 12
#define NUM_TREE 1

short rs_unused = 0;
static struct treeinfo treeinfo[NUM_TREE + 1] = { { MAIN_DIALOG, 0 }, { 0, 0 } };

BYTE pname[] = "TCHELP.RSC";

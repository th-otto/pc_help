/**************************************************/
/*                                                */
/*  H E L P F I L E - D E C O M P I L E R  V 1.0  */
/*                                                */
/*  Headerfile HELP_RC.H                          */
/*                                                */
/*  Author: Volker Reichel                        */
/*         Buehlstrasse 8                         */
/*         7507 Pfinztal 2                        */
/*                                                */
/*  Last change: 31.01.1992                       */
/**************************************************/

#include "hcint.h"

/*---------- For the output of messages -------*/
#define TO_SCREEN   0x01
#define TO_LOG      0x02
#define TO_ALL      (TO_SCREEN | TO_LOG)


#define BOLD_ON         "\033E"
#define BOLD_OFF        "\033F"
#define FORM_FEED       "\f"

/*------ Constants for memory allocation ---------*/
#define TXTBUFSIZE      0x8000L
#define MAXCODEDSIZE    0x4000L


/*--------- Description of an Index entry --------*/
typedef uint16_t SUB_IDX_ENTRY;

/*----------- Description of a name --------------*/
typedef struct name_entry {
	uint16_t scr_code;		 /* Index-Code ScreenTab */
	uint16_t link_index;	 /* link-Index ScreenTab */
	unsigned int name_idx;
	unsigned char name_attr; /* Attribute of the name */
	char *name;				 /* The name itself */
	struct name_entry *next; /* Follower */
} NAME_ENTRY;

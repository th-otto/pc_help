/*---------- General constants----------------*/

#define CR         0x0d
#define NL         0x0a
#define ESC_CHR    0x1d
#define ESC_CHR_S  "\035"
#define BACKSLASH  '\\'
#define HC_ENCRYPT 0xa3

/*------ Constants for the decoding process ------*/
#define CHAR_DIR      0x0C
#define STR_TABLE     0x0D
#define STR_NEWLINE   0x0E
#define CHAR_EMPTY    0x0F

/*-------- HC-version-dependent constants --------*/
#define INDEX_SCR   1   /* 2nd entry ScreenTab */
#define HC_MAGIC "\27590BH2.0"  /* Help compiler version */
#define INDEX_CNT   27  /* Entries in INDEX */

/*----------- Attributes of a name ---------------*/
#define SCR_NAME    0	/* ScreenName */
#define CAP_SENS    1	/* Caps/l.c. distinction */
#define SENSITIVE   2	/* No distinction */
#define LINK        3	/* is a \link-name */
#define ATTR_CNT    4	/* Number of attributes */

/*--------- Types of search-word tables ----------*/
#define CAP_TABLE   0
#define SENS_TABLE  1

/*------ reserved file indices */
#define FILEINDEX_PC   0 /* pc.hlp */
#define FILEINDEX_PD   0 /* pd.hlp */
#define FILEINDEX_C    1 /* c.hlp */
#define FILEINDEX_LIB  2 /* lib.hlp */
#define FILEINDEX_PASM 3 /* pasm.hlp */
#define FILEINDEX_USR  4 /* usr.hlp */

/*------ Header structure of a help-file ---------*/

typedef struct {
	char copyright[80];
	char magic[8];
	uint32_t scr_tab_size; 			/* Length of screen table */
	uint32_t str_offset;   			/* String-table start */
	uint32_t str_size;     			/* Length in bytes */
	unsigned char char_table[CHAR_DIR];	/* Most common characters */
	uint32_t caps_offset;  			/* Start capsens-Table */
	uint32_t caps_size;    			/* Length in Bytes (count * 6) + length of strings */
	uint32_t caps_cnt;     			/* No. of search-words */
	uint32_t sens_offset;  			/* Start sensitive-Tab. */
	uint32_t sens_size;    			/* Length in bytes (count * 6) + length of strings */
	uint32_t sens_cnt;     			/* No. of search-words */
} HLPHDR;

/*--------- Structure of the Keyword-Tables ---------*/
typedef struct {
	uint32_t pos; 					/* Word-start for current position+pos */
	uint16_t code;					/* Word has this coding */
} SRCHKEY_ENTRY;
#define SIZEOF_SRCHKEY_ENTRY 6

typedef union {
	struct {
		unsigned int hibit: 1;
		unsigned int screen_no: 12;
		unsigned int attr: 3;
	} u;
	uint16_t xcode;
} scr_code_t;

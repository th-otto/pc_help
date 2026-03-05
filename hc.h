#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#ifdef __PUREC__
#include <ext.h>
#else
#include <time.h>
#include <unistd.h>
#define getch()
#endif
#include <stdlib.h>
#include <stdint_.h>
#include "hcint.h"
#include "endian_.h"

#ifndef __PUREC__
#undef WITH_FIXES
#define WITH_FIXES 1
#endif

#ifndef FALSE
#define FALSE 0
#define TRUE  1
#endif
#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
# include <stdbool.h>
#else
typedef int bool;
#endif

#if __BYTE_ORDER__ != __ORDER_BIG_ENDIAN__
#	define MUST_SWAP 1
#endif

#define g_malloc(n) malloc(n)
#define g_new(t, n) (t *)g_malloc((n) * sizeof(t))
#define g_new0(t, n) (t *)calloc((n), sizeof(t))
#define g_free(p) free(p)
#define g_strdup(s) strdup(s)

enum {
#define HCERR(e, s) e,
#include "hcerr.h"
ERR_COUNT
};


#define LVL_FATAL   0
#define LVL_ERROR   1
#define LVL_WARNING 2

#define MAX_HELP_FILES 62
#define SCREENBUF_SIZE ((size_t)16384)
#define INBUF_SIZE ((size_t)16384)
/*
 * the maximum number of screens is not only limited by memory,
 * but also by the way screen codes are encoded
 */
#define MAX_SCREENS ((size_t)4096)

#define CTRL_Z 		'\032'
#define CTRL_Z_S 	"\032"



/* temp file for cross references */
#define HC_TMP_ENCODED "hc.$1$"
/* temp file for compressed data */
#define HC_TMP_COMPRESSED "hc.$2$"
/* temp file for string table */
#define HC_TMP_STRINGS "hc.$3$"

struct options {
	bool create_log;
	bool verbose;
	bool allow_braces; /* nowhere set */
	bool break_make;
	int tabsize;
};

enum token {
	TK_NONE = -1,
	TK_EOF = 0,
	TK_SCREEN = 1,
	TK_END = 2,
	TK_PRINT = 3,
	TK_STRING = 4,
	TK_LPAREN = 5,
	TK_RPAREN = 6,
	TK_COMMA = 7,
	TK_HASH = 8,
	TK_LINK = 9,
	TK_WAIT = 10,
	TK_CAPSENSITIVE = 11,
	TK_SENSITIVE = 12,
	TK_EXTERN = 13,
	TK_EOFCMD = 14,
	TK_NOP = 15
};

enum scope {
	SC_M2 = -2,
	SC_PLAINTEXT = -1,
	SC_NONE = 0,
	SC_STRING = 1,
	SC_KEYWORD = 2
};

typedef struct name_entry {
	char *name;
	const char *filename;
	long lineno;
	long offset;
	struct name_entry *next;
} NAME_ENTRY;

#ifndef __SIZEOF_POINTER__
#ifdef __PUREC__
#define __SIZEOF_POINTER__ 4
#endif
#endif
#ifndef __SIZEOF_POINTER__
#error "unknown sizeof(void *)"
#endif


typedef struct {
	union {
		uint32_t pos; 				/* Word-start for current position+pos */
		char *name;
	} u;
	uint16_t code;					/* Word has this coding */
} INTERNAL_SRCHKEY_ENTRY;




/*
 * main.c
 */
extern unsigned char *hc_inbuf;
extern unsigned char *screenbuf;
extern unsigned char *hc_inbuf_ptr;
extern unsigned char *screenbuf_ptr;
extern char outfile_name[64];
extern size_t hc_inbuf_size;
extern int file_index;
extern struct options options;

char *xbasename(const char *path);
void compile_files(int nfiles, char **names);


/*
 * hcio.c
 */
extern const char *err_filename;
extern FILE *hc_infile;
extern FILE *hc_outfile;
extern int errors_thisfile;
extern int warnings_thisfile;
extern FILE *logfile;
extern long err_lineno;

unsigned char hc_getc(void);
bool hc_putc(unsigned char b);
bool hc_putw(/* unsigned */ short w);
bool hc_puts(const char *);
void hc_flshbuf(void);
unsigned char hc_fillbuf(void);
size_t hc_fread(FILE *fp, size_t count, void *ptr);
bool hc_fwrite(FILE *fp, size_t count, void *ptr);
void hc_openfile(char *filename);
void hc_createfile(const char *filename);
void log_open(void);
void hc_closeout(void);
void log_close(void);
void hc_closein(void);
void hc_copyfile(char *filename);


/*
 * hclog.c
 */
extern long errors_total;
extern long warnings_total;
extern const char *const errmsg[ERR_COUNT];

void hclog(int errcode, int level, ...);
void logstr(const char *str);
void cleanup(void);


/*
 * hcparse.c
 */
extern int brace_level;

void parse_file(void);
void hc_skipto(enum token token, enum scope scope);


/*
 *
 */
struct keyword {
	enum token token;
	const char *name;
};
#define CC_CR         2
#define CC_WHITESPACE 3
extern unsigned char const character_class[256];
extern struct keyword const keywords[];
extern bool in_screen;
extern bool in_link;
extern long input_lineno;
extern char cur_identifier[];
extern enum token hc_curtok;
extern enum scope hc_curscope;

enum token hc_gettok(void);
void hc_backtok(void);
void hc_back(void);
void parse_identifier(unsigned char c);
void parse_string(void);
void parse_keyword(void);
void parse_link(char *s);
void skip_space(void);

/*
 * hchash.c
 */
struct hashitem {
	enum token type;
	const char *name;
	struct hashitem *next;
};

#define KEYW_HASH_SIZE 211
extern struct hashitem *keyword_hash[];
extern uint32_t *screen_table_offset;
extern HLPHDR helphdr;
extern const char *last_indexentry_name;
extern NAME_ENTRY *namelist;
extern int screen_cnt;
extern size_t screen_start;

unsigned int calchash(const char *s, unsigned int hashsize);
void init_keyword_hash(void);
void add_name(const char *name, const char *filename, long lineno, long offset);
void write_help(void);
void free_keyword_hash(void);
void do_references(const char *tmpname);


/*
 * hcindex.c
 */
extern const char *month_names[];
extern INTERNAL_SRCHKEY_ENTRY *caps_table;
extern size_t caps_cnt;
extern INTERNAL_SRCHKEY_ENTRY *sens_table;
extern size_t sens_cnt;
extern long caps_size;
extern long sens_size;


void generate_index(void);
void add_index_entry(const char *s, int screen_no, int attr);
int16_t get_index_screen_code(const char *s);
void generate_index_page(void);
void clear_index(void);
void free_index(void);
void generate_copyright_page(void);


/*
 * hccompr.c
 */
void do_compress(void);



#if !defined(__TOS__) && !defined(__atarist__)
void atari_strupr(char *s);
#else
#define atari_strupr(s) strupr(s)
#endif

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#if defined(__PUREC__) || defined(__TURBOC__)
#include <aes.h>
#include <vdi.h>
#if defined(__STDIO)
#define ORIG_PUREC
#endif
#ifdef ORIG_PUREC
#define EVNT_TIME(lo) lo, 0
#endif
#define DTA _DTA
#define d_fname dta_name
#include <tos.h>
#ifndef SuperToUser
#define SuperToUser(sp) Super(sp)
#endif
#else
#include <time.h>
#include <unistd.h>
#include <gem.h>
#include <osbind.h>
extern short _app;
#endif
#include <stdlib.h>
#include <stdint_.h>

#ifndef FA_RDONLY
#  define FA_RDONLY 0x01
#endif
#ifndef FA_HIDDEN
#  define FA_HIDDEN 0x02
#endif
#ifndef FA_DIREC
#  define FA_DIREC  0x10
#endif

#ifndef EVNT_TIME
#define EVNT_TIME(lo) lo
#endif

#ifndef FALSE
#define FALSE 0
#define TRUE  1
#endif
#ifndef DESK
#  define DESK 0
#endif
#undef NIL
#define NIL (-1)

#ifndef G_BLACK
#define G_WHITE			0
#define G_BLACK			1
#define G_RED			2
#define G_GREEN			3
#define G_BLUE			4
#define G_CYAN			5
#define G_YELLOW		6
#define G_MAGENTA		7
#define G_LWHITE		8
#define G_LBLACK		9
#define G_LRED			10
#define G_LGREEN		11
#define G_LBLUE			12
#define G_LCYAN			13
#define G_LYELLOW		14
#define G_LMAGENTA		15
#endif

#ifndef OS_SELECTED
#  define OS_SELECTED 0x0001
#endif

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
# include <stdbool.h>
#else
typedef int bool;
#endif

#ifndef _WORD
#if defined(__PUREC__) || defined(__TURBOC__)
#define _WORD int
#else
#define _WORD short
#endif
#endif

#define LINK_SIZE 64
#define TABSIZE 4

/* values for wintype field */
#define WINTYPE_FILE 0
#define WINTYPE_LOG  1
#define WINTYPE_HELP 2



#define FNAME_MAX 128

struct membuf {
	char *buf;
	size_t size;
};
#define MAX_BUFFER_MARKS 8
struct memfd {
	struct membuf *buf;
	long last_used;
	long inserted;
	long first_used;
	long marks[MAX_BUFFER_MARKS];
};


/*
 * main.c
 */
extern _WORD phys_handle;
extern _WORD vdi_handle;
extern _WORD vdi_planes;
extern _WORD screen_width;
extern _WORD screen_height;
extern _WORD gl_wchar;
extern _WORD gl_hchar;
extern _WORD ap_id;


/*
 * help.c
 */
#define HELP_MODE_LANGUAGE 0
#define HELP_MODE_LIBRARIES 1
#define HELP_MODE_OPTIONS 2
#define HELP_MODE_ASSEMBLER 3
#define HELP_MODE_INDEX 4

#define HELP_MAX_DEPTH 9
bool help_undo(void);
bool help_close(void);
void help_set_title(void);
bool help_show(int mode);
bool help_show_topic(const char *str);


/*
 * display.c
 */
void editwin_set_cursor(_WORD cursor_y, _WORD cursor_x);
void edit_set_help(const char *title, const char *str, long len, bool settext);
void edit_init(void);
bool edit_closewind(bool deletewind);
bool edit_undo(void);
bool edit_key(int key);
void edit_copy(void);
void edit_set_wininfo(_WORD lines, _WORD columns);
void edit_win_redraw(void);
void edit_scroll_wind(_WORD ydir, _WORD xdir);
void edit_win_clicked(_WORD row, _WORD column);
void edit_win_double_click(_WORD row, _WORD column);
void edit_set_slider(bool horizontal, _WORD pos, _WORD size);
void edit_get_selection(long *start, long *end);
void edit_select(long start, long end);
int edit_max_title_len(void);
int edit_open_special(const char *title, int type);


/*
 * win.c
 */
#define SL_VSLIDE 0
#define SL_HSLIDE 1
#define SL_VSLSIZE 2
#define SL_HSLSIZE 3

struct windinfo {
	/*  0 */ _WORD xpos;
	/*  2 */ _WORD ypos;
	/*  4 */ _WORD columns;
	/*  6 */ _WORD lines;
};

void win_init(void);
void win_set_cursor(_WORD cursor_y, _WORD cursor_x);
void arrow_wind(_WORD arrow);
void full_wind(void);
void close_wind(_WORD wh);
void redraw_wind(_WORD wh);
void win_is_top(_WORD wh);
void win_set_top(void);
void move_wind(GRECT *gr);
void win_invert_line(_WORD y, _WORD x1, _WORD x2);
void win_clear_lines(_WORD line, _WORD height);
void win_draw_str(_WORD line, char *str, _WORD first_char, _WORD width);
void win_scroll(_WORD y, _WORD x, _WORD h, _WORD w, _WORD offset);
void win_close(bool deletewin);
void win_set_slider(_WORD type, long pos, long size);
void win_cursor_on(void);
void win_cursor_off(void);
_WORD win_create(struct windinfo *info, const char *title);
void win_set_name(const char *name);
bool win_is_fully_visible(void);
void win_start_redraw(void);
void win_select_region(_WORD mox, _WORD moy, _WORD clicks);
_WORD win_get_handle(void);
void win_timer(void);


/*
 * rsc.c
 */
#undef min
#undef max
void Pling(void);
_WORD min(_WORD a, _WORD b);
_WORD max(_WORD a, _WORD b);
void mouse_on(void);
void mouse_off(void);
OBJECT *obj_addr(_WORD tree, _WORD obj);
void obj_deselect(_WORD tree, _WORD obj);
void get_ptext(_WORD tree, _WORD obj, char *buf);
void show_alert(short code, const char *arg);
void arrow_mouse(void);
void form_dial_rect(_WORD type, const GRECT *gr);
void center_dialog(OBJECT *tree, GRECT *gr);

void clear_rect(_WORD x, _WORD y, _WORD w, _WORD h);
void copy_grect(const GRECT *src, const GRECT *dst);
void fast_copy_grect(GRECT *gr, _WORD h);
_WORD do_dialog(_WORD treenr, _WORD startob);

_WORD rc_equal(const GRECT *gr1, const GRECT *gr2);
_WORD rc_intersect(const GRECT *gr1, GRECT *gr2);
void rsrc_fix(void);



/*
 * membuf.c
 */
extern struct memfd *cur_memfd;

void *m_alloc(size_t size);
int m_free(void *ptr);
void memfd_init(void);
void memfd_readbuf(off_t start, char *dst, ssize_t count);
int memfd_writebuf(off_t start, ssize_t delete, ssize_t insert, const char **src);
int memfd_getc(off_t start);
off_t memfd_getsize(void);
int memfd_new(void);
int memfd_new_mark(long start);
long memfd_get_current_mark(int i);
void memfd_set_mark(int i, long start);
void memfd_clear_mark(int i);
long memfd_get_mark(int fd, int i);
void membuf_init(void);
struct membuf *membuf_alloc(size_t size);
int membuf_realloc(struct membuf *buf, size_t size);
void membuf_sort(void);
void membuf_free(struct membuf *buf);
void memfd_freebuf(void);


/*
 * utils
 */

long find_str_forward(long, const char *, char casesensitive);
long find_str_backward(long, const char *, char casesensitive);


/*
 * util5.s/pchlplib.c
 */
int help_init(const char *pc_dir);
int help_find_online(char *link, const char **str, long *len);
int help_exit(void);


/*
 * util7.s/pchlplib.c
 */
#if defined(__PUREC__) && 0
/* for reference; only called from assembler so no need to declare it here */
void binsearch_init(const void *table, int (*func)(const void *, const void *), size_t num_entries, size_t entrysize);
int binsearch(const char *key);
#endif


/*
 * mmalloc.c
 */
int x_free(void *ptr);
int x_realloc(void *ptr, size_t size);
void *x_malloc(size_t size);
void *m_realloc(void *ptr, size_t size);
void *memrealloc(void *ptr);

#include "pc_help.h"
#include "hcint.h"
#include "alerts.h"

typedef struct {
	_WORD x1;
	_WORD y1;
	_WORD x2;
	_WORD y2;
} PXY4;

struct windtab {
	GRECT work;
	_WORD wh;
	_WORD cursor_y;
	_WORD cursor_x;
	char cursor_state;
	_WORD is_normal;
};

#define CURSOR_OFF     0 /* off */
#define CURSOR_ON      1 /* on, but not yet drawn */
#define CURSOR_DRAWN   2 /* currently drawn */
#define CURSOR_UNDRAWN 3 /* undrawn because of blinking or active selection */

#define MAX_WIND 1

#if !WITH_FIXES
void *physbase;
#endif
static struct windtab windtab[MAX_WIND];
static bool wind_was_clipped;
static bool redraw_clip_flag;
static PXY4 redraw_clip;
static _WORD win_x_margin;
static _WORD win_y_margin;
static GRECT full;
static GRECT winwork;
#if !WITH_FIXES
static short not_st_high;
#endif

#define ed_wchar gl_wchar
#define ed_hchar gl_hchar

static bool mywind_is_top = FALSE;
static int update_calls = 0;

#define LINK_EFFECTS 0x09 /* bold & underline */

#define WIND_KIND (NAME|CLOSER|FULLER|MOVER|SIZER|UPARROW|DNARROW|VSLIDE|LFARROW|RTARROW|HSLIDE)


/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void win_init(void)
{
	_WORD dummy;
	
#if !WITH_FIXES
	not_st_high = (Blitmode(-1) & 1) || screen_height != 399 || screen_width != 639 || vdi_planes != 1;
#endif
	vst_alignment(vdi_handle, 0, 5, &dummy, &dummy);
	vswr_mode(vdi_handle, MD_REPLACE);
	win_x_margin = ed_wchar / 2;
	win_y_margin = ed_hchar / 4;
	wind_get(DESK, WF_WORKXYWH, &full.g_x, &full.g_y, &full.g_w, &full.g_h);
	wind_calc(WC_WORK, WIND_KIND, full.g_x, full.g_y, full.g_w, full.g_h, &winwork.g_x, &winwork.g_y, &winwork.g_w, &winwork.g_h);
}

/* ---------------------------------------------------------------------- */

static void clip_pxy(bool flag, PXY4 *pxy)
{
	redraw_clip_flag = flag;
	redraw_clip = *pxy;
	vs_clip(vdi_handle, flag, &pxy->x1);
}

/* ---------------------------------------------------------------------- */

static void clip_wind(void)
{
	PXY4 pxy;
	bool flag;
	
#ifdef __GNUC__
	{
		PXY4 *pp = (PXY4 *)&windtab[0].work;
		pxy = *pp;
	}
#else
	pxy = *(PXY4 *)&windtab[0].work;
#endif
	flag = FALSE;
	pxy.x2 += pxy.x1 - 1;
	pxy.y2 += pxy.y1 - 1;
	if (pxy.x2 > screen_width)
	{
		pxy.x2 = screen_width;
		flag = TRUE;
	}
	if (pxy.y2 > screen_height)
	{
		pxy.y2 = screen_height;
		flag = TRUE;
	}
	clip_pxy(flag, &pxy);
}

/* ---------------------------------------------------------------------- */

static void wnd_update(_WORD type)
{
	if (type == BEG_UPDATE)
	{
		if (update_calls++ == 0)
			wind_update(BEG_UPDATE);
	} else if (type == END_UPDATE)
	{
		if (--update_calls == 0)
			wind_update(END_UPDATE);
	} else
	{
		wind_update(type);
	}
}

/* ---------------------------------------------------------------------- */

static void invert_cursor(void)
{
	struct windtab *win;
	_WORD xoff;
	_WORD ysize;
	_WORD xend;
	_WORD yend;
	_WORD screen_maxx;
	_WORD screen_maxy;
	_WORD mox;
	_WORD moy;
	_WORD mstate;
	_WORD kstate;
	bool mouse_flag;

	wnd_update(BEG_UPDATE);
	if (!wind_was_clipped)
		clip_wind();
	win = &windtab[0];
	xoff = ed_wchar / 4;
	ysize = ed_hchar;
	xend = windtab[0].cursor_x * ed_wchar + win->work.g_x; /* XXX use win */
	xend += win_x_margin / 2;
	yend = windtab[0].cursor_y * ysize + win->work.g_y + win_y_margin;
	screen_maxx = min(win->work.g_x + win->work.g_w, screen_width);
	screen_maxy = min(win->work.g_y + win->work.g_h, screen_height);
	if (xend >= win->work.g_x &&
		yend >= win->work.g_y &&
		xend + xoff + 4 < screen_maxx &&
		yend + ysize < screen_maxy)
	{
		graf_mkstate(&mox, &moy, &mstate, &kstate);
		mox -= xend;
		moy -= yend;
		if (mox < 0)
			mox = -mox;
		if (moy < 0)
			moy = -moy;
		if (max(mox, moy) < ed_hchar * 2 + ysize)
		{
			mouse_flag = TRUE;
			mouse_off();
		} else
		{
			mouse_flag = FALSE;
		}
		vsf_color(vdi_handle, G_BLACK);
		vswr_mode(vdi_handle, MD_XOR);
		/*
		 * draws cursor looking like:
		 *        ******
		 *         ****
		 *          **
		 *          **
		 *          **
		 *          **
		 *          **
		 *          **
		 *         ****
		 *        ******
		 */
		/* draw top line */
		clear_rect(xend, yend, xoff + 4, 1);
		/* draw line below top */
		clear_rect(xend + 1, yend + 1, xoff + 2, 1);
		/* draw beam */
		clear_rect(xend + 2, yend + 2, xoff, ed_hchar - 2);
		/* draw line above bottom */
		clear_rect(xend + 1, yend + ed_hchar, xoff + 2, 1);
		/* draw bottom line */
		clear_rect(xend, yend + ed_hchar + 1, xoff + 4, 1);
	
		vsf_color(vdi_handle, G_WHITE);
		vswr_mode(vdi_handle, MD_REPLACE);
#if WITH_FIXES
		if (mouse_flag)
			mouse_on();
#endif
	}
#if !WITH_FIXES
	if (mouse_flag) /* BUG: misplaced: mouse_flag only set inside if */
		mouse_on();
#endif
	wnd_update(END_UPDATE);
}

/* ---------------------------------------------------------------------- */

static void start_redraw(void)
{
	if (!wind_was_clipped)
	{
		if (windtab[0].cursor_state == CURSOR_DRAWN)
		{
			windtab[0].cursor_state = CURSOR_ON;
			invert_cursor();
		}
		clip_wind();
		wind_was_clipped = TRUE;
	}
}

/* ---------------------------------------------------------------------- */

bool win_is_fully_visible(void)
{
	struct windtab *win;
	
	win = &windtab[0];
	if (win->work.g_x >= 0 &&
		win->work.g_y >= 0 &&
		win->work.g_x + win->work.g_w - 1 <= screen_width &&
		win->work.g_y + win->work.g_h - 1 <= screen_height)
		return TRUE;
	return FALSE;
}

/* ---------------------------------------------------------------------- */

void win_start_redraw(void)
{
	_WORD x, y, w, h;
	
	x = windtab[0].work.g_x;
	y = windtab[0].work.g_y;
	w = windtab[0].work.g_w;
	h = windtab[0].work.g_h;
	start_redraw();
	wnd_update(BEG_UPDATE);
	vsf_interior(vdi_handle, FIS_SOLID);
	vsf_color(vdi_handle, G_WHITE);
	clear_rect(x, y, w, win_y_margin);
	clear_rect(x, y, win_x_margin, h);
	clear_rect(x, y + h - win_y_margin, w, win_y_margin);
	clear_rect(x + w - win_x_margin, y, win_x_margin, h);
	wnd_update(END_UPDATE);
}

/* ---------------------------------------------------------------------- */

void win_draw_str(_WORD line, char *str, _WORD first_char, _WORD width)
{
	_WORD x, y;
	_WORD w;
	GRECT gr;
	char *p;
	
	x = windtab[0].work.g_x + win_x_margin;	 /* XXX use pointer */
	y = windtab[0].work.g_y + win_y_margin + line * ed_hchar;
	w = windtab[0].work.g_w - 2 * win_x_margin;
	start_redraw();
	if (redraw_clip_flag)
	{
		gr.g_x = x;
		gr.g_y = y;
		gr.g_w = w;
		gr.g_h = ed_hchar;
		if (!rc_intersect((GRECT *)&redraw_clip, &gr)) /* BUG: redraw_clip is not a GRECT */
			return;
	}
	
	wnd_update(BEG_UPDATE);
	if (width <= 0)
	{
		width = 0;
	} else
	{
		_WORD effects = 0;
		_WORD column = 0;
		while (*str != '\0' && column < first_char)
		{
			if (*str++ == ESC_CHR)
			{
				if (effects != 0)
					effects = 0;
				else
					effects = LINK_EFFECTS; 
			} else
			{
				column++;
			}
		}
		column = 0;
		for (;;)
		{
			p = strchr(str, ESC_CHR);
			if (p == NULL)
				break;
			*p = '\0';
			vst_effects(vdi_handle, effects);
			v_gtext(vdi_handle, x + column * ed_wchar, y, str);
			if (effects != 0)
				effects = 0;
			else
				effects = LINK_EFFECTS; 
			column += (_WORD)(p - str);
			str = p + 1;
		}
		vst_effects(vdi_handle, effects);
		v_gtext(vdi_handle, x + column * ed_wchar, y, str);
		vst_effects(vdi_handle, 0);
	}
	clear_rect(x + width * ed_wchar, y, w - width * ed_wchar, ed_hchar);
	wnd_update(END_UPDATE);
}

/* ---------------------------------------------------------------------- */

void win_clear_lines(_WORD line, _WORD height)
{
	struct windtab *win;
	
	win = &windtab[0];
	start_redraw();
	clear_rect(win->work.g_x, win->work.g_y + win_y_margin + line * ed_hchar, win->work.g_w, height * ed_hchar);
}

/* ---------------------------------------------------------------------- */

void win_is_top(_WORD wh)
{
	struct windtab *win = windtab;
	
	if (wh == win->wh && wh != DESK)
		mywind_is_top = TRUE;
	else
		mywind_is_top = FALSE;
}

/* ---------------------------------------------------------------------- */

void win_set_top(void)
{
	wind_set(windtab[0].wh, WF_TOP, 0, 0, 0, 0);
}

/* ---------------------------------------------------------------------- */

static _WORD x_align(_WORD x)
{
	x += win_x_margin;
	x -= x % 8;
	x -= win_x_margin;
	if (x < 0)
		x += 8;
	return x;
}

/* ---------------------------------------------------------------------- */

_WORD win_create(struct windinfo *info, const char *title)
{
	_WORD wh;
	struct windtab *win;
	_WORD x; /* FIXME: use grect */
	_WORD y;
	_WORD w;
	_WORD h;
	
	if (windtab[0].wh != 0)
		return AL_NO_MORE_WINDS;
	wh = wind_create(WIND_KIND, full.g_x, full.g_y, full.g_w, full.g_h);
	if (wh < 0)
		return AL_NO_MORE_WINDS;
	mouse_off();
#if defined(__GEMLIB__) || defined(__PORTAES_H__)
	wind_set_str(wh, WF_NAME, title);
#else
	wind_set(wh, WF_NAME, title, 0, 0);
#endif
	win = &windtab[0];
	win->wh = wh;
	win->is_normal = TRUE;
	if (info->xpos != -1)
	{
		win->work.g_x = info->xpos * ed_wchar;
		win->work.g_y = info->ypos * ed_hchar;
	} else
	{
		win->work.g_x = ed_wchar;
		win->work.g_y = ed_hchar;
	}
	win->work.g_x += winwork.g_x;
	win->work.g_y += winwork.g_y;
#if WITH_FIXES
	if (win->work.g_x > winwork.g_x + winwork.g_w + 2 * ed_wchar)
		win->work.g_x = winwork.g_x + winwork.g_w + 2 * ed_wchar;
	if (win->work.g_y > winwork.g_y + winwork.g_h)
		win->work.g_y = winwork.g_y + winwork.g_h;
#endif
	win->work.g_x = x_align(win->work.g_x);
	win->work.g_w = info->columns * ed_wchar + 2 * win_x_margin;
	if (win->work.g_w > winwork.g_w)
	{
		info->columns = (winwork.g_w - 2 * win_x_margin) / ed_wchar;
		win->work.g_w = info->columns * ed_wchar + 2 * win_x_margin;
	}
	win->work.g_h = info->lines * ed_hchar + 2 * win_y_margin;
	if (win->work.g_h > winwork.g_h)
	{
		info->lines = (winwork.g_h - 2 * win_y_margin) / ed_hchar;
		win->work.g_h = info->lines * ed_hchar + 2 * win_y_margin;
	}
	wind_calc(WC_BORDER, WIND_KIND, win->work.g_x, win->work.g_y, win->work.g_w, win->work.g_h, &x, &y, &w, &h);
	wind_open(wh, x, y, w, h);
	start_redraw();
	vsf_interior(vdi_handle, FIS_SOLID);
	vsf_color(vdi_handle, G_WHITE);
	clear_rect(win->work.g_x, win->work.g_y, win->work.g_w, win->work.g_h);
	wind_was_clipped = FALSE;
	mouse_on();
	
	return 0;
}

/* ---------------------------------------------------------------------- */

void win_set_name(const char *name)
{
#if defined(__GEMLIB__) || defined(__PORTAES_H__)
	wind_set_str(windtab[0].wh, WF_NAME, name);
#else
	wind_set(windtab[0].wh, WF_NAME, name, 0, 0);
#endif
}

/* ---------------------------------------------------------------------- */

void move_wind(GRECT *gr)
{
	struct windtab *win;
	_WORD columns;
	_WORD lines;
	
	win = &windtab[0];
	windtab[0].is_normal = TRUE;
	wind_calc(WC_WORK, WIND_KIND, gr->g_x, gr->g_y, gr->g_w, gr->g_h, &win->work.g_x, &win->work.g_y, &win->work.g_w, &win->work.g_h);
	win->work.g_x = x_align(win->work.g_x);
	columns = (win->work.g_w - 2 * win_x_margin) / ed_wchar;
	lines = (win->work.g_h - 2 * win_y_margin) / ed_hchar;
	win->work.g_w = columns * ed_wchar + 2 * win_x_margin;
	win->work.g_h = lines * ed_hchar + 2 * win_y_margin;
	/* FIXME: should not modify *gr */
	wind_calc(WC_BORDER, WIND_KIND, win->work.g_x, win->work.g_y, win->work.g_w, win->work.g_h, &gr->g_x, &gr->g_y, &gr->g_w, &gr->g_h);
	wind_set(windtab[0].wh, WF_CURRXYWH, gr->g_x, gr->g_y, gr->g_w, gr->g_h);
	edit_set_wininfo(lines, columns);
	help_set_title();
	win_start_redraw();
}

/* ---------------------------------------------------------------------- */

void full_wind(void)
{
	GRECT gr;
	_WORD is_normal;
	_WORD wh;

	wh = windtab[0].wh;	
	is_normal = windtab[0].is_normal;
	if (is_normal)
		wind_get(wh, WF_FULLXYWH, &gr.g_x, &gr.g_y, &gr.g_w, &gr.g_h);
	else
		wind_get(wh, WF_PREVXYWH, &gr.g_x, &gr.g_y, &gr.g_w, &gr.g_h);
	move_wind(&gr);
	if (is_normal)
		windtab[0].is_normal = FALSE;
}

/* ---------------------------------------------------------------------- */

void win_close(bool deletewin)
{
	_WORD wh;
	_WORD top;
	
	wh = windtab[0].wh;
	windtab[0].wh = 0;
#if defined(__GEMLIB__) || defined(__PORTAES_H__)
	wind_get_int(-1, WF_TOP, &top);
#else
	wind_get(-1, WF_TOP, &top);
#endif
	if (top == wh && deletewin)
	{
		wind_close(wh);
		wind_delete(wh);
	}
	mywind_is_top = FALSE;
}

/* ---------------------------------------------------------------------- */

void win_scroll(_WORD y, _WORD x, _WORD h, _WORD w, _WORD offset)
{
	struct windtab *win;
	GRECT gr;
	GRECT dst;
	
	win = &windtab[0];
	gr.g_x = win->work.g_x + win_x_margin + x * ed_wchar;
	gr.g_y = win->work.g_y + win_y_margin + y * ed_hchar;
	gr.g_w = w * ed_wchar;
	gr.g_h = h * ed_hchar;
	start_redraw();
	mouse_off();
#if !WITH_FIXES
	if (!not_st_high)
	{
		physbase = Logbase();
		fast_copy_grect(&gr, offset * ed_hchar);
	} else
#endif
	{
		dst = gr;
		dst.g_y += offset * ed_hchar;
		copy_grect(&gr, &dst);
	}
	mouse_on();
}

/* ---------------------------------------------------------------------- */

void redraw_wind(_WORD wh)
{
	GRECT gr;
	PXY4 pxy;
	GRECT work;
	_WORD flag;
	
	if (wh != windtab[0].wh)
		return;
	work = windtab[0].work;
	wind_get(wh, WF_FIRSTXYWH, &gr.g_x, &gr.g_y, &gr.g_w, &gr.g_h);
	mouse_off();
	wnd_update(BEG_UPDATE);
	wind_was_clipped = TRUE;
	work.g_w = min(work.g_w, screen_width - work.g_x + 1);
	work.g_h = min(work.g_h, screen_height - work.g_y + 1);
	while (gr.g_w > 0 && gr.g_h > 0)
	{
		if (rc_intersect(&work, &gr))
		{
#ifdef __GNUC__
			{
			PXY4 *pp = (PXY4 *)&gr;
			pxy = *pp;
			}
#else
			pxy = *((PXY4 *)&gr);
#endif
			pxy.x2 += pxy.x1 - 1;
			pxy.y2 += pxy.y1 - 1;
			flag = !rc_equal(&gr, &windtab[0].work);
			clip_pxy(flag, &pxy);
			edit_win_redraw();
			if (windtab[0].cursor_state == CURSOR_DRAWN)
				invert_cursor();
		}
		wind_get(wh, WF_NEXTXYWH, &gr.g_x, &gr.g_y, &gr.g_w, &gr.g_h);
	}
	wnd_update(END_UPDATE);
	wind_was_clipped = FALSE;
	mouse_on();
}

/* ---------------------------------------------------------------------- */

static _WORD x_column(_WORD x1, _WORD x2)
{
	return ((x2 - x1) - win_x_margin + ed_wchar / 2) / ed_wchar;
}

/* ---------------------------------------------------------------------- */

static _WORD x_row(_WORD y1, _WORD y2)
{
	return ((y2 - y1) - win_y_margin) / ed_hchar;
}

/* ---------------------------------------------------------------------- */

void win_select_region(_WORD x, _WORD y, _WORD clicks)
{
	struct windtab *win;
	_WORD rows;
	_WORD columns;
	
	if (!mywind_is_top)
		return;
	win = &windtab[0];
	if (x < win->work.g_x)
		return;
	if (y < win->work.g_y)
		return;
	if (x >= win->work.g_x + win->work.g_w)
		return;
	if (y >= win->work.g_y + win->work.g_h)
		return;
	rows = x_row(win->work.g_y, y);
	columns = x_column(win->work.g_x, x);
	if (clicks >= 2)
	{
		edit_win_double_click(rows, columns);
		return;
	}
	edit_win_clicked(rows, columns);
}

/* ---------------------------------------------------------------------- */

void arrow_wind(_WORD what)
{
	_WORD columns;
	_WORD rows;
	struct windtab *win;
	
	mouse_off();
	win = &windtab[0];
	columns = (win->work.g_w - 2 * win_x_margin) / ed_wchar;
	rows = (win->work.g_h - 2 * win_y_margin) / ed_hchar;
	switch (what)
	{
	case WA_UPPAGE:
		edit_scroll_wind(-(rows - 2), 0);
		break;
	case WA_DNPAGE:
		edit_scroll_wind(rows - 2, 0);
		break;
	case WA_UPLINE:
		edit_scroll_wind(-1, 0);
		break;
	case WA_DNLINE:
		edit_scroll_wind(1, 0);
		break;
	case WA_LFPAGE:
		edit_scroll_wind(0, -columns / 2);
		break;
	case WA_RTPAGE:
		edit_scroll_wind(0, columns / 2);
		break;
	case WA_LFLINE:
		edit_scroll_wind(0, -4);
		break;
	case WA_RTLINE:
		edit_scroll_wind(0, 4);
		break;
	}
	mouse_on();
	wind_was_clipped = FALSE;
}

/* ---------------------------------------------------------------------- */

void win_invert_line(_WORD y, _WORD x1, _WORD x2)
{
	struct windtab *win;
	
	win = &windtab[0];
	start_redraw();
	mouse_off();
	vsf_color(vdi_handle, G_BLACK);
	vswr_mode(vdi_handle, MD_XOR);
	clear_rect(win->work.g_x + win_x_margin + x1 * ed_wchar, win->work.g_y + win_y_margin + y * ed_hchar, (x2 - x1) * ed_wchar, ed_hchar);
	vsf_color(vdi_handle, G_WHITE);
	vswr_mode(vdi_handle, MD_REPLACE);
	mouse_on();
}

/* ---------------------------------------------------------------------- */

void win_set_slider(_WORD type, long pos, long size)
{
	struct windtab *win;
	_WORD oldval;
	_WORD dummy;
	_WORD val;
	static _WORD const slidtab[4] = { WF_VSLIDE, WF_HSLIDE, WF_VSLSIZE, WF_HSLSIZE };
	
	win = &windtab[0];
	if (size == 0)
	{
		val = 1000;
	} else
	{
		val = (_WORD)(pos * 1000 / size);
	}
	wind_get(win->wh, slidtab[type], &oldval, &dummy, &dummy, &dummy);
	if (oldval != val)
		wind_set(win->wh, slidtab[type], val, 0, 0, 0);
}

/* ---------------------------------------------------------------------- */

void win_set_cursor(_WORD cursor_y, _WORD cursor_x)
{
	struct windtab *win = &windtab[0];

	if (win->cursor_state == CURSOR_DRAWN)
		invert_cursor();
	win->cursor_y = cursor_y;
	win->cursor_x = cursor_x;
	win->cursor_state = CURSOR_DRAWN;
	invert_cursor();
}

/* ---------------------------------------------------------------------- */

void win_cursor_on(void)
{
	if (windtab[0].cursor_state == CURSOR_OFF)
		windtab[0].cursor_state = CURSOR_ON;
}

/* ---------------------------------------------------------------------- */

void win_cursor_off(void)
{
	if (windtab[0].cursor_state == CURSOR_DRAWN)
		invert_cursor();
	windtab[0].cursor_state = CURSOR_OFF;
}

/* ---------------------------------------------------------------------- */

void win_timer(void)
{
	struct windtab *win;
	
	if (mywind_is_top)
	{
		win = &windtab[0];
		if (win->cursor_state == CURSOR_DRAWN)
		{
			invert_cursor();
			win->cursor_state = CURSOR_ON;
		} else if (win->cursor_state == CURSOR_ON)
		{
			invert_cursor();
			win->cursor_state = CURSOR_DRAWN;
		}
	}
	wind_was_clipped = FALSE;
}

/* ---------------------------------------------------------------------- */

_WORD win_get_handle(void)
{
	return windtab[0].wh;
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

#define BYTE char
#define LONG long
#define WORD _WORD
struct treeinfo {
	_WORD tree;
	_WORD dummy;
};
#include "pchlprsc.h"
#if WITH_FIXES
#include "pchlprsc.rsh"
static struct treeinfo treeinfo[2] = { { MAIN_DIALOG, 0 }, { 0, 0 } };
#else
#include "tchlprsc.rsh"
#endif

#if defined(__PUREC__) && !WITH_FIXES
/* unused here; need this only for the string constant */
void getpath(char *path)
{
	strcpy(path, "\\");
}
#endif

/* FIXME: move to resource */
struct alertmsg {
	short code;
	const char *msg;
};
#define N_(x) x
static struct alertmsg const alertmsg_table[] = {
	{ AL_INTERNAL, N_("[3][|Internal error 2][ Ok ]") },
	{ AL_LOWMEM, N_("[3][|Running out of memory][ Ok ]") },
	{ AL_HELP_KEYWORD, N_("[3][|Help: Keyword not found][ Ok ]") },
	{ AL_LOW_RESOLUTION, "[3][|HELP can't run in low resolution][ Ok ]" },
	{ -998, "[3][|HELP stack overflow|Be very careful][ Ok ]" },
	{ AL_BAD_HELPFILE, N_("[3][|Bad help file][ Ok ]") },
	{ AL_HELP_NOT_FOUND, N_("[3][|Help file not found][ Ok ]") },
	{ 0, N_("[3][|Internal error][ Ok ]") }
};

/* ---------------------------------------------------------------------- */

void mouse_on(void)
{
	v_show_c(vdi_handle, 1);
}

/* ---------------------------------------------------------------------- */

void mouse_off(void)
{
	v_hide_c(vdi_handle);
}

/* ---------------------------------------------------------------------- */

void arrow_mouse(void)
{
	graf_mouse(ARROW, NULL);
}

/* ---------------------------------------------------------------------- */

OBJECT *obj_addr(_WORD tree, _WORD obj)
{
	return &rs_object[treeinfo[tree].tree + obj];
}

/* ---------------------------------------------------------------------- */

void obj_deselect(_WORD tree, _WORD obj)
{
	obj_addr(tree, obj)->ob_state &= ~OS_SELECTED;
}

/* ---------------------------------------------------------------------- */

void get_ptext(_WORD tree, _WORD obj, char *str)
{
	TEDINFO *ted = obj_addr(tree, obj)->ob_spec.tedinfo;
	char *src = ted->te_ptext;
	_WORD len = ted->te_txtlen;
	
	while (--len >= 0 && (*str++ = *src++) != '\0')
		;
#if !WITH_FIXES
	*str = '\0'; /* BUG: NUL byte already copied */
#endif
}

/* ---------------------------------------------------------------------- */

void form_dial_rect(_WORD type, const GRECT *gr)
{
	form_dial(type, 0, 0, 0, 0, gr->g_x, gr->g_y, gr->g_w, gr->g_h);
}

/* ---------------------------------------------------------------------- */

void center_dialog(OBJECT *tree, GRECT *gr)
{
	form_center(tree, &gr->g_x, &gr->g_y, &gr->g_w, &gr->g_h);
}

/* ---------------------------------------------------------------------- */

_WORD do_dialog(_WORD treenr, _WORD startob)
{
	OBJECT *tree;
	GRECT gr;
	_WORD obj;
	
	tree = obj_addr(treenr, ROOT);
	center_dialog(tree, &gr);
	wind_update(BEG_UPDATE);
	form_dial_rect(FMD_START, &gr);
	form_dial_rect(FMD_GROW, &gr);
	objc_draw(tree, ROOT, MAX_DEPTH, gr.g_x, gr.g_y, gr.g_w, gr.g_h);
	obj = form_do(tree, startob) & 0x7fff;
	form_dial_rect(FMD_SHRINK, &gr);
	form_dial_rect(FMD_FINISH, &gr);
	wind_update(END_UPDATE);
	obj_deselect(treenr, obj);
	return obj;
}

/* ---------------------------------------------------------------------- */

/*
 * FIXME: none of the messages has parameters
 */
void show_alert(short code, const char *arg)
{
	const struct alertmsg *alert;
	
	alert = alertmsg_table;
	for (;;)
	{
		if (alert->code == 0 || alert->code == code)
		{
			char buf[256];
			const char *src;
			char *dst;
			
			mouse_on();
			src = alert->msg;
			dst = buf;
			while (*src != '\0' && *src != '%')
				*dst++ = *src++;
			if (*src == '%' && arg != NULL)
			{
				src++;
				while (*arg != '\0')
					*dst++ = *arg++;
			}
			while ((*dst++ = *src++) != '\0')
				;
			form_alert(1, buf);
			return;
		}
		alert++;
	}
}

/* ---------------------------------------------------------------------- */

void Pling(void)
{
	Crawio(7);
}

/* ---------------------------------------------------------------------- */

_WORD min(_WORD a, _WORD b)
{
	if (a > b)
		return b;
	return a;
}

/* ---------------------------------------------------------------------- */

_WORD max(_WORD a, _WORD b)
{
	if (a < b)
		return b;
	return a;
}

/* ---------------------------------------------------------------------- */

_WORD rc_intersect(const GRECT *gr1, GRECT *gr2)
{
	_WORD x1;
	_WORD y1;
	_WORD x2;
	_WORD y2;
	
	x1 = max(gr1->g_x, gr2->g_x);
	y1 = max(gr1->g_y, gr2->g_y);
	x2 = min(gr1->g_x + gr1->g_w, gr2->g_x + gr2->g_w);
	y2 = min(gr1->g_y + gr1->g_h, gr2->g_y + gr2->g_h);
	gr2->g_x = x1;
	gr2->g_y = y1;
	gr2->g_w = x2 - x1;
	gr2->g_h = y2 - y1;
	if (gr2->g_w > 0 && gr2->g_h > 0)
		return TRUE;
	return FALSE;
}

/* ---------------------------------------------------------------------- */

_WORD rc_equal(const GRECT *gr1, const GRECT *gr2)
{
	if (gr1->g_x == gr2->g_x &&
		gr1->g_y == gr2->g_y &&
		gr1->g_w == gr2->g_w &&
		gr1->g_h == gr2->g_h)
		return TRUE;
	return FALSE;
}

/* ---------------------------------------------------------------------- */

void clear_rect(_WORD x, _WORD y, _WORD w, _WORD h)
{
	_WORD pxy[4];
	
	if (w <= 0 || h <= 0)
		return;
	if (x < 0)
		x = 0;
	if (y < 0)
		y = 0;
	pxy[0] = x;
	pxy[1] = y;
	pxy[2] = x + w - 1;
	pxy[3] = y + h - 1;
	if (pxy[2] > screen_width)
		pxy[2] = screen_width;
	if (pxy[3] > screen_height)
		pxy[3] = screen_height;
	vr_recfl(vdi_handle, pxy);
}

/* ---------------------------------------------------------------------- */

void copy_grect(const GRECT *src, const GRECT *dst)
{
	_WORD pxy[8];
	MFDB screen;
	
	screen.fd_addr = 0;
	pxy[0] = src->g_x;
	pxy[1] = src->g_y;
	pxy[2] = src->g_x + src->g_w - 1;
	pxy[3] = src->g_y + src->g_h - 1;
	pxy[4] = dst->g_x;
	pxy[5] = dst->g_y;
	pxy[6] = dst->g_x + dst->g_w - 1;
	pxy[7] = dst->g_y + dst->g_h - 1;
	vro_cpyfm(vdi_handle, S_ONLY, pxy, &screen, &screen);
}

/* ---------------------------------------------------------------------- */

static void fix_rsh(OBJECT *tree, _WORD obj, _WORD parent)
{
	OBJECT *ptr;
	
	while (obj >= 0 && obj != parent)
	{
		rsrc_obfix(tree, obj);
		ptr = &tree[obj];
		if (ptr->ob_head >= 0)
			fix_rsh(tree, ptr->ob_head, obj);
		switch (ptr->ob_type)
		{
		case G_TEXT:
		case G_BOXTEXT:
		case G_FTEXT:
		case G_FBOXTEXT:
			/* fix ob_spec */
			ptr->ob_spec.tedinfo = &rs_tedinfo[ptr->ob_spec.index];
			break;
			/* ob_spec -> string */
		case G_BUTTON:
		case G_STRING:
		case G_TITLE:
			ptr->ob_spec.free_string = rs_strings[ptr->ob_spec.index];
			break;
			/* ob_specs not requiring fixups */
		case G_USERDEF:
		case G_BOX:
		case G_IBOX:
		case G_BOXCHAR:
			break;
		}
		obj = ptr->ob_next;
	}
}

/* ---------------------------------------------------------------------- */

void rsrc_fix(void)
{
	TEDINFO *ted;
	_WORD tree;
	
	/* fix pointers in TEDINFO */
	for (ted = rs_tedinfo; ted < &rs_tedinfo[sizeof(rs_tedinfo) / sizeof(rs_tedinfo[0])]; ted++)
	{
		ted->te_ptext = rs_strings[(long) (ted->te_ptext)];
		ted->te_ptmplt = rs_strings[(long) (ted->te_ptmplt)];
		ted->te_pvalid = rs_strings[(long) (ted->te_pvalid)];
	}
	for (tree = 0; tree < NUM_TREE; tree++)
		fix_rsh(&rs_object[treeinfo[tree].tree], 0, NIL);
}


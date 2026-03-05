#include "pc_help.h"
#include "helpmsg.h"
#include <stdint_.h>
#include "hcint.h"
#include "pchlprsc.h"

static int help_win_idx = -1;
static int help_level = -1;
static const char *const help_table[] = {
	ESC_CHR_S "\377\377C Language",
	ESC_CHR_S "\377\377Libraries",
	ESC_CHR_S "\377\377Options",
	ESC_CHR_S "\377\377Assembler",
	ESC_CHR_S "\0\0Index",
};

static const char *get_help_title(void);

struct {
	long selection_start;
	long selection_end;
	char str[LINK_SIZE];
} help_stack[HELP_MAX_DEPTH + 1];
char help_title[(HELP_MAX_DEPTH + 1) * LINK_SIZE + 6];


/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static void make_link(char *_dst, const char *_src)
{
	char *dst;
	const char *src;

	dst = _dst;
	src = _src;
	if (src[0] == ESC_CHR)
	{
		memcpy(dst, src, LINK_SIZE - 1);
	} else
	{
		dst[0] = ESC_CHR;
		dst[1] = -1;
		dst[2] = -1;
		memcpy(&dst[3], src, LINK_SIZE - 4);
	}
	dst[LINK_SIZE - 1] = '\0';
#if WITH_OPTIMIZATIONS
	{
		char *p = strchr(&dst[3], ESC_CHR);
		if (p != NULL)
			*p = '\0';
	}
#else
	src = strchr(&dst[3], ESC_CHR);
	if (src != NULL)
		*(char *)src = '\0';
#endif
}

/* ---------------------------------------------------------------------- */

static void help_push(const char *str)
{
	if (help_level == HELP_MAX_DEPTH)
	{
		memmove(&help_stack[0], &help_stack[1], sizeof(help_stack[0]) * HELP_MAX_DEPTH);
	} else
	{
		help_level++;
	}
	help_stack[help_level].selection_start = 0;
	help_stack[help_level].selection_end = 0;
	memcpy(&help_stack[help_level].str, str, LINK_SIZE);
}

/* ---------------------------------------------------------------------- */

static void set_helpstr(const char *str, long len)
{
	const char *title = get_help_title();
	edit_set_help(title, str, len, TRUE);
	mouse_on();
}

/* ---------------------------------------------------------------------- */

static const char *get_help_title(void)
{
	int maxlen;
	int len;
	int level;
	char link[LINK_SIZE];
	const char *str;
	
	maxlen = edit_max_title_len() - 2;
	len = 0;
	strcpy(help_title, "HelpAcc");
	for (level = help_level; level >= 0; level--)
	{
		make_link(link, help_stack[level].str);
		len += (int)strlen(link);
		if (len > maxlen && level < help_level)
			break;
	}
	for (len = level + 1; len <= help_level; len++)
	{
		strcat(help_title, ": ");
		str = &help_stack[len].str[3];
		strcat(help_title, str);
#if !WITH_OPTIMIZATIONS
		str = &help_title[strlen(help_title)] - 1;
#endif
	}
	return help_title;
}

/* ---------------------------------------------------------------------- */

bool help_show_topic(const char *topic)
{
	char link[LINK_SIZE];
	char sub[LINK_SIZE];
	const char *str;
	long len;
	int err;
	
	make_link(link, topic);
	if (help_level >= 0)
	{
		make_link(sub, help_stack[help_level].str);
		if (strcmp(sub, link) == 0)
		{
			win_set_top();
			return FALSE;
		}
		edit_get_selection(&help_stack[help_level].selection_start, &help_stack[help_level].selection_end);
	}
	err = help_find_online(link, &str, &len);
	if (err != 0)
	{
		show_alert(err, NULL);
		return err;
	} else
	{
		if (help_win_idx < 0 && (help_win_idx = edit_open_special("", WINTYPE_HELP), help_win_idx) < 0)
			return TRUE;
		win_set_top();
		help_push(link);
		set_helpstr(str, len);
	}
	return FALSE;
}

/* ---------------------------------------------------------------------- */

bool help_show(int mode)
{
	help_level = -1;
	return help_show_topic(help_table[mode]);
}

/* ---------------------------------------------------------------------- */

bool help_undo(void)
{
	long selection_start;
	long selection_end;
	long prev_selection_start;
	long prev_selection_end;

	--help_level;
	if (help_level >= 0)
	{
		selection_start = help_stack[help_level].selection_start;
		selection_end = help_stack[help_level].selection_end;
		if (--help_level >= 0)
		{
			prev_selection_start = help_stack[help_level].selection_start;
			prev_selection_end = help_stack[help_level].selection_end;
#ifdef __GNUC__
		} else
		{
			prev_selection_start = 0; /* silence compiler */
			prev_selection_end = 0;
#endif
		}
		help_show_topic(help_stack[help_level + 1].str);
		if (help_level > 0)
		{
			help_stack[help_level - 1].selection_start = prev_selection_start;
			help_stack[help_level - 1].selection_end = prev_selection_end;
		}
	}
	if (help_level < 0)
	{
		help_win_idx = -1;
		return TRUE;
	}
	edit_select(selection_start, selection_end);
	return FALSE;
}

/* ---------------------------------------------------------------------- */

bool help_close(void)
{
	help_level = -1;
	help_win_idx = -1;
	return TRUE;
}

/* ---------------------------------------------------------------------- */

void help_set_title(void)
{
	const char *title;
	
	title = get_help_title();
	edit_set_help(title, NULL, 0, FALSE);
	mouse_on();
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */


#include "pc_help.h"
#include "hcint.h"
#include "alerts.h"

#define MAX_LINE_LEN 256

typedef struct _editwin {
	/*   0 */ int selection_start_mark;
	/*   2 */ int selection_end_mark;
	/*   4 */ int topline_mark;
	/*   6 */ char window_name[FNAME_MAX];
	/* 134 */ int displayed_lines;
	/* 136 */ int total_lines; /* BUG: should be long */
	/* 138 */ int display_columns;
	/* 140 */ _WORD cursor_y;
	/* 142 */ _WORD cursor_x;
	/* 144 */ _WORD target_column;
	/* 146 */ _WORD left_offset;
	/* 148 */ char inuse;
	/* 149 */ char select_toward_start;
	/* 150 */ char wintype;
} EDITWIN;

EDITWIN editwin;

#define IS_LINK_START(c) ((signed char)(c) < 0)
#define CR_S "\r"

#ifdef __PUREC__
/* not declared in ctype.h */
int isword(unsigned char c);
#else
#define isword(c) (isalnum(c) || c >= 0x80)
#endif

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void editwin_set_cursor(_WORD cursor_y, _WORD cursor_x)
{
	EDITWIN *win = &editwin;
	
	win->cursor_y = cursor_y;
	win->cursor_x = cursor_x;
	win->target_column = cursor_x;
	win_set_cursor(cursor_y, cursor_x - win->left_offset);
}

/* ---------------------------------------------------------------------- */

static int expand_tabs(const char *src, char *dst, int srclen, int dstlen)
{
	int srccount;
	int dstcount;
	bool in_link;
	char c;

	srccount = 0;
	dstcount = 0;
	in_link = FALSE;
	while (srccount < srclen && dstcount < dstlen)
	{
		int end;
		
		c = *src++;
		srccount++;
		if (c == 0)
			c = '\020'; /* digit 0 */
		if (c == '\t')
		{
			end = dstcount - (dstcount % TABSIZE) + TABSIZE;
			c = ' ';
			if (end > dstlen)
				end = dstlen;
			while (dstcount < end)
			{
				*dst++ = c;
				dstcount++;
			}
		} else if (c == ESC_CHR)
		{
			*dst++ = c;
			if (in_link)
			{
				in_link = FALSE;
			} else
			{
				end = srclen - 1;
				if (end > srccount)
				{
					if (IS_LINK_START(*src))
					{
						in_link = TRUE;
						src += 2;
						srccount += 2;
					}
				}
			}
		} else
		{
			*dst++ = c;
			dstcount++;
		}
	}
	*dst = '\0';

	return dstcount;
}

/* ---------------------------------------------------------------------- */

/*
 * only used here to find a single character,
 * so it is faster to replace find_str_forward/find_str_backward
 * by a simpler version
 */
#define find_str_forward(offset, s, casesensitive) find_cr_forward(offset)
#define find_str_backward(offset, s, casesensitive) find_cr_backward(offset)

static long find_cr_forward(long offset)
{
	long len;
	const char *ptr;
	struct memfd *memfd = cur_memfd;
	struct membuf *membuf = memfd->buf;
	
	ptr = membuf->buf + offset;
	if (offset < memfd->inserted)
	{
		len = memfd->inserted - offset;
	} else
	{
		long used_len;
		
		len = memfd->first_used - memfd->inserted;
		used_len = memfd->last_used - len;
		if (offset >= used_len)
			return AL_HELP_KEYWORD;
		ptr += len;
		len += used_len;
		len -= offset;
	}

	for (;;)
	{
		if (len != 0)
		{
			offset++;
			len--;
			if (*ptr++ == CR)
				break;
			continue;
		}
		if (ptr != membuf->buf + memfd->inserted)
			return AL_HELP_KEYWORD;
		if ((len = memfd->last_used - memfd->first_used) == 0)
			return AL_HELP_KEYWORD;
		ptr = membuf->buf + memfd->first_used;
	}
	--offset;
	return offset;
}

/* ---------------------------------------------------------------------- */

static long find_cr_backward(long offset)
{
	long len;
	const char *ptr;
	struct memfd *memfd = cur_memfd;
	struct membuf *membuf = memfd->buf;
	
	offset += 1;
	ptr = membuf->buf + offset;
	if (offset < memfd->inserted)
	{
		len = offset;
	} else
	{
		long used_len;
		
		len = memfd->first_used - memfd->inserted;
		used_len = memfd->last_used - len;
		if (offset > used_len)
			offset = used_len;
		ptr += used_len;
		len = offset;
		len -= memfd->inserted;
	}
	
	for (;;)
	{
		if (len != 0)
		{
			offset--;
			len--;
			if (*--ptr == CR)
				break;
			continue;
		}
		if (ptr != membuf->buf + memfd->first_used)
			return AL_HELP_KEYWORD;
		if ((len = memfd->inserted) == 0)
			return AL_HELP_KEYWORD;
		ptr = membuf->buf + len;
	}
	return offset;
}

/* ---------------------------------------------------------------------- */

static long find_line_start_backward(long start)
{
	off_t offset;
	char buf[1];
	
	if (start <= 0)
		return 0;
	offset = find_str_backward(start - 1, CR_S, TRUE);
	if (offset < 0)
		return 0;
	offset++;
	memfd_readbuf(offset, buf, 1);
	if (buf[0] == '\n')
		offset++;
	return offset;
}

/* ---------------------------------------------------------------------- */

static long find_line_end_forward(long offset)
{
	offset = find_str_forward(offset, CR_S, TRUE);
	if (offset < 0)
		return memfd_getsize();
	return offset;
}

/* ---------------------------------------------------------------------- */

static long find_prev_line_start(long offset)
{
	offset = find_str_backward(offset - 1, CR_S, TRUE);
	if (offset <= 0)
		return 0;
	return find_line_start_backward(offset);
}

/* ---------------------------------------------------------------------- */

static long find_next_line_start(long offset)
{
	long size;
	char buf[1];
	
	offset = find_line_end_forward(offset);
	size = memfd_getsize();
	++offset;
	if (offset >= size)
		return size;
	memfd_readbuf(offset, buf, 1);
	if (buf[0] == '\n')
		offset++;
	return offset;
}

/* ---------------------------------------------------------------------- */

static long find_char_backward(long offset)
{
	char buf[4];
	
	--offset;
	for (;;)
	{
		if (offset <= 0)
			return 0;
		memfd_readbuf(offset, &buf[2], 1);
		if (buf[2] == '\n')
		{
			--offset;
			continue;
		}
		if (buf[2] == ESC_CHR)
		{
			--offset;
			continue;
		}
		if (offset <= 1)
			return offset;
		memfd_readbuf(offset - 2, buf, 2);
		if (buf[0] == ESC_CHR && IS_LINK_START(buf[1]))
		{
			offset -= 2;
		} else
		{
			if (!IS_LINK_START(buf[2]) || buf[1] != ESC_CHR)
				break;
			--offset;
		}
	}
	return offset;
}

/* ---------------------------------------------------------------------- */

static long find_char_forward(long offset)
{
	long size;
	char buf[2];
	
	size = memfd_getsize();
	++offset;
	for (;;)
	{
		if (offset >= size)
			return size;
		memfd_readbuf(offset, buf, 1);
		if (buf[0] == '\n')
		{
			++offset;
			continue;
		}
		if (buf[0] != ESC_CHR)
			break;
		++offset;
		if (offset >= size)
			return size;
		memfd_readbuf(offset, buf, 1);
		if (IS_LINK_START(buf[0]))
			offset += 2;
	}
	return offset;
}

/* ---------------------------------------------------------------------- */

static int read_line_at(long start, char *dst, int maxlen)
{
	int len;
	
	len = (int)(find_line_end_forward(start) - start);
	if (len > maxlen)
		len = maxlen;
	memfd_readbuf(start, dst, len);
	return len;
}

/* ---------------------------------------------------------------------- */

static int get_display_width(long offset)
{
	long start;
	int len;
	char buf[MAX_LINE_LEN];
	int i;
	bool in_link;
	char *ptr;
	char c;
	
	start = find_line_start_backward(offset);
	len = min((int)(offset - start), MAX_LINE_LEN - 1);
	len = read_line_at(start, buf, len);
	i = 0;
	in_link = FALSE;
	ptr = buf;
	while (--len >= 0)
	{
		c = *ptr++;
		if (c == '\t')
		{
			i = i - (i % TABSIZE) + TABSIZE;
		} else if (c == ESC_CHR)
		{
			if (in_link)
			{
				in_link = FALSE;
			} else
			{
				if (len > 1 && IS_LINK_START(*ptr))
				{
					in_link = TRUE;
					ptr += 2;
					len -= 2;
				}
			}
		} else
		{
			i++;
		}
	}
	return i;
}

/* ---------------------------------------------------------------------- */

static long get_file_pos(long offset, int column)
{
	int len;
	char buf[MAX_LINE_LEN];
	int i;
	bool in_link;
	char *ptr;
	char c;

	offset = find_line_start_backward(offset);
	len = read_line_at(offset, buf, MAX_LINE_LEN - 1);
	i = 0;
	in_link = FALSE;
	ptr = buf;
	while (--len >= 0 && i <= column)
	{
		c = *ptr++;
		if (c == '\t')
		{
			i = i - (i % TABSIZE) + TABSIZE;
		} else if (c == ESC_CHR)
		{
			if (in_link)
			{
				in_link = FALSE;
			} else
			{
				if (len > 1 && IS_LINK_START(*ptr))
				{
					in_link = TRUE;
					len -= 2;
					ptr += 2;
				}
			}
		} else
		{
			i++;
		}
	}
	if (i > column && ptr > buf)
		ptr--;
	
	return (ptr - buf) + offset;
}

/* ---------------------------------------------------------------------- */

static long count_lines(long startoffset, long endoffset)
{
	long start;
	long end;
	long count;
	char swapped;
	
	start = startoffset;
	end = endoffset;
	count = 0;
	swapped = FALSE;
	
	if (startoffset > endoffset)
	{
		start = endoffset;
		end = startoffset;
		swapped = TRUE;
	}
	for (;;)
	{
		start = find_str_forward(start, CR_S, TRUE) + 1;
		if (start < 0 || start > end)
			break;
		count++;
	}
	if (swapped)
		count = -count;
	return count;
}

/* ---------------------------------------------------------------------- */

static int count_crs(long len, const char *str)
{
	int count;
	
	count = 0;
	while (--len >= 0)
		if (*str++ == '\r')
			count++;
	return count;
}

/* ---------------------------------------------------------------------- */

static int lineno_from_offset(EDITWIN *win, long end)
{
	long offset;
	int i;
	
	offset = memfd_get_current_mark(win->topline_mark);
	if (end < offset)
		return -1;
	for (i = 0; i < win->displayed_lines; i++)
	{
		offset = find_str_forward(offset, CR_S, TRUE) + 1;
		if (offset < 0 || offset > end)
			break;
	}
	return i;
}

/* ---------------------------------------------------------------------- */

static void scrap_init(void)
{
	char scrap_path[FNAME_MAX];
	char *env;
	_DTA dta;
	char bootdrv;

	if (scrp_read(scrap_path) != 0 && scrap_path[0] != '\0')
		return;
	env = getenv("CLIPBRD");
	if (env != NULL)
	{
		scrp_write(env);
		return;
	}
	bootdrv = (char)(long)Setexc(0x444 / 4, (void (*)(void))-1);
	scrap_path[0] = bootdrv + 'A';
	strcpy(&scrap_path[1], ":\\CLIPBRD");
	if (scrap_path[0] > 'B')
	{
		(void) Dcreate(scrap_path);
		scrp_write(scrap_path);
	} else
	{
		Fsetdta(&dta);
		if (Fsfirst(scrap_path, FA_DIREC) == 0)
			scrp_write(scrap_path);
	}
}

/* ---------------------------------------------------------------------- */

static void scrap_write(char **str, long len)
{
	char scrap_path[FNAME_MAX];
	_DTA dta;
	size_t pathlen;
	int fd;
	
	if (scrp_read(scrap_path) == 0 || scrap_path[0] == '\0')
		return;
	pathlen = strlen(scrap_path);
	if (pathlen == 0 || (scrap_path[pathlen - 1] != '\\' && scrap_path[pathlen - 1] != '/'))
	{
		scrap_path[pathlen++] = '\\';
	}
	strcpy(&scrap_path[pathlen], "*.*");
	Fsetdta(&dta);
	if (Fsfirst(scrap_path, 0) == 0)
	{
		do
		{
			strcpy(&scrap_path[pathlen], dta.dta_name);
			unlink(scrap_path);
		} while (Fsnext() == 0);
	}
	strcpy(&scrap_path[pathlen], "scrap.txt");
	fd = (int)Fcreate(scrap_path, 0);
	if (fd >= 0)
	{
		if (Fwrite(fd, len, *str) != len)
			show_alert(AL_FILE_WRITE, NULL);
		Fclose(fd);
	} else
	{
		show_alert(AL_FILE_WRITE, NULL);
	}
}

/* ---------------------------------------------------------------------- */

static void invert_selection(EDITWIN *win, long start, long end)
{
	int firstline;
	int lastline;
	int startwidth;
	int endwidth;
	
	if (start >= end)
		return;
	firstline = lineno_from_offset(win, start);
	lastline = lineno_from_offset(win, end);
	if (firstline >= win->displayed_lines || lastline < 0)
		return;
	startwidth = get_display_width(start) - win->left_offset;
	if (startwidth < 0)
		startwidth = 0;
	if (startwidth > win->display_columns)
		startwidth = win->display_columns;
	endwidth = get_display_width(end) - win->left_offset;
	if (endwidth < 0)
		endwidth = 0;
	if (endwidth > win->display_columns)
		endwidth = win->display_columns;
	if (firstline < 0)
	{
		firstline = 0;
		startwidth = 0;
	}
	if (lastline >= win->displayed_lines)
	{
		lastline = win->displayed_lines - 1;
		endwidth = win->display_columns;
	}
	if (firstline == lastline)
	{
		win_invert_line(firstline, startwidth, endwidth);
	} else
	{
		win_invert_line(firstline, startwidth, win->display_columns);
		win_invert_line(lastline, 0, endwidth);
	}
	while (++firstline < lastline)
		win_invert_line(firstline, 0, win->display_columns);
}

/* ---------------------------------------------------------------------- */

static long find_line_in_window(EDITWIN *win, int lineno)
{
	long offset;

	offset = memfd_get_current_mark(win->topline_mark);
	while (--lineno >= 0)
	{
		offset = find_next_line_start(offset);
	}
	return offset;
}

/* ---------------------------------------------------------------------- */

static void redraw_lines(EDITWIN *win, long offset, int firstline, int count)
{
	long selection_start;
	long selection_end;
	char buf[MAX_LINE_LEN];
	char buf2[MAX_LINE_LEN];
	long line_end;
	long size;
	int maxcolumns;
	int linelen;
	int columns;
	bool did_draw;
	
	if (firstline >= win->displayed_lines)
		return;
	if (count <= 0)
		return;
	mouse_off();
	if (firstline < 0)
	{
		count += firstline;
		firstline = 0;
	}
	if (win->displayed_lines - firstline < count)
	{
		count = win->displayed_lines - firstline;
	}
	size = memfd_getsize();
	selection_start = memfd_get_current_mark(win->selection_start_mark);
	selection_end = memfd_get_current_mark(win->selection_end_mark);
	if (selection_start < offset)
		selection_start = offset;
	did_draw = FALSE;
	line_end = selection_end; /* otherwise maybe uninitialized below */
	while (count > 0 && offset < size)
	{
		did_draw = TRUE;
		line_end = find_line_end_forward(offset);
		maxcolumns = win->display_columns + win->left_offset;
		linelen = read_line_at(offset, buf, MAX_LINE_LEN - 1);
		columns = expand_tabs(buf, buf2, linelen, maxcolumns);
		win_draw_str(firstline, buf2, win->left_offset, columns - win->left_offset);
		offset = find_next_line_start(line_end);
		firstline++;
		count--;
	}
	if (line_end < selection_end)
		selection_end = offset;
	if (did_draw)
		invert_selection(win, selection_start, selection_end);
	win_clear_lines(firstline, count);
	mouse_on();
}

/* ---------------------------------------------------------------------- */

static void scroll_editwin(EDITWIN *win, int firstline, int height, int offset)
{
	int line;
	int diff;
	
	if (offset == 0)
		return;
	line = firstline + offset;
	if (firstline < 0)
	{
		line -= firstline;
		height += firstline;
		firstline = 0;
	}
	if (line < 0)
	{
		firstline -= line;
		height += line;
		line = 0;
	}
	diff = win->displayed_lines - firstline;
	if (height > diff)
		height = diff;
	diff = win->displayed_lines - line;
	if (height > diff)
		height = diff;
	if (height > 0)
		win_scroll(firstline, 0, height, win->display_columns, offset);
}

/* ---------------------------------------------------------------------- */

static void editwin_free(int idx)
{
	EDITWIN *win;
	
	win = &editwin;
	win->inuse = FALSE;
	win_close(idx);
}

/* ---------------------------------------------------------------------- */

static void editwin_init(EDITWIN *win)
{
	win->target_column = 0;
	win->left_offset = 0;
	win->topline_mark = memfd_new_mark(0);
	win->selection_start_mark = memfd_new_mark(0);
	win->selection_end_mark = memfd_new_mark(0);
	editwin_set_cursor(0, 0);
	win_cursor_on();
	win_set_slider(SL_HSLSIZE, win->display_columns, MAX_LINE_LEN);
	win->total_lines = (int)count_lines(0, memfd_getsize()) + 1;
	win_set_slider(SL_VSLSIZE, win->displayed_lines, win->total_lines);
}

/* ---------------------------------------------------------------------- */

static int editwin_alloc(const char *title, struct windinfo *info)
{
	struct windinfo _info;
	int winidx;
	EDITWIN *win;
	
	if (info == NULL || info->columns == 0)
	{
		_info.xpos = -1;
		_info.ypos = 0;
		_info.columns = 70;
		_info.lines = 90;
		info = &_info;
	}
	winidx = win_create(info, title);
	if (winidx >= 0)
	{
		win = &editwin;
		win->inuse = TRUE;
		win->wintype = WINTYPE_FILE;
		win->displayed_lines = info->lines;
		win->display_columns = info->columns;
		strcpy(win->window_name, title);
		win_set_name(win->window_name);
		editwin_init(win);
		win_set_top();
	}
	return winidx;
}

/* ---------------------------------------------------------------------- */

static long get_selection_start(void)
{
	return memfd_get_current_mark(editwin.selection_start_mark);
}

/* ---------------------------------------------------------------------- */

static void scroll_window(long start, int hor_diff)
{
	long top;
	long size;
	int lines;
	int i;
	int column;
	int right_margin;
	EDITWIN *win;
	
	win = &editwin;
	top = memfd_get_current_mark(win->topline_mark);
	start = find_line_start_backward(start);
	size = memfd_getsize();
	lines = win->displayed_lines;
	while (lines > 1)
	{
		size = find_prev_line_start(size);
		lines--;
	}
	if (start > size)
		start = size;
	i = 0;
	while (top < start)
	{
		top = find_next_line_start(top);
		i++;
		if (i >= win->displayed_lines)
			break;
	}
	while (top > start)
	{
		top = find_prev_line_start(top);
		--i;
		if (i <= -win->displayed_lines)
			break;
	}
	start = find_line_start_backward(start);
	memfd_set_mark(win->topline_mark, start);
	column = win->left_offset + hor_diff;
	if (column < 0)
		column = 0;
	right_margin = MAX_LINE_LEN - 1 - win->display_columns;
	if (right_margin < column)
		column = right_margin;
	hor_diff = column - win->left_offset;
	if (hor_diff == 0 && win_is_fully_visible())
	{
		scroll_editwin(win, 0, win->displayed_lines, -i);
		if (i < 0)
		{
			redraw_lines(win, start, 0, -i);
		} else
		{
			lines = win->displayed_lines - i;
			redraw_lines(win, find_line_in_window(win, lines), lines, i);
		}
	} else
	{
		win->left_offset = column;
		redraw_lines(win, start, 0, win->displayed_lines);
		win_set_slider(SL_HSLIDE, column, right_margin);
	}
	
	lines = win->cursor_y;
	if (lines >= 0 && lines < win->displayed_lines)
	{
		lines -= i;
	} else
	{
		if ((lines < 0 && i < 0) || (lines >= win->displayed_lines && i > 0))
		{
			lines = lineno_from_offset(win, get_selection_start());
		}
	}
	editwin_set_cursor(lines, win->cursor_x);
	if (i != 0)
		win_set_slider(SL_VSLIDE, start, size);
}

/* ---------------------------------------------------------------------- */

static void edit_ensure_visible(long start)
{
	int line;
	EDITWIN *win;
	int width;
	long top;
	long prevtop;
	long bottom;
	int hor_diff;
	
	win = &editwin;
	line = lineno_from_offset(win, start);
	width = get_display_width(start) - win->left_offset;
	top = memfd_get_current_mark(win->topline_mark);
	if (line < 0 || line >= win->displayed_lines)
	{
		bottom = find_line_in_window(win, win->displayed_lines);
		prevtop = find_prev_line_start(top);
		if (bottom <= start &&
			find_line_end_forward(bottom) >= start)
		{
			start = find_next_line_start(top);
		} else if (start >= prevtop && start < top)
		{
			start = prevtop;
		} else
		{
			line = win->displayed_lines / 2;
			while (--line >= 0)
				start = find_prev_line_start(start);
		}
	} else
	{
		start = top;
	}
	hor_diff = 0;
	if (width < 0 || width > win->display_columns - 1)
	{
		hor_diff = width - win->display_columns / 2;
	}
	if (start != top || hor_diff != 0)
		scroll_window(start, hor_diff);
}

/* ---------------------------------------------------------------------- */

static void edit_set_cursor_pos(long start)
{
	EDITWIN *win;
	int line;
	int width;
	
	win = &editwin;
	line = lineno_from_offset(win, start);
	width = get_display_width(start) - win->left_offset;
	editwin_set_cursor(line, width + win->left_offset);
	win_cursor_on();
}

/* ---------------------------------------------------------------------- */

static void edit_set_cursor_to(long start)
{
	EDITWIN *win;
	long selection_start;
	long selection_end;
	int line;
	int column;
	
	if (start < 0)
		start = 0;
	else if (start > memfd_getsize())
		start = memfd_getsize();
	win = &editwin;
	selection_start = memfd_get_current_mark(win->selection_start_mark);
	selection_end = memfd_get_current_mark(win->selection_end_mark);
	if (selection_start < selection_end ||
		start != selection_start ||
		win->cursor_y < 0 ||
		win->cursor_y >= win->displayed_lines ||
		win->cursor_x < win->left_offset ||
		win->cursor_x > win->left_offset + win->display_columns)
	{
		line = win->cursor_y;
		if (selection_start < selection_end ||
			count_lines(selection_start, start) != 0)
			line = lineno_from_offset(win, start);
		column = get_display_width(start) - win->left_offset;
		if (line < 0 || line >= win->displayed_lines ||
			column < 0 || column > win->display_columns - 1)
		{
			edit_ensure_visible(start);
			line = lineno_from_offset(win, start);
			column = get_display_width(start) - win->left_offset;
		}
		editwin_set_cursor(line, column + win->left_offset);
		if (selection_start < selection_end)
			invert_selection(win, selection_start, selection_end);
	}
	memfd_set_mark(win->selection_start_mark, start);
	memfd_set_mark(win->selection_end_mark, start);
	win_cursor_on();
}

/* ---------------------------------------------------------------------- */

static void ensure_selection_visible(void)
{
	edit_ensure_visible(memfd_get_current_mark(editwin.selection_start_mark));
	edit_ensure_visible(memfd_get_current_mark(editwin.selection_end_mark));
}

/* ---------------------------------------------------------------------- */

static void set_new_selection(long start, long end)
{
	EDITWIN *win;
	long size;
	long selection_start;
	long selection_end;
	long startpos;
	long endpos;
	
	size = memfd_getsize();
	if (start < 0)
		start = 0;
	else if (start > size)
		start = size;
	if (end < 0)
		end = 0;
	else if (end > size)
		end = size;
	win = &editwin;
	selection_start = memfd_get_current_mark(win->selection_start_mark);
	selection_end = memfd_get_current_mark(win->selection_end_mark);
	win_cursor_off();
	startpos = selection_start;
	if (selection_start < start)
		startpos = start;
	endpos = selection_end;
	if (selection_end > end)
		endpos = end;
	if (endpos <= startpos)
	{
		invert_selection(win, selection_start, selection_end);
		invert_selection(win, start, end);
	} else
	{
		invert_selection(win, selection_start, startpos);
		invert_selection(win, endpos, selection_end);
		invert_selection(win, start, startpos);
		invert_selection(win, endpos, end);
	}
	memfd_set_mark(win->selection_start_mark, start);
	memfd_set_mark(win->selection_end_mark, end);
	win->target_column = get_display_width(start);
	if (start == end)
	{
		edit_set_cursor_pos(start);
	} else
	{
		win->cursor_y = lineno_from_offset(win, start);
	}
}

/* ---------------------------------------------------------------------- */

static bool is_in_word(char c)
{
	if (isword((unsigned char)c) || c == '_' || c == '#')
		return TRUE;
	return FALSE;
}

/* ---------------------------------------------------------------------- */

static bool is_char_not_in_word(long pos)
{
	char buf[2];
	
	if (pos < 0 || pos >= memfd_getsize())
		return TRUE;
	memfd_readbuf(pos, buf, 1);
	return !is_in_word(buf[0]);
}

/* ---------------------------------------------------------------------- */

static bool select_word(long pos)
{
	long start;
	int x;
	char buf[MAX_LINE_LEN + 2];
	int i, j;
	int linelen;
	
	start = find_line_start_backward(pos);
	linelen = read_line_at(start, &buf[1], MAX_LINE_LEN - 1);
	buf[0] = '\0';
	buf[linelen + 1] = '\0';
	x = (int)(pos - start + 1);
	i = x;
	while (i > 0 && buf[i] != ESC_CHR)
		i--;
	while (i > 0 && buf[i - 1] == ESC_CHR)
		i--;
	j = x + 1;
	while (j < linelen && buf[j] != ESC_CHR)
		j++;
	if (buf[i] != ESC_CHR || buf[j] != ESC_CHR)
	{
		i = x;
		j = x;
	} else
	{
		j++;
	}
	start--;
	set_new_selection(start + i, start + j);
	if (i != j)
		return TRUE;
	return FALSE;
}

/* ---------------------------------------------------------------------- */

static void show_help_context(void)
{
	EDITWIN *win;
	long start;
	int len;
	char buf[MAX_LINE_LEN];
	
	win = &editwin;
	select_word(memfd_get_current_mark(win->selection_start_mark));
	start = memfd_get_current_mark(win->selection_start_mark);
	len = min((int)(memfd_get_current_mark(win->selection_end_mark) - start), MAX_LINE_LEN - 1);
	if (len <= 0)
	{
		Pling();
	} else
	{
		memfd_readbuf(start, buf, len);
		buf[len] = '\0';
		help_show_topic(buf);
	}
}

/* ---------------------------------------------------------------------- */

static void editwin_close(int idx)
{
	if (help_close() == FALSE)
		return;
	memfd_freebuf();
	editwin_free(idx);
}

/* ---------------------------------------------------------------------- */

void edit_init(void)
{
	memfd_init();
	win_init();
	scrap_init();
	editwin.inuse = FALSE;
}

/* ---------------------------------------------------------------------- */

bool edit_closewind(bool deletewind)
{
	EDITWIN *win;
	
	win = &editwin;
	if (win->inuse)
	{
		editwin_close(deletewind);
		return TRUE;
	}
	return FALSE;
}

/* ---------------------------------------------------------------------- */

bool edit_undo(void)
{
	if (help_undo())
	{
		edit_closewind(TRUE);
		return TRUE;
	}
	return FALSE;
}

/* ---------------------------------------------------------------------- */

static int delete_insert_text(long start, long delete, long insert, const char **str)
{
	int err;
	
	err = memfd_writebuf(start, delete, insert, str);
	if (err != 0)
	{
		show_alert(err, NULL);
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

static int edit_delete_insert(int line, long start, long delete, long insert, const char **str)
{
	int err;
	EDITWIN *win;
	long size;
	long deleted_lines;
	long inserted_lines;
	long linediff;
	int i;
	long scrolllines;

	win = &editwin;
	deleted_lines = win->total_lines;	
	err = delete_insert_text(start, delete, insert, str);
	if (err != 0)
		return AL_ERROR;
	inserted_lines = 0;
	if (insert > 0)
		inserted_lines = count_crs(insert, *str);
	linediff = inserted_lines - deleted_lines;
	scrolllines = win->displayed_lines - line - 1 - max((int)deleted_lines, (int)inserted_lines);
	if (win_is_fully_visible())
	{
		if (linediff != 0)
		{
			scroll_editwin(win, line + (int)deleted_lines + 1, (int)scrolllines, (int)linediff);
			win->total_lines += (int)linediff;
			win_set_slider(SL_VSLSIZE, win->displayed_lines, win->total_lines);
		}
		size = memfd_getsize();
		i = win->displayed_lines;
		while (i > 1)
		{
			size = find_prev_line_start(size);
			i--;
		}
		win_set_slider(SL_VSLIDE, memfd_get_current_mark(win->topline_mark), size);
		redraw_lines(win, find_line_start_backward(start), line, (int)inserted_lines + 1);
		if (linediff < 0)
		{
			line = win->displayed_lines + (int)linediff;
			redraw_lines(win, find_line_in_window(win, line), line, -(int)linediff);
		}
	} else
	{
		redraw_lines(win, find_line_start_backward(start), line, win->displayed_lines - line);
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

bool edit_key(int key)
{
	EDITWIN *win;
	long newpos;
	long pos;
	long top;
	int i;
	long selection_end;
	int target_column;
	char buf[2];
	
	win = &editwin;
	newpos = get_selection_start();
	pos = newpos;
	selection_end = memfd_get_current_mark(win->selection_end_mark);
	target_column = win->target_column;
	if ((key & 0xff) == 0x15 || (key & 0xff) == 0x11) /* Ctrl-U, Ctrl-Q */
	{
		edit_closewind(TRUE);
		return TRUE;
	}
	if ((key & 0xff) == 0x03) /* Ctrl-C */
	{
		edit_copy();
		return FALSE;
	}
	switch (key)
	{
	case 0x6200: /* help */
		show_help_context();
		return FALSE;

	case 0x6100: /* undo */
		return edit_undo();

	default:
		break;
	}
	
	if (pos == selection_end)
	{
		edit_set_cursor_to(pos);
	} else
	{
		edit_ensure_visible(pos);
	}
	
	switch (key)
	{
	case 0x4b34: /* Shift-Cursor-Left */
		newpos = find_line_start_backward(pos);
		break;
	
	case 0x4d36: /* Shift-Cursor-Right */
		newpos = find_line_end_forward(pos);
		break;
	
	case 0x4700: /* home */
		newpos = 0;
		break;
	
	case 0x4737: /* Shift-Home */
		newpos = memfd_getsize();
		break;
	
	case 0x7300: /* Control-Cursor-Left */
		newpos = pos;
		if (newpos > 0)
		{
			if (is_char_not_in_word(find_char_backward(newpos)))
			{
				while (newpos > 0)
				{
					memfd_readbuf(newpos, buf, 1);
					if (!is_in_word(buf[0]))
						break;
					newpos = find_char_backward(newpos);
				}
			}
		}
		while (newpos > 0)
		{
			memfd_readbuf(newpos, buf, 1);
			if (is_in_word(buf[0]))
				break;
			newpos = find_char_backward(newpos);
		}
		while (newpos > 0)
		{
			memfd_readbuf(newpos, buf, 1);
			if (!is_in_word(buf[0]))
				break;
			newpos = find_char_backward(newpos);
		}
		if (newpos != 0 && !is_in_word(buf[0]))
			newpos = find_char_forward(newpos);
		break;
		
	case 0x7400: /* Control-Cursor-Right */
		newpos = pos;
		pos = memfd_getsize();
		while (newpos < pos)
		{
			memfd_readbuf(newpos, buf, 1);
			if (!is_in_word(buf[0]))
				break;
			newpos = find_char_forward(newpos);
		}
		while (newpos < pos)
		{
			memfd_readbuf(newpos, buf, 1);
			if (is_in_word(buf[0]))
				break;
			newpos = find_char_forward(newpos);
		}
		break;
	
	case 0x4838: /* Shift-Cursor-Up */
		top = memfd_get_current_mark(win->topline_mark);
		i = win->displayed_lines - 2;
		while (i > 0)
		{
			newpos = find_prev_line_start(newpos);
			top = find_prev_line_start(top);
			i--;
		}
		scroll_window(top, 0);
		newpos = get_file_pos(newpos, target_column);
		break;

	case 0x5032: /* Shift-Cursor-Down */
		top = memfd_get_current_mark(win->topline_mark);
		i = win->displayed_lines - 2;
		while (i > 0)
		{
			newpos = find_next_line_start(newpos);
			top = find_next_line_start(top);
			i--;
		}
		scroll_window(top, 0);
		newpos = get_file_pos(newpos, target_column);
		break;
	
	case 0x4b00: /* Cursor-Left */
		newpos = find_char_backward(pos);
		break;
	
	case 0x4d00: /* Cursor-Right */
		newpos = find_char_forward(pos);
		break;
	
	case 0x4800: /* Cursor-Up */
		newpos = find_prev_line_start(pos);
		newpos = get_file_pos(newpos, target_column);
		break;
	
	case 0x5000: /* Cursor-Down */
		newpos = find_next_line_start(pos);
		newpos = get_file_pos(newpos, target_column);
		break;
	
	default:
		break;
	}
	
	edit_set_cursor_to(newpos);
	if (key == 0x4800 ||
		key == 0x5000 ||
		key == 0x4838 ||
		key == 0x5032)
		win->target_column = target_column;
	return FALSE;
}

/* ---------------------------------------------------------------------- */

void edit_copy(void)
{
	long start;
	long len;
	struct membuf *scrap_buf;
	
	if (!editwin.inuse)
		return;
	
	start = 0;
	len = memfd_getsize();
	if (len > 0)
	{
		scrap_buf = membuf_alloc(len);
		if (scrap_buf == NULL)
		{
			show_alert(AL_LOWMEM, NULL);
			return;
		}
		memfd_readbuf(start, scrap_buf->buf, len);
		/* if (win->wintype == WINTYPE_HELP) */
		{
			char *src = scrap_buf->buf;
			char *dst = src;
			char c;
			long scrap_len;
			
			scrap_len = 0;
			while (--len >= 0)
			{
				c = *src++;
				if (c == ESC_CHR)
				{
					if (len > 1 && IS_LINK_START(*src))
					{
						src += 2;
						len -= 2;
					}
				} else
				{
					*dst++ = c;
					scrap_len++;
				}
			}
			scrap_write(&scrap_buf->buf, scrap_len);
			membuf_free(scrap_buf);
		}
	}
}

/* ---------------------------------------------------------------------- */

void edit_set_wininfo(_WORD lines, _WORD columns)
{
	EDITWIN *win;
	
	win = &editwin;
	win->displayed_lines = lines;
	win->display_columns = columns;
	win_set_slider(SL_VSLSIZE, win->displayed_lines, win->total_lines);
	win_set_slider(SL_HSLSIZE, columns, MAX_LINE_LEN);
}

/* ---------------------------------------------------------------------- */

void edit_win_redraw(void)
{
	EDITWIN *win;
	
	win = &editwin;
	win_start_redraw();
	redraw_lines(win, memfd_get_current_mark(win->topline_mark), 0, win->displayed_lines);
}

/* ---------------------------------------------------------------------- */

void edit_scroll_wind(_WORD ydir, _WORD xdir)
{
	EDITWIN *win;
	long pos;
	long bottom;
	int lines;
	
	win = &editwin;
	pos = memfd_get_current_mark(win->topline_mark);
	bottom = pos;
	lines = 0;
	while (lines < ydir)
	{
		bottom = find_next_line_start(bottom);
		lines++;
	}
	while (lines > ydir)
	{
		bottom = find_prev_line_start(bottom);
		lines--;
	}
	if (bottom == 0 || bottom == memfd_getsize())
		count_lines(pos, bottom);
	scroll_window(bottom, xdir);
}

/* ---------------------------------------------------------------------- */

void edit_win_clicked(_WORD row, _WORD column)
{
	EDITWIN *win;
	long pos;
	int col = column;
	
	win = &editwin;
	pos = find_line_start_backward(find_line_in_window(win, row));
	col += win->left_offset;
	pos = get_file_pos(pos, col);
	win->target_column = col;
	edit_set_cursor_to(pos);
}

/* ---------------------------------------------------------------------- */

void edit_win_double_click(_WORD row, _WORD column)
{
	EDITWIN *win;
	long pos;
	
	win = &editwin;
	pos = find_line_start_backward(find_line_in_window(win, row));
	pos = get_file_pos(pos, column + win->left_offset);
	edit_set_cursor_to(pos);
	show_help_context();
	{
		_WORD dummy;
		evnt_button(1, 1, 0, &dummy, &dummy, &dummy, &dummy);
	}
}

/* ---------------------------------------------------------------------- */

void edit_set_slider(bool horizontal, _WORD pos, _WORD size)
{
	EDITWIN *win;
	int hor;
	long start;
	long bottom;
	int lines;
	
	win = &editwin;
	if (horizontal)
	{
		hor = (int)(((long)(MAX_LINE_LEN - 1 - win->display_columns) * pos) / size) - win->left_offset;
		start = memfd_get_current_mark(win->topline_mark);
	} else
	{
		bottom = memfd_getsize();
		lines = win->displayed_lines;
		while (lines > 1)
		{
			bottom = find_prev_line_start(bottom);
			--lines;
		}
		start = find_line_start_backward((bottom * pos) / size);
		hor = 0;
	}
	scroll_window(start, hor);
}

/* ---------------------------------------------------------------------- */

void edit_get_selection(long *start, long *end)
{
	EDITWIN *win = &editwin;
	
	*start = memfd_get_current_mark(win->selection_start_mark);
	*end = memfd_get_current_mark(win->selection_end_mark);
}

/* ---------------------------------------------------------------------- */

void edit_select(long start, long end)
{
	set_new_selection(start, end);
	ensure_selection_visible();
}

/* ---------------------------------------------------------------------- */

int edit_open_special(const char *title, int type)
{
	int memidx;
	int err;
	
	memidx = memfd_new();
	err = memidx;
	if (err < 0)
	{
		show_alert(err, NULL);
		return err;
	}
	type -= 1;
	err = editwin_alloc(title, NULL);
	if (err < 0)
	{
		memfd_freebuf();
		show_alert(err, NULL);
	}
	return err;
}

/* ---------------------------------------------------------------------- */

void edit_set_help(const char *title, const char *str, long len, bool settext)
{
	EDITWIN *win;
	
	win = &editwin;
	mouse_off(); /* must be turned off because invert_cursor might be called */
	win_set_name(title);
	strcpy(win->window_name, title);
	if (settext)
	{
		/* avoid errors for readonly window */
		win->wintype = -WINTYPE_HELP;
		edit_delete_insert(0, 0, memfd_getsize(), len, &str);
		edit_set_cursor_pos(find_char_backward(find_char_forward(0)));
		win->wintype = WINTYPE_HELP;
	}
	mouse_on();
}

/* ---------------------------------------------------------------------- */

int edit_max_title_len(void)
{
	return editwin.display_columns;
}

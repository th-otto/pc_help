#include "pc_help.h"
#include "hcint.h"
#ifndef ORIG_PUREC
#include <fcntl.h>
#endif
#include "endian_.h"
#include "alerts.h"

struct offset {
	uint16_t offset;
	int16_t scr_code;
};

struct helpfile {
	char name[128];
	FILE *fp;
	long filepos;
	struct offset *search_table;
	size_t name_cnt;
	char *string_table;
	uint16_t *screen_size_table;
	uint16_t *compressed_size_table;
};

#define NUM_HELPFILES 10

static struct helpfile helplibfiles[NUM_HELPFILES];

#define SCREENBUF_SIZE 16384
#define COMPRESS_CHUNK_SIZE 8192

/* buffer for decoded screen */
static char *screen_buffer = NULL;

static char const index_page[] =
	"\r\n"
	"\r\n"
	"\r\n"
	"          " ESC_CHR_S "\200\000Menu" ESC_CHR_S "\r\n"
	"          " ESC_CHR_S "\200\000Pascal" ESC_CHR_S "\r\n"
	"          " ESC_CHR_S "\200\000Shell" ESC_CHR_S "\r\n"
	"          " ESC_CHR_S "\200\000Debugger" ESC_CHR_S "\r\n"
	"          " ESC_CHR_S "\200\000Units" ESC_CHR_S "\r\n"
	"          " ESC_CHR_S "\200\000Assembler" ESC_CHR_S "\r\n"
;

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

int help_init(const char *helpdirpath)
{
	_DTA dta;
	char filename[128];
	int count;
	struct helpfile *file;
	const char *scan;
	const char *p;
	long len;
	
	file = helplibfiles;
	count = 0;
	scan = helpdirpath;
	Fsetdta(&dta);
	for (;;)
	{
		if (count >= NUM_HELPFILES)
			break;
		p = strchr(scan, ';');
		if (p == NULL)
			p = scan + strlen(scan);
		len = p - scan;
		if (len > 114)
			len = 114;
		strncpy(filename, scan, len);
		if (len > 0 && filename[len - 1] != '\\' && filename[len - 1] != '/')
			filename[len++] = '\\';
		strcpy(&filename[len], "*.hlp");
		if (Fsfirst(filename, 0) == 0)
		{
			do
			{
				if (count < NUM_HELPFILES)
				{
					strcpy(file->name, filename);
					strcpy(&file->name[len], dta.dta_name);
					file++;
					count++;
				}
			} while (Fsnext() == 0);
		}
		if (*p == '\0')
			break;
		scan = p + 1;
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

static void help_closefile(struct helpfile *file)
{
	if (file->fp != NULL)
	{
		fclose(file->fp);
		file->fp = NULL;
	}
	m_free(file->search_table);
	file->search_table = NULL;
	file->string_table = NULL;
	file->screen_size_table = NULL;
	file->compressed_size_table = NULL;
}

/* ---------------------------------------------------------------------- */

static void help_openfile(struct helpfile *file)
{
	PPHDR hdr;
	FILE *fp;
	
	fp = fopen(file->name, "rb");
	if (fp != NULL)
	{
		file->fp = fp;
		if (fread(&hdr, sizeof(hdr), 1, fp) == 1)
		{
			if (hdr.magic == cpu_to_be32(PP_MAGIC))
			{
				file->search_table = m_alloc(be32_to_cpu(hdr.search_tab_size) + be32_to_cpu(hdr.str_size) + be32_to_cpu(hdr.scr_tab_size) + be32_to_cpu(hdr.compr_tab_size));
				if (file->search_table != NULL)
				{
					long readok;
					
					file->name_cnt = be32_to_cpu(hdr.search_tab_size) / 4;
					file->string_table = (char *)file->search_table + be32_to_cpu(hdr.search_tab_size);
					file->screen_size_table = (uint16_t *)((char *)file->string_table + be32_to_cpu(hdr.str_size));
					file->compressed_size_table = (uint16_t *)((char *)file->screen_size_table + be32_to_cpu(hdr.scr_tab_size));
					readok = fread(file->search_table, be32_to_cpu(hdr.search_tab_size), 1, fp);
					readok &= fread(file->string_table, be32_to_cpu(hdr.str_size), 1, fp);
					readok &= fread(file->screen_size_table, be32_to_cpu(hdr.scr_tab_size), 1, fp);
					readok &= fread(file->compressed_size_table, be32_to_cpu(hdr.compr_tab_size), 1, fp);
					file->filepos = ftell(fp);
					if (readok != 0)
						return;
				}
			}
		}
		help_closefile(file);
	}
}

/* ---------------------------------------------------------------------- */

int help_exit(void)
{
	int i;

	for (i = 0; i < NUM_HELPFILES; i++)
	{
		help_closefile(&helplibfiles[i]);
	}
	m_free(screen_buffer);
	screen_buffer = NULL;
	return 0;
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static int help_findkey(const char *str, struct helpfile *file)
{
	long name_cnt;
	struct offset *table;
	char *strings;
	struct offset *entry;
	long middle;
	int cmp;
	
	name_cnt = file->name_cnt;
	table = file->search_table;
	strings = file->string_table;
	
	while (name_cnt > 0)
	{
		middle = name_cnt >> 1;
		entry = &table[middle];
		cmp = strcmp(str, strings + entry->offset);
		if (cmp < 0)
		{
			name_cnt = middle;
		} else if (cmp > 0)
		{
			table = entry + 1;
			name_cnt -= middle + 1;
		} else
		{
			return entry->scr_code;
		}
	}
	return -1;
}

/* ---------------------------------------------------------------------- */

static short help_find(const char *str)
{
	struct helpfile *file;
	char key[256];
	int i;
	int scr_code;
	
	file = helplibfiles;
	strncpy(key, str, sizeof(key) - 1);
	key[sizeof(key) - 1] = '\0';
	strupr(key);
	for (i = 0; i < NUM_HELPFILES && file->name[0] != '\0'; file++, i++)
	{
		if (file->fp == NULL)
			help_openfile(file);
		if (file->fp != NULL)
		{
			if ((scr_code = help_findkey(str, file)) != -1 ||
				(scr_code = help_findkey(key, file)) != -1)
			{
				return ((scr_code & 0x7ff) << 4) | (i + 1);
			}
		}
	}
	return -1;
}

/* ---------------------------------------------------------------------- */

static void help_decompress(FILE *fp, char *buf, size_t size)
{
	char *end = buf + size;
	int c;
	int len;
	
	while (buf < end)
	{
		c = fgetc(fp);
		if ((signed char)c >= 0)
		{
			if ((unsigned char)c == 0x7f)
				c = fgetc(fp);
			*buf++ = c;
		} else
		{
			char *src;
			
			c = (signed char)c << 8;
			c += fgetc(fp);
			if ((len = (c & 7)) == 0)
			{
				if ((len = fgetc(fp)) == 0)
				{
					len = fgetc(fp);
					len += fgetc(fp) << 8;
				}
			}
			src = &buf[c >> 3];
			if (end < &buf[len + 2])
			{
				len += 2;
				while (--len >= 0 && buf < end)
					*buf++ = *src++;
			} else
			{
				*buf++ = *src++;
				*buf++ = *src++;
				do
				{
					*buf++ = *src++;
				} while (--len > 0);
			}
		}
	}
}

/* ---------------------------------------------------------------------- */

int help_find_online(char *link, const char **str, long *len)
{
	short screen_no;
	unsigned short file_num;
	struct helpfile *file;
	uint16_t *screen_table;
	uint16_t *compressed_table;
	unsigned long screen_pos;
	short screen_len;
	short i;
	short chunk;
	long filepos;
	short code;
	char *buf;

	if (*link == ESC_CHR)
	{
		code = link[1];
		code <<= 8;
		code |= (unsigned char)link[2];
		if (code == 0)
		{
			*str = index_page;
			*len = sizeof(index_page) - 1;
			return 0;
		}
		link += 3;
		if ((unsigned short)code == 0x8000)
		{
			/*
			 * from the index page, where we don't know the file number
			 */
			code = help_find(link);
			if (code < 0)
				return AL_HELP_KEYWORD;
		}
	} else
	{
		code = help_find(link);
		if (code < 0)
			return AL_HELP_KEYWORD;
	}
	screen_no = (code >> 4) & 0x7ff;
	file_num = (int)(code & 0x0f) - 1;

	if (file_num >= NUM_HELPFILES)
		return AL_HELP_NOT_FOUND;

	file = &helplibfiles[file_num];
	if (file->fp == NULL)
		help_openfile(file);
	if (file->fp == NULL)
		return AL_HELP_NOT_FOUND;
	if (screen_buffer == NULL)
	{
		screen_buffer = m_alloc(SCREENBUF_SIZE);
		if (screen_buffer == NULL)
			return AL_LOWMEM;
	}
	
	screen_pos = 0;
	screen_table = file->screen_size_table;
	while (--screen_no >= 0)
	{
		screen_pos += *screen_table++;
	}
	screen_len = *screen_table;
	if (screen_len > SCREENBUF_SIZE || SCREENBUF_SIZE < COMPRESS_CHUNK_SIZE)
		return 0;
	chunk = (short)(screen_pos / COMPRESS_CHUNK_SIZE);
	filepos = file->filepos;
	compressed_table = file->compressed_size_table;
	while (--chunk >= 0)
	{
		filepos += *compressed_table++;
	}
	fseek(file->fp, filepos, SEEK_SET);
	buf = screen_buffer;
	for (i = 0; i < screen_len; )
	{
		short offset = (short)screen_pos & (COMPRESS_CHUNK_SIZE - 1);
		short len = COMPRESS_CHUNK_SIZE - offset;
		if (len > screen_len - i)
			len = screen_len - i;
		help_decompress(file->fp, buf, offset + len);
		memmove(buf, &buf[offset], len);
		buf += len;
		i += len;
		screen_pos += len;
	}
	
	*len = screen_len;
	*str = screen_buffer;

	/*
	 * The display code needs a marker for the start of links
	 */
	{
		char *end;

		buf = screen_buffer;
		end = screen_buffer + screen_len;
		while (buf < end)
		{
			if (*buf++ == ESC_CHR)
			{
				if (buf < end)
				{
					unsigned short scr_code;

					/*
					 * Replace the link code by a encoded screen number & file number.
					 * This makes sure that
					 * - the IS_LINK_START macro works in display.c
					 * - there are no CRs accidently part of the screen code
					 * - there are no NUL bytes in the stream
					 */
					scr_code = (unsigned char)buf[0];
					scr_code <<= 8;
					scr_code |= (unsigned char)buf[1];
					if (scr_code != LINK_EXTERNAL)
					{
						scr_code = ((scr_code & 0x7ff) << 4) | (file_num + 1);
						scr_code |= 0x8000;
					}
					*buf++ = scr_code >> 8;
					*buf++ = scr_code;
					while (buf < end)
					{
						if (*buf++ == ESC_CHR)
							break;
					}
				}
			}
		}
	}
	
	return 0;
}

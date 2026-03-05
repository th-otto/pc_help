#include "pc_help.h"
#include "hcint.h"
#ifndef ORIG_PUREC
#include <fcntl.h>
#endif
#include "endian_.h"
#include "alerts.h"

#if defined(__TOS__) || defined(__atarist__)
/*
 * use direct gemdos calls here, to reduce library overhead
 */
# define open(name, mode) (int)Fopen(name, mode)
# define close(fd) Fclose(fd)
# define read(fd, buf, count) Fread(fd, count, buf)
# define lseek(fd, offset, whence) Fseek(offset, fd, whence)
#endif

#ifndef O_BINARY
# ifdef _O_BINARY
#  define O_BINARY _O_BINARY
# else
#  define O_BINARY 0
# endif
#endif

struct helpfile {
	union {
	    const char *c;
	    char *s;
	} path;
	uint32_t *screen_table;         /* buffer for all tables (also start of screen table) */
	uint32_t scr_tab_size;          /* Length of screen table */
	uint32_t *str_table;            /* String-table start */
	uint32_t str_size;              /* Length in bytes */
	unsigned char char_table[CHAR_DIR]; /* Most common characters */
	char *caps_table;               /* Start capsens-Table */
	uint32_t caps_size;             /* Length in Bytes (count * 6) + length of strings */
	uint32_t caps_cnt;              /* No. of search-words */
	char *sens_table;               /* Start sensitive-Tab. */
	uint32_t sens_size;             /* Length in bytes (count * 6) + length of strings */
	uint32_t sens_cnt;              /* No. of search-words */
	short fd;
	long filepos;
};

#define NUM_HELPFILES 5

static struct helpfile helplibfiles[NUM_HELPFILES] = {
	{ { "pc.hlp" }, 0, 0, 0, 0, "", 0, 0, 0, 0, 0, 0, 0, 0 },
	{ { "c.hlp" }, 0, 0, 0, 0, "", 0, 0, 0, 0, 0, 0, 0, 0 },
	{ { "lib.hlp" }, 0, 0, 0, 0, "", 0, 0, 0, 0, 0, 0, 0, 0 },
	{ { "pasm.hlp" }, 0, 0, 0, 0, "", 0, 0, 0, 0, 0, 0, 0, 0 },
	{ { "usr.hlp" }, 0, 0, 0, 0, "", 0, 0, 0, 0, 0, 0, 0, 0 }
};

#define get_nibble(nibble) \
	if (oddflag) { oddflag = FALSE; nibble = b & 0x0f; } else { oddflag = TRUE; b = *encoded++; nibble = b >> 4; }
#define get_byte(byte) \
	get_nibble(byte); \
	byte <<= 4; \
	if (oddflag) { oddflag = FALSE; byte |= b & 0x0f; } else { oddflag = TRUE; b = *encoded++; byte |= b >> 4; }

#define SCREENBUF_SIZE ((size_t)16384)

/* buffer for decoded screen */
static uint8_t *screen_buffer = NULL;

static char const index_page[] =
	"\r\n"
	"\r\n"
	"\r\n"
	"          " ESC_CHR_S "\200\020Pure C" ESC_CHR_S "\r\n"      /* Screen #2 of file #0 */
	"          " ESC_CHR_S "\200\021C Language" ESC_CHR_S "\r\n"  /* Screen #2 of file #1 */
	"          " ESC_CHR_S "\200\022Libraries" ESC_CHR_S "\r\n"   /* Screen #2 of file #2 */
	"          " ESC_CHR_S "\200\023Assembler" ESC_CHR_S "\r\n"   /* Screen #2 of file #3 */
	"          " ESC_CHR_S "\200\024Userdefined Help" ESC_CHR_S   /* Screen #2 of file #4 */
;

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

int help_init(const char *pc_dir)
{
	int i;
	size_t len;
	char *dirstore;
	
	len = strlen(pc_dir) + 14;
	dirstore = m_alloc(len * NUM_HELPFILES);
	if (dirstore == NULL)
		return AL_LOWMEM;
	for (i = 0; i < NUM_HELPFILES; i++)
	{
		strcpy(dirstore, pc_dir);
		strcat(dirstore, helplibfiles[i].path.c);
		helplibfiles[i].path.s = dirstore;
		dirstore += len;
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

int help_exit(void)
{
	int i;

	for (i = 0; i < NUM_HELPFILES; i++)
	{
		if (helplibfiles[i].screen_table != NULL)
		{
			if (m_free(helplibfiles[i].screen_table) != 0)
				return AL_LOWMEM;
			helplibfiles[i].screen_table = NULL;
		}
		if (screen_buffer != NULL)
		{
			if (m_free(screen_buffer) != 0)
				return AL_LOWMEM;
			screen_buffer = NULL;
		}
		if (helplibfiles[i].fd != 0)
		{
			if (close(helplibfiles[i].fd) != 0)
				return AL_FILE_CLOSE;
			helplibfiles[i].fd = 0;
		}
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

static int read_header(struct helpfile *hlpfile)
{
	HLPHDR helphdr;
	int fd;
	uint32_t size;
	uint8_t *buffer;
	
	fd = open(hlpfile->path.c, O_RDONLY | O_BINARY);
	if (fd < 0)
		return AL_HELP_NOT_FOUND;
	if (read(fd, &helphdr, sizeof(helphdr)) != sizeof(helphdr))
	{
		close(fd);
		return AL_FILE_READ;
	}
	if (strncmp(helphdr.magic, HC_MAGIC, sizeof(helphdr.magic)) != 0)
	{
		close(fd);
		return AL_BAD_HELPFILE;
	}
	hlpfile->scr_tab_size = be32_to_cpu(helphdr.scr_tab_size);
	hlpfile->str_size = be32_to_cpu(helphdr.str_size);
	hlpfile->caps_size = be32_to_cpu(helphdr.caps_size);
	hlpfile->caps_cnt = be32_to_cpu(helphdr.caps_cnt);
	hlpfile->sens_size = be32_to_cpu(helphdr.sens_size);
	hlpfile->sens_cnt = be32_to_cpu(helphdr.sens_cnt);
	size = hlpfile->scr_tab_size + hlpfile->str_size + hlpfile->caps_size + hlpfile->sens_size;
	buffer = m_alloc(size);
	if (buffer == NULL)
	{
		close(fd);
		return AL_LOWMEM;
	}
	if ((size_t)read(fd, buffer, size) != size)
	{
		m_free(buffer);
		close(fd);
		return AL_FILE_READ;
	}
	memcpy(hlpfile->char_table, helphdr.char_table, sizeof(hlpfile->char_table));
	hlpfile->filepos = size + sizeof(helphdr);
	hlpfile->fd = fd;
	hlpfile->screen_table = (uint32_t *)buffer;
	/* string table always follows screen table (ignoring str_offset) */
	hlpfile->str_table = (uint32_t *)(buffer + hlpfile->scr_tab_size);
	/* caps table always follows string table (ignoring caps_offset) */
	hlpfile->caps_table = (char *)hlpfile->str_table + hlpfile->str_size;
	/* sens table always follows caps table (ignoring sens_offset) */
	hlpfile->sens_table = hlpfile->caps_table + hlpfile->caps_size;
	
	/* convert to screen count */
	hlpfile->scr_tab_size >>= 2;

	return 0;
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static int keyword_cmp(const void *key, const void *entry)
{
	return strcmp(key, (const char *)entry + be32_to_cpu(((const SRCHKEY_ENTRY *)entry)->pos));
}

/* ---------------------------------------------------------------------- */

static void *binsearch(const char *key, const char *table, size_t num_entries)
{
	size_t left;
	size_t right;
	size_t middle;
	const char *entry;
	int (*func)(const void *key, const void *entry);
	int cmp;
	
	left = 0;
	right = num_entries;
	if (right == 0)
		return NULL;
#if 0
	/* unneeded: won't happen */
	if (binsearch_entry_size == 0)
		return NULL;
#endif
	right--;
	func = keyword_cmp;
	for (;;)
	{
		middle = (left + right) >> 1;
		entry = table + middle * SIZEOF_SRCHKEY_ENTRY;
		cmp = func(key, entry);
		if (cmp == 0)
			return (void *)entry;
		if (cmp < 0)
		{
			right = middle;
			if (right == 0)
				return NULL;
			right--;
		} else
		{
			left = middle + 1;
		}
		if (left >= right)
			return NULL;
	}
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static void *search_helpfile(struct helpfile *hlpfile, const char *entry, bool caps)
{
	entry += 3;
	if (caps)
		return binsearch(entry, hlpfile->caps_table, hlpfile->caps_cnt);
	else
		return binsearch(entry, hlpfile->sens_table, hlpfile->sens_cnt);
}

/* ---------------------------------------------------------------------- */

static int search_allfiles(char *linkstart, char **link, bool caps)
{
	int i;
	void *found;

	for (i = 0; i < NUM_HELPFILES; i++)
	{
		struct helpfile *hlpfile = &helplibfiles[i];
		
		if (hlpfile->fd != 0 || read_header(hlpfile) == 0)
		{
			if ((found = search_helpfile(hlpfile, linkstart, caps)) != NULL)
			{
				*link = found;
				return 0;
			}
		}
	}
	return AL_HELP_KEYWORD;
}

/* ---------------------------------------------------------------------- */

int help_find_online(char *link, const char **str, long *len)
{
	int16_t scr_code;
	uint16_t screen_no;
	int16_t file_index;
	int err;
	char *linkstart;
	struct helpfile *hlpfile;
	uint32_t screen_start;
	uint32_t screen_size;
	unsigned char *encoded;
	unsigned char *decoded;
	bool oddflag;
	uint8_t b;
	uint8_t nibble;
	uint32_t *str_table;

	linkstart = link;
	if (*link++ == ESC_CHR)
	{
		scr_code = *link++;
		scr_code <<= 8;
		scr_code |= (unsigned char)*link++;
		if (scr_code != -1)
		{
			if (scr_code >= -1)
			{
				*str = index_page;
				*len = sizeof(index_page) - 1;
				return 0;
			}
			goto got_code;
		}
	}
	if (search_allfiles(linkstart, &link, TRUE) != 0)
	{
		strupr(linkstart);
		if ((err = search_allfiles(linkstart, &link, FALSE)) != 0)
			return err;
	}
	
	/*
	 * fetch code from SRCHKEY_ENTRY
	 */
	scr_code = link[4];
	scr_code <<= 8;
	scr_code |= (unsigned char)link[5];
	linkstart[1] = (scr_code >> 8);
	linkstart[2] = (scr_code);
	
got_code:
	file_index = scr_code & 7;
	/* calculate screen number */
	screen_no = ((scr_code & 0x7ff8) >> 3) - 1;
	if (file_index >= NUM_HELPFILES)
		return AL_HELP_KEYWORD;
	hlpfile = &helplibfiles[file_index];
	if (hlpfile->fd == 0 && (err = read_header(hlpfile)) != 0)
	{
		help_exit();
		return err;
	}
	if (screen_no >= hlpfile->scr_tab_size)
	{
		return AL_HELP_KEYWORD;
	}
	screen_start = be32_to_cpu(hlpfile->screen_table[screen_no]);
	screen_size = be32_to_cpu(hlpfile->screen_table[screen_no + 1]) - screen_start;
	if (screen_buffer != NULL)
	{
		if (m_free(screen_buffer) != 0)
		{
			help_exit();
			return AL_LOWMEM;
		}
		screen_buffer = NULL;
	}
	screen_buffer = m_alloc(SCREENBUF_SIZE);
	if (screen_buffer == NULL)
	{
		help_exit();
		return AL_LOWMEM;
	}
	screen_start -= hlpfile->filepos;
	hlpfile->filepos += screen_start;
	if (lseek(hlpfile->fd, screen_start, SEEK_CUR) != hlpfile->filepos)
	{
		help_exit();
		return AL_FILE_READ;
	}
	
	/*
	 * share the same buffer for encoded/decoded data:
	 * read the encoded data to the end
	 */
	decoded = screen_buffer;
	encoded = decoded + SCREENBUF_SIZE - screen_size;
	if ((size_t)read(hlpfile->fd, encoded, screen_size) != screen_size)
	{
		help_exit();
		return AL_FILE_READ;
	}
	hlpfile->filepos += screen_size;

	str_table = hlpfile->str_table;
	oddflag = FALSE;
	b = 0;
	for (;;)
	{
		get_nibble(nibble);
		if (nibble < CHAR_DIR)
		{
			*decoded++ = hlpfile->char_table[nibble];
		} else if (nibble == CHAR_DIR)
		{
			get_byte(nibble);
			*decoded++ = nibble;
		} else if (nibble == STR_NEWLINE)
		{
			*decoded++ = CR;
			*decoded++ = NL;
		} else if (nibble == STR_TABLE)
		{
			uint16_t idx;
			uint32_t offset;
			int str_len;
			uint8_t *src;
			
			get_byte(idx);
			idx <<= 4;
			get_nibble(nibble);
			idx |= nibble;
			offset = be32_to_cpu(str_table[idx]);
			str_len = (int)(be32_to_cpu(str_table[idx + 1]) - offset);
			src = (uint8_t *)str_table + offset;
			do
			{
				*decoded++ = *src++ ^ HC_ENCRYPT;
			} while (--str_len > 0);
		} else
		{
			/* must be CHAR_EMPTY: end of screen */
			break;
		}
	}
	*decoded = '\0';
	*len = decoded - screen_buffer;
	/*
	 * shrink to actual len
	 */
	if (x_realloc(screen_buffer, *len + 1) != 0)
	{
		help_exit();
		return AL_BAD_HELPFILE;
	}
	*str = (char *)screen_buffer;

	return 0;
}

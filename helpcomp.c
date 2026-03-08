#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdarg.h>
#ifdef __PUREC__
#include <ext.h>
#else
#include <time.h>
#include <unistd.h>
#define stricmp strcasecmp
#endif
#include <stdlib.h>
#include <stdint_.h>
#include "hcint.h"
#include "endian_.h"

#define SCR_NAME    	0	/* ScreenName */
#define ATTR_SENSITIVE  1	/* No distinction */
#define ATTR_CAPS       3	/* Caps/l.c. distinction */

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

#define LOG_FILENAME "helpcomp.log"
#define MAX_HELP_FILES 128
#define INBUF_SIZE ((size_t)16384)
#define MAX_SCREENS 8192
#define MAX_STRLEN 127
#define MAX_TOTALNAMES 65536L
#define SCREENBUF_SIZE ((size_t)32768L)
#undef FILENAME_MAX
#define FILENAME_MAX 119
#define COMPRESS_CHUNK_SIZE 8192


static uint16_t screen_size_table[MAX_SCREENS];
static int32_t screen_table[MAX_SCREENS];
static uint16_t compressed_size[1024];
static struct name *namelist;
struct offset {
	uint16_t offset;
	int16_t scr_code;
};
static struct offset offset_table[MAX_SCREENS];
static char name_array[MAX_TOTALNAMES];
static int name_cnt;
static long str_offset;
static size_t screen_size;
static char screen_buf[SCREENBUF_SIZE + COMPRESS_CHUNK_SIZE];

struct name {
	struct name *next;
	struct name *prev;
	short attr;
	int16_t screen_no;
	char name[0];
};

static struct {
	char create_log;
	char check_only;
	int tabsize;
	char verbose;
	char break_make;
} options;
static struct {
	char name[FILENAME_MAX + 1];
	int first_screen;
	int last_screen;
} helpfiles[MAX_HELP_FILES];
static int nfiles;
static char outfile_name[FILENAME_MAX];
static char err_filename[FILENAME_MAX];
static FILE *logfile;
static FILE *hc_infile;
static long err_lineno;

static void extract_path(const char *path, char *buf);
static void add_extension(char *buf, const char *ext);
static void compress_chunk(const char *buf, size_t size, FILE *fp);

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static void vlog(const char *format, va_list args)
{
	if (err_lineno != 0)
		printf("File: %s  Line: %ld  ", err_filename, err_lineno);
	vprintf(format, args);
	if (logfile != NULL)
	{
		if (err_lineno != 0)
			fprintf(logfile, "File: %s  Line: %ld  ", err_filename, err_lineno);
		vfprintf(logfile, format, args);
	}
}

/* ---------------------------------------------------------------------- */

__attribute__((format(printf, 1, 2)))
static void hclog(const char *format, ...)
{
	va_list args;
	
	va_start(args, format);
	vlog(format, args);
	va_end(args);
}

/* ---------------------------------------------------------------------- */

__attribute__((format(printf, 1, 2)))
static void fatal(const char *format, ...)
{
	va_list args;
	
	va_start(args, format);
	vlog(format, args);
	va_end(args);
	exit(EXIT_FAILURE);
}

/* ---------------------------------------------------------------------- */

__attribute__((format(printf, 1, 2)))
static void error(const char *format, ...)
{
	va_list args;
	
	va_start(args, format);
	vlog(format, args);
	va_end(args);
	if (options.break_make)
		exit(EXIT_FAILURE);
}

/* ---------------------------------------------------------------------- */

static int hc_getc(void)
{
	int c;
	
	c = fgetc(hc_infile);
	if (c == '\r') /* FIXME: handle CR/LF */
		err_lineno++;
	return c;
}

/* ---------------------------------------------------------------------- */

static void hc_ungetc(int c)
{
	if (c == '\r') /* FIXME: handle CR/LF */
		err_lineno--;
	ungetc(c, hc_infile);
}

/* ---------------------------------------------------------------------- */

static void open_file(const char *filename)
{
	hc_infile = fopen(filename, "rb");
	if (hc_infile == NULL)
		fatal("File not found: %s\n", filename);
	err_lineno = 1;
	strcpy(err_filename, filename);
}

/* ---------------------------------------------------------------------- */

static void close_file(void)
{
	fclose(hc_infile);
	err_lineno = 0;
}

/* ---------------------------------------------------------------------- */

static int skip_comments(void)
{
	int c;
	
	for (;;)
	{
		do
		{
			c = hc_getc();
		} while (isspace(c));
		if (c != '{')
			break;
		do
		{
			c = hc_getc();
		} while (c != EOF && c != '}');
		if (c == EOF)
			fatal("Unterminated comment\n");
	}
	hc_ungetc(c);
	return c;
}

/* ---------------------------------------------------------------------- */

static int parse_identifier(char *s)
{
	int len;
	int c;
	
	len = 0;
	c = hc_getc();
	if (isalpha(c))
	{
		while (isalnum(c))
		{
			if (len < MAX_STRLEN)
				s[len++] = c;
			c = hc_getc();
		}
	}
	s[len] = '\0';
	hc_ungetc(c);
	return len;
}

/* ---------------------------------------------------------------------- */

static void expect_char(int c)
{
	skip_comments();
	if (hc_getc() != c)
		fatal("'%c' expected\n", c);
}

/* ---------------------------------------------------------------------- */

static int parse_string(char *s)
{
	int len;
	int c;
	
	expect_char('"');
	len = 0;
	c = hc_getc();
	while (c != '"' && c != EOF)
	{
		if (len < MAX_STRLEN)
			s[len++] = c;
		c = hc_getc();
	}
	s[len] = '\0';
	if (c != '"')
		fatal("Unterminated string\n");
	return len;
}

/* ---------------------------------------------------------------------- */

static bool expect_screen(void)
{
	char id[MAX_STRLEN + 1];
	
	for (;;)
	{
		skip_comments();
		if (parse_identifier(id) == 0)
			break;
		if (strcmp(id, "screen") == 0)
			return TRUE;
		if (strcmp(id, "print") != 0)
			break;
		expect_char('(');
		parse_string(id);
		hclog("%s\n", id);
		expect_char(')');
	}
	if (hc_getc() != EOF)
		fatal("Screen directive expected\n");
	return FALSE;
}

/* ---------------------------------------------------------------------- */

#if !defined(__TOS__) && !defined(__atarist__)

static unsigned char const uppercase_table[256] =
{
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
	0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
	0x60, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
	0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
	0x58, 0x59, 0x5a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
	0x80, 0x55, 0x82, 0x83, 0x41, 0x85, 0x86, 0x87,
	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x41, 0x8f,
	0x90, 0x91, 0x92, 0x93, 0x4f, 0x95, 0x96, 0x97,
	0x98, 0x4f, 0x55, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
	0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
	0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
	0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
	0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
	0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
	0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
	0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
	0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
	0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
	0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
	0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
	0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff
};

static void atari_strupr(char *s)
{
	while (*s != '\0')
	{
		*s = uppercase_table[(unsigned char)*s];
		s++;
	}
}
#define strupr(s) atari_strupr(s)
#endif

/* ---------------------------------------------------------------------- */

static void ins_name(const char *s, int attr, int screen_no)
{
	size_t len;
	struct name *name;
	struct name *prev;
	
	len = strlen(s);
	name = (struct name *)g_malloc(sizeof(*name) + 1 + len);
	if (name == NULL)
		fatal("Out of memory\n");
	name->next = NULL;
	name->prev = NULL;
	name->attr = attr;
	name->screen_no = screen_no;
	strcpy(name->name, s);
	if (attr == SENS_TABLE)
		strupr(name->name);
	prev = namelist;
	if (prev == NULL)
	{
		namelist = name;
	} else
	{
		int cmp;
		
		for (;;)
		{
			cmp = strcmp(name->name, prev->name);
			if (cmp < 0)
			{
				if (prev->next != NULL)
				{
					prev = prev->next;
				} else
				{
					prev->next = name;
					return;
				}
			} else if (cmp > 0)
			{
				if (prev->prev != NULL)
				{
					prev = prev->prev;
				} else
				{
					prev->prev = name;
					return;
				}
			} else
			{
				fatal("Screen name collision %s\n", s);
			}
		}
	}
}

/* ---------------------------------------------------------------------- */

static int16_t find_code(const char *s)
{
	struct name *name;
	int cmp;
	char buf[MAX_STRLEN + 1];
	
	for (name = namelist; name != NULL; )
	{
		cmp = strcmp(s, name->name);
		if (cmp < 0)
			name = name->next;
		else if (cmp <= 0)
			return name->screen_no;
		else
			name = name->prev;
	}
	strcpy(buf, s);
	strupr(buf);
	for (name = namelist; name != NULL; )
	{
		cmp = strcmp(buf, name->name);
		if (cmp >= 0)
		{
			if (cmp > 0)
			{
				name = name->prev;
			} else
			{
				if (name->attr == ATTR_SENSITIVE)
					return name->screen_no;
				name = name->next;
			}
		} else
		{
			name = name->next;
		}
	}
	
	return -1;
}

/* ---------------------------------------------------------------------- */

static void calc_offsets(struct name *name)
{
	for (; name != NULL; name = name->prev)
	{
		if (name->next != NULL)
			calc_offsets(name->next);
		if (name->attr != SCR_NAME)
		{
			struct offset *offset;
			size_t len;
			
			len = strlen(name->name) + 1;
			if (name_cnt >= MAX_SCREENS || str_offset + len >= MAX_TOTALNAMES)
				fatal("Table overflow\n");
			offset = &offset_table[name_cnt];
			offset->offset = str_offset;
			offset->scr_code = name->screen_no;
			if (name->attr == ATTR_SENSITIVE)
				offset->scr_code |= SCR_SENSITIVE_FLAG;
			name_cnt++;
			strcpy(name_array + str_offset, name->name);
			str_offset += len;
		}
	}
}

/* ---------------------------------------------------------------------- */

static int parse_screenattr(void)
{
	int attr;
	char id[MAX_STRLEN + 1];
	
	attr = 0;
	for (;;)
	{
		skip_comments();
		if (parse_identifier(id) == 0)
			fatal("'sensitive' or 'capsensitive' expected\n");
		if (stricmp(id, "sensitive") == 0)
			attr |= ATTR_SENSITIVE;
		else if (stricmp(id, "capsensitive") == 0)
			attr |= ATTR_CAPS;
		else
			fatal("'sensitive' or 'capsensitive' expected\n");
		if (skip_comments() != '|')
			break;
		hc_getc();
	}
	return attr;
}

/* ---------------------------------------------------------------------- */

static void parse_screennames(int screen_no)
{
	int c;
	int attr;
	char id[MAX_STRLEN + 1];
	
	expect_char('(');
	for (;;)
	{
		c = skip_comments();
		if (c == ')')
			break;
		/*
		 * accepts either capsensitive("title") (new style)
		 * or "title":capsensitive (old style)
		 */
		if (c == '"')
		{
			parse_string(id);
			attr = SCR_NAME;
		} else
		{
			attr = parse_screenattr();
			expect_char('(');
			parse_string(id);
			expect_char(')');
		}
		c = skip_comments();
		if (c == ':')
		{
			hc_getc();
			attr = parse_screenattr();
			c = skip_comments();
		}
		ins_name(id, attr, screen_no);
		if (c == ',')
			hc_getc();
	}
	expect_char(')');
	skip_comments();
}

/* ---------------------------------------------------------------------- */

static void skip_screen(void)
{
	int c;
	char id[MAX_STRLEN + 1];

	do
	{
		/* for (;;) XXX */
		again:
		{
			c = hc_getc();
			if (c == EOF)
			{
				fatal("Unterminated screen\n");
			} else if (c == '\t')
			{
				screen_size += options.tabsize;
			} else if (c != '\\')
			{
				screen_size += 1;
			} else
			{
				c = hc_getc();
				if (c == '\\')
				{
					screen_size += 1;
				} else if (c == '#')
				{
					screen_size += 2;
				} else
				{
					goto done; /* XXX break; */
				}
			}
			goto again;
		}
		done:;
		hc_ungetc(c);
	} while (parse_identifier(id) == 0 || strcmp(id, "end") != 0);
}

/* ---------------------------------------------------------------------- */

static void parse_link(char *s)
{
	int len;
	int c;
	
	len = 0;
	while ((c = hc_getc()) != '\\')
	{
		if (c == EOF)
			fatal("Unterminated reference\n");
		if (len < MAX_STRLEN)
			s[len++] = c;
	}
	c = hc_getc();
	if (c != '#')
		fatal("'#' expected\n");
	c = hc_getc();
	if (c & 0x80)
		fatal("Illegal character after cross reference\n");
	hc_ungetc(c);
	s[len] = '\0';
}

/* ---------------------------------------------------------------------- */

static char *parse_reference(const char *name, const char *text, char *link)
{
	int16_t scr_code;
	
	scr_code = find_code(name);
	if (scr_code < 0)
	{
		if (name == text)
			error("Reference to unknown screen %s\n", name);
		else
			error("Link to unknown screen %s\n", name);
	}
	*link++ = ESC_CHR;
	*link++ = scr_code >> 8;
	*link++ = scr_code & 0xff;
	while ((*link++ = *text++) != '\0')
		;
	link[-1] = ESC_CHR;
	return link;
}

/* ---------------------------------------------------------------------- */

static char *parse_screen(char *ptr)
{
	char text[MAX_STRLEN + 1];
	char name[MAX_STRLEN + 1];
	int c;
	
	for (;;)
	{
		if (ptr >= &screen_buf[SCREENBUF_SIZE - 1])
			fatal("Screen too long\n");
		c = hc_getc();
		if (c == '\\')
		{
			c = hc_getc();
			if (c == '#')
			{
				parse_link(text);
				ptr = parse_reference(text, text, ptr);
			} else if (c == '\\')
			{
				*ptr++ = '\\';
			} else
			{
				hc_ungetc(c);
				if (parse_identifier(text) != 0)
				{
					if (strcmp(text, "link") == 0)
					{
						expect_char('(');
						parse_string(name);
						expect_char(')');
						parse_link(text);
						ptr = parse_reference(name, text, ptr);
					} else if (strcmp(text, "end") == 0)
					{
						break;
					} else if (strcmp(text, "nop") == 0)
					{
						break;
					} else
					{
						fatal("Unknown directive %s\n", text);
					}
				} else
				{
					*ptr++ = '\\';
				}
			}
		} else if (c == '\t')
		{
			for (c = 0; c < options.tabsize; c++)
				*ptr++ = ' ';
		} else if (c == EOF)
		{
			fatal("Unterminated screen\n");
		} else
		{
			*ptr++ = c;
		}
	}
	return ptr;
}

/* ---------------------------------------------------------------------- */

static void skip_to(long pos)
{
	long count;
	
	count = pos - ftell(hc_infile);
	if (count < 0)
	{
		fseek(hc_infile, pos, SEEK_SET);
	} else
	{
		while (--count >= 0)
			hc_getc();
	}
}

/* ---------------------------------------------------------------------- */

static void read_commandfile(const char *path)
{
	int c;
	int len;
	char filename[FILENAME_MAX + 1];

	c = hc_getc();
	nfiles = -1;
	while (c != EOF)
	{
		while (c != EOF && isspace(c))
			c = hc_getc();
		if (c == ';')
		{
			c = hc_getc();
			while (c != '\n' && c != EOF)
				c = hc_getc();
			continue;
		} else if (c == '-')
		{
			c = hc_getc();
			while (isalnum(c))
			{
				switch(toupper(c))
				{
				case 'L':
					options.create_log = TRUE;
					break;
				case 'N':
					options.check_only = TRUE;
					break;
				case 'V':
					options.verbose = TRUE;
					break;
				case 'W':
					options.break_make = TRUE;
					break;
				case 'T':
					if (hc_getc() != '=')
						fatal("'=' expected in T-option\n");
					c = hc_getc();
					if (isdigit(c))
						options.tabsize = c - '0';
					else
						fatal("Digit expected after 'T='\n");
					break;
				default:
					error("Invalid option character: '%c'\n", c);
					break;
				}
				c = hc_getc();
			}
			continue;
		}
		len = 0;
		while (c != EOF && !isspace(c))
		{
			if (len < FILENAME_MAX)
				filename[len++] = c;
			c = hc_getc();
		}
		filename[len] = '\0';
		if (filename[0] != '\0')
		{
			if (nfiles < 0)
			{
				strcpy(outfile_name, filename);
			} else if (nfiles < MAX_HELP_FILES)
			{
				char *name = helpfiles[nfiles].name;
				
				if (filename[0] != '\\' &&
					filename[0] != '/' &&
					filename[1] != ':')
					strcpy(name, path);
				else
					*name = '\0';
				strcat(name, filename);
			} else
			{
				fatal("Too many input files\n");
			}
			nfiles++;
		}
	}
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static void process_command_file(char *cmdname)
{
	long compr_tab_size;
	PPHDR hdr;
	char path[FILENAME_MAX + 1];
	int screen_no;
	int i;
	int chunk_no;
	int scr;
	char *ptr;
	char *end;
	FILE *fp;
	
	extract_path(cmdname, path);
	add_extension(cmdname, ".cmd");
	open_file(cmdname);
	read_commandfile(path);
	close_file();
	if (options.create_log)
	{
		logfile = fopen(LOG_FILENAME, "w");
		if (logfile == NULL)
			fatal("Could not create '" LOG_FILENAME "'\n");
	}
	if (nfiles <= 0)
		fatal("No input files to process\n");
	screen_no = 0;
	screen_size = 0;
	for (i = 0; i < nfiles; i++)
	{
		open_file(helpfiles[i].name);
		setvbuf(hc_infile, NULL, _IOFBF, INBUF_SIZE);
		helpfiles[i].first_screen = screen_no;
		while (expect_screen())
		{
			if (screen_no >= MAX_SCREENS)
				fatal("Too many screens\n");
			parse_screennames(screen_no);
			screen_table[screen_no] = ftell(hc_infile);
			skip_screen();
			screen_no++;
		}
		helpfiles[i].last_screen = screen_no;
		close_file();
	}
	
	name_cnt = 0;
	str_offset = 0;
	calc_offsets(namelist);
	/* align to even size */
	str_offset += str_offset & 1;
	
	compr_tab_size = (screen_size + COMPRESS_CHUNK_SIZE - 1) / COMPRESS_CHUNK_SIZE;
	if (compr_tab_size >= 1024)
		fatal("Help file too large\n");
	
	if (options.check_only)
	{
		fp = NULL;
	} else
	{
		fp = fopen(outfile_name, "wb");
		if (fp == NULL)
		{
			fatal("Create error %s\n", outfile_name);
		} else
		{
			if (options.verbose)
				hclog("Output file: %s\n", outfile_name);
		}
	}
	
	if (fp != NULL)
	{
		setvbuf(fp, NULL, _IOFBF, INBUF_SIZE);
		hdr.magic = cpu_to_be32(PP_MAGIC);
		hdr.search_tab_size = cpu_to_be32(name_cnt * sizeof(struct offset));
		hdr.str_size = cpu_to_be32(str_offset);
		hdr.scr_tab_size = cpu_to_be32(screen_no * sizeof(uint16_t));
		hdr.compr_tab_size = cpu_to_be32(compr_tab_size * 2);
		/* avoid writing garbage to header */
		hdr.reserved_20 = cpu_to_be32(0);
		hdr.reserved_24 = cpu_to_be32(0);
		hdr.reserved_28 = cpu_to_be32(0);
		fwrite(&hdr, sizeof(hdr), 1, fp);
#ifdef MUST_SWAP
		for (i = 0; i < name_cnt; i++)
		{
			offset_table[i].offset = cpu_to_be16(offset_table[i].offset);
			offset_table[i].scr_code = cpu_to_be16(offset_table[i].scr_code);
		}
#endif
		fwrite(offset_table, sizeof(offset_table[0]), name_cnt, fp);
		fwrite(name_array, 1, str_offset, fp);
		/*
		 * dummy write, will be updated later
		 */
		fwrite(screen_size_table, sizeof(screen_size_table[0]), screen_no, fp);
		fwrite(compressed_size, sizeof(compressed_size[0]), compr_tab_size, fp);
	}
	
	ptr = screen_buf;
	chunk_no = 0;
	for (i = 0; i < nfiles; i++)
	{
		open_file(helpfiles[i].name);
		setvbuf(hc_infile, NULL, _IOFBF, INBUF_SIZE);
		fseek(hc_infile, 0, SEEK_SET); /* FIXME: unneeded */
		for (scr = helpfiles[i].first_screen; scr < helpfiles[i].last_screen; scr++)
		{
			skip_to(screen_table[scr]);
			end = parse_screen(ptr);
			screen_size_table[scr] = (uint16_t)(end - ptr);
			ptr = end;
			if (fp != NULL)
			{
				while (ptr >= &screen_buf[COMPRESS_CHUNK_SIZE])
				{
					long pos = ftell(fp);
					compress_chunk(screen_buf, COMPRESS_CHUNK_SIZE, fp);
					memmove(screen_buf, &screen_buf[COMPRESS_CHUNK_SIZE], ptr - &screen_buf[COMPRESS_CHUNK_SIZE]);
					ptr -= COMPRESS_CHUNK_SIZE;
					compressed_size[chunk_no] = (uint16_t)(ftell(fp) - pos);
					chunk_no++;
				}
			} else
			{
				while (ptr >= &screen_buf[COMPRESS_CHUNK_SIZE])
					ptr -= COMPRESS_CHUNK_SIZE;
			}
		}
		close_file();
	}
	
	if (fp != NULL)
	{
		if (ptr > screen_buf)
		{
			long pos = ftell(fp);
			compress_chunk(screen_buf, ptr - screen_buf, fp);
			compressed_size[chunk_no] = (uint16_t)(ftell(fp) - pos);
			chunk_no++;
		}
		if (options.verbose)
		{
			hclog("File size           : %6ld\n", (long)ftell(fp));
			hclog("Number of screens   : %6d\n", screen_no);
			hclog("Number of key words : %6d\n", name_cnt);
		}
		fseek(fp, be32_to_cpu(hdr.search_tab_size) + be32_to_cpu(hdr.str_size) + sizeof(hdr), SEEK_SET);
#ifdef MUST_SWAP
		for (i = 0; i < screen_no; i++)
		{
			screen_size_table[i] = cpu_to_be16(screen_size_table[i]);
		}
		for (i = 0; i < compr_tab_size; i++)
		{
			compressed_size[i] = cpu_to_be16(compressed_size[i]);
		}
#endif
		fwrite(screen_size_table, sizeof(screen_size_table[0]), screen_no, fp);
		fwrite(compressed_size, sizeof(compressed_size[0]), compr_tab_size, fp);
		fclose(fp);
	}
}

/* ---------------------------------------------------------------------- */

int main(int argc, char **argv)
{
	int i;
	char *arg;
	
	if (argc < 2)
		fatal("Usage: hc commandfile\n");
	
	options.tabsize = 4;
	for (i = 1; i < argc; i++)
	{
		char c;

		arg = argv[i];
		
		if (*arg++ == '-')
		{
			while ((c = *arg++) != '\0')
			{
				switch (toupper(c))
				{
				case 'L':
					options.create_log = TRUE;
					break;
				case 'N':
					options.check_only = TRUE;
					break;
				case 'V':
					options.verbose = TRUE;
					break;
				case 'W':
					options.break_make = TRUE;
					break;
				case 'T':
					if (*arg++ != '=')
						fatal("'=' expected in T-option\n");
					c = *arg++;
					if (isdigit(c))
						options.tabsize = c - '0';
					else
						fatal("Digit expected after 'T='\n");
					break;
				default:
					error("Invalid option character: '%c'\n", c);
					break;
				}
			}
		}
	}
	
	for (i = 1; i < argc; i++)
	{
		arg = argv[i];
		if (*arg != '-')
			process_command_file(arg);
	}
	return EXIT_SUCCESS;
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static short x45a3c[32766L];
static short x55a38[4096];
static short x57a38;
static short x57a3a;
static long x57a3c;
static short x57a40;
static long x57a42[512];
static long x58242;
static long x58246;
static long x5824a[255];
static long x58646[15];

static void compress_init(void)
{
	int i;
	
	for (i = 0; i < 4096; i++)
	{
		x55a38[i] = -1;
	}
	x57a3a = 0;
	x57a38 = 0;
	x57a3c = 0;
	x57a40 = 0;
}

/* ---------------------------------------------------------------------- */

static short x1105a(short x)
{
	if (x == 0)
	{
		return 0;
	} else
	{
		short mask;
		short n;
		
		for (mask = 0x7fff, n = 16; mask >= x; )
		{
			mask >>= 1;
			n--;
		}
		return n;
	}
}

/* ---------------------------------------------------------------------- */

static void x11076(unsigned char c, FILE *fp)
{
	if (c >= 127)
	{
		fputc(127, fp);
	}
	fputc(c, fp);
	x57a42[c]++;
	x58242++;
}

/* ---------------------------------------------------------------------- */

static void x110b0(int d0, int d1, int d4, FILE *fp)
{
	int d3 = d1 - d0;
	int d5;
	
	x58646[x1105a(-d3)]++;
	d4 -= 2;
	if (d4 >= 8)
	{
		d5 = d3 << 3;
		fputc(d5 >> 8, fp);
		fputc(d5, fp);
		if (d4 >= 255)
		{
			fputc(0, fp);
			fputc(d4, fp);
			fputc(d4 >> 8, fp);
		} else
		{
			x5824a[d4]++;
			fputc(d4, fp);
		}
	} else
	{
		x5824a[d4]++;
		d5 = (d3 << 3) + d4;
		fputc(d5 >> 8, fp);
		fputc(d5, fp);
	}
	x58246++;
}

/* ---------------------------------------------------------------------- */

static short x11150(const char *buf, int d0, int d1, short *a1)
{
	unsigned char d2;
	int d3;
	int d4;
	int d5;
	const char *ptr;
	const short *a3;
	const char *a4;
	
	ptr = buf + d0;
	d2 = *ptr;
	a3 = x45a3c;
	d3 = -1;
	d4 = 0;
	for (;;)
	{
	again:
		d0 = a3[d0];
		if (d0 < d1)
			break;
		a4 = &buf[d0];
		if (a4[d4] == d2)
		{
			d5 = d4;
			for (;;)
			{
				if (--d5 < 0)
				{
					d5 = d4;
					while (a4[d5] == ptr[d5])
						d5++;
					d3 = d0;
					d4 = d5;
					d2 = ptr[d4];
					goto again;
				} else
				{
					if (a4[d5] != ptr[d5])
						goto again;
				}
			}
			
		}
	}
	*a1 = d4;
	return d3;
}

/* ---------------------------------------------------------------------- */

static void x111b2(const char *buf, int size)
{
	short *a3;
	short *a1 = x45a3c;
	short d1 = *buf++;
	short d2 = *buf++;
	int i;
	short d4;
	short d5;
	
	size -= 2;
	for (i = 0; i < size; i++, d1 = d2, d2 = d4)
	{
		d4 = *buf++;
		d5 = ((d1 << 8) + (d2 << 4) + d1 + d2 + d4) & 0xfff;
		a3 = &x55a38[d5];
		*a1++ = *a3;
		*a3 = i;
	}
}

/* ---------------------------------------------------------------------- */

static void compress_buf(const char *buf, size_t _size, FILE *fp)
{
	int i;
	int d5;
	short d6;
	short d7;
	short o2;
	short o0;
	int size = (int)_size;

	x111b2(buf, size);
	for (i = 0; i < size; )
	{
		d5 = 0;
		if (i > 4096)
			d5 = i - 4096;
		d6 = x11150(buf, i, d5, &o2);
		if (o2 <= 2)
		{
			x11076(buf[i], fp);
			i++;
		} else
		{
			for (;;)
			{
				d7 = x11150(buf, i + 1, d5 + 1, &o0);
				if (o2 >= o0)
				{
					if (o2 > size - i)
					{
						o2 = size - i;
						if (size - i <= 2)
						{
							x11076(buf[d6], fp);
							if (o2 == 2)
								x11076(buf[d6 + 1], fp);
						} else
						{
							x110b0(i, d6, o2, fp);
						}
					} else
					{
						x110b0(i, d6, o2, fp);
					}
					i += o2;
					break;
				} else
				{
					x11076(buf[i], fp);
					i++;
					d6 = d7;
					o2 = o0;
				}
			}
		}
	}
}

/* ---------------------------------------------------------------------- */

static void compress_chunk(const char *buf, size_t size, FILE *fp)
{
	compress_init();
	compress_buf(buf, size, fp);
}

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static int file_namelen(const char *s, int len)
{
	int i;
	char c;
	
	for (i = len - 1; i > 0; i--)
	{
		c = s[i];
		if (c == '\\' ||
			c == '/' ||
			c == ':')
			return len;
		if (c == '.')
			return i;
	}
	return len;
}

/* ---------------------------------------------------------------------- */

static int file_pathlen(const char *path, int len)
{
	--len;
	while (len >= 0)
	{
		char c = path[len];
		if (c == '\\' ||
			c == '/' ||
			c == ':')
			break;
		len--;
	}
	len++;
	return len;
}

/* ---------------------------------------------------------------------- */

static void extract_path(const char *path, char *buf)
{
	int namelen;
	
	namelen = (int)strlen(path);
	namelen = file_namelen(path, namelen);
	namelen = file_pathlen(path, namelen);
	if (namelen != 0)
		strncpy(buf, path, namelen);
	buf[namelen] = '\0';
}

/* ---------------------------------------------------------------------- */

static void add_extension(char *path, const char *ext)
{
	int len;
	
	len = (int)strlen(path);
	if (file_namelen(path, len) == len)
		strcat(path, ext);
}

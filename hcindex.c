#include "hc.h"

static short const name_to_index[256] = {
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26,  0,  1,  2,  3,  4,  5,  6,
	 7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22,
	23, 24, 25, 26, 26, 26, 26, 26,
	26,  0,  1,  2,  3,  4,  5,  6,
	 7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22,
	23, 24, 25, 26, 26, 26, 26, 26,
	26, 20, 26, 26,  0, 26, 26, 26, /* lowercase u umlaut, lowercase a umlaut */
	26, 26, 26, 26, 26, 26,  0, 26, /* uppercase a umlaut */
	26, 26, 26, 26, 14, 26, 26, 26, /* lowercase o umlaut */
	26, 14, 20, 26, 26, 26, 26, 26, /* uppercase o umlaut, uppercase u umlaut */
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26,
	26, 26, 26, 26, 26, 26, 26, 26
};

#if WITH_FIXES
static unsigned char const uppercase_table[256] =
#else
static unsigned short const uppercase_table[256] =
#endif
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

long caps_size = 0;
long sens_size = 0;

#if !defined(ENABLE_NLS) && defined(COUNTRY) && COUNTRY == 0
#define index_name_other "Other"
#if WITH_FIXES
#define index_name_other2 index_name_other
#define index_name_other_end "\\#\\end" CTRL_Z_S
#define COMPILED_ON "was formatted on %d %s %d." "\r\n%s"
#else
#define index_name_other2 "Other\0ges"
#define index_name_other_end "\\#\\end" CTRL_Z_S "\0nd" CTRL_Z_S
#define COMPILED_ON "was formatted on %d %s %d" "\\end" CTRL_Z_S "\0s\0"
#endif
#define NO_INDEX_ENTRY "No keywords starting with this letter." "\\end" CTRL_Z_S "\0den." "\\end" CTRL_Z_S
#define SCREEN_TITLE "Index of available keywords:          "
#else
#define index_name_other "Sonstiges"
#define index_name_other2 index_name_other
#define index_name_other_end "\\#\\end" CTRL_Z_S
#define NO_INDEX_ENTRY "Zu diesem Buchstaben ist kein Eintrag vorhanden." "\\end" CTRL_Z_S
#define SCREEN_TITLE "Index der verf\201gbaren Schl\201sselw\224rter:"
#define COMPILED_ON "wurde \201bersetzt am %d.%s %d." "\r\n%s"
#endif

static char no_index_entry[] = "screen(\"a..\")" NO_INDEX_ENTRY;
static char const index_page[] =
	"screen(\"Index\")"
	SCREEN_TITLE "\r\n"
	"\r\n"
	"     \\#A..\\#       \\#B..\\#       \\#C..\\#      \\#D..\\#" "\r\n"
	"\r\n"
	"     \\#E..\\#       \\#F..\\#       \\#G..\\#      \\#H..\\#" "\r\n"
	"\r\n"
	"     \\#I..\\#       \\#J..\\#       \\#K..\\#      \\#L..\\#" "\r\n"
	"\r\n"
	"     \\#M..\\#       \\#N..\\#       \\#O..\\#      \\#P..\\#" "\r\n"
	"\r\n"
	"     \\#Q..\\#       \\#R..\\#       \\#S..\\#      \\#T..\\#" "\r\n"
	"\r\n"
	"     \\#U..\\#       \\#V..\\#       \\#W..\\#      \\#X..\\#" "\r\n"
	"\r\n"
	"     \\#Y..\\#       \\#Z..\\#" "\r\n"
	"\r\n"
	"     \\#" index_name_other index_name_other_end
;

#if !defined(ENABLE_NLS) && defined(COUNTRY) && COUNTRY == 0
static const char *copyright_name = "screen(\"Version\")\r\n";
#else
static const char *copyright_name = "screen(\"Copyright\")";
#endif
/* FIXME: only the compiler is (c) Borland, not the generated help file */
static const char *copyright = "\r\n(c) 1990 Borland International, Inc.\\end" CTRL_Z_S;

const char *month_names[12] = {
#if !defined(ENABLE_NLS) && defined(COUNTRY) && COUNTRY == 0
#if WITH_FIXES
	"January",
	"February",
	"March",
	"April",
#else
/* patched version which just replaces memory from german binary */
	"Jan.\0r",
	"Feb.\0ar",
	"Mar.",
	"April",
#endif
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December"
#else
	"Januar",
	"Februar",
	"M\204rz",
	"April",
	"Mai",
	"Juni",
	"Juli",
	"August",
	"September",
	"Oktober",
	"November",
	"Dezember"
#endif
};
static bool did_index = FALSE;

struct indexentry {
	char *text;
	scr_code_t scr_code;
	struct indexentry *next;
#if WITH_FIXES
	unsigned char free_me;
#endif
};
struct nameindex {
	struct indexentry *entries;
	unsigned long count;
};

static struct nameindex nameindex[INDEX_CNT];
INTERNAL_SRCHKEY_ENTRY *caps_table;
size_t caps_cnt;
INTERNAL_SRCHKEY_ENTRY *sens_table;
size_t sens_cnt;

static void generate_index_entries(const char *name, int idx);
static void add_search_key(INTERNAL_SRCHKEY_ENTRY *table, size_t count, struct indexentry *entry);
static int index_namecmp(const char *s1, const char *s2);

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void generate_index(void)
{
	char index_name[10] = "A..";
	int i;
	int screen_no;
	
#ifdef __GNUC__
	screen_no = 0; /* silence compiler */
#endif
	for (i = 0; i < INDEX_CNT; i++)
	{
		if (i == INDEX_CNT - 1)
			strcpy(index_name, index_name_other2);
		if (nameindex[i].count != 0)
		{
			generate_index_entries(index_name, i);
		} else
		{
			if (did_index == FALSE)
			{
				if (i < INDEX_CNT - 1)
					no_index_entry[8] = i + 'A';
				memcpy(hc_inbuf, no_index_entry, sizeof(no_index_entry));
				hc_inbuf_ptr = hc_inbuf;
				parse_file();
				did_index = TRUE;
				screen_no = screen_cnt;
			} else
			{
				add_index_entry(index_name, screen_no, SCR_NAME);
			}
		}
		index_name[0]++;
	}
#if !WITH_FIXES && !TEST_CODE
	/* BUG: must not be freed yet, because it is still used in do_references() */
	free_index();
#endif
}

/* ---------------------------------------------------------------------- */

void free_index(void)
{
	int i;
	struct indexentry *entry, *next;
	
	for (i = 0; i < INDEX_CNT; i++)
	{
		for (entry = nameindex[i].entries; entry != NULL; entry = next)
		{
			/* entry->name need not be freed, since it was copied to the search tables */
#if WITH_FIXES
			/*
			 * unless it was never copied to the search tables, because it was just a screen name
			 */
			if (entry->free_me)
				g_free(entry->text);
#endif
			next = entry->next;
			g_free(entry);
		}
#if WITH_FIXES
		nameindex[i].entries = NULL;
#endif
	}
}

/* ---------------------------------------------------------------------- */

static void format_index_entry(char *dst, const char *src, int maxlen, intptr_t neighbor)
{
	int len;
	
	len = 0;
	while (*src != '\0' && len < maxlen)
	{
		*dst++ = *src++;
		len++;
	}
	if (len < maxlen)
		*dst++ = ESC_CHR;
	else
		dst[-1] = ESC_CHR;
	len++;
	if (neighbor != 0)
	{
		while (len < maxlen)
		{
			*dst++ = ' ';
			len++;
		}
	}
	*dst = '\0';
}

#ifdef __PUREC__
/* we know that the internal & external representations are identical */
#define SCR_CODE(code) (code).xcode
#else
#define SCR_CODE(code) \
	((int16_t) ((code).u.hibit << 15) | \
	 ((uint16_t) (code).u.screen_no << 3) | \
	 ((uint16_t) (code).u.attr))
#endif

/* ---------------------------------------------------------------------- */

static void generate_index_entries(const char *name, int idx)
{
	char buf[31];
	char buf2[31];
	struct indexentry *left;
	struct indexentry *right;
	struct indexentry *neighbor;
	int count;
	
	last_indexentry_name = name;
	memset(buf, 0, sizeof(buf));
	memset(buf2, 0, sizeof(buf2));
	right = nameindex[idx].entries;
	left = right;
	for (count = 0; (unsigned long)count < (nameindex[idx].count >> 1); count++)
		right = right->next;
	if (nameindex[idx].count == 1)
		right = NULL;
	else if (nameindex[idx].count & 1)
		right = right->next;
	neighbor = right;
	screenbuf_ptr = screenbuf;
	hc_putc(CR);
	hc_putc(NL);
	for (count = 0; (unsigned long)count < nameindex[idx].count; count++)
	{
		format_index_entry(buf, left->text, (int)sizeof(buf) - 1, (intptr_t) neighbor);
		hc_puts("     ");
		hc_putc(ESC_CHR);
		hc_putw(SCR_CODE(left->scr_code));
		hc_puts(buf);
		if (right != NULL)
		{
			format_index_entry(buf2, right->text, (int)sizeof(buf2) - 1, 0);
			hc_puts("     ");
			hc_putc(ESC_CHR);
			hc_putw(SCR_CODE(right->scr_code));
			hc_puts(buf2);
			right = right->next;
			neighbor = right;
			count++;
		}
		hc_putc(CR);
		hc_putc(NL);
		left = left->next;
	}
	screen_cnt++;
	add_index_entry(name, screen_cnt, SCR_NAME);
	screen_table_offset[screen_cnt - 1] = screen_start;
	screen_start += screenbuf_ptr - screenbuf;
	hc_flshbuf();
	last_indexentry_name = NULL;
}

/* ---------------------------------------------------------------------- */

void clear_index(void)
{
#if WITH_FIXES
	memset(nameindex, 0, sizeof(nameindex));
#else
	memset(nameindex, 0, INDEX_CNT); /* BUG */
#endif
}

/* ---------------------------------------------------------------------- */

static long last_index_screenno = -1;

void add_index_entry(const char *name, int screen_no, int attr)
{
	int idx;
	struct indexentry *entry;
	char *newname;

	idx = name_to_index[(unsigned char)*name];
	nameindex[idx].count++;
	entry = g_new(struct indexentry, 1);
	if (entry == NULL)
	{
		hclog(ERR_NOMEM, LVL_FATAL);
	}
	newname = g_new(char, strlen(name) + 1);
	if (newname == NULL)
	{
		hclog(ERR_NOMEM, LVL_FATAL);
	}
	strcpy(newname, name);
	entry->text = newname;
	entry->scr_code.u.hibit = 1;
	entry->scr_code.u.screen_no = screen_no;
	entry->scr_code.u.attr = file_index;
	entry->next = NULL;
#if WITH_FIXES
	entry->free_me = TRUE;
#endif
	if (last_index_screenno != screen_no)
	{
		last_index_screenno = screen_no;
		last_indexentry_name = newname;
	}
	if (nameindex[idx].entries == NULL)
	{
		nameindex[idx].entries = entry;
	} else
	{
		struct indexentry **table;
		struct indexentry *prev;
		int cmp;
		
		prev = nameindex[idx].entries;
		table = &nameindex[idx].entries;
		(void)&table; /* XXX to get registers right */
		while (prev != NULL)
		{
			cmp = index_namecmp(prev->text, name);
			if (cmp == 0 && strcmp(prev->text, name) == 0)
			{
				hclog(ERR_DUPLICATE_SCREEN, LVL_ERROR, name);
#if WITH_FIXES
				g_free(newname);
				g_free(entry);
#endif
				return;
			}
			if (cmp > 0)
				break;
			table = &prev->next;
			prev = *table;
		}
		*table = entry;
		entry->next = prev;
	}
	if (attr == CAP_SENS)
	{
		add_search_key(caps_table, caps_cnt, entry);
		caps_cnt++;
		caps_size += strlen(newname) + 1;
	} else if (attr == SENSITIVE)
	{
		add_search_key(sens_table, sens_cnt, entry);
		sens_cnt++;
		sens_size += strlen(newname) + 1;
	}
}

/* ---------------------------------------------------------------------- */

static void add_search_key(INTERNAL_SRCHKEY_ENTRY *table, size_t count, struct indexentry *entry)
{
	/*
	 * search table takes ownership of the index entry text here
	 */
	table[count].u.name = entry->text;
	table[count].code = SCR_CODE(entry->scr_code);
#if WITH_FIXES
	entry->free_me = FALSE;
#endif
}

/* ---------------------------------------------------------------------- */

int16_t get_index_screen_code(const char *s)
{
	struct indexentry *entry;
	
	for (entry = nameindex[name_to_index[(unsigned char)*s]].entries; entry != NULL; entry = entry->next)
	{
		if (strcmp(s, entry->text) == 0)
			return SCR_CODE(entry->scr_code);
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

static int index_namecmp(const char *s1, const char *s2)
{
	while (uppercase_table[(unsigned char)*s1] == uppercase_table[(unsigned char)*s2])
	{
		if (*s1 == '\0')
			return 0;
		s1++;
		s2++;
	}
#if WITH_FIXES
	return uppercase_table[(unsigned char)*s1] - uppercase_table[(unsigned char)*s2];
#else
	return (unsigned char)*s1 - (unsigned char)*s2;
#endif
}

/* ---------------------------------------------------------------------- */

#if !defined(__TOS__) && !defined(__atarist__)
void atari_strupr(char *s)
{
	while (*s != '\0')
	{
		*s = uppercase_table[(unsigned char)*s];
		s++;
	}
}
#endif

/* ---------------------------------------------------------------------- */

void generate_index_page(void)
{
	memcpy(hc_inbuf, index_page, sizeof(index_page));
	hc_inbuf_ptr = hc_inbuf;
	parse_file();
}

/* ---------------------------------------------------------------------- */

void generate_copyright_page(void)
{
	char *name;
	
#if WITH_FIXES
	name = xbasename(outfile_name);
#else
	name = strrchr(outfile_name, '\\');
	if (name == NULL)
		name = outfile_name;
	else
		name++;
#endif
#if WITH_FIXES
	{
		time_t t;
		struct tm tm;
		
		t = time(0);
		tm = *localtime(&t);
	
		sprintf((char *)hc_inbuf, "%s%s " COMPILED_ON, copyright_name, name, tm.tm_mday, month_names[tm.tm_mon], tm.tm_year + 1900, copyright);
	}
#else
	{
		struct date d;
		
		getdate(&d);
		sprintf((char *)hc_inbuf, "%s%s " COMPILED_ON, copyright_name, name, (unsigned char)d.da_day, month_names[(unsigned char)d.da_mon - 1], d.da_year, copyright);
	}
#endif
	hc_inbuf_ptr = hc_inbuf;
	parse_file();
}

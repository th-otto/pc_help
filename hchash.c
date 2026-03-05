#include "hc.h"

struct hashitem *keyword_hash[KEYW_HASH_SIZE];
HLPHDR helphdr;
static NAME_ENTRY *namelist_tail;
uint32_t *screen_table_offset;

/* current screen number during parsing */
int screen_cnt = 0;
/* offset into temporary file where current screen starts */
size_t screen_start = 0;
NAME_ENTRY *namelist = NULL;

static void free_namelist(NAME_ENTRY *list);
static void write_table(INTERNAL_SRCHKEY_ENTRY *table, long count, size_t strsize);

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void skip_space(void)
{
	unsigned char c;
	unsigned char sc;
	
	do
	{
		c = hc_getc();
		sc = character_class[c];
	} while (sc == CC_WHITESPACE || sc == CC_CR);
	hc_back();
}

/* ---------------------------------------------------------------------- */

unsigned int calchash(const char *s, unsigned int hashsize)
{
	unsigned long hash;
	const char *p;
	
	hash = 0;
	p = s;
	while (*p++ != '\0')
		;
	hash = ((unsigned char)s[0] + (unsigned char)p[-2] * 32 + (p - s) * 256) % hashsize;
	return (unsigned int)hash;
}

/* ---------------------------------------------------------------------- */

void init_keyword_hash(void)
{
	const struct keyword *kw;
	struct hashitem *item;
	int hash;
	
	/*
	 * FIXME: there are only 10 keywords. Do we really need
	 * a hash for this?
	 */
	memset(keyword_hash, 0, sizeof(keyword_hash));
	for (kw = keywords; kw->name != NULL; kw++)
	{
		hash = calchash(kw->name, KEYW_HASH_SIZE);
		item = g_new(struct hashitem, 1);
		if (item == NULL)
			hclog(ERR_NOMEM, LVL_FATAL);
		item->type = kw->token;
		item->name = kw->name;
		item->next = NULL;
		if (keyword_hash[hash] == NULL)
		{
			keyword_hash[hash] = item;
		} else
		{
			struct hashitem *prev;
			
			prev = keyword_hash[hash];
			while (prev->next != NULL)
				prev = prev->next;
			prev->next = item;
		}
	}
}

/* ---------------------------------------------------------------------- */

void free_keyword_hash(void)
{
	struct hashitem *item, *next;
	int hash;
	
	for (hash = 0; hash < KEYW_HASH_SIZE; hash++)
	{
		for (item = keyword_hash[hash]; item != NULL; item = next)
		{
			next = item->next;
			g_free(item);
		}
		keyword_hash[hash] = NULL;
	}
}

/* ---------------------------------------------------------------------- */

void write_help(void)
{
	long offset;
	int i;
	
	hc_createfile(outfile_name);
	strncpy(helphdr.copyright, "Help System Version 2.0 (c) 1990 Borland International, Inc.\r\n\r\n\014\032\000", sizeof(helphdr.copyright));
#ifdef __GNUC__
	memcpy(helphdr.magic, HC_MAGIC, sizeof(helphdr.magic));
#else
	strncpy(helphdr.magic, HC_MAGIC, sizeof(helphdr.magic));
#endif
	helphdr.scr_tab_size = cpu_to_be32((uint32_t)(screen_cnt + 1) * sizeof(uint32_t));
	helphdr.str_offset = cpu_to_be32(be32_to_cpu(helphdr.scr_tab_size) + sizeof(helphdr));
#ifdef MUST_SWAP
	/* this is still in cpu order */
	helphdr.str_size = cpu_to_be32(helphdr.str_size);
#endif
	helphdr.caps_offset = cpu_to_be32(be32_to_cpu(helphdr.str_offset) + be32_to_cpu(helphdr.str_size));
	if ((caps_size & 1) != 0)
		caps_size++;
	helphdr.caps_size = cpu_to_be32(caps_cnt * SIZEOF_SRCHKEY_ENTRY + caps_size);
	helphdr.caps_cnt = cpu_to_be32(caps_cnt);
	helphdr.sens_offset = cpu_to_be32(be32_to_cpu(helphdr.caps_offset) + be32_to_cpu(helphdr.caps_size));
	if ((sens_size & 1) != 0)
		sens_size++;
	helphdr.sens_size = cpu_to_be32(sens_cnt * SIZEOF_SRCHKEY_ENTRY + sens_size);
	helphdr.sens_cnt = cpu_to_be32(sens_cnt);
#if TEST_CODE
	fprintf(stderr, "scr_tab_size: %lu\n", (unsigned long)be32_to_cpu(helphdr.scr_tab_size));
	fprintf(stderr, "str_offset:   %lu\n", (unsigned long)be32_to_cpu(helphdr.str_offset));
	fprintf(stderr, "str_size:     %lu\n", (unsigned long)be32_to_cpu(helphdr.str_size));
	fprintf(stderr, "char_table:   ");
	for (i = 0; i < CHAR_DIR; i++)
	{
		if (helphdr.char_table[i] >= 0x20 && helphdr.char_table[i] < 0x7f)
			putc(helphdr.char_table[i], stderr);
		else
			fprintf(stderr, "\\x%02x", helphdr.char_table[i]);
	}
	putc('\n', stderr);
	fprintf(stderr, "caps_offset:  %lu\n", (unsigned long)be32_to_cpu(helphdr.caps_offset));
	fprintf(stderr, "caps_size:    %lu\n", (unsigned long)be32_to_cpu(helphdr.caps_size));
	fprintf(stderr, "caps_cnt:     %lu\n", (unsigned long)be32_to_cpu(helphdr.caps_cnt));
	fprintf(stderr, "sens_offset:  %lu\n", (unsigned long)be32_to_cpu(helphdr.sens_offset));
	fprintf(stderr, "sens_size:    %lu\n", (unsigned long)be32_to_cpu(helphdr.sens_size));
	fprintf(stderr, "sens_cnt:     %lu\n", (unsigned long)be32_to_cpu(helphdr.sens_cnt));
	fprintf(stderr, "\nscreen_table_offset:\n");
#endif
	hc_fwrite(hc_outfile, sizeof(helphdr), &helphdr);
	offset = be32_to_cpu(helphdr.sens_offset) + be32_to_cpu(helphdr.sens_size);
	for (i = 0; i <= screen_cnt; i++)
	{
		screen_table_offset[i] += offset;
#if TEST_CODE
		fprintf(stderr, "%4d: %08lx\n", i, (unsigned long)screen_table_offset[i]);
#endif
#ifdef MUST_SWAP
		screen_table_offset[i] = cpu_to_be32(screen_table_offset[i]);
#endif
	}
	hc_fwrite(hc_outfile, (screen_cnt + 1) * sizeof(uint32_t), screen_table_offset);
	hc_copyfile(HC_TMP_STRINGS);
	write_table(caps_table, caps_cnt, caps_size);
	write_table(sens_table, sens_cnt, sens_size);
	g_free(caps_table);
	caps_table = NULL;
	g_free(sens_table);
	sens_table = NULL;
	hc_copyfile(HC_TMP_COMPRESSED);
	hc_closeout();
}

/* ---------------------------------------------------------------------- */

void add_name(const char *name, const char *filename, long lineno, long offset)
{
	NAME_ENTRY *newentry;
	char *newname;
	
	newentry = g_new(NAME_ENTRY, 1);
	newname = g_new(char, strlen(name) + 1);
	if (newentry == NULL || newname == NULL)
	{
		hclog(ERR_NOMEM, LVL_FATAL);
	}
	strcpy(newname, name);
	newentry->name = newname;
	newentry->filename = filename;
	newentry->lineno = lineno;
	newentry->offset = offset;
	newentry->next = NULL;
	if (namelist != NULL)
	{
		namelist_tail->next = newentry;
		namelist_tail = newentry;
	} else
	{
		namelist_tail = newentry;
		namelist = newentry;
	}
}

/* ---------------------------------------------------------------------- */

void do_references(const char *tmpname)
{
	FILE *fp;
	NAME_ENTRY *name;
	char buf[256];
	int16_t scr_code;
	
	if (namelist == NULL)
		return;
	if ((fp = fopen(tmpname, "rb+")) == NULL)
	{
		hclog(ERR_WRITE_ERROR, LVL_FATAL, "temporary file");
	}
	for (name = namelist; name != NULL; name = name->next)
	{
		fseek(fp, name->offset, SEEK_SET);
		if ((scr_code = get_index_screen_code(name->name)) >= 0)
		{
			strcpy(buf, name->name);
			atari_strupr(buf);
			if ((scr_code = get_index_screen_code(buf)) >= 0)
			{
				err_filename = name->filename;
				err_lineno = name->lineno;
				hclog(ERR_UNKNOWN_SCREEN, LVL_WARNING, name->name);
				scr_code = -1;
			}
		}
		putc(scr_code >> 8, fp);
		putc(scr_code, fp);
	}
	fclose(fp);
	free_namelist(namelist);
	namelist = NULL;
	namelist_tail = NULL;
}

/* ---------------------------------------------------------------------- */

static void free_namelist(NAME_ENTRY *list)
{
	NAME_ENTRY *next;
	
	while (list != NULL)
	{
		next = list->next;
		g_free(list->name);
		g_free(list);
		list = next;
	}
}

/* ---------------------------------------------------------------------- */

static int namecmp(const void *_s1, const void *_s2)
{
	return strcmp(((const INTERNAL_SRCHKEY_ENTRY *)_s1)->u.name, ((const INTERNAL_SRCHKEY_ENTRY *)_s2)->u.name);
}

/* ---------------------------------------------------------------------- */

static void write_table(INTERNAL_SRCHKEY_ENTRY *table, long count, size_t strsize)
{
	long i;
	size_t size;
	size_t pos;
	size_t len;
	
	i = 0;
	size = count * SIZEOF_SRCHKEY_ENTRY;
	if (size == 0)
		return;
	qsort(table, count, sizeof(*table), namecmp);
	hc_inbuf_ptr = hc_inbuf;
	pos = count * SIZEOF_SRCHKEY_ENTRY;
	do
	{
		len = strlen(table[i].u.name) + 1;
		if (hc_inbuf_ptr + len < hc_inbuf + INBUF_SIZE + SCREENBUF_SIZE)
		{
			strcpy((char *)hc_inbuf_ptr, table[i].u.name);
			g_free(table[i].u.name);
			hc_inbuf_ptr += len;
		} else
		{
			hclog(ERR_NOMEM, LVL_FATAL);
		}
		table[i].u.pos = pos;
		pos = pos + len - SIZEOF_SRCHKEY_ENTRY;
		++i;
	} while (i < count);

	/* for Pure-C we know that the internal & external representations are identical */
#ifndef __PUREC__
	if (sizeof(SRCHKEY_ENTRY) != sizeof(*table) || __BYTE_ORDER__ != __ORDER_BIG_ENDIAN__)
	{
		for (i = 0; i < count; i++)
		{
			SRCHKEY_ENTRY ent;
			
			ent.pos = cpu_to_be32(table[i].u.pos);
			ent.code = cpu_to_be16(table[i].code);
			if (fwrite(&ent, SIZEOF_SRCHKEY_ENTRY, 1, hc_outfile) != 1)
			{
				hclog(ERR_WRITE_ERROR, LVL_FATAL, outfile_name);
			}
		}
	} else
#endif
	{
		if (!hc_fwrite(hc_outfile, size, table))
		{
			hclog(ERR_WRITE_ERROR, LVL_FATAL, outfile_name);
		}
	}
	len = hc_inbuf_ptr - hc_inbuf;
	if (len & 1)
	{
		*hc_inbuf_ptr++ = 0;
		len++;
	}
	if (len != strsize)
	{
		hclog(ERR_STRING_MISMATCH, LVL_FATAL);
	}
	if (!hc_fwrite(hc_outfile, strsize, hc_inbuf))
	{
		hclog(ERR_WRITE_ERROR, LVL_FATAL, outfile_name);
	}
}

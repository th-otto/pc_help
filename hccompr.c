#include "hc.h"

struct x {
	short str_len;
	short prev_code;
	short str_code;
	unsigned char this_char;
};
struct codeinfo {
	int32_t count;
	int32_t code;
};

struct x *x163e2;
static struct codeinfo *char_counts;
static struct codeinfo *x163ea;

static int32_t codecmp(struct codeinfo *p1, struct codeinfo *p2);
static void init_tables(void);
static void init_codeinfo(struct codeinfo *table, int32_t count);
static int32_t x124fe(uint16_t prev_code, uint16_t this_char);
static void sort_codes(void *table, size_t nmemb, size_t size, int32_t (*cmp)(struct codeinfo *, struct codeinfo *));


#define MAX_CODES 0x4679L

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static unsigned char nibble;
static unsigned char oddflag;

static void write_compression(void);

static void write_nibble(unsigned char b)
{
#if TEST_CODE > 1
	fprintf(stderr, " %02x", b);
#endif
	if (!oddflag)
	{
		nibble = b << 4;
		oddflag = TRUE;
	} else
	{
		hc_putc(nibble | b);
		nibble = 0;
		oddflag = FALSE;
	}
}

/* ---------------------------------------------------------------------- */

static void flush_nibble(void)
{
	if (oddflag)
	{
		hc_putc(nibble);
		nibble = 0;
		oddflag = FALSE;
	}
}

/* ---------------------------------------------------------------------- */

void do_compress(void)
{
	unsigned int d3;
	int32_t i;
	int32_t xd5;
	int32_t str_count;
	int32_t *str_offset;

	d3 = 0;
	x163e2 = g_new(struct x, MAX_CODES);
	/* the code below will access this array with negative values??? */
	x163ea = g_new(struct codeinfo, 0x10000UL);
	char_counts = g_new(struct codeinfo, 256);
	if (x163e2 == NULL || x163ea == NULL || char_counts == NULL)
	{
		hclog(ERR_NOMEM, LVL_FATAL);
	}
	init_tables();
	init_codeinfo(x163ea, 0x10000UL);
	init_codeinfo(char_counts, 256);
	if ((hc_infile = fopen(HC_TMP_ENCODED, "rb")) == NULL)
	{
		hclog(ERR_OPEN_SOURCE, LVL_FATAL, "temporary file");
	}
	if (options.verbose)
		fprintf(stderr, "\n\treading uncompressed help screens\n");
	for (i = 0; i < screen_cnt; i++)
	{
		int str_len;
		uint16_t prev_code;
		uint16_t this_char;
		
		hc_inbuf_size = screen_table_offset[i + 1] - screen_table_offset[i];
		if (hc_fread(hc_infile, hc_inbuf_size, hc_inbuf) != hc_inbuf_size)
		{
			hclog(ERR_READ_ERROR, LVL_FATAL, "temporary file");
		}
		hc_inbuf_ptr = hc_inbuf;
		str_len = 1;
		prev_code = -*hc_inbuf_ptr;
		char_counts[*hc_inbuf_ptr++].count++;
		while (hc_inbuf_ptr < hc_inbuf + hc_inbuf_size)
		{
			int32_t code;
			
			this_char = *hc_inbuf_ptr++;
			code = x124fe(prev_code, this_char);
			char_counts[this_char].count++;
			str_len++;
			if (x163e2[code].prev_code != -256)
			{
				prev_code = (uint16_t)code;
			} else
			{
				if (d3 <= 0x3ffe)
				{
					d3++;
					x163e2[code].str_len = str_len;
					x163e2[code].prev_code = prev_code;
					x163e2[code].this_char = this_char;
				}
				/* BUG: this will access totally bogus indices??? */
				x163ea[prev_code].count++;
				prev_code = -this_char;
				str_len = 1;
			}
		}
	}
	
	if (options.verbose)
		fprintf(stderr, "\tcomputing compression\n");
	for (i = 0; i < MAX_CODES; i++)
	{
		if (x163e2[i].str_len < 4 || x163ea[i].count < 2)
		{
			x163ea[i].count = 0;
		} else
		{
			x163ea[i].count = x163ea[i].count * x163e2[i].str_len;
		}
	}

	sort_codes(x163ea, 4096, sizeof(*x163ea), codecmp);

#if TEST_CODE
	fprintf(stderr, "x163e2:\n");
	for (i = 0; i < MAX_CODES; i++)
	{
		if (x163e2[i].prev_code != -256)
			fprintf(stderr, "%04lx: %04x %04x %04x %02x\n", (long)i, (uint16_t)x163e2[i].str_len, (uint16_t)x163e2[i].prev_code, (uint16_t)x163e2[i].str_code, x163e2[i].this_char);
	}
	fprintf(stderr, "\n");

	fprintf(stderr, "x163ea:\n");
	for (i = 0; i < 0x10000L; i++)
	{
		if (x163ea[i].count != 0)
			fprintf(stderr, "%04lx: %ld %04lx\n", (long)i, (long)x163ea[i].count, (long)x163ea[i].code);
	}
	fprintf(stderr, "\n");
#endif

	if (x163ea[4095].count > 4)
		xd5 = x163ea[4095].count;
	else
		xd5 = 4;

	for (i = 4096; i < MAX_CODES; i++)
	{
		if (x163ea[i].count > xd5)
		{
			int32_t step;
			int32_t middle;

			middle = 2047;
			step = 1024;
			for (;;)
			{
				if (x163ea[middle].count == x163ea[i].count)
					break;
				if (x163ea[middle - 1].count > x163ea[i].count && x163ea[middle].count < x163ea[i].count)
					break;
				if (x163ea[middle].count > x163ea[i].count)
					middle += step;
				else
					middle -= step;
				step >>= 1;
			}
			memmove(&x163ea[middle + 1], &x163ea[middle], (4095 - middle) * sizeof(*x163ea));
			x163ea[middle] = x163ea[i];
			if (x163ea[4095].count > 4)
				xd5 = x163ea[4095].count;
			else
				xd5 = 4;
		}
	}
	for (i = 4095; i > 0 && x163ea[i].count == 0; i--)
		;

	str_count = i + 1;
	str_offset = g_new(int32_t, str_count + 1);
	if (str_offset == NULL)
	{
		hclog(ERR_NOMEM, LVL_FATAL);
	}
	str_offset[0] = (str_count + 1) * sizeof(*str_offset);
	for (i = 0; i < str_count; i++)
	{
		str_offset[i + 1] = x163e2[x163ea[i].code].str_len + str_offset[i];
	}

	hc_createfile(HC_TMP_STRINGS);
	if (options.verbose)
		fprintf(stderr, "\twriting compressed help screens\n");
#if TEST_CODE
	fprintf(stderr, "strings:\n");
	for (i = 0; i <= str_count; i++)
		fprintf(stderr, "%04lx: %06lx\n", (long)i, (long)str_offset[i]);
	fprintf(stderr, "\n");
#endif
#ifdef MUST_SWAP
	for (i = 0; i <= str_count; i++)
		str_offset[i] = cpu_to_be32(str_offset[i]);
#endif
	if (!hc_fwrite(hc_outfile, (str_count + 1) * sizeof(*str_offset), str_offset))
	{
		hclog(ERR_WRITE_ERROR, LVL_FATAL, "temporary file");
	}
#ifdef MUST_SWAP
	for (i = 0; i <= str_count; i++)
		str_offset[i] = be32_to_cpu(str_offset[i]);
#endif

	if (x163ea[str_count - 1].count > 4)
		xd5 = x163ea[str_count - 1].count;
	else
		xd5 = 4;
	for (i = 0; i < str_count; i++)
	{
		if (x163ea[i].count >= xd5)
		{
			int32_t count;
			unsigned char *a5;
			int32_t code;
			
			code = x163ea[i].code;
			x163e2[code].str_code = (short)i;
			count = x163ea[i].count / x163e2[code].str_len;
			a5 = screenbuf + x163e2[code].str_len;
			screenbuf_ptr = a5;
			*a5 = '\0';
			while (x163e2[code].prev_code >= 0)
			{
				*--a5 = x163e2[code].this_char ^ HC_ENCRYPT;
				char_counts[*a5].count -= count;
				if (x163e2[code].str_code < -1)
					x163e2[code].str_code = -1;
				code = x163e2[code].prev_code;
			}
			*--a5 = x163e2[code].this_char ^ HC_ENCRYPT;
			char_counts[*a5].count -= count;
			*--a5 = -x163e2[code].prev_code ^ HC_ENCRYPT;
			char_counts[*a5].count -= count;
			if (x163e2[code].str_code < -1)
				x163e2[code].str_code = -1;
			hc_flshbuf();
		}
	}

	if ((helphdr.str_size = str_offset[str_count]) & 1)
	{
		helphdr.str_size += 1;
		*screenbuf_ptr = 0;
		fwrite(screenbuf_ptr, 1, 1, hc_outfile);
	}

	hc_closeout();
	g_free(str_offset);
	g_free(x163ea);
	
	memset(helphdr.char_table, 0, CHAR_DIR);
	char_counts['\0'].count = char_counts[NL].count = char_counts[CR].count = 0;
	sort_codes(char_counts, 256, sizeof(*char_counts), codecmp);
	for (i = 0; i < CHAR_DIR; i++)
	{
		helphdr.char_table[i] = char_counts[i].code;
	}
	g_free(char_counts);
	rewind(hc_infile);
	/*
	 * compress using generic version
	 */
	write_compression();
	fclose(hc_infile);
	g_free(x163e2);
	unlink(HC_TMP_ENCODED);
}

/* ---------------------------------------------------------------------- */

static int32_t codecmp(struct codeinfo *p1, struct codeinfo *p2)
{
	return p2->count - p1->count;
}

/* ---------------------------------------------------------------------- */

static void init_tables(void)
{
	int32_t i;
	
	for (i = 0; i < MAX_CODES; i++)
	{
		x163e2[i].str_len = 0;
		x163e2[i].prev_code = -256;
		x163e2[i].str_code = -2;
		x163e2[i].this_char = 0;
	}
}

/* ---------------------------------------------------------------------- */

static void init_codeinfo(struct codeinfo *table, int32_t count)
{
	int32_t i;
	
	for (i = 0; i < count; i++)
	{
		table[i].count = 0;
		table[i].code = i;
	}
}

/* ---------------------------------------------------------------------- */

static int32_t x124fe(uint16_t prev_code, uint16_t this_char)
{
	int32_t code;
	int32_t step;
	
	code = (this_char * 64) ^ prev_code;
	code = code % MAX_CODES;
	if (code == 0)
		step = 1;
	else
		step = MAX_CODES - code;
	for (;;)
	{
		/*
		 * beware: cast to (uint16_t) is needed here,
		 * otherwise the compiler will compare a sign-extended value to a zero-extended value
		 */
		if (x163e2[code].prev_code == -256 || ((uint16_t)x163e2[code].prev_code == prev_code && x163e2[code].this_char == this_char))
		{
			return code;
		}
		code -= step;
		if (code < 0)
			code += MAX_CODES;
	}
}

/* ---------------------------------------------------------------------- */

static void swap(unsigned char *p1, unsigned char *p2, size_t size);

static void sort_codes(void *table, size_t nmemb, size_t size, int32_t (*cmp)(struct codeinfo *, struct codeinfo *))
{
	unsigned char *end;
	size_t d5;
	size_t d6;
	unsigned char *a3;
	unsigned char *a4;
	unsigned char *a5;
	
	if (nmemb < 2)
		return;
	end = (unsigned char *)table - size;
	d5 = (nmemb >> 1) * size;
	a4 = end + d5;
	a4 += d5;
	if (nmemb & 1)
		a4 += size;
	while (d5 != size)
	{
		d6 = d5;
		a5 = end + d6;
		while (a4 >= (a3 = &a5[d6]))
		{
			d6 += d6;
			if (a3 != a4 && cmp((struct codeinfo *)(a3 + size), (struct codeinfo *)a3) > 0)
			{
				a3 += size;
				d6 += size;
			}
			if (cmp((struct codeinfo *)a5, (struct codeinfo *)a3) >= 0)
				break;
			swap(a5, a3, size);
			a5 = a3;
		}
		d5 -= size;
	}
	while (a4 != table)
	{
		a5 = table;
		d6 = size;
		while (a4 >= (a3 = &a5[d6]))
		{
			d6 += d6;
			if (a3 != a4 && cmp((struct codeinfo *)(a3 + size), (struct codeinfo *)a3) > 0)
			{
				a3 += size;
				d6 += size;
			}
			if (cmp((struct codeinfo *)a5, (struct codeinfo *)a3) >= 0)
				break;
			swap(a5, a3, size);
			a5 = a3;
		}
		swap(table, a4, size);
		a4 -= size;
	}
}

static void swap(unsigned char *p1, unsigned char *p2, size_t size)
{
	unsigned char tmp;
	
	while (size--)
	{
		tmp = *p1;
		*p1++ = *p2;
		*p2++ = tmp;
	}
}

/* ---------------------------------------------------------------------- */

void write_compression(void)
{
	uint32_t *_screen_table_offset;
	struct x *str_table_ptr;
	uint8_t *a6;
	uint8_t *a4;
	int32_t i;
	size_t screen_size;
	uint8_t *inbuf_end;
	int32_t str_match;
	int32_t _screen_cnt;

	screen_start = 0;
	str_table_ptr = x163e2;
	_screen_table_offset = screen_table_offset;
	hc_createfile(HC_TMP_COMPRESSED);
	/* local long copy */
	_screen_cnt = screen_cnt;
	for (i = 0; i < _screen_cnt; i++)
	{
		screen_size = _screen_table_offset[i + 1] - _screen_table_offset[i];
#if TEST_CODE > 1
		fprintf(stderr, "write_compression: screen %ld: %lu %lu\n", (long)i, (unsigned long)_screen_table_offset[i], (unsigned long)screen_size);
#endif
		/* input buffer may still contain garbage of previous screen */
		hc_inbuf[screen_size] = 0;
		hc_inbuf[screen_size + 1] = 0;
		if (hc_fread(hc_infile, screen_size, hc_inbuf) != screen_size)
		{
			hclog(ERR_READ_ERROR, LVL_FATAL, "temporary file");
		}
		a6 = hc_inbuf;
		inbuf_end = a6 + screen_size;
		while (a6 < inbuf_end)
		{
			uint16_t prev_code;
			int str_code;
			uint16_t this_char;
			int16_t code;
			int16_t step;

			a4 = a6;
			str_code = -1;
#if TEST_CODE > 1
#define toprint(c) ((c) >= 0x20 && (c) < 0x7f ? (c) : '?')
			fprintf(stderr, "char %02x %c", *a4, toprint(*a4));
#endif
			prev_code = -*a4++;
			do
			{
				this_char = *a4++;
				code = (this_char * 64) ^ prev_code;
				code = ((uint16_t)code % (uint16_t)MAX_CODES);
				if (code == 0)
					step = 1;
				else
					step = (uint16_t)MAX_CODES - code;
				for (;;)
				{
#if TEST_CODE > 1
					fprintf(stderr, ", %02x %c %04x %04x %02x", this_char, toprint(this_char), (uint16_t)code, (uint16_t)str_table_ptr[code].prev_code, str_table_ptr[code].this_char);
#endif
					/*
					 * beware: cast to (uint16_t) is needed here,
					 * otherwise the compiler will compare a sign-extended value to a zero-extended value
					 */
					if (str_table_ptr[code].prev_code == -256 ||
						((uint16_t)str_table_ptr[code].prev_code == prev_code && str_table_ptr[code].this_char == this_char))
					{
						break;
					}
					if ((code -= step) < 0)
						code += (uint16_t)MAX_CODES;
				}
				if (str_table_ptr[code].str_code >= 0)
				{
					str_code = str_table_ptr[code].str_code;
					str_match = code;
				}
				prev_code = code;
			} while (str_table_ptr[code].str_code >= -1 && a4 < inbuf_end);
#if TEST_CODE > 1
			fprintf(stderr, " prev_code %04x str_code=%d %lu %lu\n", prev_code, str_code, (unsigned long)(a4 - hc_inbuf), (unsigned long)(a6 - hc_inbuf));
			fprintf(stderr, "nibbles:");
#endif
			if (str_code >= 0)
			{
				a6 += (unsigned short)str_table_ptr[str_match].str_len;
				write_nibble(STR_TABLE);
				write_nibble((unsigned short)str_code >> 8);
				write_nibble((unsigned short)str_code >> 4);
				write_nibble(str_code & 0x0f);
			} else if (a6[0] == CR && a6[1] == NL)
			{
				a6 += 2;
				write_nibble(STR_NEWLINE);
			} else
			{
				int cc;
				unsigned char c = *a6++;
				
				cc = CHAR_DIR;
				for (;;)
				{
					if (--cc < 0)
					{
						/* not found in char_table, direct output */
						write_nibble(CHAR_DIR);
						write_nibble(c >> 4);
						write_nibble(c & 0x0f);
						break;
					}
					if (helphdr.char_table[cc] == c)
					{
						/* write index of common character */
						write_nibble(cc);
						break;
					}
				}
			}
#if TEST_CODE > 1
			putc('\n', stderr);
#endif
		}
		write_nibble(CHAR_EMPTY);
		flush_nibble();
		_screen_table_offset[i] = screen_start;
		screen_start += screenbuf_ptr - screenbuf;
#if TEST_CODE > 1
		fprintf(stderr, "\nwrite_compression: compressed screen %ld: %lu %lu %lu\n\n", (long)i, (unsigned long)_screen_table_offset[i], (unsigned long)(screenbuf_ptr - screenbuf), (unsigned long)(a6 - hc_inbuf));
#endif
		hc_flshbuf();
	}
	_screen_table_offset[i] = screen_start;
	hc_closeout();
#if TEST_CODE
	fprintf(stderr, "write_compression: total size: %lu\n", screen_start);
#endif
}

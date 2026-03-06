#include "hc.h"
#include "country.h"

FILE *hc_infile;
FILE *hc_outfile;
FILE *logfile;
long err_lineno;
int errors_thisfile;
int warnings_thisfile;

const char *err_filename = NULL;



#define LOG_FILENAME "hc.log"

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

unsigned char hc_getc(void)
{
	unsigned char c;
	
	if (hc_inbuf_ptr < hc_inbuf + hc_inbuf_size)
	{
		c = *hc_inbuf_ptr++;
		if (c == '\r') /* FIXME: handle CR/LF */
		{
			input_lineno++;
			if (in_link)
				hclog(ERR_CANT_BREAK, LVL_ERROR);
		}
		return c;
	}
	if (hc_inbuf_size != INBUF_SIZE)
		return CTRL_Z;
	return hc_fillbuf();
}

/* ---------------------------------------------------------------------- */

bool hc_putc(unsigned char b)
{
#if TEST_CODE
	if (in_screen)
	{
		if (b >= 0x20 && b < 0x7f)
			putc(b, stderr);
		else
			fprintf(stderr, "\\x%02x", b);
	}
#endif
	*screenbuf_ptr++ = b;
	if (screenbuf_ptr >= screenbuf + SCREENBUF_SIZE)
	{
		hclog(ERR_SCREEN_TO_LONG, LVL_ERROR);
		if (in_screen)
			hc_skipto(TK_END, SC_PLAINTEXT);
		screenbuf_ptr = screenbuf;
		return FALSE;
	}
	return TRUE;
}

/* ---------------------------------------------------------------------- */

bool hc_putw(short w)
{
	if (hc_putc(w >> 8))
		return hc_putc(w);
	return FALSE;
}

/* ---------------------------------------------------------------------- */

bool hc_puts(const char *s)
{
	size_t len;
	
	len = strlen(s);
	if (screenbuf_ptr + len >= screenbuf + SCREENBUF_SIZE)
	{
		hclog(ERR_SCREEN_TO_LONG, LVL_ERROR);
		if (in_screen)
			hc_skipto(TK_END, SC_PLAINTEXT);
		screenbuf_ptr = screenbuf;
		return FALSE;
	}
	strcpy((char *)screenbuf_ptr, s);
	screenbuf_ptr += len;
	return TRUE;
}

/* ---------------------------------------------------------------------- */

unsigned char hc_fillbuf(void)
{
	unsigned char c;
	
	hc_inbuf_size = hc_fread(hc_infile, INBUF_SIZE, hc_inbuf);
	if (ferror(hc_infile))
	{
		hclog(ERR_READ_ERROR, LVL_FATAL, err_filename);
	}
	if (hc_inbuf_size < INBUF_SIZE)
		hc_inbuf[hc_inbuf_size++] = CTRL_Z;
	hc_inbuf_ptr = hc_inbuf;
	c = *hc_inbuf_ptr++;
	
	if (c == '\r') /* FIXME: handle CR/LF */
	{
		input_lineno++;
		if (in_link)
			hclog(ERR_CANT_BREAK, LVL_ERROR);
	}
	return c;
}

/* ---------------------------------------------------------------------- */

void hc_flshbuf(void)
{
	if (!hc_fwrite(hc_outfile, screenbuf_ptr - screenbuf, screenbuf))
		hclog(ERR_WRITE_ERROR, LVL_FATAL, "output file");
	screenbuf_ptr = screenbuf;
}

/* ---------------------------------------------------------------------- */

size_t hc_fread(FILE *fp, size_t count, void *ptr)
{
	return fread(ptr, 1, count, fp);
}

/* ---------------------------------------------------------------------- */

bool hc_fwrite(FILE *fp, size_t count, void *ptr)
{
	if (fwrite(ptr, 1, count, fp) != count)
		return FALSE;
	return TRUE;
}

/* ---------------------------------------------------------------------- */

void hc_openfile(char *filename)
{
	err_filename = filename;
	if ((hc_infile = fopen(filename, "rb")) == NULL)
		hclog(ERR_OPEN_SOURCE, LVL_FATAL, err_filename);
}

/* ---------------------------------------------------------------------- */

void hc_createfile(const char *filename)
{
	if ((hc_outfile = fopen(filename, "wb")) == NULL)
		hclog(ERR_OPEN_OUTPUT, LVL_FATAL, filename);
}

/* ---------------------------------------------------------------------- */

void log_open(void)
{
	struct tm tm;

	if ((logfile = fopen(LOG_FILENAME, "w")) == NULL)
		hclog(ERR_OPEN_OUTPUT, LVL_FATAL, LOG_FILENAME);
	get_localtime(&tm);
	fprintf(logfile,
		"\n"
		" Help Compiler                                   (c) 1990 Borland Germany GmbH\n"
		"\n"
		"-------------------------------------------------------------------------------\n"
		"\tlog file for %s\n"
		"\tdate:        %d.%s %d\n"
		"-------------------------------------------------------------------------------\n"
		"\n",
		outfile_name,
		tm.tm_mday, get_month_name(COUNTRY_US, tm.tm_mon), tm.tm_year + 1900);
}

/* ---------------------------------------------------------------------- */

void hc_closeout(void)
{
	if (hc_outfile != NULL)
	{
		fclose(hc_outfile);
		hc_outfile = NULL;
	}
}

/* ---------------------------------------------------------------------- */

void log_close(void)
{
	if (logfile != NULL)
	{
		fprintf(logfile,
			"\n"
			"\n"
			"-------------------------------------------------------------------------------\n"
			"\ttotal number of errors:   %ld\n"
			"\ttotal number of warnings: %ld\n"
			"-------------------------------------------------------------------------------\n",
			errors_total, warnings_total);
		fclose(logfile);
		logfile = NULL;
	}
}

/* ---------------------------------------------------------------------- */

void hc_closein(void)
{
	err_filename = NULL;
	if (hc_infile != NULL)
	{
		fclose(hc_infile);
		hc_infile = NULL;
	}
}

/* ---------------------------------------------------------------------- */

void hc_copyfile(char *filename)
{
	hc_openfile(filename);
	while (!feof(hc_infile))
	{
		hc_fwrite(hc_outfile, hc_fread(hc_infile, INBUF_SIZE, hc_inbuf), hc_inbuf);
	}
	hc_closein();
}

#include "hc.h"

long errors_total = 0;
long warnings_total = 0;

const char *const errmsg[] = {
#define HCERR(e, s) s,
#include "hcerr.h"
};
#if WITH_FIXES
#if !defined(__atarist__) && !defined(__TOS__)
#include "cp_atari.h"
#endif
#endif


/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void hclog(int errcode, int level, ...)
{
	va_list args;
	char buf[256];
	
	va_start(args, level);
	if (level == LVL_FATAL)
	{
		logstr("Fatal: ");
	} else
	{
		if (level == LVL_ERROR)
		{
			logstr("Error ");
			errors_thisfile++;
			errors_total++;
		} else
		{
			logstr("Warning ");
			warnings_thisfile++;
			warnings_total++;
		}
		if (err_filename != NULL)
		{
			sprintf(buf, "%s ", err_filename);
			logstr(buf);
			sprintf(buf, "%ld: ", err_lineno);
			logstr(buf);
		}
	}
	vsprintf(buf, errmsg[errcode], args);
	logstr(buf);
	logstr("\n");
	if (level == LVL_FATAL)
	{
		logstr("\tprogram aborted!\n\n");
		cleanup();
	}
}

/* ---------------------------------------------------------------------- */

void cleanup(void)
{
	log_close();
	hc_closein();
	hc_closeout();
	unlink(HC_TMP_ENCODED);
	unlink(HC_TMP_COMPRESSED);
	unlink(HC_TMP_STRINGS);
#if WITH_FIXES
	exit(EXIT_FAILURE);
#else
	exit(-1);
#endif
}

/* ---------------------------------------------------------------------- */

void logstr(const char *str)
{
#if WITH_FIXES
	if (logfile != NULL)
		fputs(str, logfile);
#if !defined(__atarist__) && !defined(__TOS__)
	{
		unsigned short cc;

		/*
		 * assumes that all but atari uses a utf-8 console.
		 * Do not write atari non-ascii-characters to it
		 * (but it is still written unmodified to the logfile above)
		 */
		while (*str != '\0')
		{
			cc = atari_to_unicode[(unsigned char)*str];
			if (cc >= 0x800)
			{
				fputc(((cc >> 12) & 0x0f) | 0xe0, stdout);
				fputc(((cc >> 6) & 0x3f) | 0x80, stdout);
				fputc(((cc) & 0x3f) | 0x80, stdout);
			} else if (cc >= 0x80)
			{
				fputc(((cc >> 6) & 0x3f) | 0xc0, stdout);
				fputc(((cc) & 0x3f) | 0x80, stdout);
			} else
			{
				fputc(cc, stdout);
			}
			str++;
		}
	}
#else
	fputs(str, stdout);
#endif

#else
	if (logfile != NULL)
		fprintf(logfile, str); /* BUG: str may contain '%' */
	fprintf(stdout, str);
#endif
}

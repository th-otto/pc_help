#include "hc.h"
#include "country.h"
#if defined(__atarist__) || defined(__TOS__)
#if defined(ORIG_PUREC)
#define OSHEADER SYSHDR
#define os_beg os_start
#define os_conf os_palmode
#else
#include <mint/sysvars.h>
#endif
#endif


size_t hc_inbuf_size = INBUF_SIZE;
int file_index = FILEINDEX_USR;
static int generate_help = 1;
struct options options = { FALSE, FALSE, 0, FALSE, 4, COUNTRY_DE };

unsigned char *hc_inbuf;
unsigned char *screenbuf;
unsigned char *hc_inbuf_ptr;
unsigned char *screenbuf_ptr;
char outfile_name[64];
static char *helpfiles[MAX_HELP_FILES + 2];

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

char *xbasename(const char *path)
{
	char *name1;
	char *name2;
	
	name1 = strrchr(path, '\\');
	name2 = strrchr(path, '/');
	if (name1 == NULL || name2 > name1)
		name1 = name2;
	if (name1 == NULL)
		return (char *)path;
	++name1;
	return name1;
}

/* ---------------------------------------------------------------------- */

static void alloc_buffers(void)
{
	unsigned char *p;
	
	init_keyword_hash();
	clear_index();
	if ((hc_inbuf = g_new(unsigned char, INBUF_SIZE + SCREENBUF_SIZE)) == NULL)
		hclog(ERR_NOMEM, LVL_FATAL);
	p = hc_inbuf + INBUF_SIZE;
	screenbuf = p;
	screenbuf_ptr = p;
	hc_inbuf_ptr = p;
	if (hc_inbuf_ptr)
	{
	}
	if ((screen_table_offset = g_new(uint32_t, MAX_SCREENS)) == NULL)
		hclog(ERR_NOMEM, LVL_FATAL);
	if ((caps_table = g_new(INTERNAL_SRCHKEY_ENTRY, MAX_SCREENS)) == NULL)
		hclog(ERR_NOMEM, LVL_FATAL);
	if ((sens_table = g_new(INTERNAL_SRCHKEY_ENTRY, MAX_SCREENS)) == NULL)
		hclog(ERR_NOMEM, LVL_FATAL);
	caps_cnt = sens_cnt = 0;
}

/* ---------------------------------------------------------------------- */

static void reset_file(void)
{
	unsigned char *p;
	
	if (errors_thisfile != 0)
		generate_help = 0;
	err_lineno = input_lineno = 1;
	errors_thisfile = warnings_thisfile = 0;
	hc_inbuf_size = INBUF_SIZE;
	p = screenbuf;
	screenbuf_ptr = p;
	hc_inbuf_ptr = p;
}

/* ---------------------------------------------------------------------- */

static void check_errors(void)
{
	char buf[256];
	
	logstr("\n\t");
	if (errors_thisfile != 0)
	{
		sprintf(buf, "%d Error(s)\t", errors_thisfile);
		logstr(buf);
	}
	if (warnings_thisfile != 0)
	{
		sprintf(buf, "%d Warning(s)", warnings_thisfile);
		logstr(buf);
	}
	logstr("\n");
	if (errors_thisfile != 0)
		cleanup();
	if (options.break_make && warnings_thisfile != 0)
		cleanup();
	reset_file();
}

/* ---------------------------------------------------------------------- */

static void pass1(int nfiles, char **names)
{
	int i;
	char buf[256];
	
	hc_createfile(HC_TMP_ENCODED);
	generate_copyright_page();
	generate_index_page();
	for (i = 0; nfiles > i; i++)
	{
		reset_file();
		hc_openfile(names[i]);
		if (options.verbose)
		{
			sprintf(buf, "\tscanning %s\n\n", err_filename);
			logstr(buf);
		}
		parse_file();
		hc_closein();
		check_errors();
	}
	if (generate_help)
	{
		if (options.verbose)
		{
			fprintf(stdout, "\n\tcreating index\n");
		}
		generate_index();
	}
	screen_table_offset[screen_cnt] = screen_start;
	hc_closeout();
}

/* ---------------------------------------------------------------------- */

static void compile_files(int nfiles, char **names)
{
	char buf[256];
	
	fprintf(stdout, "\tpass 1:\n");
	pass1(nfiles, names);
	if (generate_help)
	{
		fprintf(stdout, "\n\tpass 2:\n");
		if (options.verbose)
			logstr("\tdoing references\n\n");
		do_references(HC_TMP_ENCODED);
		check_errors();
	}
	/* not needed any longer */
	free_index();
	if (generate_help > 0)
	{
		fprintf(stdout, "\n\tpass 3:\n");
		if (options.verbose)
			logstr("\tcompressing\n");
		do_compress();
		check_errors();
	} else
	{
		unlink(HC_TMP_ENCODED);
	}
	if (generate_help > 0)
	{
		fprintf(stdout, "\n\tpass 4:\n");
		if (options.verbose)
		{
			sprintf(buf, "\tcreating %s\n", outfile_name);
			logstr(buf);
		}
		write_help();
		check_errors();
	}
}

/* ---------------------------------------------------------------------- */

static void compile_help(char *helpfilename, int nfiles, char **names)
{
	strcpy(outfile_name, helpfilename);
	alloc_buffers();
	if (options.create_log)
		log_open();
	compile_files(nfiles, names);
	hc_closeout();
	log_close();
	unlink(HC_TMP_COMPRESSED);
	unlink(HC_TMP_STRINGS);
	while (--nfiles >= 0)
		g_free(names[nfiles]);
	g_free(helpfilename);
	g_free(screen_table_offset);
	screen_table_offset = NULL;
	g_free(hc_inbuf);
	hc_inbuf = NULL;
	free_keyword_hash();
}

/* ---------------------------------------------------------------------- */

static void usage(void)
{
	fprintf(stdout,
		"usage: HC commandfile\n"
		"\n"
		"commandfile format:\n"
		"\n"
		"\t-[options]\n"
		"\t(path and) filename of help file\n"
		"\tlist of (paths and) filenames of the sources\n"
		"\n"
		"\toptions:\n"
		"\tL\t\tcreate log file\n"
		"\tN\t\tdo not generate help file\n"
		"\tV\t\tverbose message output\n"
		"\tW\t\tbreak make on warnings\n"
		"\tT=x\texpand tabs to x blanks (0 < x <= 9, default: %d)\n"
		"\tG=x\tgenerate index page(s) for lang <x> (default: %d)\n"
		"\n"
		"\n"
		"note: use one line for the entire options and\n"
		"      separate lines for each filename,\n"
		"      comments start with a semicolon and\n"
		"      end at the end of line\n",
		options.tabsize, options.country);
}

/* ---------------------------------------------------------------------- */

static void print_banner(void)
{
	fprintf(stdout,
		"\n"
		" Help Compiler                    (c) 1990 Borland Germany GmbH\n"
		"\n");
}

/* ---------------------------------------------------------------------- */

#if defined(__atarist__) || defined(__TOS__)
static long get_default_country(void)
{
	OSHEADER *syshdr;
	unsigned char conf;
	
	syshdr = *((OSHEADER **)0x4f2);
	syshdr = syshdr->os_beg;
	conf = (syshdr->os_conf >> 1) & 0x7f;
	if (conf == 0x7f)
	{
		/* multi-language */
		/* try to get setting from NVRAM, ignoring errors if not available */
		conf = options.country;
		(void) NVMaccess(0, 5, 1, &conf);
	}
	options.country = conf;
	return 0;
}
#endif

/* ---------------------------------------------------------------------- */

static int read_commandfile(int argc, char **argv)
{
	int nfiles;
	bool gotoptions;
	size_t pathlen;
	char *end;
	char *start;
	char line[256];
	char path[128];
	FILE *fp;
	
	nfiles = -1;
	gotoptions = FALSE;
	if (argc <= 1)
		return 0;
	end = xbasename(argv[1]);
	pathlen = end - argv[1];
	strncpy(path, argv[1], pathlen);
	path[pathlen] = '\0';
	if ((fp = fopen(argv[1], "r")) == NULL)
	{
		hclog(ERR_OPEN_PROJECT, LVL_FATAL, argv[1]);
	}
	while (fgets(line, (int)sizeof(line), fp) != NULL)
	{
		size_t len = strlen(line);
		
		if (len > 0 && line[len - 1] == '\n')
			line[--len] = '\0';
		if (len > 0 && line[len - 1] == '\r')
			line[--len] = '\0';
		start = line;
		while (*start == ' ' || *start == '\t')
			start++;
		if (*start == ';' || *start == '\0')
			continue;
		end = start;
		while (*end != ' ' && *end != '\t' && *end != ';' && *end != '\0')
			end++;
		*end = '\0';
		if (gotoptions == FALSE)
		{
			end = start + 1;
			while (*end != '\0')
			{
				switch (toupper((unsigned char)*end))
				{
				case '0':
				case '1':
				case '2':
				case '3':
				case '4':
				case '5':
				case '6':
				case '7':
					file_index = (unsigned char)*end - '0';
					break;
				case '8':
				case '9':
					hclog(ERR_FILE_INDEX, LVL_ERROR, (unsigned char)*end);
					break;
				case 'L':
					options.create_log = TRUE;
					break;
				case 'T':
					++end;
					if (*end == '=')
					{
						++end;
						options.tabsize = (unsigned char)*end - '0';
					} else
					{
						hclog(ERR_EXPECTED, LVL_ERROR, (unsigned char)end[-1]);
					}
					break;
				case 'G':
					++end;
					if (*end == '=')
					{
						char *iend;
						
						++end;
						options.country = (int)strtol(end, &iend, 10);
						end = iend;
						continue;
					} else
					{
						hclog(ERR_EXPECTED, LVL_ERROR, (unsigned char)end[-1]);
					}
					break;
				case 'V':
					options.verbose = TRUE;
					break;
				case 'N':
					generate_help = -1;
					break;
				case 'W':
					options.break_make = TRUE;
					break;
				case '-':
					break;
				default:
					hclog(ERR_OPTION, LVL_ERROR, (unsigned char)*end);
					break;
				}
				end++;
			}
			gotoptions = TRUE;
		} else
		{
			if (nfiles <= MAX_HELP_FILES)
			{
				size_t len = strlen(start);
				
				if (start[1] != ':' && start[0] != '\\' && start[0] != '/')
					len += pathlen;
				if ((end = (char *)malloc(len + 1)) == NULL)
					hclog(ERR_NOMEM, LVL_FATAL);
				if (start[1] != ':' && start[0] != '\\' && start[0] != '/')
				{
					strcpy(end, path);
					strcat(end, start);
				} else
				{
					strcpy(end, start);
				}
				nfiles++;
				helpfiles[nfiles] = end;
			} else
			{
				hclog(ERR_TOO_MANY_FILES, LVL_FATAL, argv[1]);
			}
		}
	}
	fclose(fp);
	if (errors_thisfile != 0)
	{
		exit(EXIT_FAILURE);
	}

	return nfiles;
}

/* ---------------------------------------------------------------------- */

int main(int argc, char **argv)
{
	int n;
	
	print_banner();
#if defined(__atarist__) || defined(__TOS__)
	Supexec(get_default_country);
#endif
	if ((n = read_commandfile(argc, argv)) == 0)
	{
		usage();
	} else
	{
		compile_help(helpfiles[0], n, &helpfiles[1]);
	}
	if (options.verbose)
	{
		fprintf(stdout, "\nready.\n");
	}
	return EXIT_SUCCESS;
}

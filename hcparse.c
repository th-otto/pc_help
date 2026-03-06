#include "hc.h"

int brace_level = 0;

#if defined(__TOS__) || defined(__atarist__)
#define RIGHT_S "\257"
#else
#define RIGHT_S "\302\273"
#endif
#define msg_continue " do you want to continue, [y]es or [n]o ? "

static bool next_parameter(bool one_only);
static bool parse_parameters(bool one_only);

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void parse_file(void)
{
	char buf[256];
	int attr = CAP_SENS;
	bool in_parameter;
	bool save_in_screen;
	
	for (;;)
	{
		switch (hc_gettok())
		{
		case TK_EOF:
			if (in_screen)
				hclog(ERR_MISSING_END, LVL_ERROR);
			return;
		case TK_SCREEN:
			screen_cnt++;
			in_parameter = TRUE;
			if (parse_parameters(TRUE))
			{
				for (;;)
				{
					switch (hc_curtok)
					{
					case TK_SENSITIVE:
						attr = SENSITIVE;
						/* fall through */
					case TK_CAPSENSITIVE:
						if (parse_parameters(FALSE))
						{
							if (hc_curtok == TK_STRING)
							{
								if (attr == SENSITIVE)
									atari_strupr(cur_identifier);
								add_index_entry(cur_identifier, screen_cnt, attr);
							} else
							{
								hclog(ERR_WRONG_ARGUMENT, LVL_ERROR);
								in_parameter = FALSE;
							}
							if (next_parameter(FALSE))
								in_parameter = FALSE;
						}
						attr = CAP_SENS;
						break;
					case TK_STRING:
						add_index_entry(cur_identifier, screen_cnt, SCR_NAME);
						break;
					default:
						hclog(ERR_WRONG_ARGUMENT, LVL_ERROR);
						in_parameter = FALSE;
						break;
					}
					if (in_parameter)
					{
						if (next_parameter(TRUE))
							continue;
					}
					break;
				}
			} else
			{
				in_parameter = FALSE;
			}
			if (in_parameter)
			{
				in_screen = TRUE;
				skip_space();
#if TEST_CODE
				fprintf(stderr, "start screen %d: ", screen_cnt - 1);
#endif
			} else
			{
				hc_skipto(TK_SCREEN, SC_M2);
			}
			break;
		
		case TK_END:
			in_screen = FALSE;
			screen_table_offset[screen_cnt - 1] = screen_start;
#if TEST_CODE
			fprintf(stderr, "\nend screen %d: %lu\n", screen_cnt - 1, (unsigned long)(screenbuf_ptr - screenbuf));
#endif
			screen_start += screenbuf_ptr - screenbuf;
			hc_flshbuf();
			break;
		
		case TK_PRINT:
			save_in_screen = in_screen;
			in_screen = FALSE;
			if (parse_parameters(TRUE))
			{
				for (;;)
				{
					if (hc_curtok == TK_STRING)
					{
						fprintf(stdout, RIGHT_S RIGHT_S RIGHT_S RIGHT_S RIGHT_S RIGHT_S RIGHT_S " %s\n", cur_identifier);
					} else
					{
						hclog(ERR_WRONG_ARGUMENT, LVL_ERROR);
					}
					if (!next_parameter(TRUE))
						break;
				}
			}
			in_screen = save_in_screen;
			break;
		
		case TK_WAIT:
			{
				char c;
				
				fprintf(stderr, RIGHT_S RIGHT_S RIGHT_S RIGHT_S RIGHT_S RIGHT_S RIGHT_S msg_continue);
				c = fgetc(stdin);
				if (c == 'n' || c == 'N')
					exit(EXIT_SUCCESS);
			}
			break;
		
		case TK_HASH:
			if (in_screen)
				parse_link(NULL);
			else
				hclog(ERR_WRONG_SCOPE, LVL_ERROR);
			break;
		
		case TK_LINK:
			save_in_screen = in_screen;
			in_screen = FALSE;
			if (save_in_screen && parse_parameters(FALSE))
			{
				if (hc_curtok == TK_STRING)
				{
					strcpy(buf, cur_identifier);
					next_parameter(FALSE);
					in_screen = save_in_screen;
					parse_link(buf);
				} else
				{
					hclog(ERR_WRONG_ARGUMENT, LVL_ERROR);
					hc_skipto(TK_HASH, SC_M2);
				}
			} else
			{
				hclog(ERR_WRONG_SCOPE, LVL_ERROR);
				in_screen = save_in_screen;
			}
			break;

		case TK_EOFCMD:
			if (in_screen)
				hc_putc(CTRL_Z);
			else
				hclog(ERR_WRONG_SCOPE, LVL_ERROR);
			break;
		
		case TK_EXTERN:
		case TK_NOP:
			break;
		
		default:
			hclog(ERR_UNKNOWN_STATEMENT, LVL_ERROR);
			break;
		}
	}
}

/* ---------------------------------------------------------------------- */

static bool next_parameter(bool one_only)
{
	bool d3 = FALSE;
	
	for (;;)
	{
		hc_gettok();
		switch (hc_curtok)
		{
		case TK_LPAREN:
			hclog(ERR_PARENTHESIS, LVL_ERROR);
			return TRUE;
		case TK_RPAREN:
			return FALSE;
		case TK_COMMA:
			if (!one_only)
				hclog(ERR_TOO_MANY_PARAMETERS, LVL_ERROR);
			if (d3)
				hclog(ERR_MISSING_PARAMETER, LVL_WARNING);
			d3 = TRUE;
			break;
		default:
			return TRUE;
		}
	}
}

/* ---------------------------------------------------------------------- */

static bool parse_parameters(bool one_only)
{
	hc_gettok();
	if (hc_curtok != TK_LPAREN)
	{
		hclog(ERR_MISSING_PARAMETER_LIST, LVL_ERROR);
		hc_skipto(TK_RPAREN, SC_KEYWORD);
		return FALSE;
	} else
	{
		if (!next_parameter(one_only))
		{
			hclog(ERR_MISSING_PARAMETER_LIST, LVL_ERROR);
			return FALSE;
		}
	}
	return TRUE;
}

/* ---------------------------------------------------------------------- */

void hc_skipto(enum token token, enum scope scope)
{
	while (hc_curtok != TK_EOF && hc_curtok != token && hc_curscope != scope)
		hc_gettok();
	hc_backtok();
}

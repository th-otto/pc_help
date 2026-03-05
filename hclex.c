#include "hc.h"

char cur_identifier[1024];
enum token hc_curtok;
enum scope hc_curscope;
long input_lineno;

#define CC_ILLEGAL    0
#define CC_CR         2
#define CC_WHITESPACE 3
#define CC_CTRL_Z     4
#define CC_QUOTE      5
#define CC_HASH       6
#define CC_STAR       7
#define CC_PLUS       8
#define CC_COMMA      9
#define CC_MINUS      10
#define CC_SLASH      11
#define CC_DIGIT      12
#define CC_ALPHA      13
#define CC_SEMI       14
#define CC_EQUAL      15
#define CC_LBRACE     16
#define CC_RBRACE     17
#define CC_BACKSLASH  18
#define CC_LPAREN     19
#define CC_RPAREN     20

unsigned char const character_class[256] = {
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_WHITESPACE, CC_WHITESPACE, CC_ILLEGAL,  CC_ILLEGAL,   CC_CR,      CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_CTRL_Z,     CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_WHITESPACE, CC_ILLEGAL,    CC_QUOTE,      CC_HASH,     CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_LPAREN,     CC_RPAREN,     CC_STAR,       CC_PLUS,     CC_COMMA,     CC_MINUS,   CC_ILLEGAL, CC_SLASH,
	CC_DIGIT,      CC_DIGIT,      CC_DIGIT,      CC_DIGIT,    CC_DIGIT,     CC_DIGIT,   CC_DIGIT,   CC_DIGIT,
	CC_DIGIT,      CC_DIGIT,      CC_ILLEGAL,    CC_SEMI,     CC_ILLEGAL,   CC_EQUAL,   CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ALPHA,      CC_ALPHA,      CC_ALPHA,    CC_ALPHA,     CC_ALPHA,   CC_ALPHA,   CC_ALPHA,
	CC_ALPHA,      CC_ALPHA,      CC_ALPHA,      CC_ALPHA,    CC_ALPHA,     CC_ALPHA,   CC_ALPHA,   CC_ALPHA,
	CC_ALPHA,      CC_ALPHA,      CC_ALPHA,      CC_ALPHA,    CC_ALPHA,     CC_ALPHA,   CC_ALPHA,   CC_ALPHA,
	CC_ALPHA,      CC_ALPHA,      CC_ALPHA,      CC_ILLEGAL,  CC_BACKSLASH, CC_ILLEGAL, CC_ILLEGAL, CC_ALPHA,
	CC_ILLEGAL,    CC_ALPHA,      CC_ALPHA,      CC_ALPHA,    CC_ALPHA,     CC_ALPHA,   CC_ALPHA,   CC_ALPHA,
	CC_ALPHA,      CC_ALPHA,      CC_ALPHA,      CC_ALPHA,    CC_ALPHA,     CC_ALPHA,   CC_ALPHA,   CC_ALPHA,
	CC_ALPHA,      CC_ALPHA,      CC_ALPHA,      CC_ALPHA,    CC_ALPHA,     CC_ALPHA,   CC_ALPHA,   CC_ALPHA,
	CC_ALPHA,      CC_ALPHA,      CC_ALPHA,      CC_LBRACE,   CC_ILLEGAL,   CC_RBRACE,  CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL,
	CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,    CC_ILLEGAL,  CC_ILLEGAL,   CC_ILLEGAL, CC_ILLEGAL, CC_ILLEGAL
};

struct keyword const keywords[] = {
	{ TK_SCREEN, "screen" },
	{ TK_END, "end"  },
	{ TK_PRINT, "print" },
	{ TK_LINK, "link" },
	{ TK_WAIT, "wait" },
	{ TK_CAPSENSITIVE, "capsensitive" },
	{ TK_SENSITIVE, "sensitive" },
	{ TK_EXTERN, "extern" },
	{ TK_EOFCMD, "EOF" },
	{ TK_NOP, "nop" },
	{ 0, NULL },
};

bool in_screen = FALSE;
static bool backtok = FALSE;
bool in_link = FALSE;

static void parse_braces(void);

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

enum token hc_gettok(void)
{
	unsigned char c;
	int i;
	unsigned char sc;

	err_lineno = input_lineno;
	if (backtok)
	{
		backtok = FALSE;
		return hc_curtok;
	} else
	{
		for (;;)
		{
			c = hc_getc();
			if (in_screen && c != CTRL_Z)
			{
				for (;;)
				{
					switch (c)
					{
					case ESC_CHR:
						hclog(ERR_ILLEGAL_CHARACTER, LVL_ERROR, c);
						c = hc_getc();
						continue;
					case '\\':
						c = hc_getc();
						if (c == '\\')
						{
							hc_putc('\\');
							c = hc_getc();
							continue;
						}
						break;
					case '\t':
						if (options.tabsize != 0)
						{
							/* BUG: must take current column into account */
							for (i = 0; i < options.tabsize; i++)
								hc_putc(' ');
						} else
						{
							hc_putc('\t');
						}
						c = hc_getc();
						continue;
					default:
						hc_putc(c);
						c = hc_getc();
						continue;
					}
					break;
				}
			}
			sc = character_class[c];
			hc_curscope = SC_NONE;
			switch (sc)
			{
			case CC_ALPHA: /* 'a'..'z', 'A'..'Z' */
				parse_identifier(c);
				parse_keyword();
				return hc_curtok;
			case CC_LBRACE: /* '{' */
				parse_braces();
				break;
			case CC_CTRL_Z: /* CTRL_Z */
				return hc_curtok = TK_EOF;
			case CC_LPAREN: /* '(' */
				return hc_curtok = TK_LPAREN;
			case CC_RPAREN: /* ')' */
				return hc_curtok = TK_RPAREN;
			case CC_QUOTE: /* '"' */
				parse_string();
				return TK_STRING;
			case CC_COMMA: /* ',' */
				return hc_curtok = TK_COMMA;
			case CC_HASH: /* '#' */
				hc_curscope = SC_KEYWORD;
				return hc_curtok = TK_HASH;

			case CC_ILLEGAL: /* control, illegal */
				break;
			case CC_CR: /* '\r' */
				break;
			case CC_WHITESPACE: /* '\t', '\n', ' ' */
				break;
			case CC_STAR: /* '*' */
				break;
			case CC_PLUS: /* '+' */
				break;
			case CC_MINUS: /* '-' */
				break;
			case CC_SLASH: /* '/' */
				break;
			case CC_DIGIT: /* '0'..'9' */
				break;
			case CC_SEMI: /* ';' */
				break;
			case CC_EQUAL: /* '=' */
				break;
			case CC_RBRACE: /* '}' */
				break;
			case CC_BACKSLASH: /* '\\' */
				break;
			}
		}
	}
}

/* ---------------------------------------------------------------------- */

void hc_backtok(void)
{
	backtok = TRUE;
}

/* ---------------------------------------------------------------------- */

void hc_back(void)
{
	--hc_inbuf_ptr;
	if (*hc_inbuf_ptr == '\r') /* FIXME: handle CR/LF */
		--input_lineno;
}

/* ---------------------------------------------------------------------- */

void parse_identifier(unsigned char c)
{
	char *cp;
	
	cp = cur_identifier;
	do
	{
		/* FIXME: handle buffer overflow */
		*cp++ = c;
		c = hc_getc();
	} while (character_class[c] == CC_ALPHA || character_class[c] == CC_DIGIT);
	*cp = '\0';
	hc_back();
}

/* ---------------------------------------------------------------------- */

void parse_string(void)
{
	char *cp;
	unsigned char c;
	
	cp = cur_identifier;
	do
	{
		c = hc_getc();
		if (c == '\\')
		{
			/* FIXME: handle buffer overflow */
			*cp++ = hc_getc();
			c = hc_getc();
		}
		/* FIXME: handle buffer overflow */
		*cp++ = c;
	} while (character_class[c] != CC_QUOTE && character_class[c] != CC_CR);
	if (character_class[c] == CC_CR) /* '\r' */ /* FIXME: handle CR/LF */
		hclog(ERR_PENDING_STRING, LVL_ERROR);
	*--cp = '\0';
	hc_curtok = TK_STRING;
	hc_curscope = SC_STRING;
}

/* ---------------------------------------------------------------------- */

void parse_keyword(void)
{
	int val;
	struct hashitem *h;
	
	val = calchash(cur_identifier, KEYW_HASH_SIZE);
	h = keyword_hash[val];
	while (h != NULL)
	{
		if (strcmp(cur_identifier, h->name) == 0)
			break;
		h = h->next;
	}
	if (h != NULL)
	{
		hc_curscope = SC_KEYWORD;
		hc_curtok = h->type;
	} else
	{
		hc_curtok = TK_NONE;
		hc_curscope = SC_PLAINTEXT;
	}
}

/* ---------------------------------------------------------------------- */

void parse_link(char *s)
{
	unsigned char *ptr;
	int16_t scr_code;
	
	in_link = TRUE;
	hc_putc(ESC_CHR);
	/*
	 * remember where link code goes
	 */
	ptr = screenbuf_ptr;
	hc_putw(-1);
	if (s == NULL)
		s = (char *)screenbuf_ptr;
	hc_gettok();
	if (hc_curtok != TK_HASH)
	{
		hclog(ERR_PENDING_KEYWORD, LVL_ERROR);
		hc_backtok();
	}
	*screenbuf_ptr = 0;
	if ((scr_code = get_index_screen_code(s)) == 0)
	{
		add_name(s, err_filename, input_lineno, ptr - screenbuf + screen_start);
	} else
	{
		/*
		 * write link code
		 */
		*ptr++ = scr_code >> 8;
		*ptr = scr_code;
	}
	hc_putc(ESC_CHR);
	in_link = FALSE;
}

/* ---------------------------------------------------------------------- */

static void parse_braces(void)
{
	unsigned char c;
	
	++brace_level;
	do
	{
		c = hc_getc();
		if (in_screen)
		{
			if (c != '\\')
				continue;
			c = hc_getc();
		} else if (c == '\\')
		{
			hc_getc();
			continue;
		}
		switch (c)
		{
		case '}':
			brace_level--;
			break;
		case '{':
			if (options.allow_braces)
				brace_level++;
			break;
		}
	} while (brace_level != 0);
}


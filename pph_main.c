#include "pc_help.h"
#include "helpmsg.h"
#include <stdint_.h>
#include "hcint.h"
#include "pphlprsc.h"
#include "alerts.h"

_WORD phys_handle;
_WORD vdi_handle;
_WORD vdi_planes;
_WORD screen_width;
_WORD screen_height;
_WORD gl_wchar;
_WORD gl_hchar;
_WORD ap_id;


static const char *const help_table[] = {
	ESC_CHR_S "\377\377PASCAL",
	ESC_CHR_S "\377\377UNITS",
	ESC_CHR_S "\377\377Options",
	ESC_CHR_S "\377\377Assembler",
	ESC_CHR_S "\0\0Index",
};

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static void read_inf(void)
{
	int fd;
	char pc_dir[128];
	long size;
	const char *env;
	
	*pc_dir = '\0';
	fd = (int)Fopen("pp_help.inf", 0);
	if (fd >= 0)
	{
		size = Fread(fd, sizeof(pc_dir), pc_dir);
		do
		{
			pc_dir[size--] = '\0';
		} while (size >= 0 && isspace(pc_dir[size]));
		Fclose((int)fd);
	} else
	{
		env = getenv("PP");
		if (env != NULL)
		{
			strcpy(pc_dir, env);
		}
	}
	help_init(pc_dir);
}

/* ---------------------------------------------------------------------- */

static void drain_keys(void)
{
	_WORD msg[8];
	_WORD events;
	
	do
	{
		events = evnt_multi(MU_KEYBD | MU_TIMER,
			2, 1, 1,
			0, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			msg,
			EVNT_TIME(0),
			msg, msg, msg, msg, msg, msg);
	} while (events & MU_KEYBD);
}

/* ---------------------------------------------------------------------- */

static bool handle_key(int key)
{
	return edit_key(key);
}

/* ---------------------------------------------------------------------- */

static void handle_button(_WORD mox, _WORD moy, _WORD clicks)
{
	win_select_region(mox, moy, clicks);
}

/* ---------------------------------------------------------------------- */

static bool pp_help_show(int mode)
{
	return help_show(help_table[mode]);
}

/* ---------------------------------------------------------------------- */

static bool ac_open(void)
{
	char buf[80];
	_WORD button;

	for (;;)
	{
		button = do_dialog(MAIN_DIALOG, DLG_KEYWORD);
		switch (button)
		{
		case DLG_LANGUAGE:
			if (pp_help_show(HELP_MODE_LANGUAGE) == FALSE) /* 'Pascal Language' */
				return FALSE;
			break;
		case DLG_LIBRARIES:
			if (pp_help_show(HELP_MODE_LIBRARIES) == FALSE) /* 'Units' */
				return FALSE;
			break;
		case DLG_OPTIONS:
			if (pp_help_show(HELP_MODE_OPTIONS) == FALSE) /* 'Options' */
				return FALSE;
			break;
		case DLG_ASSEMBLER:
			if (pp_help_show(HELP_MODE_ASSEMBLER) == FALSE) /* 'Assembler' */
				return FALSE;
			break;
		case DLG_INDEX:
			if (pp_help_show(HELP_MODE_INDEX) == FALSE) /* 'Index' */
				return FALSE;
			break;
		case DLG_OK:
			get_ptext(MAIN_DIALOG, DLG_KEYWORD, buf);
			if (buf[0] == '\0')
				return TRUE;
			if (help_show_topic(buf) == FALSE)
				return FALSE;
			break;
		case DLG_CANCEL:
			return TRUE;
		}
	}
}

/* ---------------------------------------------------------------------- */

static void send_reply(_WORD sender)
{
	_WORD msg[8];
	
	msg[0] = AC_REPLY;
	msg[1] = ap_id;
	msg[2] = 0;
	msg[3] = win_get_handle();
	msg[4] = 0;
	msg[5] = 0;
	msg[6] = 0;
	msg[7] = 0;
	appl_write(sender, (int)sizeof(msg), msg);
}

/* ---------------------------------------------------------------------- */

static bool handle_message(_WORD *msg)
{
	_WORD wh;
	bool quit;
	
	wh = msg[3];
	quit = FALSE;
	switch (msg[0])
	{
	case WM_REDRAW:
		redraw_wind(wh);
		break;
	case WM_TOPPED:
		wind_set(wh, WF_TOP, 0, 0, 0, 0);
		break;
	case WM_CLOSED:
		help_exit();
		edit_closewind(TRUE);
		quit = TRUE;
		break;
	case WM_FULLED:
		full_wind();
		break;
	case WM_ARROWED:
		arrow_wind(msg[4]);
		break;
	case WM_HSLID:
		edit_set_slider(TRUE, msg[4], 1000);
		break;
	case WM_VSLID:
		edit_set_slider(FALSE, msg[4], 1000);
		break;
	case WM_SIZED:
	case WM_MOVED:
		move_wind((GRECT *)&msg[4]);
		break;
	case AC_OPEN:
		help_exit();
		ac_open();
		break;
	case AC_CLOSE:
		help_exit();
		edit_closewind(FALSE);
		quit = TRUE;
		break;

	case AC_COPY:
		edit_copy();
		send_reply(msg[1]);
		break;
	
	case AC_HELP:
		help_exit();
		help_show_topic(*((char **)&msg[3]));
		send_reply(msg[1]);
		break;
	
	case AC_VERSION:
		send_reply(msg[1]);
		break;
	}
	return quit;
}

/* ---------------------------------------------------------------------- */

static void eventloop(bool isapp, const char *keyword)
{
	_WORD mox;
	_WORD moy;
	_WORD kstate;
	_WORD key;
	_WORD clicks;
	_WORD button;
	_WORD top;
	_WORD dummy;
	_WORD msg[8];
	bool quit;
	_WORD events;
	
	quit = FALSE;
	if (isapp)
	{
		if (keyword == NULL)
			quit = ac_open();
		else
			help_show_topic(keyword);
	}
	while (!quit || !isapp)
	{
		events = evnt_multi(MU_MESAG | MU_TIMER | MU_KEYBD | MU_BUTTON,
			2, 1, 1,
			0, 0, 0, 0, 0,
			0, 0, 0, 0, 0,
			msg,
			EVNT_TIME(500),
			&mox, &moy, &button, &kstate, &key, &clicks);
		wind_get(0, WF_TOP, &top, &dummy, &dummy, &dummy);
		win_is_top(top);
		if (events & MU_KEYBD)
		{
			quit = handle_key(key);
			drain_keys();
		}
		if (events & MU_BUTTON)
		{
			handle_button(mox, moy, clicks);
		}
		if (events & MU_MESAG)
			quit = handle_message(msg);
		if (events & MU_TIMER)
			win_timer();
		if (quit)
		{
			help_exit();
			edit_closewind(TRUE);
		}
	}
}

/* ---------------------------------------------------------------------- */

#include "pphlprsc.h"
#include "pphlprsc.rsh"

void rsrc_fix(void)
{
	_WORD obj;
	
	for (obj = 0; obj < NUM_OBS; obj++)
		rsrc_obfix(rs_object, obj);
}

/* ---------------------------------------------------------------------- */

OBJECT *obj_addr(_WORD tree, _WORD obj)
{
	return rs_trindex[tree] + obj;
}

/* ---------------------------------------------------------------------- */

int main(int argc, char **argv)
{
	_WORD workin[11];
	_WORD workout[57];
	int i;
	_WORD dummy;
	
	read_inf();
	
	if ((ap_id = appl_init()) >= 0)
	{
		if (!_app)
			menu_register(ap_id, "  Turbo Help ");
		phys_handle = graf_handle(&gl_wchar, &gl_hchar, &dummy, &dummy);
		vdi_handle = phys_handle;
		for (i = 0; i < 10; i++)
			workin[i] = 1;
		workin[10] = 2;
		v_opnvwk(workin, &vdi_handle, workout);
		if (vdi_handle != 0)
		{
			screen_width = workout[0];
			screen_height = workout[1];
			vq_extnd(vdi_handle, 1, workout);
			vdi_planes = workout[4];
			if ((screen_width + 1) / gl_wchar >= 80)
			{
				rsrc_fix();
				membuf_init();
				edit_init();
				arrow_mouse();
				eventloop(_app, argc >= 2 ? argv[1] : NULL);
				help_exit();
				mouse_on();
			} else
			{
				show_alert(AL_LOW_RESOLUTION, NULL);
			}
			v_clsvwk(vdi_handle);
		} else
		{
			form_alert(1, "[1][v_opnvwk()-Error][Ok]");
		}
		if (!_app)
		{
			for (;;)
				evnt_timer(EVNT_TIME(0));
		}
		appl_exit();
	} else
	{
		(void) Cconws("appl_init()-Error-Hit any key to return to desktop");
		Cconin();
	}
	return 0;
}

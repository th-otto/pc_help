#include "hc.h"
#include "country.h"

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

static const char *month_names_de[12] = {
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
};
static const char *month_names_en[12] = {
	"January",
	"February",
	"March",
	"April",
	"May",
	"June",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December"
};

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

/* ---------------------------------------------------------------------- */

void get_localtime(struct tm *tm)
{
#if defined(__TOS__) || defined(__atarist__)
	/*
	 * Since we only need a local time, avoid the overhead of pulling
	 * in all the timezone stuff.
	 * It is not well supported in Pure-C, anyway.
	 */
	unsigned short date;
	unsigned short time;
	
	date = Tgetdate();
	tm->tm_mday = date & 0x1f;
	date >>= 5;
	tm->tm_mon = (date & 0x0f) - 1;
	date >>= 4;
	date += 80;
	tm->tm_year = date;
	time = Tgettime();
	tm->tm_sec = (time << 1) & 0x3f;
	time >>= 5;
	tm->tm_min = time & 0x3f;
	time >>= 6;
	tm->tm_hour = time;
	tm->tm_wday = -1;
	tm->tm_yday = -1;
	tm->tm_isdst = -1;
#else
	time_t t;
		
	t = time(0);
	*tm = *localtime(&t);
#endif
}

/* ---------------------------------------------------------------------- */

const char *get_month_name(int country, int month)
{
	switch (country)
	{
	case COUNTRY_DE:
	case COUNTRY_SG:
		return month_names_de[month];
	}
	return month_names_en[month];
}

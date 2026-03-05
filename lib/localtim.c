#include <time.h>

struct tm *_conSecDat(time_t clock, int local);

struct tm *localtime(const time_t *clock)
{
	return _conSecDat(*clock + timezone, 1);
}

#include <string.h>
#include <stddef.h>


char *strchr(const char *s, int _c)
{
	unsigned char c = _c;
	unsigned char c1;
	
	do {
		if ((c1 = *s++) == '\0')
			goto end;
	} while (c1 != c);
found:
	--s;
	return (char *)s;
end:
	if (c == 0)
		goto found;
	return NULL;
}

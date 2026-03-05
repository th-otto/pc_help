#include "pc_help.h"
#include "alerts.h"

#define MAX_MEM_FD 1
#define MAX_MEMBUFS 20
struct memfd *cur_memfd;
static struct memfd memfds[MAX_MEM_FD];
static struct membuf membufs[MAX_MEMBUFS];

static void memfd_move_insert(off_t start);
static int memfd_realloc_insert(long);

/* ********************************************************************** */
/* ---------------------------------------------------------------------- */
/* ********************************************************************** */

void memfd_init(void)
{
	struct memfd *mem;
	
	mem = &memfds[0];
	mem->buf = NULL;
	cur_memfd = mem;
}

/* ---------------------------------------------------------------------- */

int memfd_new(void)
{
	struct memfd *mem;
	int j;
	
	mem = memfds;
	if (mem->buf != NULL)
		return AL_NO_MORE_WINDS;
	mem = memfds;
	mem->buf = membuf_alloc(1024);
	if (mem->buf != NULL)
	{
		mem->inserted = 0;
		mem->first_used = 1024;
		mem->last_used = 1024;
		for (j = 0; j < MAX_BUFFER_MARKS; j++)
			mem->marks[j] = -1;
		return 0;
	}
	return AL_LOWMEM;
}

/* ---------------------------------------------------------------------- */

void memfd_freebuf(void)
{
	membuf_free(memfds[0].buf);
	memfds[0].buf = NULL;
}

/* ---------------------------------------------------------------------- */

off_t memfd_getsize(void)
{
	return cur_memfd->last_used - (cur_memfd->first_used - cur_memfd->inserted);
}

/* ---------------------------------------------------------------------- */

void memfd_readbuf(off_t start, char *dst, ssize_t count)
{
	struct memfd *mem;
	const char *src;
	
	if (count > 0)
	{
		mem = cur_memfd;
		if (start < mem->inserted)
		{
			ssize_t copy;

			src = mem->buf->buf + start;
			if (mem->inserted - start < count)
			{
				copy = mem->inserted - start;
				memcpy(dst, src, copy);
				dst = dst + copy;
				copy = count - copy;
				src = mem->buf->buf + mem->first_used;
				memcpy(dst, src, copy);
				return;
			}
		} else
		{
			start -= mem->inserted;
			src = mem->buf->buf + mem->first_used + start;
		}
		memcpy(dst, src, count);
	}
}

/* ---------------------------------------------------------------------- */

int memfd_getc(off_t start)
{
	struct memfd *mem;
	const char *src;
	
	mem = cur_memfd;
	if (start < mem->inserted)
	{
		src = mem->buf->buf + start;
	} else
	{
		start -= mem->inserted;
		if (mem->first_used + start >= mem->last_used)
			return EOF;
		src = mem->buf->buf + mem->first_used + start;
	}
	return (unsigned char)*src;
}

/* ---------------------------------------------------------------------- */

int memfd_writebuf(off_t start, ssize_t delete, ssize_t insert, const char **src)
{
	struct memfd *mem;
	long len;
	long count;
	int i;
	
	mem = cur_memfd;
	if (delete > 0)
	{
		memfd_move_insert(start);
		mem->first_used += delete;
		len = mem->first_used - mem->inserted;
		if (len > 2048)
		{
			count = -(len - 1024);
			i = memfd_realloc_insert(count);
			if (i != 0)
				return AL_LOWMEM;
		}
		for (i = 0; i < MAX_BUFFER_MARKS; i++)
		{
			if (mem->marks[i] > mem->inserted)
			{
				if (mem->marks[i] < mem->inserted + delete)
					mem->marks[i] = mem->inserted;
				else
					mem->marks[i] -= delete;
			}
		}
	}
	
	if (insert > 0)
	{
		memfd_move_insert(start);
		len = mem->first_used - mem->inserted;
		if (insert > len)
		{
			count = 1024 - len + insert;
			i = memfd_realloc_insert(count);
			if (i != 0)
				return AL_LOWMEM;
		}
		for (i = 0; i < MAX_BUFFER_MARKS; i++)
		{
			if (mem->marks[i] > mem->inserted)
				mem->marks[i] += insert;
		}
		memcpy(mem->buf->buf + mem->inserted, *src, insert);
		mem->inserted += insert;
	}
	
	return 0;
}

/* ---------------------------------------------------------------------- */

int memfd_new_mark(long start)
{
	int i;
	struct memfd *mem;
	
	mem = cur_memfd;
	for (i = 0; i < MAX_BUFFER_MARKS && mem->marks[i] != -1; i++)
		;
	if (i < MAX_BUFFER_MARKS)
	{
		mem->marks[i] = start;
		return i;
	}
	return AL_INTERNAL;
}

/* ---------------------------------------------------------------------- */

long memfd_get_current_mark(int i)
{
	return cur_memfd->marks[i];
}

/* ---------------------------------------------------------------------- */

long memfd_get_mark(int fd, int i)
{
	return memfds[fd].marks[i];
}

/* ---------------------------------------------------------------------- */

void memfd_set_mark(int i, long start)
{
	cur_memfd->marks[i] = start;
}

/* ---------------------------------------------------------------------- */

void memfd_clear_mark(int i)
{
	cur_memfd->marks[i] = -1;
}

/* ---------------------------------------------------------------------- */

static void memfd_move_insert(off_t start)
{
	struct memfd *mem;
	long count;
	
	mem = cur_memfd;
	count = mem->inserted - start;
	if (count > 0)
	{
		mem->inserted -= count;
		mem->first_used -= count;
		memmove(mem->buf->buf + mem->first_used, mem->buf->buf + mem->inserted, count);
	} else if (count < 0)
	{
		memmove(mem->buf->buf + mem->inserted, mem->buf->buf + mem->first_used, -count);
		mem->inserted -= count;
		mem->first_used -= count;
	}
}

/* ---------------------------------------------------------------------- */

static int memfd_realloc_insert(long count)
{
	struct memfd *mem;

	mem = cur_memfd;
	if (count > 0)
	{
		if (membuf_realloc(mem->buf, mem->last_used + count) != 0)
			return AL_ERROR;
		memmove(mem->buf->buf + mem->first_used + count, mem->buf->buf + mem->first_used, mem->last_used - mem->first_used);
		mem->last_used += count;
		mem->first_used += count;
	} else if (count < 0)
	{
		memmove(mem->buf->buf + mem->first_used + count, mem->buf->buf + mem->first_used, mem->last_used - mem->first_used);
		mem->last_used += count;
		mem->first_used += count;
		if (membuf_realloc(mem->buf, mem->last_used) != 0)
			return AL_ERROR;
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

void *m_alloc(size_t size)
{
	return (void *)Malloc(size);
}

/* ---------------------------------------------------------------------- */

int m_free(void *ptr)
{
	return (int)Mfree(ptr);
}

/* ---------------------------------------------------------------------- */

void membuf_init(void)
{
	struct membuf *buf;
	
	for (buf = membufs; buf < &membufs[MAX_MEMBUFS]; buf++)
		buf->buf = NULL;
}

/* ---------------------------------------------------------------------- */

struct membuf *membuf_alloc(size_t size)
{
	struct membuf *buf;
	
	size += size & 1;
	for (buf = membufs; buf < &membufs[MAX_MEMBUFS] && buf->buf != NULL; buf++)
		;
	if (buf == &membufs[MAX_MEMBUFS])
		return NULL;
	buf->buf = m_alloc(size);
	if (buf->buf == NULL)
		return NULL;
	buf->size = size;
	return buf;
}

/* ---------------------------------------------------------------------- */

int membuf_realloc(struct membuf *buf, size_t size)
{
	void *newptr;
	
	size += size & 1;
	
	if (size > buf->size)
	{
		newptr = m_alloc(size);
		if (newptr == NULL)
			return AL_LOWMEM;
		memcpy(newptr, buf->buf, buf->size);
		m_free(buf->buf);
		buf->buf = newptr;
		buf->size = size;
	}
	return 0;
}

/* ---------------------------------------------------------------------- */

void membuf_free(struct membuf *buf)
{
	if (buf != NULL)
	{
		m_free(buf->buf);
		buf->buf = NULL;
	}
}

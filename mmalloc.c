#include "pc_help.h"

#define MEM_BLOCK_SIZE 8204UL

#define CHUNK_MAGIC 0x5B9C21DFUL
#define MEMBLOCK_END 0x34FEAF1BUL

struct chunk {
	unsigned long magic;
	size_t size;
};
struct memblock {
	struct memblock *next;
	union {
		struct memblock *start;
		size_t size;
	} u;
};

int (*_heapErr)(size_t size);
static struct memblock *mem_blk_list;


static void *getblock(size_t size)
{
	void *block;
	
	do
	{
		block = (void *)Malloc(size);
		if (block != NULL)
			return block;
	} while (_heapErr != 0 && _heapErr(size) != 0);
	return NULL;
}


static void *getchunk(size_t size)
{
	struct chunk *chunk;
	
	chunk = (struct chunk *)getblock(size + sizeof(*chunk));
	if (chunk == NULL)
		return NULL;
	chunk->magic = CHUNK_MAGIC;
	chunk->size = size;
	++chunk;
	return chunk;
}


static struct memblock *getmemblock(void)
{
	struct memblock *block;
	struct memblock *start;
	struct memblock **last;
	struct memblock *next;
	
	block = (struct memblock *)getblock(MEM_BLOCK_SIZE);
	if (block == NULL)
		return NULL;
	start = block + 1;
	block->u.start = start;
	start->next = NULL;
	start->u.size = MEM_BLOCK_SIZE - 20;
	*((unsigned long *)((char *)block + MEM_BLOCK_SIZE - 4)) = 0x34FEAF1BUL;
	last = &mem_blk_list;
	next = *last;
	while (next != NULL)
	{
		if (next > block)
			break;
		last = &(next)->next;
		next = *last;
	}
	block->next = next;
	*last = block;
	return block;
}


static void freememblock(struct memblock *block)
{
	struct memblock **last;
	
	last = &mem_blk_list;
	while (*last != NULL)
	{
		if (*last == block)
		{
			*last = block->next;
			Mfree(block);
			return;
		}
		last = &(*last)->next;
	}
}


static void *alloc_from_memlist(size_t size)
{
	struct memblock **last;
	struct memblock *start;
	struct memblock *block;
	size_t remain;
	
	size += size & 1;
	block = mem_blk_list;
	for (;;)
	{
		if (block == NULL)
		{
			block = getmemblock();
			if (block == NULL)
				return NULL;
		}
		last = &block->u.start;
		start = *last;
		while (start)
		{
			if (start->u.size >= size)
			{
				remain = start->u.size - size;
				if (remain < 24)
				{
					*last = start->next;
				} else
				{
					struct memblock *p;
					
					remain -= sizeof(*block);
					start->u.size = remain;
					p = (struct memblock *)((char *)start + remain + sizeof(*block));
					start = p;
					start->u.size = size;
				}
				*((unsigned long *)start) = MEMBLOCK_END;
				return ++start;
			}
			last = &start->next;
			start = *last;
		}
		block = block->next;
	}
}


static bool is_chunk(void *block)
{
	struct chunk *chunk = (struct chunk *)block - 1;
	return chunk->magic == CHUNK_MAGIC;
}


static size_t chunk_size(void *block)
{
	struct chunk *chunk = (struct chunk *)block - 1;
	return chunk->size;
}


static int free_chunk(void *block)
{
	struct chunk *chunk = (struct chunk *)block;
	chunk--;
	return (int)Mfree(chunk);
}


static int free_memblock(void *p)
{
	struct memblock *block = p;
	struct memblock *scan;
	struct memblock *last;
	struct memblock *start;
	
	block--;
	scan = mem_blk_list;
	while (scan)
	{
		if ((size_t)((char *)block - (char *)(scan + 1)) <= (MEM_BLOCK_SIZE - 12UL))
		{
			last = NULL;
			start = scan->u.start;
			while (start)
			{
				if (start > block)
					break;
				last = start;
				start = start->next;
			}
			if (last != NULL && (char *)(last + 1) + last->u.size == (char *)block)
			{
				last->u.size += block->u.size + sizeof(*block);
				block = last;
			} else
			{
				block->next = start;
				if (last == NULL)
					scan->u.start = block;
				else
					last->next = block;
			}
			if (start != NULL && (char *)(block + 1) + block->u.size == (char *)start)
			{
				block->next = start->next;
				block->u.size += start->u.size + sizeof(*block);
			}
			if (block->u.size == MEM_BLOCK_SIZE - 20UL)
				freememblock(scan);
			return 0;
		}
		scan = scan->next;
	}
	return 1;
}


static int chunk_realloc(void *block, size_t newsize)
{
	struct chunk *chunk = (struct chunk *)block;
	chunk--;
#ifdef ORIG_PUREC
	if (Mshrink(0, chunk, newsize + sizeof(*chunk)) != 0)
#else
	if (Mshrink(chunk, newsize + sizeof(*chunk)) != 0)
#endif
		return 1;
	chunk->size = newsize;
	return 0;
}


static int mem_realloc(void *p, size_t newsize)
{
	struct memblock *block = (struct memblock *)p;
	size_t remain;
	
	block--;
	newsize += newsize & 1;
	remain = block->u.size - newsize;
	if (remain >= 24)
	{
		block->u.size = newsize;
		block = (struct memblock *)((char *)block + newsize + sizeof(*block));
		block->u.size = remain - sizeof(*block);
		free_memblock(block + 1);
	}
	return 0;
}


void *x_malloc(size_t size)
{
	if (size >= 16377UL)
		return getchunk(size);
	return alloc_from_memlist(size);
}


int x_free(void *ptr)
{
	if (ptr == NULL)
		return 0;
	if (is_chunk(ptr))
		return free_chunk(ptr);
	return free_memblock(ptr);
}


int x_realloc(void *ptr, size_t size)
{
	if (ptr == NULL)
		return 0;
	if (is_chunk(ptr))
		return chunk_realloc(ptr, size);
	return mem_realloc(ptr, size);
}


void *m_realloc(void *ptr, size_t size)
{
	void *newptr;
	size_t oldsize;
	
	if (ptr == NULL)
		return x_malloc(size);
	oldsize = chunk_size(ptr);
	if (oldsize > size)
	{
		m_realloc(ptr, size);
		return ptr;
	}
	newptr = x_malloc(size);
	if (newptr == NULL)
		return NULL;
	memcpy(newptr, ptr, oldsize);
	x_free(ptr);
	return newptr;
}


void *memrealloc(void *ptr)
{
	struct memblock *block;
	size_t size;
	void *newptr;
	
	if (ptr == NULL)
		return NULL;
	size = chunk_size(ptr);
	block = getmemblock();
	newptr = x_malloc(size);
	if (block != NULL && block->u.start->u.size == MEM_BLOCK_SIZE - 20UL)
		freememblock(block);
	if (newptr == NULL || newptr >= ptr)
	{
		x_free(newptr);
		return ptr;
	}
	memcpy(newptr, ptr, size);
	x_free(ptr);
	return newptr;
}

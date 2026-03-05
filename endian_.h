#ifndef __ORDER_BIG_ENDIAN__
#define __ORDER_BIG_ENDIAN__    4321
#define __ORDER_LITTLE_ENDIAN__ 1234
#endif

#if defined(__mc68000__) || defined(__PUREC__) || defined(__TURBOC__) || defined(__AHCC__)
#  ifndef __atarist__
#    define __atarist__ 1
#  endif
#endif

#ifndef __BYTE_ORDER__
#  if defined(__atarist__)
#    define __BYTE_ORDER__ __ORDER_BIG_ENDIAN__
#  endif
#  if defined(__i386__) || defined(__i486__) || defined(__i586__) || defined(__i686__) || defined(__x86_64__)
#    define __BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__
#  endif
#endif

#ifndef __BYTE_ORDER__
# error "unknown byte order"
#endif

#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__

#ifdef __linux__

#include <byteswap.h>

#define be16_to_cpu(x) __bswap_16(x)
#define be32_to_cpu(x) __bswap_32(x)
#define cpu_to_be16(x) __bswap_16(x)
#define cpu_to_be32(x) __bswap_32(x)

#else

static __inline uint16_t bswap_16(uint16_t v)
{
    return ((((v) >> 8) & 0xffu) | (((v) & 0xffu) << 8));
}

static __inline uint32_t bswap_32(uint32_t v)
{
	return (((v >> 24) & 0xffu) | ((v >> 8) & 0xff00u) | ((v & 0xffu) << 24) | ((v & 0xff00u) << 8));
}

#define be16_to_cpu(x) bswap_16(x)
#define be32_to_cpu(x) bswap_32(x)
#define cpu_to_be16(x) bswap_16(x)
#define cpu_to_be32(x) bswap_32(x)

#endif

#else

#define be16_to_cpu(x) x
#define be32_to_cpu(x) x
#define cpu_to_be16(x) x
#define cpu_to_be32(x) x

#endif


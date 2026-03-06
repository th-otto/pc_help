#ifndef __STDINT__H__
#define __STDINT__H__

#if defined(__PUREC__) && defined(__STDIO)
#define ORIG_PUREC
#endif

#ifdef ORIG_PUREC
typedef unsigned char uint8_t;
typedef signed char int8_t;
typedef unsigned short uint16_t;
typedef signed short int16_t;
typedef unsigned long uint32_t;
typedef signed long int32_t;
typedef long ssize_t;
typedef long intptr_t;
typedef unsigned long uintptr_t;
#else
#include <stdint.h>
#endif
#ifdef __PUREC__
typedef long off_t;
#endif

#if !defined(__attribute__) && !defined(__GNUC__)
#define __attribute__(x)
#endif

#endif /* __STDINT__H__ */

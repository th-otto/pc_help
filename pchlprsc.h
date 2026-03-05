/*
 * resource set indices for pchlprsc
 *
 * created by ORCS 2.18
 */

/*
 * Number of Strings:        13
 * Number of Bitblks:        0
 * Number of Iconblks:       0
 * Number of Color Iconblks: 0
 * Number of Color Icons:    0
 * Number of Tedinfos:       1
 * Number of Free Strings:   0
 * Number of Free Images:    0
 * Number of Objects:        12
 * Number of Trees:          1
 * Number of Userblks:       0
 * Number of Images:         0
 * Total file size:          660
 */

#ifdef RSC_NAME
#undef RSC_NAME
#endif
#ifndef __ALCYON__
#define RSC_NAME "pchlprsc"
#endif
#ifdef RSC_ID
#undef RSC_ID
#endif
#ifdef pchlprsc
#define RSC_ID pchlprsc
#else
#define RSC_ID 0
#endif

#ifndef RSC_STATIC_FILE
# define RSC_STATIC_FILE 0
#endif
#if !RSC_STATIC_FILE
#define NUM_STRINGS 13
#define NUM_FRSTR 0
#define NUM_UD 0
#define NUM_IMAGES 0
#define NUM_BB 0
#define NUM_FRIMG 0
#define NUM_IB 0
#define NUM_CIB 0
#define NUM_TI 1
#define NUM_OBS 12
#define NUM_TREE 1
#endif



#define MAIN_DIALOG                        0 /* form/dialog */
#define DLG_KEYWORD                        3 /* FBOXTEXT in tree MAIN_DIALOG */
#define DLG_CANCEL                         4 /* BUTTON in tree MAIN_DIALOG */
#define DLG_OK                             5 /* BUTTON in tree MAIN_DIALOG */
#define DLG_LANGUAGE                       6 /* BUTTON in tree MAIN_DIALOG */
#define DLG_LIBRARIES                      7 /* BUTTON in tree MAIN_DIALOG */
#define DLG_OPTIONS                        8 /* BUTTON in tree MAIN_DIALOG */
#define DLG_ASSEMBLER                      9 /* BUTTON in tree MAIN_DIALOG */
#define DLG_INDEX                         10 /* BUTTON in tree MAIN_DIALOG */




#ifdef __STDC__
#ifndef _WORD
#  ifdef WORD
#    define _WORD WORD
#  else
#    define _WORD short
#  endif
#endif
extern _WORD pchlprsc_rsc_load(_WORD wchar, _WORD hchar);
extern _WORD pchlprsc_rsc_gaddr(_WORD type, _WORD idx, void *gaddr);
extern _WORD pchlprsc_rsc_free(void);
#endif

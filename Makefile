#
# use "make CROSS=" to do a native compilation
# add COUNTRY=0 to compile an english version
#
CROSS=m68k-atari-mint-

TEST_CODE?=0
COUNTRY?=1

CC=$(CROSS)gcc
AS=$(CC)
WARN = -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wundef -Werror
OPTS=-O2 -fomit-frame-pointer
CFLAGS=-I. $(COMMON_DIR) $(OPTS) $(WARN) -DTEST_CODE=$(TEST_CODE) -DCOUNTRY=$(COUNTRY)
LDFLAGS=-s

ifeq ($(CROSS),)
STRIPEX = :
else
EXE = .ttp
endif

OBJS = \
	hc.o \
	hcio.o \
	hcparse.o \
	hclex.o \
	hchash.o \
	hclog.o \
	hcindex.o \
	hccompr.o \
	\
	$(empty)

PCHELP_OBJS = \
	pch_main.o \
	pch_help.o \
	display.o \
	win.o \
	membuf.o \
	pchlplib.o \
	mmalloc.o \
	$(empty)

# util2.o not used

PROGRAMS =
PROGRAMS += hc$(EXE)
PROGRAMS += help_rc$(EXE)
ifneq ($(CROSS),)
PROGRAMS += pc_help.prg
LIBS=-liio
endif

all:  $(PROGRAMS)

hc$(EXE): $(OBJS)
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS)

help_rc$(EXE): help_rc.o
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $< $(LIBS)

pc_help.prg: $(PCHELP_OBJS)
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(PCHELP_OBJS) $(LIBS) -lgem

$(OBJS): $(MAKEFILE_LIST)

findstr.o: findstr.s
	$(AS) -c -o $@ $<

gccstub.o: gccstub.s
	$(AS) -c -o $@ $<

clean::
	$(RM) *.o *.pdb hc hc$(EXE) help_rc help_rc$(EXE) pc_help.prg

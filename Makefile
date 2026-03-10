#
# use "make CROSS=" to do a native compilation
#
CROSS=m68k-atari-mint-

TEST_CODE?=0

CC=$(CROSS)gcc
AS=$(CC)
WARN = -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wdeclaration-after-statement -Wundef -Werror
OPTS=-O2 -fomit-frame-pointer
CFLAGS=$(CPU_CFLAGS) -I. $(COMMON_DIR) $(OPTS) $(WARN) -DTEST_CODE=$(TEST_CODE)
LDFLAGS=-s

ifneq ($(findstring mint,$(CROSS)),)
EXE = .ttp
endif
ifneq ($(findstring mingw,$(CROSS)),)
EXE = .exe
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
	country.o \
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

PPHELP_OBJS = \
	pph_main.o \
	pch_help.o \
	display.o \
	win.o \
	membuf.o \
	pphlplib.o \
	mmalloc.o \
	$(empty)

PROGRAMS =
PROGRAMS += hc$(EXE)
PROGRAMS += help_rc$(EXE)
PROGRAMS += helpcomp$(EXE)
ifneq ($(findstring mint,$(CROSS)),)
PROGRAMS += pc_help.prg
PROGRAMS += pp_help.prg
LIBS=-liio
endif

all:  $(PROGRAMS)

hc$(EXE): $(OBJS)
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS)

help_rc$(EXE): help_rc.o
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $< $(LIBS)

helpcomp$(EXE): helpcomp.o
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $< $(LIBS)

pc_help.prg: $(PCHELP_OBJS)
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(PCHELP_OBJS) $(LIBS) -lgem

pp_help.prg: $(PPHELP_OBJS)
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS) $(PPHELP_OBJS) $(LIBS) -lgem

$(OBJS): $(MAKEFILE_LIST)

findstr.o: findstr.s
	$(AS) -c -o $@ $<

gccstub.o: gccstub.s
	$(AS) -c -o $@ $<

clean::
	$(RM) *.o *.pdb hc hc$(EXE) help_rc helpcomp help_rc$(EXE) pc_help.prg pp_help.prg

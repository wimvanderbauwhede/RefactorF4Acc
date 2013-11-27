#FC = ifort
#CC = icc
FC = gfortran 
CC = gcc 
FFLAGS = -g -cpp -m32
# CFLAGS is needed only for the timing test done in ftest/
CFLAGS = -g -m32
SRCS = $(shell ls *.F90)
OBJS = $(addsuffix .o, $(basename $(SRCS)))

all: $(OBJS) libgptl.a test install

test:
	(cd ftest && make FC=$(FC) CC=$(CC)) || (echo "test failed: quitting" && exit 1)

libgptl.a: $(OBJS)
	$(AR) ruv $@ $(OBJS)

install: libgptl.a
	echo "copying libgptl.a to lib/..."
	@(cp libgptl.a lib/) || (echo "failed to copy libgptl.a to lib/" && exit 1)
	echo "copying gptl.inc to include/..."
	@(cp gptl.inc include/) || (echo "failed to copy gptl.inc to include/" && exit 1)

.SUFFIXES:
.SUFFIXES: .o .F90

.F90.o:
	$(FC) -c $(FFLAGS) $<

clean:
	$(RM) *.o libgptl.a
	(cd ftest && make clean)
	$(RM) include/* lib/*

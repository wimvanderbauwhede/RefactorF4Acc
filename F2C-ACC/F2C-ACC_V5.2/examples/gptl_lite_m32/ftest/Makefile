CFLAGS = -g -m32
FFLAGS = -cpp -g -m32 
LDFLAGS = -m32 -L.. -lgptl
OBJS = fmain.o mysleep.o
FC = gfortran 
all: testit
	./a.out

testit: $(OBJS)
	$(FC) -o a.out $(OBJS) $(LDFLAGS)

.SUFFIXES: .o .F90

.F90.o:
	$(FC) -c $(FFLAGS) $<

clean:
	$(RM) *.o a.out

mysleep.o: mysleep.c

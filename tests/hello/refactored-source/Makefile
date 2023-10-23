
hello: error_codes.o greet_world.o main.o
	$(FC) error_codes_h.o greet_world.o main.o -L/usr/lib -o hello 

main.o: src/main.f90
	$(FC) -c src/main.f90
error_codes.o: src/include/error_codes_h.f90
	$(FC) -c src/include/error_codes_h.f90
greet_world.o: src/greet_world.f90
	$(FC) -c src/greet_world.f90

.PHONY: clean
clean:
	rm *.mod *.o hello

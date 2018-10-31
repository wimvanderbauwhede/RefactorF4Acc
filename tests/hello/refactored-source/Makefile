
hello: error_codes.o greet_world.o main.o
	$(FC) error_codes.o greet_world.o main.o -o hello 

main.o: src/main.f95
	$(FC) -c src/main.f95
error_codes.o: src/include/error_codes.f95
	$(FC) -c src/include/error_codes.f95
greet_world.o: src/greet_world.f95
	$(FC) -c src/greet_world.f95

.PHONY: clean
clean:
	rm *.mod *.o hello

#rm out.log
F4-exe -m coriolis.f95 -s ./src -o corio_core
#-o update_loc_vel -D VERBOSE
#F4-exe -m coriolis.f95 -s ./src -o update_loc_vel 
#F4-exe -m coriolis.f95 -s ./src -o predict_vel
#F4-exe -m coriolis.f95 -s ./src -o update_loc_vel -o predict_loc
#>> out.log 2>&1

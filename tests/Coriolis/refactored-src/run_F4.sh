#rm out.log
F4-exe -m coriolis.f95 -s ./src -o predict_loc -o predict_vel -o update_loc_vel 
#F4-exe -m coriolis.f95 -s ./src -o update_loc_vel 
#F4-exe -m coriolis.f95 -s ./src -o predict_vel
#F4-exe -m coriolis.f95 -s ./src -o update_loc_vel -o predict_loc
#>> out.log 2>&1

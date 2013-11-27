integer, parameter :: gptl_max_regions = 100 ! max allowable regions

integer(8)        :: gptl_last(0:gptl_max_regions-1)        ! last timestamp               
integer(8)        :: gptl_total(0:gptl_max_regions-1)       ! total accumulated time       
integer(8)        :: gptl_count_rate                        ! returned from system_clock
integer           :: gptl_nregions                          ! number of active timers      
integer           :: gptl_ncalls(0:gptl_max_regions-1)      ! number of calls              
logical           :: gptl_initialized                       ! initialization has been done 
logical           :: gptl_isrunning(0:gptl_max_regions-1)   ! flag indicates if timer is on
character(len=32) :: gptl_name(0:gptl_max_regions-1)        ! names of timers              

common /gptl_private/ gptl_last, gptl_total, gptl_count_rate, gptl_nregions, gptl_ncalls, &
                      gptl_initialized, gptl_isrunning, gptl_name


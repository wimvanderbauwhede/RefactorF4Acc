        program min_coercion
        integer i1,i2,i3,i4
        real r1,r2,r3,r4
        i1=11
        i2=22
        r1=1.1
        r2=2.2
        i3 = min(i1,i2)
        r4 = min(r1,r2)
#ifdef SHOW_ERRORS    
        i3 = min(i1,r2) ! error
#endif        
        i3 = min1(r1,r2) ! warning
        i4 = min(r1,r2) ! warning
#ifdef SHOW_ERRORS    
        r3 = min(i1,r2) ! error
#endif        
        r3 = amin0(i1,i2) 
        r4 = min(i1,i2,i3,i4) 
        end program min_coercion


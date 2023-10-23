      program array_subtyping
      integer ai1(4),ai2(8)
      integer k1,k2,kk1,kk2
      parameter(kk1=4)
      parameter(kk2=8)
      ai1 = 11 
      ai2 = 22
      ai1 = ai2(1:4) ! ok
      ai2(1:4) = ai1 ! ok
      k1=4
      k2=8
      ai1 = ai2(1:k2)
      ai2 = ai1(1:k1)
#ifdef SHOW_ERRORS    
      ai1 = ai2(1:kk2) ! error
      ai2 = ai1(1:kk1) ! error
      ai1 = ai2 ! error
      ai2 = ai1 ! error
#endif      
      end

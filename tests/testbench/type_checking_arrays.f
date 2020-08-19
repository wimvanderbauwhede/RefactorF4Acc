      program tsp
       INTEGER A(5,5)
       INTEGER i,j, K(3), kk(2,3), kk2(8)
       INTEGER r(3), three
       parameter(three=3)
       dimension r5(5)
       K = (/ 1, 5, 2 /)
       kk(1,:) = (/1,2,3/)
       kk(2,:) = (/3,4,5/) 
       do i=1,8
       kk2(i)=i
       end do
!       A(2, (/1, 3, 5/))
       do i=1,5
       do j=1,5
       a(i,j)=i*10+j
       end do
       end do
       r =  A(2, 1:3) ! OK
       print *,r
       r = A(2, 1:5:2) ! OK
       print *,r
       i=22
       r = A(2, 1:5:i) ! NOT OK, RHS is (1,2)
       print *,r
       r5 = A(2, :) ! OK
       print *,r5
    
       r = A(2, K)
       print *,r ! K is size 3, so (1,3) so OK
       k(3) = 42
       r = A(2, K) ! Type check OK but out of bounds
       print *,r 
       j=5
       print *,r,r(j) 
       r = a(1,kk(1,:)) ! OK
       print *,r
       i=2
       j=4
       r = a(1,kk2(i:j)) ! OK
       print *,r
       i=2
       j=4
       r = a(1,kk2(1:2*j)) ! NOK: LHS is (1,3) RHS is (1,8)
       print *,r
       i=2
       j=4
       kk2 = a(1,k(1:i+1)) ! NOK: LHS is (1,8) RHS is (1,3)
       print *,kk2
       !r = a(1,kk2(1:8)) ! ERROR: LHS is (1,3) RHS is (1,8)
       !print *,r
       !kk2 = a(1,k(1:3)) ! ERROR: LHS is (1,8) RHS is (1,3)
       !print *,kk2
       !kk2 = a(1,k(1:three)) ! ERROR: LHS is (1,8) RHS is (1,3)
       !print *,kk2
      end 

   

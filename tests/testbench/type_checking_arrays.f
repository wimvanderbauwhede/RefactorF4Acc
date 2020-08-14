      program tsp
       INTEGER A(5,5)
       INTEGER i,j, K(3), kk(2,3)
       INTEGER r(3)
       dimension r5(5)
       K = (/ 1, 5, 2 /)
       kk(1,:) = (/1,2,3/)
       kk(2,:) = (/3,4,5/) 
!       A(2, (/1, 3, 5/))
       do i=1,5
       do j=1,5
       a(i,j)=i*10+j
       end do
       end do
       r =  A(2, 1:3)
       print *,r
       r = A(2, 1:5:2)
       print *,r
       i=22
       r = A(2, 1:5:i)
       print *,r
       r5 = A(2, :)
       print *,r
    
       r = A(2, K)
       print *,r
       k(3) = 42
       r = A(2, K)
       print *,r
       j=5
       print *,r,r(j) 
       r = a(1,kk(1,:))
       print *,r
      end 

   

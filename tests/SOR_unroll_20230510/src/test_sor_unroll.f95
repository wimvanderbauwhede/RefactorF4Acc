! Inline and then run through the apf compiler, then reduce, then translate to C

! Write a simple host code: just a time loop that calls sor

! $ time ./test_sor_unroll_1
! -390.423431    

! real	0m7.482s
! user	0m7.482s
! sys	0m0.000s
! $ time ./test_sor_unroll_2
! -391.846161    

! real	0m7.910s
! user	0m7.902s
! sys	0m0.008s
! $ time ./test_sor_unroll_3
! -392.749146    

! real	0m7.947s
! user	0m7.935s
! sys	0m0.012s
! $ time ./test_sor_unroll_4
! -393.359375    

! real	0m7.982s
! user	0m7.965s
! sys	0m0.016s


program test_sor_unroll
use sor_params
use sor_routines
real, dimension(0:im+1,0:jm+1,0:km+1) :: p0
real, dimension(0:im+1,0:jm+1,0:km+1) :: p1
real, dimension(0:im+1,0:jm+1,0:km+1) :: rhs
#if UNROLL>1
real, dimension(0:im+1,0:jm+1,0:km+1) :: p2
#if UNROLL>2
real, dimension(0:im+1,0:jm+1,0:km+1) :: p3
#if UNROLL>3
real, dimension(0:im+1,0:jm+1,0:km+1) :: p4
#endif
#endif
#endif
integer :: iter, niters

integer :: i,j,k

do i = 0,im+1
do j = 0,jm+1
do k = 0,km+1
    rhs(i,j,k) = 1.0
    p0(i,j,k) = 1.0
    end do
end do
end do

niters = 1200/UNROLL

do iter = 1,niters
    ! print *,iter
!$RF4A Subroutine sor_superkernel
!$RF4A Begin Inline
call sor (p0,p1,rhs)
#if UNROLL > 1
call sor (p1,p2,rhs)
#if UNROLL > 2
call sor (p2,p3,rhs)
#if UNROLL > 3
call sor (p3,p4,rhs)
#endif
#endif
#endif
!$RF4A End Inline
!$RF4A End Subroutine sor_superkernel
#if UNROLL==1
p0=p1
#elif UNROLL==2
p0=p2
#elif UNROLL==3
p0=p3
#elif UNROLL==4
p0=p4
#endif
end do

print *, p0(im/2,jm/2,km/2)

end program


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
#ifdef WITH_OPENMP
use omp_lib
#endif

use sor_params
use sor_routines
#ifndef DYN_ALLOC
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
#else
    real, allocatable  :: p0(:,:,:)
    real, allocatable  :: p1(:,:,:)
    real, allocatable  :: rhs(:,:,:)
#if UNROLL>1
    real, allocatable  :: p2(:,:,:)
#if UNROLL>2
    real, allocatable  :: p3(:,:,:)
#if UNROLL>3
    real, allocatable  :: p4(:,:,:)
#endif
#endif
#endif
#endif
integer :: iter, niters

integer :: i,j,k
#ifdef TIMING
    integer :: clock_rate
    integer, dimension(0:1) :: timestamp
#endif

#ifdef DYN_ALLOC
    allocate(p0(0:im+1,0:jm+1,0:km+1))
    allocate(p1(0:im+1,0:jm+1,0:km+1))
    allocate(rhs(0:im+1,0:jm+1,0:km+1))
#if UNROLL>1
    allocate(p2(0:im+1,0:jm+1,0:km+1))
#if UNROLL>2
    allocate(p3(0:im+1,0:jm+1,0:km+1))
#if UNROLL>3
    allocate(p4(0:im+1,0:jm+1,0:km+1))
#endif
#endif
#endif
#endif

do i = 0,im+1
do j = 0,jm+1
do k = 0,km+1
    rhs(i,j,k) = 1.0
    p0(i,j,k) = 1.0
end do
end do
end do

niters = 24/UNROLL
#ifdef TIMING
    call system_clock(timestamp(0), clock_rate)
#endif
do iter = 1,niters
    print *,iter
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
#ifdef TIMING
    call system_clock(timestamp(1), clock_rate)
    print '(f8.3)',(timestamp(1)-timestamp(0))/ real(clock_rate)
#endif
print *, p0(im/2,jm/2,km/2)
#ifdef DYN_ALLOC
    deallocate(p0)
    deallocate(p1)
    deallocate(rhs)
#if UNROLL>1
    deallocate(p2)
#if UNROLL>2
    deallocate(p3)
#if UNROLL>3
    deallocate(p4)
#endif
#endif
#endif
#endif
end program


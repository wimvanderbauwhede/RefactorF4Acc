! gfortran -Ofast -fopenmp test_omp.f95 
! gfortran -Ofast -mcmodel=medium -fopenmp omp_ex.f95 
! OMP_NUM_THREADS=8 ./a.out 
! Conclusion: using subroutines in the loop body seems to work just fine
program main
    use omp_lib
    integer :: global_id
    ! Declarations
    real, dimension(1:512000) :: test
    real, dimension(1:512000) :: test2
    integer :: i,j,k
    integer :: iter
    integer, parameter :: niters = 10000

    integer :: thid, nth
    !$OMP PARALLEL
    nth = omp_get_num_threads()
    !thid = omp_get_thread_num()
    !  print *, "Number of threads: ",nth
    !$OMP END PARALLEL
    do iter=1,niters
    !$OMP PARALLEL DO
    do i=1,512000
    call testf(test,i)
    call testf(test2,i)
    test(i)=test2(i)+1
    end do
    !$OMP END PARALLEL DO
    end do
  print *,test(1),test(512000), test2(1),test2(512000)  
end program main  

subroutine testf(v,i) 
    real:: v(512000)
    integer, intent(in) :: i
    v(i)=2.0*i+1.0
end subroutine testf


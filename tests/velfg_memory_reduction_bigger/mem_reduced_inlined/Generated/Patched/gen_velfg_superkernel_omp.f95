program main
     use omp_lib
 
     implicit none
     integer, parameter :: niters=50
     integer, parameter :: sz =  2025000
     integer :: global_id
     real, dimension(1:sz) :: u_0
     real, dimension(1:sz) :: h_1

     ! integer :: idx
     integer :: iter
     do global_id = 1, sz     
       h_1(global_id) = 1.0
       u_0(global_id) = 2.0      
     end do ! global_id    

!    ! Loops over stage calls
!     state_ptr = st_stage_kernel_1
    do iter = 1, niters
!$OMP PARALLEL DO SHARED(u_0,h_1)
    do global_id = 1, sz

     h_1(global_id) =  u_0(global_id)
 
    end do ! global_id
!$OMP END PARALLEL DO
    end do
    print *,h_1(10)
end program main  

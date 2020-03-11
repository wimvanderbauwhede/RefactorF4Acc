module mpi_dummy_h
      integer, parameter :: mpi_comm_world=0 
      integer, parameter :: mpi_failure=1 
      integer, parameter :: mpi_success=0 
      integer, parameter :: mpi_status_size=3 
      integer, parameter :: mpi_source=1 
      integer, parameter :: mpi_tag=2 
      integer, parameter :: mpi_count=3 
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_any_source=-1 
      integer, parameter :: mpi_any_tag=-1 
      integer, parameter :: mpi_integer=1 
      integer, parameter :: mpi_integer8=6 
      integer, parameter :: mpi_real=2 
      integer, parameter :: mpi_double_precision=3 
      integer, parameter :: mpi_logical=4 
      integer, parameter :: mpi_character=5 
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_sum=1 
      integer, parameter :: mpi_max=2 
      integer, parameter :: mpi_min=3 
      integer, parameter :: mpi_product=4 
      real(kind=8) :: mpi_wtime
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_wronly=4

end module mpi_dummy_h

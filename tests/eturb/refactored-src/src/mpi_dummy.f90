! *********************************************************************72
module singleton_module_src_mpi_dummy

contains

      subroutine mpi_allreduce(data1,data2,n,datatype,operation,comm,ierror)
! 
! *********************************************************************72
! 
! c MPI_ALLREDUCE carries out a reduction operation.
      implicit none
! 
!   Dummy parameters for MPI F77 stubs
! 
      integer, parameter :: mpi_comm_world=0
! 
!   Return values.
! 
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
! 
!   recv message status
! 
      integer, parameter :: mpi_status_size=3
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_count=3
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, parameter :: mpi_info_null=0
! 
!   recv flags
! 
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
! 
!   data types and sizes
! 
      integer, parameter :: mpi_integer=1
      integer, parameter :: mpi_integer8=6
      integer, parameter :: mpi_real=2
      integer, parameter :: mpi_double_precision=3
      integer, parameter :: mpi_logical=4
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_byte=1
! 
!   allreduce operations
! 
      integer, parameter :: mpi_sum=1
      integer, parameter :: mpi_max=2
      integer, parameter :: mpi_min=3
      integer, parameter :: mpi_product=4
! 
!   timer
! 
      real(kind=8) :: mpi_wtime
! 
!   I/O
! 
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_wronly=4
      integer, intent(In) :: n
      integer :: comm
      integer, dimension(1:n), intent(InOut) :: data1
      integer, dimension(1:n), intent(InOut) :: data2
      integer, intent(In) :: datatype
      integer, intent(Out) :: ierror
      integer, intent(In) :: operation
      real(kind=8), dimension(1:n) :: data1_mpi_reduce_double_precision
      integer(kind=8), dimension(1:n) :: data1_mpi_reduce_integer8
      real, dimension(1:n) :: data1_mpi_reduce_real
      real(kind=8), dimension(1:n) :: data2_mpi_reduce_double_precision
      integer(kind=8), dimension(1:n) :: data2_mpi_reduce_integer8
      real, dimension(1:n) :: data2_mpi_reduce_real
      ierror = mpi_success
      if ( datatype  ==  mpi_double_precision ) then
        data1_mpi_reduce_double_precision = real(data1,8)
        data2_mpi_reduce_double_precision = real(data2,8)
        call mpi_reduce_double_precision(data1_mpi_reduce_double_precision, &
      data2_mpi_reduce_double_precision,n,operation,ierror)
        data1 = int(data1_mpi_reduce_double_precision, 4)
        data2 = int(data2_mpi_reduce_double_precision, 4)
      else if ( datatype  ==  mpi_integer ) then
        call mpi_reduce_integer(data1,data2,n,operation,ierror)

      else if ( datatype  ==  mpi_integer8 ) then
        data1_mpi_reduce_integer8 = data1
        data2_mpi_reduce_integer8 = data2
        call mpi_reduce_integer8(data1_mpi_reduce_integer8,data2_mpi_reduce_integer8,n,operation, &
      ierror)
        data1 = data1_mpi_reduce_integer8
        data2 = data2_mpi_reduce_integer8
      else if ( datatype  ==  mpi_real ) then
        data1_mpi_reduce_real = real(data1,4)
        data2_mpi_reduce_real = real(data2,4)
        call mpi_reduce_real(data1_mpi_reduce_real,data2_mpi_reduce_real,n,operation,ierror)

        data1 = int(data1_mpi_reduce_real, 4)
        data2 = int(data2_mpi_reduce_real, 4)
      else
        ierror = mpi_failure
      end if
      return
      end subroutine mpi_allreduce
      subroutine mpi_barrier(comm,ierror)
! *********************************************************************72
! 
! c MPI_BARRIER forces processes within a communicator to wait together.
! 
      implicit none
      integer :: comm
      integer, intent(Out) :: ierror
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
      ierror = mpi_failure
      return
      end subroutine mpi_barrier
      subroutine mpi_finalize(ierror)
! *********************************************************************72
! 
! c MPI_FINALIZE shuts down the MPI library.
! 
      implicit none
      integer, intent(Out) :: ierror
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
      ierror = mpi_success
      return
      end subroutine mpi_finalize
      subroutine mpi_reduce_double_precision(data1,data2,n,operation,ierror)
! 
! *********************************************************************72
! 
! c MPI_REDUCE_DOUBLE_PRECISION carries out a reduction operation on real*8 values.
      implicit none
! 
!   Dummy parameters for MPI F77 stubs
! 
      integer, parameter :: mpi_comm_world=0
! 
!   Return values.
! 
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
! 
!   recv message status
! 
      integer, parameter :: mpi_status_size=3
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_count=3
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, parameter :: mpi_info_null=0
! 
!   recv flags
! 
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
! 
!   data types and sizes
! 
      integer, parameter :: mpi_integer=1
      integer, parameter :: mpi_integer8=6
      integer, parameter :: mpi_real=2
      integer, parameter :: mpi_double_precision=3
      integer, parameter :: mpi_logical=4
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_byte=1
! 
!   allreduce operations
! 
      integer, parameter :: mpi_sum=1
      integer, parameter :: mpi_max=2
      integer, parameter :: mpi_min=3
      integer, parameter :: mpi_product=4
! 
!   timer
! 
      real(kind=8) :: mpi_wtime
! 
!   I/O
! 
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_wronly=4
      integer, intent(In) :: n
      real(kind=8), dimension(1:n), intent(In) :: data1
      real(kind=8), dimension(1:n), intent(Out) :: data2
      integer :: i
      integer, intent(Out) :: ierror
      integer :: operation
      ierror = mpi_success
      do i = 1, n
        data2(i) = data1(i)
      end do
      return
      end subroutine mpi_reduce_double_precision
      subroutine mpi_reduce_integer8(data1,data2,n,operation,ierror)
! 
! *********************************************************************72
      implicit none
! 
!   Dummy parameters for MPI F77 stubs
! 
      integer, parameter :: mpi_comm_world=0
! 
!   Return values.
! 
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
! 
!   recv message status
! 
      integer, parameter :: mpi_status_size=3
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_count=3
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, parameter :: mpi_info_null=0
! 
!   recv flags
! 
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
! 
!   data types and sizes
! 
      integer, parameter :: mpi_integer=1
      integer, parameter :: mpi_integer8=6
      integer, parameter :: mpi_real=2
      integer, parameter :: mpi_double_precision=3
      integer, parameter :: mpi_logical=4
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_byte=1
! 
!   allreduce operations
! 
      integer, parameter :: mpi_sum=1
      integer, parameter :: mpi_max=2
      integer, parameter :: mpi_min=3
      integer, parameter :: mpi_product=4
! 
!   timer
! 
      real(kind=8) :: mpi_wtime
! 
!   I/O
! 
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_wronly=4
      integer, intent(In) :: n
      integer(kind=8), dimension(1:n), intent(In) :: data1
      integer(kind=8), dimension(1:n), intent(Out) :: data2
      integer :: i
      integer, intent(Out) :: ierror
      integer :: operation
      ierror = mpi_success
      do i = 1, n
         data2(i) = data1(i)
      end do
      ierror = mpi_failure
      return
      end subroutine mpi_reduce_integer8
      subroutine mpi_reduce_integer(data1,data2,n,operation,ierror)
! 
! *********************************************************************72
      implicit none
! 
!   Dummy parameters for MPI F77 stubs
! 
      integer, parameter :: mpi_comm_world=0
! 
!   Return values.
! 
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
! 
!   recv message status
! 
      integer, parameter :: mpi_status_size=3
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_count=3
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, parameter :: mpi_info_null=0
! 
!   recv flags
! 
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
! 
!   data types and sizes
! 
      integer, parameter :: mpi_integer=1
      integer, parameter :: mpi_integer8=6
      integer, parameter :: mpi_real=2
      integer, parameter :: mpi_double_precision=3
      integer, parameter :: mpi_logical=4
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_byte=1
! 
!   allreduce operations
! 
      integer, parameter :: mpi_sum=1
      integer, parameter :: mpi_max=2
      integer, parameter :: mpi_min=3
      integer, parameter :: mpi_product=4
! 
!   timer
! 
      real(kind=8) :: mpi_wtime
! 
!   I/O
! 
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_wronly=4
      integer, intent(In) :: n
      integer, dimension(1:n), intent(In) :: data1
      integer, dimension(1:n), intent(Out) :: data2
      integer :: i
      integer, intent(Out) :: ierror
      integer :: operation
      ierror = mpi_success
      do i = 1, n
         data2(i) = data1(i)
      end do
      ierror = mpi_failure
      return
      end subroutine mpi_reduce_integer
      subroutine mpi_reduce_real(data1,data2,n,operation,ierror)
! 
! *********************************************************************72
! 
! c MPI_REDUCE_REAL carries out a reduction operation on reals.
! 
!   Discussion:
      implicit none
! 
!   Dummy parameters for MPI F77 stubs
! 
      integer, parameter :: mpi_comm_world=0
! 
!   Return values.
! 
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
! 
!   recv message status
! 
      integer, parameter :: mpi_status_size=3
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_count=3
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, parameter :: mpi_info_null=0
! 
!   recv flags
! 
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
! 
!   data types and sizes
! 
      integer, parameter :: mpi_integer=1
      integer, parameter :: mpi_integer8=6
      integer, parameter :: mpi_real=2
      integer, parameter :: mpi_double_precision=3
      integer, parameter :: mpi_logical=4
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_byte=1
! 
!   allreduce operations
! 
      integer, parameter :: mpi_sum=1
      integer, parameter :: mpi_max=2
      integer, parameter :: mpi_min=3
      integer, parameter :: mpi_product=4
! 
!   timer
! 
      real(kind=8) :: mpi_wtime
! 
!   I/O
! 
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_wronly=4
      integer, intent(In) :: n
      real, dimension(1:n), intent(In) :: data1
      real, dimension(1:n), intent(Out) :: data2
      integer :: i
      integer, intent(Out) :: ierror
      integer :: operation
      ierror = mpi_success
        do i = 1, n
          data2(i) = data1(i)
        end do
      return
      end subroutine mpi_reduce_real
      real(kind=8) function mpi_wtime()
! *********************************************************************72
! 
! c MPI_WTIME returns the elapsed wall clock time.
! 
      implicit none
      real(kind=4), dimension(1:2) :: a
      real(kind=4) :: etime
      a(1)=0.0
      a(2)=0.0
      mpi_wtime = etime(a)
      return
      end function mpi_wtime

end module singleton_module_src_mpi_dummy


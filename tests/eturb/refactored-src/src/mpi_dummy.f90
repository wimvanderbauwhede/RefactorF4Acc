module singleton_module_src_mpi_dummy

contains

      subroutine mpi_allreduce(data1,data2,n,datatype,operation,comm,ierror)
      implicit none
      integer, intent(In) :: n
      integer :: comm
      integer, dimension(1:n), intent(In) :: data1
      integer, dimension(1:n), intent(InOut) :: data2
      integer, intent(In) :: datatype
      integer, intent(Out) :: ierror
      integer, intent(In) :: operation
      ierror = mpi_success
      if ( datatype  ==  mpi_double_precision ) then
        call mpi_reduce_double_precision(real(data1,8),real(data2,8),n,operation,ierror)
      else if ( datatype  ==  mpi_integer ) then
        call mpi_reduce_integer(data1,data2,n,operation,ierror)
      else if ( datatype  ==  mpi_integer8 ) then
        call mpi_reduce_integer8(data1,data2,n,operation,ierror)
      else if ( datatype  ==  mpi_real ) then
        call mpi_reduce_real(real(data1,4),real(data2,4),n,operation,ierror)
      else
        ierror = mpi_failure
      end if
      return
      end subroutine mpi_allreduce
      subroutine mpi_barrier(comm,ierror)
      implicit none
      integer :: comm
      integer, intent(Out) :: ierror
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
      ierror = mpi_failure
      return
      end subroutine mpi_barrier
      subroutine mpi_finalize(ierror)
      implicit none
      integer, intent(Out) :: ierror
      integer, parameter :: mpi_failure=1
      integer, parameter :: mpi_success=0
      ierror = mpi_success
      return
      end subroutine mpi_finalize
      subroutine mpi_reduce_double_precision(data1,data2,n,operation,ierror)
      implicit none
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
      implicit none
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
      implicit none
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
      implicit none
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
      real *kind=8 function mpi_wtime()
      implicit none
      real(kind=4), dimension(1:2) :: a
      real(kind=4) :: etime
      a(1)=0.0
      a(2)=0.0
      mpi_wtime = etime(a)
      return
      end function mpi_wtime

end module singleton_module_src_mpi_dummy


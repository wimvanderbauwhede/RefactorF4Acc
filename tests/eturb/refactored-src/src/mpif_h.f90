module mpif_h
      use params_mpif_h, only : mpi_status_size
! $COPYRIGHT$
! $HEADER$

! $COPYRIGHT$
! $HEADER$

! $COPYRIGHT$
! $HEADER$

! $COPYRIGHT$
! $HEADER$

! $COPYRIGHT$
! $HEADER$

! $COPYRIGHT$
! $HEADER$

! $COPYRIGHT$
! $HEADER$

      external mpi_null_copy_fn, mpi_null_delete_fn
      external mpi_comm_null_copy_fn, mpi_comm_null_delete_fn
      external mpi_type_null_copy_fn, mpi_type_null_delete_fn
      external mpi_dup_fn, mpi_comm_dup_fn, mpi_type_dup_fn
      external mpi_win_null_copy_fn
      external mpi_win_null_delete_fn
      external mpi_win_dup_fn
      external mpi_conversion_fn_null

      external mpi_wtime, mpi_wtick , pmpi_wtick, pmpi_wtime
      real(kind=8) :: mpi_wtime
      real(kind=8) :: mpi_wtick
      real(kind=8) :: pmpi_wtick
      real(kind=8) :: pmpi_wtime
      external mpi_aint_add, mpi_aint_diff
      integer :: mpi_aint_add
      integer :: mpi_aint_diff
! $COPYRIGHT$
! $HEADER$

      integer :: mpi_bottom
      integer :: mpi_in_place
      character, dimension(1:1) :: mpi_argv_null
      character, dimension(1:1,1:1) :: mpi_argvs_null
      integer, dimension(1:1) :: mpi_errcodes_ignore
      integer, dimension(1:mpi_status_size) :: mpi_status_ignore
      integer, dimension(1:mpi_status_size,1:1) :: mpi_statuses_ignore
      integer, dimension(1:1) :: mpi_unweighted
      integer, dimension(1:1) :: mpi_weights_empty

! $COPYRIGHT$

      interface mpi_sizeof

end module mpif_h

module singleton_module_src_comm_mpi

      use singleton_module_src_singlmesh
      use singleton_module_src_math
      use singleton_module_src_papi
      use singleton_module_src_subs1
      use singleton_module_src_mpi_dummy
contains

      subroutine gop(x,w,op,n)
      implicit none
      real(kind=8) :: tmxmf
      real(kind=8) :: tmxms
      real(kind=8) :: tdsum
      real(kind=8) :: taxhm
      real(kind=8) :: tcopy
      real(kind=8) :: tinvc
      real(kind=8) :: tinv3
      real(kind=8) :: tinit
      real(kind=8) :: tadc3
      real(kind=8) :: tcol3
      real(kind=8) :: ta2s2
      real(kind=8) :: tcol2
      real(kind=8) :: tadd2
      real(kind=8) :: tsolv
      real(kind=8) :: tgsum
      real(kind=8) :: tdsnd
      real(kind=8) :: tdadd
      real(kind=8) :: tcdtp
      real(kind=8) :: tmltd
      real(kind=8) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: thmhz
      real(kind=8), intent(Out) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tdott
      real(kind=8) :: tbsol
      real(kind=8) :: tbso2
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tusbc
      real(kind=8) :: tddsl
      real(kind=8) :: tcrsl
      real(kind=8) :: tdsmx
      real(kind=8) :: tdsmn
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: teslv
      real(kind=8) :: tbbbb
      real(kind=8) :: tcccc
      real(kind=8) :: tdddd
      real(kind=8) :: teeee
      real(kind=8) :: tvdss
      real(kind=8) :: tschw
      real(kind=8) :: tadvc
      real(kind=8) :: tspro
      real(kind=8) :: tgop_sync
      real(kind=8) :: tsyc
      real(kind=8) :: twal
      real(kind=8) :: tgp2
      real(kind=8) :: tcvf
      real(kind=8) :: tproj
      real(kind=8) :: tusfq
      integer :: nmxmf
      integer :: nmxms
      integer :: ndsum
      integer :: naxhm
      integer :: ncopy
      integer :: ninvc
      integer :: ninv3
      integer :: nsolv
      integer :: ngsum
      integer :: ndsnd
      integer :: ndadd
      integer :: ncdtp
      integer :: nmltd
      integer :: nprep
      integer :: npres
      integer :: nhmhz
      integer, intent(InOut) :: ngop
      integer :: ngop1
      integer :: ndott
      integer :: nbsol
      integer :: nbso2
      integer :: nsett
      integer :: nslvb
      integer :: nusbc
      integer :: nddsl
      integer :: ncrsl
      integer :: ndsmx
      integer :: ndsmn
      integer :: ngsmn
      integer :: ngsmx
      integer :: neslv
      integer :: nbbbb
      integer :: ncccc
      integer :: ndddd
      integer :: neeee
      integer :: nvdss
      integer :: nadvc
      integer :: nspro
      integer :: ngop_sync
      integer :: nsyc
      integer :: nwal
      integer :: ngp2
      integer :: ncvf
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pdsum
      real(kind=8) :: paxhm
      real(kind=8) :: pcopy
      real(kind=8) :: pinvc
      real(kind=8) :: pinv3
      real(kind=8) :: psolv
      real(kind=8) :: pgsum
      real(kind=8) :: pdsnd
      real(kind=8) :: pdadd
      real(kind=8) :: pcdtp
      real(kind=8) :: pmltd
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real(kind=8) :: phmhz
      real(kind=8) :: pgop
      real(kind=8) :: pgop1
      real(kind=8) :: pdott
      real(kind=8) :: pbsol
      real(kind=8) :: pbso2
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: pusbc
      real(kind=8) :: pddsl
      real(kind=8) :: pcrsl
      real(kind=8) :: pdsmx
      real(kind=8) :: pdsmn
      real(kind=8) :: pgsmn
      real(kind=8) :: pgsmx
      real(kind=8) :: peslv
      real(kind=8) :: pbbbb
      real(kind=8) :: pcccc
      real(kind=8) :: pdddd
      real(kind=8) :: peeee
      real(kind=8) :: pvdss
      real(kind=8) :: pspro
      real(kind=8) :: pgop_sync
      real(kind=8) :: psyc
      real(kind=8) :: pwal
      real(kind=8) :: pgp2
      real(kind=8) :: etime1
      real(kind=8) :: etime2
      real(kind=8) :: etime0
      real(kind=8) :: gtime1
      real(kind=8) :: tscrtch
      real(kind=8) :: etimes
      real(kind=8) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: etims0
      real(kind=8) :: ttime
      integer :: icalld
      save    icalld
      data icalld / 0 / 
      logical, intent(In) :: ifsync
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
      real, dimension(1:n), intent(InOut) :: x
      real, dimension(1:n), intent(InOut) :: w
      character(len=3), intent(In) :: op
      if (ifsync) call nekgsync()
#ifdef TIMER
      if (icalld == 0) then
        tgop =0.0d0
        ngop =0
        icalld=1
      endif
      ngop = ngop + 1
      etime1=dnekclock()
#endif
      if (op == '+  ') then
         call mpi_allreduce (x,w,n,nekreal,mpi_sum ,nekcomm,ierr)
      elseif (op == 'M  ') then
         call mpi_allreduce (x,w,n,nekreal,mpi_max ,nekcomm,ierr)
      elseif (op == 'm  ') then
         call mpi_allreduce (x,w,n,nekreal,mpi_min ,nekcomm,ierr)
      elseif (op == '*  ') then
         call mpi_allreduce (x,w,n,nekreal,mpi_prod,nekcomm,ierr)
      else
         write(6,*) nid,' OP ',op,' not supported.  ABORT in GOP.'
         call exitt
      endif
      call copy(x,w,n)
#ifdef TIMER
      tgop =tgop +(dnekclock()-etime1)
#endif
      return
      end subroutine gop
      subroutine igop(x,w,op,n)
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
      implicit none
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
      integer, dimension(1:n), intent(InOut) :: x
      integer, dimension(1:n), intent(InOut) :: w
      character(len=3), intent(In) :: op
      if     (op == '+  ') then
        call mpi_allreduce (x,w,n,mpi_integer,mpi_sum ,nekcomm,ierr)
      elseif (op == 'M  ') then
        call mpi_allreduce (x,w,n,mpi_integer,mpi_max ,nekcomm,ierr)
      elseif (op == 'm  ') then
        call mpi_allreduce (x,w,n,mpi_integer,mpi_min ,nekcomm,ierr)
      elseif (op == '*  ') then
        call mpi_allreduce (x,w,n,mpi_integer,mpi_prod,nekcomm,ierr)
      else
        write(6,*) nid,' OP ',op,' not supported.  ABORT in igop.'
        call exitt
      endif
      call icopy(x,w,n)
      return
      end subroutine igop
      real *8 function dnekclock()
      implicit none
      integer, parameter :: ompi_major_version=4
      integer, parameter :: ompi_minor_version=0
      integer, parameter :: ompi_release_version=1
      integer, parameter :: mpi_integer_kind=4
      integer, parameter :: mpi_address_kind=8
      integer, parameter :: mpi_offset_kind=8
      integer, parameter :: mpi_count_kind=8
      integer, parameter :: mpi_status_size=6
      integer, parameter :: mpi_max_processor_name=256-1
      integer, parameter :: mpi_max_error_string=256-1
      integer, parameter :: mpi_max_object_name=64-1
      integer, parameter :: mpi_max_library_version_string=256-1
      integer, parameter :: mpi_max_info_key=36-1
      integer, parameter :: mpi_max_info_val=256-1
      integer, parameter :: mpi_max_port_name=1024-1
      integer, parameter :: mpi_max_datarep_string=128-1
      logical, parameter :: mpi_subarrays_supported=.false.
      logical, parameter :: mpi_async_protects_nonblocking=.false.
      integer, parameter :: mpi_any_source=-1
      integer, parameter :: mpi_any_tag=-1
      integer, parameter :: mpi_appnum=4
      integer, parameter :: mpi_bsend_overhead=128
      integer, parameter :: mpi_cart=1
      integer, parameter :: mpi_combiner_contiguous=2
      integer, parameter :: mpi_combiner_darray=13
      integer, parameter :: mpi_combiner_dup=1
      integer, parameter :: mpi_combiner_f90_complex=15
      integer, parameter :: mpi_combiner_f90_integer=16
      integer, parameter :: mpi_combiner_f90_real=14
      integer, parameter :: mpi_combiner_hindexed=8
      integer, parameter :: mpi_combiner_hindexed_block=18
      integer, parameter :: mpi_combiner_hindexed_integer=7
      integer, parameter :: mpi_combiner_hvector=5
      integer, parameter :: mpi_combiner_hvector_integer=4
      integer, parameter :: mpi_combiner_indexed=6
      integer, parameter :: mpi_combiner_indexed_block=9
      integer, parameter :: mpi_combiner_named=0
      integer, parameter :: mpi_combiner_resized=17
      integer, parameter :: mpi_combiner_struct=11
      integer, parameter :: mpi_combiner_struct_integer=10
      integer, parameter :: mpi_combiner_subarray=12
      integer, parameter :: mpi_combiner_vector=3
      integer, parameter :: mpi_comm_type_shared=0
      integer, parameter :: mpi_congruent=1
      integer, parameter :: mpi_distribute_block=0
      integer, parameter :: mpi_distribute_cyclic=1
      integer, parameter :: mpi_distribute_dflt_darg=-1
      integer, parameter :: mpi_distribute_none=2
      integer, parameter :: mpi_dist_graph=3
      integer, parameter :: mpi_error=3
      integer, parameter :: mpi_err_access=20
      integer, parameter :: mpi_err_amode=21
      integer, parameter :: mpi_err_arg=13
      integer, parameter :: mpi_err_assert=22
      integer, parameter :: mpi_err_bad_file=23
      integer, parameter :: mpi_err_base=24
      integer, parameter :: mpi_err_buffer=1
      integer, parameter :: mpi_err_comm=5
      integer, parameter :: mpi_err_conversion=25
      integer, parameter :: mpi_err_count=2
      integer, parameter :: mpi_err_dims=12
      integer, parameter :: mpi_err_disp=26
      integer, parameter :: mpi_err_dup_datarep=27
      integer, parameter :: mpi_err_file=30
      integer, parameter :: mpi_err_file_exists=28
      integer, parameter :: mpi_err_file_in_use=29
      integer, parameter :: mpi_err_group=9
      integer, parameter :: mpi_err_info=34
      integer, parameter :: mpi_err_info_key=31
      integer, parameter :: mpi_err_info_nokey=32
      integer, parameter :: mpi_err_info_value=33
      integer, parameter :: mpi_err_intern=17
      integer, parameter :: mpi_err_in_status=18
      integer, parameter :: mpi_err_io=35
      integer, parameter :: mpi_err_keyval=36
      integer, parameter :: mpi_err_lastcode=92
      integer, parameter :: mpi_err_locktype=37
      integer, parameter :: mpi_err_name=38
      integer, parameter :: mpi_err_not_same=40
      integer, parameter :: mpi_err_no_mem=39
      integer, parameter :: mpi_err_no_space=41
      integer, parameter :: mpi_err_no_such_file=42
      integer, parameter :: mpi_err_op=10
      integer, parameter :: mpi_err_other=16
      integer, parameter :: mpi_err_pending=19
      integer, parameter :: mpi_err_port=43
      integer, parameter :: mpi_err_quota=44
      integer, parameter :: mpi_err_rank=6
      integer, parameter :: mpi_err_read_only=45
      integer, parameter :: mpi_err_request=7
      integer, parameter :: mpi_err_rma_attach=69
      integer, parameter :: mpi_err_rma_conflict=46
      integer, parameter :: mpi_err_rma_flavor=70
      integer, parameter :: mpi_err_rma_range=68
      integer, parameter :: mpi_err_rma_shared=71
      integer, parameter :: mpi_err_rma_sync=47
      integer, parameter :: mpi_err_root=8
      integer, parameter :: mpi_err_service=48
      integer, parameter :: mpi_err_size=49
      integer, parameter :: mpi_err_spawn=50
      integer, parameter :: mpi_err_tag=4
      integer, parameter :: mpi_err_topology=11
      integer, parameter :: mpi_err_truncate=15
      integer, parameter :: mpi_err_type=3
      integer, parameter :: mpi_err_unknown=14
      integer, parameter :: mpi_err_unsupported_datarep=51
      integer, parameter :: mpi_err_unsupported_operation=52
      integer, parameter :: mpi_err_win=53
      integer, parameter :: mpi_graph=2
      integer, parameter :: mpi_host=1
      integer, parameter :: mpi_ident=0
      integer, parameter :: mpi_io=2
      integer, parameter :: mpi_keyval_invalid=-1
      integer, parameter :: mpi_lastusedcode=5
      integer, parameter :: mpi_lock_exclusive=1
      integer, parameter :: mpi_lock_shared=2
      integer, parameter :: mpi_mode_nocheck=1
      integer, parameter :: mpi_mode_noprecede=2
      integer, parameter :: mpi_mode_noput=4
      integer, parameter :: mpi_mode_nostore=8
      integer, parameter :: mpi_mode_nosucceed=16
      integer, parameter :: mpi_order_c=0
      integer, parameter :: mpi_order_fortran=1
      integer, parameter :: mpi_proc_null=-2
      integer, parameter :: mpi_root=-4
      integer, parameter :: mpi_similar=2
      integer, parameter :: mpi_source=1
      integer, parameter :: mpi_subversion=1
      integer, parameter :: mpi_success=0
      integer, parameter :: mpi_tag=2
      integer, parameter :: mpi_tag_ub=0
      integer, parameter :: mpi_thread_funneled=1
      integer, parameter :: mpi_thread_multiple=3
      integer, parameter :: mpi_thread_serialized=2
      integer, parameter :: mpi_thread_single=0
      integer, parameter :: mpi_typeclass_complex=3
      integer, parameter :: mpi_typeclass_integer=1
      integer, parameter :: mpi_typeclass_real=2
      integer, parameter :: mpi_t_err_cannot_init=56
      integer, parameter :: mpi_t_err_cvar_set_never=64
      integer, parameter :: mpi_t_err_cvar_set_not_now=63
      integer, parameter :: mpi_t_err_invalid=72
      integer, parameter :: mpi_t_err_invalid_handle=59
      integer, parameter :: mpi_t_err_invalid_index=57
      integer, parameter :: mpi_t_err_invalid_item=58
      integer, parameter :: mpi_t_err_invalid_session=62
      integer, parameter :: mpi_t_err_memory=54
      integer, parameter :: mpi_t_err_not_initialized=55
      integer, parameter :: mpi_t_err_out_of_handles=60
      integer, parameter :: mpi_t_err_out_of_sessions=61
      integer, parameter :: mpi_t_err_pvar_no_atomic=67
      integer, parameter :: mpi_t_err_pvar_no_startstop=65
      integer, parameter :: mpi_t_err_pvar_no_write=66
      integer, parameter :: mpi_undefined=-32766
      integer, parameter :: mpi_unequal=3
      integer, parameter :: mpi_universe_size=6
      integer, parameter :: mpi_version=3
      integer, parameter :: mpi_win_base=7
      integer, parameter :: mpi_win_create_flavor=10
      integer, parameter :: mpi_win_disp_unit=9
      integer, parameter :: mpi_win_flavor_allocate=2
      integer, parameter :: mpi_win_flavor_create=1
      integer, parameter :: mpi_win_flavor_dynamic=3
      integer, parameter :: mpi_win_flavor_shared=4
      integer, parameter :: mpi_win_model=11
      integer, parameter :: mpi_win_separate=1
      integer, parameter :: mpi_win_size=8
      integer, parameter :: mpi_win_unified=0
      integer, parameter :: mpi_wtime_is_global=3
      integer, parameter :: ompi_comm_type_board=8
      integer, parameter :: ompi_comm_type_cluster=11
      integer, parameter :: ompi_comm_type_core=2
      integer, parameter :: ompi_comm_type_cu=10
      integer, parameter :: ompi_comm_type_host=9
      integer, parameter :: ompi_comm_type_hwthread=1
      integer, parameter :: ompi_comm_type_l1cache=3
      integer, parameter :: ompi_comm_type_l2cache=4
      integer, parameter :: ompi_comm_type_l3cache=5
      integer, parameter :: ompi_comm_type_node=0
      integer, parameter :: ompi_comm_type_numa=7
      integer, parameter :: ompi_comm_type_socket=6
      integer, parameter :: mpi_2complex=26
      integer, parameter :: mpi_2double_complex=27
      integer, parameter :: mpi_2double_precision=24
      integer, parameter :: mpi_2int=52
      integer, parameter :: mpi_2integer=25
      integer, parameter :: mpi_2real=23
      integer, parameter :: mpi_aint=66
      integer, parameter :: mpi_band=6
      integer, parameter :: mpi_bor=8
      integer, parameter :: mpi_bxor=10
      integer, parameter :: mpi_byte=1
      integer, parameter :: mpi_char=34
      integer, parameter :: mpi_character=5
      integer, parameter :: mpi_comm_null=2
      integer, parameter :: mpi_comm_self=1
      integer, parameter :: mpi_comm_world=0
      integer, parameter :: mpi_complex=18
      integer, parameter :: mpi_complex16=20
      integer, parameter :: mpi_complex32=21
      integer, parameter :: mpi_complex8=19
      integer, parameter :: mpi_count=72
      integer, parameter :: mpi_cxx_bool=54
      integer, parameter :: mpi_cxx_complex=55
      integer, parameter :: mpi_cxx_double_complex=56
      integer, parameter :: mpi_cxx_float_complex=55
      integer, parameter :: mpi_cxx_long_double_complex=57
      integer, parameter :: mpi_c_bool=68
      integer, parameter :: mpi_c_complex=69
      integer, parameter :: mpi_c_double_complex=70
      integer, parameter :: mpi_c_float_complex=69
      integer, parameter :: mpi_c_long_double_complex=71
      integer, parameter :: mpi_datatype_null=0
      integer, parameter :: mpi_double=46
      integer, parameter :: mpi_double_complex=22
      integer, parameter :: mpi_double_int=49
      integer, parameter :: mpi_double_precision=17
      integer, parameter :: mpi_errhandler_null=0
      integer, parameter :: mpi_errors_are_fatal=1
      integer, parameter :: mpi_errors_return=2
      integer, parameter :: mpi_float=45
      integer, parameter :: mpi_float_int=48
      integer, parameter :: mpi_group_empty=1
      integer, parameter :: mpi_group_null=0
      integer, parameter :: mpi_info_env=1
      integer, parameter :: mpi_info_null=0
      integer, parameter :: mpi_int=39
      integer, parameter :: mpi_int16_t=60
      integer, parameter :: mpi_int32_t=62
      integer, parameter :: mpi_int64_t=64
      integer, parameter :: mpi_int8_t=58
      integer, parameter :: mpi_integer=7
      integer, parameter :: mpi_integer1=8
      integer, parameter :: mpi_integer16=12
      integer, parameter :: mpi_integer2=9
      integer, parameter :: mpi_integer4=10
      integer, parameter :: mpi_integer8=11
      integer, parameter :: mpi_land=5
      integer, parameter :: mpi_lb=4
      integer, parameter :: mpi_logical=6
      integer, parameter :: mpi_logical1=29
      integer, parameter :: mpi_logical2=30
      integer, parameter :: mpi_logical4=31
      integer, parameter :: mpi_logical8=32
      integer, parameter :: mpi_long=41
      integer, parameter :: mpi_long_double=47
      integer, parameter :: mpi_long_double_int=50
      integer, parameter :: mpi_long_int=51
      integer, parameter :: mpi_long_long=43
      integer, parameter :: mpi_long_long_int=43
      integer, parameter :: mpi_lor=7
      integer, parameter :: mpi_lxor=9
      integer, parameter :: mpi_max=1
      integer, parameter :: mpi_maxloc=11
      integer, parameter :: mpi_message_no_proc=1
      integer, parameter :: mpi_message_null=0
      integer, parameter :: mpi_min=2
      integer, parameter :: mpi_minloc=12
      integer, parameter :: mpi_no_op=14
      integer, parameter :: mpi_offset=67
      integer, parameter :: mpi_op_null=0
      integer, parameter :: mpi_packed=2
      integer, parameter :: mpi_prod=4
      integer, parameter :: mpi_real=13
      integer, parameter :: mpi_real16=16
      integer, parameter :: mpi_real2=28
      integer, parameter :: mpi_real4=14
      integer, parameter :: mpi_real8=15
      integer, parameter :: mpi_replace=13
      integer, parameter :: mpi_request_null=0
      integer, parameter :: mpi_short=37
      integer, parameter :: mpi_short_int=53
      integer, parameter :: mpi_signed_char=36
      integer, parameter :: mpi_sum=3
      integer, parameter :: mpi_ub=3
      integer, parameter :: mpi_uint16_t=61
      integer, parameter :: mpi_uint32_t=63
      integer, parameter :: mpi_uint64_t=65
      integer, parameter :: mpi_uint8_t=59
      integer, parameter :: mpi_unsigned=40
      integer, parameter :: mpi_unsigned_char=35
      integer, parameter :: mpi_unsigned_long=42
      integer, parameter :: mpi_unsigned_long_long=44
      integer, parameter :: mpi_unsigned_short=38
      integer, parameter :: mpi_wchar=33
      integer, parameter :: mpi_win_null=0
      integer, parameter :: mpi_mode_append=128
      integer, parameter :: mpi_mode_create=1
      integer, parameter :: mpi_mode_delete_on_close=16
      integer, parameter :: mpi_mode_excl=64
      integer, parameter :: mpi_mode_rdonly=2
      integer, parameter :: mpi_mode_rdwr=8
      integer, parameter :: mpi_mode_sequential=256
      integer, parameter :: mpi_mode_unique_open=32
      integer, parameter :: mpi_mode_wronly=4
      integer, parameter :: mpi_seek_cur=602
      integer, parameter :: mpi_seek_end=604
      integer, parameter :: mpi_seek_set=600
      integer, parameter :: mpi_displacement_current=-54278278
      integer, parameter :: mpi_file_null=0
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
      dnekclock=mpi_wtime()
      return
      end function dnekclock
      real *8 function dnekclock_sync()
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
      implicit none
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
      call nekgsync()
      dnekclock_sync=mpi_wtime()
      return
      end function dnekclock_sync
      subroutine nekgsync()
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
      implicit none
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
      call mpi_barrier(nekcomm,ierr)
      return
      end subroutine nekgsync
      subroutine exitt()
      implicit none
      integer :: nio
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer :: nelt
      integer :: nfield
      integer :: npert
      integer, intent(In) :: nid
      integer :: idsess
      integer :: nx1
      integer :: ny1
      integer :: nz1
      integer :: nx2
      integer :: ny2
      integer :: nz2
      integer :: nx3
      integer :: ny3
      integer :: nz3
      integer :: nxd
      integer :: nyd
      integer :: nzd
      integer :: ndim
      integer :: ldimr
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz3,1:lz3) :: dztm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real :: eigas
      real :: eigaa
      real :: eigast
      real :: eigae
      real :: eigga
      real :: eiggs
      real :: eiggst
      real :: eigge
      logical :: ifaa
      logical :: ifae
      logical :: ifas
      logical :: ifast
      logical :: ifga
      logical :: ifge
      logical :: ifgs
      logical :: ifgst
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
      real, dimension(1:200) :: param
      real :: rstim
      real :: vnekton
      real, dimension(1:ldimt1,1:3) :: cpfld
      real, dimension(-5:10,1:ldimt1,1:3) :: cpgrp
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:20) :: uparam
      real, dimension(0:ldimt1) :: atol
      real, dimension(0:ldimt1) :: restol
      real :: filtertype
      integer, dimension(-5:10,1:ldimt1) :: matype
      integer :: nktonv
      integer :: nhis
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer :: ipscal
      integer :: npscal
      integer :: ipsco
      integer :: ifldmhd
      integer :: irstv
      integer :: irstt
      integer :: irstim
      integer, dimension(1:maxobj) :: nmember
      integer :: nobj
      integer :: ngeom
      integer, dimension(1:ldimt) :: idpss
      logical :: if3d
      logical :: ifflow
      logical :: ifheat
      logical :: iftran
      logical :: ifaxis
      logical :: ifstrs
      logical :: ifsplit
      logical :: ifmgrid
      logical, dimension(1:ldimt1) :: ifadvc
      logical, dimension(1:ldimt1) :: ifdiff
      logical, dimension(1:ldimt1) :: ifdeal
      logical, dimension(0:ldimt1) :: ifprojfld
      logical, dimension(0:ldimt1) :: iftmsh
      logical, dimension(0:ldimt1) :: ifdgfld
      logical :: ifdg
      logical :: ifmvbd
      logical :: ifchar
      logical, dimension(1:ldimt1) :: ifnonl
      logical, dimension(1:ldimt1) :: ifvarp
      logical, dimension(1:ldimt1) :: ifpsco
      logical :: ifvps
      logical :: ifmodel
      logical :: ifkeps
      logical :: ifintq
      logical :: ifcons
      logical :: ifxyo
      logical :: ifpo
      logical :: ifvo
      logical :: ifto
      logical :: iftgo
      logical, dimension(1:ldimt1) :: ifpso
      logical :: iffmtin
      logical :: ifbo
      logical :: ifanls
      logical :: ifanl2
      logical :: ifmhd
      logical :: ifessr
      logical :: ifpert
      logical :: ifbase
      logical :: ifcvode
      logical :: iflomach
      logical :: ifexplvis
      logical :: ifschclob
      logical :: ifuservp
      logical :: ifcyclic
      logical :: ifmoab
      logical :: ifcoup
      logical :: ifvcoup
      logical :: ifusermv
      logical :: ifreguo
      logical :: ifxyo_
      logical :: ifaziv
      logical, intent(In) :: ifneknek
      logical :: ifneknekm
      logical, dimension(1:ldimt1) :: ifcvfld
      logical :: ifdp0dt
      logical :: ifmpiio
      logical :: ifrich
      logical :: ifnav
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
      integer, dimension(1:lelt) :: ieact
      integer :: neact
      integer :: numflu
      integer :: numoth
      integer :: numbcs
      integer, dimension(1:numsts) :: matindx
      integer, dimension(1:numsts) :: matids
      integer, dimension(1:lelt) :: imatie
      integer, dimension(1:numsts) :: ibcsts
      integer, dimension(1:numsts) :: bcf
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly3,1:ly1) :: iatm31
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly3,1:ly1) :: ictm31
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real :: volvm1
      real :: volvm2
      real :: voltm1
      real :: voltm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
      integer :: node
      integer :: pid
      integer, intent(In) :: np
      integer :: nullpid
      integer :: node0
      integer(kind=8), intent(In) :: nvtot
      integer, dimension(0:ldimt1) :: nelg
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer :: nelgv
      integer :: nelgt
      logical :: ifgprnt
      integer :: wdsize
      integer :: isize
      integer :: lsize
      integer :: csize
      integer :: wdsizi
      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth
      logical :: ifgsh_fld_same
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      integer :: ndg_facex
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real :: nu_star
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real :: p0th
      real :: dp0thdt
      real :: gamma0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      integer :: jp
      real, dimension(1:ldimt1) :: tauss
      real, dimension(1:ldimt1) :: txnext
      integer :: nsskip
      logical :: ifskip
      logical :: ifmodp
      logical :: ifssvt
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifexvt
      logical, dimension(1:ldimt1) :: ifextr
      real :: dvnnh1
      real :: dvnnsm
      real :: dvnnl2
      real :: dvnnl8
      real :: dvdfh1
      real :: dvdfsm
      real :: dvdfl2
      real :: dvdfl8
      real :: dvprh1
      real :: dvprsm
      real :: dvprl2
      real :: dvprl8
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
      real :: time
      real :: timef
      real :: fintim
      real :: timeio
      real :: dt
      real, dimension(1:10) :: dtlag
      real :: dtinit
      real :: dtinvm
      real :: courno
      real :: ctarg
      real, dimension(1:10) :: ab
      real, dimension(1:10) :: bd
      real, dimension(1:10) :: abmsh
      real, dimension(1:ldimt1) :: avdiff
      real, dimension(1:ldimt1) :: avtran
      real, dimension(0:ldimt1) :: volfld
      real :: tolrel
      real :: tolabs
      real :: tolhdf
      real :: tolpdf
      real :: tolev
      real :: tolnl
      real :: prelax
      real :: tolps
      real :: tolhs
      real :: tolhr
      real :: tolhv
      real, dimension(1:ldimt1) :: tolht
      real :: tolhe
      real :: vnrmh1
      real :: vnrmsm
      real :: vnrml2
      real :: vnrml8
      real :: vmean
      real, dimension(1:ldimt) :: tnrmh1
      real, dimension(1:ldimt) :: tnrmsm
      real, dimension(1:ldimt) :: tnrml2
      real, dimension(1:ldimt) :: tnrml8
      real, dimension(1:ldimt) :: tmean
      integer :: ifield
      integer :: imesh
      integer, intent(In) :: istep
      integer :: nsteps
      integer :: iostep
      integer :: lastep
      integer :: iocomm
      integer :: instep
      integer :: nab
      integer :: nabmsh
      integer :: nbd
      integer :: nbdinp
      integer :: ntaubd
      integer :: nmxh
      integer :: nmxp
      integer :: nmxe
      integer :: nmxnl
      integer :: ninter
      integer, dimension(0:ldimt1) :: nelfld
      integer :: nconv
      integer :: nconv_max
      integer :: ioinfodmp
      real :: pi
      logical :: ifprnt
      logical :: if_full_pres
      logical :: ifoutfld
      real, dimension(1:3,1:lpert) :: lyap
      integer :: iesolv
      logical, dimension(1:lelv) :: ifalgn
      logical, dimension(1:lelv) :: ifrsxy
      real, dimension(1:lelv) :: volel
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:ly1) :: wym1
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:ly2) :: wym2
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      if (nid == 0) then
         write(6,*) ' '
         write(6,'(A)') 'an error occured: dying ...'
         write(6,*) ' '
      endif
      if (ifneknek.and.icall == 0) call happy_check(0)
      call print_runtime_info
      call nek_die(1) 
      return
      end subroutine exitt
      subroutine print_runtime_info()
      implicit none
      integer :: nio
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer :: nelt
      integer :: nfield
      integer :: npert
      integer, intent(In) :: nid
      integer :: idsess
      integer :: nx1
      integer :: ny1
      integer :: nz1
      integer :: nx2
      integer :: ny2
      integer :: nz2
      integer :: nx3
      integer :: ny3
      integer :: nz3
      integer :: nxd
      integer :: nyd
      integer :: nzd
      integer :: ndim
      integer :: ldimr
      real, dimension(1:lx1,1:lx1) :: dxm1
      real, dimension(1:lx2,1:lx1) :: dxm12
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly2,1:ly1) :: dym12
      real, dimension(1:lz1,1:lz1) :: dzm1
      real, dimension(1:lz2,1:lz1) :: dzm12
      real, dimension(1:lx1,1:lx1) :: dxtm1
      real, dimension(1:lx1,1:lx2) :: dxtm12
      real, dimension(1:ly1,1:ly1) :: dytm1
      real, dimension(1:ly1,1:ly2) :: dytm12
      real, dimension(1:lz1,1:lz1) :: dztm1
      real, dimension(1:lz1,1:lz2) :: dztm12
      real, dimension(1:lx3,1:lx3) :: dxm3
      real, dimension(1:lx3,1:lx3) :: dxtm3
      real, dimension(1:ly3,1:ly3) :: dym3
      real, dimension(1:ly3,1:ly3) :: dytm3
      real, dimension(1:lz3,1:lz3) :: dzm3
      real, dimension(1:lz3,1:lz3) :: dztm3
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      real, dimension(1:ly3,1:ly3) :: dcm3
      real, dimension(1:ly3,1:ly3) :: dctm3
      real, dimension(1:ly2,1:ly1) :: dcm12
      real, dimension(1:ly1,1:ly2) :: dctm12
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly2,1:ly1) :: dam12
      real, dimension(1:ly1,1:ly2) :: datm12
      real, dimension(1:ly3,1:ly3) :: dam3
      real, dimension(1:ly3,1:ly3) :: datm3
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vxd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vyd
      real, dimension(1:lxd,1:lyd,1:lzd,1:lelv) :: vzd
      real, dimension(1:lx1,1:lxd) :: imd1
      real, dimension(1:lxd,1:lx1) :: imd1t
      real, dimension(1:lxd,1:lx1) :: im1d
      real, dimension(1:lx1,1:lxd) :: im1dt
      real, dimension(1:lx1,1:lxd) :: pmd1
      real, dimension(1:lxd,1:lx1) :: pmd1t
      real :: eigas
      real :: eigaa
      real :: eigast
      real :: eigae
      real :: eigga
      real :: eiggs
      real :: eiggst
      real :: eigge
      logical :: ifaa
      logical :: ifae
      logical :: ifas
      logical :: ifast
      logical :: ifga
      logical :: ifge
      logical :: ifgs
      logical :: ifgst
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: xm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: ym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: zm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: jacm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sxm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: txm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: sym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tym2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: rzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: szm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: tzm2
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: jacm2
      real, dimension(1:lxd*lyd*lzd,1:ldim*ldim,1:lelv) :: rx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g1m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g2m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g3m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g4m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g5m1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: g6m1
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unr
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: uns
      real, dimension(1:lx1*lz1,1:6,1:lelt) :: unt
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t1z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2x
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2y
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: t2z
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1*lz1,1:2*ldim,1:lelt) :: etalph
      real :: dlam
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vny
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: vnz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v1z
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2x
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2y
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: v2z
      logical :: ifgeom
      logical :: ifgmsh3
      logical :: ifvcor
      logical :: ifsurt
      logical :: ifmelt
      logical :: ifwcno
      logical, dimension(1:lelt) :: ifrzer
      logical, dimension(1:2*ldim,1:lelv) :: ifqinp
      logical, dimension(1:2*ldim,1:lelv) :: ifeppm
      logical, dimension(0:1) :: iflmsf
      logical, dimension(0:1) :: iflmse
      logical, dimension(0:1) :: iflmsc
      logical, dimension(1:2*ldim,1:lelt,0:1) :: ifmsfc
      logical, dimension(1:12,1:lelt,0:1) :: ifmseg
      logical, dimension(1:8,1:lelt,0:1) :: ifmscr
      logical, dimension(1:8,1:lelt) :: ifnskp
      logical :: ifbcor
      real, dimension(1:200) :: param
      real :: rstim
      real :: vnekton
      real, dimension(1:ldimt1,1:3) :: cpfld
      real, dimension(-5:10,1:ldimt1,1:3) :: cpgrp
      real, dimension(1:ldimt3,1:maxobj) :: qinteg
      real, dimension(1:20) :: uparam
      real, dimension(0:ldimt1) :: atol
      real, dimension(0:ldimt1) :: restol
      real :: filtertype
      integer, dimension(-5:10,1:ldimt1) :: matype
      integer :: nktonv
      integer :: nhis
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer :: ipscal
      integer :: npscal
      integer :: ipsco
      integer :: ifldmhd
      integer :: irstv
      integer :: irstt
      integer :: irstim
      integer, dimension(1:maxobj) :: nmember
      integer :: nobj
      integer :: ngeom
      integer, dimension(1:ldimt) :: idpss
      logical :: if3d
      logical :: ifflow
      logical :: ifheat
      logical :: iftran
      logical :: ifaxis
      logical :: ifstrs
      logical :: ifsplit
      logical :: ifmgrid
      logical, dimension(1:ldimt1) :: ifadvc
      logical, dimension(1:ldimt1) :: ifdiff
      logical, dimension(1:ldimt1) :: ifdeal
      logical, dimension(0:ldimt1) :: ifprojfld
      logical, dimension(0:ldimt1) :: iftmsh
      logical, dimension(0:ldimt1) :: ifdgfld
      logical :: ifdg
      logical :: ifmvbd
      logical :: ifchar
      logical, dimension(1:ldimt1) :: ifnonl
      logical, dimension(1:ldimt1) :: ifvarp
      logical, dimension(1:ldimt1) :: ifpsco
      logical :: ifvps
      logical :: ifmodel
      logical :: ifkeps
      logical :: ifintq
      logical :: ifcons
      logical :: ifxyo
      logical :: ifpo
      logical :: ifvo
      logical :: ifto
      logical :: iftgo
      logical, dimension(1:ldimt1) :: ifpso
      logical :: iffmtin
      logical :: ifbo
      logical :: ifanls
      logical :: ifanl2
      logical :: ifmhd
      logical :: ifessr
      logical :: ifpert
      logical :: ifbase
      logical :: ifcvode
      logical :: iflomach
      logical :: ifexplvis
      logical :: ifschclob
      logical :: ifuservp
      logical :: ifcyclic
      logical :: ifmoab
      logical :: ifcoup
      logical :: ifvcoup
      logical :: ifusermv
      logical :: ifreguo
      logical :: ifxyo_
      logical :: ifaziv
      logical :: ifneknek
      logical :: ifneknekm
      logical, dimension(1:ldimt1) :: ifcvfld
      logical :: ifdp0dt
      logical :: ifmpiio
      logical :: ifrich
      logical :: ifnav
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      character(len=2), dimension(1:8) :: ocode
      character(len=10), dimension(1:5) :: drivc
      character(len=14) :: rstv
      character(len=14) :: rstt
      character(len=40), dimension(1:100,1:2) :: textsw
      character(len=132), dimension(1:15) :: initc
      character(len=40) :: turbmod
      character(len=132) :: reafle
      character(len=132) :: fldfle
      character(len=132) :: dmpfle
      character(len=132) :: hisfle
      character(len=132) :: schfle
      character(len=132) :: orefle
      character(len=132) :: nrefle
      character(len=132) :: session
      character(len=132) :: path
      character(len=132) :: re2fle
      character(len=132) :: parfle
      integer :: cr_re2
      integer :: fh_re2
      integer(kind=8) :: re2off_b
      real, dimension(1:8,1:lelt) :: xc
      real, dimension(1:8,1:lelt) :: yc
      real, dimension(1:8,1:lelt) :: zc
      real, dimension(1:5,1:6,1:lelt,0:ldimt1) :: bc
      real, dimension(1:6,1:12,1:lelt) :: curve
      real, dimension(1:lelt) :: cerror
      integer, dimension(1:lelt) :: igroup
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      character(len=1), dimension(1:12,1:lelt) :: ccurve
      character(len=1), dimension(1:6,1:lelt) :: cdof
      character(len=3), dimension(1:6,1:lelt,0:ldimt1) :: cbc
      character(len=3) :: solver_type
      integer, dimension(1:lelt) :: ieact
      integer :: neact
      integer :: numflu
      integer :: numoth
      integer :: numbcs
      integer, dimension(1:numsts) :: matindx
      integer, dimension(1:numsts) :: matids
      integer, dimension(1:lelt) :: imatie
      integer, dimension(1:numsts) :: ibcsts
      integer, dimension(1:numsts) :: bcf
      character(len=3), dimension(1:numsts) :: bctyps
      real, dimension(1:lx2,1:lx1) :: ixm12
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iym12
      real, dimension(1:ly1,1:ly2) :: iym21
      real, dimension(1:lz2,1:lz1) :: izm12
      real, dimension(1:lz1,1:lz2) :: izm21
      real, dimension(1:lx1,1:lx2) :: ixtm12
      real, dimension(1:lx2,1:lx1) :: ixtm21
      real, dimension(1:ly1,1:ly2) :: iytm12
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz1,1:lz2) :: iztm12
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx3,1:lx1) :: ixm13
      real, dimension(1:lx1,1:lx3) :: ixm31
      real, dimension(1:ly3,1:ly1) :: iym13
      real, dimension(1:ly1,1:ly3) :: iym31
      real, dimension(1:lz3,1:lz1) :: izm13
      real, dimension(1:lz1,1:lz3) :: izm31
      real, dimension(1:lx1,1:lx3) :: ixtm13
      real, dimension(1:lx3,1:lx1) :: ixtm31
      real, dimension(1:ly1,1:ly3) :: iytm13
      real, dimension(1:ly3,1:ly1) :: iytm31
      real, dimension(1:lz1,1:lz3) :: iztm13
      real, dimension(1:lz3,1:lz1) :: iztm31
      real, dimension(1:ly2,1:ly1) :: iam12
      real, dimension(1:ly1,1:ly2) :: iam21
      real, dimension(1:ly1,1:ly2) :: iatm12
      real, dimension(1:ly2,1:ly1) :: iatm21
      real, dimension(1:ly3,1:ly1) :: iam13
      real, dimension(1:ly1,1:ly3) :: iam31
      real, dimension(1:ly1,1:ly3) :: iatm13
      real, dimension(1:ly3,1:ly1) :: iatm31
      real, dimension(1:ly2,1:ly1) :: icm12
      real, dimension(1:ly1,1:ly2) :: icm21
      real, dimension(1:ly1,1:ly2) :: ictm12
      real, dimension(1:ly2,1:ly1) :: ictm21
      real, dimension(1:ly3,1:ly1) :: icm13
      real, dimension(1:ly1,1:ly3) :: icm31
      real, dimension(1:ly1,1:ly3) :: ictm13
      real, dimension(1:ly3,1:ly1) :: ictm31
      real, dimension(1:ly1,1:ly1) :: iajl1
      real, dimension(1:ly1,1:ly1) :: iatjl1
      real, dimension(1:ly2,1:ly2) :: iajl2
      real, dimension(1:ly2,1:ly2) :: iatjl2
      real, dimension(1:ly3,1:ly3) :: ialj3
      real, dimension(1:ly3,1:ly3) :: iatlj3
      real, dimension(1:ly1,1:ly1) :: ialj1
      real, dimension(1:ly1,1:ly1) :: iatlj1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: bm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: binvm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bintm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: bm2inv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: baxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1) :: bm1lag
      real :: volvm1
      real :: volvm2
      real :: voltm1
      real :: voltm2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: yinvm1
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: binvdg
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wx
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wy
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wz
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wxlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wylag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt,1:lorder-1) :: wzlag
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w1mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w2mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: w3mask
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelt) :: wmult
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev1
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev2
      real, dimension(1:lx1m,1:ly1m,1:lz1m,1:lelv) :: ev3
      integer :: node
      integer :: pid
      integer, intent(In) :: np
      integer :: nullpid
      integer :: node0
      integer(kind=8), intent(In) :: nvtot
      integer, dimension(0:ldimt1) :: nelg
      integer, dimension(1:lelt) :: lglel
      integer, dimension(1:lelg) :: gllel
      integer, dimension(1:lelg) :: gllnid
      integer :: nelgv
      integer :: nelgt
      logical :: ifgprnt
      integer :: wdsize
      integer :: isize
      integer :: lsize
      integer :: csize
      integer :: wdsizi
      integer :: cr_h
      integer :: gsh
      integer, dimension(0:ldimt3) :: gsh_fld
      integer, dimension(1:ldimt3) :: xxth
      logical :: ifgsh_fld_same
      integer, dimension(1:lx1*lz1*2*ldim*lelt) :: dg_face
      integer :: dg_hndlx
      integer :: ndg_facex
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: bq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vxlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vylag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv,1:2) :: vzlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:lorder-1,1:ldimt) :: tlag
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: vgradt2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abx2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: aby2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: abz2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: vdiff_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      real, dimension(1:lx1*ly1*lz1*lelv) :: vx_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_e
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: t
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vtrans
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: bfz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: cflf
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmnv
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bmass
      real, dimension(1:lx1*ly1*lz1*lelv*ldim,1:lorder+1) :: bdivw
      real, dimension(1:lxd*lyd*lzd*lelv*ldim,1:lorder+1) :: c_vx
      real, dimension(1:2*ldim,1:lelt) :: fw
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: by
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bz
      real, dimension(1:lbx2,1:lby2,1:lbz2,1:lbelv) :: pm
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmx
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmy
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bmz
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz1
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbx2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bby2
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bbz2
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bxlag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bylag
      real, dimension(1:lbx1*lby1*lbz1*lbelv,1:lorder-1) :: bzlag
      real, dimension(1:lbx2*lby2*lbz2*lbelv,1:lorder2) :: pmlag
      real :: nu_star
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv,1:lorder2) :: prlag
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: qtl
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelt) :: usrdiv
      real :: p0th
      real :: dp0thdt
      real :: gamma0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v1mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v2mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: v3mask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: omask
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt) :: tmult
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b1mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b2mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: b3mask
      real, dimension(1:lbx1,1:lby1,1:lbz1,1:lbelv) :: bpmask
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: vzp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lpert) :: prp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: tp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: bqp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfxp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfyp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: bfzp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vxlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vylagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lorder-1,1:lpert) :: vzlagp
       real, dimension(1:lpx2*lpy2*lpz2*lpelv,1:lorder2,1:lpert) :: prlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lorder-1,1:lpert) :: tlagp
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exx2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exy2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelv,1:lpert) :: exz2p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt1p
       real, dimension(1:lpx1*lpy1*lpz1*lpelt,1:ldimt,1:lpert) :: vgradt2p
      integer :: jp
      real, dimension(1:ldimt1) :: tauss
      real, dimension(1:ldimt1) :: txnext
      integer :: nsskip
      logical :: ifskip
      logical :: ifmodp
      logical :: ifssvt
      logical, dimension(1:ldimt1) :: ifstst
      logical :: ifexvt
      logical, dimension(1:ldimt1) :: ifextr
      real :: dvnnh1
      real :: dvnnsm
      real :: dvnnl2
      real :: dvnnl8
      real :: dvdfh1
      real :: dvdfsm
      real :: dvdfl2
      real :: dvdfl8
      real :: dvprh1
      real :: dvprsm
      real :: dvprl2
      real :: dvprl8
      integer, dimension(1:2,1:3) :: nomlis
      integer, dimension(1:6) :: nmlinv
      integer, dimension(1:6) :: group
      integer, dimension(1:6,1:6) :: skpdat
      integer, dimension(1:6) :: eface
      integer, dimension(1:6) :: eface1
      integer, dimension(-12:12,1:3) :: eskip
      integer, dimension(1:3) :: nedg
      integer :: ncmp
      integer, dimension(1:8) :: ixcn
      integer, dimension(1:3,0:ldimt1) :: noffst
      integer :: maxmlt
      integer, dimension(0:ldimt1) :: nspmax
      integer, dimension(0:ldimt1) :: ngspcn
      integer, dimension(1:3,0:ldimt1) :: ngsped
      integer, dimension(1:lelt,0:ldimt1) :: numscn
      integer, dimension(1:lelt,0:ldimt1) :: numsed
      integer, dimension(1:8,1:lelt,0:ldimt1) :: gcnnum
      integer, dimension(1:8,1:lelt,0:ldimt1) :: lcnnum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: lednum
      integer, dimension(1:12,1:lelt,0:ldimt1) :: gedtyp
      integer, dimension(1:2,0:ldimt1) :: ngcomm
      integer, dimension(1:20) :: iedge
      integer, dimension(1:2,1:4,1:6,0:1) :: iedgef
      integer, dimension(1:3,1:16) :: icedg
      integer, dimension(1:4,1:6) :: iedgfc
      integer, dimension(1:4,1:10) :: icface
      integer, dimension(1:8) :: indx
      integer, dimension(1:27) :: invedg
      real :: time
      real :: timef
      real :: fintim
      real :: timeio
      real :: dt
      real, dimension(1:10) :: dtlag
      real :: dtinit
      real :: dtinvm
      real :: courno
      real :: ctarg
      real, dimension(1:10) :: ab
      real, dimension(1:10) :: bd
      real, dimension(1:10) :: abmsh
      real, dimension(1:ldimt1) :: avdiff
      real, dimension(1:ldimt1) :: avtran
      real, dimension(0:ldimt1) :: volfld
      real :: tolrel
      real :: tolabs
      real :: tolhdf
      real :: tolpdf
      real :: tolev
      real :: tolnl
      real :: prelax
      real :: tolps
      real :: tolhs
      real :: tolhr
      real :: tolhv
      real, dimension(1:ldimt1) :: tolht
      real :: tolhe
      real :: vnrmh1
      real :: vnrmsm
      real :: vnrml2
      real :: vnrml8
      real :: vmean
      real, dimension(1:ldimt) :: tnrmh1
      real, dimension(1:ldimt) :: tnrmsm
      real, dimension(1:ldimt) :: tnrml2
      real, dimension(1:ldimt) :: tnrml8
      real, dimension(1:ldimt) :: tmean
      integer :: ifield
      integer :: imesh
      integer, intent(In) :: istep
      integer :: nsteps
      integer :: iostep
      integer :: lastep
      integer :: iocomm
      integer :: instep
      integer :: nab
      integer :: nabmsh
      integer :: nbd
      integer :: nbdinp
      integer :: ntaubd
      integer :: nmxh
      integer :: nmxp
      integer :: nmxe
      integer :: nmxnl
      integer :: ninter
      integer, dimension(0:ldimt1) :: nelfld
      integer :: nconv
      integer :: nconv_max
      integer :: ioinfodmp
      real :: pi
      logical :: ifprnt
      logical :: if_full_pres
      logical :: ifoutfld
      real, dimension(1:3,1:lpert) :: lyap
      integer :: iesolv
      logical, dimension(1:lelv) :: ifalgn
      logical, dimension(1:lelv) :: ifrsxy
      real, dimension(1:lelv) :: volel
      real, dimension(1:lx1,1:3) :: zgm1
      real, dimension(1:lx2,1:3) :: zgm2
      real, dimension(1:lx3,1:3) :: zgm3
      real, dimension(1:lx1) :: zam1
      real, dimension(1:lx2) :: zam2
      real, dimension(1:lx3) :: zam3
      real, dimension(1:lx1) :: wxm1
      real, dimension(1:ly1) :: wym1
      real, dimension(1:lz1) :: wzm1
      real, dimension(1:lx1,1:ly1,1:lz1) :: w3m1
      real, dimension(1:lx2) :: wxm2
      real, dimension(1:ly2) :: wym2
      real, dimension(1:lz2) :: wzm2
      real, dimension(1:lx2,1:ly2,1:lz2) :: w3m2
      real, dimension(1:lx3) :: wxm3
      real, dimension(1:ly3) :: wym3
      real, dimension(1:lz3) :: wzm3
      real, dimension(1:lx3,1:ly3,1:lz3) :: w3m3
      real, dimension(1:ly1) :: wam1
      real, dimension(1:ly2) :: wam2
      real, dimension(1:ly3) :: wam3
      real, dimension(1:lx1,1:ly1) :: w2am1
      real, dimension(1:lx1,1:ly1) :: w2cm1
      real, dimension(1:lx2,1:ly2) :: w2am2
      real, dimension(1:lx2,1:ly2) :: w2cm2
      real, dimension(1:lx3,1:ly3) :: w2am3
      real, dimension(1:lx3,1:ly3) :: w2cm3
      real, dimension(1:lx1) :: zgl
      real, dimension(1:lx1) :: wgl
      real, dimension(1:lx1) :: zgp
      real, dimension(1:lxq) :: wgp
      real, dimension(1:lx1*lx1) :: wgl1
      real, dimension(1:lxq*lxq) :: wgl2
      real, dimension(1:lx1*lx1) :: wgli
      real, dimension(1:lx1*lx1) :: d1
      real, dimension(1:lx1*lx1) :: d1t
      real, dimension(1:lx1*lx1) :: d2
      real, dimension(1:lx1*lx1) :: b2p
      real, dimension(1:lx1*lx1) :: b1ia1
      real, dimension(1:lx1*lx1) :: b1ia1t
      real, dimension(1:lx1*lx1) :: da
      real, dimension(1:lx1*lx1) :: dat
      real, dimension(1:lx1*lxq) :: iggl
      real, dimension(1:lx1*lxq) :: igglt
      real, dimension(1:lx1*lxq) :: dglg
      real, dimension(1:lx1*lxq) :: dglgt
      real, dimension(1:lx1*lxq) :: wglg
      real, dimension(1:lx1*lxq) :: wglgt
      real(kind=8) :: tmxmf
      real(kind=8) :: tmxms
      real(kind=8) :: tdsum
      real(kind=8) :: taxhm
      real(kind=8) :: tcopy
      real(kind=8) :: tinvc
      real(kind=8) :: tinv3
      real(kind=8) :: tinit
      real(kind=8) :: tadc3
      real(kind=8) :: tcol3
      real(kind=8) :: ta2s2
      real(kind=8) :: tcol2
      real(kind=8) :: tadd2
      real(kind=8) :: tsolv
      real(kind=8) :: tgsum
      real(kind=8) :: tdsnd
      real(kind=8) :: tdadd
      real(kind=8) :: tcdtp
      real(kind=8) :: tmltd
      real(kind=8), intent(In) :: tprep
      real(kind=8) :: tpres
      real(kind=8) :: thmhz
      real(kind=8) :: tgop
      real(kind=8) :: tgop1
      real(kind=8) :: tdott
      real(kind=8) :: tbsol
      real(kind=8) :: tbso2
      real(kind=8) :: tsett
      real(kind=8) :: tslvb
      real(kind=8) :: tusbc
      real(kind=8) :: tddsl
      real(kind=8) :: tcrsl
      real(kind=8) :: tdsmx
      real(kind=8) :: tdsmn
      real(kind=8) :: tgsmn
      real(kind=8) :: tgsmx
      real(kind=8) :: teslv
      real(kind=8) :: tbbbb
      real(kind=8) :: tcccc
      real(kind=8) :: tdddd
      real(kind=8) :: teeee
      real(kind=8) :: tvdss
      real(kind=8) :: tschw
      real(kind=8) :: tadvc
      real(kind=8) :: tspro
      real(kind=8) :: tgop_sync
      real(kind=8) :: tsyc
      real(kind=8) :: twal
      real(kind=8) :: tgp2
      real(kind=8) :: tcvf
      real(kind=8) :: tproj
      real(kind=8) :: tusfq
      integer :: nmxmf
      integer :: nmxms
      integer :: ndsum
      integer :: naxhm
      integer :: ncopy
      integer :: ninvc
      integer :: ninv3
      integer :: nsolv
      integer :: ngsum
      integer :: ndsnd
      integer :: ndadd
      integer :: ncdtp
      integer :: nmltd
      integer :: nprep
      integer :: npres
      integer :: nhmhz
      integer :: ngop
      integer :: ngop1
      integer :: ndott
      integer :: nbsol
      integer :: nbso2
      integer :: nsett
      integer :: nslvb
      integer :: nusbc
      integer :: nddsl
      integer :: ncrsl
      integer :: ndsmx
      integer :: ndsmn
      integer :: ngsmn
      integer :: ngsmx
      integer :: neslv
      integer :: nbbbb
      integer :: ncccc
      integer :: ndddd
      integer :: neeee
      integer :: nvdss
      integer :: nadvc
      integer :: nspro
      integer :: ngop_sync
      integer :: nsyc
      integer :: nwal
      integer :: ngp2
      integer :: ncvf
      real(kind=8) :: pmxmf
      real(kind=8) :: pmxms
      real(kind=8) :: pdsum
      real(kind=8) :: paxhm
      real(kind=8) :: pcopy
      real(kind=8) :: pinvc
      real(kind=8) :: pinv3
      real(kind=8) :: psolv
      real(kind=8) :: pgsum
      real(kind=8) :: pdsnd
      real(kind=8) :: pdadd
      real(kind=8) :: pcdtp
      real(kind=8) :: pmltd
      real(kind=8) :: pprep
      real(kind=8) :: ppres
      real(kind=8) :: phmhz
      real(kind=8) :: pgop
      real(kind=8) :: pgop1
      real(kind=8) :: pdott
      real(kind=8) :: pbsol
      real(kind=8) :: pbso2
      real(kind=8) :: psett
      real(kind=8) :: pslvb
      real(kind=8) :: pusbc
      real(kind=8) :: pddsl
      real(kind=8) :: pcrsl
      real(kind=8) :: pdsmx
      real(kind=8) :: pdsmn
      real(kind=8) :: pgsmn
      real(kind=8) :: pgsmx
      real(kind=8) :: peslv
      real(kind=8) :: pbbbb
      real(kind=8) :: pcccc
      real(kind=8) :: pdddd
      real(kind=8) :: peeee
      real(kind=8) :: pvdss
      real(kind=8) :: pspro
      real(kind=8) :: pgop_sync
      real(kind=8) :: psyc
      real(kind=8) :: pwal
      real(kind=8) :: pgp2
      real(kind=8) :: etime1
      real(kind=8) :: etime2
      real(kind=8) :: etime0
      real(kind=8) :: gtime1
      real(kind=8) :: tscrtch
      real(kind=8), intent(In) :: etimes
      real(kind=8), intent(InOut) :: ttotal
      real(kind=8) :: tttstp
      real(kind=8) :: etims0
      real(kind=8), intent(In) :: ttime
      integer :: icalld
      save    icalld
      data icalld / 0 / 
      logical :: ifsync
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
#ifdef PAPI
      gflops = glsum(dnekgflops(),1)
#endif
      tstop  = dnekclock_sync()
      ttotal = tstop-etimes
      tsol   = max(ttime - tprep,0.0)
      nxyz   = lx1*ly1*lz1
      dtmp4 = glsum(getmaxrss(),1)/1e9
      if (nid == 0) then 
         dtmp1 = 0
         dtmp2 = 0
         if(istep > 0) then
           dgp   = nvtot
           dgp   = max(dgp,1.)*max(istep,1)
           dtmp0 = np*(ttime-tprep)
           dtmp1 = 0
           if (dtmp0 > 0) dtmp1 = dgp/dtmp0 
           dtmp2 = (ttime-tprep)/max(istep,1)
         endif 
         write(6,*) ' '
         write(6,'(5(A,1p1e13.5,A,/))')        'total elapsed time             : ',ttotal, ' sec'      ,'total solver time w/o IO       : ',tsol,   ' sec'      ,'time/timestep                  : ',dtmp2 , ' sec'      ,'avg throughput per timestep    : ',dtmp1 , ' gridpts/CPUs'      ,'total max memory usage         : ',dtmp4 , ' GB'
#ifdef PAPI
         write(6,'(1(A,1p1e13.5,/))')       ,'total Gflops/s                 : ',gflops
#endif
      endif 
      call flush_io
      return
      end subroutine print_runtime_info
      subroutine nek_die(ierr)
      implicit none
      integer :: nio
      integer :: loglevel
      integer :: optlevel
      integer :: nelv
      integer :: nelt
      integer :: nfield
      integer :: npert
      integer :: nid
      integer :: idsess
      integer :: nx1
      integer :: ny1
      integer :: nz1
      integer :: nx2
      integer :: ny2
      integer :: nz2
      integer :: nx3
      integer :: ny3
      integer :: nz3
      integer :: nxd
      integer :: nyd
      integer :: nzd
      integer :: ndim
      integer :: ldimr
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
      call mpi_finalize (ierr_)
#ifdef EXTBAR
      call exit_(ierr)
#else
      call exit(ierr)
#endif
      return
      end subroutine nek_die

end module singleton_module_src_comm_mpi


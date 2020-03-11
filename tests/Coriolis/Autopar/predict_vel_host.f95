module module_src_predict_vel
 contains 
      subroutine predict_vel(alpha,im,jm,km,u,un,v,vn)

        use module_predict_loc_predict_vel_update_etc_superkernel_init
        use oclWrapper
!      implicit none

      implicit none

! otherStatements

! remainingDecls
      real :: beta !!
      real, dimension(1:im,1:jm,1:km), intent(out) :: vn !!
      real, dimension(1:im,1:jm,1:km), intent(in) :: v !!
      real, dimension(1:im,1:jm,1:km), intent(out) :: un !!
      real, dimension(1:im,1:jm,1:km), intent(in) :: u !!
      integer, intent(in) :: km !!
      integer, intent(in) :: jm !!
      integer, intent(in) :: im !!
      integer, intent(in) :: alpha !!
      integer :: k !!
      integer :: j !!
      integer :: i !!

        ! Extra declarations
        real (kind=4) :: exectime

        ! Buffer declarations
        integer(8) :: state_ptr_buf

        integer, dimension(1) :: state_ptr

        ! Size declarations
        integer, dimension(1) :: state_ptr_sz

        
! Size assignments
        state_ptr_sz = shape(state_ptr)

        ! Buffer loads
        call oclLoadBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)

        ! Original code with buffer writes and reads
! ---- BEGIN predict_vel_map_17 -----------------------------------------------------------------------------------------------
        oclGlobalRange = (im * (jm * km))
        oclLocalRange = 0
        state_ptr(1) = ST_PREDICT_VEL_MAP_17
        
        call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_sz,state_ptr)
        call runOcl(oclGlobalRange,oclLocalRange,exectime)
        ! call predict_vel_map_17

! ---- END --------------------------------------------------------------------------------------------------------------------
      end subroutine predict_vel
! Footer (produceCode_progUnit c)
end module module_src_predict_vel

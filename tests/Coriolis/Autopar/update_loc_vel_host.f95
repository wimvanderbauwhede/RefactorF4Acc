module module_src_update_loc_vel
 contains 
      subroutine update_loc_vel(im,jm,km,u,un,v,vn,x,xn,y,yn)

        use module_predict_loc_predict_vel_update_etc_superkernel_init
        use oclWrapper
!      implicit none

      implicit none

! otherStatements

! remainingDecls
      real, dimension(1:im,1:jm,1:km), intent(in) :: yn !!
      real, dimension(1:im,1:jm,1:km), intent(out) :: y !!
      real, dimension(1:im,1:jm,1:km), intent(in) :: xn !!
      real, dimension(1:im,1:jm,1:km), intent(out) :: x !!
      real, dimension(1:im,1:jm,1:km), intent(in) :: vn !!
      real, dimension(1:im,1:jm,1:km), intent(out) :: v !!
      real, dimension(1:im,1:jm,1:km), intent(in) :: un !!
      real, dimension(1:im,1:jm,1:km), intent(out) :: u !!
      integer, intent(in) :: km !!
      integer, intent(in) :: jm !!
      integer, intent(in) :: im !!
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
! ---- BEGIN update_loc_vel_map_19 --------------------------------------------------------------------------------------------
        oclGlobalRange = (im * (jm * km))
        oclLocalRange = 0
        state_ptr(1) = ST_UPDATE_LOC_VEL_MAP_19
        
        call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_sz,state_ptr)
        call runOcl(oclGlobalRange,oclLocalRange,exectime)
        ! call update_loc_vel_map_19

! ---- END --------------------------------------------------------------------------------------------------------------------
      end subroutine update_loc_vel
! Footer (produceCode_progUnit c)
end module module_src_update_loc_vel

module module_src_corio_core
 contains 
      subroutine corio_core(u,v,x,y)

        use module_corio_core_superkernel_init
        use oclWrapper
!      implicit none

      implicit none

! otherStatements

! remainingDecls
      real, parameter :: dt = 432.000000  !!
      real, parameter :: pi = 3.14159274  !!
      real, parameter :: freq = -7.27220540E-05  !!
      real, parameter :: f = -1.45444108E-04  !!
      real, parameter :: alpha = -6.28318563E-02  !!
      real, parameter :: beta = 9.86960484E-04  !!
      integer, parameter :: dmax = 1000  !!
      integer, parameter :: im = 10  !!
      integer, parameter :: jm = 10  !!
      integer, parameter :: km = 5  !!
      real, dimension(1:im,1:jm,1:km), intent(inout) :: y !!
      real, dimension(1:im,1:jm,1:km), intent(inout) :: x !!
      real, dimension(1:im,1:jm,1:km), intent(inout) :: v !!
      real, dimension(1:im,1:jm,1:km), intent(inout) :: u !!
      real, dimension(1:im,1:jm,1:km) :: yn !!
      real, dimension(1:im,1:jm,1:km) :: xn !!
      real, dimension(1:im,1:jm,1:km) :: vn !!
      real, dimension(1:im,1:jm,1:km) :: un !!
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
! ---- BEGIN corio_core_map_26 ------------------------------------------------------------------------------------------------
        oclGlobalRange = (10 * (10 * 5))
        oclLocalRange = 0
        state_ptr(1) = ST_CORIO_CORE_MAP_26
        
        call oclWrite1DIntArrayBuffer(state_ptr_buf,state_ptr_sz,state_ptr)
        call runOcl(oclGlobalRange,oclLocalRange,exectime)
        ! call corio_core_map_26

! ---- END --------------------------------------------------------------------------------------------------------------------
      end subroutine corio_core
! Footer (produceCode_progUnit c)
end module module_src_corio_core

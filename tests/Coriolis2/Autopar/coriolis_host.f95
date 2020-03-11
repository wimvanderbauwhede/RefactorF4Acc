        program corio

        use oclWrapper
        use module_corio_core_superkernel_init
      implicit none
        
! Original declarations
      integer, parameter :: im = 10  !!
      integer, parameter :: jm = 10  !!
      integer, parameter :: km = 5  !!
      integer, parameter :: dmax = 1000  !!
      integer :: k !!
      real, dimension(1:im,1:jm,1:km) :: u !!
      real, dimension(1:im,1:jm,1:km) :: v !!
      real, dimension(1:im,1:jm,1:km) :: un !!
      real, dimension(1:im,1:jm,1:km) :: vn !!
      real, dimension(1:im,1:jm,1:km) :: x !!
      real, dimension(1:im,1:jm,1:km) :: y !!
      real, dimension(1:im,1:jm,1:km) :: xn !!
      real, dimension(1:im,1:jm,1:km) :: yn !!
      integer :: n !!
      integer :: i !!
      integer :: j !!
      real, parameter :: pi = 3.14159274  !!
      real, parameter :: freq = -7.27220540E-05  !!
      real, parameter :: f = -1.45444108E-04  !!
      real, parameter :: dt = 432.000000  !!
      real, parameter :: alpha = -6.28318563E-02  !!
      real, parameter :: beta = 9.86960484E-04  !!
      integer, parameter :: ntot = 200  !!



!

! otherStatements

! remainingDecls

        ! Extra declarations
!NOTHING!
        ! Buffer declarations
      integer(8) :: state_ptr_buf

        integer, dimension(1) :: state_ptr

        ! Size declarations
      integer, dimension(1) :: state_ptr_sz

        call corio_core_superkernel_init()
        
! Size assignments
      state_ptr_sz = shape(state_ptr)

        ! Buffer loads
      call oclLoadBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)

        ! Original code with buffer writes and reads
        do i=1,im
        do j=1,jm
            do k=1,km
                u(i,j,k) = 0.5
                v(i,j,k) = 0.5
                x(i,j,k) = 0.
                y(i,j,k) = 5.
            end do
        end do
        end do
        open(10,file='output1.txt',form='formatted')
        write(10,*)freq,dt,ntot
        do n = 1,ntot
      call corio_core(u,v,x,y)
        end do
        end program corio

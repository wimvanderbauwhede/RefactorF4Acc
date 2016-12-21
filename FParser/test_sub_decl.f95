    subroutine initialise_LES_kernel ( p,u,v,w,f,g,h,fold,gold,hold, cov1, cov2, cov3, cov4, cov5, cov6, cov7, cov8, cov9, diu1, diu2, diu3, diu4, diu5, diu6, diu7, diu8, diu9, nou1, nou2, nou3, nou4, nou5, nou6, nou7, nou8, nou9, amask1, bmask1, cmask1, dmask1, cn1, cn2l, cn2s, cn3l, cn3s, cn4l, cn4s, rhs, sm, dxs, dys, dzs, dx1, dy1, dzn, z2, dt, im, jm, km, nmax )
        use oclWrapper
!        use params_common_sn

        implicit none
    ! Parameters
        integer, parameter  :: ip = 150
        integer, parameter  :: jp = 150
        integer, parameter  :: kp = 90    
    ! Arguments
!$ACC Arguments	
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+1)  :: p
!$ACC End Arguments	
        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: u
        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: v
        real(kind=4), dimension(0:ip+1,-1:jp+1,-1:kp+1)  :: w
        real(kind=4), dimension(0:ip,0:jp,0:kp)  :: f      
        real(kind=4), dimension(0:ip,0:jp,0:kp)  :: g
        real(kind=4), dimension(0:ip,0:jp,0:kp)  :: h
        real(kind=4), dimension(ip,jp,kp)  :: fold
        real(kind=4), dimension(ip,jp,kp)  :: gold
        real(kind=4), dimension(ip,jp,kp)  :: hold
        
        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+2)  :: cov1
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov2
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov3
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov4
        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+2)  :: cov5
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov6
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov7
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov8
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: cov9

        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+2)  :: diu1
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu2
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu3
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu4
        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+2)  :: diu5
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu6
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu7
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu8
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: diu9

        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+2)  :: nou1
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou2
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou3
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou4
        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+2)  :: nou5
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou6
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou7
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou8
        real(kind=4), dimension(0:ip+2,0:jp+2,0:kp+2)  :: nou9

        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: amask1
        real(kind=4), dimension(-1:ip+1,0:jp+1,0:kp+1)  :: bmask1
        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: cmask1
        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: dmask1
!$ACC Arguments
        real(kind=4), dimension(ip,jp,kp)  :: cn1
!$ACC End Arguments
        real(kind=4), dimension(ip)  :: cn2l
        real(kind=4), dimension(ip)  :: cn2s
        real(kind=4), dimension(jp)  :: cn3l
        real(kind=4), dimension(jp)  :: cn3s
        real(kind=4), dimension(kp)  :: cn4l
        real(kind=4), dimension(kp)  :: cn4s
!$ACC Arguments
        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: rhs
        real(kind=4), dimension(-1:ip+1,-1:jp+1,0:kp+1)  :: sm
        real(kind=4), dimension(0:ip)  :: dxs
        real(kind=4), dimension(0:jp)  :: dys
        real(kind=4), dimension(-1:kp+2)  :: dzs
        real(kind=4), dimension(-1:ip+1)  :: dx1
        real(kind=4), dimension(0:jp+1)  :: dy1
        real(kind=4), dimension(-1:kp+2)  :: dzn
        real(kind=4), dimension(kp+2)  :: z2        
!$ACC End Arguments
       
!$ACC ConstArguments
        real(kind=4) :: dt
        integer :: im
        integer :: jm
        integer :: km
        integer :: nmax
!$ACC End ConstArguments

! -----------------------------------------------------------------------
! Combined arrays for OpenCL kernels
!$ACC Arguments	
        real(kind=4), dimension(0:3,0:ip+1,-1:jp+1,-1:kp+1)  :: uvw
        real(kind=4), dimension(0:3,0:ip,0:jp,0:kp)  :: fgh
        real(kind=4), dimension(0:3,ip,jp,kp)  :: fgh_old
        real(kind=4), dimension(1:16,-1:ip+2,0:jp+2,0:kp+2)  :: cov
        real(kind=4), dimension(1:16,-1:ip+2,0:jp+2,0:kp+2)  :: diu
        real(kind=4), dimension(1:16,-1:ip+2,0:jp+2,0:kp+2)  :: nou
        real(kind=4), dimension(0:3,0:ip+1,-1:jp+1,-1:kp+1)  :: mask1
        real(kind=4), dimension(1:2*(ip+jp+kp))  :: cn234ls
        integer, dimension(0:1) :: n_state
!$ACC End Arguments

        ! OpenCL-specific declarations
        integer :: nunits
        !WV: FIXME, needs dynamic allocation!
!FIXME        character(10) :: kstr
!FIXME        character(17) :: srcstr

!$ACC BufDecls

! Sizes
!$ACC SizeDecls

 ! Convert to new format
        call convert_to_uvw(u,v,w,uvw)
        call convert_to_fgh(f,g,h,fgh)
        call convert_to_fgh_old(fold,gold,hold, fgh_old)
        ! The following are all read-only
        call convert_to_9vec(cov1,cov2,cov3,cov4,cov5,cov6,cov7,cov8,cov9,cov)
        call convert_to_9vec(diu1,diu2,diu3,diu4,diu5,diu6,diu7,diu8,diu9,diu)
        call convert_to_9vec(nou1,nou2,nou3,nou4,nou5,nou6,nou7,nou8,nou9,nou)
        call convert_to_mask1(amask1,bmask1,cmask1,dmask1,mask1)
        call convert_to_cn234ls(cn2l,cn2s,cn3l,cn3s,cn4l,cn4s,cn234ls)

       ! OpenCL-specific code

        srcstr='LES_kernel_ocl.cc'
        kstr='LES_kernel'

        call oclInit(srcstr,kstr)
        call oclGetMaxComputeUnits(nunits)
        
        ! Create OpenCL buffers

!$ACC MakeSizes        

        n_state(0)=0
        n_state(1)=0

!$ACC MakeBuffers

!$ACC SetArgs
    
    ! Copy all arrays required for the full run
!$ACC WriteBuffers
     
    ! Following buffers are used in the loop, assign to module-level buffer array for convenience

        oclBuffers(1) = p_buf
        oclBuffers(2) = uvw_buf
        oclBuffers(3) = fgh_old_buf
        oclBuffers(4) = n_state_buf

    end subroutine initialise_LES_kernel 
! --------------------------------------------------------------------------------

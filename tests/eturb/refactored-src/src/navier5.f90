module singleton_module_src_navier5

      use singleton_module_src_comm_mpi
      use singleton_module_src_math
      use singleton_module_src_subs1
      use singleton_module_src_mxm_wrapper
contains

      subroutine mappr(pm1,pm2,pa,pb,nelv,ifsplit,ixm21,iytm21,iztm21,ifield,vmult,nrout_GLOB, &
      rname_GLOB,dct_GLOB,ncall_GLOB,dcount_GLOB,tmxmf_GLOB,tcol2_GLOB)
      use params_SIZE, only : ly1, ly2, lx1, lelv, lz1, lz2, lx2
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      real, dimension(1:n1,1:n2) :: ixm21_mxm
      real, dimension(1:n2,1:n3) :: iytm21_mxm
      real, dimension(1:n2,1:n3) :: iztm21_mxm
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pm1_copy
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pm2_copy
      integer, parameter :: maxrts=1000
      integer, intent(In) :: nelv
      logical, intent(In) :: ifsplit
      real, dimension(1:lx1,1:lx2), intent(InOut) :: ixm21
      real, dimension(1:ly2,1:ly1), intent(InOut) :: iytm21
      real, dimension(1:lz2,1:lz1), intent(InOut) :: iztm21
      integer, intent(Out) :: ifield
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vmult
      integer :: nrout_GLOB
      character(len=6), dimension(1:maxrts) :: rname_GLOB
      real(kind=8), dimension(1:maxrts) :: dct_GLOB
      integer, dimension(1:maxrts) :: ncall_GLOB
      real(kind=8) :: dcount_GLOB
      real(kind=8) :: tmxmf_GLOB
      real(kind=8) :: tcol2_GLOB
      integer :: nglob1
      integer :: nyz2
      integer :: nxy1
      integer :: nxyz
      integer :: iel
      integer :: iz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv), intent(InOut) :: pm2
      real, dimension(1:lx1,1:ly2,1:lz2), intent(InOut) :: pa
      real, dimension(1:lx1,1:ly1,1:lz2), intent(InOut) :: pb
      nglob1 = lx1*ly1*lz1*nelv
      nyz2   = ly2*lz2
      nxy1   = lx1*ly1
      nxyz   = lx1*ly1*lz1
      if (ifsplit) then
         pm1_copy = reshape(pm1,shape(pm1_copy))
         pm2_copy = reshape(pm2,shape(pm2_copy))
         call copy(pm1_copy,pm2_copy,nglob1)

         pm1 = reshape(pm1_copy, shape(pm1))
         pm2 = reshape(pm2_copy, shape(pm2))
      else
         do iel=1,nelv
            ixm21_mxm = reshape(ixm21,shape(ixm21_mxm))
            call mxm(ixm21_mxm,lx1,pm2(1,1,1,iel),lx2,pa(1,1,1),nyz2,nrout_GLOB,rname_GLOB,dct_GLOB, &
      ncall_GLOB,dcount_GLOB,tmxmf_GLOB)
            ixm21 = reshape(ixm21_mxm, shape(ixm21))
            do iz=1,lz2
               iytm21_mxm = reshape(iytm21,shape(iytm21_mxm))
               call mxm(pa(1,1,iz),lx1,iytm21_mxm,ly2,pb(1,1,iz),ly1,nrout_GLOB,rname_GLOB,dct_GLOB, &
      ncall_GLOB,dcount_GLOB,tmxmf_GLOB)
               iytm21 = reshape(iytm21_mxm, shape(iytm21))
  end do
            iztm21_mxm = reshape(iztm21,shape(iztm21_mxm))
            call mxm(pb(1,1,1),nxy1,iztm21_mxm,lz2,pm1(1,1,1,iel),lz1,nrout_GLOB,rname_GLOB, &
      dct_GLOB,ncall_GLOB,dcount_GLOB,tmxmf_GLOB)
            iztm21 = reshape(iztm21_mxm, shape(iztm21))
  end do
       ifield=1
       call dssum (pm1,lx1,ly1,lz1)
       call col2  (pm1,vmult,nglob1)
      endif
      return
      end subroutine mappr
      subroutine local_grad3(ur,us,ut,u,n,e,d,dt,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB, &
      dcount_GLOB,tmxmf_GLOB)
      implicit none
      real, dimension(0:n,0:n,0:n) :: ur_mxm
      real, dimension(0:n,0:n,0:n) :: ut_mxm
      integer, parameter :: maxrts=1000
      integer :: nrout_GLOB
      character(len=6), dimension(1:maxrts) :: rname_GLOB
      real(kind=8), dimension(1:maxrts) :: dct_GLOB
      integer, dimension(1:maxrts) :: ncall_GLOB
      real(kind=8) :: dcount_GLOB
      real(kind=8) :: tmxmf_GLOB
      integer, intent(In) :: n
      integer :: m1
      integer :: m2
      integer :: k
      real, dimension(0:n,0:n,0:n), intent(InOut) :: ur
      real, dimension(0:n,0:n,0:n), intent(InOut) :: us
      real, dimension(0:n,0:n,0:n), intent(InOut) :: ut
      real, dimension(0:n,0:n,0:n,1:1), intent(In) :: u
      real, dimension(0:n,0:n), intent(In) :: d
      real, dimension(0:n,0:n), intent(In) :: dt
      integer, intent(In) :: e
      m1 = n+1
      m2 = m1*m1
      ur_mxm = reshape(ur,shape(ur_mxm))
      call mxm(d,m1,u(0,0,0,e),m1,ur_mxm,m2,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB,dcount_GLOB, &
      tmxmf_GLOB)
      ur = reshape(ur_mxm, shape(ur))
      do k=0,n
         call mxm(u(0,0,k,e),m1,dt,m1,us(0,0,k),m1,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB, &
      dcount_GLOB,tmxmf_GLOB)
      enddo
      ut_mxm = reshape(ut,shape(ut_mxm))
      call mxm(u(0,0,0,e),m2,dt,m1,ut_mxm,m1,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB,dcount_GLOB, &
      tmxmf_GLOB)
      ut = reshape(ut_mxm, shape(ut))
      return
      end subroutine local_grad3
      subroutine local_grad2(ur,us,u,n,e,d,dt,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB,dcount_GLOB, &
      tmxmf_GLOB)
      implicit none
      integer, parameter :: maxrts=1000
      integer :: nrout_GLOB
      character(len=6), dimension(1:maxrts) :: rname_GLOB
      real(kind=8), dimension(1:maxrts) :: dct_GLOB
      integer, dimension(1:maxrts) :: ncall_GLOB
      real(kind=8) :: dcount_GLOB
      real(kind=8) :: tmxmf_GLOB
      integer, intent(In) :: n
      integer :: m1
      real, dimension(0:n,0:n), intent(InOut) :: ur
      real, dimension(0:n,0:n), intent(InOut) :: us
      real, dimension(0:n,0:n,1:1), intent(In) :: u
      real, dimension(0:n,0:n), intent(In) :: d
      real, dimension(0:n,0:n), intent(In) :: dt
      integer, intent(In) :: e
      m1 = n+1
      call mxm(d,m1,u(0,0,e),m1,ur,m1,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB,dcount_GLOB, &
      tmxmf_GLOB)
      call mxm(u(0,0,e),m1,dt,m1,us,m1,nrout_GLOB,rname_GLOB,dct_GLOB,ncall_GLOB,dcount_GLOB, &
      tmxmf_GLOB)
      return
      end subroutine local_grad2
      subroutine gradm1(ux,uy,uz,u,ur,us,ut,nelt,if3d,dxm1,dxtm1,jacmi,rxm1,sxm1,txm1,rym1,sym1, &
      tym1,rzm1,szm1,tzm1,ifaxis,ifrzer,dytm1,nrout,rname,dct,ncall,dcount,tmxmf,dym1_GLOB, &
      dam1_GLOB,datm1_GLOB,dcm1_GLOB,dctm1_GLOB)
      use params_SIZE, only : lelt, ly1, lx1, lz1
!!      use params_INPUT ! ONLY LIST EMPTY
! Grouped Parameter Declarations
      implicit none
      integer, parameter :: lxyz=lx1*ly1*lz1
! Moved param decl for  lxyz to top of code unit
      real, dimension(1:lxyz), intent(InOut) :: ur
      real, dimension(1:lxyz), intent(InOut) :: us
      real, dimension(1:lxyz), intent(InOut) :: ut
      integer, intent(In) :: nelt
      logical, intent(In) :: if3d
      real, dimension(1:lx1,1:lx1), intent(In) :: dxm1
      real, dimension(1:lx1,1:lx1), intent(In) :: dxtm1
      real, dimension(1:lx1*ly1*lz1,1:lelt), intent(In) :: jacmi
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tzm1
      logical, intent(In) :: ifaxis
      logical, dimension(1:lelt), intent(In) :: ifrzer
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dytm1
      integer :: nrout
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      real, dimension(1:ly1,1:ly1) :: dym1_GLOB
      real, dimension(1:ly1,1:ly1) :: dam1_GLOB
      real, dimension(1:ly1,1:ly1) :: datm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dcm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dctm1_GLOB
      integer :: nxyz
      integer :: ntot
      integer :: n
      integer :: i
      real, dimension(1:lxyz,1:1), intent(Out) :: ux
      real, dimension(1:lxyz,1:1), intent(Out) :: uy
      real, dimension(1:lxyz,1:1), intent(Out) :: uz
      real, dimension(1:lxyz,1:1), intent(In) :: u
      integer :: e
      nxyz = lx1*ly1*lz1
      ntot = nxyz*nelt
      n = lx1-1
      do e=1,nelt
         if (if3d) then
            call local_grad3(ur,us,ut,u,n,e,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)

            do i=1,lxyz
               ux(i,e) = jacmi(i,e)*(ur(i)*rxm1(i,1,1,e)                             + us(i)*sxm1(i, &
      1,1,e)                             + ut(i)*txm1(i,1,1,e) )
               uy(i,e) = jacmi(i,e)*(ur(i)*rym1(i,1,1,e)                             + us(i)*sym1(i, &
      1,1,e)                             + ut(i)*tym1(i,1,1,e) )
               uz(i,e) = jacmi(i,e)*(ur(i)*rzm1(i,1,1,e)                             + us(i)*szm1(i, &
      1,1,e)                             + ut(i)*tzm1(i,1,1,e) )
            enddo
         else
            call setaxdy(ifrzer(e),dym1_GLOB,dam1_GLOB,dytm1,datm1_GLOB,dcm1_GLOB,dctm1_GLOB)

            call local_grad2(ur,us,u,n,e,dxm1,dytm1,nrout,rname,dct,ncall,dcount,tmxmf)

            do i=1,lxyz
               ux(i,e) =jacmi(i,e)*(ur(i)*rxm1(i,1,1,e)                            + us(i)*sxm1(i,1, &
      1,e) )
               uy(i,e) =jacmi(i,e)*(ur(i)*rym1(i,1,1,e)                            + us(i)*sym1(i,1, &
      1,e) )
            enddo
         endif
      enddo
      return
      end subroutine gradm1
      subroutine drgtrq(dgtq,xm0,ym0,zm0,sij,pm1,visc,f,e,eface1,skpdat,if3d,ifaxis,area,unx,uny, &
      unz)
      use params_SIZE, only : lz1, ldim, lelv, lx1, lelt, ly1
!!      use params_INPUT ! ONLY LIST EMPTY
      implicit none
      integer, dimension(1:6), intent(In) :: eface1
      integer, dimension(1:6,1:6), intent(In) :: skpdat
      logical, intent(In) :: if3d
      logical, intent(In) :: ifaxis
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: area
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt), intent(In) :: unz
      integer :: js1
      integer :: jf1
      integer :: jskip1
      integer :: js2
      integer :: jf2
      integer :: jskip2
      integer :: i
      real :: a
      integer :: j2
      integer :: j1
      real :: v
      real :: s11
      real :: s21
      real :: s31
      real :: s12
      real :: s22
      real :: s32
      real :: s13
      real :: s23
      real :: s33
      real :: r1
      real :: r2
      real :: r3
      integer :: l
      integer :: k
      real, dimension(1:3,1:4), intent(InOut) :: dgtq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: xm0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: zm0
      real, dimension(1:lx1,1:ly1,1:lz1,1:3*ldim-3,1:lelv), intent(In) :: sij
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: pm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: visc
      real, dimension(1:3,1:2) :: dg
      integer :: f
      integer :: e
      integer :: pf
      real :: n1
      real :: n2
      real :: n3
      call dsset(lx1,ly1,lz1)    
      pf     = eface1(f)         
      js1    = skpdat(1,pf)
      jf1    = skpdat(2,pf)
      jskip1 = skpdat(3,pf)
      js2    = skpdat(4,pf)
      jf2    = skpdat(5,pf)
      jskip2 = skpdat(6,pf)
      call rzero(dgtq,12)
      if (if3d.or.ifaxis) then
       i = 0
       a = 0
       do j2=js2,jf2,jskip2
       do j1=js1,jf1,jskip1
         i = i+1
         n1 = unx(i,1,f,e)*area(i,1,f,e)
         n2 = uny(i,1,f,e)*area(i,1,f,e)
         n3 = unz(i,1,f,e)*area(i,1,f,e)
         a  = a +          area(i,1,f,e)
         v  = visc(j1,j2,1,e)
         s11 = sij(j1,j2,1,1,e)
         s21 = sij(j1,j2,1,4,e)
         s31 = sij(j1,j2,1,6,e)
         s12 = sij(j1,j2,1,4,e)
         s22 = sij(j1,j2,1,2,e)
         s32 = sij(j1,j2,1,5,e)
         s13 = sij(j1,j2,1,6,e)
         s23 = sij(j1,j2,1,5,e)
         s33 = sij(j1,j2,1,3,e)
         dg(1,1) = pm1(j1,j2,1,e)*n1     
         dg(2,1) = pm1(j1,j2,1,e)*n2
         dg(3,1) = pm1(j1,j2,1,e)*n3
         dg(1,2) = -v*(s11*n1 + s12*n2 + s13*n3) 
         dg(2,2) = -v*(s21*n1 + s22*n2 + s23*n3)
         dg(3,2) = -v*(s31*n1 + s32*n2 + s33*n3)
         r1 = xm0(j1,j2,1,e)
         r2 = ym0(j1,j2,1,e)
         r3 = zm0(j1,j2,1,e)
         do l=1,2
         do k=1,3
            dgtq(k,l) = dgtq(k,l) + dg(k,l)
         enddo
         enddo
         dgtq(1,3) = dgtq(1,3) + (r2*dg(3,1)-r3*dg(2,1)) 
         dgtq(2,3) = dgtq(2,3) + (r3*dg(1,1)-r1*dg(3,1)) 
         dgtq(3,3) = dgtq(3,3) + (r1*dg(2,1)-r2*dg(1,1))
         dgtq(1,4) = dgtq(1,4) + (r2*dg(3,2)-r3*dg(2,2)) 
         dgtq(2,4) = dgtq(2,4) + (r3*dg(1,2)-r1*dg(3,2)) 
         dgtq(3,4) = dgtq(3,4) + (r1*dg(2,2)-r2*dg(1,2))
       enddo
       enddo
      else 
       i = 0
       a = 0
       do j2=js2,jf2,jskip2
       do j1=js1,jf1,jskip1
         i = i+1
         n1 = unx(i,1,f,e)*area(i,1,f,e)
         n2 = uny(i,1,f,e)*area(i,1,f,e)
         a  = a +          area(i,1,f,e)
         v  = visc(j1,j2,1,e)
         s11 = sij(j1,j2,1,1,e)
         s12 = sij(j1,j2,1,3,e)
         s21 = sij(j1,j2,1,3,e)
         s22 = sij(j1,j2,1,2,e)
         dg(1,1) = pm1(j1,j2,1,e)*n1     
         dg(2,1) = pm1(j1,j2,1,e)*n2
         dg(3,1) = 0
         dg(1,2) = -v*(s11*n1 + s12*n2) 
         dg(2,2) = -v*(s21*n1 + s22*n2)
         dg(3,2) = 0.
         r1 = xm0(j1,j2,1,e)
         r2 = ym0(j1,j2,1,e)
         r3 = 0.
         do l=1,2
         do k=1,3
            dgtq(k,l) = dgtq(k,l) + dg(k,l)
         enddo
         enddo
         dgtq(1,3) = 0
         dgtq(2,3) = 0
         dgtq(3,3) = dgtq(3,3) + (r1*dg(2,1)-r2*dg(1,1))
         dgtq(1,4) = 0
         dgtq(2,4) = 0
         dgtq(3,4) = dgtq(3,4) + (r1*dg(2,2)-r2*dg(1,2))
       enddo
       enddo
      endif
      return
      end subroutine drgtrq
      subroutine torque_calc(scale,x0,ifdout,iftout,dragx,dragpx,dragvx,dragy,dragpy,dragvy,dragz, &
      dragpz,dragvz,torqx,torqpx,torqvx,torqy,torqpy,torqvy,torqz,torqpz,torqvz,dpdx_mean, &
      dpdy_mean,dpdz_mean,dgtq,flow_rate,base_flow,domain_length,xsec,scale_vf,pm1,sij,ur,us,ut, &
      vr,vs,vt,wr,ws,wt,xm0,xm0,xm0,ym0,zm0)
      use params_SIZE, only : ly1, lhis, lelv, lx1, ldimt1, lz2, maxmbr, ly2, lz1, lelt, lx2, &
       maxobj, lelg
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      real, dimension(1:3,1:4) :: dgtq_cmult
      real, dimension(0:maxobj) :: dragpx_gop
      real, dimension(0:maxobj) :: dragpy_gop
      real, dimension(0:maxobj) :: dragpz_gop
      real, dimension(0:maxobj) :: dragvx_gop
      real, dimension(0:maxobj) :: dragvy_gop
      real, dimension(0:maxobj) :: dragvz_gop
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: pm1_add2s2
      real, dimension(0:maxobj) :: torqpx_gop
      real, dimension(0:maxobj) :: torqpy_gop
      real, dimension(0:maxobj) :: torqpz_gop
      real, dimension(0:maxobj) :: torqvx_gop
      real, dimension(0:maxobj) :: torqvy_gop
      real, dimension(0:maxobj) :: torqvz_gop
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff_cfill
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff_drgtrq
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx_comp_sij
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_comp_sij
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_comp_sij
      real, dimension(0:maxobj) :: w1_gop
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm0_cadd2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm0_mappr
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1_add2s2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1_cadd2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym0_cadd2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym0_mappr
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1_add2s2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1_cadd2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm0_cadd2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1_add2s2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1_cadd2
      xm0(1,1,1,1:512) = reshape(trx(1:lx1,1:ly1,1:lz1),shape(xm0(1,1,1,1:512)))
      xm0(1,1,1,513:1024) = reshape(trz(1:lx1,1:ly1,1:lz1),shape(xm0(1,1,1,513:1024)))
! Grouped Parameter Declarations
      integer, parameter :: lr=lx1*ly1*lz1
      real :: base_flow
      real, dimension(1:3,1:4), intent(InOut) :: dgtq
      real :: domain_length
      real, intent(InOut) :: dpdx_mean
      real, intent(InOut) :: dpdy_mean
      real, intent(InOut) :: dpdz_mean
      real, dimension(0:maxobj), intent(InOut) :: dragpx
      real, dimension(0:maxobj), intent(InOut) :: dragpy
      real, dimension(0:maxobj), intent(InOut) :: dragpz
      real, dimension(0:maxobj), intent(InOut) :: dragvx
      real, dimension(0:maxobj), intent(InOut) :: dragvy
      real, dimension(0:maxobj), intent(InOut) :: dragvz
      real, dimension(0:maxobj), intent(InOut) :: dragx
      real, dimension(0:maxobj), intent(InOut) :: dragy
      real, dimension(0:maxobj), intent(InOut) :: dragz
      real :: flow_rate
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
      real, dimension(1:3), intent(In) :: scale_vf
      real, dimension(1:lx1*ly1*lz1*6*lelv), intent(InOut) :: sij
      real, dimension(0:maxobj), intent(InOut) :: torqpx
      real, dimension(0:maxobj), intent(InOut) :: torqpy
      real, dimension(0:maxobj), intent(InOut) :: torqpz
      real, dimension(0:maxobj), intent(InOut) :: torqvx
      real, dimension(0:maxobj), intent(InOut) :: torqvy
      real, dimension(0:maxobj), intent(InOut) :: torqvz
      real, dimension(0:maxobj), intent(InOut) :: torqx
      real, dimension(0:maxobj), intent(InOut) :: torqy
      real, dimension(0:maxobj), intent(InOut) :: torqz
      real, dimension(1:lr), intent(InOut) :: ur
      real, dimension(1:lr), intent(InOut) :: us
      real, dimension(1:lr), intent(InOut) :: ut
      real, dimension(1:lr), intent(InOut) :: vr
      real, dimension(1:lr), intent(InOut) :: vs
      real, dimension(1:lr), intent(InOut) :: vt
      real, dimension(1:lr), intent(InOut) :: wr
      real, dimension(1:lr), intent(InOut) :: ws
      real, dimension(1:lr), intent(InOut) :: wt
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: xm0
      real :: xsec
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: ym0
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(InOut) :: zm0
      integer :: nelv
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv) :: pr
      real, dimension(1:200) :: param
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1
      logical :: if3d
      logical :: ifaxis
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz
      integer :: istep
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff
      integer :: nobj
      integer :: nhis
      character(len=1), dimension(1:11,1:lhis+maxobj) :: hcode
      integer, dimension(1:4,1:lhis+maxobj) :: lochis
      integer, dimension(1:maxobj) :: nmember
      integer :: ifield
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object
      integer, dimension(1:lelg) :: gllnid
      integer, dimension(1:lelg) :: gllel
      integer :: nio
      real :: time
      logical :: ifsync_GLOB
      real(kind=8) :: tgop_GLOB
      integer :: ngop_GLOB
      logical :: ifneknek
      real(kind=8) :: ttotal
      real(kind=8) :: etimes
      real(kind=8) :: tprep
      real(kind=8) :: ttime
      integer(kind=8) :: nvtot
      logical :: ifsplit_GLOB
      real, dimension(1:lx1,1:lx2) :: ixm21_GLOB
      real, dimension(1:ly2,1:ly1) :: iytm21_GLOB
      real, dimension(1:lz2,1:lz1) :: iztm21_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult_GLOB
      integer :: nrout
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      real(kind=8) :: tcol2
      real(kind=8) :: ta2s2_GLOB
      real, dimension(1:lx1,1:lx1) :: dxm1_GLOB
      real, dimension(1:lx1,1:lx1) :: dxtm1_GLOB
      real, dimension(1:lx1*ly1*lz1,1:lelt) :: jacmi_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rxm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sxm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: txm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: sym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tym1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: rzm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: szm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: tzm1_GLOB
      logical, dimension(1:lelt) :: ifrzer_GLOB
      real, dimension(1:ly1,1:ly1) :: dytm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      integer, dimension(1:6) :: eface1_GLOB
      integer, dimension(1:6,1:6) :: skpdat_GLOB
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area_GLOB
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx_GLOB
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny_GLOB
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1) :: trx
      real, dimension(1:lx1,1:ly1,1:lz1) :: trz
      real, intent(In) :: scale
      integer :: i
      integer :: i0
      integer :: ie
      integer :: ieg
      integer :: ifc
      integer :: ii
      integer :: iobj
      integer :: mem
      integer :: memtot
      integer :: n
      integer :: nij
      real :: x1max
      real :: x1min
      real :: x2max
      real :: x2min
      real :: x3max
      real :: x3min
      real, dimension(1:3), intent(In) :: x0
      real, dimension(0:maxobj) :: w1
      logical, intent(In) :: ifdout
      logical, intent(In) :: iftout
! Moved param decl for  lr to top of code unit
      n = lx1*ly1*lz1*nelv
      xm0_mappr = reshape(xm0,shape(xm0_mappr))
      ym0_mappr = reshape(ym0,shape(ym0_mappr))
      call mappr(pm1,pr,xm0_mappr,ym0_mappr,nelv,ifsplit_GLOB,ixm21_GLOB,iytm21_GLOB,iztm21_GLOB, &
      ifield,vmult_GLOB,nrout,rname,dct,ncall,dcount,tmxmf,tcol2)
      xm0 = reshape(xm0_mappr, shape(xm0))
      ym0 = reshape(ym0_mappr, shape(ym0))
      if (param(55) /= 0) then
         dpdx_mean = -scale_vf(1)
         dpdy_mean = -scale_vf(2)
         dpdz_mean = -scale_vf(3)
      endif
      pm1_add2s2 = reshape(pm1,shape(pm1_add2s2))
      xm1_add2s2 = reshape(xm1,shape(xm1_add2s2))
      call add2s2(pm1_add2s2,xm1_add2s2,dpdx_mean,n,ta2s2_GLOB)

      pm1 = reshape(pm1_add2s2, shape(pm1))
      xm1 = reshape(xm1_add2s2, shape(xm1))
      pm1_add2s2 = reshape(pm1,shape(pm1_add2s2))
      ym1_add2s2 = reshape(ym1,shape(ym1_add2s2))
      call add2s2(pm1_add2s2,ym1_add2s2,dpdy_mean,n,ta2s2_GLOB)

      pm1 = reshape(pm1_add2s2, shape(pm1))
      ym1 = reshape(ym1_add2s2, shape(ym1))
      pm1_add2s2 = reshape(pm1,shape(pm1_add2s2))
      zm1_add2s2 = reshape(zm1,shape(zm1_add2s2))
      call add2s2(pm1_add2s2,zm1_add2s2,dpdz_mean,n,ta2s2_GLOB)

      pm1 = reshape(pm1_add2s2, shape(pm1))
      zm1 = reshape(zm1_add2s2, shape(zm1))
      nij = 3
      if (if3d.or.ifaxis) nij=6
      vx_comp_sij = reshape(vx,shape(vx_comp_sij))
      vy_comp_sij = reshape(vy,shape(vy_comp_sij))
      vz_comp_sij = reshape(vz,shape(vz_comp_sij))
      call comp_sij(sij,nij,vx_comp_sij,vy_comp_sij,vz_comp_sij,ur,us,ut,vr,vs,vt,wr,ws,wt,if3d, &
      nelv,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB, &
      tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB,ifaxis,ifrzer_GLOB,dytm1_GLOB,ym1,nrout,rname,dct, &
      ncall,dcount,tmxmf,dym1,dam1,datm1,dcm1,dctm1)
      vx = reshape(vx_comp_sij, shape(vx))
      vy = reshape(vy_comp_sij, shape(vy))
      vz = reshape(vz_comp_sij, shape(vz))
      vdiff_cfill = reshape(vdiff,shape(vdiff_cfill))
      call cfill(vdiff_cfill,param(2),n)

      vdiff = reshape(vdiff_cfill, shape(vdiff))
      xm0_cadd2 = reshape(xm0,shape(xm0_cadd2))
      xm1_cadd2 = reshape(xm1,shape(xm1_cadd2))
      call cadd2(xm0_cadd2,xm1_cadd2,-x0(1),n)

      xm0 = reshape(xm0_cadd2, shape(xm0))
      xm1 = reshape(xm1_cadd2, shape(xm1))
      ym0_cadd2 = reshape(ym0,shape(ym0_cadd2))
      ym1_cadd2 = reshape(ym1,shape(ym1_cadd2))
      call cadd2(ym0_cadd2,ym1_cadd2,-x0(2),n)

      ym0 = reshape(ym0_cadd2, shape(ym0))
      ym1 = reshape(ym1_cadd2, shape(ym1))
      zm0_cadd2 = reshape(zm0,shape(zm0_cadd2))
      zm1_cadd2 = reshape(zm1,shape(zm1_cadd2))
      call cadd2(zm0_cadd2,zm1_cadd2,-x0(3),n)

      zm0 = reshape(zm0_cadd2, shape(zm0))
      zm1 = reshape(zm1_cadd2, shape(zm1))
      x1min = glmin(xm0(1,1,1,1),n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      x2min = glmin(ym0(1,1,1,1),n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      x3min = glmin(zm0(1,1,1,1),n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      x1max = glmax(xm0(1,1,1,1),n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      x2max = glmax(ym0(1,1,1,1),n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      x3max = glmax(zm0(1,1,1,1),n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB,tgop_GLOB, &
      ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      do i=0,maxobj
         dragpx(i) = 0   
         dragvx(i) = 0
         dragx (i) = 0
         dragpy(i) = 0
         dragvy(i) = 0
         dragy (i) = 0
         dragpz(i) = 0
         dragvz(i) = 0
         dragz (i) = 0
         torqpx(i) = 0
         torqvx(i) = 0
         torqx (i) = 0
         torqpy(i) = 0
         torqvy(i) = 0
         torqy (i) = 0
         torqpz(i) = 0
         torqvz(i) = 0
         torqz (i) = 0
      enddo
      nobj = 0
      do ii=1,nhis
        if (hcode(10,ii) == 'I') then
          iobj   = lochis(1,ii)
          memtot = nmember(iobj)
          nobj   = max(iobj,nobj)
          if (hcode(1,ii) /= ' ' .or. hcode(2,ii) /= ' ' .or.      hcode(3,ii) /= ' ' ) then
            ifield = 1
            do mem=1,memtot
               ieg   = object(iobj,mem,1)
               ifc   = object(iobj,mem,2)
               if (gllnid(ieg) == nid) then 
                  ie = gllel(ieg)
                  vdiff_drgtrq = reshape(vdiff,shape(vdiff_drgtrq))
                  call drgtrq(dgtq,xm0,ym0,zm0,sij,pm1,vdiff_drgtrq,ifc,ie,eface1_GLOB,skpdat_GLOB, &
      if3d,ifaxis,area_GLOB,unx_GLOB,uny_GLOB,unz_GLOB)
                  vdiff = reshape(vdiff_drgtrq, shape(vdiff))
                  dgtq_cmult = reshape(dgtq,shape(dgtq_cmult))
                  call cmult(dgtq_cmult,scale,12)

                  dgtq = reshape(dgtq_cmult, shape(dgtq))
                  dragpx(iobj) = dragpx(iobj) + dgtq(1,1)  
                  dragpy(iobj) = dragpy(iobj) + dgtq(2,1)
                  dragpz(iobj) = dragpz(iobj) + dgtq(3,1)
                  dragvx(iobj) = dragvx(iobj) + dgtq(1,2)  
                  dragvy(iobj) = dragvy(iobj) + dgtq(2,2)
                  dragvz(iobj) = dragvz(iobj) + dgtq(3,2)
                  torqpx(iobj) = torqpx(iobj) + dgtq(1,3)  
                  torqpy(iobj) = torqpy(iobj) + dgtq(2,3)
                  torqpz(iobj) = torqpz(iobj) + dgtq(3,3)
                  torqvx(iobj) = torqvx(iobj) + dgtq(1,4)  
                  torqvy(iobj) = torqvy(iobj) + dgtq(2,4)
                  torqvz(iobj) = torqvz(iobj) + dgtq(3,4)
               endif
            enddo
          endif
        endif
      enddo
      dragpx_gop = reshape(dragpx,shape(dragpx_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(dragpx_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      dragpx = reshape(dragpx_gop, shape(dragpx))
      w1 = reshape(w1_gop, shape(w1))
      dragpy_gop = reshape(dragpy,shape(dragpy_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(dragpy_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      dragpy = reshape(dragpy_gop, shape(dragpy))
      w1 = reshape(w1_gop, shape(w1))
      dragpz_gop = reshape(dragpz,shape(dragpz_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(dragpz_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      dragpz = reshape(dragpz_gop, shape(dragpz))
      w1 = reshape(w1_gop, shape(w1))
      dragvx_gop = reshape(dragvx,shape(dragvx_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(dragvx_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      dragvx = reshape(dragvx_gop, shape(dragvx))
      w1 = reshape(w1_gop, shape(w1))
      dragvy_gop = reshape(dragvy,shape(dragvy_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(dragvy_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      dragvy = reshape(dragvy_gop, shape(dragvy))
      w1 = reshape(w1_gop, shape(w1))
      dragvz_gop = reshape(dragvz,shape(dragvz_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(dragvz_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      dragvz = reshape(dragvz_gop, shape(dragvz))
      w1 = reshape(w1_gop, shape(w1))
      torqpx_gop = reshape(torqpx,shape(torqpx_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(torqpx_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      torqpx = reshape(torqpx_gop, shape(torqpx))
      w1 = reshape(w1_gop, shape(w1))
      torqpy_gop = reshape(torqpy,shape(torqpy_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(torqpy_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      torqpy = reshape(torqpy_gop, shape(torqpy))
      w1 = reshape(w1_gop, shape(w1))
      torqpz_gop = reshape(torqpz,shape(torqpz_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(torqpz_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      torqpz = reshape(torqpz_gop, shape(torqpz))
      w1 = reshape(w1_gop, shape(w1))
      torqvx_gop = reshape(torqvx,shape(torqvx_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(torqvx_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      torqvx = reshape(torqvx_gop, shape(torqvx))
      w1 = reshape(w1_gop, shape(w1))
      torqvy_gop = reshape(torqvy,shape(torqvy_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(torqvy_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      torqvy = reshape(torqvy_gop, shape(torqvy))
      w1 = reshape(w1_gop, shape(w1))
      torqvz_gop = reshape(torqvz,shape(torqvz_gop))
      w1_gop = reshape(w1,shape(w1_gop))
      call gop(torqvz_gop,w1_gop,'+  ',maxobj+1,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync_GLOB, &
      tgop_GLOB,ngop_GLOB,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot)
      torqvz = reshape(torqvz_gop, shape(torqvz))
      w1 = reshape(w1_gop, shape(w1))
      nobj  = iglmax(nobj,1,icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek,ttotal,etimes,tprep, &
      ttime,istep,nvtot,ifsync_GLOB,tgop_GLOB,ngop_GLOB)
      do i=1,nobj
         dragx(i) = dragpx(i) + dragvx(i)
         dragy(i) = dragpy(i) + dragvy(i)
         dragz(i) = dragpz(i) + dragvz(i)
         torqx(i) = torqpx(i) + torqvx(i)
         torqy(i) = torqpy(i) + torqvy(i)
         torqz(i) = torqpz(i) + torqvz(i)
         dragpx(0) = dragpx (0) + dragpx (i)
         dragvx(0) = dragvx (0) + dragvx (i)
         dragx (0) = dragx  (0) + dragx  (i)
         dragpy(0) = dragpy (0) + dragpy (i)
         dragvy(0) = dragvy (0) + dragvy (i)
         dragy (0) = dragy  (0) + dragy  (i)
         dragpz(0) = dragpz (0) + dragpz (i)
         dragvz(0) = dragvz (0) + dragvz (i)
         dragz (0) = dragz  (0) + dragz  (i)
         torqpx(0) = torqpx (0) + torqpx (i)
         torqvx(0) = torqvx (0) + torqvx (i)
         torqx (0) = torqx  (0) + torqx  (i)
         torqpy(0) = torqpy (0) + torqpy (i)
         torqvy(0) = torqvy (0) + torqvy (i)
         torqy (0) = torqy  (0) + torqy  (i)
         torqpz(0) = torqpz (0) + torqpz (i)
         torqvz(0) = torqvz (0) + torqvz (i)
         torqz (0) = torqz  (0) + torqz  (i)
      enddo
      i0 = 0
      if (nobj <= 1) i0 = 1  
      do i=i0,nobj
        if (nio == 0) then
          if (if3d.or.ifaxis) then
           if (ifdout) then
            write(6,6) istep,time,dragx(i),dragpx(i),dragvx(i),i,'dragx'
            write(6,6) istep,time,dragy(i),dragpy(i),dragvy(i),i,'dragy'
            write(6,6) istep,time,dragz(i),dragpz(i),dragvz(i),i,'dragz'
           endif
           if (iftout) then
            write(6,6) istep,time,torqx(i),torqpx(i),torqvx(i),i,'torqx'
            write(6,6) istep,time,torqy(i),torqpy(i),torqvy(i),i,'torqy'
            write(6,6) istep,time,torqz(i),torqpz(i),torqvz(i),i,'torqz'
           endif
          else
           if (ifdout) then
            write(6,6) istep,time,dragx(i),dragpx(i),dragvx(i),i,'dragx'
            write(6,6) istep,time,dragy(i),dragpy(i),dragvy(i),i,'dragy'
           endif
           if (iftout) then
            write(6,6) istep,time,torqz(i),torqpz(i),torqvz(i),i,'torqz'
           endif
          endif
        endif
    6   format(i8,1p4e19.11,2x,i5,a5)
      enddo
      trx(1:lx1,1:ly1,1:lz1) = xm0(1,1,1,1:512)
      trz(1:lx1,1:ly1,1:lz1) = xm0(1,1,1,513:1024)
      return
      end subroutine torque_calc
      subroutine comp_sij(sij,nij,u,v,w,ur,us,ut,vr,vs,vt,wr,ws,wt,if3d,nelv,dxm1,dxtm1,jacmi,rxm1, &
      sxm1,txm1,rym1,sym1,tym1,rzm1,szm1,tzm1,ifaxis,ifrzer,dytm1,ym1,nrout,rname,dct,ncall, &
      dcount,tmxmf,dym1_GLOB,dam1_GLOB,datm1_GLOB,dcm1_GLOB,dctm1_GLOB)
      use params_SIZE, only : lelv, ly1, lelt, lx1, lz1
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      logical, intent(In) :: if3d
      integer, intent(In) :: nelv
      real, dimension(1:lx1,1:lx1), intent(In) :: dxm1
      real, dimension(1:lx1,1:lx1), intent(In) :: dxtm1
      real, dimension(1:lx1*ly1*lz1,1:lelt), intent(In) :: jacmi
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sxm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: txm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: sym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: rzm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: szm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: tzm1
      logical, intent(In) :: ifaxis
      logical, dimension(1:lelt), intent(In) :: ifrzer
      real, dimension(1:ly1,1:ly1), intent(InOut) :: dytm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym1
      integer :: nrout
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: v_local_grad2
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: v_local_grad3
      real, dimension(0:n,0:n) :: vr_local_grad2
      real, dimension(0:n,0:n,0:n) :: vr_local_grad3
      real, dimension(0:n,0:n) :: vs_local_grad2
      real, dimension(0:n,0:n,0:n) :: vs_local_grad3
      real, dimension(0:n,0:n,0:n) :: vt_local_grad3
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: w_local_grad2
      real, dimension(1:lx1*ly1*lz1,1:lelv) :: w_local_grad3
      real, dimension(0:n,0:n) :: wr_local_grad2
      real, dimension(0:n,0:n,0:n) :: wr_local_grad3
      real, dimension(0:n,0:n) :: ws_local_grad2
      real, dimension(0:n,0:n,0:n) :: ws_local_grad3
      real, dimension(0:n,0:n,0:n) :: wt_local_grad3
            integer, parameter :: maxrts=1000
      character(len=6), dimension(1:maxrts) :: rname
      real(kind=8), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8) :: dcount
      real(kind=8) :: tmxmf
      real, dimension(1:ly1,1:ly1) :: dym1_GLOB
      real, dimension(1:ly1,1:ly1) :: dam1_GLOB
      real, dimension(1:ly1,1:ly1) :: datm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dcm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dctm1_GLOB
      integer :: nij
      integer :: n
      integer :: nxyz
      integer :: i
      real :: r
      integer :: e
      real, dimension(1:lx1*ly1*lz1,1:nij,1:lelv), intent(Out) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(In) :: u
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: v
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: w
      real, dimension(1:1), intent(InOut) :: ur
      real, dimension(1:1), intent(InOut) :: us
      real, dimension(1:1), intent(InOut) :: ut
      real, dimension(1:1), intent(InOut) :: vr
      real, dimension(1:1), intent(InOut) :: vs
      real, dimension(1:1), intent(InOut) :: vt
      real, dimension(1:1), intent(InOut) :: wr
      real, dimension(1:1), intent(InOut) :: ws
      real, dimension(1:1), intent(InOut) :: wt
      real :: j
      n    = lx1-1      
      nxyz = lx1*ly1*lz1
      if (if3d) then     
       do e=1,nelv
        call local_grad3(ur,us,ut,u,n,e,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)

        vr_local_grad3 = reshape(vr,shape(vr_local_grad3))
        vs_local_grad3 = reshape(vs,shape(vs_local_grad3))
        vt_local_grad3 = reshape(vt,shape(vt_local_grad3))
        v_local_grad3 = reshape(v,shape(v_local_grad3))
        call local_grad3(vr_local_grad3,vs_local_grad3,vt_local_grad3,v_local_grad3,n,e,dxm1,dxtm1, &
      nrout,rname,dct,ncall,dcount,tmxmf)
        vr = reshape(vr_local_grad3, shape(vr))
        vs = reshape(vs_local_grad3, shape(vs))
        vt = reshape(vt_local_grad3, shape(vt))
        v = reshape(v_local_grad3, shape(v))
        wr_local_grad3 = reshape(wr,shape(wr_local_grad3))
        ws_local_grad3 = reshape(ws,shape(ws_local_grad3))
        wt_local_grad3 = reshape(wt,shape(wt_local_grad3))
        w_local_grad3 = reshape(w,shape(w_local_grad3))
        call local_grad3(wr_local_grad3,ws_local_grad3,wt_local_grad3,w_local_grad3,n,e,dxm1,dxtm1, &
      nrout,rname,dct,ncall,dcount,tmxmf)
        wr = reshape(wr_local_grad3, shape(wr))
        ws = reshape(ws_local_grad3, shape(ws))
        wt = reshape(wt_local_grad3, shape(wt))
        w = reshape(w_local_grad3, shape(w))
        do i=1,nxyz
         j = jacmi(i,e)
         sij(i,1,e) = j*     2*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e)+ut(i)*txm1(i,1,1,e))
         sij(i,2,e) = j*     2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e)+vt(i)*tym1(i,1,1,e))
         sij(i,3,e) = j*     2*(wr(i)*rzm1(i,1,1,e)+ws(i)*szm1(i,1,1,e)+wt(i)*tzm1(i,1,1,e))
         sij(i,4,e) = j*     (ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1,e)+ut(i)*tym1(i,1,1, &
      e) +    vr(i)*rxm1(i,1,1,e)+vs(i)*sxm1(i,1,1,e)+vt(i)*txm1(i,1,1,e) )
         sij(i,5,e) = j*     (wr(i)*rym1(i,1,1,e)+ws(i)*sym1(i,1,1,e)+wt(i)*tym1(i,1,1, &
      e) +    vr(i)*rzm1(i,1,1,e)+vs(i)*szm1(i,1,1,e)+vt(i)*tzm1(i,1,1,e) )
         sij(i,6,e) = j*     (ur(i)*rzm1(i,1,1,e)+us(i)*szm1(i,1,1,e)+ut(i)*tzm1(i,1,1, &
      e) +    wr(i)*rxm1(i,1,1,e)+ws(i)*sxm1(i,1,1,e)+wt(i)*txm1(i,1,1,e) )
        enddo
       enddo
      elseif (ifaxis) then  
         do e=1,nelv
            call setaxdy(ifrzer(e),dym1_GLOB,dam1_GLOB,dytm1,datm1_GLOB,dcm1_GLOB,dctm1_GLOB)

            call local_grad2(ur,us,u,n,e,dxm1,dytm1,nrout,rname,dct,ncall,dcount,tmxmf)

            vr_local_grad2 = reshape(vr,shape(vr_local_grad2))
            vs_local_grad2 = reshape(vs,shape(vs_local_grad2))
            v_local_grad2 = reshape(v,shape(v_local_grad2))
            call local_grad2(vr_local_grad2,vs_local_grad2,v_local_grad2,n,e,dxm1,dytm1,nrout,rname, &
      dct,ncall,dcount,tmxmf)
            vr = reshape(vr_local_grad2, shape(vr))
            vs = reshape(vs_local_grad2, shape(vs))
            v = reshape(v_local_grad2, shape(v))
            wr_local_grad2 = reshape(wr,shape(wr_local_grad2))
            ws_local_grad2 = reshape(ws,shape(ws_local_grad2))
            w_local_grad2 = reshape(w,shape(w_local_grad2))
            call local_grad2(wr_local_grad2,ws_local_grad2,w_local_grad2,n,e,dxm1,dytm1,nrout,rname, &
      dct,ncall,dcount,tmxmf)
            wr = reshape(wr_local_grad2, shape(wr))
            ws = reshape(ws_local_grad2, shape(ws))
            w = reshape(w_local_grad2, shape(w))
            do i=1,nxyz
               j = jacmi(i,e)
               r = ym1(i,1,1,e)                              
               sij(i,1,e) = j*             2*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e))
               sij(i,2,e) = j*             2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e))
               if (r > 0) then                              
                  sij(i,3,e) = v(i,e)/r  
               else
                  sij(i,3,e) = j*              2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e))
               endif
               sij(i,4,e) = j*              ( ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1, &
      e) +              vr(i)*rxm1(i,1,1,e)+vs(i)*sxm1(i,1,1,e) )
               if (r > 0) then                             
                  sij(i,5,e) = j*                ( wr(i)*rym1(i,1,1,e)+ws(i)*sym1(i,1,1, &
      e) )              - w(i,e) / r
               else
                  sij(i,5,e) = 0
               endif
               sij(i,6,e) = j*              ( wr(i)*rxm1(i,1,1,e)+ws(i)*sxm1(i,1,1,e) )
            enddo
         enddo
      else              
         do e=1,nelv
            call local_grad2(ur,us,u,n,e,dxm1,dxtm1,nrout,rname,dct,ncall,dcount,tmxmf)

            vr_local_grad2 = reshape(vr,shape(vr_local_grad2))
            vs_local_grad2 = reshape(vs,shape(vs_local_grad2))
            v_local_grad2 = reshape(v,shape(v_local_grad2))
            call local_grad2(vr_local_grad2,vs_local_grad2,v_local_grad2,n,e,dxm1,dxtm1,nrout,rname, &
      dct,ncall,dcount,tmxmf)
            vr = reshape(vr_local_grad2, shape(vr))
            vs = reshape(vs_local_grad2, shape(vs))
            v = reshape(v_local_grad2, shape(v))
            do i=1,nxyz
               j = jacmi(i,e)
               sij(i,1,e) = j*             2*(ur(i)*rxm1(i,1,1,e)+us(i)*sxm1(i,1,1,e))
               sij(i,2,e) = j*             2*(vr(i)*rym1(i,1,1,e)+vs(i)*sym1(i,1,1,e))
               sij(i,3,e) = j*             (ur(i)*rym1(i,1,1,e)+us(i)*sym1(i,1,1, &
      e) +            vr(i)*rxm1(i,1,1,e)+vs(i)*sxm1(i,1,1,e) )
            enddo
         enddo
      endif
      return
      end subroutine comp_sij

end module singleton_module_src_navier5


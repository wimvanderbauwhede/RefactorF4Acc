module singleton_module_src_abl

!      use singleton_module_src_comm_mpi
      use singleton_module_src_postpro
      use singleton_module_src_navier5
!      use singleton_module_src_math
contains

      subroutine userchk(base_flow,cs,dg2,dgtq,domain_length,dpdx_mean,dpdy_mean,dpdz_mean,dragpx, &
      dragpy,dragpz,dragvx,dragvy,dragvz,dragx,dragy,dragz,ediff,ffx_new,ffy_new,ffz_new, &
      flow_rate,icall,nekcomm,nekgroup,nekreal,nid,np,pm1,scale_vf,sij,snrm,torqpx,torqpy,torqpz, &
      torqvx,torqvy,torqvz,torqx,torqy,torqz,trx,trz,ur,us,ut,utldo,vr,vs,vt,wr,ws,wt,xm0,xsec, &
      ym0,zm0,nelv,nx1,ny1,nz1,ifuservp,t,istep,vx,ym1,iostep,pr,ndim_GLOB,jp_GLOB,xm1_GLOB, &
      zm1_GLOB,vy_GLOB,vz_GLOB,nelt_GLOB,param_GLOB,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB, &
      rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB, &
      ifaxis_GLOB,nrout,rname,dct,ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime,nvtot, &
      ifsync,tgop,ngop,nobj_GLOB,nhis_GLOB,hcode_GLOB,lochis_GLOB,cbc_GLOB,nmember_GLOB, &
      lglel_GLOB,object_GLOB,bm1_GLOB,volvm1_GLOB,dt_GLOB,vdiff_GLOB,ifield_GLOB,gllnid_GLOB, &
      gllel_GLOB,nio_GLOB,time_GLOB,ifsplit,ixm21,iytm21,iztm21,vmult,tcol2,ta2s2,ifrzer_GLOB, &
      dytm1_GLOB,dym1,dam1,datm1,dcm1,dctm1,eface1,skpdat,area,unx,uny,unz)
      use params_SIZE, only : lelv, lhis, lelt, ldimt1, ldimt, lx2, maxobj, lelg, lz2, ldim, ly1, &
       lx1, lz1, ly2, maxmbr
!!      use params_TOTAL ! ONLY LIST EMPTY
!!      use params_ZPER ! ONLY LIST EMPTY
      implicit none
      integer, parameter :: maxrts=1000
      integer, parameter :: lr=lx1*ly1*lz1
      integer, parameter :: lxyz=lx1*ly1*lz1
      real :: base_flow
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: cs
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: dg2
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
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: ediff
      real, intent(InOut) :: ffx_new
      real :: ffy_new
      real :: ffz_new
      real :: flow_rate
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(InOut) :: pm1
      real, dimension(1:3), intent(In) :: scale_vf
      real, dimension(1:lx1*ly1*lz1*6*lelv), intent(InOut) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: snrm
      real, dimension(0:maxobj), intent(InOut) :: torqpx
      real, dimension(0:maxobj), intent(InOut) :: torqpy
      real, dimension(0:maxobj), intent(InOut) :: torqpz
      real, dimension(0:maxobj), intent(InOut) :: torqvx
      real, dimension(0:maxobj), intent(InOut) :: torqvy
      real, dimension(0:maxobj), intent(InOut) :: torqvz
      real, dimension(0:maxobj), intent(InOut) :: torqx
      real, dimension(0:maxobj), intent(InOut) :: torqy
      real, dimension(0:maxobj), intent(InOut) :: torqz
      real, dimension(1:lx1,1:ly1,1:lz1) :: trx
      real, dimension(1:lx1,1:ly1,1:lz1) :: trz
      real, dimension(1:lxyz), intent(InOut) :: ur
      real, dimension(1:lxyz), intent(InOut) :: us
      real, dimension(1:lxyz), intent(InOut) :: ut
      real, dimension(1:ldim), intent(InOut) :: utldo
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
      integer, intent(In) :: nelv
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      logical, intent(In) :: ifuservp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt), intent(InOut) :: t
      integer, intent(In) :: istep
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym1
      integer, intent(In) :: iostep
      real, dimension(1:lx2,1:ly2,1:lz2,1:lelv), intent(In) :: pr
      integer :: ndim_GLOB
      integer :: jp_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: xm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: zm1_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vy_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vz_GLOB
      integer :: nelt_GLOB
      real, dimension(1:200) :: param_GLOB
      logical :: if3d_GLOB
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
      logical :: ifaxis_GLOB
      integer :: nrout
      character(len=6     ), dimension(1:maxrts) :: rname
      real(kind=8          ), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8          ) :: dcount
      real(kind=8          ) :: tmxmf
      logical :: ifneknek
      real(kind=8          ) :: ttotal
      real(kind=8          ) :: etimes
      real(kind=8          ) :: tprep
      real(kind=8          ) :: ttime
      integer(kind=8 ) :: nvtot
      logical :: ifsync
      real(kind=8          ) :: tgop
      integer :: ngop
      integer :: nobj_GLOB
      integer :: nhis_GLOB
      character(len=1     ), dimension(1:11,1:lhis+maxobj) :: hcode_GLOB
      integer, dimension(1:4,1:lhis+maxobj) :: lochis_GLOB
      character(len=3     ), dimension(1:6,1:lelt,0:ldimt1) :: cbc_GLOB
      integer, dimension(1:maxobj) :: nmember_GLOB
      integer, dimension(1:lelt) :: lglel_GLOB
      integer, dimension(1:maxobj,1:maxmbr,1:2) :: object_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt) :: bm1_GLOB
      real :: volvm1_GLOB
      real :: dt_GLOB
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt,1:ldimt1) :: vdiff_GLOB
      integer :: ifield_GLOB
      integer, dimension(1:lelg) :: gllnid_GLOB
      integer, dimension(1:lelg) :: gllel_GLOB
      integer :: nio_GLOB
      real :: time_GLOB
      logical :: ifsplit
      real, dimension(1:lx1,1:lx2) :: ixm21
      real, dimension(1:ly2,1:ly1) :: iytm21
      real, dimension(1:lz2,1:lz1) :: iztm21
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vmult
      real(kind=8          ) :: tcol2
      real(kind=8          ) :: ta2s2
      logical, dimension(1:lelt) :: ifrzer_GLOB
      real, dimension(1:ly1,1:ly1) :: dytm1_GLOB
      real, dimension(1:ly1,1:ly1) :: dym1
      real, dimension(1:ly1,1:ly1) :: dam1
      real, dimension(1:ly1,1:ly1) :: datm1
      real, dimension(1:ly1,1:ly1) :: dcm1
      real, dimension(1:ly1,1:ly1) :: dctm1
      integer, dimension(1:6) :: eface1
      integer, dimension(1:6,1:6) :: skpdat
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: area
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unx
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: uny
      real, dimension(1:lx1,1:lz1,1:6,1:lelt) :: unz
      integer :: n
      integer :: ngll
      real :: rho
      real :: a_w
      real :: xlen
      real :: zlen
      integer :: kappa
      integer :: e
      integer :: i
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: gradux
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: graduy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: graduz
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: vgrad
      real, dimension(1:3) :: x0
      real :: utau
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv) :: utauv
      save x0
      call set_grid_spacing(dg2,ndim_GLOB,nelv,nx1,ny1,nz1,jp_GLOB,xm1_GLOB,ym1,zm1_GLOB)
      n=nx1*ny1*nz1*nelv
      ngll=nx1*ny1*nz1
      if(ifuservp) then
        if(nid == 0) write(6,*) 'Calculating eddy viscosity'
        do e=1,nelv
           call eddy_visc(e,cs,dg2,ediff,icall,nekcomm,nekgroup,nekreal,nid,np,sij,snrm,nx1,ny1,nz1, &
      vx,vy_GLOB,vz_GLOB,nelt_GLOB,nelv,ym1,param_GLOB,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB, &
      rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB, &
      ifaxis_GLOB,nrout,rname,dct,ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime,istep, &
      nvtot,ifsync,tgop,ngop)
        enddo
        call copy(t,ediff,n)
      endif
      if (istep == 0) then
         call set_obj(icall,nekcomm,nekgroup,nekreal,nid,np,nobj_GLOB,nhis_GLOB,hcode_GLOB, &
      lochis_GLOB,nx1,ny1,nz1,nelv,ndim_GLOB,cbc_GLOB,nmember_GLOB,lglel_GLOB,object_GLOB, &
      ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
         call rzero(x0,3)
      endif
      ! WV was just vx
      call set_forcing(ffx_new,vx(1,1,1,1),1,icall,nekcomm,nekgroup,nekreal,nid,np,utldo,nelv,nx1,ny1,nz1, &
      !call set_forcing(ffx_new,vx,1,icall,nekcomm,nekgroup,nekreal,nid,np,utldo,nelv,nx1,ny1,nz1, &
      istep,param_GLOB,bm1_GLOB,volvm1_GLOB,dt_GLOB,ifsync,tgop,ngop,ifneknek,ttotal,etimes,tprep, &
      ttime,nvtot)
      call torque_calc(1.0,x0,.false.,.false.,dragx,dragpx,dragvx,dragy,dragpy,dragvy,dragz,dragpz, &
      dragvz,torqx,torqpx,torqvx,torqy,torqpy,torqvy,torqz,torqpz,torqvz,dpdx_mean,dpdy_mean, &
      dpdz_mean,dgtq,flow_rate,base_flow,domain_length,xsec,scale_vf,pm1,sij,ur,us,ut,vr,vs,vt,wr, &
      ws,wt,trx,trz,xm0,ym0,zm0)
      rho    = 1.
      a_w    = xlen * zlen
      utau= sqrt(dragx(1)**2+dragz(1)**2)/a_w
      utau=sqrt(utau)
      call gradm1(gradux,graduy,graduz,vx,ur,us,ut,nelt_GLOB,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB, &
      jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB, &
      tzm1_GLOB,ifaxis_GLOB,ifrzer_GLOB,dytm1_GLOB,nrout,rname,dct,ncall,dcount,tmxmf,dym1,dam1, &
      datm1,dcm1,dctm1)
      do i=1,n
      vgrad(i,1,1,1)=kappa*ym1(i,1,1,1)/utau*graduy(i,1,1,1)
      utauv(i,1,1,1)=utau
      enddo
      if (mod(istep,iostep) == 0) call outpost(dg2,vgrad,ediff,pr,t,'vgr')
      return
      end subroutine userchk
      subroutine eddy_visc(e,cs,dg2,ediff,icall,nekcomm,nekgroup,nekreal,nid,np,sij,snrm,nx1,ny1, &
      nz1,vx,vy,vz,nelt,nelv,ym1,param,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB,rxm1_GLOB, &
      sxm1_GLOB,txm1_GLOB,rym1_GLOB,sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB,ifaxis_GLOB, &
      nrout,rname,dct,ncall,dcount,tmxmf,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync, &
      tgop,ngop)
      use params_SIZE, only : lelv, lx1, ly1, lelt, lz1, ldim
!!      use params_TOTAL ! ONLY LIST EMPTY
!!      use params_ZPER ! ONLY LIST EMPTY
      implicit none
       integer, parameter :: maxrts=1000
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: dg2
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(Out) :: ediff
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vx
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vy
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelv), intent(In) :: vz
      integer, intent(In) :: nelt
      integer, intent(In) :: nelv
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym1
      real, dimension(1:200), intent(In) :: param
      logical :: if3d_GLOB
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
      logical :: ifaxis_GLOB
      integer :: nrout
      character(len=6     ), dimension(1:maxrts) :: rname
      real(kind=8          ), dimension(1:maxrts) :: dct
      integer, dimension(1:maxrts) :: ncall
      real(kind=8          ) :: dcount
      real(kind=8          ) :: tmxmf
      logical :: ifneknek
      real(kind=8          ) :: ttotal
      real(kind=8          ) :: etimes
      real(kind=8          ) :: tprep
      real(kind=8          ) :: ttime
      integer :: istep
      integer(kind=8 ) :: nvtot
      logical :: ifsync
      real(kind=8          ) :: tgop
      integer :: ngop
      integer :: ntot
      integer :: i
      real :: c0
      integer :: npow
      integer :: kappa
      real :: y0
      integer, intent(In) :: e
      real, dimension(1:lx1*ly1*lz1,1:ldim,1:ldim), intent(InOut) :: sij
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: snrm
      real, dimension(1:lx1*ly1*lz1,1:lelv), intent(InOut) :: cs
      real :: csa
      real :: csb
      ntot = nx1*ny1*nz1
      call comp_gije(sij,vx(1,1,1,e),vy(1,1,1,e),vz(1,1,1,e),e,icall,nekcomm,nekgroup,nekreal,nid, &
      np,if3d_GLOB,dxm1_GLOB,dxtm1_GLOB,jacmi_GLOB,rxm1_GLOB,sxm1_GLOB,txm1_GLOB,rym1_GLOB, &
      sym1_GLOB,tym1_GLOB,rzm1_GLOB,szm1_GLOB,tzm1_GLOB,ifaxis_GLOB,nrout,rname,dct,ncall,dcount, &
      tmxmf,ifneknek,ttotal,etimes,tprep,ttime,istep,nvtot,ifsync,tgop,ngop)
      call comp_sije(sij)
      call mag_tensor_e(snrm(1,e),sij)
      call cmult(snrm(1,e),2.0,ntot)
      ntot = nx1*ny1*nz1*nelt
      if (e == nelv) then
        do i=1,ntot
            csa=1/(c0**npow)
            csb=(sqrt(dg2(i,1,1,1))/(kappa*(ym1(i,1,1,1)+y0)))**npow
            cs(i,1)=(csa+csb)**(-1/npow)
            ediff(i,1,1,1) = param(2)+cs(i,1)*dg2(i,1,1,1)*snrm(i,1)
        enddo
      endif
      return
      end subroutine eddy_visc
      subroutine set_grid_spacing(dg2,ndim,nelv,nx1,ny1,nz1,jp,xm1,ym1,zm1)
      use params_SIZE, only : lx1, lelt, ly1, lz1
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: ndim
      integer, intent(In) :: nelv
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      integer, intent(InOut) :: jp
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: xm1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: ym1
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: zm1
      real :: gamma
      integer :: n
      integer :: k
      integer :: km
      integer :: kp
      integer :: j
      integer :: jm
      integer :: i
      integer :: im
      integer :: ip
      real :: di
      real :: dj
      real :: dk
      real, dimension(1:nx1,1:ny1,1:nz1,1:nelv), intent(InOut) :: dg2
      integer :: e
      integer :: eg
      integer :: ex
      integer :: ey
      integer :: ez
      gamma = 1.
      gamma = gamma/ndim
      n = nx1*ny1*nz1*nelv
      call rone(dg2,n)
      do e=1,nelv
         do k=1,nz1
           km = max(1  ,k-1)
           kp = min(nz1,k+1)
           do j=1,ny1
             jm = max(1  ,j-1)
             jp = min(ny1,j+1)
             do i=1,nx1
               im = max(1  ,i-1)
               ip = min(nx1,i+1)
               di = (xm1(ip,j,k,e)-xm1(im,j,k,e))**2+ (ym1(ip,j,k,e)-ym1(im,j,k,e))**2+ (zm1(ip,j,k, &
      e)-zm1(im,j,k,e))**2
               dj = (xm1(i,jp,k,e)-xm1(i,jm,k,e))**2+ (ym1(i,jp,k,e)-ym1(i,jm,k,e))**2+ (zm1(i,jp,k, &
      e)-zm1(i,jm,k,e))**2
               dk = (xm1(i,j,kp,e)-xm1(i,j,km,e))**2+ (ym1(i,j,kp,e)-ym1(i,j,km,e))**2+ (zm1(i,j,kp, &
      e)-zm1(i,j,km,e))**2
               di = di/(ip-im)
               dj = dj/(jp-jm)
               dk = dk/(kp-km)
               dg2(i,j,k,e) = (di*dj*dk)**gamma
             enddo
           enddo
         enddo
      enddo
      call dsavg(dg2)  
      return
      end subroutine set_grid_spacing
      subroutine set_obj(icall,nekcomm,nekgroup,nekreal,nid,np,nobj,nhis,hcode,lochis,nx1,ny1,nz1, &
      nelv,ndim,cbc,nmember,lglel,object,ifneknek_GLOB,ttotal,etimes,tprep,ttime,istep,nvtot, &
      ifsync,tgop,ngop)
      use params_SIZE, only : lelt, lhis, maxobj, maxmbr, ldimt1
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer, intent(In) :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer, intent(In) :: nid
      integer, intent(In) :: np
      integer, intent(InOut) :: nobj
      integer, intent(InOut) :: nhis
      character(len=1     ), dimension(1:11,1:lhis+maxobj), intent(Out) :: hcode
      integer, dimension(1:4,1:lhis+maxobj), intent(Out) :: lochis
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      integer, intent(In) :: nelv
      integer, intent(In) :: ndim
      character(len=3     ), dimension(1:6,1:lelt,0:ldimt1), intent(In) :: cbc
      integer, dimension(1:maxobj), intent(InOut) :: nmember
      integer, dimension(1:lelt), intent(In) :: lglel
      integer, dimension(1:maxobj,1:maxmbr,1:2), intent(Out) :: object
      logical :: ifneknek_GLOB
      real(kind=8          ) :: ttotal
      real(kind=8          ) :: etimes
      real(kind=8          ) :: tprep
      real(kind=8          ) :: ttime
      integer :: istep
      integer(kind=8 ) :: nvtot
      logical :: ifsync
      real(kind=8          ) :: tgop
      integer :: ngop
      integer :: iobj
      integer :: ii
      integer :: nxyz
      integer :: mem
      integer :: ieg
      integer :: e
      integer :: f
      nobj = 1			
      iobj = 0
      do ii=nhis+1,nhis+nobj
         iobj = iobj+1
         hcode(10,ii) = 'I'
         hcode( 1,ii) = 'F' 
         hcode( 2,ii) = 'F' 
         hcode( 3,ii) = 'F' 
         lochis(1,ii) = iobj
      enddo
      nhis = nhis + nobj
      if (maxobj < nobj) write(6,*) 'increase maxobj in SIZEu. rm *.o'
      call exitt(icall,nekcomm,nekgroup,nekreal,nid,np,ifneknek_GLOB,ttotal,etimes,tprep,ttime, &
      istep,nvtot,ifsync,tgop,ngop)
      nxyz = nx1*ny1*nz1
      do e=1,nelv
      do f=1,2*ndim
         if (cbc(f,e,1) == 'sh ') then
            iobj = 0
            if (f == 1) iobj=1  
            if (f == 3) iobj=2  
            if (iobj > 0) then
               nmember(iobj) = nmember(iobj) + 1
               mem = nmember(iobj)
               ieg = lglel(e)
               object(iobj,mem,1) = ieg
               object(iobj,mem,2) = f
            endif
         endif
      enddo
      enddo
      return
      end subroutine set_obj
      subroutine set_forcing(f_new,u,idir,icall,nekcomm,nekgroup,nekreal,nid,np,utldo,nelv,nx1,ny1, &
      nz1,istep,param,bm1,volvm1,dt,ifsync,tgop,ngop,ifneknek,ttotal,etimes,tprep,ttime,nvtot)
      use params_SIZE, only : lz1, ldim, ly1, lelt, lx1
!!      use params_TOTAL ! ONLY LIST EMPTY
      implicit none
      integer :: icall
      integer :: nekcomm
      integer :: nekgroup
      integer :: nekreal
      integer :: nid
      integer :: np
      real, dimension(1:ldim), intent(InOut) :: utldo
      integer, intent(In) :: nelv
      integer, intent(In) :: nx1
      integer, intent(In) :: ny1
      integer, intent(In) :: nz1
      integer, intent(In) :: istep
      real, dimension(1:200), intent(Out) :: param
      real, dimension(1:lx1,1:ly1,1:lz1,1:lelt), intent(In) :: bm1
      real, intent(In) :: volvm1
      real, intent(In) :: dt
      logical :: ifsync
      real(kind=8          ) :: tgop
      integer :: ngop
      logical :: ifneknek
      real(kind=8          ) :: ttotal
      real(kind=8          ) :: etimes
      real(kind=8          ) :: tprep
      real(kind=8          ) :: ttime
      integer(kind=8 ) :: nvtot
      real, intent(Out) :: f_new
      real, intent(In) :: u
      integer, intent(In) :: idir
      real :: alpha
      real :: dpdx
      real :: f_max
      real :: f_min
      integer :: n
      real :: u_targ
      real :: glsc2
      real :: ubar
      real :: utilde
      n=nx1*ny1*nz1*nelv
      if (istep == 0) then
         f_new = 0.
         if (dpdx == 1) then
            param(54) = -1 
            param(55) = 1  
         endif
      endif
      if (dpdx == 1) return
      u_targ  = 1.
      ubar     = glsc2(u,bm1,n,icall,nekcomm,nekgroup,nekreal,nid,np,ifsync,tgop,ngop,ifneknek, &
      ttotal,etimes,tprep,ttime,istep,nvtot)/volvm1
      utilde  = ubar/u_targ
      if (istep > 0) f_new = 0.5 * (f_new + f_new/utilde)
      if (istep > 5) then
         alpha = abs(utilde-utldo(idir))/dt
         alpha = min(alpha,0.05)
         if     (utilde > 1.and.utilde > utldo(idir)) then
            f_new = (1-alpha)*f_new
         elseif (utilde < 1.and.utilde < utldo(idir)) then
            f_new = (1+alpha)*f_new
         endif
      endif
      utldo(idir)   = utilde
      f_min = 0.00001                 
      f_new = max(f_new,f_min)
      f_max = 0.10000                 
      f_new = min(f_new,f_max)
      return
      end subroutine set_forcing

end module singleton_module_src_abl


module module_dyn_shapiro_superkernel_init

integer, parameter :: ST_DYN_SHAPIRO_MAP_49 = 0 !  dyn_shapiro_map_49
integer, parameter :: ST_DYN_SHAPIRO_MAP_55 = 1 !  dyn_shapiro_map_55
integer, parameter :: ST_DYN_SHAPIRO_MAP_75 = 2 !  dyn_shapiro_map_75
integer, parameter :: ST_DYN_SHAPIRO_MAP_92 = 3 !  dyn_shapiro_map_92
        integer, parameter ::DT_BUF_IDX = 1
        integer, parameter ::DU___DYN_BUF_IDX = 6
        integer, parameter ::DUU___DYN_BUF_IDX = 10
        integer, parameter ::DV___DYN_BUF_IDX = 7
        integer, parameter ::DX_BUF_IDX = 4
        integer, parameter ::DY_BUF_IDX = 5
        integer, parameter ::EPS_BUF_IDX = 16
        integer, parameter ::ETA_BUF_IDX = 3
        integer, parameter ::ETAN_BUF_IDX = 15
        integer, parameter ::G_BUF_IDX = 2
        integer, parameter ::H_BUF_IDX = 14
        integer, parameter ::STATE_PTR_BUF_IDX = 17
        integer, parameter ::U_BUF_IDX = 8
        integer, parameter ::UN_BUF_IDX = 12
        integer, parameter ::V_BUF_IDX = 11
        integer, parameter ::VN_BUF_IDX = 13
        integer, parameter ::WET_BUF_IDX = 9

contains


! WV 2021-06-22

    subroutine dyn_shapiro_superkernel_init()

        use oclWrapper
        character(len=*), parameter :: srcstr = "module_dyn_shapiro_superkernel.cl"
        character(len=*), parameter :: kstr   = "dyn_shapiro_superkernel"
! parameters
              integer, parameter :: nx = 500 
              integer, parameter :: ny = 500 
              real, parameter :: alpha = 1e-9 
! declarations
        real :: dt
        real :: g
        real, dimension(0:(ny + 1),0:(nx + 1)) :: eta
        real :: dx
        real :: dy
        real, dimension(0:(ny + 1),0:(nx + 1)) :: u
        real, dimension(0:(ny + 1),0:(nx + 1)) :: du___dyn
        integer, dimension(0:(ny + 1),0:(nx + 1)) :: wet
        real :: duu___dyn
        real, dimension(0:(ny + 1),0:(nx + 1)) :: v
        real, dimension(0:(ny + 1),0:(nx + 1)) :: dv___dyn
        real, dimension(0:(ny + 1),0:(nx + 1)) :: un
        real, dimension(0:(ny + 1),0:(nx + 1)) :: h
        real, dimension(0:(ny + 1),0:(nx + 1)) :: vn
        real :: eps
        real, dimension(0:(ny + 1),0:(nx + 1)) :: etan
        integer :: state_ptr
! buffer declarations
        integer(8) :: dt_buf
        integer(8) :: g_buf
        integer(8) :: eta_buf
        integer(8) :: dx_buf
        integer(8) :: dy_buf
        integer(8) :: u_buf
        integer(8) :: du___dyn_buf
        integer(8) :: wet_buf
        integer(8) :: duu___dyn_buf
        integer(8) :: v_buf
        integer(8) :: dv___dyn_buf
        integer(8) :: un_buf
        integer(8) :: h_buf
        integer(8) :: vn_buf
        integer(8) :: eps_buf
        integer(8) :: etan_buf
        integer(8) :: state_ptr_buf
        integer, dimension(1) :: dt_ptr_sz
        integer, dimension(1) :: g_ptr_sz
        integer, dimension(2) :: eta_sz
        integer, dimension(1) :: dx_ptr_sz
        integer, dimension(1) :: dy_ptr_sz
        integer, dimension(2) :: u_sz
        integer, dimension(2) :: du___dyn_sz
        integer, dimension(2) :: wet_sz
        integer, dimension(1) :: duu___dyn_ptr_sz
        integer, dimension(2) :: v_sz
        integer, dimension(2) :: dv___dyn_sz
        integer, dimension(2) :: un_sz
        integer, dimension(2) :: h_sz
        integer, dimension(2) :: vn_sz
        integer, dimension(1) :: eps_ptr_sz
        integer, dimension(2) :: etan_sz
        integer, dimension(1) :: state_ptr_ptr_sz
        real, dimension(1) :: dt_ptr
        real, dimension(1) :: g_ptr
        real, dimension(1) :: dx_ptr
        real, dimension(1) :: dy_ptr
        real, dimension(1) :: duu___dyn_ptr
        real, dimension(1) :: eps_ptr
        integer, dimension(1) :: state_ptr_ptr

        call oclInit(srcstr,kstr)

        dt_ptr_sz = shape(dt_ptr)
        g_ptr_sz = shape(g_ptr)
        eta_sz = shape(eta)
        dx_ptr_sz = shape(dx_ptr)
        dy_ptr_sz = shape(dy_ptr)
        u_sz = shape(u)
        du___dyn_sz = shape(du___dyn)
        wet_sz = shape(wet)
        duu___dyn_ptr_sz = shape(duu___dyn_ptr)
        v_sz = shape(v)
        dv___dyn_sz = shape(dv___dyn)
        un_sz = shape(un)
        h_sz = shape(h)
        vn_sz = shape(vn)
        eps_ptr_sz = shape(eps_ptr)
        etan_sz = shape(etan)
        state_ptr_ptr_sz = shape(state_ptr_ptr)

        call oclMake1DFloatArrayReadWriteBuffer(dt_buf,dt_ptr_sz,dt_ptr)! Automatic conversion to array
        call oclMake1DFloatArrayReadWriteBuffer(g_buf,g_ptr_sz,g_ptr)! Automatic conversion to array
        call oclMake2DFloatArrayReadWriteBuffer(eta_buf,eta_sz,eta)
        call oclMake1DFloatArrayReadWriteBuffer(dx_buf,dx_ptr_sz,dx_ptr)! Automatic conversion to array
        call oclMake1DFloatArrayReadWriteBuffer(dy_buf,dy_ptr_sz,dy_ptr)! Automatic conversion to array
        call oclMake2DFloatArrayReadWriteBuffer(u_buf,u_sz,u)
        call oclMake2DFloatArrayReadWriteBuffer(du___dyn_buf,du___dyn_sz,du___dyn)
        call oclMake2DIntArrayReadWriteBuffer(wet_buf,wet_sz,wet)
        call oclMake1DFloatArrayReadWriteBuffer(duu___dyn_buf,duu___dyn_ptr_sz,duu___dyn_ptr)! Automatic conversion to array
        call oclMake2DFloatArrayReadWriteBuffer(v_buf,v_sz,v)
        call oclMake2DFloatArrayReadWriteBuffer(dv___dyn_buf,dv___dyn_sz,dv___dyn)
        call oclMake2DFloatArrayReadWriteBuffer(un_buf,un_sz,un)
        call oclMake2DFloatArrayReadWriteBuffer(h_buf,h_sz,h)
        call oclMake2DFloatArrayReadWriteBuffer(vn_buf,vn_sz,vn)
        call oclMake1DFloatArrayReadWriteBuffer(eps_buf,eps_ptr_sz,eps_ptr)! Automatic conversion to array
        call oclMake2DFloatArrayReadWriteBuffer(etan_buf,etan_sz,etan)
        call oclMake1DIntArrayReadWriteBuffer(state_ptr_buf,state_ptr_ptr_sz,state_ptr_ptr)! Automatic conversion to array

        call oclSetFloatArrayArg(0, dt_buf)
        call oclSetFloatArrayArg(1, g_buf)
        call oclSetFloatArrayArg(2, eta_buf)
        call oclSetFloatArrayArg(3, dx_buf)
        call oclSetFloatArrayArg(4, dy_buf)
        call oclSetFloatArrayArg(7, u_buf)
        call oclSetFloatArrayArg(5, du___dyn_buf)
        call oclSetIntArrayArg(8, wet_buf)
        call oclSetFloatArrayArg(9, duu___dyn_buf)
        call oclSetFloatArrayArg(10, v_buf)
        call oclSetFloatArrayArg(6, dv___dyn_buf)
        call oclSetFloatArrayArg(11, un_buf)
        call oclSetFloatArrayArg(13, h_buf)
        call oclSetFloatArrayArg(12, vn_buf)
        call oclSetFloatArrayArg(15, eps_buf)
        call oclSetFloatArrayArg(14, etan_buf)
        call oclSetIntArrayArg(16, state_ptr_buf)

        call oclStoreBuffer(DT_BUF_IDX, dt_buf)
        call oclStoreBuffer(DU___DYN_BUF_IDX, du___dyn_buf)
        call oclStoreBuffer(DUU___DYN_BUF_IDX, duu___dyn_buf)
        call oclStoreBuffer(DV___DYN_BUF_IDX, dv___dyn_buf)
        call oclStoreBuffer(DX_BUF_IDX, dx_buf)
        call oclStoreBuffer(DY_BUF_IDX, dy_buf)
        call oclStoreBuffer(EPS_BUF_IDX, eps_buf)
        call oclStoreBuffer(ETA_BUF_IDX, eta_buf)
        call oclStoreBuffer(ETAN_BUF_IDX, etan_buf)
        call oclStoreBuffer(G_BUF_IDX, g_buf)
        call oclStoreBuffer(H_BUF_IDX, h_buf)
        call oclStoreBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)
        call oclStoreBuffer(U_BUF_IDX, u_buf)
        call oclStoreBuffer(UN_BUF_IDX, un_buf)
        call oclStoreBuffer(V_BUF_IDX, v_buf)
        call oclStoreBuffer(VN_BUF_IDX, vn_buf)
        call oclStoreBuffer(WET_BUF_IDX, wet_buf)


    end subroutine dyn_shapiro_superkernel_init
end module module_dyn_shapiro_superkernel_init
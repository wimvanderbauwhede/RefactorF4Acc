module module_corio_core_superkernel_init

integer, parameter :: ST_CORIO_CORE_MAP_26 = 0 !  corio_core_map_26
        integer, parameter ::STATE_PTR_BUF_IDX = 9
        integer, parameter ::U_BUF_IDX = 1
        integer, parameter ::UN_BUF_IDX = 4
        integer, parameter ::V_BUF_IDX = 2
        integer, parameter ::VN_BUF_IDX = 6
        integer, parameter ::X_BUF_IDX = 3
        integer, parameter ::XN_BUF_IDX = 7
        integer, parameter ::Y_BUF_IDX = 5
        integer, parameter ::YN_BUF_IDX = 8

contains

    subroutine corio_core_superkernel_init()

        use oclWrapper
        character(len=*), parameter :: srcstr = "module_corio_core_superkernel.cl"
        character(len=*), parameter :: kstr   = "corio_core_superkernel"
! parameters
              real, parameter :: dt = 432.000000 
              real, parameter :: pi = 3.14159274 
              real, parameter :: freq = -7.27220540E-05 
              real, parameter :: f = -1.45444108E-04 
              real, parameter :: alpha = -6.28318563E-02 
              real, parameter :: beta = 9.86960484E-04 
              integer, parameter :: dmax = 1000 
              integer, parameter :: im = 10 
              integer, parameter :: jm = 10 
              integer, parameter :: km = 5 
! declarations
        real, dimension(1:im,1:jm,1:km) :: un
        real, dimension(1:im,1:jm,1:km) :: vn
        real, dimension(1:im,1:jm,1:km) :: xn
        real, dimension(1:im,1:jm,1:km) :: yn
        real, dimension(1:im,1:jm,1:km) :: u
        real, dimension(1:im,1:jm,1:km) :: v
        real, dimension(1:im,1:jm,1:km) :: x
        real, dimension(1:im,1:jm,1:km) :: y
        integer, dimension(1) :: state_ptr
! buffer declarations
        integer(8) :: un_buf
        integer(8) :: vn_buf
        integer(8) :: xn_buf
        integer(8) :: yn_buf
        integer(8) :: u_buf
        integer(8) :: v_buf
        integer(8) :: x_buf
        integer(8) :: y_buf
        integer(8) :: state_ptr_buf
        integer, dimension(3) :: un_sz
        integer, dimension(3) :: vn_sz
        integer, dimension(3) :: xn_sz
        integer, dimension(3) :: yn_sz
        integer, dimension(3) :: u_sz
        integer, dimension(3) :: v_sz
        integer, dimension(3) :: x_sz
        integer, dimension(3) :: y_sz
        integer, dimension(1) :: state_ptr_sz

        call oclInit(srcstr,kstr)

        un_sz = shape(un)
        vn_sz = shape(vn)
        xn_sz = shape(xn)
        yn_sz = shape(yn)
        u_sz = shape(u)
        v_sz = shape(v)
        x_sz = shape(x)
        y_sz = shape(y)
        state_ptr_sz = shape(state_ptr)

        call oclMake3DFloatArrayReadWriteBuffer(un_buf,un_sz,un)
        call oclMake3DFloatArrayReadWriteBuffer(vn_buf,vn_sz,vn)
        call oclMake3DFloatArrayReadWriteBuffer(xn_buf,xn_sz,xn)
        call oclMake3DFloatArrayReadWriteBuffer(yn_buf,yn_sz,yn)
        call oclMake3DFloatArrayReadWriteBuffer(u_buf,u_sz,u)
        call oclMake3DFloatArrayReadWriteBuffer(v_buf,v_sz,v)
        call oclMake3DFloatArrayReadWriteBuffer(x_buf,x_sz,x)
        call oclMake3DFloatArrayReadWriteBuffer(y_buf,y_sz,y)
        call oclMake1DIntArrayReadWriteBuffer(state_ptr_buf,state_ptr_sz,state_ptr)

        call oclSetFloatArrayArg(3, un_buf)
        call oclSetFloatArrayArg(5, vn_buf)
        call oclSetFloatArrayArg(6, xn_buf)
        call oclSetFloatArrayArg(7, yn_buf)
        call oclSetFloatArrayArg(0, u_buf)
        call oclSetFloatArrayArg(1, v_buf)
        call oclSetFloatArrayArg(2, x_buf)
        call oclSetFloatArrayArg(4, y_buf)
        call oclSetIntArrayArg(8, state_ptr_buf)

        call oclStoreBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)
        call oclStoreBuffer(U_BUF_IDX, u_buf)
        call oclStoreBuffer(UN_BUF_IDX, un_buf)
        call oclStoreBuffer(V_BUF_IDX, v_buf)
        call oclStoreBuffer(VN_BUF_IDX, vn_buf)
        call oclStoreBuffer(X_BUF_IDX, x_buf)
        call oclStoreBuffer(XN_BUF_IDX, xn_buf)
        call oclStoreBuffer(Y_BUF_IDX, y_buf)
        call oclStoreBuffer(YN_BUF_IDX, yn_buf)


    end subroutine corio_core_superkernel_init
end module module_corio_core_superkernel_init
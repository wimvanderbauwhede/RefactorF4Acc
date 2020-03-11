module module_predict_loc_predict_vel_update_etc_superkernel_init

integer, parameter :: ST_PREDICT_LOC_MAP_19 = 0 !  predict_loc_map_19
integer, parameter :: ST_PREDICT_VEL_MAP_17 = 1 !  predict_vel_map_17
integer, parameter :: ST_UPDATE_LOC_VEL_MAP_19 = 2 !  update_loc_vel_map_19
        integer, parameter ::ALPHA_BUF_IDX = 14
        integer, parameter ::BETA_BUF_IDX = 13
        integer, parameter ::DMAX_BUF_IDX = 5
        integer, parameter ::DT_BUF_IDX = 3
        integer, parameter ::IM_BUF_IDX = 1
        integer, parameter ::JM_BUF_IDX = 8
        integer, parameter ::KM_BUF_IDX = 9
        integer, parameter ::STATE_PTR_BUF_IDX = 16
        integer, parameter ::U_BUF_IDX = 12
        integer, parameter ::UN_BUF_IDX = 4
        integer, parameter ::V_BUF_IDX = 15
        integer, parameter ::VN_BUF_IDX = 7
        integer, parameter ::X_BUF_IDX = 2
        integer, parameter ::XN_BUF_IDX = 10
        integer, parameter ::Y_BUF_IDX = 6
        integer, parameter ::YN_BUF_IDX = 11

contains

    subroutine predict_loc_predict_vel_update_etc_superkernel_init()

        use oclWrapper
        character(len=*), parameter :: srcstr = "module_predict_loc_predict_vel_update_etc_superkernel.cl"
        character(len=*), parameter :: kstr   = "predict_loc_predict_vel_update_etc_superkernel"
! parameters
! declarations
        integer :: im
        real, dimension(1:im,1:jm,1:km) :: x
        real :: dt
        real, dimension(1:im,1:jm,1:km) :: un
        real :: dmax
        real, dimension(1:im,1:jm,1:km) :: y
        real, dimension(1:im,1:jm,1:km) :: vn
        integer :: jm
        integer :: km
        real, dimension(1:im,1:jm,1:km) :: u
        real :: beta
        integer :: alpha
        real, dimension(1:im,1:jm,1:km) :: v
        real, dimension(1:im,1:jm,1:km) :: xn
        real, dimension(1:im,1:jm,1:km) :: yn
        integer, dimension(1) :: state_ptr
! buffer declarations
        integer(8) :: im_buf
        integer(8) :: x_buf
        integer(8) :: dt_buf
        integer(8) :: un_buf
        integer(8) :: dmax_buf
        integer(8) :: y_buf
        integer(8) :: vn_buf
        integer(8) :: jm_buf
        integer(8) :: km_buf
        integer(8) :: u_buf
        integer(8) :: beta_buf
        integer(8) :: alpha_buf
        integer(8) :: v_buf
        integer(8) :: xn_buf
        integer(8) :: yn_buf
        integer(8) :: state_ptr_buf
        integer, dimension(1) :: im_ptr_sz
        integer, dimension(3) :: x_sz
        integer, dimension(1) :: dt_ptr_sz
        integer, dimension(3) :: un_sz
        integer, dimension(1) :: dmax_ptr_sz
        integer, dimension(3) :: y_sz
        integer, dimension(3) :: vn_sz
        integer, dimension(1) :: jm_ptr_sz
        integer, dimension(1) :: km_ptr_sz
        integer, dimension(3) :: u_sz
        integer, dimension(1) :: beta_ptr_sz
        integer, dimension(1) :: alpha_ptr_sz
        integer, dimension(3) :: v_sz
        integer, dimension(3) :: xn_sz
        integer, dimension(3) :: yn_sz
        integer, dimension(1) :: state_ptr_sz
        integer, dimension(1) :: im_ptr
        real, dimension(1) :: dt_ptr
        real, dimension(1) :: dmax_ptr
        integer, dimension(1) :: jm_ptr
        integer, dimension(1) :: km_ptr
        real, dimension(1) :: beta_ptr
        integer, dimension(1) :: alpha_ptr

        call oclInit(srcstr,kstr)

        im_ptr_sz = shape(im_ptr)
        x_sz = shape(x)
        dt_ptr_sz = shape(dt_ptr)
        un_sz = shape(un)
        dmax_ptr_sz = shape(dmax_ptr)
        y_sz = shape(y)
        vn_sz = shape(vn)
        jm_ptr_sz = shape(jm_ptr)
        km_ptr_sz = shape(km_ptr)
        u_sz = shape(u)
        beta_ptr_sz = shape(beta_ptr)
        alpha_ptr_sz = shape(alpha_ptr)
        v_sz = shape(v)
        xn_sz = shape(xn)
        yn_sz = shape(yn)
        state_ptr_sz = shape(state_ptr)

        call oclMake1DIntArrayReadWriteBuffer(im_buf,im_ptr_sz,im_ptr)! Automatic conversion to array
        call oclMake3DFloatArrayReadWriteBuffer(x_buf,x_sz,x)
        call oclMake1DFloatArrayReadWriteBuffer(dt_buf,dt_ptr_sz,dt_ptr)! Automatic conversion to array
        call oclMake3DFloatArrayReadWriteBuffer(un_buf,un_sz,un)
        call oclMake1DFloatArrayReadWriteBuffer(dmax_buf,dmax_ptr_sz,dmax_ptr)! Automatic conversion to array
        call oclMake3DFloatArrayReadWriteBuffer(y_buf,y_sz,y)
        call oclMake3DFloatArrayReadWriteBuffer(vn_buf,vn_sz,vn)
        call oclMake1DIntArrayReadWriteBuffer(jm_buf,jm_ptr_sz,jm_ptr)! Automatic conversion to array
        call oclMake1DIntArrayReadWriteBuffer(km_buf,km_ptr_sz,km_ptr)! Automatic conversion to array
        call oclMake3DFloatArrayReadWriteBuffer(u_buf,u_sz,u)
        call oclMake1DFloatArrayReadWriteBuffer(beta_buf,beta_ptr_sz,beta_ptr)! Automatic conversion to array
        call oclMake1DIntArrayReadWriteBuffer(alpha_buf,alpha_ptr_sz,alpha_ptr)! Automatic conversion to array
        call oclMake3DFloatArrayReadWriteBuffer(v_buf,v_sz,v)
        call oclMake3DFloatArrayReadWriteBuffer(xn_buf,xn_sz,xn)
        call oclMake3DFloatArrayReadWriteBuffer(yn_buf,yn_sz,yn)
        call oclMake1DIntArrayReadWriteBuffer(state_ptr_buf,state_ptr_sz,state_ptr)

        call oclSetIntArrayArg(0, im_buf)
        call oclSetFloatArrayArg(1, x_buf)
        call oclSetFloatArrayArg(2, dt_buf)
        call oclSetFloatArrayArg(3, un_buf)
        call oclSetFloatArrayArg(4, dmax_buf)
        call oclSetFloatArrayArg(5, y_buf)
        call oclSetFloatArrayArg(6, vn_buf)
        call oclSetIntArrayArg(7, jm_buf)
        call oclSetIntArrayArg(8, km_buf)
        call oclSetFloatArrayArg(11, u_buf)
        call oclSetFloatArrayArg(12, beta_buf)
        call oclSetIntArrayArg(13, alpha_buf)
        call oclSetFloatArrayArg(14, v_buf)
        call oclSetFloatArrayArg(9, xn_buf)
        call oclSetFloatArrayArg(10, yn_buf)
        call oclSetIntArrayArg(15, state_ptr_buf)

        call oclStoreBuffer(ALPHA_BUF_IDX, alpha_buf)
        call oclStoreBuffer(BETA_BUF_IDX, beta_buf)
        call oclStoreBuffer(DMAX_BUF_IDX, dmax_buf)
        call oclStoreBuffer(DT_BUF_IDX, dt_buf)
        call oclStoreBuffer(IM_BUF_IDX, im_buf)
        call oclStoreBuffer(JM_BUF_IDX, jm_buf)
        call oclStoreBuffer(KM_BUF_IDX, km_buf)
        call oclStoreBuffer(STATE_PTR_BUF_IDX, state_ptr_buf)
        call oclStoreBuffer(U_BUF_IDX, u_buf)
        call oclStoreBuffer(UN_BUF_IDX, un_buf)
        call oclStoreBuffer(V_BUF_IDX, v_buf)
        call oclStoreBuffer(VN_BUF_IDX, vn_buf)
        call oclStoreBuffer(X_BUF_IDX, x_buf)
        call oclStoreBuffer(XN_BUF_IDX, xn_buf)
        call oclStoreBuffer(Y_BUF_IDX, y_buf)
        call oclStoreBuffer(YN_BUF_IDX, yn_buf)


    end subroutine predict_loc_predict_vel_update_etc_superkernel_init
end module module_predict_loc_predict_vel_update_etc_superkernel_init
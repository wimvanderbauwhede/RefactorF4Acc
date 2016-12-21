import F95OpenACCParser
import NormaliseF95Code
import Test.HUnit
import RunTestWV
import System.Process

ex_no_regions = [
    "",
    "#define IANIME 0",
    "#define IFBF 1",
    "module module_LES_ocl",
    "! split this into initialise_LES_kernel and run_LES_kernel",
    "    contains",
    "    subroutine initialise_LES_kernel ( &",
    "            p,u,v,w,f,g,h,fold,gold,hold, &",
    "            cov1, cov2, cov3, cov4, cov5, cov6, cov7, cov8, cov9, &",
    "            diu1, diu2, diu3, diu4, diu5, diu6, diu7, diu8, diu9, &",
    "            nou1, nou2, nou3, nou4, nou5, nou6, nou7, nou8, nou9, &",
    "            amask1, bmask1, cmask1, dmask1, &",
    "            cn1, cn2l, cn2s, cn3l, cn3s, cn4l, cn4s, &",
    "            rhs, sm, dxs, dys, dzs, dx1, dy1, dzn, z2, &",
    "            dt, im, jm, km, nmax &",
    "            )",
    "        use oclWrapper",
    "!        use params_common_sn",
    "",
    "        implicit none",
    "        integer, parameter  :: ip = 150",
    "        integer, parameter  :: jp = 150",
    "        integer, parameter  :: kp = 90",
    "    ! arguments",
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: u",
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: v",
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,-1:kp+1)  :: w",
    ""
    ]

ex_var_region = [
    "",
    "#define IANIME 0",
    "#define IFBF 1",
    "module module_LES_ocl",
    "! split this into initialise_LES_kernel and run_LES_kernel",
    "    contains",
    "    subroutine initialise_LES_kernel ( &",
    "            p,u,v,w,f,g,h,fold,gold,hold, &",
    "            cov1, cov2, cov3, cov4, cov5, cov6, cov7, cov8, cov9, &",
    "            diu1, diu2, diu3, diu4, diu5, diu6, diu7, diu8, diu9, &",
    "            nou1, nou2, nou3, nou4, nou5, nou6, nou7, nou8, nou9, &",
    "            amask1, bmask1, cmask1, dmask1, &",
    "            cn1, cn2l, cn2s, cn3l, cn3s, cn4l, cn4s, &",
    "            rhs, sm, dxs, dys, dzs, dx1, dy1, dzn, z2, &",
    "            dt, im, jm, km, nmax &",
    "            )",
    "        use oclWrapper",
    "        use params_common_sn",
    "",
    "        implicit none",
    "",
    "    ! arguments",
    "!$acc arguments",
    "        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+1)  :: p",
    "!$acc end arguments",
    
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: u",
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: v",
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,-1:kp+1)  :: w",
    ""
    ]

ex_const_region = [
    "       ",
    "!$acc constarguments",
    "        real(kind=4) :: dt",
    "        integer :: im",
    "        integer :: jm",
    "        integer :: km",
    "        integer :: nmax",
    "!$acc end constarguments",
    "",
    "!"
	]

ex_multiple_var_regions = [
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: cmask1",
    "        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: dmask1",
    "!$acc arguments",
    "        real(kind=4), dimension(ip,jp,kp)  :: cn1",
    "!$acc end arguments",
    "        real(kind=4), dimension(ip)  :: cn2l",
    "        real(kind=4), dimension(ip)  :: cn2s",
    "        real(kind=4), dimension(jp)  :: cn3l",
    "        real(kind=4), dimension(jp)  :: cn3s",
    "        real(kind=4), dimension(kp)  :: cn4l",
    "        real(kind=4), dimension(kp)  :: cn4s",
    "!$acc arguments",
    "        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: rhs",
    "        real(kind=4), dimension(-1:ip+1,-1:jp+1,0:kp+1)  :: sm",
    "        real(kind=4), dimension(0:ip)  :: dxs",
    "        real(kind=4), dimension(0:jp)  :: dys",
    "        real(kind=4), dimension(-1:kp+2)  :: dzs",
    "        real(kind=4), dimension(-1:ip+1)  :: dx1",
    "        real(kind=4), dimension(0:jp+1)  :: dy1",
    "        real(kind=4), dimension(-1:kp+2)  :: dzn",
    "        real(kind=4), dimension(kp+2)  :: z2        ",
    "!$acc end arguments",
    "       "
	]
ex_var_const_regions = [
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,0:kp+1)  :: cmask1",
    "        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: dmask1",
    "!$acc arguments",
    "        real(kind=4), dimension(ip,jp,kp)  :: cn1",
    "!$acc end arguments",
    "        real(kind=4), dimension(ip)  :: cn2l",
    "        real(kind=4), dimension(ip)  :: cn2s",
    "        real(kind=4), dimension(jp)  :: cn3l",
    "        real(kind=4), dimension(jp)  :: cn3s",
    "        real(kind=4), dimension(kp)  :: cn4l",
    "        real(kind=4), dimension(kp)  :: cn4s",
    "!$acc arguments",
    "        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: rhs",
    "        real(kind=4), dimension(-1:ip+1,-1:jp+1,0:kp+1)  :: sm",
    "        real(kind=4), dimension(0:ip)  :: dxs",
    "        real(kind=4), dimension(0:jp)  :: dys",
    "        real(kind=4), dimension(-1:kp+2)  :: dzs",
    "        real(kind=4), dimension(-1:ip+1)  :: dx1",
    "        real(kind=4), dimension(0:jp+1)  :: dy1",
    "        real(kind=4), dimension(-1:kp+2)  :: dzn",
    "        real(kind=4), dimension(kp+2)  :: z2        ",
    "!$acc end arguments",
    "       ",
    "!$acc constarguments",
    "        real(kind=4) :: dt",
    "        integer :: im",
    "        integer :: jm",
    "        integer :: km",
    "        integer :: nmax",
    "!$acc end constarguments",
    "",
    "!"
	]

ex_pars = [
 "! Parameters",
 "       integer(8), parameter  :: gogo = 7188",
 "       integer, parameter  :: ip = 150",
 "       integer, parameter  :: jp = 150",
 "       integer, parameter  :: kp = 90   "
	]	
normalise_tuple (l1,l2,l3) = (normalise_F95_code_lines l1,normalise_F95_code_lines l2,normalise_F95_code_lines l3)

test_no_regions = assertEqualListTuple "NoReg" (normalise_tuple ([],[],["        integer, parameter  :: ip = 150","        integer, parameter  :: jp = 150","        integer, parameter  :: kp = 90"])) (normalise_tuple $ extract_OpenACC_regions_from_F95_src ex_no_regions)
test_var_region = assertEqualListTuple "VarReg" (["        real(kind=4), dimension(-1:ip+2,0:jp+2,0:kp+1)  :: p"],[],[]) (extract_OpenACC_regions_from_F95_src ex_var_region)
test_const_region = assertEqualListTuple "ConstReg" ([],["        real(kind=4) :: dt","        integer :: im","        integer :: jm","        integer :: km","        integer :: nmax"] ,[]) (extract_OpenACC_regions_from_F95_src ex_const_region)
test_multiple_var_regions = assertEqualListTuple "MultipleVarRegs" (["        real(kind=4), dimension(ip,jp,kp)  :: cn1","        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: rhs","        real(kind=4), dimension(-1:ip+1,-1:jp+1,0:kp+1)  :: sm","        real(kind=4), dimension(0:ip)  :: dxs","        real(kind=4), dimension(0:jp)  :: dys","        real(kind=4), dimension(-1:kp+2)  :: dzs","        real(kind=4), dimension(-1:ip+1)  :: dx1","        real(kind=4), dimension(0:jp+1)  :: dy1","        real(kind=4), dimension(-1:kp+2)  :: dzn","        real(kind=4), dimension(kp+2)  :: z2        "],[],[]) (extract_OpenACC_regions_from_F95_src ex_multiple_var_regions)
test_var_const_regions = assertEqualListTuple "VarConstRegs" (["        real(kind=4), dimension(ip,jp,kp)  :: cn1","        real(kind=4), dimension(0:ip+1,0:jp+1,0:kp+1)  :: rhs","        real(kind=4), dimension(-1:ip+1,-1:jp+1,0:kp+1)  :: sm","        real(kind=4), dimension(0:ip)  :: dxs","        real(kind=4), dimension(0:jp)  :: dys","        real(kind=4), dimension(-1:kp+2)  :: dzs","        real(kind=4), dimension(-1:ip+1)  :: dx1","        real(kind=4), dimension(0:jp+1)  :: dy1","        real(kind=4), dimension(-1:kp+2)  :: dzn","        real(kind=4), dimension(kp+2)  :: z2        "],["        real(kind=4) :: dt","        integer :: im","        integer :: jm","        integer :: km","        integer :: nmax"],[]) (extract_OpenACC_regions_from_F95_src ex_var_const_regions)

test_pars =  assertEqualListTuple "Pars" ([],[],["       integer(8), parameter  :: gogo = 7188","       integer, parameter  :: ip = 150","       integer, parameter  :: jp = 150","       integer, parameter  :: kp = 90   "]) (extract_OpenACC_regions_from_F95_src ex_pars)

tests = TestList [
	"No regions" ~: test_no_regions
	,"Var region" ~: test_var_region
	,"Const region" ~: test_const_region
	,"Multiple var regions" ~: test_multiple_var_regions
	,"Var and Const regions" ~: test_var_const_regions
	,"Pars" ~: test_pars
	]

main = runTestWV "F95OpenACCParser" tests  

-- main = putStrLn $ show $ extract_OpenACC_regions_from_F95_src ex_var_const_regions


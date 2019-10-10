module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        ) where
import TyTraCLAST

ast :: TyTraCLAST
ast = [
             -- shapiro_map_16
        (Vec VS (DSVec 5 DInt) "wet_s_0" , Stencil (SVec 5 DInt "s1") (Vec VI DInt "wet_0"))
        ,(Vec VS (DSVec 5 DFloat) "etan_s_0" , Stencil (SVec 5 DInt "s2") (Vec VI DFloat "etan_0"))
        ,( Vec VO DFloat "eta_1", Map (Function "shapiro_map_16"  [Scalar VI DFloat  "eps_0"]) (ZipT [Vec VS (DSVec 5 DInt) "wet_s_0",Vec VS (DSVec 5 DFloat) "etan_s_0"]) )
         -- dyn_map_39
        ,(Vec VS (DSVec 3 DFloat) "eta_s_0" , Stencil (SVec 3 DInt "s3") (Vec VO DFloat "eta_1"))
        ,( (Tuple [Vec VO DFloat "du_1",Vec VO DFloat "dv_1"]), UnzipT ( Map (Function "dyn_map_39"  [Scalar VI DFloat  "dt_0",Scalar VI DFloat  "g_0",Scalar VI DFloat  "dx_0",Scalar VI DFloat  "dy_0"]) (Vec VS (DSVec 3 DFloat) "eta_s_0") ) )
         -- dyn_map_45
        ,(Vec VS (DSVec 3 DInt) "wet_s_1" , Stencil (SVec 3 DInt "s4") (Vec VI DInt "wet_0"))
        ,( (Tuple [Vec VO DFloat "un_1",Vec VO DFloat "vn_1"]), UnzipT ( Map (Function "dyn_map_45" []) (ZipT [Vec VI DFloat "u_0",Vec VO DFloat "du_1",Vec VS (DSVec 3 DInt) "wet_s_1",Vec VI DFloat "v_0",Vec VO DFloat "dv_1"]) ) )
         -- dyn_map_65
        ,(Vec VS (DSVec 5 DFloat) "h_s_0" , Stencil (SVec 5 DInt "s5") (Vec VI DFloat "h_0"))
        ,(Vec VS (DSVec 2 DFloat) "un_s_0" , Stencil (SVec 2 DInt "s6") (Vec VO DFloat "un_1"))
        ,(Vec VS (DSVec 2 DFloat) "vn_s_0" , Stencil (SVec 2 DInt "s7") (Vec VO DFloat "vn_1"))
        ,( Vec VO DFloat "etan_1", Map (Function "dyn_map_65"  [Scalar VI DFloat  "dt_0",Scalar VI DFloat  "dx_0",Scalar VI DFloat  "dy_0"]) (ZipT [Vec VS (DSVec 2 DFloat) "un_s_0",Vec VS (DSVec 5 DFloat) "h_s_0",Vec VS (DSVec 2 DFloat) "vn_s_0",Vec VO DFloat "eta_1"]) )
         -- update_map_24
        ,( (Tuple [Vec VO DFloat "h_1",Vec VO DFloat "u_1",Vec VO DFloat "v_1",Vec VO DInt "wet_1"]), UnzipT ( Map (Function "update_map_24"  [Scalar VI DFloat  "hmin_0"]) (ZipT [Vec VI DFloat "hzero_0",Vec VO DFloat "eta_1",Vec VO DFloat "un_1",Vec VO DFloat "vn_1"]) ) )
        ]

functionSignaturesList = [
        ("dyn_map_39", MapFSig (Tuple [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "g_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"],SVec 3 DFloat "eta_s_0",Tuple [Scalar VDC DFloat "du_1",Scalar VDC DFloat "dv_1"])),
        ("dyn_map_45", MapFSig (Tuple [],Tuple [Scalar VDC DFloat "u_0",Scalar VDC DFloat "du_1",SVec 3 DInt "wet_s_1",Scalar VDC DFloat "v_0",Scalar VDC DFloat "dv_1"],Tuple [Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"])),
        ("dyn_map_65", MapFSig (Tuple [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"],Tuple [SVec 2 DFloat "un_s_0",SVec 5 DFloat "h_s_0",SVec 2 DFloat "vn_s_0",Scalar VDC DFloat "eta_1"],Scalar VDC DFloat "etan_1")),
        ("shapiro_map_16", MapFSig (Scalar VDC DFloat "eps_0",Tuple [SVec 5 DInt "wet_s_0",SVec 5 DFloat "etan_s_0"],Scalar VDC DFloat "eta_1")),
        ("update_map_24", MapFSig (Scalar VDC DFloat "hmin_0",Tuple [Scalar VDC DFloat "hzero_0",Scalar VDC DFloat "eta_1",Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"],Tuple [Scalar VDC DFloat "h_1",Scalar VDC DFloat "u_1",Scalar VDC DFloat "v_1",Scalar VDC DInt "wet_1"]))
    ]
stencilDefinitionsList = [("s1" , [-502,-1,0,1,502] ), ("s2" , [-502,-1,0,1,502] ), ("s3" , [0,1,502] ), ("s4" , [0,1,502] ), ("s5" , [-502,-1,0,1,502] ), ("s6" , [-502,0] ), ("s7" , [-1,0] )]

mainArgDeclsList = [
      ("hmin_0" , "real, intent(in) :: hmin_0" )
    , ("h_0" , "real, dimension(1:252004), intent(in) :: h_0" )
    , ("u_0" , "real, dimension(1:252004), intent(in) :: u_0" )
    , ("wet_0" , "integer, dimension(1:252004), intent(in) :: wet_0" )
    , ("etan_0" , "real, dimension(1:252004), intent(in) :: etan_0" )
    , ("g_0" , "real, intent(in) :: g_0" )
    , ("dx_0" , "real, intent(in) :: dx_0" )
    , ("eps_0" , "real, intent(in) :: eps_0" )
    , ("dy_0" , "real, intent(in) :: dy_0" )
    , ("v_0" , "real, dimension(1:252004), intent(in) :: v_0" )
    , ("hzero_0" , "real, dimension(1:252004), intent(in) :: hzero_0" )
    , ("dt_0" , "real, intent(in) :: dt_0" )
    , ("v_1" , "real, dimension(1:252004), intent(out) :: v_1" )
    , ("u_1" , "real, dimension(1:252004), intent(out) :: u_1" )
    , ("h_1" , "real, dimension(1:252004), intent(out) :: h_1" )
    , ("vn_1" , "real, dimension(1:252004), intent(out) :: vn_1" )
    , ("eta_1" , "real, dimension(1:252004), intent(out) :: eta_1" )
    , ("etan_1" , "real, dimension(1:252004), intent(out) :: etan_1" )
    , ("un_1" , "real, dimension(1:252004), intent(out) :: un_1" )
    , ("du_1" , "real, dimension(1:252004), intent(out) :: du_1" )
    , ("wet_1" , "integer, dimension(1:252004), intent(out) :: wet_1" )
    , ("dv_1" , "real, dimension(1:252004), intent(out) :: dv_1" )
  ]

scalarisedArgsList = [
     ( "dyn_map_39",[("dt",0), ("g",0), ("eta",1), ("eta",2), ("eta",3), ("dx",0), ("dy",0), ("du",0), ("dv",0)])
    ,( "dyn_map_45",[("u",0), ("du",0), ("wet",1), ("wet",2), ("wet",3), ("v",0), ("dv",0), ("un",0), ("vn",0)])
    ,( "dyn_map_65",[("un",1), ("un",2), ("h",1), ("h",2), ("h",3), ("h",4), ("h",5), ("vn",1), ("vn",2), ("eta",0), ("dt",0), ("dx",0), ("dy",0), ("etan",0)])
    ,( "shapiro_dyn_update_superkernel",[("wet",0), ("eps",0), ("etan",0), ("eta",0), ("dt",0), ("g",0), ("dx",0), ("dy",0), ("du",0), ("dv",0), ("u",0), ("v",0), ("un",0), ("vn",0), ("h",0), ("hzero",0), ("hmin",0), ("state_ptr",0)])
    ,( "shapiro_map_16",[("wet",1), ("wet",2), ("wet",3), ("wet",4), ("wet",5), ("eps",0), ("etan",1), ("etan",2), ("etan",3), ("etan",4), ("etan",5), ("eta",0)])
    ,( "update_map_24",[("hzero",0), ("eta",0), ("h",0), ("hmin",0), ("un",0), ("vn",0), ("wet",0), ("u",0), ("v",0)])
  ]

origNamesList = [
     ( "shapiro_map_16",[("eps","eps_0"), ("wet","wet_s_0"), ("etan","etan_s_0"), ("eta","eta_1")])
    ,( "dyn_map_39",[("dt","dt_0"), ("g","g_0"), ("dx","dx_0"), ("dy","dy_0"), ("eta","eta_s_0"), ("du","du_1"), ("dv","dv_1")])
    ,( "dyn_map_45",[("u","u_0"), ("du","du_1"), ("wet","wet_s_1"), ("v","v_0"), ("dv","dv_1"), ("un","un_1"), ("vn","vn_1")])
    ,( "dyn_map_65",[("dt","dt_0"), ("dx","dx_0"), ("dy","dy_0"), ("un","un_s_0"), ("h","h_s_0"), ("vn","vn_s_0"), ("eta","eta_1"), ("etan","etan_1")])
    ,( "update_map_24",[("hmin","hmin_0"), ("hzero","hzero_0"), ("eta","eta_1"), ("un","un_1"), ("vn","vn_1"), ("h","h_1"), ("u","u_1"), ("v","v_1"), ("wet","wet_1")])
  ]
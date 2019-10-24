module ASTInstance ( ast
        , functionSignaturesList
        , stencilDefinitionsList
        , mainArgDeclsList 
        , scalarisedArgsList
        , origNamesList
        ) where
import TyTraCLAST

ast :: TyTraCLAST
-- ast = [
--              -- shapiro_map_16
--         (Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DInt "wet_0")))
--         ,(Vec VS (SVec 5 (Scalar VDC DFloat "eta_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "eta_0")))
--         ,( Vec VT (Scalar VDC DFloat "eta_1"), Map (Function "shapiro_map_16"  []) (ZipT [Vec VS (SVec 5(Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5(Scalar VDC DFloat "eta_s_0"))]) )
--          -- dyn_map_39
--         ,(Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s3")) (Vec VT (Scalar VDC DFloat "eta_1")))
--         ,( (Tuple [Vec VO (Scalar VDC DFloat "du_1"),Vec VO (Scalar VDC DFloat "dv_1")]), UnzipT ( Map (Function "dyn_map_39"  []) (Vec VS (SVec 3(Scalar VDC DFloat "eta_s_1"))) ) )
--          -- dyn_map_45
--         ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DInt "wet_0")))
--         ,( (Tuple [Vec VT (Scalar VDC DFloat "un_1"),Vec VT (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_map_45" []) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VO (Scalar VDC DFloat "du_1"),Vec VS (SVec 3(Scalar VDC DInt "wet_s_1")),Vec VI (Scalar VDC DFloat "v_0"),Vec VO (Scalar VDC DFloat "dv_1")]) ) )
--          -- dyn_map_65
--         ,(Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DFloat "h_0")))
--         ,(Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s6")) (Vec VT (Scalar VDC DFloat "vn_1")))
--         ,(Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "un_1")))
--         -- dyn_map_65
--         -- Scalar VDC DFloat "dt_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"
--         ,( Vec VT (Scalar VDC DFloat "eta_2"), Map (Function "dyn_map_65"  []) (ZipT [Vec VS (SVec 2(Scalar VDC DFloat "un_s_0")),Vec VS (SVec 5(Scalar VDC DFloat "h_s_0")),Vec VS (SVec 2(Scalar VDC DFloat "vn_s_0")),Vec VT (Scalar VDC DFloat "eta_1")]) )
--          -- update_map_24
--         ,( 
--           -- (
--           --   Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1"),Vec VO (Scalar VDC DFloat "v_1"),Vec VO (Scalar VDC DInt "wet_1")]
--           -- )
--           Vec VO (Scalar VDC DFloat "u_1")
--           , UnzipT ( Map (Function "update_map_24"  []) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VT (Scalar VDC DFloat "eta_2"),Vec VT (Scalar VDC DFloat "un_1"),Vec VT (Scalar VDC DFloat "vn_1")]) ) 
--           )
--         ]

-- functionSignaturesList = [
--         ("dyn_map_39",  [Tuple [],SVec 3 (Scalar VDC DFloat "eta_s_1"),Tuple [Scalar VDC DFloat "du_1",Scalar VDC DFloat "dv_1"]]),
--         ("dyn_map_45",  [Tuple [],Tuple [Scalar VDC DFloat "u_0",Scalar VDC DFloat "du_1",SVec 3 (Scalar VDC DInt "wet_s_1"),Scalar VDC DFloat "v_0",Scalar VDC DFloat "dv_1"],Tuple [Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"]]),
--         ("dyn_map_65",  [Tuple [],Tuple [SVec 2 (Scalar VDC DFloat "un_s_0"),SVec 5 (Scalar VDC DFloat "h_s_0"),SVec 2 (Scalar VDC DFloat "vn_s_0"),Scalar VDC DFloat "eta_1"],Scalar VDC DFloat "eta_2"]),
--         ("shapiro_map_16",  [Tuple [],Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "eta_s_0")],Scalar VDC DFloat "eta_1"]),
--         ("update_map_24",  [Tuple [],Tuple [Scalar VDC DFloat "hzero_0",Scalar VDC DFloat "eta_2",Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"],
--           -- Tuple [Scalar VDC DFloat "h_1",Scalar VDC DFloat "u_1",Scalar VDC DFloat "v_1",Scalar VDC DInt "wet_1"]
--           Scalar VDC DFloat "u_1"
--           ])
--     ]        


ast = [
             -- shapiro_map_16
        (Vec VS (SVec 5 (Scalar VDC DInt "wet_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s1")) (Vec VI (Scalar VDC DInt "wet_0")))
        ,(Vec VS (SVec 5 (Scalar VDC DFloat "eta_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s2")) (Vec VI (Scalar VDC DFloat "eta_0")))
        ,( Vec VT (Scalar VDC DFloat "eta_1"), Map (Function "shapiro_map_16"  [Scalar VDC DFloat "eps_0"]) (ZipT [Vec VS (SVec 5(Scalar VDC DInt "wet_s_0")),Vec VS (SVec 5(Scalar VDC DFloat "eta_s_0"))]) )
         -- dyn_map_39
        ,(Vec VS (SVec 3 (Scalar VDC DFloat "eta_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s3")) (Vec VT (Scalar VDC DFloat "eta_1")))
        ,( (Tuple [Vec VO (Scalar VDC DFloat "du_1"),Vec VO (Scalar VDC DFloat "dv_1")]), UnzipT ( Map (Function "dyn_map_39"  [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "g_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"]) (Vec VS (SVec 3(Scalar VDC DFloat "eta_s_1"))) ) )
         -- dyn_map_45
        ,(Vec VS (SVec 3 (Scalar VDC DInt "wet_s_1" )) , Stencil (SVec 3 (Scalar VDC DInt "s4")) (Vec VI (Scalar VDC DInt "wet_0")))
        ,( (Tuple [Vec VT (Scalar VDC DFloat "un_1"),Vec VT (Scalar VDC DFloat "vn_1")]), UnzipT ( Map (Function "dyn_map_45" []) (ZipT [Vec VI (Scalar VDC DFloat "u_0"),Vec VO (Scalar VDC DFloat "du_1"),Vec VS (SVec 3(Scalar VDC DInt "wet_s_1")),Vec VI (Scalar VDC DFloat "v_0"),Vec VO (Scalar VDC DFloat "dv_1")]) ) )
         -- dyn_map_65
        ,(Vec VS (SVec 5 (Scalar VDC DFloat "h_s_0" )) , Stencil (SVec 5 (Scalar VDC DInt "s5")) (Vec VI (Scalar VDC DFloat "h_0")))
        ,(Vec VS (SVec 2 (Scalar VDC DFloat "vn_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s6")) (Vec VT (Scalar VDC DFloat "vn_1")))
        ,(Vec VS (SVec 2 (Scalar VDC DFloat "un_s_0" )) , Stencil (SVec 2 (Scalar VDC DInt "s7")) (Vec VT (Scalar VDC DFloat "un_1")))
        -- dyn_map_65
        -- Scalar VDC DFloat "dt_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"
        ,( Vec VT (Scalar VDC DFloat "eta_2"), Map (Function "dyn_map_65"  []) (ZipT [Vec VS (SVec 2(Scalar VDC DFloat "un_s_0")),Vec VS (SVec 5(Scalar VDC DFloat "h_s_0")),Vec VS (SVec 2(Scalar VDC DFloat "vn_s_0")),Vec VT (Scalar VDC DFloat "eta_1")]) )
         -- update_map_24
        ,( 
          -- (
          --   Tuple [Vec VO (Scalar VDC DFloat "h_1"),Vec VO (Scalar VDC DFloat "u_1"),Vec VO (Scalar VDC DFloat "v_1"),Vec VO (Scalar VDC DInt "wet_1")]
          -- )
          Vec VO (Scalar VDC DFloat "u_1")
          , UnzipT ( Map (Function "update_map_24"  [Scalar VDC DFloat "hmin_0"]) (ZipT [Vec VI (Scalar VDC DFloat "hzero_0"),Vec VT (Scalar VDC DFloat "eta_2"),Vec VT (Scalar VDC DFloat "un_1"),Vec VT (Scalar VDC DFloat "vn_1")]) ) 
          )
        ]

functionSignaturesList = [
        ("dyn_map_39",  [Tuple [Scalar VDC DFloat "dt_0",Scalar VDC DFloat "g_0",Scalar VDC DFloat "dx_0",Scalar VDC DFloat "dy_0"],SVec 3 (Scalar VDC DFloat "eta_s_1"),Tuple [Scalar VDC DFloat "du_1",Scalar VDC DFloat "dv_1"]]),
        ("dyn_map_45",  [Tuple [],Tuple [Scalar VDC DFloat "u_0",Scalar VDC DFloat "du_1",SVec 3 (Scalar VDC DInt "wet_s_1"),Scalar VDC DFloat "v_0",Scalar VDC DFloat "dv_1"],Tuple [Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"]]),
        ("dyn_map_65",  [Tuple [],Tuple [SVec 2 (Scalar VDC DFloat "un_s_0"),SVec 5 (Scalar VDC DFloat "h_s_0"),SVec 2 (Scalar VDC DFloat "vn_s_0"),Scalar VDC DFloat "eta_1"],Scalar VDC DFloat "eta_2"]),
        ("shapiro_map_16",  [Scalar VDC DFloat "eps_0",Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "eta_s_0")],Scalar VDC DFloat "eta_1"]),
        ("update_map_24",  [Scalar VDC DFloat "hmin_0",Tuple [Scalar VDC DFloat "hzero_0",Scalar VDC DFloat "eta_2",Scalar VDC DFloat "un_1",Scalar VDC DFloat "vn_1"],
          -- Tuple [Scalar VDC DFloat "h_1",Scalar VDC DFloat "u_1",Scalar VDC DFloat "v_1",Scalar VDC DInt "wet_1"]
          Scalar VDC DFloat "u_1"
          ])
    ]
stencilDefinitionsList = [("s1" , [-502,-1,0,1,502] ), ("s2" , [-502,-1,0,1,502] ), ("s3" , [0,1,502] ), ("s4" , [0,1,502] ), ("s5" , [-502,-1,0,1,502] ), ("s6" , [-1,0] ), ("s7" , [-502,0] )]


mainArgDeclsList = [
      ("eps_0" , MkFDecl "real" Nothing (Just In) ["eps_0"] )
    , ("hzero_0" , MkFDecl "real" (Just 252004) (Just In) ["hzero_0"] )
    , ("v_0" , MkFDecl "real" (Just 252004) (Just In) ["v_0"])
    , ("dx_0" , MkFDecl "real" Nothing (Just In) ["dx_0"])
    , ("g_0" , MkFDecl "real" Nothing (Just In) ["g_0"])
    , ("dt_0" , MkFDecl "real" Nothing (Just In) ["dt_0"])
    , ("hmin_0" , MkFDecl "real" Nothing (Just In) ["hmin_0"])
    , ("wet_0" , MkFDecl "integer" (Just 252004) (Just In) ["wet_0"])
    , ("h_0" , MkFDecl "real" (Just 252004) (Just In) ["h_0"])
    , ("eta_0" , MkFDecl "real" (Just 252004) (Just In) ["eta_0"])
    , ("dy_0" , MkFDecl "real" Nothing (Just In) ["dy_0"])
    , ("u_0" , MkFDecl "real" (Just 252004) (Just In) ["u_0"])
    , ("v_1" , MkFDecl "real" (Just 252004) (Just Out) ["v_1"])
    , ("h_1" , MkFDecl "real" (Just 252004) (Just Out) ["h_1"])
    , ("du_1" , MkFDecl "real" (Just 252004) (Just Out) ["du_1"])
    , ("wet_1" , MkFDecl "integer" (Just 252004) (Just Out) ["wet_1"])
    , ("u_1" , MkFDecl "real" (Just 252004) (Just Out) ["u_1"])
    , ("dv_1" , MkFDecl "real" (Just 252004) (Just Out) ["dv_1"])
  ]
-- mainArgDeclsList = [
--       ("eps_0" , "real, intent(in) :: eps_0" )
--     , ("hzero_0" , "real, dimension(1:252004), intent(in) :: hzero_0" ) -- MkFDecl "real" 252004 In ["hzero_0"]
--     , ("v_0" , "real, dimension(1:252004), intent(in) :: v_0" )
--     , ("dx_0" , "real, intent(in) :: dx_0" )
--     , ("g_0" , "real, intent(in) :: g_0" )
--     , ("dt_0" , "real, intent(in) :: dt_0" )
--     , ("hmin_0" , "real, intent(in) :: hmin_0" )
--     , ("wet_0" , "integer, dimension(1:252004), intent(in) :: wet_0" )
--     , ("h_0" , "real, dimension(1:252004), intent(in) :: h_0" )
--     , ("eta_0" , "real, dimension(1:252004), intent(in) :: eta_0" )
--     , ("dy_0" , "real, intent(in) :: dy_0" )
--     , ("u_0" , "real, dimension(1:252004), intent(in) :: u_0" )
--     , ("v_1" , "real, dimension(1:252004), intent(out) :: v_1" )
--     , ("h_1" , "real, dimension(1:252004), intent(out) :: h_1" )
--     , ("du_1" , "real, dimension(1:252004), intent(out) :: du_1" )
--     , ("wet_1" , "integer, dimension(1:252004), intent(out) :: wet_1" )
--     , ("u_1" , "real, dimension(1:252004), intent(out) :: u_1" )
--     , ("dv_1" , "real, dimension(1:252004), intent(out) :: dv_1" )
--   ]

scalarisedArgsList = [
     ( "dyn_map_39",[("dt",0), ("g",0), ("eta",1), ("eta",2), ("eta",3), ("dx",0), ("dy",0), ("du",0), ("dv",0)])
    ,( "dyn_map_45",[("u",0), ("du",0), ("wet",1), ("wet",2), ("wet",3), ("v",0), ("dv",0), ("un",0), ("vn",0)])
    ,( "dyn_map_65",[("un",1), ("un",2), ("h",1), ("h",2), ("h",3), ("h",4), ("h",5), ("vn",1), ("vn",2), ("eta",0), ("dt",0), ("dx",0), ("dy",0)])
    ,( "shapiro_dyn_update_superkernel",[("wet",0), ("eps",0), ("eta",0), ("dt",0), ("g",0), ("dx",0), ("dy",0), ("du",0), ("dv",0), ("u",0), ("v",0), ("h",0), ("hzero",0), ("hmin",0), ("state_ptr",0)])
    ,( "shapiro_map_16",[("wet",1), ("wet",2), ("wet",3), ("wet",4), ("wet",5), ("eps",0), ("eta",1), ("eta",2), ("eta",3), ("eta",4), ("eta",5)])
    ,( "update_map_24",[("hzero",0), ("eta",0), ("h",0), ("hmin",0), ("un",0), ("vn",0), ("wet",0), ("u",0), ("v",0)])
  ]

origNamesList = [
     ( "shapiro_map_16",[("eps","eps_0"), ("wet","wet_s_0"), ("eta","eta_s_0"), ("eta","eta_1")])
    ,( "dyn_map_39",[("dt","dt_0"), ("g","g_0"), ("dx","dx_0"), ("dy","dy_0"), ("eta","eta_s_1"), ("du","du_1"), ("dv","dv_1")])
    ,( "dyn_map_45",[("u","u_0"), ("du","du_1"), ("wet","wet_s_1"), ("v","v_0"), ("dv","dv_1"), ("un","un_1"), ("vn","vn_1")])
    ,( "dyn_map_65",[("dt","dt_0"), ("dx","dx_0"), ("dy","dy_0"), ("un","un_s_0"), ("h","h_s_0"), ("vn","vn_s_0"), ("eta","eta_1"), ("eta","eta_2")])
    ,( "update_map_24",[("hmin","hmin_0"), ("hzero","hzero_0"), ("eta","eta_2"), ("un","un_1"), ("vn","vn_1"), ("h","h_1"), ("u","u_1"), ("v","v_1"), ("wet","wet_1")])
  ]
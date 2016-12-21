module F95ArgDeclParserTestRefs where
import F95Types

expr_parser_tests = [
-- x+1
    Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Const 1}),
-- 2-y2
    Op (MkOpExpr {oe_op = "-", oe_lhs = Const 2, oe_rhs = Var "y2"}),
-- 2*x
    Op (MkOpExpr {oe_op = "*", oe_lhs = Const 2, oe_rhs = Var "x"}),
-- 2*(x+1)
    Op (MkOpExpr {oe_op = "*", oe_lhs = Const 2, oe_rhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Const 1})}),
-- 2+x*y
    Op (MkOpExpr {oe_op = "+", oe_lhs = Const 2, oe_rhs = Op (MkOpExpr {oe_op = "*", oe_lhs = Var "x", oe_rhs = Var "y"})}),
-- -1*(x+y)
    Op (MkOpExpr {oe_op = "*", oe_lhs = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), oe_rhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Var "y"})}),
-- -(1*(x+y))
    Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Op (MkOpExpr {oe_op = "*", oe_lhs = Const 1, oe_rhs = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Var "y"})})})
    ]
range_expr_tests = [
-- 5
    MkRange {r_start = Var "ip", r_stop = Const 5},
-- 0:1
    MkRange {r_start = Const 0, r_stop = Const 1},
-- 0:x
    MkRange {r_start = Const 0, r_stop = Var "x"},
-- x:y
    MkRange {r_start = Var "x", r_stop = Var "y"},
-- -1:x+1
    MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Const 1})}
    ]
range_parser_tests = [
-- 0:1
    MkRange {r_start = Const 0, r_stop = Const 1},
-- 0:x
    MkRange {r_start = Const 0, r_stop = Var "x"},
-- x:y
    MkRange {r_start = Var "x", r_stop = Var "y"},
-- -1:x+1
    MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Const 1})},
-- 0
    MkRange {r_start = Const 1, r_stop = Const 0},
-- x
    MkRange {r_start = Const 1, r_stop = Var "x"},
-- x+y
    MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "x", oe_rhs = Var "y"})},
-- ip+1
    MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})}
    ]
dim_parser_tests = [
-- dimension(ip)
    [MkRange {r_start = Const 1, r_stop = Var "ip"}],
-- dimension(ip+1)
    [MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})}],
-- dimension(0:ip+1)
    [MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})}],
-- dimension(-1:jp+1)
    [MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})}],
-- dimension(ip,jp,kp)
    [MkRange {r_start = Const 1, r_stop = Var "ip"},MkRange {r_start = Const 1, r_stop = Var "jp"},MkRange {r_start = Const 1, r_stop = Var "kp"}],
-- dimension(ip+1,jp+1,kp+1)
    [MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})},MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})},MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "kp", oe_rhs = Const 1})}],
-- dimension(0:ip+1,-1:jp+1,-1:kp+1)
    [MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})},MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})},MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "kp", oe_rhs = Const 1})}]
    ]
intent_parser_tests = [
-- intent(in)
    In,
-- intent (out)
    Out,
-- intent ( inout )
    InOut
    ]
type_parser_tests = [
-- real(kind=4)
    MkVarType {at_numtype = F95Real, at_wordsz = 4},
-- real
    MkVarType {at_numtype = F95Real, at_wordsz = 4},
-- integer
    MkVarType {at_numtype = F95Integer, at_wordsz = 4},
-- integer(8)
    MkVarType {at_numtype = F95Integer, at_wordsz = 8},
-- real ( kind = 8 )
    MkVarType {at_numtype = F95Real, at_wordsz = 8}
    ]
arglist_parser_tests = [
-- :: p
    ["p"],
-- :: u,v,w
    ["u","v","w"],
-- ::fold, gold, h42
    ["fold","gold","h42"]
    ]
ocl_argmode_parser_tests = [
-- !$acc argmode read
    Read,
-- !$acc argmode write
    Write,
-- !$acc argmode readwrite
    ReadWrite
    ]
f95_arg_decl_parser_tests = [
--         real(kind=4), dimension(ip,jp,kp)  :: u
    MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = 4}, vd_dimension = [MkRange {r_start = Const 1, r_stop = Var "ip"},MkRange {r_start = Const 1, r_stop = Var "jp"},MkRange {r_start = Const 1, r_stop = Var "kp"}], vd_intent = InOut, vd_varlist = ["u"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]},
--         real(8), dimension(ip,jp,kp)  :: uin
    MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = 8}, vd_dimension = [MkRange {r_start = Const 1, r_stop = Var "ip"},MkRange {r_start = Const 1, r_stop = Var "jp"},MkRange {r_start = Const 1, r_stop = Var "kp"}], vd_intent = In, vd_varlist = ["uin"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]},
--         real(kind=4), dimension(ip+1,jp+1,kp+1)  :: 
    MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = 4}, vd_dimension = [MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})},MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})},MkRange {r_start = Const 1, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "kp", oe_rhs = Const 1})}], vd_intent = InOut, vd_varlist = ["v"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]},
--         real(kind=4), dimension(0:ip+1,-1:jp+1,-1:kp+1)  :: w
    MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = 4}, vd_dimension = [MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})},MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})},MkRange {r_start = Pref (MkPrefixOpExpr {poe_op = "-", poe_exp = Const 1}), r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "kp", oe_rhs = Const 1})}], vd_intent = InOut, vd_varlist = ["w"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]},
--         integer, dimension(0:ip+1,0:jp+1,0:kp+1)  :: t1 !$acc argmode read
    MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Integer, at_wordsz = 4}, vd_dimension = [MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})},MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})},MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "kp", oe_rhs = Const 1})}], vd_intent = InOut, vd_varlist = ["t1"], vd_argmode = Read, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]},
--         integer(kind=8), dimension(0:ip+1,0:jp+1,0:kp+1)  :: t1,t2,t3 !$acc argmode read
    MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Integer, at_wordsz = 8}, vd_dimension = [MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "ip", oe_rhs = Const 1})},MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "jp", oe_rhs = Const 1})},MkRange {r_start = Const 0, r_stop = Op (MkOpExpr {oe_op = "+", oe_lhs = Var "kp", oe_rhs = Const 1})}], vd_intent = InOut, vd_varlist = ["t1","t2","t3"], vd_argmode = Read, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]}
    ]

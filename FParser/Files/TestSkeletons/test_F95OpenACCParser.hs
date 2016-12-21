import F95OpenACCParser
import Test.HUnit
import System.Process
-- The lists should be populated with examples of the text to be parsed.
-- "no regions" means there are no !$ACC regions in the text; var region means there is a single !$ACC Arguments, const region means there is a single !$ACC ConstArguments, etc.
ex_no_regions = [
    "",
    ""
    ]

ex_var_region = [
    "",
    ""
    ]

ex_const_region = [
    "",
    ""
	]

ex_multiple_var_regions = [
    "",
    ""
	]
ex_var_const_regions = [
    "",
    ""
	]

ex_pars = [
 "",
 ""
	]	
-- Populate the ([],[],[]) with the correct lists of strings to be extracted for each case
test_no_regions = assertEqual "NoReg" ([],[],[]) (extract_OpenACC_regions_from_F95_src ex_no_regions)
test_var_region = assertEqual "VarReg" ([],[],[]) (extract_OpenACC_regions_from_F95_src ex_var_region)
test_const_region = assertEqual "ConstReg" ([],[],[]) (extract_OpenACC_regions_from_F95_src ex_const_region)
test_multiple_var_regions = assertEqual "MultipleVarRegs" ([],[],[]) (extract_OpenACC_regions_from_F95_src ex_multiple_var_regions)
test_var_const_regions = assertEqual "VarConstRegs" ([],[],[]) (extract_OpenACC_regions_from_F95_src ex_var_const_regions)
test_pars =  assertEqual "Pars" ([],[],[]) (extract_OpenACC_regions_from_F95_src ex_pars)

tests = TestList [
	"No regions" ~: test_no_regions
	,"Var region" ~: test_var_region
	,"Const region" ~: test_const_region
	,"Multiple var regions" ~: test_multiple_var_regions
	,"Var and Const regions" ~: test_var_const_regions
	,"Pars" ~: test_pars
	]

main = runTestTT tests  


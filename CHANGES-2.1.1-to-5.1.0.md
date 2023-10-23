version 5.1.0

- The main change in this release is better support for F90/F95 syntax and features.
- The parser is much improved, esp. for IO operations
- EQUIVALENCE refactoring is more comprehensive now
- Warning and error messages have also improved
- Constant folding and expression evaluation is now also more complete
- Subroutine extraction and inlining is more robust

* Fortran/F95VarDeclParser.pm:
    - now accepts mixed-case expressions 
    - added parser for `volatile`
* Parser/Combinators.pm:
    - added `mixedCaseWord`
* RefactorF4Acc/Analysis/DeadCodeElimination.pm
    - `analyse_for_dead_code` is now more complete but still experimental
* RefactorF4Acc/Analysis/Variables.pm
    - support for `_[1248]`
* RefactorF4Acc/Config.pm
    - warnings now have a level 0 .. 4, default 1 
    - Extra configuration options: see `CONFIGURATION.md`
        +'PRESERVE_CASE' => 0,
        +'NO_SAVE' => 1,SAVE will be deleted
        +'EXE' => '',
        +'CUSTOM_PASS_OUTPUT_PATH' => '',
        +'STRICT_COMMONS_CHECKS' => 0,
        +'STRICT_EQUIVALENCE_CHECKS' => 0,
        +'IGNORE_ERRORS' => 0,
        +'EXCLUDE_ALL_SUBDIRS','Exclude all subfolders in the source folder? 0/1','0'
        +'RENAME_PARS_IN_INLINED_SUBS','Rename parameters in inlined subroutines (to avoid name conflicts)? 0/1',0
        +'RENAME_VARS_IN_INLINED_SUBS','Rename variables in inlined subroutines (to avoid name conflicts)? 0/1',0
        +'FOLD_CONSTANTS','Fold constants (replace parameters by their values)? 0/1','0'
        +'ONE_SUB_PER_MODULE', 'Create a singleton module for each subroutine? 0/1','1'
        +'PURPOSE_CFG','Relative path to the Purpose configuration','purpose.cfg'

* RefactorF4Acc/CustomPasses.pm
    - Added Scalarise, EliminateDeadCode, IfdefIO
* RefactorF4Acc/Emitter.pm
    - New emitter `emit_AnnLines`, uses the AST instead of the generated lines
* RefactorF4Acc/ExpressionAST/Evaluate.pm
    - A much more comprehensive evaluator
* RefactorF4Acc/Inventory.pm 
    - support for `PRESERVE_CASE`
    - support for `EXCLUDE_ALL_SUBDIRS`
* RefactorF4Acc/Main.pm
    - support for `PRESERVE_CASE`
    - warnings with levels
    - `-S` option to print out generated code to STDOUT
* RefactorF4Acc/Parser/Expressions.pm
    - support for `_[1248]`
    - support for `*` syntax
* RefactorF4Acc/Parser/SrcReader.pm
    - support for `PRESERVE_CASE`
* RefactorF4Acc/Parser.pm
    - Improved parser, in particular for I/O and F90/95 syntax. Also better warnings on unsupported/ignored features. See `LIMITATIONS.md` 
    - Handle `CONTAINS`
* RefactorF4Acc/Refactoring/InlineSubroutine.pm
    - All new
* RefactorF4Acc/Refactoring/Modules.pm
    - Support for `ONE_SUB_PER_MODULE`
* RefactorF4Acc/Refactoring/Subroutines/Emitters.pm
    - Support for `SUB_SUFFIX` 
* RefactorF4Acc/Refactoring.pm
    - Support for `FOLD_CONSTANTS`
* RefactorF4Acc/Translation/OpenCLC.pm
    - This replaces `OpenCLTranslation.pm`


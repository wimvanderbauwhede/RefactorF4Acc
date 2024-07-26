package RefactorF4Acc::Translation::Uxntal;

use v5.30;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( min max );
use RefactorF4Acc::F95SpecWords qw(
    %F95_intrinsic_functions
    %F95_intrinsic_function_sigs
    %F95_intrinsic_subroutine_sigs
    );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass stateful_pass_inplace stateless_pass_inplace pass_wrapper_subs_in_module update_arg_var_decl_sourcelines get_annotated_sourcelines);
use RefactorF4Acc::Refactoring::Fixes qw(
    _declare_undeclared_variables
    _remove_unused_variables
    __has_module_level_declaration
    );
use RefactorF4Acc::Refactoring::CaseToIf qw( replace_case_by_if )    ;
use RefactorF4Acc::Refactoring::FoldConstants qw(
    fold_constants_all
    fold_constants_in_decls
    );
# use RefactorF4Acc::Parser::Expressions qw( @sigils );
use RefactorF4Acc::Translation::LlvmToTyTraIR qw( generate_llvm_ir_for_TyTra );
use RefactorF4Acc::Emitter qw( emit_AnnLines );
use Fortran::F95VarDeclParser qw( parse_F95_var_decl );

use RefactorF4Acc::Translation::UxntalLibHandler qw( load_uxntal_lib_subroutines add_to_used_lib_subs emit_used_uxntal_lib_subroutine_sources);

#
#   (c) 2010-2024 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

no warnings qw(experimental::signatures);
use feature qw(signatures);

@RefactorF4Acc::Translation::Uxntal::ISA = qw(Exporter);

@RefactorF4Acc::Translation::Uxntal::EXPORT_OK = qw(
    &translate_program_to_Uxntal
);

#### #### #### #### BEGIN OF UXNTAL TRANSLATION CODE #### #### #### ####

#               0    1    2    3      4      5      6      7      8      9   10   11   12   13    14
our @sigils = ('(', '&', '$', 'ADD', 'SUB', 'MUL', 'DIV', 'mod', 'pow', '=', '@', '#', ':' ,'//', ')('
#                15    16      17    18      19     20     21     22     23     24       25       26
               ,'EQU', 'NEQ', 'LTH', 'GTH', 'lte', 'gte', 'not', 'AND', 'ORA', 'EOR', '.eqv.', '.neqv.'
#                27   28
               ,',', '(/',
# Constants
#                29         30      31         32           33         34             35       36
               ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
              );

# TODO This needs to be changed so that only the used functions are emitted
my @uxntal_lib_sources = (
    '../../uxntal-libs/fmt-print.tal',
    '../../uxntal-libs/string.tal',
    '../../uxntal-libs/range-map-fold-lib.tal',
    '../../uxntal-libs/process-args-lib.tal',
    '../../uxntal-libs/call-stack.tal'
);

sub translate_program_to_Uxntal($stref,$program_name){
    load_uxntal_lib_subroutines(@uxntal_lib_sources);
    $stref->{'UseCallStack'}=0;
    $stref->{'Uxntal'} = {
        'Macros' => { 'Set' =>{}, 'List' => [] },
        'CallStackPointers'  => [
            '|0000',
            '@csp $2 ( call stack pointer )',
            '@fp $2 ( frame pointer, it points to the *previous* frame )'
        ],
        'Console' => [
        '    |10 @Console &vector $2 &read $1 &pad $4 &type $1 &write $1 &error $1'
        ],
        # For reading
        'ReadFile' => [
        '    |a0 @File &vector $2 &success $2 &stat $2 &delete $1 &append $1 &name $2 &length $2 &read $2 &write $2'
        ],
        # For writing, TODO
        'WriteFile' => [
        '    |b0 @File &vector $2 &success $2 &stat $2 &delete $1 &append $1 &name $2 &length $2 &read $2 &write $2'
        ],

        'CLIHandling' => {
            'Preamble'=> [
                '@buf $40 ( 64 bytes in total )',
                '@argbuf $40 ( 64 bytes in total )',
                '@argc $2',
                '@arglens $7 ( 7 args max, 1 byte each )',
                '@all-done $1'
            ],
            'Main' => [
                '( set vector )',
                ';on-argument .Console/vector DEO2',
                '#00 .argc STZ'
            ],
            'Lib' => '( ~../../../uxntal-libs/process-args-lib.tal )'
        },
        'Main' => {'TranslatedCode'=>[],'Name'=>''},
        'Libraries' => { 'Set' =>{}, 'List' => ['( LIBRARY ROUTINES )'] },
        'Subroutines' => {},
        # { 'LocalVars'=> {'Set' =>{}, 'List' => [] }, 'Args' => {'Set' =>{}, 'List' => [] },  'isMain' => '' , 'TranslatedCode'}
        'Globals' => { 'Set' =>{}, 'List' => [] },
        'CallStack'  => [
            '( ~../../../uxntal-libs/call-stack.tal )',
            '|e000 ( 8 kB call stack )',
            '@call-stack ( grows down )'
        ]
    };


    $stref = fold_constants_all($stref) ;
    my $new_annlines = $stref->{'Subroutines'}{$program_name}{'RefactoredCode'};
    # croak Dumper pp_annlines($new_annlines);
    $stref->{'TranslatedCode'}=[];
    $Config{'FIXES'}={
        # _declare_undeclared_variables => 1,
        # _remove_unused_variables => 1
    };
    # croak "PROBLEM: this does not do a recdescent on the call tree!";
    # $stref = pass_wrapper_subs_in_module($stref,$program_name,
    #    # module-specific passes.
    #    [
    #         # [\&_fold_consts_in_module_decls]
    #         # [\&translate_module_decls_to_Uxntal]
    #    ],
    #    # subroutine-specific passes
    #    [
    #       [ \&replace_case_by_if ],
    #       [\&translate_sub_to_Uxntal]
    #    ]
    #    );
    $stref = do_passes_recdescent($stref,$program_name,
        [
            \&replace_case_by_if ,
            \&translate_sub_to_Uxntal
        ], {}
    );

    add_to_used_lib_subs( 'wst' );
    if ($stref->{'UseCallStack'} ) {
        add_to_used_lib_subs( 'init-call-stack' );
        add_to_used_lib_subs( 'push-frame' );
        add_to_used_lib_subs( 'pop-frame' );
        add_to_used_lib_subs( 'stack-alloc' );
    }
    my @used_uxntal_lib_subroutine_sources=emit_used_uxntal_lib_subroutine_sources();

    $stref->{'TranslatedCode'}=[
        '|00 @System &vector $2 &expansion $2 &wst $1 &rst $1 &metadata $2 &r $2 &g $2 &b $2 &debug $1 &state $1',
        ($stref->{'HasCLArgs'} ? @{$stref->{'Uxntal'}{'Console'}} :()),
        ($stref->{'HasReadFile'} ? @{$stref->{'Uxntal'}{'ReadFile'}} :()),
        ($stref->{'HasWriteFile'} ? @{$stref->{'Uxntal'}{'WriteFile'}} :()),
        '|0000',
        ($stref->{'UseCallStack'} ? @{$stref->{'Uxntal'}{'CallStackPointers'}} : ()),
        ($stref->{'HasCLArgs'} ? @{$stref->{'Uxntal'}{'CLIHandling'}{'Preamble'}} : ()),
        '','|0100',
        ($stref->{'UseCallStack'} ? 'init-call-stack' : ''),
        ($stref->{'HasCLArgs'}
            ? @{$stref->{'Uxntal'}{'CLIHandling'}{'Main'}}
            : $stref->{'Uxntal'}{'Main'}{'Name'}."\n#80 .System/state DEO\n"
        ),
        'BRK','',
        ($stref->{'HasCLArgs'}
            ? '@main '.$stref->{'Uxntal'}{'Main'}{'Name'} . "\n#80 .System/state DEO\nBRK"
            : ''
        ),
        ($stref->{'HasCLArgs'} ?  $stref->{'Uxntal'}{'CLIHandling'}{'Lib'} : ''),'',
        @{$stref->{'Uxntal'}{'Main'}{'TranslatedCode'}},
        @{$stref->{'Uxntal'}{'Libraries'}{'List'}},
        @{$stref->{'TranslatedCode'}}, # These are the subroutines
        @used_uxntal_lib_subroutine_sources,
        # '@nl #0a18 DEO JMP2r',
        @{$stref->{'Uxntal'}{'Globals'}{'List'}},
        @{$stref->{'Uxntal'}{'Macros'}{'List'}},
        ($stref->{'UseCallStack'} ? @{$stref->{'Uxntal'}{'CallStack'}} : ()),
       ];
    #    carp "TODO: Global decls";
    # This prints out the lines from $stref->{'TranslatedCode'}
    $stref = _emit_Uxntal_code($stref, $program_name);
    # This enables the postprocessing for custom passes
    $stref->{'CustomPassPostProcessing'}=1;
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'}={};
} # END of translate_program_to_Uxntal

# TODO: This should include handling of 'use' declarations.
# Unfortunately for those we will need to split the module level declarations from the subroutines.
sub translate_module_decls_to_Uxntal($stref, $mod_name){

    my $pass_emit_module_declarations = sub ($annline, $state){
        (my $line,my $info)=@{$annline};
        # say "MOD LINE: <$line>";
        my $c_line=$line;
        (my $stref, my $mod_name, my $pass_state)=@{$state};
        my $skip=1;

        if (exists $info->{'VarDecl'}) {
                my $var = $info->{'VarDecl'}{'Name'};
                # This never uses that stack as module vars are never automatic
                $c_line = _emit_var_decl_Uxntal( $stref, $mod_name, $info, $var);
                $skip=0;
        }
        elsif ( exists $info->{'ParamDecl'} ) {
            croak "SHOULD NOT HAPPEN ParamDecl", Dumper($info);;
            my $var = $info->{'VarDecl'}{'Name'};
        }
        elsif ( exists $info->{'ParsedVarDecl'} ) {
            croak "SHOULD NOT HAPPEN ParsedVarDecl", Dumper($info);

        }
        elsif ( exists $info->{'ParsedParDecl'} ) {
            croak "SHOULD NOT HAPPEN ParsedParDecl", Dumper($info);
        }
        push @{$pass_state->{'TranslatedCode'}},$c_line unless $skip;

        return ([$annline],[$stref,$mod_name,$pass_state]);
    };

    my $state = [$stref,$mod_name, {'TranslatedCode'=>[]}];
    ($stref,$state) = stateful_pass_inplace($stref,$mod_name,$pass_emit_module_declarations , $state,'emit_module_declarations() ' . __LINE__  ) ;

    $stref->{'Modules'}{$mod_name}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
    $stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}},''];

    return $stref;
} # END of translate_module_decls_to_Uxntal

sub translate_sub_to_Uxntal( $stref, $f){

=info
    # First we collect info. What we need to know is:

    - What are the subroutine arguments, and their types?
    - Scalar && IODir eq 'In' => emit a scalar
    - otherwise => emit a pointer
    - make a list/table of all the arguments, of course we already have that in $stref->{'Subroutines'}{$f}{'RefactoredArgs'}
    - Then for every VarDecl we encounter:
        - if it's an Arg, remove it
        - otherwise, convert it to C syntax
        - In any case, if it is an array, we need the dimensions; but that should exists already in $stref->{'Subroutines'}{$f}{'Vars'}
    - If we find a select/case, we need to mark the *first* case to indicate that it should *not* be prefixed with  "}\n break;"
    - so maybe we actually don't need a separate pass after all ...

WV 2021-06-07

Instead of the nice but cumbersome approach we had until now, from now on it is simple:
- All non-constant, non-param args are pointers because they are addresses
- If a call arg is an expression, then it's a value
- Arguments to calls are therefore always either `;`; &arg_var[idx_expr] becomes ;arg_var idx_expr ADD2
- Accesses in subroutine bodies are always *lhs_vars = expr(*rhs_vars), i.e. expr(*rhs_vars LDA{1,2}) lhs_vars STA{1,2}
- Scalar local vars are values, so also LDA
- A parameter used as arg should be passed by value

=cut
    $stref = _get_word_sizes($stref,$f);
    $stref = _pointer_analysis($stref,$f);
    my $Sf = $stref->{'Subroutines'}{$f};

    my $annlines = get_annotated_sourcelines( $stref, $f );

    # This analysis only looks at args, local vars and local parameters. We need to include globals
    # Or maybe not, as pointer analysis is not necessary for Uxntal.
    # We populate $state->{'Pointers'} and $state->{'WordSizes'} but the latter is not used as
    # $Sf->{'WordSizes'} is populated above via _get_word_sizes()
    # We also check if getarg is called and set CLArgs to 1 if it is
    my $pass_analysis = sub ($annline,$state){
        my ($line, $info) = @{$annline};

        if (exists $info->{'Signature'} ) {
            $state->{'Args'} = { map { $_=>1 } @{$info->{'Signature'}{'Args'}{'List'}}};
        }
        elsif (exists $info->{'VarDecl'} ) {
            my $var = $info->{'VarDecl'}{'Name'};
            if (exists $state->{'Args'}{$var} ) {
                $state->{'Pointers'}{$var}='*'; # means should be treated as a pointer
            } else {
                $state->{'Pointers'}{$var}=''; # means should be treated as a scalar, i.e. LDA
                $state->{'LocalVars'}{$var}=1;
            }
            my $word_sz=0;
            my $type = $info->{'ParsedVarDecl'}{'TypeTup'}{'Type'};
            if ($type eq 'integer') {
                my $kind = $info->{'ParsedVarDecl'}{'TypeTup'}{'Kind'};
                if ($kind>2) {
                    die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
                }
                $word_sz=$kind;
            }
            elsif ($type eq 'logical') {
                $word_sz=1;
            }
            elsif ($type eq 'character') {
                    $word_sz=1;
            } elsif ($type =~/^character\(/) {
                    $word_sz=2;
            } else {
                die "Supported types are integer, character, string and logical: $var in $f is $type\n";
            }
            if (not exists $Sf->{'WordSizes'}{$var}) {
                # carp 'MISSING WORDSZ for '.$var;
                # The previous analysis does not include unused variables
                $state->{'WordSizes'}{$var}=$word_sz;
            } elsif ($Sf->{'WordSizes'}{$var} != $word_sz ) {
                carp 'CONFLICTING WORDSZ for '.$var.': '.$Sf->{'WordSizes'}{$var}.' != '.$word_sz;
            }
        }
        elsif ( exists $info->{'ParamDecl'} ) {
            my $var = $info->{'ParamDecl'}{'Var'};
            $state->{'Pointers'}{$var}='';
            $state->{'Parameters'}{$var}=1;
            my $word_sz=0;
            my $type = $info->{'ParsedParDecl'}{'TypeTup'}{'Type'};
            if ($type eq 'integer') {
                my $kind = $info->{'ParsedParDecl'}{'TypeTup'}{'Kind'};
                if ($kind>2) {
                    die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
                }
                $word_sz=$kind;
            } elsif ($type eq 'logical') {
                $word_sz=1;
            } elsif ($type eq 'character') {
                $word_sz=1;
            } elsif ($type =~/^character\(/) {
                    $word_sz=2;
            } else {
                die "Supported types are integer, character, string and logical: $var in $f is $type\n";
            }
            $state->{'WordSizes'}{$var}=$word_sz;
        }
        # FIXME: this is because of the presence of an empty $info->{'SubroutineCall'} record.
        elsif (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) {
            my $fname =  $info->{'SubroutineCall'}{'Name'};
            if (not exists $F95_intrinsic_functions{$fname} ) {
                for my $call_arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
                    my $call_arg = ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Scalar'
                    or $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const'
                    or $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr'
                    ) ? $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Expr'}
                    : $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Arg'};

                    if (exists $state->{'LocalVars'}{$call_arg}) {
                        $state->{'Pointers'}{$call_arg}='*';
                    }
                    elsif (exists $state->{'Parameters'}{$call_arg}) {
                        $state->{'Pointers'}{$call_arg}='&';
                        # carp 'TODO: a const scalar passed as arg: ',$call_arg_expr_str ;
                    }
                }
            } elsif ($fname eq 'getarg' or $fname eq 'iargc') { # call to getarg means we need the machinery
                $state->{'CLArgs'}=1;
                add_to_used_lib_subs($fname);
                add_to_used_lib_subs('on-argument');
            }
        }
        elsif ( exists $info->{'FunctionCalls'} ) {
            for my $entry (@{$info->{'FunctionCalls'}}) {
                my $fname =  $entry->{'Name'};
                if (not exists $F95_intrinsic_functions{$fname} ) {
                    # We assume intrinsics take values not pointers
                    for my $arg (sort keys %{$entry->{'Args'}}) {
                        if (exists $state->{'LocalVars'}{$arg}) {
                            $state->{'Pointers'}{$arg}='*';
                        }
                    }
                } else {
                    add_to_used_lib_subs($fname);
                }
            }
        }

        return ([[$line,$info]],$state)
    };

    my $pass_state = {'Pointers'=>{},'CLArgs'=>0,'Args' =>{},'LocalVars' =>{}, 'Parameters'=>{}, 'WordSizes'=>{}};
    (my $new_annlines_,$pass_state) = stateful_pass($annlines,$pass_analysis,$pass_state,"pass_analysis($f)");
    $Sf->{'Pointers'} = $pass_state->{'Pointers'};
    $Sf->{'WordSizes'} =
        exists $Sf->{'WordSizes'}
        ? { %{$Sf->{'WordSizes'}}, %{$pass_state->{'WordSizes'}}}
        : { %{$pass_state->{'WordSizes'}}};
    $stref->{'HasCLArgs'} = $pass_state->{'CLArgs'} unless (exists $stref->{'HasCLArgs'} and $stref->{'HasCLArgs'}==1);

# --------------------------------------------------------------------------------------------
# If the routine uses a call stack, add vars to be allocated on the stack to StackAllocInfo
     # $Sf->{'UseCallStack'}=1; # override for debugging
    my $use_stack = __use_stack($stref,$f);
    my @stack_alloc_info_nbytes_inits=();
    my @stack_alloc_info=();
    my @stack_array_string_inits=();
    my $stack_alloc_nbytes = 0;
    if ($use_stack) {
        $Sf->{'CurrentOffset'}=0;
        $stref->{'UseCallStack'}=1;
        my $pass_stack_allocation = sub ($annline, $state){
            (my $line,my $info)=@{$annline};
            (my $stref, my $f, my $pass_state)=@{$state};

            if (exists $info->{'VarDecl'}  ) {
                my $var = $info->{'VarDecl'}{'Name'};
                if (not exists $stref->{'Subroutines'}{$var}
                and (not exists $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}
                or $var ne $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} )
                ) { # otherwise it is a function
                # say "Stack alloc for $var in $f";
                    push @{$pass_state->{'StackAllocInfo'}}, _stack_allocation($stref,$f,$var);
                }
            } elsif (exists $info->{'ArgDecl'}) {
                croak "ArgDecl should also be allocated on the stack!"
            } elsif (exists $info->{'Signature'} && exists $info->{'Signature'}{'ResultVar'}) {
                my $var = $info->{'Signature'}{'ResultVar'};
                if (not is_array_or_string($stref,$f,$var)) { # otherwise we allocate statically
                    push @{$pass_state->{'StackAllocInfo'}}, _stack_allocation($stref,$f,$var);
                }
            }
            return ([$annline],[$stref,$f,$pass_state]);
        };

        my $stack_alloc_state = [$stref,$f,
            # pass state
            {
                'StackAllocInfo' => []
            }
            ];
        ($stref,$stack_alloc_state) = stateful_pass_inplace($stref,$f,$pass_stack_allocation, $stack_alloc_state,'pass_stack_allocation() ' . __LINE__  ) ;
        @stack_alloc_info_nbytes_inits=@{$stack_alloc_state->[2]{'StackAllocInfo'}};

        for my $entry (@stack_alloc_info_nbytes_inits) {
            $stack_alloc_nbytes+=$entry->[1];
        }
        @stack_alloc_info = map {$_->[0]} @stack_alloc_info_nbytes_inits;
        @stack_array_string_inits= grep { !/^\s*$/ } map {$_->[2]} @stack_alloc_info_nbytes_inits;
    } # use stack

# --------------------------------------------------------------------------------------------
    my $pass_translate_to_Uxntal = sub ($annline, $state){
        (my $line,my $info)=@{$annline};
        my $c_line= $line eq '' ? '' : "( TODO $line )";
        (my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineID'};
        my $skip=0;
        my $skip_comment=0;
        if (exists $info->{'Signature'} ) {
            # subroutine f(x) becomes @f ;x LDA{sz} if x is read
            # but if x is write, then we have
            # @f ... ;x STA{sz} JMP2r
            # So what we need is to create a Set $arg => [$wordz, $iodir]
            # and a List of $arg
            # Or maybe {ReadArgs} and {WriteArgs} with the actual code
            $pass_state->{'Args'}=$info->{'Signature'}{'Args'}{'List'};
            my ($sig_line,$arg_decls, $args_to_store,$write_args,$isMain) = _emit_subroutine_sig_Uxntal( $stref, $f, $annline);
            $pass_state->{'Subroutine'}{'ArgDecls'}=$arg_decls;
            $pass_state->{'Subroutine'}{'Sig'}=[
                "( ____ $line )",
                $sig_line, ($use_stack ? 'push-frame' :''),
                ($use_stack ? toHex($stack_alloc_nbytes,2).' stack-alloc' : '') # FIXME: not pure, $use_stack and $stack_alloc_nbytes are global
                ];
            $pass_state->{'Subroutine'}{'ReadArgs'}=$args_to_store;
            $skip=1;$skip_comment=1;
            $pass_state->{'Subroutine'}{'WriteArgs'}=$write_args;
            if ($isMain) {
                $pass_state->{'Subroutine'}{'IsMain'}=$f;
            }
        }
        elsif (exists $info->{'VarDecl'} and not $use_stack ) {
            my $var = $info->{'VarDecl'}{'Name'};
            if (not exists $stref->{'Subroutines'}{$var}) { # otherwise it is a function
                if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}) {
                    $c_line='( '.$line.' )';
                    # croak 'WHY?'.$line;
                } else {
                    if (not (exists $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} 
                    and $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} eq $var)) {
                        ($stref,my $uxntal_var_decl) =  _emit_var_decl_Uxntal($stref,$f,$info,$var);
                        if (not exists $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_var_decl}) {
                            $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_var_decl}=$uxntal_var_decl;
                            $skip_comment=1;
                            push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}}, "( ____ $line )" unless $skip_comment;
                            push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}},$uxntal_var_decl;
                        } else {
                            croak "Vars should be unique: $uxntal_var_decl";
                        }
                    }
            }
            }
            $skip=1;
        }
        elsif ( exists $info->{'ParamDecl'} ) {
            # A parameter should become a macro
            my $var = $info->{'ParamDecl'}{'Var'};
            ($stref,my $uxntal_par) = _emit_var_decl_Uxntal($stref,$f,$info,$var);
            if (not exists $stref->{'Uxntal'}{'Macros'}{'Set'}{$uxntal_par}) {
                $stref->{'Uxntal'}{'Macros'}{'Set'}{$uxntal_par}=$uxntal_par;
                push @{$stref->{'Uxntal'}{'Macros'}{'List'}},$uxntal_par;
            } else {
                croak "Macros should be unique: $uxntal_par";
            }
            $skip=1;
        }
        # For Uxntal, we need to turn the Case into an IfThen
        elsif (exists $info->{'Select'} ) {
            croak 'SHOULD NOT HAPPEN!';
        }
        elsif (exists $info->{'Case'} ) {
            croak 'SHOULD NOT HAPPEN!';
        }
        elsif (exists $info->{'CaseDefault'}) {
            croak 'SHOULD NOT HAPPEN!';
            # $c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.'default : {';
        }
        elsif (exists $info->{'Do'} ) {
            if (exists $info->{'Do'}{'While'}) {
                push @{$pass_state->{'DoStack'}}, [$id,$info->{'Do'}{'ExpressionsAST'},'While'];
                $c_line = '&while_loop_'.$f.'_'.$id . "\n" ;
            } else {
                my $do_iterator = $f.'_'.$info->{'Do'}{'Iterator'};
                $stref->{'Subroutines'}{$f}{'DoIterators'}{$info->{'Do'}{'Iterator'}}=$do_iterator;
                my $uxntal_do_iter_decl = '@'.$do_iterator.' $2';
                if (not exists $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_do_iter_decl}) {
                    $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_do_iter_decl}=$uxntal_do_iter_decl;
                    $skip_comment=1;
                    push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}}, "( ____ $line )" unless $skip_comment;
                    push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}},$uxntal_do_iter_decl;
                }
                my $do_step = $info->{'Do'}{'Range'}{'Expressions'}[2];
                if ($do_step!~/^\-?\d+$/) {
                    error("Only DO with constant integer STEP is supported: $line in $f",0,'ERROR');
                }
                push @{$pass_state->{'DoStack'}}, [
                    $id,$do_iterator,$do_step,'Do'];
                my ($do_start,$word_sz)= _emit_expression_Uxntal($info->{'Do'}{'Range'}{'ExpressionASTs'}[0],$stref, $f, $info);
                (my $do_stop,$word_sz) =  _emit_expression_Uxntal($info->{'Do'}{'Range'}{'ExpressionASTs'}[1],$stref, $f, $info);
                $c_line = $do_stop . ' INC2 ' . $do_start . "\n" .
                # 'DUP2 EQU2k ;&loop_end_'.$f.'_'.$id.' JCN2'. "\n" .
                'OVR2 OVR2 SUB2 #fff7 GTH2 ;&loop_end_'.$f.'_'.$id.' JCN2'. "\n" .
                '&loop_'.$f.'_'.$id . "\n" .
                ';'.$do_iterator.' STA2 ';
            }
        }
        elsif (exists $info->{'BeginDo'} ) {
            croak 'TODO: BeginDo: what is this?';
            $c_line='for () {';
        }

        if (exists $info->{'Assignment'} ) {
            ($c_line,$pass_state) = _emit_assignment_Uxntal($stref, $f, $info,$pass_state) ;
            if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
                my $indent = $info->{'Indent'};
                my $branch_id = $info->{'LineID'};
                my $cond_expr_ast=$info->{'Cond'}{'AST'};
                my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
                $c_line = "\n$cond_expr #00 EQU ,&branch$branch_id JCN\n" . $indent.$c_line;
                $c_line .= "\n&branch$branch_id";
            }
        }
        elsif (exists $info->{'SubroutineCall'} and not exists $info->{'IOCall'}) {
            $c_line = _emit_subroutine_call_expr_Uxntal($stref,$f,$line,$info);
            # If without Then
            if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
                my $indent = $info->{'Indent'};
                my $branch_id = $info->{'LineID'};
                my $cond_expr_ast=$info->{'Cond'}{'AST'};
                my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
            # What we have is e.g.
            # if (fl(1:2) == __PH0__) VV = .true.
            # What we need is
            # NOT <cond> <label_end> JCN
                $c_line = "\n$indent $cond_expr #00 EQU ;&branch$branch_id JCN2\n" . $c_line;
            # <expr>
                $c_line .= $indent.' '."&branch$branch_id";
            }
        }
        elsif (exists $info->{'IOCall'}) {
            if (exists $info->{'PrintCall'}) {
                # say "PRINT: $line";
                # say Dumper $info;
                $c_line = __emit_list_based_print_write($stref,$f,$line,$info, '*','yes');
                # croak Dumper($c_line) if $line=~/decodeTokenStrI/;    
                # say "UXNTAL: $c_line";
            } elsif (exists $info->{'WriteCall'}) {
                # carp Dumper $info;
                my $call_ast = $info->{'IOCall'}{'Args'}{'AST'};
                my $iolist_ast = $info->{'IOList'}{'AST'};
                # TODO: check if this is a write to a file!
                # say 'WRITE: IOCall Args:'.Dumper($call_ast),'IOList:',Dumper($iolist_ast);
                say "WRITE: $line";
                my ($print_calls, $offsets, $unit, $advance) = _analyse_write_call($stref,$f,$info);
                if (scalar @{$print_calls} == 1 and
                    (
                        $print_calls->[0] eq 'print-list' or
                        $print_calls->[0] eq 'print-list-stderr'
                    )
                ) {
                    # add_to_used_lib_subs($print_calls->[0]);
                    $c_line = __emit_list_based_print_write($stref,$f,$line,$info, $unit,$advance);
                    # say "UXNTAL SINGLE WRITE: $c_line";
                } else {
                    # if ($unit eq 'STDOUT' or $unit eq 'STDERR') {
                    add_to_used_lib_subs('update-len');
                    my ($uxntal_expr_str,$word_sz) = _emit_expression_Uxntal([2,$unit],$stref, $f, $info);
                    my $update_len = ($unit eq 'STDOUT' or $unit eq 'STDERR') ? '' :
                        ' '.$uxntal_expr_str. ' update-len ';
                    $c_line = ($unit eq 'STDOUT' or $unit eq 'STDERR') ? '' :
                        ' #0000 '.$uxntal_expr_str. ' STA2 ';
                    my $maybe_str = ($unit eq 'STDOUT' or $unit eq 'STDERR')
                        ? ''
                        : $uxntal_expr_str;
                    # ";$unit ";
                    my $idx=1;
                    for my $print_call (@{$print_calls}) {
                        add_to_used_lib_subs($print_call);
                        my $maybe_offset= $maybe_str ne ''
                            ? $offsets->[$idx-1] == 0
                                ? ' '
                                : ' '.toHex( $offsets->[$idx-1],2).' ADD2 '
                            : ' ';
                        my $arg_ast = [];
                        if ($iolist_ast->[0] == 27) {
                            # warn "$line: $print_call: ".Dumper($iolist_ast->[$idx++]);
                            $arg_ast = $iolist_ast->[$idx++];
                        } else {
                            # warn "$line: $print_call: ".Dumper($iolist_ast);
                            $arg_ast = $iolist_ast;
                        }
                        # say Dumper( $offsets->[$idx-1] -($idx<1?0:$offsets->[$idx-2]), $arg_ast);
                        my ($arg_exp_Uxntal,$word_sz) = _emit_expression_Uxntal($arg_ast,$stref, $f, $info);
                        if ($arg_exp_Uxntal=~/\#\d+/ and $print_call=~/string/) {
                            $print_call=~s/string/char/;
                        }
                        $c_line.= $arg_exp_Uxntal.' '.$maybe_str.$maybe_offset.$print_call.'' .$update_len. " ";

                    }
                    # say "UXNTAL: $c_line";
                }
            }
            elsif (exists $info->{'OpenCall'}) {
                # open(unit=$src,file=$fn,iostat=$stat,action='read', status='old', recl=1,access='direct',form='unformatted') )
                my $fn = __create_fq_varname($stref,$f,$info->{'FileNameVar'});
                my $unit= $info->{'UnitVar'};
                my $fq_unit= __create_fq_varname($stref,$f,$unit);
                my $iostat = __create_fq_varname($stref,$f,$info->{'IOStat'});
                my ($uxntal_var_access, $word_sz) = _var_access_read($stref,$f,$info, [2,$info->{'FileNameVar'}]);
                $c_line = $uxntal_var_access .
                " #0002 ADD2 .File/name DEO2";
                if (not exists $stref->{'Subroutines'}{$f}{'FileHandle'}) {
                    $stref->{'Subroutines'}{$f}{'FileHandle'}{$unit}={
                        'Unit' => $fq_unit,
                        'IOStat' =>$iostat,
                        'File' => $fn
                    };
                } else {
                    die "Only a single file handle is supported\n";
                }
            }
            elsif (exists $info->{'CloseCall'}) {
                my $unit= $info->{'UnitVar'};
                $c_line = '.File/name DEI2k ROT DEO2';
                delete $stref->{'Subroutines'}{$f}{'FileHandle'}{$unit};
            }
            elsif (exists $info->{'ReadCall'}) {
                $stref->{'HasReadFile'}=1;
                # read(unit=$src,iostat=$stat,rec=$i) $cbuf
                my $rec = __create_fq_varname($stref,$f,$info->{'RecVar'});
                # croak Dumper sort keys %{$info};
                if ($info->{'IOList'}{'AST'}[0] != 2) {
                    die "READ is only supported with a single arg in the IO list\n";
                }
                my $cbuf = $info->{'IOList'}{'AST'}[1];
                # my $subset = in_nested_set($Sf,'Vars',$cbuf);
                # if ($subset eq '') {
                #     croak "$f $cbuf";
                # }
                # my $decl = get_var_record_from_set($Sf->{$subset},$cbuf);
                my $decl = getDecl($stref,$f,$cbuf);
                my $len=0;
                if ($decl->{'Type'} ne 'character') {
                    die "READ is only supported with a character buffer\n";
                } else {
                    if (exists $decl->{'Attr'} and $decl->{'Attr'}=~/len/) {
                        $len=$decl->{'Attr'}; $len=~s/^\(len=//;$len=~s/\)$//;
                    } else {
                        $len=1;
                    }
                }
                my $uxntal_len = toHex($len,2);
                my $fq_cbuf = __create_fq_varname($stref,$f,$cbuf);
                my $iostat = __create_fq_varname($stref,$f,$info->{'IOStat'});
                $c_line = "$uxntal_len .File/length DEO2\n"
                . ";$fq_cbuf .File/read DEO2\n"
                . ";$rec LDA2 INC2 ;$rec STA2\n"
                . ".File/success DEI2 #0001 SUB2 ;$iostat STA2";
            } else {
                croak 'TODO: IOCall '.Dumper( $info->{'IOCall'}{'Args'}{'AST'})."\nIOList ".Dumper($info->{'IOList'}{'AST'});
            }
            if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
                my $indent = $info->{'Indent'};
                my $branch_id = $info->{'LineID'};
                my $cond_expr_ast=$info->{'Cond'}{'AST'};
                my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
            # What we have is e.g.
            # if (fl(1:2) == __PH0__) VV = .true.
            # What we need is
            # NOT <cond> <label_end> JCN
                $c_line = "\n$indent $cond_expr #00 EQU ;&branch$branch_id JCN2\n" . $c_line;
            # <expr>
                $c_line .= $indent.' '."&branch$branch_id";
            }
        }
        elsif (exists $info->{'If'} and not exists $info->{'IfThen'} ) {
            if (exists $info->{'Goto'}) {
                $c_line = ',&'.$f.'_'.$info->{'Goto'}{'Label'}.' JMP';
            } else {
                croak "If without Then, not assignment, goto or call: $line";
            }
            my $indent = $info->{'Indent'};
            my $branch_id = $info->{'LineID'};
            my $cond_expr_ast=$info->{'Cond'}{'AST'};
            my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
            $c_line = "\n( If without Then )\n" . $indent.' '."$cond_expr #00 EQU ;&branch$branch_id JCN2\n" . $c_line;
            $c_line .= $indent.' '."&branch$branch_id";
        }
        elsif (exists $info->{'IfThen'} and not exists $info->{'ElseIf'} ) {
            # say "EX-CASE: $line => If IfId = $id" if $f eq 'decodeTokenStr';
            $pass_state->{'IfBranchId'} = $id;
            push @{$pass_state->{'IfStack'}},$id;
            $pass_state->{'IfId'}=$id;
            push @{$pass_state->{'BranchStack'}},$id;
            $c_line = _emit_ifthen_Uxntal($stref, $f, $info, $id);
        } elsif (exists $info->{'ElseIf'} ) {
            # say "EX-CASE: $line => ElseIf IfId=$id" if $f eq 'decodeTokenStr';
            ($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
            $c_line .= _emit_ifthen_Uxntal($stref, $f, $info, $branch_id);
            push @{$pass_state->{'BranchStack'}},$branch_id;
        } elsif (exists $info->{'Else'} ) {
            # say "EX-CASE: $line => Else IfId=$id" if $f eq 'decodeTokenStr';
            ($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
            $c_line .= "&branch$branch_id";
            push @{$pass_state->{'BranchStack'}},$branch_id;
        } elsif (exists $info->{'EndIf'} ) {
            # say "EX-CASE: $line => EndIf IfId=$id" if $f eq 'decodeTokenStr';
            # my $branch_id = $pass_state->{'IfBranchId'};
            my $branch_id = pop @{$pass_state->{'BranchStack'}};
            my $if_id = $pass_state->{'IfId'};
            $c_line = ';&cond_end'.$if_id.' JMP2 '."\n"
            .'&branch'.$branch_id.'_end &cond_end'.$if_id;
            pop @{$pass_state->{'IfStack'}};
            $pass_state->{'IfId'}=$pass_state->{'IfStack'}[-1];
        }
        elsif (
                exists $info->{'EndDo'}
            ) {
                my $do_tup = pop @{$pass_state->{'DoStack'}};
                if ($do_tup->[-1] eq 'Do') {
                    # croak Dumper $f,$annline,$do_tup;
                    my ($do_id, $do_iter, $do_step) = @{$do_tup};
                    my $inc = $do_step == 1 ? 'INC2' : toHex($do_step,2). ($do_step>0 ? ' ADD2' : ' SUB2');
                    my $dec = $do_step == 1 ? '#0001 SUB2' : toHex($do_step,2). ($do_step<0 ? ' ADD2' : ' SUB2');
                    # This says, INC and then compare, if it is not equal, loop again
                    # But fortran says compare then INC
                    $c_line = ";$do_iter LDA2 $inc OVR2 OVR2 NEQ2 ".';&loop_'.$f.'_'.$do_id.' JCN2 '."\n;$do_iter LDA2 $inc ;$do_iter STA2\n".
                    '&loop_end_'.$f."_$do_id POP2 POP2\n";
                } else { # while
                # croak Dumper $do_tup;
                    my ($do_id, $do_while_cond) = @{$do_tup};
                    ($c_line,my $word_sz) =  _emit_expression_Uxntal($do_while_cond,$stref, $f, $info);
                    $c_line .= "\n".';&while_loop_'.$f.'_'.$do_id.' JCN2';
                }
        }
        elsif ( exists $info->{'EndProgram'} ) {

            $info->{'Indent'} = '' ;
            # $c_line = 'BRK' ;
            $c_line = $use_stack ? '!pop-frame' : 'JMP2r';

        }
        elsif ( exists $info->{'EndSubroutine'} ) {
            # Here we must emit the code to put the values for Out and InOut args on the stack
            # WV 20240126: or not? A subroutine has not return values, right. And any `OUT`s should have been written to elsewhere.
            # $c_line = _emit_subroutine_return_vals_Uxntal($stref,$f,$info);
            # $info->{'Indent'} = '' ;
            $c_line = $use_stack ? '!pop-frame' : 'JMP2r';
        }
        elsif ( exists $info->{'EndFunction'} ) {
            # A function returns either its RESULT or its own name.
            # If the result is an array or string we should return a reference

            my $fname = $info->{'EndFunction'}{'Name'};
            # carp Dumper $stref->{'Subroutines'}{$fname}{'Signature'};
            my $res = exists $stref->{'Subroutines'}{$fname}{'Signature'}{'ResultVar'}
                ?  $stref->{'Subroutines'}{$fname}{'Signature'}{'ResultVar'}
                : $fname;
            my $word_sz = $stref->{'Subroutines'}{$fname}{'WordSizes'}{$res};
            my $short_mode =  $word_sz == 2 ? '2' : '';
            if (is_array_or_string($stref,$f,$res)) {
                # We return the address
                # ResultVar should always be statically allocated if it is an array or string
                $c_line = ';'. __create_fq_varname($stref,$f,$res)."\n";
                $c_line .= $use_stack ?  ' !pop-frame' : ' JMP2r' ;
            } else {
                # We return the value
                if ($use_stack) {
                    $c_line =  __stack_access($stref,$f,$res).' LDA'.$short_mode.' !pop-frame';
                } else {
                    $c_line = ';'. __create_fq_varname($stref,$f,$res).' LDA'.$short_mode .' JMP2r';
                }
            }
        }
        elsif (exists $info->{'EndSelect'} ) {
            croak 'SHOULD NOT HAPPEN!';
                #  $c_line = '    }'."\n".$info->{'Indent'}.'}';
        }

        elsif (exists $info->{'Comments'} ) {
            $c_line = '( '.$line.' )';
        }
        elsif (exists $info->{'Use'}) {
            if ($line=~/$f/) {
                $c_line = '( '.$line.' )'; $skip=1;$skip_comment=1;
            } else {
            # We should parse the module, or we can simply assume that we replace it with an include with the same name
            warn "Replacing USE with #include: ".$line;
            $line=~s/^\s*use\s+//;
            $line=~s/\s*$//;
            $c_line = "( from $line )";
            }
        }
        elsif (
            exists $info->{'ImplicitNone'} or
            exists $info->{'Implicit'}
        ) {
            $c_line = '//'.$line; $skip=1;
        }
        elsif (exists $info->{'Include'} ) {
            $line=~s/^\s*//;
            $c_line = '#'.$line;
        }
        elsif (exists $info->{'Goto'} ) {
            $c_line = ',&'.$f.'_'.$info->{'Goto'}{'Label'}.' JMP';
        }
        elsif (exists $info->{'Continue'}) {
            $c_line='&'.$f.'_'.$info->{'Label'};
        }
        elsif (exists $info->{'Common'}) {
            $c_line='';
        }
        if (exists $info->{'Label'} ) {
            if (not exists $info->{'Continue'}) { die "Labels can only occur on `continue` lines\n"; }
            # croak Dumper $info;
            # $c_line = $info->{'Label'}. ' : '."\n".$info->{'Indent'}.$c_line;
        }
        chomp $c_line;
        $skip_comment=1;
        push @{$pass_state->{'Subroutine'}{'TranslatedCode'}},"( ____ $line )" unless $skip_comment or $line=~/^\s*$/;
        push @{$pass_state->{'Subroutine'}{'TranslatedCode'}},$c_line unless $skip;
        # push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line     unless $skip;
        return ([$annline],[$stref,$f,$pass_state]);
    };

    my $state = [$stref,$f,

    # pass state
    # for subroutine, we need the args, local vars and the actual body
    # That then goes into $stref->{'Uxntal'}{'Subroutines'}{$f}
    {
        'Args' => {'Set' =>{}, 'List' => [] },
        'Subroutine' => {
            'WriteArgs' => {}, # This should probably replace Pointers
            'IsMain' => '',
            'TranslatedCode'=>[],
            'ArgDecls'=>[],
            'LocalVars'=> {'Set' =>{}, 'List' => [] },
            # 'LocalVarDecls' =>[],
            # 'DoIterators' => {'Set' =>{}, 'List' => [] },
            'ReadArgs' => [],
            'Sig' => '',
        },
        'IfStack'=>[],'IfId' =>0,
        'BranchStack'=>[],'IfBranchId' =>0,
        'DoStack'=>[], 'DoId' => 0,
    }
    ];
     ($stref,$state) = stateful_pass_inplace($stref,$f,$pass_translate_to_Uxntal, $state,'pass_translate_to_Uxntal() ' . __LINE__  ) ;
# --------------------------------------------------------------------------------------------
    my $sub_uxntal_code = $state->[2]{'Subroutine'};
    # $stref->{'Uxntal'}{'Subroutines'}{$f}=$sub_uxntal_code;
     # $stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
     my @translated_sub_code=(
        # @{$stref->{'TranslatedCode'}},'',
        @stack_alloc_info, # This is purely info
        @{$sub_uxntal_code->{'ArgDecls'}},
        @{$sub_uxntal_code->{'LocalVars'}{'List'}},
        @{$sub_uxntal_code->{'Sig'}},
        @stack_array_string_inits,
        @{$sub_uxntal_code->{'ReadArgs'}},
        @{$sub_uxntal_code->{'TranslatedCode'}},
        # @{$stref->{'TranslatedCode'}},'',
        #  @{$state->[2]{'ArgVarDecls'}},'',
        #  @{$state->[2]{'TranslatedCode'}}
     ) ;
    # $stref->{'Uxntal'}{'Subroutines'}{$f}{'TranslatedCode'}=$stref->{'TranslatedCode'};

    if ( $sub_uxntal_code->{'IsMain'} ne '') {
        $stref->{'Uxntal'}{'Main'}{'Name'} = $sub_uxntal_code->{'IsMain'};
        $stref->{'Uxntal'}{'Main'}{'TranslatedCode'} = [@translated_sub_code];
        delete $stref->{'Uxntal'}{'Subroutines'}{$f};
    } else {
        $stref->{'TranslatedCode'}=[
                @{$stref->{'TranslatedCode'}},'',"( ==== $f ==== )",'', @translated_sub_code
        ];
    }
     return $stref;

} # END of translate_sub_to_Uxntal()

sub _get_word_sizes($stref,$f){
    my $Sf = $stref->{'Subroutines'}{$f};

    for my $var (@{$Sf->{'AllVarsAndPars'}{'List'}}) {
        # my $subset = in_nested_set($Sf,'Vars',$var);
        # if ($subset eq '') {
        #     croak "$f $var";
        # }
        # my $decl = get_var_record_from_set($Sf->{$subset},$var);
        my $decl = getDecl($stref,$f,$var);
        my $word_sz=0;
        my $type = $decl->{'Type'};
        if ($type eq 'integer') {
            my $kind = $decl->{'Attr'};
            $kind=~s/kind\s*=\s*//;
            $kind=~s/^\s*\(\s*//;
            $kind=~s/\s*\)\s*$//;
            if( $kind eq '') {
                warn "default kind for $var in $f";
                $kind=4;
            } else {
                $kind*=1;
            }
            if ($kind>2) {
                die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
            }
            $word_sz=$kind;
        }
        elsif ($type eq 'logical') {
            $word_sz=1;
        }
        elsif ($type eq 'character') {
                # if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '' and $decl->{'Attr'}!~/len=1/) {
                #     # It's a string, not a character, so we store the address, not the value.
                #     # croak('WRONG! Need to disambiguate between the pointer and the value!');
                #     $word_sz=2;
                # } else {
                    $word_sz=1;
                # }
        } elsif ($type =~/^character\(/) {
                $word_sz=2;
        } else {
            die "Supported types are integer, character, string and logical: $var in $f is $type\n";
        }
        $Sf->{'WordSizes'}{$var} = $word_sz;
        # carp Dumper($decl) if $var eq 'funktalGlobalCharArray';
        if (exists $decl->{'ModuleName'}) {
            $stref->{'Modules'}{$decl->{'ModuleName'}}{'WordSizes'}{$var} = $word_sz;
        }
    }
    return $stref;
} # END of _get_word_sizes

sub __use_stack($stref,$f) {
    my $Sf = $stref->{'Subroutines'}{$f};
    if (exists $Sf->{'UseCallStack'}) {
        return 1;
    }
    elsif (exists $Sf->{'Recursion'} ) {
        if ($Sf->{'Recursion'} eq 'No' or $Sf->{'Recursion'} eq 'Tail' ) {
            return 0;
        } else {
            return 1;
        }
    } else {
        return 0;
    }
} # END of __use_stack


# WV20240419 I think this should be obsolete, or at least, what we need is determine if we pass by value or by reference. We should keep the WordSizes analysis
# So: an array or string is always an address
# when we pass them as arg to a subroutine, we store the address as a pointer, so we need to dereference
# a scalar is always a value
# when we pass them as arg to a subroutine, we store the value
# So the analysis we need is:
    # if var is array or string
    #     if var is arg
    #         passed by reference, so
    #             ref addr STA2
    #             addr LDA2 [idx ADD2] LDA(2)
    #     else
    #         not passed, so
    #             val addr [idx ADD2] STA(2)
    #             addr [idx ADD2] LDA(2)
    # else
    #     if var is arg
    #         passed by value, so
    #             val addr STA(2)
    #             addr LDA(2)
    #     else
    #         not passed, so
    #             val addr STA(2)
    #             addr LDA(2)

# What we need to add here is the case of stack-based allocation
# The name needs to be unique. The neatest way is to use child labels.
# But at the moment I am putting the alloc before the def
# So let's keep that for now

# With { } STH2r strings, the string variable would always store an address.
# So the question is if using those inline strings is the right thing to do.
# I think we handle this as follows:
# TODO
# an assignment of a string literal to a var means:
#     If the var is locally declared (and therefore allocated) we do a strcpy
#     If the var is an arg, we simply copy the address
# an assignment of a string var to another string var (no indexing)
#     if it is a local, we do a strcpy
#     if it is an arg, it's by reference
# an assignment of a array var to another array
#    if it is an arg, it's by reference
#     if it is a local, we do a array copy I think
# TODO
# If I want to incorporate string access in here, I need the full ast because
# $idx is a pair
# Of course once I do that, I might as well get the var from the ast
# ['@',$var,[',',@idx_exprs]] : 10, 3 args, last arg is array has 27
# ['@',$var,[':',$idx_expr_b,$idx_expr_e]] # This can be an array slice OR a string access : 10, 3 args, last arg is array has 12
# ['@',$var,$idx_expr] : 10, 3 args, last arg is scalar
# ['$',$var] : 2, 2 args,
# WV 2024-05-12 Maybe I should do this differently: 'ST' always means an assignment, so maybe I should split var_access in read and write?
# If read
# If single word (i.e. '$', 2): ";$fq_var LD$word_sz"
# If slice and string, then it is a substring, and it split var_access in read and write?
# If it's read, and it's a single word, then it's just an LD
# But if it is a slice, then it is a substring, and it will need a memwrite-string
# In other words, it is either read or assign: even an OUT arg must be assigned somewhere.
# And except for the memwrite-string and memwrite-array, having a read access function still makes sense.

# Returns the Uxntal expression and its word size
sub _var_access_read($stref,$f,$info,$ast) {
    my ($var,$idxs,$idx_expr_type) = __unpack_var_access_ast($ast);
    if ($var eq 'STDOUT') {
        return ('#18',1);
    }
    elsif ($var eq 'STDERR') {
        return ('#19',1);
    }
    my $Sf = $stref->{'Subroutines'}{$f};
    my $word_sz = $Sf->{'WordSizes'}{$var};
    
    my $short_mode = $word_sz == 2 ? '2' : '';
    my $uxntal_code = '';

    if (is_param($stref,$f,$var)) {
        $uxntal_code = __create_fq_varname($stref,$f,$var);
    } else {
        my $var_access = __var_access($stref,$f,$var);

        if (is_array($stref,$f,$var)) {
            if ($idx_expr_type == 1) {
                my $idx_offset = __get_array_index_offset($stref,$f,$var);
                my $idx_offset_Uxntal =  toHex($idx_offset,2);
                my $idx_offset_expr = $idx_offset==0? '' : $idx_offset_Uxntal.' SUB2';
                (my $idx,my $idx_word_sz) = _emit_expression_Uxntal($idxs,$stref,$f,$info);
                my $idx_expr = defined $idx ? ($idx eq $idx_offset_Uxntal) ? '' :
                "$idx $idx_offset_expr".( $short_mode ? ' #0002 MUL2 ': '') .' ADD2 ' : '';
                $uxntal_code =     "$var_access $idx_expr LDA$short_mode"; # index, load the value
            } elsif ($idx_expr_type == 2) {
                croak('Array slice is not yet supported: '.Dumper($ast));
                error('Array slice is not yet supported: '.Dumper($ast));
            } elsif ($idx_expr_type == 0) {
                # the array or string itself, likely as argument to a function
                $uxntal_code =  "$var_access";
            }
        } elsif  (is_string($stref,$f,$var)) {
            if ($idx_expr_type == 0) {
                # the array or string itself, likely as argument to a function
                $uxntal_code =  "$var_access";
            }
            elsif( $idx_expr_type == 2) {
                (my $idx_expr_b,my $idx_word_sz) = _emit_expression_Uxntal($idxs->[1], $stref, $f,$info);
                (my $idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($idxs->[2], $stref, $f,$info);
                if ($idx_expr_b eq $idx_expr_e) { # access a single character, so return a byte as value
                    # my $idx_offset = 1; # assuming strings always start at 1
                    # my $idx_offset_Uxntal =  toHex($idx_offset,2);
                    # my $idx_offset_expr = $idx_offset==0? '' : $idx_offset_Uxntal.' SUB2';
                    # my $idx_expr =  ($idx_expr_b eq  $idx_offset_Uxntal) ? '' : "$idx_expr_b  $idx_offset_expr ADD2 ";
                    # The value is at 0-idx+2
                    # So if the offset is 1, we have idx-1+2, so idx+1, that is the INC2
                    # so in full we have
                    $uxntal_code =  "$var_access INC2 $idx_expr_b ADD2 LDA" # load a pointer, index, load the value
                } else {
                    # extract a substring
                    # my $decl = get_var_record_from_set($Sf->{'Vars'},$var);
                    my $decl = getDecl($stref,$f,$var);
                    my $id=$info->{'LineID'};
                    if($decl->{'Attr'}!~/len/) {
                        croak 'String with index>1 but the type is character', Dumper $ast;
                    }
                    my $len = __get_len_from_Attr($decl);
                    $uxntal_code = __gen_substr($var_access, $idx_expr_b,$idx_expr_e, $len, $id);
                }
            }
        } elsif  ($ast->[0] == 2) { # a scalar
            $uxntal_code =  "$var_access LDA$short_mode";
        } else {
            croak('WRONG! <',Dumper($ast),'>');
            if (is_arg($stref,$f,$var)) {
            #         passed by value, so
                    $uxntal_code = "$var_access LDA$short_mode";
            } else {
            #         not passed, so
                    $uxntal_code = "$var_access LDA$short_mode";
            }
        }
    }
    return ($uxntal_code, $word_sz);
} # END of _var_access_read()

=pod
So we have:

READ means the RHS of an assignment, or anywhere in an expression, or a subroutine argument
ARG
    SCALAR
    ARRAY
    STRING
    ARRAY INDEX
    STRING SLICE
    ARRAY SLICE
LOCAL
    SCALAR
    ARRAY
    STRING
    ARRAY INDEX
    STRING SLICE
    ARRAY SLICE

ASSIGN
The RHS is via read, except for array and string slices AND for array and string assignments
ARG
    SCALAR:  f(v) where v is an (in)out and we have v=expr
    Which means v *must* be a pointer, so we have <expr> ;v LDA2 STA$word_sz
    ARRAY => copy
    STRING => copy
    ARRAY INDEX <expr> ;s LDA2 $idx_expr ADD2 STA$word_sz
    STRING INDEX <expr> ;s LDA2 $idx_expr ADD2 STA
    STRING SLICE => copy
    ARRAY SLICE => copy
LOCAL
    SCALAR:  v=expr
    Which means v is an addr, so we have <expr> ;v STA$word_sz
    ARRAY  => copy
    STRING => copy
    ARRAY INDEX <expr> ;s $idx_expr ADD2 STA$word_sz
    STRING INDEX <expr> ;s $idx_expr ADD2 STA
    STRING SLICE => copy
    ARRAY SLICE => copy
=cut
sub _var_access_assign($stref,$f,$info,$lhs_ast,$rhs_ast) {
# carp Dumper($lhs_ast,$rhs_ast);
    my ($var,$idxs,$idx_expr_type) = __unpack_var_access_ast($lhs_ast);
    my $Sf = $stref->{'Subroutines'}{$f};
    my $word_sz= $Sf->{'WordSizes'}{$var};
    my $short_mode = $word_sz == 2 ? '2' : '';
    my $uxntal_code = '';
    # my $use_stack = __use_stack($stref,$f);
    my $lhs_var_access = __var_access($stref,$f,$var);
    if  (is_array($stref,$f,$var)) {
        my $lhs_idx_offset = __get_array_index_offset($stref,$f,$var);
        my $lhs_idx_offset_Uxntal =  toHex($lhs_idx_offset,2);
        my $lhs_idx_offset_expr = $lhs_idx_offset==0? '' : $lhs_idx_offset_Uxntal.' SUB2';
        if  ($idx_expr_type == 1) { # array(i) = rhs_expr
            my ($rhs_expr_Uxntal, $rhs_word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
            if ($rhs_word_sz!=$word_sz){
                croak "LHS and RHS word sizes don't match: $word_sz <> $rhs_word_sz for assignment to $var in $f";
            }
            my ($idx,$idx_word_sz) = _emit_expression_Uxntal($idxs,$stref,$f,$info);
            my $idx_expr = defined $idx ? ($idx eq $lhs_idx_offset_Uxntal) ? '' : "$idx $lhs_idx_offset_expr".( $short_mode ? ' #0002 MUL2 ': '') .' ADD2 ' : '';
            $uxntal_code = "$rhs_expr_Uxntal  $lhs_var_access $idx_expr STA$short_mode"; # index, load the value
        } elsif  ($idx_expr_type == 0) { # array = rhs_expr
            my $decl = getDecl($stref,$f,$var);
            # It looks like ModuleVars are *copied* per function, not linked.
            # So I need to get the actual decl from the module
            my $dim = exists $decl->{'ConstDim'}
                ? __C_array_size($decl->{'ConstDim'})
                : __C_array_size($decl->{'Dim'});
            my $array_length = $dim;
            if ($rhs_ast->[0] == 28) { # Array literal
                my ($rhs_array_literal,$rhs_word_sz) = _emit_expression_Uxntal($rhs_ast, $stref,$f, $info);
                # unique ID the cheap way
                my $ref = \$rhs_ast; $ref=~s/REF..//;$ref=~s/\)//;
                $uxntal_code = "$rhs_array_literal ;&$ref STA2 " .
                "{ ( iter ) ".
                    ( $word_sz==2 ? '#0002 MUL2' : '')
                    .' DUP2 LIT2 &'.$ref.' $2 ADD2 LDA' .$short_mode.
                    ( $short_mode eq '2' ? ' SWP2' : ' ROT ROT' )
                    . " $lhs_var_access ADD2 STA$short_mode JMP2r } STH2r ".
                    toHex($array_length-1,2)
                    . ' #0000 range-map-short';
                add_to_used_lib_subs('range-map-short');
            } elsif ($rhs_ast->[0] == 34) { # the RHS is a string
                # We should check that the LHS is an array of strings
                # my $decl = get_var_record_from_set($Sf->{'Vars'},$var);
                my $decl = getDecl($stref,$f,$var);
                if (is_character($stref,$f,$var) ) { # Array of characters
                # If so, we set every elt to that string
                    my $dim = exists $decl->{'ConstDim'}
                        ? __C_array_size($decl->{'ConstDim'})
                        : __C_array_size($decl->{'Dim'});
                    # my $dim =  __C_array_size($decl->{'Dim'});
                    my $array_length = $dim;
                    my $isChar=1;
                    my $rhs_char_literal = __substitute_PlaceHolders_Uxntal($rhs_ast->[1],$info,$isChar);
                    # unique ID the cheap way
                    my $ref = \$rhs_ast; $ref=~s/REF..//;$ref=~s/\)//;
                    $uxntal_code =
                        "{ ( iter ) $rhs_char_literal ROT ROT ".
                        "$lhs_var_access ADD2 STA JMP2r } STH2r ".
                        toHex($array_length-1,2)
                        . ' #0000 range-map-short';
                    add_to_used_lib_subs('range-map-short');
                } elsif (is_string($stref,$f,$var) ) { # Array of strings
                    croak 'TODO: ASSIGNMENT TO ARRAY OF STRINGS';
                } else {
                    error("RHS is string, LHS is array");
                }
            } elsif ($rhs_ast->[0] >= 29) { # the RHS is a constant
                if ($rhs_ast->[0]==29) { # integer, check type and kind of LHS.
                    my $mkind = is_integer($stref,$f,$var);
                    if ($mkind==0 or $mkind==4) {
                        error('Only integer of kind 1 or 2 is supported on the RHS of an array assignment');
                    } else {
                        my $short_mode = $mkind==2 ? '2' : '';
                        my $rhs_int_literal = toHex($rhs_ast->[1],$mkind);
                        my $ref = \$rhs_ast; $ref=~s/REF..//;$ref=~s/\)//;
                        $uxntal_code =
                            "{ ( iter ) $rhs_int_literal ". ( $short_mode eq '2' ? ' SWP2' : ' ROT ROT' ).' '.
                            "$lhs_var_access ADD2 STA$short_mode JMP2r } STH2r ".
                            toHex($array_length-1,2)
                            . ' #0000 range-map-short';
                        add_to_used_lib_subs('range-map-short');
                    }
                }
                elsif ($rhs_ast->[0]==31) { # logical, check type and kind of LHS. Encode as 1 or 0 byte
                    croak 'TODO: ASSIGNMENT TO ARRAY OF LOGICALS';
                    # integer, check type and kind of LHS.
                    if ( is_logical($stref,$f,$var) ) {
                        my $rhs_bool_literal = $rhs_ast->[1] eq '.true' ? '#01' : '#00';
                        my $ref = \$rhs_ast; $ref=~s/REF..//;$ref=~s/\)//;
                        $uxntal_code =
                            "{ ( iter ) $rhs_bool_literal ".  'ROT ROT'  .
                            "$lhs_var_access ADD2 STA JMP2r } STH2r ".
                            toHex($array_length-1,2)
                            . ' #0000 range-map-short';
                        add_to_used_lib_subs('range-map-short');

                    } else {
                        error('Only integer of kind 1 or 2 is supported on the RHS of an array assignment');
                    }
                }
                elsif ($rhs_ast->[0]==32) { # character constant, I think this is unused
                    croak "CHARACTER assignment to ARRAY ".Dumper($rhs_ast);
                }
                else {
                    error('Only integer and logical are supported on the RHS of an array assignment');
                }

            } else {
                my ($rhs_var,$idxs,$idx_expr_type) = __unpack_var_access_ast($rhs_ast);
                if (is_array($stref,$f,$rhs_var)) {
                    # if the rhs is also an array we need an array copy
                    # This is a range-map
                    my $rhs_var_access = __var_access($stref,$f,$rhs_var);
                    $uxntal_code = "{ ( iter ) ".
                        ( $word_sz==2 ? '#0002 MUL2' : '')
                        ." DUP2 $rhs_var_access ADD2 LDA$short_mode " .
                        ( $short_mode eq '2' ? 'SWP2' : 'ROT ROT' ). ' '
                        . "$lhs_var_access ADD2 STA$short_mode JMP2r } STH2r ".
                        toHex($array_length-1,2)
                        . ' #0000 range-map-short';
                    add_to_used_lib_subs('range-map-short');
                } else {
                # if not, it is an error
                    error("LHS is an array but RHS isn't");
                }
            }
        } elsif  ( $idx_expr_type == 2) {
            error('Array slice is not yet supported: '.Dumper($lhs_ast));
        } else {
            croak "Unknown index expression type: $idx_expr_type";
        }
    } elsif  (is_string($stref,$f,$var) ) {
        $uxntal_code =  __copy_substr($stref, $f, $info, $lhs_ast, $rhs_ast)
    } else { # v = <anything not a string>
        my ($rhs_expr_Uxntal, $word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
        $uxntal_code = "$rhs_expr_Uxntal $lhs_var_access STA$short_mode ( scalar )";
    }
    return $uxntal_code;
} # END of _var_access_assign()

sub __is_write_arg($stref,$f,$var) {
    # my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var) ;
    my $decl = getDecl($stref,$f,$var);
    # carp("<$var>",Dumper $decl);
    my $iodir = exists $decl->{'IODir'} ? $decl->{'IODir'} : 'Unknown';
    my $uxntal_write_arg = $iodir eq 'out' or $iodir eq 'inout' ? 1 : 0 ;
    return $uxntal_write_arg;
}
sub __var_access($stref,$f,$var) {
    my $use_stack = __use_stack($stref,$f);
    # my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var) ;
    # carp("<$var>",Dumper $decl);
    # my $iodir = exists $decl->{'IODir'} ? $decl->{'IODir'} : 'Unknown';
    my $uxntal_write_arg = __is_write_arg($stref,$f,$var);
    # $iodir eq 'out' or $iodir eq 'inout' ? 1 : 0 ;
    # Module vars are globals, so don't allocate on the stack
    if (__is_module_var($stref,$f,$var) ) {
        $use_stack=0;
    }
    elsif (__is_result_var($stref,$f,$var) ) {
        $use_stack=0;
    }
    if (exists $stref->{'Subroutines'}{$f}{'DoIterators'}{$var}) {
        $use_stack=0;
    }
    return
        (
            $use_stack
            ? __stack_access($stref,$f,$var)
            : ';'. __create_fq_varname($stref,$f,$var)
        )
        .
        (
            (is_arg($stref,$f,$var) and (is_array_or_string($stref,$f,$var) or $uxntal_write_arg))
            ? ' LDA2' # passed by reference
            : '' # not passed
        );
}

sub __unpack_var_access_ast($ast) {
    if (ref($ast) eq 'ARRAY' and scalar @{$ast} >= 2) {
        # ['@',$var,[',',@idx_exprs]] : 10, 3 args, last arg is array has 27
        # ['@',$var,[':',$idx_expr_b,$idx_expr_e]] # This can be an array slice OR a string access : 10, 3 args, last arg is array has 12
        # ['@',$var,$idx_expr] : 10, 3 args, last arg is scalar
        # ['$',$var] : 2, 2 args,
        # [34,'__PH0__']
        my $idx_expr_type = 0; # 0 = no index | 1 = scalar | 2 = slice | 3 = multi-dim
        my $var = $ast->[1];
        my $idxs = [];
        if ($ast->[0] == 10) {
            if (scalar @{$ast} == 3) {
                $idxs=$ast->[2]; # is still an ast here, probably keep it that way
                $idx_expr_type = $idxs->[0] == 27 ? 3 : $idxs->[0] == 12 ? 2 : 1;
                if ($idx_expr_type == 3) {
                    error('Multi-dimensional arrays are not supported: '.Dumper($ast));
                }
            } else {
                error('Array access AST must have 3 items: '.Dumper($ast));
            }
        } elsif ($ast->[0] == 2) {
            if (scalar @{$ast} != 2) {
                error('Scalar AST must have 2 items: '.Dumper($ast));
            }
        } else {
            croak Dumper $ast;
            error('AST must be an @ or $: '.Dumper($ast));
        }
        return ($var,$idxs,$idx_expr_type);
    } else {
        croak Dumper($ast);
        error('AST must be a list: '.Dumper($ast));
    }
} # END of __unpack_var_access_ast

# We need to catch the cases where we have a RHS that is not a string. For example, it can be a character:
# s(i:i) = c
# s(i:i) = "c" => a character literal, this should be $lhs_idx_expr_type == 0 but that is not enough
# s(i:j) = "hello, " // w => This is assumed to return a temporary string and we start at the first char
# s = "c"
# # So must check the RHS and consider the following cases:
# - a var, which can be a string or a character scalar (anything else is an error)
# - a character literal (or a string literal of length 1)
# - a string literal
# - an expression
# In particular, if it is a function call, we need to get the return type
# string operator expressions can only be '//' but as the args can be expressions themselves, I need to see about the size of each arg. In practice I think it can't be done:
# a substr can have a runtime length, so there is no way to know the length of the concatenation operation
# But the operator is not magical, it essentially assumes static strings.

sub __copy_substr($stref, $f, $info, $lhs_ast, $rhs_ast) {
    # extract a substring and copy
    # The RHS string can be a literal
    my $uxntal_code = '';
    # unpack the asts
    my ($lhs_var,$lhs_idxs,$lhs_idx_expr_type) = __unpack_var_access_ast($lhs_ast);
    if ($rhs_ast->[0] == 34 or $rhs_ast->[0] == 1 or $rhs_ast->[0] == 13) { # string literal or function returning a string or char
        my $lhs_var_access = __var_access($stref,$f,$lhs_var);
        my $rhs_Uxntal_expr = '';
        if ($rhs_ast->[0] == 1 or $rhs_ast->[0] == 13) {
            ($rhs_Uxntal_expr, my $rhs_word_sz) = _emit_expression_Uxntal($rhs_ast, $stref, $f,$info)
        } elsif ($rhs_ast->[0] == 34) {
            $rhs_Uxntal_expr = __substitute_PlaceHolders_Uxntal($rhs_ast->[1],$info,0) # 0 means always as string
        } else {
            croak "PROBLEM: ".Dumper($rhs_ast);
        }
        if ($lhs_idx_expr_type == 2) { # slice
            # s_to(b1:e1) = "str"
            # This is a full string copy
            # so the RHS is just the string
            # the LHS is the slice; we use the LHS value
            # So we copy ce-cb+1 bytes from the RHS to the LHS, starting at position cb
            # <rhs-string> ;lhs_str <cb> ADD2 <ce-cb+1> strncpy
            my ($lhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[1], $stref, $f,$info);
            (my $lhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[2], $stref, $f,$info);
            if ($lhs_idx_expr_b eq $lhs_idx_expr_e ) {
                # simplyfied case of s_to(b1:b1) = "X", so the RHS is a single-character string
                # croak "WV20240723: WRONG, $lhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
                # my $lhs_idx_expr =  ($lhs_idx_expr_b eq '#0000') ? '' : "$lhs_idx_expr_b ADD2 ";
                # $uxntal_code = "$rhs_Uxntal_expr #0002 ADD2 LDA $lhs_var_access $lhs_idx_expr #0002 ADD2 STA"
                # WV20240723 I think this is wrong: the string will start at 1, so to get the first char we should have pos+1
                my $lhs_idx_expr =  ($lhs_idx_expr_b eq '#0001') ? '#0002' : "$lhs_idx_expr_b INC2 ";
                $uxntal_code = "$rhs_Uxntal_expr #0002 ADD2 LDA $lhs_var_access $lhs_idx_expr ADD2 STA ( WV20240723: WRONG? ) ";
            } else { # It is not possible to tell at compile time if these are compatible.
                # So to avoid overwriting, we use the LHS slice
                # croak "WV20240723: WRONG, $lhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
                # WV20240723 #0001 SUB2 to have base-0 which is what we need for strncpy
                $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access $lhs_idx_expr_b #0001 SUB2 ADD2 ( WV20240723: WRONG? ) ".
                __calc_len($lhs_idx_expr_e, $lhs_idx_expr_b).' strncpy';
                add_to_used_lib_subs('strncpy');
            }
        } else { # This is either a character assignment or a string copy
        # <string-literal> ;lhs_str <$len> strncpy
        # we need the length of LHS and RHS.
            # my $Sf = $stref->{'Subroutines'}{$f};
            # my $decl = get_var_record_from_set($Sf->{'Vars'},$lhs_var);
            my $decl = getDecl($stref,$f,$lhs_var);
            if($decl->{'Attr'}!~/len/) {
                # a single character; we assume len=1 means a string of length 1
                $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access STA";
            } else {
                # Problem is that this can be an expression
                # Something like str // "str" // fstr()
                # This becomes rather complicated so I will only deal with constant strings

                # carp $rhs_Uxntal_expr,Dumper ($info,$rhs_ast);
                my $lhs_len = __get_len_from_Attr($decl);
                if ($lhs_len eq ':' or $lhs_len eq '*') {
                    warning('Allocating 64 bytes for dynamic ('.$lhs_len.') string '.$lhs_var.' in '.$f);
                    $lhs_len = 64; # AD-HOC!
                }
                my $rhs_len = $rhs_ast->[0] == 34
                    ? length($info->{'PlaceHolders'}{$rhs_ast->[1]})-2 # -2 for the quotes
                    : $lhs_len; # a hack, TODO
                # This works only if there is only one function call
                if (exists $info->{'FunctionCalls'} and
                scalar @{$info->{'FunctionCalls'}}==1) {
                    my $fname = $info->{'FunctionCalls'}[0]{'Name'};
                    $rhs_len = $stref->{'Subroutines'}{$fname}{'RefactoredCode'}[0][1]{'Signature'}{'ReturnTypeAttr'};
                    $rhs_len =~s/\(len=//;$rhs_len =~s/\)//;
                    if ($rhs_len eq ':' or $rhs_len eq '*') {
                        $rhs_len=64; # AD-HOC
                    }
                }

                my $len = toHex(min($lhs_len,$rhs_len),2);
                $uxntal_code = $len eq '#0000' 
                ? "{ 0000 } STH2r $lhs_var_access #0000 strncpy"
                : "$rhs_Uxntal_expr $lhs_var_access $len strncpy";
                add_to_used_lib_subs('strncpy');
            }
            # croak "NOT a substr copy! ".Dumper($lhs_ast,$rhs_ast);
        }
    } else { # RHS is not a literal or expression
        my ($rhs_var,$rhs_idxs,$rhs_idx_expr_type) = __unpack_var_access_ast($rhs_ast);
        my $lhs_var_access = __var_access($stref,$f,$lhs_var);
        my $rhs_var_access = __var_access($stref,$f,$rhs_var);
        if ($lhs_idx_expr_type == 2 and $rhs_idx_expr_type == 2) {
            # both are slices
            # get the slice index expressions
            my ($lhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[1], $stref, $f,$info);
            (my $lhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[2], $stref, $f,$info);
            (my $rhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs->[1], $stref, $f,$info);
            (my $rhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs->[2], $stref, $f,$info);

            if ($lhs_idx_expr_b eq $lhs_idx_expr_e and $rhs_idx_expr_b eq $rhs_idx_expr_e) {
                # simplyfied case of s_to(b1:b1) = s_from(b2:b2)
                # further simplified if b1 or b2 is 0:
                # s_to(b1:b1) = s_from(1:1)
                # s_to(1:1) = s_from(b2:b2)
                # croak "WV20240723: WRONG, $rhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
                my $rhs_idx_expr =  ($rhs_idx_expr_b eq '#0001') ? '#0002' : "$rhs_idx_expr_b INC2 ";
                my $lhs_idx_expr =  ($lhs_idx_expr_b eq '#0000') ? '#0002' : "$lhs_idx_expr_b INC2 ";
                $uxntal_code = "$rhs_var_access $rhs_idx_expr ADD2 LDA $lhs_var_access $lhs_idx_expr ADD2 STA ( WV20240723: WRONG? ) ";
            } else { # It is not possible to tell at compile time if these are compatible.
                # So to avoid overwriting, we use the LHS slice
                # s_to(b1:e1) = s_from(b2:e2)
                # So this is a strncpy where we copy e1-b1+1 bytes from the RHS starting at b2 to LHS starting at b1
                # croak "WV20240723: WRONG, $rhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
                $uxntal_code = "$rhs_var_access $rhs_idx_expr_b #0001 SUB2 ADD2 $lhs_var_access $lhs_idx_expr_b #0001 SUB2 ADD2 ( WV20240723: WRONG? ) ".
                __calc_len($lhs_idx_expr_e,$lhs_idx_expr_b). ' strncpy';
                add_to_used_lib_subs('strncpy');
            }
        } elsif ($lhs_idx_expr_type == 2 and $rhs_idx_expr_type == 0) {
            # this is a special case of the above where we start the RHS string at 0; LHS is a slice
            # s1(i:j) = s2
            my ($lhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[1], $stref, $f,$info);
            (my $lhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[2], $stref, $f,$info);
            if ($rhs_ast->[0] == 2 and is_string($stref,$f,$rhs_var)) {
                # RHS is a scalar, so a string-type variable, and it is a string
                # s_to(b:e) = s_from where s_from is of length e-b
                # s_to = s_from(b:e) where s_to is of length e-b
                # croak "WV20240723: WRONG, $lhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
                $uxntal_code = "$rhs_var_access $lhs_var_access $lhs_idx_expr_b #0001 SUB2 ADD2 ( WV20240723: WRONG? ) ".
                __calc_len($lhs_idx_expr_e, $lhs_idx_expr_b).' strncpy';
                add_to_used_lib_subs('strncpy');
            }
            elsif (($rhs_ast->[0] == 2 and is_character($stref,$f,$rhs_var)) or $rhs_ast->[0] == 32) {
                # it's a character-type scalar or a character constant.
                # s_to(b:b) = 'c'
                # $lhs_ast = ['@',$s,[':',$i_expr]
                # croak "WV20240723: WRONG, $lhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
                my ($rhs_Uxntal_expr,$rhs_word_sz) = _emit_expression_Uxntal ($rhs_ast, $stref, $f, $info);
                my ($idx_expr,$idx_word_sz) = _emit_expression_Uxntal ($lhs_ast->[2][1], $stref, $f, $info);
                $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access $idx_expr INC2 ADD2 STA ( WV20240723: WRONG? ) ";
            }
            elsif ($rhs_ast->[0] == 1) { # a function call
                # get the return type of the function
                my $sig = $stref->{'Subroutines'}{$rhs_ast->[1]}{'Signature'};
                croak 'TODO: function on RHS of strcpy: '.Dumper($sig);
            }
        } elsif ($lhs_idx_expr_type == 0 and $rhs_idx_expr_type == 2) {
            # RHS is a slice, LHS is a string variable
            # s_to = s_from(bb:ee)
            my ($rhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs->[1], $stref, $f,$info);
            (my $rhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs->[2], $stref, $f,$info);
            # croak "WV20240723: WRONG, $rhs_idx_expr_b is BASE-1 so needs #0001 SUB2";
            # First, check for the special condition b==e
            if ($rhs_idx_expr_b eq $rhs_idx_expr_e ) {
                my $rhs_idx_expr =  ($rhs_idx_expr_b eq '#0001') ? '#0002' : "$rhs_idx_expr_b INC2 ";
                $uxntal_code = "$rhs_var_access $rhs_idx_expr ADD2 LDA $lhs_var_access #0002 ADD2 STA ( WV20240723: WRONG? ) ";
            } else {
                # I think here we must put in a safeguarding condition that e-b should be < length
                # Or we could just copy length bytes
                # So: if e-b+1 < length, use e-b+1 else use length
                $uxntal_code = "$rhs_var_access $rhs_idx_expr_b ADD2 $lhs_var_access ".
                __calc_len($rhs_idx_expr_e, $rhs_idx_expr_b)." $lhs_var_access LDA2 min strncpy";
                add_to_used_lib_subs('min');
                add_to_used_lib_subs('strncpy');
            }
        } elsif ($lhs_idx_expr_type == 0 and $rhs_idx_expr_type == 0) { # no indexing on either side
        # s_lhs = s_rhs
        # I am assuming the LHS is a string
        # The RHS could be a char or a string
            if ($rhs_ast->[0] == 2 and is_string($stref,$f,$rhs_var) ) {
                # if a string, copy as much of the RHS into the LHS as will fit
                $uxntal_code = "$rhs_var_access $lhs_var_access ".
                " $rhs_var_access LDA2 $lhs_var_access LDA2 min strncpy ";
                # This changes the length of the LHS string. I don't think that is OK
                # LEN returns the allocated length
                # TRIM_LEN returns the length skipping trailing spaces (and I assume 0s)
                # " $rhs_var_access LDA2 $lhs_var_access LDA2 min $lhs_var_access STA2 ";
                add_to_used_lib_subs('min');
                add_to_used_lib_subs('strncpy');
        # if a char, it's easy:
        # #0001 $rhs_var_access STA2
        # $lhs_var_access LDA2 $rhs_var_access #0002 ADD2 STA2
            }
            elsif (($rhs_ast->[0] == 2 and is_character($stref,$f,$rhs_var)) or $rhs_ast->[0] == 32) {
                # it's a character-type scalar or a character constant.
                # we set the rhs to a string of length 1 with this char
                # s_to(b:b) = 'c'
                # $lhs_ast = ['@',$s,[':',$i_expr]
                my ($rhs_Uxntal_expr,$rhs_word_sz) = _emit_expression_Uxntal ($rhs_ast, $stref, $f, $info);
                $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access #0002 ADD2 STA #0001 $rhs_var_access STA2";
            }
        } elsif ($lhs_idx_expr_type == 2 and $rhs_idx_expr_type == 1) {
            # Special case: RHS is array assignment.
            # This can be either an array of chars or an array of strings
            # So we need to get the array type, and the indices of the LHS slice
            my ($lhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[1], $stref, $f,$info);
            (my $lhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($lhs_idxs->[2], $stref, $f,$info);
            (my $rhs_idx_expr,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs, $stref, $f,$info);
            # I will be lazy and simply trust the LHS indices
            if ($lhs_idx_expr_b eq $lhs_idx_expr_e) {
                my $lhs_idx_expr =  ($lhs_idx_expr_b eq '#0001') ? "#0002" : "$lhs_idx_expr_b INC2";
                $uxntal_code = "$rhs_var_access $rhs_idx_expr #0001 SUB2 ADD2 LDA $lhs_var_access $lhs_idx_expr ADD2 STA (  WV20240723: WRONG? ) ";
                # croak "WV20240723: WRONG, $lhs_idx_expr_b is BASE-1 so needs #0001 SUB2\n".$uxntal_code;
            } else {
                croak 'TODO: array of strings';
            }

        } else {
            say $lhs_idx_expr_type,$rhs_idx_expr_type ;
            error("Unsupported index expression in __copy_substr($f) : $lhs_idx_expr_type , $rhs_idx_expr_type ".Dumper($lhs_ast,$rhs_ast),$DBG,'ERROR');
        }
    }
    return $uxntal_code.' ( COPY SUBSTR )';

} # END of __copy_substr

sub __calc_len($e,$b){
    if ($e=~/^\#/ and $b=~/^\#/) {
        $e=~s/\#// ;$b=~s/\#//;
        my $len = hex($e) - hex($b) + 1;
        return toHex($len,2);
    } else {
        return "$e $b SUB2 INC2";
    }
}

# This returns the address of the var on the stack
sub __stack_access($stref,$f,$var) {
    my $Sf = $stref->{'Subroutines'}{$f};
    my $offset = $Sf->{'StackOffset'}{$var};
    croak "INVALID __stack_access($f,$var)" unless defined $offset;
    if ($offset>0) {
        my $offset_hex = toHex($offset,2);
        # my $uxntal_code = '';
        return ".fp LDZ2 $offset_hex ADD2";
    } else {
        return ".fp LDZ2";
    }
} # END of __stack_access()

# We call this for every variable declaration
# But I think storing the arguments should be a separate call.
# Instead of ;arg STA$short_mode we need .fp LDZ2 $Sf->{'StackOffset'}{$var} ADD2 STA$short_mode
# i.e. __stack_access($stref,$f,$var). "STA$short_mode"
sub _stack_allocation($stref,$f,$var) {
    my $Sf = $stref->{'Subroutines'}{$f};
    my $word_sz = $Sf->{'WordSizes'}{$var} ;
    my $uxntal_code = '';
    my $offset = $Sf->{'CurrentOffset'};
    my $nbytes=2;
    my $array_string_init='';
    if  (is_array_or_string($stref,$f,$var)) {
         if (is_arg($stref,$f,$var)) {
        #         passed by reference, so
            $Sf->{'CurrentOffset'} += 2;
            $uxntal_code = "( allocated 2 bytes at $offset for $var )";
        } else {
        #         not passed, so
            my $subset = in_nested_set( $Sf, 'DeclaredOrigLocalVars', $var );
            my $decl = get_var_record_from_set($Sf->{$subset},$var);
            if (is_array($stref,$f,$var)) {
                croak Dumper $decl if $var eq 'res';
                # my $decl = getDecl($stref,$f,$var);
                # my $dim =  __C_array_size($decl->{'Dim'});
                my $dim = exists $decl->{'ConstDim'}
                    ? __C_array_size($decl->{'ConstDim'})
                    : __C_array_size($decl->{'Dim'}) ;
                $nbytes= $dim*$word_sz+2; # 2 bytes for size field
                my $init_array = toHex($dim,2).' .fp LDZ2 '.toHex($offset,2). ' ADD2 STA2';
                $array_string_init=$init_array;
            }
            elsif (is_string($stref,$f,$var)) {
                my $len = __get_len_from_Attr($decl);
                $nbytes = $len+2; # 2 bytes for the len field
                my $init_string = toHex($len,2).' .fp LDZ2 '.toHex($offset,2). ' ADD2 STA2';
                $array_string_init=$init_string;
            }
            $Sf->{'CurrentOffset'} += $nbytes;
            # my $nbytes_Uxn=toHex($nbytes,2);
            $uxntal_code = "( allocated $nbytes bytes at $offset for $var )";
        }
    } else { # Scalars
        $nbytes = __is_write_arg($stref,$f,$var) ? 2 : $word_sz;
        $Sf->{'CurrentOffset'} += $nbytes;
        $uxntal_code = "( allocated $nbytes bytes at $offset for $var )";
    }
    $Sf->{'StackOffset'}{$var}= $offset;
    return [$uxntal_code,$nbytes,$array_string_init];
} # END of _stack_allocation()

sub __create_fq_varname($stref,$f,$var_name) {
    # carp Dumper $var_name;
    my $fq_varname = $f.'_'.$var_name;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $decl = get_var_record_from_set($Sf->{'ModuleVars'},$var_name);
    if (not defined $decl) {
        $decl = get_var_record_from_set($Sf->{'ModuleParameters'},$var_name);
    }
    if (defined $decl) {
        my $mod_name ='';
        if (exists $decl->{'ModuleName'}) {
            $mod_name = $decl->{'ModuleName'};
        }
        if ($mod_name ne '') {
            $fq_varname = $mod_name.'_'.$var_name;
            if (not exists $stref->{'Uxntal'}{'Globals'}{'Set'}{$fq_varname}) {
                $stref->{'Uxntal'}{'Globals'}{'Set'}{$fq_varname} = 1;
                my $info={}; # I don't need info for this, it is only used to get the LineID for unique substrings
                ($stref, my $global_var_decl)= _emit_var_decl_Uxntal($stref,$mod_name,$info,$var_name);
                push @{$stref->{'Uxntal'}{'Globals'}{'List'}},$global_var_decl ;
            }
        }
    }
    return $fq_varname;
} # END of __create_fq_varname

sub __is_module_var($stref,$f,$var_name) {
    # carp Dumper $var_name;
    my $Sf = $stref->{'Subroutines'}{$f};
    return in_nested_set($Sf,'ModuleVars',$var_name) ? 1 : 0;
} # END of __is_module_var

sub __is_result_var($stref,$f,$var_name) {
    return ( exists $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}
    and $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} eq $var_name
    ) ? 1 : 0;
}


sub _pointer_analysis($stref,$f) {

    my $Sf = $stref->{'Subroutines'}{$f};

    my $annlines = get_annotated_sourcelines( $stref, $f );

    # This analysis only looks at args, local vars and local parameters. We need to include globals
    # Or maybe not, as pointer analysis is not necessary for Uxntal.
    # We populate $state->{'Pointers'} and $state->{'WordSizes'} but the latter is not used as
    # $Sf->{'WordSizes'} is populated above;
    my $pass_pointer_analysis = sub ($annline,$state){
        my ($line, $info) = @{$annline};

        if (exists $info->{'Signature'} ) {
            $state->{'Args'} = { map { $_=>1 } @{$info->{'Signature'}{'Args'}{'List'}}};
        }
        elsif (exists $info->{'VarDecl'} ) {
            my $var = $info->{'VarDecl'}{'Name'};
            if (exists $state->{'Args'}{$var} ) {
                $state->{'Pointers'}{$var}='*'; # means should be treated as a pointer
            } else {
                $state->{'Pointers'}{$var}=''; # means should be treated as a scalar, i.e. LDA
                $state->{'LocalVars'}{$var}=1;
            }
            my $word_sz=0;
            my $type = $info->{'ParsedVarDecl'}{'TypeTup'}{'Type'};
            if ($type eq 'integer') {
                my $kind = $info->{'ParsedVarDecl'}{'TypeTup'}{'Kind'};
                if ($kind>2) {
                    die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
                }
                $word_sz=$kind;
            }
            elsif ($type eq 'logical') {
                $word_sz=1;
            }
            elsif ($type eq 'character') {
                $word_sz=1;
            } elsif ($type =~/^character\(/) {
                $word_sz=2;
            } else {
                die "Supported types are integer, character, string and logical: $var in $f is $type\n";
            }
            $state->{'WordSizes'}{$var}=$word_sz;
        }
        elsif ( exists $info->{'ParamDecl'} ) {
            my $var = $info->{'ParamDecl'}{'Var'};
            $state->{'Pointers'}{$var}='';
            $state->{'Parameters'}{$var}=1;
            my $word_sz=0;
            my $type = $info->{'ParsedParDecl'}{'TypeTup'}{'Type'};
            if ($type eq 'integer') {
                my $kind = $info->{'ParsedParDecl'}{'TypeTup'}{'Kind'};
                if ($kind>2) {
                    die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
                }
                $word_sz=$kind;
            } elsif ($type eq 'logical') {
                $word_sz=1;
            } elsif ($type eq 'character') {
                $word_sz=1;
            } elsif ($type =~/^character\(/) {
                $word_sz=2;
            } else {
                die "Supported types are integer, character, string and logical: $var in $f is $type\n";
            }
            $state->{'WordSizes'}{$var}=$word_sz;
        }
        # FIXME: this is because of the presence of an empty $info->{'SubroutineCall'} record.
        elsif (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) {
            my $fname =  $info->{'SubroutineCall'}{'Name'};
            if (not exists $F95_intrinsic_functions{$fname} ) {
                for my $call_arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
                    my $call_arg = ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Scalar'
                    or $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const'
                    or $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr'
                    ) ? $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Expr'}
                    : $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Arg'};

                    if (exists $state->{'LocalVars'}{$call_arg}) {
                        $state->{'Pointers'}{$call_arg}='*';
                    }
                    elsif (exists $state->{'Parameters'}{$call_arg}) {
                        $state->{'Pointers'}{$call_arg}='&';
                        # carp 'TODO: a const scalar passed as arg: ',$call_arg_expr_str ;
                    }
                }
            }
        }
        elsif ( exists $info->{'FunctionCalls'} ) {
            for my $entry (@{$info->{'FunctionCalls'}}) {
                my $fname =  $entry->{'Name'};
                if (not exists $F95_intrinsic_functions{$fname} ) {
                    # We assume intrinsics take values not pointers
                    for my $arg (sort keys %{$entry->{'Args'}}) {
                        if (exists $state->{'LocalVars'}{$arg}) {
                            $state->{'Pointers'}{$arg}='*';
                        }
                    }
                }
            }
        }

        return ([[$line,$info]],$state)
    };

    my $pass_state = {'Pointers'=>{},'Args' =>{},'LocalVars' =>{}, 'Parameters'=>{}, 'WordSizes'=>{}};
    (my $new_annlines_,$pass_state) = stateful_pass($annlines,$pass_pointer_analysis,$pass_state,"pass_pointer_analysis($f)");
    $Sf->{'Pointers'} = $pass_state->{'Pointers'};
    return $stref;

} # END of _pointer_analysis

sub _emit_Uxntal_code($stref, $module_name){
     map {say $_ } @{$stref->{'TranslatedCode'}} if $V;
    # WV 2021-06-08 I use .cc so that this is ostensibly C++ code.
    # This is because in pure C, the switch/case does not work with const int (!)
    # I don't want to replace the const int by #define in an ad-hoc way so C++ it is.
     my $ext = 'tal';
     my $module_src = $stref->{'Modules'}{$module_name}{'Source'};
    if (not defined $module_src) {
        $module_src=$Config{'MODULE_SRC'};
    }

     my $fsrc = $module_src;
    if ($module_src eq '') { # No module? Try to treat it as a program
        if ($module_name eq  $stref->{'Top'}) {
            $fsrc= $stref->{'Program'};
            $fsrc=~s/^.+\///;
        }
    }
    # croak "$targetdir/$fsrc";
     my $csrc = $fsrc;$csrc=~s/\.\w+$//;
     $csrc=~s/.+\///;
    if (not -d $targetdir) {
        mkdir $targetdir;
    }

     open my $OUT, '>', "$targetdir/$csrc.$ext";
     map {say $OUT $_ } @{$stref->{'TranslatedCode'}};
     close $OUT;
    return $stref;
} # END of _emit_Uxntal_code

sub _emit_subroutine_sig_Uxntal($stref, $f, $annline){
        (my $line, my $info) = @{ $annline };
        my $Sf = $stref->{'Subroutines'}{$f};

        my $name = $info->{'Signature'}{'Name'};
        my $args_ref = $info->{'Signature'}{'Args'}{'List'};
# The ResultVar should be declared like a local, and be returned by value unless it is an array or string;
# If it is an array or string it should be allocated statically
# @intToStr_cs $2 should be @intToStr_cs 0006 $6 instead
# ;intToStr_cs STA2 at the start should not be there
# ;intToStr_cs LDA2 should be ;intToStr_cs unless it is a scalar
        my $result_var = '';
        if (exists $info->{'Signature'}{'ResultVar'}) {
            $result_var = $info->{'Signature'}{'ResultVar'};
            push @{$args_ref},$info->{'Signature'}{'ResultVar'};
        }
        my $uxntal_arg_decls=[];
        my $uxntal_args_to_store=[];
        my $uxntal_write_args={};
        for my $arg (@{ $args_ref }) {
            ($stref,my $uxntal_arg_decl, my $uxntal_arg_store, my $uxntal_write_arg) = _emit_arg_decl_Uxntal($stref,$f,$arg,$name);
            if ($uxntal_write_arg) {
                $uxntal_write_args->{$arg}=[$arg,$name];
            }
            if ( $arg ne $result_var) {
                unshift @{$uxntal_arg_decls},$uxntal_arg_decl;
                unshift @{$uxntal_args_to_store},$uxntal_arg_store;
            } else {
                if (is_array_or_string($stref,$f,$result_var)) {
                    my $uxntal_res_decl = _emit_var_decl_Uxntal ($stref,$f,$info,$result_var);
                    unshift @{$uxntal_arg_decls},$uxntal_res_decl;
                } else {
                    unshift @{$uxntal_arg_decls},$uxntal_arg_decl;
                }
                # croak 'TODO: arg decl for result var, can be a string'
            }
        }

        # my $args_str = join( ' ', @{$uxntal_arg_decls} );
        my $rline = '@'.$name;
        my $isMain = 0;
        if (exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'}==1
        ) {
            $isMain = 1;
            # $rline = '|0100';
        }
        return  ($rline,$uxntal_arg_decls, $uxntal_args_to_store, $uxntal_write_args,$isMain);
} # END of _emit_subroutine_sig_Uxntal

sub _emit_arg_decl_Uxntal($stref,$f,$arg, $name){
    # my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg) ;
    my $decl = getDecl($stref,$f,$arg);
    my $iodir = lc($decl->{'IODir'});
    my $ftype = $decl->{'Type'};
    my $fkind = $decl->{'Attr'};
    my $isArrayOrString =  is_array_or_string($stref,$f,$arg);
    $fkind=~s/\(kind=//;
    $fkind=~s/\)//;
    if ($fkind eq '') {$fkind=2};
    # my $uxntal_size = toUxntalType($ftype,$fkind);
    my $word_sz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$arg};
    my $short_mode = __nBytes($word_sz, $isArrayOrString)==1?'':'2';
    # croak "$f $arg: $word_sz != $uxntal_size" if $word_sz != $uxntal_size;
    my $uxntal_write_arg = $iodir eq 'out' or $iodir eq 'inout' ? 1 : 0 ;
    my $fq_name = $name.'_'.$arg;
    my $use_stack = __use_stack($stref,$f);
    # But if $arg is a ResultVar, it should not go on the stack
    if (($use_stack==1) and exists $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}
    and $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} eq $arg
    ) {
        $use_stack=0;
        }
    # If the arg is an Out arg, we need to put its address on the stack
    # TODO: I need to check the handling of a RESULT string from a function.
    # If we don't use the stack we can allocate this as a local and return the address
    # But if we do use the stack the allocation should be done by the caller.
    # So to do this right, the allocation should always be done by the caller.
    # What if we have something like f(str(...)) and str returns a string?
    # The only good way seems to do something like tmp_str = str(...); f(tmp_str)
    # What this means is that a call to a function that is used as an arg should have a strcpy
    my $uxntal_arg_store = ($use_stack
        ? __stack_access($stref,$f,$arg)
        : ";$fq_name"
        ) . " STA$short_mode";
    my $uxntal_arg_decl = $use_stack
        ? ''
        : '@'.$fq_name.' $'.__nBytes($word_sz, $isArrayOrString);
    return ($stref,$uxntal_arg_decl,$uxntal_arg_store, $uxntal_write_arg,$use_stack);
} # END of _emit_arg_decl_Uxntal()

sub __nBytes ($wordSz, $isArrayOrString){
    # If the arg is an array, 2 bytes
    # If the arg is a scalar, wordSz
    # If the arg is a string, 2 bytes
    if ($isArrayOrString) {
        return 2;
    } else {
        return $wordSz;
    }
} # END of __nBytes

sub _emit_var_decl_Uxntal ($stref,$f,$info,$var){
    my $sub_or_module = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_module}{$f};
    # carp "_emit_var_decl_Uxntal: VAR $var in $f " if $var eq 'res' and $f eq 'decodeTokenStrI';
    # my $decl =  get_var_record_from_set($stref->{$sub_or_module}{$f}{'Vars'},$var);
    my $decl = getDecl($stref,$f,$var);

    my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;

    my $const = '';
    my $val='';

    if (defined $decl->{'Parameter'}) {
        $val = $decl->{'Val'};
		# carp "VAL: $val";
        my $val_str = $val;
        if ($val=~/[\'\"'](.+?)[\'\"]/) {
            $val_str = '"'.$1;
        }
        elsif ($val=~/^\d+(?:_[1248])?$/) {
			# carp 'HERE';
            my $sz=2;
            if ($val=~s/_([1248])$//) { $sz=$1}
            $val_str = toHex($val,$sz);
        }
        elsif (exists $decl->{'AST'}) {
            my $ast = $decl->{'AST'};
            ($val_str,my $word_sz) = _emit_expression_Uxntal($ast,$stref, $f, $info);
        } else {
            croak "ParsedParDecl without AST, FIXME!";
        }
        # Define parameter as macro
        # my $par_decl_str = '%'.$f.'_'.$var.' { '. $val_str .' }';
        # Better: define parameter as function
        my $par_decl_str = '@'.$f.'_'.$var.' '. $val_str .' JMP2r';
        return ($stref,$par_decl_str);
        # $const = 'const ';
        # $val = ' = '.$decl->{'Val'};
        # # In the case of a constant array: replace '(/' with '{' and add '[]' to front
        # # WV 2021-10-19 This is OK but a bit hacky, because Fortran also supports the '[ ... ]' syntax
        # # It would be better to use ParsedVarDecl
        # if ($val=~s/\(\//{/) {
        #     $val=~s/\/\)/}/;
        #     $val = '[]' . $val;
        # }
    } else {
        # FIXME: Dim can still contain named constants
        # croak "$f ". Dumper( $decl). Dumper($stref->{$sub_or_module}{$f}{'Vars'}) if $decl->{'Name'}=~/funktalTokens/i;
        #.Dumper($stref->{$sub_or_module}{$f}{'Vars'})
        my $subset = in_nested_set( $Sf, 'Vars', $var );
        # croak "$subset $f ". Dumper( $decl) if $decl->{'Type'} eq 'real';
        # croak "$subset $f ". Dumper( $decl) if $var eq 'funktalTokens';
        my $dim = $array
            ? exists $decl->{'ConstDim'}
                ? __C_array_size($decl->{'ConstDim'})
                : __C_array_size($decl->{'Dim'})
            : 1;
        my $ftype = $decl->{'Type'};
        my $strlen=0;
        if ($ftype eq 'character') {
            if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
                $strlen = $decl->{'Attr'};
                $strlen=~s/len=//;
                $strlen=~s/^\(//;
                $strlen=~s/\)$//;
                if ($strlen eq '*' or $strlen eq ':') {
                    warning('Allocating 64 bytes for dynamic ('.$strlen.') string '.$var.' in '.$f);
                    $strlen = 64; # AD-HOC, 64 characters ought to be enough for anyone
                }
                $dim *= $strlen;
            }
        }
        my $fkind = $decl->{'Attr'};
        if (ref($ftype) eq 'HASH') {
            if (exists $ftype->{'Kind'}) {
                $fkind = $ftype->{'Kind'};
            }
            $ftype = $ftype->{'Type'};
        }
        $fkind=~s/\(kind=//;
        $fkind=~s/\)//;
        if ($fkind eq '') {$fkind=4};

        my $sz = $Sf->{'WordSizes'}{$var}; # This breaks because we did not populate this for modules!
        if (not defined $sz) {
            croak "$f $var ".Dumper($decl);
        }

        if (($ftype eq 'character') and ($strlen >1)) {
            my $len = toRawHex($strlen,2);
            my $padding = $len;
            $padding =~s/^0+//;
            my $c_var_decl = '@'.$f.'_'.$var.' '.$len.' $'. $padding;
            return ($stref,$c_var_decl);
        } else {
            my $padding = toRawHex($sz*$dim,2);
            $padding =~s/^0+//;
            my $c_var_decl = '@'.$f.'_'.$var.' $'. $padding;
            return ($stref,$c_var_decl);
        }
    }
} # END of _emit_var_decl_Uxntal


# TODO use _var_access_assign !
sub _emit_assignment_Uxntal ($stref, $f, $info, $pass_state){
    my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};
    my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
    my $rline = _var_access_assign($stref,$f,$info,$lhs_ast,$rhs_ast);
    return ($rline,$pass_state);
} # END of _emit_assignment_Uxntal



sub _emit_ifthen_Uxntal ($stref, $f, $info, $branch_id){
    my $cond_expr_ast=$info->{'Cond'}{'AST'};
    my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
    # $cond_expr=_change_operators_to_Uxntal($cond_expr);
    # FIXME! fix for stray '+'
    # $cond_expr=~s/\+\>/>/g;
    # my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');
    my $rline = "$cond_expr ;&branch$branch_id JCN2\n" .
                 ";&branch${branch_id}_end JMP2\n" .
             "&branch${branch_id}";
    return $rline;
}

sub _emit_ifbranch_end_Uxntal ($id, $state){
    # my $branch_id = $state->{'IfBranchId'};
    my $branch_id = pop @{$state->{'BranchStack'}};
    my $if_id = $state->{'IfId'};
    my $r_line = ";&cond_end${if_id} JMP2 \n";
    $r_line .= "&branch${branch_id}_end\n";
    $state->{'IfBranchId'} = $id;
    $branch_id = $state->{'IfBranchId'};
    return ($r_line,$branch_id);
}
# I wonder if for call args it might be better to have a separate function which checks if the arg is scalar, array, array access, const
# The AST is a tree made of a nesting of lists. Each list starts with an integer identifying its type:
#                 0    1    2    3    4    5    6    7    8    9    10   11   12   13    14
# our @sigils = ('(', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//', ')('
#                 15    16    17  18   19    20     21       22       23      24       25       26
#                ,'==', '/=', '<', '>', '<=', '>=', '.not.', '.and.', '.or.', '.xor.', '.eqv.', '.neqv.'
#                 27   28
#                ,',', '(/',
# Constants
#                 29        30      31         32           34             35       36
#                ,'integer', 'real', 'logical', 'character', 'PlaceHolder', 'Label', 'BLANK'
#   );
# $: scalar
# &: subroutine
# @: array

=pod
The cases to consider are:
- operators, recurse _emit_expression_Uxntal
- literal constants (bool, number, character), emit in place
- string constants, emit in place
- variables, will always be _var_access_read()
- function calls, is _emit_subroutine_call_expr_Uxntal
=cut
# Return the Uxntal expression string and its word size.
sub _emit_expression_Uxntal ($ast, $stref, $f, $info) {
    my $Sf = $stref->{'Subroutines'}{$f};

    if (ref($ast) eq 'ARRAY') {
        my $opcode = $ast->[0];
        if ( $opcode == 10 or $opcode == 2) { # variables, will always be _var_access_read()
            return _var_access_read($stref,$f,$info,$ast);
        }
        elsif ($opcode == 1) { # function calls, is _emit_subroutine_call_expr_Uxntal
            (my $opcode, my $name, my $args) =@{$ast};
            # Special cases
            if ($name eq 'int' or $name eq 'achar' or $name eq 'char') { # just remove it
                # [1,'int',[',', $arg, $sz]]
                # For 'char' this means we ignore the 'kind' and assume ASCII
                my $uxn_ast = $args->[0] == 27  ? $args->[1] : $args;
                return _emit_expression_Uxntal($uxn_ast, $stref, $f,$info);
            }
            elsif ($name eq 'print') {
                # [1,'print','*', $arg]
                my $uxn_ast = [1,'print',$args->[2]];
                return _emit_expression_Uxntal($uxn_ast, $stref, $f,$info);
            }
            elsif ($name eq 'ishft') {
                # We need to translate the negative into a shift over 4
                # This is not even always possible, in principle this has to be a runtime operation
                # But for constant shifts it can be done
                my ($val_to_shift, $word_sz) = _emit_expression_Uxntal($args->[1], $stref, $f,$info);
                my $short_mode = $word_sz==2 ? '2':'';
                if ($args->[2][0]==29 or ($args->[2][0]==4 and $args->[2][1][0]==29)) {
                    my $shift_dir = $args->[2][0] == 4 ? 'right' : 'left';

                    my $shift_nbits = $shift_dir eq 'left' ? $args->[2][1] : $args->[2][1][1];
                    my $sft = toHex($shift_nbits,1);
                    if ($shift_dir eq 'left') { 
                        #<shift_nbits>0 is left shift
                        return ("$val_to_shift $sft #40 SFT SFT$short_mode",$word_sz);
                    } else {
                        #0<shift_nbits> is right shift
                        return ("$val_to_shift $sft SFT$short_mode",$word_sz);
                    }
                } else { # If the shift argument is not a constant, we need to determine at run time if it is positive or negative
                    # We know this *must* be a byte, so we remove the MSB
                    my $shift_n_bits = _emit_expression_Uxntal($args->[2], $stref, $f,$info) . ' NIP';
                    croak "ishft works only with shorts" if $word_sz==1;
                    return ("$val_to_shift $shift_n_bits ishft",2);
                    # croak 'TODO ISHFT RUNTIME: '.Dumper($args);
                }
            } else {
                return _emit_function_call_expr_Uxntal($stref,$f,$info,$ast);
            }
        }
        elsif ($opcode == 28) { # (/
            # this is very lazy, but it works
            my $lst_expr = _emit_expression_Uxntal($ast->[1], $stref, $f,$info);
            $lst_expr =~s/\#//g;
            return ("{ $lst_expr } STH2r",2);
        }
        elsif ($opcode > 28 and $opcode < 36) { # literal constants (bool, number, character, string), emit in place
            (my $opcode, my $exp) =@{$ast};
            if ($opcode == 34) {
                # We'll assume here that a single-char string is a char
                my $isChar=1;
                return (__substitute_PlaceHolders_Uxntal($exp,$info,$isChar),1);
            }
            elsif ($opcode == 35) {
                die 'ERROR: Fortran LABEL as arg is not supported, sorry!'."\n";
            }
            # Handle integers, also with size notations, e.g. 11_1, 22_2
            # Transform into hex
            elsif ($exp=~/^\d+(?:_[1248])?$/) {
                my $sz=2;
                if ($exp=~s/_([1248])$//) { $sz=$1}
                return (toHex($exp,$sz),$sz);
            }
            elsif ($exp eq '.true.') {
                return ('#01',1);
            }
            elsif ($exp eq '.false.') {
                return ('#00',1);
            }
            else {
                my ($uxntal_str,$word_sz) = _var_access_read($stref,$f,$info, $ast);
                return ("$uxntal_str ( FALL-THROUGH ) ",$word_sz);
            }
        }
        elsif ($opcode >= 36) { # special case
            return ($ast->[1]);
        }
        elsif (__is_operator($opcode) ) { # operators
        # carp Dumper $ast,$opcode;
            # Special cases
            # Uxn does not have pow or mod so these would have to be functions
            # TODO these are not implemented yet
            if ($opcode ==19 or $opcode == 20) {
                add_to_used_lib_subs($sigils[$opcode].'2'); # FIXME: use word size!
            }
            if (($opcode == 21 or $opcode == 4 or $opcode == 3) and scalar @{$ast} == 2) {#  '.not.', '-' or '+'
                (my $opcode, my $exp) =@{$ast};
                my ($v, $word_sz) = _emit_expression_Uxntal($exp, $stref, $f,$info);
                my $short_mode= $word_sz==2?'2':'';
                if ($opcode == 21 ) {
                    croak 'BOOL must have word size of 1!' if $word_sz==2;
                    add_to_used_lib_subs($sigils[$opcode].$short_mode);
                    return ( "$v not", $word_sz) ;
                }
                elsif($opcode == 4) {
                    # In principle we need to know the word size!
                    # But I will simply assume that all arithmetic is using shorts
                    return ("#0000 $v SUB$short_mode",$word_sz);
                } else {
                    return ($v, $word_sz);
                }
            }
            (my $opcode, my $lexp, my $rexp) =@{$ast};
            if ($opcode == 8) { # eq '^'
                $ast = [1,'pow',[27,$lexp,$rexp] ] ;
                return _emit_function_call_expr_Uxntal($stref,$f,$info,$ast);
            }
            elsif ($opcode == 7) { # eq '%', mod
                $ast = [1,'mod',[27,$lexp,$rexp] ] ;
                return _emit_function_call_expr_Uxntal($stref,$f,$info,$ast);
            }
            my ($lexp_str,$l_word_sz) = _emit_expression_Uxntal($lexp, $stref, $f,$info);
            my ($rexp_str,$r_word_sz) = _emit_expression_Uxntal($rexp, $stref, $f,$info);
            my $lv = (ref($lexp) eq 'ARRAY') ?  $lexp_str : $lexp;
            my $rv = (ref($rexp) eq 'ARRAY') ? $rexp_str : $rexp;

            if ($lv=~/^\"/) {
                my $len = toRawHex( length($lv)-1,2);
                $lv = "{ $len $lv } STH2r";
            }
            if ($rv=~/^\"/) {
                my $len = toRawHex( length($rv)-1,2);
                $rv = "{ $len $rv } STH2r";
            }
            if (isStrCmp($ast, $stref, $f,$info)) {
                add_to_used_lib_subs('strcmp');
                return ("$lv $rv strcmp",1);
            } elsif ($opcode == 13) {
                # Only works for a total length of 256 characters
                add_to_used_lib_subs('concat');
                return ("$lv $rv".' { 0100 $100 } STH2r concat',2);
            } else {
                if ($l_word_sz!=$r_word_sz) {
                    croak "Word sizes for ".$sigils[$opcode]." must be the same: $l_word_sz <> $r_word_sz ( $lv $rv )";
                } 
                my $short_mode = $l_word_sz == 2 ? '2' : '';
                # Ideally, the _emit_expression_Uxntal should return the word size of the expression
                return ("$lv $rv  ". $sigils[$opcode].$short_mode, $l_word_sz ); # FIXME, needs refining
            }
        }
        elsif (scalar @{$ast} > 3 and $opcode == 27) { # the ast is a comma-separated list ','
                carp "WHY DOES THIS HAPPEN? ";
                my @args_lst_Uxntal=();
                for my $idx (1 .. scalar @{$ast}-1) {
                    my $arg = $ast->[$idx];
                    my ($uxntal_arg_expr,$word_sz) = _emit_expression_Uxntal($arg, $stref, $f,$info);
                    push @args_lst_Uxntal, $uxntal_arg_expr;
                }
                return (join(' ',@args_lst_Uxntal),2 );
        }
        else {
            if ($opcode==0) { # parens, just remove it
                return _emit_expression_Uxntal($ast->[1], $stref, $f, $info);
            }
            croak 'Unimplemented case for _emit_expression_Uxntal: ',Dumper($ast);
        }
    } else {
        # This is fall-through if the expression is a literal
        return ($ast,0); # word size set to 0 as it is meaningless.
    }
} # END of _emit_expression_Uxntal


# Emits constant strings with only a leading double quote
# We add extra info  to distingiush between a character and a string of length 1
sub __substitute_PlaceHolders_Uxntal($expr_str,$info,$isChar){
    if (not defined $isChar) { $isChar=0; }
    if ($expr_str=~/__PH/ and exists $info->{'PlaceHolders'}) {
        # croak $expr_str.Dumper($info->{'PlaceHolders'})
        while ($expr_str =~ /(__PH\d+__)/) {
            my $ph=$1;
            my $ph_str = $info->{'PlaceHolders'}{$ph};
            $ph_str=~s/[\'\"]$//;
            $ph_str=~s/^[\']/\"/;
            $expr_str=~s/$ph/$ph_str/;
        }
        my $len = toRawHex(length($expr_str)-1,2);
        if ($len eq '0001' and $isChar) {
            $expr_str = toHex(ord(substr($expr_str,1,1)),1);
        } elsif ($len eq '0000') { # empty string is a string!
            $expr_str = '#00'; #"{ 0000 } STH2r"; #  '#00'; #
        } else {
            # replace space and nl by their ascii code
            # ' ' => ' 20 "'
            $expr_str =~s/\s/ 20 \"/g;
            $expr_str =~s/\n/ 0a \"/g;
            $expr_str =~s/\"\s*$//;
            $expr_str = "{ $len $expr_str } STH2r";
        }
    }
    return $expr_str;
} # END of __substitute_PlaceHolders


#### #### #### #### END OF C TRANSLATION CODE #### #### #### ####

sub _emit_subroutine_call_expr_Uxntal($stref,$f,$line,$info){
    my @call_arg_expr_strs_Uxntal=();
    my $subname = $info->{'SubroutineCall'}{'Name'};
    # This is only for local subroutines, so handle the others here
    if (exists $info->{'SubroutineCall'}{'IsExternal'}) {
        if ($subname eq 'exit') {
            return 'BRK';
        }
        elsif (exists  $F95_intrinsic_subroutine_sigs{$subname}) {
            add_to_used_lib_subs($subname);
            my $ast = [1,$subname,$info->{'SubroutineCall'}{'ExpressionAST'}];
            return __emit_intrinsic_subroutine_call_expr_Uxntal($stref,$f,$info,$ast);
        } else {
            warning("Subroutine $subname is EXTERNAL in $f");
        }
    }
    my $Ssubname = $stref->{'Subroutines'}{$subname};
    my $Sf = $stref->{'Subroutines'}{$f};
    # What we need for every argument is IODir , ArrayOrScalar from the record
    # So we'd better loop over the List in the record.
    #  "inout" args will occur in both places if required.
    my @in_args=();
    my @out_args=();
    my $idx=0;
    # emit Uxntal expr for each call arg
    # If the argument is a variable
    # If it is a string or array, we do __array_access
    # Otherwise we check if it is In or Out/InOut
    # If In, we do _array_access_read, else we do __array_access
    for my $sig_arg (@{$Ssubname->{'RefactoredArgs'}{'List'}}) {
        $idx++; # So starts at 1, because 0 is the sigil
        my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};

        my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} // $sig_arg;
        # my $call_arg_decl = get_var_record_from_set($Sf->{'Vars'},$call_arg_expr_str);
        my $call_arg_decl = getDecl($stref,$f,$call_arg_expr_str);
        # my $isParam = (defined $call_arg_decl ?1:0) * (exists $call_arg_decl->{'Parameter'}?1:0);
        # and binds lower than = so needs parens
        # my $isParam = (defined $call_arg_decl and exists $call_arg_decl->{'Parameter'});
        # or use &&
        my $isParam = defined $call_arg_decl && exists $call_arg_decl->{'Parameter'};
        my $intent = $rec->{'IODir'};
        my $isConstOrExpr = exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str} ?
        (($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' )
        or ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr')
        or $isParam)
        : 0;
        my $arg_expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[0] == 27 ? $info->{'SubroutineCall'}{'ExpressionAST'}[$idx] : $info->{'SubroutineCall'}{'ExpressionAST'};
        if ($isConstOrExpr) { # Not a var; but it can still be a string.
        # look at the signature
            if ($arg_expr_ast->[0] == 34) { # special case
                if (exists $rec->{'Attr'} and $rec->{'Attr'} ne ''
                and $rec->{'Attr'}!~/len=1$/) {
                    push @call_arg_expr_strs_Uxntal, __substitute_PlaceHolders_Uxntal($arg_expr_ast->[1],$info,0).' ( STRING ) '; # treat as string
                }
            } else {
                my ($uxntal_arg_expr,$word_sz) = _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);
                push @call_arg_expr_strs_Uxntal, $uxntal_arg_expr.' ( CONST/EXPR ARG by VAL ) ';
            }
        }
        elsif (not is_array_or_string($stref,$f,$call_arg_expr_str) and $intent eq 'in' ) { # As Scalar var used as In
            my ($uxntal_var_access, $word_sz) = _var_access_read($stref,$f,$info,$arg_expr_ast);
            push @call_arg_expr_strs_Uxntal, $uxntal_var_access.' ( SCALAR IN ARG by VAL ) ';
        }
        else { # A var, either nor scalar or scalar but used as Out or InOut
        # But this could be e.g. str(ib:ie), in which case it is a substring, TODO!
            if ($arg_expr_ast->[0] == 10 and scalar @{$arg_expr_ast}==3) { # an array or string access, need a substring or subarray
                my $var = $arg_expr_ast->[1];
                my $word_sz = $Sf->{'WordSizes'}{$var};
                my $short_mode =  $word_sz == 2 ? '2' : '';
                my $var_access = __var_access($stref,$f,$var);
                my $idx_expr_b = '';
                if ($arg_expr_ast->[2][0] == 12 ) { # ib:ie
                    ($idx_expr_b,my $word_sz) = _emit_expression_Uxntal($arg_expr_ast->[2][1], $stref, $f,$info);
                } else {
                    ($idx_expr_b,my $word_sz) =  _emit_expression_Uxntal($arg_expr_ast->[2], $stref, $f,$info);
                }
                my $idx_expr_e = $idx_expr_b;
                if ($arg_expr_ast->[2][0] == 12 ){ # ib:ie
                    ($idx_expr_e,my $word_sz) = _emit_expression_Uxntal($arg_expr_ast->[2][2], $stref, $f,$info);
                }
                croak Dumper($arg_expr_ast) if ref($idx_expr_b) eq 'ARRAY';
                if ($idx_expr_b eq $idx_expr_e) { # access a single element, so return a byte/short as value
                    my $idx_offset = __get_array_index_offset($stref,$f,$var);
                    my $idx_offset_Uxntal =  toHex($idx_offset,2);
                    my $idx_offset_expr = $idx_offset==0? '' : $idx_offset_Uxntal.' SUB2';
                    my $idx = $idx_expr_b;
                    # my $idx_word_sz = 
                    my $idx_expr = defined $idx ? ($idx eq $idx_offset_Uxntal) ? '' :
                    "$idx $idx_offset_expr".( $short_mode ? ' #0002 MUL2 ': '') .' ADD2 ' : '';
                    push @call_arg_expr_strs_Uxntal, "$var_access $idx_expr LDA$short_mode".' ( BYTE/SHORT )' # load a pointer, index, load the value


                    # my $idx_expr =  ($idx_expr_b eq '#0000') ? '' : "$idx_expr_b ADD2 ";
                    # push @call_arg_expr_strs_Uxntal,  "$var_access $idx_expr LDA$short_mode".' ( BYTE/SHORT )' # load a pointer, index, load the value
                } else {
                    # extract a substring
                    # my $decl = get_var_record_from_set($Sf->{'Vars'},$var);
                    my $decl = getDecl($stref,$f,$var);
                    my $id=$info->{'LineID'};
                    if($decl->{'Attr'}!~/len/) {
                        croak 'String with index>1 but the type is character', Dumper $arg_expr_ast;
                    }
                    my $len = __get_len_from_Attr($decl);
                    push @call_arg_expr_strs_Uxntal, __gen_substr($var_access, $idx_expr_b,$idx_expr_e, $len, $id). ' ( SUBSTR ) ';
                }
            } else {
                push @call_arg_expr_strs_Uxntal, __var_access($stref,$f,$arg_expr_ast->[1]).' ( ARG by REF ) ';
            }
        }
    }

    return join("\n", @call_arg_expr_strs_Uxntal, $subname);

} # END of _emit_subroutine_call_expr_Uxntal

sub _emit_function_call_expr_Uxntal($stref,$f,$info,$ast){
    (my $opcode, my $name, my $args) =@{$ast};
    my @call_arg_expr_strs_Uxntal=();
    my $subname = $ast->[1];#$info->{'SubroutineCall'}{'Name'};
    my $word_sz=2; 
    if (exists $F95_intrinsic_function_sigs{$subname}) {
        # my $intent = 'in';
        if ($F95_intrinsic_function_sigs{$subname}[-1] eq 'logical'
        or $F95_intrinsic_function_sigs{$subname}[-1] eq 'character') {
            $word_sz=1;
        }
        add_to_used_lib_subs($subname);
        my @call_arg_asts = ();
        if (@{$args}) { # else means no args
            if ($args->[0] == 27) { #
                for my $idx (1 .. scalar @{$args}-1) {
                    push @call_arg_asts, $args->[$idx];
                }
            } else {
                push @call_arg_asts, $args;
            }
            my $idx=0;
            for my $call_arg_ast (@call_arg_asts) {
                $idx++;
                if (not (($call_arg_ast->[0]==9) and ($call_arg_ast->[1][1] eq 'kind'))
                ) { # skip kind=... argument as we don't use it anyway
                    my $call_arg_expr_str =
                    ($call_arg_ast->[0] == 2 or $call_arg_ast->[0] == 10 or $call_arg_ast->[0] > 28)
                    ? $call_arg_ast->[1] : '';
                    my ($uxntal_expr,$word_sz) = __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$call_arg_ast,$idx,'in');
                    push @call_arg_expr_strs_Uxntal, $uxntal_expr;
                }
            }
            # carp Dumper(@call_arg_asts,@call_arg_expr_strs_Uxntal) if $subname eq 'iand';
        }
    } else {
        my $Ssubname = $stref->{'Subroutines'}{$subname};
        if ($stref->{'Subroutines'}{$subname}{'Signature'}{'ReturnType'} eq 'logical'
        or $stref->{'Subroutines'}{$subname}{'Signature'}{'ReturnType'} eq 'character'
        and $stref->{'Subroutines'}{$subname}{'Signature'}{'ReturnTypeAttr'} eq '') {
            $word_sz=1;
        }

        my $idx=0;
        for my $fcall (@{$info->{'FunctionCalls'}}) {
            if ($fcall->{'Name'} eq $subname) {
                my $argmap = $fcall->{'ArgMap'};
                    for my $sig_arg (sort keys %{$argmap}) {
                        $idx++; # So starts at 1, because 0 is the sigil
                        my $intent = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
                        my $call_arg_expr_str = $argmap->{$sig_arg} // $sig_arg;
                        my ($uxntal_expr,$word_sz) = __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$ast,$idx,$intent);
                        push @call_arg_expr_strs_Uxntal, $uxntal_expr;
                    }
                last;
            }
        }
    }
# TODO: deal with kind here
    return (join(" ", @call_arg_expr_strs_Uxntal, $subname),$word_sz);

} # END of _emit_function_call_expr_Uxntal

# Returns the call arg Uxntal expression and its word size
sub __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$ast_from_info,$idx,$intent){
    my $Sf = $stref->{'Subroutines'}{$f};
    # croak Dumper($subname,$call_arg_expr_str,$ast_from_info) if $subname eq 'modulo';
    # my $call_arg_decl = get_var_record_from_set($Sf->{'Vars'},$call_arg_expr_str);
    my $call_arg_decl = getDecl($stref,$f,$call_arg_expr_str);

    # carp Dumper $call_arg_decl, (defined $call_arg_decl) , (exists $call_arg_decl->{'Parameter'});
    my $isParam = ((defined $call_arg_decl) && (exists $call_arg_decl->{'Parameter'})) ? 1 : 0;
    my $arg_is_not_string = 0;
    my $arg_is_intrinsic_call = 0;
    # This does not work for intrinsics, they are not in FunctionCalls
    # Maybe I should add IntrinsicFunctionCalls to make it easy
    my $call_info = $info->{'SubroutineCall'};
    if (exists $info->{'Assignment'} or exists $info->{'SubroutineCall'} or exists $info->{'IOCall'}) {
        # Get the function call info
        if  (exists $info->{'FunctionCalls'} and scalar @{$info->{'FunctionCalls'}}>0) {
            for my $fcall (@{$info->{'FunctionCalls'}}) {
                if ($fcall->{'Name'} eq $subname) {
                    $call_info = $fcall;
                    last;
                }
            }
        }
        if  (exists $info->{'IntrinsicFunctionCalls'} and scalar @{$info->{'IntrinsicFunctionCalls'}}>0) {
            for my $fcall (@{$info->{'IntrinsicFunctionCalls'}}) {
                if ($fcall->{'Name'} eq $subname) {
                    $call_info = $fcall;
                    $arg_is_intrinsic_call = 1;
                    $arg_is_not_string = $F95_intrinsic_function_sigs{$subname}[0][$idx-1] ne 'character(*)' ? 1 : 0;
                    last;
                }
            }
        }
    }
# carp Dumper($subname,$call_arg_expr_str,$ast_from_info,$call_info);
    my $isConstOrExpr = exists $call_info->{'Args'}{'Set'}{$call_arg_expr_str}
        ? (($call_info->{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' )
        or ($call_info->{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr')
        or $isParam)
            ? 1
            : 0
        : 0;
    # TODO: support DO via {'Do'}{'Range'}{ExpressionASTs'}'
    # Problem is that here, we don't know which of the expressions it is
    # my $ast_from_info = exists $info->{'Assignment'}
    #     ? $info->{'Rhs'}{'ExpressionAST'}
    #     : exists $info->{'Do'}
    #         ? $info->{'Do'}{'Range'}{'ExpressionASTs'}[$be]
    #         : $info->{'SubroutineCall'}{'ExpressionAST'};

    my $arg_expr_ast = $ast_from_info->[0] == 27 # comma
        ? $ast_from_info->[$idx]
        : $ast_from_info->[0] == 1 # function call
            ? $ast_from_info->[2][0] == 27 # comma
                ? $ast_from_info->[2][$idx]
                : $ast_from_info->[2]
            : $ast_from_info;
    # carp Dumper $arg_expr_ast;
    if ($isConstOrExpr) { # Not a var
        return _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);#.' ( CONST/EXPR ARG by VAL ) ';
    }
    elsif ($arg_is_intrinsic_call) {
        my ($uxntal_expr,$word_sz) = _emit_expression_Uxntal($ast_from_info, $stref, $f,$info);
        return ($uxntal_expr.' ( INTRINSIC CALL ) ',$word_sz);
    }
    elsif (not is_array_or_string($stref,$f,$call_arg_expr_str) and $intent eq 'in' ) { # a Scalar var used as In
        my ($uxntal_expr,$word_sz) = _var_access_read($stref,$f,$info,$arg_expr_ast);
        return ($uxntal_expr.' ( SCALAR IN ARG by VAL ) ',$word_sz);
    }
    elsif ( $arg_is_not_string ) { # A string access used as In in an intrinsic
        my ($uxntal_expr,$word_sz) = _var_access_read($stref,$f,$info,$arg_expr_ast);
        return ($uxntal_expr .' ( INTRINSIC ARG by VAL ) ',$word_sz);
    }
    else { # A var, either not scalar or scalar but used as Out or InOut
    # But this could be e.g. str(ib:ie), in which case it is a substring, TODO!
        if ($arg_expr_ast->[0] == 10 and scalar @{$arg_expr_ast}==3) { # an array or string access, need a substring or subarray
                my $var = $arg_expr_ast->[1];
                if (is_array($stref,$f,$var)) {
                    if ($arg_expr_ast->[2][0] == 12) {
                        croak("Array slice is not supported: $var in $f: ".Dumper($arg_expr_ast)) ;
                    } else {
                     return _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);
                    }
                }
                my $var_access = __var_access($stref,$f,$var);
                my $idx_expr_b = $arg_expr_ast->[2];
                if ($arg_expr_ast->[2][0] == 12) { # ib:ie
                    ($idx_expr_b,my $word_sz) = _emit_expression_Uxntal($arg_expr_ast->[2][1], $stref, $f,$info)
                }
                my $idx_expr_e = $idx_expr_b;
                if ($arg_expr_ast->[2][0] == 12 ){ # ib:ie
                    ($idx_expr_e,my $word_sz) = _emit_expression_Uxntal($arg_expr_ast->[2][2], $stref, $f,$info)
                }

                if ($idx_expr_b eq $idx_expr_e) { # access a single character, so return a byte as value
                    my $idx_expr =  ($idx_expr_b eq '#0000') ? '' : "$idx_expr_b ADD2 ";
                    return  ("$var_access INC2 $idx_expr LDA ", 1) # load a pointer, index, load the value
                } else {
                    # extract a substring
                    # my $decl = get_var_record_from_set($Sf->{'Vars'},$var);
                    my $decl = getDecl($stref,$f,$var);
                    my $id=$info->{'LineID'};
                    if($decl->{'Attr'}!~/len/) {
                        croak 'String with index>1 but the type is character', Dumper $arg_expr_ast;
                    }
                    my $len = __get_len_from_Attr($decl);
                    return (__gen_substr($var_access, $idx_expr_b,$idx_expr_e, $len, $id),2);
                }

         } else {
            my ($uxntal_call_arg, $word_sz) = __var_access($stref,$f,$arg_expr_ast->[1]);
            return ($uxntal_call_arg.' ( ARG by REF ) ',$word_sz);
         }
    }
} # END of __emit_call_arg_Uxntal_expr

sub __emit_intrinsic_subroutine_call_expr_Uxntal($stref,$f,$info,$ast){
    (my $opcode, my $name, my $args) =@{$ast};
    my @call_arg_expr_strs_Uxntal=();
    my $subname = $ast->[1];#$info->{'SubroutineCall'}{'Name'};
    my $sig= $F95_intrinsic_subroutine_sigs{$subname};
        # my $intent = 'in';
    my @call_arg_asts = ();
    if ($args->[0] == 27) { #
        for my $idx (1 .. scalar @{$args}-1) {
            push @call_arg_asts, $args->[$idx];
        }
    } else {
        push @call_arg_asts, $args;
    }
        # croak Dumper @call_arg_asts;
    my $idx=0;
    for my $call_arg_ast (@call_arg_asts) {
        my $intent = $sig->[$idx][1];
        $idx++;
        my $call_arg_expr_str =
        ($call_arg_ast->[0] == 2 or $call_arg_ast->[0] == 10 or $call_arg_ast->[0] > 28)
        ? $call_arg_ast->[1] : '';
        my ($uxntal_call_arg, $word_sz) = __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$call_arg_ast,$idx,$intent);
        push @call_arg_expr_strs_Uxntal, $uxntal_call_arg;
    }


    return join(" ", @call_arg_expr_strs_Uxntal, $subname);

} # END of __emit_intrinsic_subroutine_call_expr_Uxntal

# -----------------------------------------------------------------------------
sub toUxntalType($ftype,$kind ){

    if (not defined $kind) {$kind=4};
    if ($kind=~/kind/) {$kind=~s/kind\s*=\s*//;}; # FIXME, this should have been sorted in the Parser
    my $word_sz = $kind;
    if ($ftype eq 'character' and $kind=~/len/) {
        if ($kind !~/len=1/) {
            $word_sz=2;
        } else {
            $word_sz=1;
        }
    }

    my %corr = (
        'logical'          => 1, # C has no bool
        'integer'          =>  $word_sz,
        # 'real'             => ($ftype eq 'real' and $kind == 8 ? 'double' : 'float'),
        # 'double precision' => 'double',
        # 'doubleprecision'  => 'double',
        'character'        => $word_sz
    );
    if ( exists( $corr{$ftype} ) ) {
        return $corr{$ftype};
    } else {
        croak "TYPE for $ftype is not supported\n" if $W;
    }
}    # END of toUxntalType()

sub toHex($n,$sz){
    croak if not defined $n;
	croak if $n eq '1_2';
	$n=~s/_\d$//; # strip _2 
    my $szx2 = $sz*2;
    if ($n<0) {
        $n=(2*($sz*8))-$n;
    }
    return sprintf("#%0${szx2}x",$n);
}
sub toRawHex($n,$sz){
	croak if $n eq '1_2';
    my $szx2 = $sz*2;
	$n=~s/_\d$//; # strip _2
    if ($n<0) {
        $n=(2*($sz*8))-$n;
    }
    return sprintf("%0${szx2}x",$n);
}


# iter DUP #00 SWP ( iter 00 iter )
# ;$strn ADD2 LDA ( iter strn[iter] )
# SWP #00 SWP ( strn[iter] 00 iter )
# cb SUB2 ;substr_$id ADD2 STA ( strn[iter] substr_$id[cb-iter] )

# $str_addr is an absolute Uxntal address,  ;v ;&v or a raw address
sub __gen_substr($str_addr, $cb, $ce, $len, $id){
    if ($cb eq $ce) { # return a single character. This is by value
        # -1 to go to base-0 but +2 because of the length field, so +1
        return $cb . ' INC2 '.$str_addr.' LDA2 ( STRING ) ADD2 LDA'
    } else {
        add_to_used_lib_subs('range-map');
        # return an actual substring.
# What this does is allocate space for the substring and return the address, so it's by reference.
# If the substring is the argument of a function of operator, that is the right thing to do
# If it is the RHS of an assignment, then we need a memwrite-string of the substring of this length.
# This means that for a var access which is an assignment, we need to pass in the LHS as an address.
# I think that any LHS is *always* an address. So x = 42 is ;x #002a STA2;
# But array and string slices are a special case: suppose
# s(4:8)="hello"
# Then what we need is a memwrite-string starting at 4
# short to byte
        my $cbb = $cb;
        if ($cbb=~/^\#00/) {
            $cbb=~s/^\#00//; $cbb='#'.$cbb
        }
        elsif ($cbb=~/LDA2/) {
            $cbb .= ' NIP ';
        }
        my $ceb = $ce;
        if ($ceb=~/^\#00/) {
            $ceb=~s/^\#00//;$ceb='#'.$ceb
        }
        elsif ($ceb=~/LDA2/) {
            $ceb .= ' NIP ';
        }
        # iter-1+2; iter-1-(cb-1) = iter+1; iter-cb
        return
        '{ DUP #00 SWP '.$str_addr.' ADD2 INC2 LDA' . "\n" .
        '  SWP #00 SWP '.$cb.' SUB2' . "\n" .
        '  ;&substr_'.$id.' ADD2 STA'  . "\n" .
        '  JMP2r'  . "\n" .
        '} STH2r '.$ceb.' '.$cbb.' range-map'  . "\n" .
        '{ '.toRawHex($len,2).' &substr_'.$id.' $'.toRawHex($len,1).' } STH2r'; # string with a 2-byte length field
    }
} # END of __gen_substr

sub isStrCmp($ast, $stref, $f,$info){
    if ($ast->[0] >=15 && $ast->[0]<=26 ) {
        # it is a comparison; are the args strings?
    my $lhs_name = $ast->[1][0] == 10 ? $ast->[1][1] : '';
    my $rhs_name = $ast->[2][0] == 10 ? $ast->[2][1] : '';
    my $lhs_is_str = $ast->[1][0] == 34 ? 1 : 0;
    my $rhs_is_str = $ast->[2][0] == 34 ? 1 : 0;
    if (not $lhs_is_str) {
        if ($lhs_name ne '') {
            # my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$lhs_name);
            my $decl = getDecl($stref,$f,$lhs_name);
            if ($decl->{'Type'} eq 'character') {
                $lhs_is_str=1;
            }
        }
    }
    if (not $rhs_is_str) {
        if ($rhs_name ne '') {
            # my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$rhs_name);
            my $decl = getDecl($stref,$f,$rhs_name);
            if ($decl->{'Type'} eq 'character') {
                $rhs_is_str=1;
            }
        }
    }
    return $lhs_is_str * $rhs_is_str;
    } else {
        # it is not a comparison
        return 0
    }
}
# @scmp ( a* b* -- f )
#     STH2
#     &l ( a* b* -- f )
#         LDAk LDAkr STHr NEQk ?&d
#         DUP EOR EQUk ?&d
#         POP2 INC2 INC2r !&l
#     &d ( a* c1 c2 b* -- f )
#         NIP2 POP2r EQU JMP2r

# returns the Uxntal string with the print instructions
sub _emit_list_print_Uxntal($stref,$f,$line,$info,$unit,$advance,$list_to_print){
    my $Sf = $stref->{'Subroutines'}{$f};
    my $port = ($unit eq 'STDERR') ? '#19' : '#18';
# so for every elt in the list, we must work out if it is
#  - an integer
# - a character
# - a string
# - a boolean
# - anything else, but that should fail
# although of course in principle a function should work too

    my $line_Uxntal = '';
    for my $elt ( @{$list_to_print} ) {
        my $ref = \$elt; $ref=~s/REF...//;$ref=~s/\)//;
        my $iter="iter$ref";
        # An array as arg is caught in _emit_print_from_ast so I should handle the slice there as well
        my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt);
        # croak("HANDLE ARRAY SLICE HERE!");
        my $var_name = $elt->[1];

        if ($print_fn_Uxntal eq 'print-array') {
            # transforming the array into an index access mighr be best
            my $decl = getDecl($stref,$f,$var_name);
            # carp Dumper($decl);
            my $array_length = exists $decl->{'ConstDim'}
            ? __C_array_size($decl->{'ConstDim'})
            : __C_array_size($decl->{'Dim'});
            my $elt_iter = [10,$elt->[1],[36,'LIT2 &'.$iter.' $2']];
            my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt_iter,$stref, $f, $info);
            my $elt_0 = [10,$elt->[1],[29,'0']];
            my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt_0);
            $line_Uxntal = '{ ( iter ) ,&'.$iter.' STR2 '.$arg_to_print_Uxntal.' '.$print_fn_Uxntal.' JMP2r } STH2r '.toHex($array_length-1,2).' #0000  range-map-short ( print-array )';
            # croak $line_Uxntal;
        }
        elsif ($print_fn_Uxntal eq 'print-array-slice') {
            my $idx_offset = __get_array_index_offset($stref,$f,$var_name);
            my $idx_offset_Uxntal =  toHex($idx_offset,2);
            my $idx_offset_expr = $idx_offset==0? '' : $idx_offset_Uxntal.' SUB2';
            # croak Dumper $elt;
            my ($b,$word_sz_b) = _emit_expression_Uxntal($elt->[2][1],$stref, $f, $info);
            my ($e,$word_sz_e) = _emit_expression_Uxntal($elt->[2][2],$stref, $f, $info);
            $elt = [10,$elt->[1],[36,'LIT2 &'.$iter.' $2']];
            my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt,$stref, $f, $info);
            my $elt_0 = [10,$elt->[1],[29,'0']];
            my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt_0);
            $line_Uxntal = '{ ( iter ) ,&'.$iter.' STR2 '.$arg_to_print_Uxntal.' '.$print_fn_Uxntal." #20 $port DEO JMP2r } STH2r $e $idx_offset_expr $b $idx_offset_expr range-map-short ( print-array-slice )";
            # croak $line_Uxntal;
        } else {
            my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt,$stref, $f, $info);
            # carp Dumper($print_fn_Uxntal,$arg_to_print_Uxntal);
            # TODO: feels like a HACK
            if ($print_fn_Uxntal eq 'print-char' and $elt->[0] == 2) {
                my ($uxntal_var_access, $word_sz) = _var_access_read($stref,$f,$info,$elt);
                croak "$uxntal_var_access: word size is $word_sz" if $word_sz !=1;
                $arg_to_print_Uxntal = $uxntal_var_access. ' LDA';
            }
            # If a string is a single char, we treat it as a char, so we must print a char
            if ($print_fn_Uxntal eq 'print-string' and $arg_to_print_Uxntal=~/^(?:\s*\#|LDA)$/ ) { #
                $print_fn_Uxntal = 'print-char';
            }
            $line_Uxntal .= "$arg_to_print_Uxntal $print_fn_Uxntal #20 $port DEO ( , )\n";
            add_to_used_lib_subs($print_fn_Uxntal);
        }
    }
    if ($advance eq 'yes') {
        if ($unit eq 'STDOUT') {
            $line_Uxntal .= ' #0a #18 DEO';
        }
        elsif ($unit eq 'STDERR') {
            $line_Uxntal .= ' #0a #19 DEO';
        }
    } else {
        if ($unit eq 'STDOUT') {
            $line_Uxntal .= ' #20 #18 DEO';
        }
        elsif ($unit eq 'STDERR') {
            $line_Uxntal .= ' #20 #19 DEO';
        }
    }
    return $line_Uxntal;

} # END of _emit_list_print_Uxntal

# returns the print function to be used: print-char, print-int etc
sub _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt){
    my $Sf = $stref->{'Subroutines'}{$f};
    my $suffix = $unit eq 'STDERR' ? '-stderr' : '';
    # carp Dumper $elt;
    my $code = $elt->[0];
    if ($code == 2 or $code == 10) { # A scalar, but can be an unindexed string or array
        my $var_name = $elt->[1];
        # my $word_sz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$var_name};
        # my $decl = get_var_record_from_set($Sf->{'Vars'},$var_name);
        my $decl = getDecl($stref,$f,$var_name);
        my $type = $decl->{'Type'};
        if ($code == 2 and $decl->{'ArrayOrScalar'} eq 'Array') {
            return 'print-array';
            croak("Printing an array is currently unsupported: $var_name");
            # this should be a range-map-short over the entire array
            # { ( iter ) $array ADD2 LDA$short_mode $   }
        }
        elsif ($code == 10 and $elt->[2][0] == 12 and exists $decl->{'Dim'}) {
            return 'print-array-slice';
            croak("Printing an array slice is currently unsupported",Dumper($elt,$decl))
        }
        # Detect and handle an array slice here. That should be [10, 'array', [':',...]]
        if ( $decl->{'Type'} eq 'character') {
            if( $code == 2 and $decl->{'Attr'}!~/len/) {
                return 'print-char'.$suffix;
            }
            elsif( $code == 10 and $decl->{'ArrayOrScalar'} eq 'Array') {
                my $dims =  $decl->{'Dim'};
                my $ndims = scalar @{$dims};
                if ($ndims==0 ) {
                    return 'print-string'.$suffix;
                } else {
                # an indexed array of characters, so print a char
                    return 'print-char'.$suffix;
                }
            }
            elsif( $code == 10 and $decl->{'ArrayOrScalar'} eq 'Scalar') {
                my $len = $decl->{'Attr'};
                $len =~s/len=//;$len =~s/[\(\)]//g;
                if ($len>1) {
                    return 'print-string'.$suffix;
                } else {
                    die "Code says array but decls says Scalar:".Dumper( $elt, $decl);
                }
            } else {
                return 'print-string'.$suffix;
            }
        }
        if ( $decl->{'Type'} eq 'integer') {
            return 'print-int'.$suffix;
        }
        if ( $decl->{'Type'} eq 'logical') {
            return 'print-bool'.$suffix;
        }
    }
    elsif ($code == 1 ) { # A function call
        my $fname = $elt->[1];
        # This is a function, need to get its return type
        # TODO
        my $return_type = exists $F95_intrinsic_function_sigs{$fname}
        ? $F95_intrinsic_function_sigs{$fname}[-1]
        : $stref->{'Subroutines'}{$fname}{'Signature'}{'ReturnType'};
        my $return_type_attr = $stref->{'Subroutines'}{$fname}{'Signature'}{'ReturnTypeAttr'} // '';
        if ($return_type eq 'character(*)' ) {
            $return_type = 'character';
            $return_type_attr ='(*)';
        }
        # I am assuming the return type can only be integer(kind=2), character, string or boolean
        if ($return_type eq 'logical') {
            return 'print-bool'.$suffix;
        }
        elsif ($return_type eq 'integer' and ($return_type_attr=~/(?:kind=)?2/
        or $return_type_attr eq '')) {
            return 'print-int'.$suffix;
        }
        elsif ($return_type eq 'character' and ($return_type_attr eq '' or $return_type_attr=~/(?:len=)?1/)) {
            return 'print-char'.$suffix;
        }
        elsif ($return_type eq 'character' and $return_type_attr=~/(?:len=)?\d+/) {
            return 'print-string'.$suffix;
        }
        elsif ($return_type eq 'character' and $return_type_attr=~/(?:len=)?[\*\:]/) {
            # croak "Dynamic string as return type for $fname";
            # We assume that the length field will be set correctly
            return 'print-string'.$suffix;
        } else {
            error("Unsupported type in print statement in $fname: ".$return_type.'('.$return_type_attr.') in <'.$line.'>'.Dumper($stref->{'Subroutines'}{$fname}{'Signature'}));
        }
    }
    elsif ($code>=29) {
        my $const_type = $code;
        my $const = $elt->[1];
        if ($const_type == 29 ) {
            return 'print-int'.$suffix;
        }
        elsif ($const_type == 31 ) {
            return 'print-bool'.$suffix;
        }
        elsif ($const_type == 32 ) {
            return 'print-char'.$suffix;
        }
        elsif ($const_type == 34 ) {
            # say Dumper ($f,$line,$info,$unit,$elt);
            # die("Placeholder in print statement\n");
            return 'print-string'.$suffix;
        }
        else {
            error('Unsupported type in print statement: '.$sigils[$const_type]);
        }
    }
    elsif ($code>=3 and $code<=6) {
        return 'print-int'.$suffix;
    }
    elsif ($code==7 or $code==8) {
        croak("TODO: printing of ".$sigils[$code]."\n");
    }
    elsif ($code>=15 and $code<=26) {
        return 'print-bool'.$suffix;
    }
    elsif ($code==13) {
        # I guess this should be a print-string of the string returned by the concatenation operation
        croak("TODO: printing of string concatenation expression\n");
    }
    else {
        error('Unsupported type in print statement: '.$sigils[$code]);
    }
} # END of _emit_print_from_ast
# -----------------------------------------------------------------------------

# Analyse the write call in terms of unit, format, advance and the argument list
# Returns a list of print calls and offsets


# How do we print

# funktalTokens(1:funktalTokensIdx-1)

# We need essentially
# {
# $print_item JMP2r
# } STH2r funktalTokensIdx-2 0 range-map-short

# where $print_item depends on the type of the array.
# I think the most pragmatic approach is to support only a single array argument, and add a special case, detected in _analyse_write_call: if there is a single arg and it is an array
# (if there are more args and one is an array, )

sub _analyse_write_call($stref,$f,$info){
    my $call_args_ast = $info->{'IOCall'}{'Args'}{'AST'}[2];
    my $iolist_ast = $info->{'IOList'}{'AST'};
# carp Dumper $call_args_ast,$iolist_ast ;
    # This is really complicated.
    # The first arg can be an integer, a variable or '*'
    # If it's zero, it's STDERR, so we need #19 instead of #18
    # If it's a variable, we are copying into a string, which is not DEO at all
    # If it's advance=no it means no newline, that bit is easy
    # And then there is the format, which tells us which print action we need to do

    # other args can be named or not (fmt=, advance=)
    # Formats must be parsed to see if it is a list or not
    # They are stored as placeholders
    my $print_calls=[];
    my $offsets=[];
    my $unit='';
    my $advance='yes';
    if ($call_args_ast->[0]==27) {
        shift @{$call_args_ast};
        # Now we have the actual arg list
        my $i=0;
        for my $arg_ast (@{$call_args_ast}) {
            # all of these will be tagged
            # tags can be
            # 29 : if 0, this is STDERR; I assume 1 is STDOUT, needs to check
            # 32: char: if *, means it's like print *
            # 34: PlaceHolder, this is the string with the format (`fmt=` is removed)
            # 9: =, check what is next, it should be [2,$attr]
            # Most common $attr is advance; the value will be a PlaceHolder
            my $attr = __analyse_write_call_arg($stref,$f,$info,$arg_ast,$i);
            # carp 'ATTR:'.Dumper( $attr);
            ++$i;
            if ($attr->[0] eq 'fmt') {
				# if ($attr->[1] eq '*') {
				# 	$advance='yes';
				# }
                ($print_calls,$offsets) = __parse_fmt($attr->[1],$stref,$f,$info);
            }
            elsif ($attr->[0] eq 'unit') {
                $unit = $attr->[1];
            }
            elsif ($attr->[0] eq 'advance') {
                $advance=$attr->[1];
            } else {
                error("Unsupported WRITE call syntax: ".Dumper($info));
            }
        }
    }
    else { # single element
        my $attr = __analyse_write_call_arg($stref,$f,$info,$call_args_ast,0);
    }

    if ($unit eq 'STDERR') {
        $print_calls = [map {$_.='-stderr'} @{$print_calls}];
    }
    elsif ($unit ne 'STDOUT') { # so must be a var
    # memwrite-string assumes the target is a string
    # memwrite-char, memwrite-int, memwrite-hex assume the target is an array
    # The use case is for strings so to be clear I should probably call them strwrite instead of memwrite.
        $print_calls = [map {$_=~s/print/strwrite/;$_} @{$print_calls}];
        map { add_to_used_lib_subs( $_ ) } @{$print_calls};
    }
# suppose I return print-array-slice
    return ($print_calls, $offsets, $unit, $advance);
} # END of _analyse_write_call
# -----------------------------------------------------------------------------
# This call returns unit, fmt or advance. Could in principle return any attribute
sub __analyse_write_call_arg($stref,$f,$info,$arg,$i){
    # all of these will be tagged
    my $tag = $arg->[0];
    my $arg_val = $arg->[1];
    if ($tag == 29) { # integer
        # 29 : if 0, this is STDERR; otherwise it means a file but I will not support this
        if ($arg_val==0) {
            # STDERR
            return ['unit','STDERR'];
        } else {
            error("WRITE only supported with unit=0, unit=* or a variable");
        }
        # "The standard logical units 0, 5, and 6 are preconnected to Solaris as stderr, stdin, and stdout"
        # it looks like for gfortran on Linux, 0 is also stderr
    }
    elsif ($tag == 32) { # character
        # 32: char: if *, means it's like print *
        if ($arg_val eq '*' ) {
            if ($i==0){
                return ['unit','STDOUT'];
            }
            elsif ($i==1) {
                return ['fmt','*'];
            }
        } else {
            error("WRITE only supported with unit=0, unit=* or a variable");
        }
    }
    elsif ($tag == 34) {
        # 34: PlaceHolder, this is the string with the format (`fmt=` is removed)
        my $fmt_str = $info->{'PlaceHolders'}{$arg_val};
        $fmt_str=~s/^[\"\']\(//;
        $fmt_str=~s/\)[\'\"]$//;
        # say "FMT=$fmt_str";
        return ['fmt',$fmt_str];
    }
    elsif ($tag == 9) {
        # 9: =, check what is next, it should be [2,$attr]
        # Most common $attr is advance; the value will be a PlaceHolder
        if (ref($arg_val) eq 'ARRAY' and $arg_val->[0] == 2) {
            my $attr = $arg_val->[1];
            if ($attr eq 'advance') {
                my $attr_val = $arg->[2];
                if ($attr_val->[0] == 34) {
                    my $attr_val_str =  $info->{'PlaceHolders'}{$attr_val->[1]};
                    $attr_val_str=~s/^[\"\']//;
                    $attr_val_str=~s/[\"\']$//;
                    return [ 'advance',$attr_val_str];
                }
            }
        }
    }
    elsif ($tag == 2) {
        # must be a variable
        my $unit_var =     $arg_val;
        return ['unit',$unit_var];
    } else {
        die "Unknown arg type: ".Dumper($arg);
    }
} # END of __analyse_write_call_arg
# -----------------------------------------------------------------------------
# returs a list of the types to be printed.
# I only support I, A, L and Z.
# For A, if it is >1 it is a string, else a character.
# What I return is the list of required print calls
# w.m means a width of w characters, showing m digits
# w>m is an error
# w<m pads upfront with spaces
# if the field is too small, a string of w `*`s is returned
# TODO: I am not going to do this.
# I will simply use m and ignore w
sub __parse_fmt($fmt_str,$stref,$f,$info){
    my $print_calls=[];
    my $offsets=[0];
    # if ($fmt_str ne '*') {
        my @fmt_str_chunks = split(/\s*,\s*/,$fmt_str);
        my $offset=0;
        my $chunk_idx=1;
        for my $chunk (@fmt_str_chunks) {
            my $c=uc(substr($chunk,0,1));
            my $nchars=substr($chunk,1);
            if ($nchars=~/^\d\.(\d)$/) {
                $nchars=$1;
            } elsif ($nchars=~/^(\d)$/) {
                $nchars=$1;
            } else { # For formats without numbers, we need to count the characters for each item in the IO list
                my $val_ast = ($info->{'IOList'}{'AST'}[0]==27)
                    # more than one argument in the IO list
                    ? $info->{'IOList'}{'AST'}[$chunk_idx]
                    : $info->{'IOList'}{'AST'};
                $nchars = __get_len_from_AST($val_ast,$info->{'PlaceHolders'});
                if ($nchars==0) {
					if ( $val_ast->[0] == 2) { # A variable
	                    my $var = $val_ast->[1];
	                    my $decl = getDecl($stref,$f,$var);
	                    my $len=0;
	                    if ($decl->{'Type'} eq 'character') {
	                        if (exists $decl->{'Attr'} and $decl->{'Attr'}=~/len/) {
	                            $len=$decl->{'Attr'}; $len=~s/^\(len=//;$len=~s/\)$//;
	                        } else {
	                            $len=1;
	                        }
	                    } elsif ($decl->{'Type'} eq 'integer') {
	                        if (exists $decl->{'Attr'} and $decl->{'Attr'}=~/kind/) {
                            	my $klen=$decl->{'Attr'}; $klen=~s/^\(kind=//;$klen=~s/\)$//;
								$len = $klen==1 ? 4 : 6; # including space for the sign
	                        } else {
	                            $len=11; # assuming signed 4-byte
	                        }
	                    } else {
	                        die "FMT without size is only supported with a character or integer\n";
	                    }
	                    $nchars=$len;
					}
					elsif ($val_ast->[0] >= 3 and $val_ast->[0]<=8) { # An integer expression
						$nchars=6; # Let's assume it's all shorts 
					}
					elsif ($val_ast->[0] >= 15 and $val_ast->[0]<=26) { # A boolean expression
						$nchars=1;
					}
                }

            }

            if ( $c eq 'I' ) {
                push @{$print_calls}, 'print-int';
                $offset+=max(2,$nchars);
            }
            elsif ( $c eq 'Z' ) {
                # Normally, print-hex assumes a short and returns 4 bytes
                # If $nchars < 4, we need to remove
                if ($nchars <4) {
                    push @{$print_calls}, 'print-hex-'.$nchars;
                } else {
                    push @{$print_calls}, 'print-hex';
                }
                $offset+=max(1,$nchars);
            }
            elsif ( $c eq 'L' ) {
                push @{$print_calls}, 'print-bool';
                $offset+=max(1,$nchars);
            }
            elsif ( $c eq 'A' ) {
                if (uc($chunk) eq 'A') {
                    if ($ nchars!=1) {
                        push @{$print_calls}, 'print-string';
                        # offset is unknown
                        # set it totally ad-hoc to 8
                        $offset+=8;
                    } else {
                        push @{$print_calls}, 'print-char';
                        $offset+=1;
                    }
                } else {
                    if ($nchars==1) {
                        push @{$print_calls}, 'print-char';
                        $offset+=max(1,$nchars);
                    }
                    elsif ($nchars>1) {
                        push @{$print_calls}, 'print-string';
                        $offset+=max(1,$nchars);
                    } else {
                        die "Problem with FMT $chunk\n";
                    }
                }
            }
            elsif ( $c eq '*' ) {
                my $val_ast = ($info->{'IOList'}{'AST'}[0]==27)
                    # more than one argument in the IO list
                    ? $info->{'IOList'}{'AST'}[$chunk_idx]
                    : $info->{'IOList'}{'AST'};
                (my $type, $offset) = __get_type_len_from_AST($val_ast,$info->{'PlaceHolders'});
                # push @{$print_calls}, 'print-'.$type;
                push @{$print_calls}, 'print-list'; # This is purely to indicate that this should be handled differently
            }
            else {
                die "Unsupported FMT: $chunk\n";
            }
            push @{$offsets},$offset;
            $chunk_idx++;
        } # for each chunk
    # } else {
    # if ($fmt_str eq '*') {
    #     # fmt=*
    #     carp 'FMT=*: ',Dumper $info->{'IOList'}{'AST'}
    #     # If it is a list, look at each arg; determine the print function based on that
    # }
    # carp '__parse_fmt: ',Dumper($print_calls,$offsets);
    return ($print_calls,$offsets);
} # END of __parse_fmt

sub __get_len_from_AST($val_ast, $phs){
#                29         30      31         32           33         34             35       36
#              ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
    if ($val_ast->[0] == 29) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 30) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 31) {
        return 1; # We print 'T' or 'F'
    } elsif ($val_ast->[0] == 32) {
        return 1;
    } elsif ($val_ast->[0] == 33) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 34) {
        return length($phs->{$val_ast->[1]});
    } elsif ($val_ast->[0] == 35) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 36) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 2) {
        # assuming this is a variable, return 0 as a sign it needs to be done outside of this function
        return 0;
    } elsif ($val_ast->[0] == 10) {
        return 0;
    } elsif ($val_ast->[0] == 1) {
        return 0;
    } else {
        return 0;
		# croak("Unsupported arg type for fmt: ".Dumper($val_ast));
    }
} # END of __get_len_from_AST

sub __get_type_len_from_AST($val_ast, $phs){
#                29         30      31         32           33         34             35       36
#              ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
    if ($val_ast->[0] == 29) { # we assume max is 2^16 so 5 chars plus a sign = 6 chars
        return ('int',6);
    } elsif ($val_ast->[0] == 30) {
        return ('real',12); # ad hoc, UNSUPPORTED
    } elsif ($val_ast->[0] == 31) {
        return ('bool',1);
    } elsif ($val_ast->[0] == 32) {
        return ('char',1);
    } elsif ($val_ast->[0] == 33) {
        return ('complex',12); # ad hoc, UNSUPPORTED;
    } elsif ($val_ast->[0] == 34) {
        return ('string',length($phs->{$val_ast->[1]}));
    } elsif ($val_ast->[0] == 35) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 36) {
        return length($val_ast->[1].'');
    } elsif ($val_ast->[0] == 2) {
        # assuming this is a variable, return 0 as a sign it needs to be done outside of this function
        return ('SCALAR',0);
    } elsif ($val_ast->[0] == 10) {
        return ('ARRAY',0);
    } elsif ($val_ast->[0] == 1) {
        return ('FUNCTION',0);
    } else {
        return ('EXPR',0);
		# croak("Unsupported arg type for fmt: ".Dumper($val_ast));
    }
} # END of __get_type_len_from_AST

sub __get_len_from_Attr($decl){
    if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
        my $len = $decl->{'Attr'};
        $len=~s/len=//;
        $len=~s/^\(//;
        $len=~s/\)$//;
        return $len;
    } else {
        croak "Decl has no Attr: ".Dumper($decl);
    }
} # END of __get_len_from_Attr

sub  __get_array_index_offset($stref,$f,$var){
    my $decl=getDecl($stref,$f,$var);
    if (exists $decl->{'ConstDim'} and scalar $decl->{'ConstDim'} > 0) {
        if (scalar @{$decl->{'ConstDim'}} == 1) {
            return $decl->{'ConstDim'}[0][0];
        } else {
            croak "Only 1-Dim arrays are supported: ".Dumper($decl);
        }
    }
    elsif (exists $decl->{'Dim'} and scalar $decl->{'Dim'} > 0) {
        if (scalar @{$decl->{'Dim'}} == 1) {
            return $decl->{'Dim'}[0][0];
        } else {
            croak "Only 1-Dim arrays are supported: ".Dumper($decl);
        }
    } else {
        croak "Decl has no Dim: ".Dumper($decl);
    }
} # END of __get_array_index_offset

sub __emit_list_based_print_write($stref,$f,$line,$info,$unit, $advance){
# carp Dumper $info->{'IOCall'}{'Args'}{'AST'};
    my $port = $unit eq 'STDERR' ? '#19' : '#18';
    #
    my $ast =  $info->{'IO'} eq 'print'
        ? $info->{'IOCall'}{'Args'}{'AST'}
        :  [1,'write',[27,[32,'*'],
        ( $info->{'IOList'}{'AST'}[0] == 27
            ? @{ $info->{'IOList'}{'AST'} }[
                1 ..
                scalar  @{ $info->{'IOList'}{'AST'} } - 1
                ]
            : $info->{'IOList'}{'AST'}
        )
        ] ] ;
    my $c_line = '';
    # list-oriented print
    if (ref($ast->[2][1]) eq 'ARRAY' and $ast->[2][1][1] eq '*') {
        my @list_to_print = @{$ast->[2]};
        shift @list_to_print; shift @list_to_print;
        # croak 'WRONG!'.Dumper( $ast,$info,@list_to_print) if $line=~/funktalTokensIdx/;
        $c_line = _emit_list_print_Uxntal($stref,$f,$line,$info,$unit, $advance,\@list_to_print);
        # carp "HERE: $c_line";
	} else {
		my $fmt_ast = $ast->[2][1];
		if ($fmt_ast->[0]==29) {
			error("Unsupported: PRINT with label arg: $line",0,'ERROR');
		}
		my $print_fmt = __analyse_write_call_arg($stref,$f,$info,$fmt_ast,0);
        carp "FMT: $print_fmt";
		my ($print_call_list, $offsets) = __parse_fmt($print_fmt->[1],$stref,$f,$info);
		my $call_arg_list = $ast->[2]; shift @{$call_arg_list};shift @{$call_arg_list};
		if (scalar @{$print_call_list} != scalar @{$call_arg_list}) {
			die Dumper($print_call_list,$call_arg_list);
		}
		$c_line='';
		for my $arg_ast (@{$call_arg_list}) {
			my $print_call = shift @{$print_call_list};
			add_to_used_lib_subs($print_call);
			my ($uxntal_expr,$word_sz) = _emit_expression_Uxntal($arg_ast,$stref, $f, $info);
			$c_line.= $uxntal_expr.' '.$print_call. " #20 $port DEO"."\n";
		}
	}
		$c_line .= " #0a $port DEO" if $advance eq 'yes';
	# if ($unit eq 'STDERR') {
		return $c_line;
	# }
	# else {
	# 	return $c_line . ' #0a #18 DEO'."  ( unit: <$unit> ) ";
	# }

} # END of __emit_list_based_print_write

sub isArray($rec){
        return ($rec->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
}

sub isString($rec){

    my $is_array = $rec->{'ArrayOrScalar'} eq 'Array';
    my $is_string = 0;
    if (not $is_array  and $rec->{'Type'} eq 'character') {
        if ($rec->{'Attr'}=~/len=(.+?)/) {
            my $len = $1;
            $is_string = $len ne '1';
        }
    }
    return $is_string
}

sub getDecl($stref,$f,$var) {
    if ($var !~/^[a-z][_\w]*$/i) {
        # not a variable, return undef
        # even if it is an array or string access, too bad
        return undef;
    }
    my $Sf = exists $stref->{'Modules'}{$f}
        ? $stref->{'Modules'}{$f}
        : $stref->{'Subroutines'}{$f};

    my $subset = in_restricted_nested_set( $Sf, 'Vars', $var ,
    { 'ExGlobArgs' => 1,
        'UndeclaredCommonVars' => 1,
        'DeclaredCommonVars' => 1
    }
    );
    if ($subset eq '') {
        croak "No decl for $var in Vars for $f";
    }
    my $decl = get_var_record_from_set($Sf->{'Vars'},$var);
    my $module_name = exists $decl->{'ModuleName'}
    ? $decl->{'ModuleName'}
    : exists $decl->{'ParentModule'}
    ? $decl->{'ParentModule'}
    : $f;
    # croak "$subset $f $var" if not exists $decl->{'ConstDim'};
    # Module var decl records are copied into the state of the subroutines that use them
    # before constant folding is done. So we need to get the originals instead.
    if( $subset eq 'ModuleVars') {
        # carp Dumper $decl;
        $decl = $stref->{'Modules'}{$module_name}{'ModuleVars'}{'Set'}{$var};
    }
    return $decl;
}
# ----------------------------------------------------------------------------------------------------
sub add_to_C_build_sources($f,$stref ){
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $is_inc = $sub_or_func eq 'IncludeFiles';
    if (not $is_inc ) {
    my $src =  $stref->{$sub_or_func}{$f}{'Source'};
    if ( not exists $stref->{'BuildSources'}{'C'}{$src} ) {
        print "ADDING $src to C BuildSources\n" if $V;
        $stref->{'BuildSources'}{'C'}{$src} = 1;
    }
    } else {
        my $inc=$f;
        if ( not exists $stref->{'BuildSources'}{'H'}{$inc} ) {
            print "ADDING $inc to C Header BuildSources\n" if $V;
            $stref->{'BuildSources'}{'H'}{$inc} = 1;
        }

    }

    return $stref;
} # END of add_to_C_build_sources()

sub __C_array_size($dims){
# carp Dumper $dims;
    my $array_size=1;
    for my $dim (@{$dims}) {
        my $lb=$dim->[0];
        my $ub=$dim->[1];
        my $dim_size = eval("$ub-$lb+1");
        $array_size*=$dim_size;
    }
    return $array_size;
}

sub __is_operator($opcode) {
    return
    (($opcode > 2  and $opcode < 7 ) or
    ($opcode > 14 and $opcode < 27) or
    ($opcode == 13));
}

# ================================================================================================================================================

sub do_passes_recdescent($stref,$f,$pass_sequence,$seen) {

    for my $pass_sub_ref (@{$pass_sequence}) {
        say "PASS ".coderef_to_subname($pass_sub_ref)."($f)" if $V;
        $stref=$pass_sub_ref->($stref, $f);
    }
    say "RECDESCENT for $f" if $V;
    my $pass_recursion_call_tree = sub($annline){
        my ($line, $info) = @{$annline};

        if (exists $info->{'SubroutineCall'}) {
            my $csf = $info->{'SubroutineCall'}{'Name'};
            if (not exists $seen->{$csf}) {
                $seen->{$csf}=1;
            if (not exists $F95_intrinsic_functions{$csf}){
            say "RECURSE info SUB $csf" if $V;
            $stref = do_passes_recdescent($stref,$csf,$pass_sequence,$seen);}
            }
        }
        # I work on the assumption that all $info records that could have function calls, will have FunctionCalls
        if (exists $info->{'FunctionCalls'} and scalar @{$info->{'FunctionCalls'}}>0) {
            my %seen=();
            for my $fcall (@{$info->{'FunctionCalls'}}) {
                my $csf = $fcall->{'Name'};
                if (not exists $seen->{$csf}) {
                    $seen->{$csf}=1;
                    if (not exists $F95_intrinsic_functions{$csf}){
                    say "RECURSE info FUNC $csf" if $V;
                    $stref = do_passes_recdescent($stref,$csf,$pass_sequence,$seen);
                    }
                }
            }
        }
        return [$annline];
    };
    $stref = stateless_pass_inplace( $stref,  $f,  $pass_recursion_call_tree, 'pass_recursion_call_tree');
    return $stref;
} # END of do_passes_recdescent

=pod
# ==== UNUSED SUBROUTINES ====

# Every arg is stored on the stack.
sub _store_arg_on_stack($stref,$f,$arg) {
    my $Sf = $stref->{'Subroutines'}{$f};
    my $short_mode = $Sf->{'WordSizes'}{$arg} == 2 ? '2' : '';
    my $uxntal_code = '';
    if  (is_array_or_string($stref,$f,$arg)) {
        $uxntal_code = __stack_access($stref,$f,$arg)." STA2";
    } else {
        $uxntal_code = __stack_access($stref,$f,$arg)." STA$short_mode";
    }
    return $uxntal_code;
} # END of _store_arg_on_stack()

sub __string_access($stref,$f,$info,$var_name,$ast){
    my $Sf = $stref->{'Subroutines'}{$f};
    my $strn = __create_fq_varname($stref,$f,$var_name);
    # my $decl = get_var_record_from_set($Sf->{'Vars'},$var_name);
    my $decl = getDecl($stref,$f,$var_name);
    my $cb = _emit_expression_Uxntal($ast->[2][1], $stref, $f,$info);
    my $ce = _emit_expression_Uxntal($ast->[2][2], $stref, $f,$info);
    my $id=$info->{'LineID'};
    if($decl->{'Attr'}!~/len/) {
        croak 'String with index>1 but the type is character', Dumper $ast;
    }
    my $len = $decl->{'Attr'};$len=~s/len=//;
    return __gen_substr(';'.$strn, $cb,$ce, $len, $id);
}

sub _change_operators_to_Uxntal($expr){
die 'FIXME!';
my %Uxntal_ops =(
    '+' => 'ADD',
    '-' => 'SUB',
    '*' => 'MUL',
    '/' => 'DIV',
    'eq' => 'EQU',
    'ne' => 'NEQ',
    'le' => '',
    'ge' => '',
    'GTH' => '>',
    'LTH' => '<',
    'not' => '',
    'and' => 'AND',
    'or' => 'ORA',
);
# .not. expr => 1 - expr => #01 expr SUB
# expr >= c => expr c GTHk EQU ORA
# expr <= c => expr c LTHk EQU ORA
while ($expr=~/\.(\w+)\./) {
    $expr=~s/\.(\w+)\./$Uxntal_ops{$1}/;
}
    return $expr;
}


sub _emit_subroutine_return_vals_Uxntal($stref,$f,$info){
    my @sub_retvals_Uxntal=();
    # my $subname = $info->{'SubroutineCall'}{'Name'};
    my $Ssubname = $stref->{'Subroutines'}{$f};

    my $idx=0;

    for my $sig_arg (@{$Ssubname->{'RefactoredArgs'}{'List'}}) {
        $idx++;
        my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};
        my $intent = $rec->{'IODir'};
        my $isArray = $rec->{'ArrayOrScalar'} eq 'Array';
        if (not $isArray  and $rec->{'Type'} eq 'character') {
            if ($rec->{'Attr'}=~/len=(\d+)/) {
                my $len = $1;
                $isArray = $len>1;
            }
        }
        my $wordSz = $rec->{'Type'} eq 'character' ? 1 : 2;
        if ($rec->{'Attr'}=~/kind=(\d+)/) {
            $wordSz = $1;
        }
        $wordSz==1 && do {$wordSz=''};

        if ($intent eq 'out' or $intent eq 'inout') {
            if (not $isArray ) {
                push @sub_retvals_Uxntal, ';'.$f.'_'.$sig_arg.' LDA'.$wordSz. ' ( RETVAL ) ';
            }
        }
    }

    return join("\n", @sub_retvals_Uxntal);
} # END of _emit_subroutine_return_vals_Uxntal

sub __all_bounds_numeric($dims){
    my $all_bounds_numeric=0;
    # no warnings 'numeric';
    for my $dim (@{$dims}) {
        for my $entry (@{$dim}) {
        $all_bounds_numeric ||=  ($entry eq $entry+0) ? 1 : 0;
        }
    }
    return $all_bounds_numeric;
}

sub _gen_array_index_f2c1d_h {
    # open RefactorF4Acc::Translation::Uxntal::DATA or die $!;
    if (not -d $targetdir) {
        mkdir $targetdir;
    }
    open my $fh, '>', $targetdir.'/array_index_f2c1d.h' or die "$! : $targetdir";
    while(my $line = <RefactorF4Acc::Translation::Uxntal::DATA>) {
        print $fh $line;
    }
    close $fh;
    close RefactorF4Acc::Translation::Uxntal::DATA;
} # END of _gen_array_index_f2c1d_h

sub _fold_consts_in_module_decls($stref, $mod_name){

    my $pass_fold_consts_in_module_decls = sub ($annline, $state){
        (my $line,my $info)=@{$annline};
        # say "MOD LINE: <$line>";
        my $c_line=$line;
        (my $stref, my $mod_name, my $pass_state)=@{$state};
        my $skip=1;

        if (exists $info->{'VarDecl'}) {
                my $var = $info->{'VarDecl'}{'Name'};
                say "$mod_name VAR DECL LINE: $c_line";
                $skip=0;
        }
        elsif ( exists $info->{'ParamDecl'} ) {
            croak "SHOULD NOT HAPPEN ParamDecl", Dumper($info);;
            my $var = $info->{'VarDecl'}{'Name'};
        }
        elsif ( exists $info->{'ParsedVarDecl'} ) {
            croak "SHOULD NOT HAPPEN ParsedVarDecl", Dumper($info);

        }
        elsif ( exists $info->{'ParsedParDecl'} ) {
            croak "SHOULD NOT HAPPEN ParsedParDecl", Dumper($info);
        }
        push @{$pass_state->{'TranslatedCode'}},$c_line unless $skip;

        return ([$annline],[]);
    };

    my $state = [];
    ($stref,$state) = stateful_pass_inplace($stref,$mod_name,$pass_fold_consts_in_module_decls , $state,'pass_fold_consts_in_module_decls() ' . __LINE__  ) ;

    return $stref;
} # END of _fold_consts_in_module_decls

# ==== END OF UNUSED SUBROUTINES ====
=cut 

=pod
Scalar:

We have either

;v f -- pass by reference

@f
;&x STA2
Using it
;&x LDA2 LDA
JMP2r
&x $2

or

;v LDA f -- pass by value

@f
;&x STA
Using it
;&x LDA
JMP2r
&x $1

But we could also have:

;v LDA ;w ff
@ff
;&x STA
;&y STA2 -- because it is an Out, stores the address
Using it
;&x LDA
;&y LDA2 STA
JMP2r
&x $1 &y $2

In other words, we can't simply do the access based on scalar or not, we need to consider In/Out/InOut
Arg:
Scalar, In: pass by value
Scalar, Out or InOut: pass by reference
Array or String, In,Out or InOut: pass by reference
Local: not passed

So __var_access needs to distinguish for scalars between In or not In

Furthermore, we need to distinguish between call args of a subroutine and access in the body
In a call arg list, if it is a Scalar Out or InOut or an Array or String, generate the address, no load

__var_access does not actually load anything. So we can actually use it.
So if it is an In, we can use _var_access_read;
otherwise, we can use __var_access


###########################################

emit_expression takes an AST and emits it, so we should as much as possible use _var_access_read.
This is the case for scalar vars, indexing into arrays and strings and "bare" arrays and strings
So what mainly remains are operators and constants,
and function calls.
I should transform all non-pure functions into subroutines first
But it turns out I never implemented that.
Next best thing is to have a variant of _emit_subroutine_call_expr_Uxntal for functions, and we use that when we encounter & in an expression AST
So first step is to rework _emit_subroutine_call_expr_Uxntal

my $maybe_characteristic = exists $info->{'Signature'}{'Characteristic'} ? $info->{'Signature'}{'Characteristic'}.' ' : '';

Question is, if we have a variable that is an InOut, say we simply have

subroutine inc(n)
    integer, intent(InOut) :: n
    n=n+1
end subroutine inc

program test_inc
integer :: nn
nn=1
inc(nn)
print *, nn
end program test_inc

#0001 ;nn STA2 ( _var_access_assign )
;nn inc ( InOut in call, so it should *not* be _var_access_read )
( So maybe I need _var_access_call
)

;n LDA2 LDA2 INC2 ;n LDA2 STA2


=cut

=pod


'|a0 @File &vector $2 &success $2 &stat $2 &delete $1 &append $1 &name $2 &length $2 &read $2 &write $2'

We need at least a

    $Sf->{'FileHandle'}{$src}={
    file =>
    iostat =>
        ...
    }

# Open
    my $fn = $f.'_'.$info->{'FileNameVar'};
    return ;$fn .File/name DEO2"
    $i=1
    open(unit=$src,file=$fn,iostat=$stat,action='read', status='old', recl=1,access='direct',form='unformatted') )
    => ";$fn .File/name DEO2"
    ,stream JSR

# Close
    => '.File/name DEI2k BRK ROT DEO2'

We need a counter for the position, corresponding to $i

# Read

    #0001 .File/length DEO2 ( write 1 to File/length )

What we should do to do this right, is take the length of $cbuf (it can even be a list, TODO) and set this on every read

File/success* will be less than File/length* if the file is shorter, so if lenght==1 it will be 0 on fail, 1 otherwise. So say we do -1 then it will be zero on success and -1 on EOF

$stat is a scalar default INTEGER variable that is assigned a positive value if an error condition occurs, a negative value if an end-of-file or end-of-record condition occurs, and zero
otherwise.

        read(unit=$src,iostat=$stat,rec=$i) $cbuf

        =>
        . "$len .File/length DEO2\n"
        . ";&$cbuf .File/read DEO2\n"
        . ";$i LDA2 INC2 ;$i STA2\n"
        . ".File/success DEI2 #0001 SUB2 ;&$stat STA2";

# Write

For file writes, I think I will only support the following:
    write($src,*) $data
    . "$len .File/length DEO2\n"
    . ";$data .File/write DEO2" ;
=cut
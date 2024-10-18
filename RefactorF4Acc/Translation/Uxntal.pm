=pod TODOS

* Easy
write(0,*) '    token:',getTokenLabel(token),getTokenVal(token), decodeTokenStr(token)
currently becomes
{ 000a 20 " 20 " 20 " 20 "token: } STH2r print-string-stderr #20 #19 DEO ( , )
and should become
{ 000a 20 20 20 20 "token: } STH2r print-string-stderr #20 #19 DEO ( , )

* In progress
cs(ii:ii) =  '"'
currently becomes
{ 0001 " } STH2r .fp LDZ2 #0015 ADD2 #0001 strncpy ( STATIC LEN ) ( COPY SUBSTR )
and should become
{ 0001 22 } STH2r ...

* Hard; but apparently this means that '//' was not parsed as an expression
FunktalDecoders.f90 line 308
cs = "'" // achar(tokenVal) // "'"
currently becomes
{ 001a """ 20 "// 20 "achar(tokenVal) 20 "// 20 " } STH2r .fp LDZ2 #0015 ADD2 #0007 strncpy ( STATIC LEN ) ( COPY SUBSTR )
which is quite WRONG:
the '//' should be a string concatenation
the 'achar' is a function
the quotes should stay single quotes so emit ASCII 27
=cut

package RefactorF4Acc::Translation::Uxntal;

use v5.30;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( min max zip );

use RefactorF4Acc::F95SpecWords qw(
    %F95_intrinsic_functions
    %F95_intrinsic_function_sigs
    %F95_intrinsic_subroutine_sigs
    );

use RefactorF4Acc::Refactoring::Helpers qw(
    stateful_pass
    stateful_pass_inplace
    stateless_pass_inplace
    pass_wrapper_subs_in_module
    get_annotated_sourcelines
    );

use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast );

use RefactorF4Acc::Refactoring::CaseToIf qw( replace_case_by_if );
use RefactorF4Acc::Refactoring::EliminateDeadCode qw( eliminate_if_const_cond );

use RefactorF4Acc::Refactoring::FoldConstants qw( fold_constants_all );

# use RefactorF4Acc::Emitter qw( emit_AnnLines );

use RefactorF4Acc::Translation::UxntalLibHandler qw(
    load_uxntal_lib_subroutines
    add_to_used_lib_subs
    emit_used_uxntal_lib_subroutine_sources
    );

use RefactorF4Acc::Translation::UxntalStaging qw(
    save_global_memory_map_to_file
    load_global_memory_map_from_file
    remove_unwanted_global_allocations_from_memory_map
    );

#
#   (c) 2010-2024 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
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

our $DBG = 0;
#               0    1    2    3      4      5      6      7      8      9   10   11   12   13    14
our @sigils = ('(', '&', '$', 'ADD', 'SUB', 'mul', 'div', 'mod', 'pow', '=', '@', '#', ':' ,'//', ')('
#                15    16      17    18      19     20     21     22     23     24       25       26
               ,'EQU', 'NEQ', 'lt', 'gt', 'lte', 'gte', 'not', 'AND', 'ORA', 'EOR', '.eqv.', '.neqv.'
#                27   28
               ,',', '(/',
# Constants
#                29         30      31         32           33         34             35       36
               ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
              );

# For shorter labels

our $shorten_var_names = 0;
our $omit_comments = 1;
our $branch = 'b';
our $loop = 'l';
our $while_loop = 'w';
our $cond = 'c';
our $end = 'e';
our $substr = 's';
our $fqp = 'fq';
our $fqn_counter = 0;
our %fqns = ();
our %short_names_check = ();

our $Varvara_magic_code = 7188;
=pod Varvara devices
00	system
10	console
20	screen
30	audio
40
50
60
70	Unused
80	controller
90	mouse
a0	file
b0
c0	datetime
d0	Reserved
e0
f0	Unused
=cut

my @uxntal_lib_sources = (
    '../../uxntal-libs/signed-cmp.tal',
    '../../uxntal-libs/signed-mult-div.tal',
    '../../uxntal-libs/fmt-print.tal',
    '../../uxntal-libs/string.tal',
    '../../uxntal-libs/range-map-fold-lib.tal',
    '../../uxntal-libs/process-args-lib.tal',
    '../../uxntal-libs/call-stack.tal',
    '../../uxntal-libs/persist-state.tal',
    '../../uxntal-libs/trim.tal'
);

sub translate_program_to_Uxntal($stref,$program_name){
    # If there is a state file, load it into $funktalState
    # We don't know yet if there is a loadState call in the program
    # If there isn't one, we undo this later using remove_unwanted_global_allocations_from_memory_map
    my $funktalState = load_global_memory_map_from_file();

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
        # For writing
        'WriteFile' => [
        '    |b0 @FileW &vector $2 &success $2 &stat $2 &delete $1 &append $1 &name $2 &length $2 &read $2 &write $2'
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
        'Globals' => $funktalState,
        # { 'Set' =>{}, 'List' => [], 'totalMemUsage' => 0, 'stateCount' => 0 },
        'CallStack'  => [
            '( ~../../../uxntal-libs/call-stack.tal )',
            '|e000 ( 8 kB call stack )',
            '@call-stack ( grows down )'
        ]
    };

    $stref = fold_constants_all($stref) ;

    my $new_annlines = $stref->{'Subroutines'}{$program_name}{'RefactoredCode'};

    $stref->{'TranslatedCode'}=[];
    $Config{'FIXES'}={};

    $stref = do_passes_recdescent($stref,$program_name,
        [
            \&replace_case_by_if,
            \&eliminate_if_const_cond,
            \&translate_sub_to_Uxntal
        ], {}
    );

    # For convenience when debugging
    if ($DBG) {
    add_to_used_lib_subs( 'wst' );
    add_to_used_lib_subs( 'nl' );
    add_to_used_lib_subs( 'ws' );
    }

    if ($stref->{'UseCallStack'} ) {
        add_to_used_lib_subs( 'init-call-stack' );
        add_to_used_lib_subs( 'push-frame' );
        add_to_used_lib_subs( 'pop-frame' );
        add_to_used_lib_subs( 'stack-alloc' );
    }
    my @used_uxntal_lib_subroutine_sources=emit_used_uxntal_lib_subroutine_sources();

    if ( not exists $stref->{'LoadState'} ){
        $stref->{'Uxntal'}{'Globals'} = remove_unwanted_global_allocations_from_memory_map($stref->{'Uxntal'}{'Globals'});
    }

    $stref->{'TranslatedCode'}=[
        '    |00 @System &vector $2 &expansion $2 &wst $1 &rst $1 &metadata $2 &r $2 &g $2 &b $2 &debug $1 &state $1',
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
            : $stref->{'Uxntal'}{'Main'}{'Name'}."\n( #80 .System/state DEO )\n"
        ),
        'BRK','',
        ($stref->{'HasCLArgs'}
            ? '@main '.$stref->{'Uxntal'}{'Main'}{'Name'} . "\n( #80 .System/state DEO )\nBRK"
            : ''
        ),
        ($stref->{'HasCLArgs'} ?  $stref->{'Uxntal'}{'CLIHandling'}{'Lib'} : ''),'',
        @{$stref->{'Uxntal'}{'Main'}{'TranslatedCode'}},
        @{$stref->{'Uxntal'}{'Libraries'}{'List'}},
        @{$stref->{'TranslatedCode'}}, # These are the subroutines
        @used_uxntal_lib_subroutine_sources,
        '( Parameters )',
        @{$stref->{'Uxntal'}{'Macros'}{'List'}},
        # '@nl #0a18 DEO JMP2r',
        '( Module Globals )',
        '@totalMemUsage '.toRawHex($stref->{'Uxntal'}{'Globals'}{'totalMemUsage'},2),
        @{$stref->{'Uxntal'}{'Globals'}{'List'}},
        ($stref->{'UseCallStack'} ? @{$stref->{'Uxntal'}{'CallStack'}} : ()),
       ];
    # This prints out the lines from $stref->{'TranslatedCode'}
    $stref->{'TranslatedCode'} = _remove_redundant_labels($stref->{'TranslatedCode'});
    $stref = _emit_Uxntal_code($stref, $program_name);
    # This enables the postprocessing for custom passes
    # $stref->{'CustomPassPostProcessing'}=1;
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'}={};
    if ( exists $stref->{'SaveState'} ){
        save_global_memory_map_to_file($stref->{'Uxntal'}{'Globals'});
    }
    return $stref;
} # END of translate_program_to_Uxntal

sub translate_sub_to_Uxntal( $stref, $f){
    return $stref if $f eq 'saveState' or $f eq 'loadState';
    # croak $f if $f eq "onFrame";
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
    # $stref = _handle_function_pointers($stref,$f);
    $stref = _pointer_analysis($stref,$f);
    my $Sf = $stref->{'Subroutines'}{$f};

    my $annlines = get_annotated_sourcelines( $stref, $f );

    # This preparatory analysis only looks at args, local vars and local parameters. We need to include globals
    # Or maybe not, as pointer analysis is not necessary for Uxntal.
    # We populate $state->{'Pointers'} and $state->{'WordSizes'} but the latter is not used as
    # $Sf->{'WordSizes'} is populated above via _get_word_sizes()
    # We also check if getarg is called and set CLArgs to 1 if it is
    # And we check if there are any Data declarations, and store those in $Sf->{'Data'}
    my $pass_prep_analysis = sub ($annline,$state){
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
                die "Supported types are integer, character, string and logical: $var in $f is $type\nLINE $line";
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
                die "Supported types are integer, character, string and logical: $var in $f is $type\nLINE $line";
            }
            $state->{'WordSizes'}{$var}=$word_sz;
        }
        elsif (exists $info->{'Data'}) {
            for my $ddef (@{$info->{'DataDefs'}}) {
                $Sf->{'Data'}{$ddef->{'NListAST'}[1]}=1; # rough and ready
            }
        }
        # FIXME: this is because of the presence of an empty $info->{'SubroutineCall'} record.
        elsif (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) {
            my $fname =  $info->{'SubroutineCall'}{'Name'};
            if ( $fname eq 'loadState') {
                $stref->{'HasReadFile'}=1;
                $stref->{'LoadState'}=1;
                add_to_used_lib_subs($fname);
            }
            elsif ($fname eq 'saveState' ) {
                $stref->{'HasWriteFile'}=1;
                $stref->{'SaveState'}=1;
                add_to_used_lib_subs($fname);
            }
            elsif (not exists $F95_intrinsic_functions{$fname} ) {
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
    (my $new_annlines_,$pass_state) = stateful_pass($annlines,$pass_prep_analysis,$pass_state,"pass_prep_analysis($f)");
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
                my $is_sub = (exists($stref->{'Subroutines'}{$var}) ? 1 :0);
                if ( $is_sub) {
                    my $type = 'of unknown type';
                    if (not exists $info->{'VarDecl'}{'Type'} and
                    exists $info->{'ParsedVarDecl'}) {
                        $type = $info->{'ParsedVarDecl'}{'TypeTup'}{'Type'};
                    }

                    # say Dumper $info->{'ParsedVarDecl'};
                    error("Local declaration of var $var ($type) in $f masks a function, this is not allowed in a recursive subroutine", 0,'ERROR_MASK');
                };
                my $is_res_x = (exists($stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}) ? 1: 0);
                my $is_res = $is_res_x ? (($var eq $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}) ? 1: 0) : 0;

                if ((not exists $stref->{'Subroutines'}{$var})
                and ((not exists $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'})
                or ($var ne $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}) )
                ) { # otherwise it is a function
                # say "Stack alloc for $var in $f";
                croak "Stack alloc for $var in $f",$line,Dumper($info) if $f eq 'lookupNamedConstant' and $line=~/isArray/;
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
    local $Data::Dumper::Indent=0;

    my $pass_translate_to_Uxntal = sub ($annline, $state){
        (my $line,my $info)=@{$annline};
        my $c_line= $line eq '' ? '' : "( $line )";
        (my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineID'};
        my $skip=0;
        my $skip_comment=0;
        # say "520 LINE $line ".Dumper($info);
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
                ($omit_comments ? '' : "( ____ $line )"),
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
                    and $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} eq $var)
                    and not exists $Sf->{'Data'}{$var}
                    ) {
                        ($stref,my $uxntal_var_decl, my $alloc_sz) =  _emit_var_decl_Uxntal($stref,$f,$info,$var);
                        if (not exists $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_var_decl}) {
                            $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_var_decl}=$uxntal_var_decl;
                            $skip_comment=1;
                            push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}}, "( ____ $line )" unless $skip_comment;
                            push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}},$uxntal_var_decl;
                            $pass_state = _gen_array_string_inits($stref,$f,$var,$pass_state);

                        } else {
                            croak "Vars should be unique: $uxntal_var_decl";
                        }
                }
            }
            }
            $skip=1;
        }
        elsif (exists $info->{'VarDecl'} and $use_stack ) {
            my $var = $info->{'VarDecl'}{'Name'};
            if (exists $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'}
                    and $stref->{'Subroutines'}{$f}{'Signature'}{'ResultVar'} eq $var) {
                $pass_state = _gen_array_string_inits($stref,$f,$var,$pass_state);
            }
        }
        elsif ( exists $info->{'ParamDecl'} ) {
            # A parameter should become a macro
            my $var = $info->{'ParamDecl'}{'Var'};
            ($stref,my $uxntal_par, my $alloc_sz) = _emit_var_decl_Uxntal($stref,$f,$info,$var);
            if (not exists $stref->{'Uxntal'}{'Macros'}{'Set'}{$uxntal_par}) {
                $stref->{'Uxntal'}{'Macros'}{'Set'}{$uxntal_par}=$uxntal_par;
                push @{$stref->{'Uxntal'}{'Macros'}{'List'}},$uxntal_par;
            } else {
                croak "Macros should be unique: $uxntal_par in $f";
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
                $c_line = '&'.$while_loop.'_'.$f.'_'.$id . "\n" ;
            } else {
                my $do_iterator =  __shorten_fq_name( $f.'_'.$info->{'Do'}{'Iterator'});
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
                'OVR2 OVR2 SUB2 #fff7 GTH2 ;&'.$loop.'_'.$end.'_'.$f.'_'.$id.' JCN2'. "\n" .
                '&'.$loop.'_'.$f.'_'.$id . "\n" .
                ';'.$do_iterator.' STA2 ';
            }
        }
        elsif (exists $info->{'BeginDo'} ) {
            todo( 'BeginDo: what is this?',1);
            $c_line='for () {';
        }

        if (exists $info->{'Assignment'} ) {
            # say "Assignment: $line" if $f eq 'move';
            ($c_line,$pass_state) = _emit_assignment_Uxntal($stref, $f, $info,$pass_state) ;
            if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
                $c_line = _emit_if_without_then_Uxntal($stref,$f,$info,$c_line);
                # my $indent = $info->{'Indent'};
                # my $branch_id = $info->{'LineID'};
                # my $cond_expr_ast=$info->{'Cond'}{'AST'};
                # my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
                # $c_line = "\n$cond_expr #00 EQU ,&$branch$branch_id JCN\n" . $c_line; #$indent.
                # $c_line .= "\n&$branch$branch_id";
            }
        }
        elsif (exists $info->{'Stop'}) {
            # $pass_state->{'Subroutine'}{'HasExitOrStop'} = 1;
            add_to_used_lib_subs('exit');
            # This is laziness: rather than generate the 'stop'
            # we tag an exit call to the end
            $c_line = 'exit';
        }
        elsif (exists $info->{'SubroutineCall'} and not exists $info->{'IOCall'}) {
            # if ($info->{'SubroutineCall'}{'Name'} eq 'exit') {
                # $pass_state->{'Subroutine'}{'HasExitOrStop'} = 1;
                # add_to_used_lib_subs('exit');
            # }
            $c_line = _emit_subroutine_call_expr_Uxntal($stref,$f,$line,$info);
            # If without Then
            if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
                $c_line = _emit_if_without_then_Uxntal($stref,$f,$info,$c_line);
            #     my $indent = $info->{'Indent'};
            #     my $branch_id = $info->{'LineID'};
            #     my $cond_expr_ast=$info->{'Cond'}{'AST'};
            #     my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
            # # What we have is e.g.
            # # if (fl(1:2) == __PH0__) VV = .true.
            # # What we need is
            # # NOT <cond> <label_end> JCN
            #     $c_line = "\n$cond_expr #00 EQU ;&$branch$branch_id JCN2\n" .$c_line;
            #     # $c_line = "\n$cond_expr #00 EQU ;&$branch$branch_id JCN2\n" . $indent.$c_line;
            # # <expr>
            #     # $c_line .= $indent.' '."&$branch$branch_id ( INDENTED BRANCH )";
            #     $c_line .= ' '."&$branch$branch_id";
            }
        }
        elsif (exists $info->{'IOCall'}) {
            if (exists $info->{'PrintCall'}) {
                # say "PRINT: $line";
                # say Dumper $info;
                $c_line = __emit_list_based_print_write($stref,$f,$line,$info, 'STDOUT','yes');
            } elsif (exists $info->{'WriteCall'}) {
                # carp Dumper $info;
                my $call_ast = $info->{'IOCall'}{'Args'}{'AST'};
                my $iolist_ast = $info->{'IOList'}{'AST'};
                todo('check if this is a write to a file!');
                # say 'WRITE: IOCall Args:'.Dumper($call_ast),'IOList:',Dumper($iolist_ast);
                # say "WRITE: $line";
                my ($print_calls, $offsets, $unit, $advance,$other_attrs) = _analyse_write_call($stref,$f,$info);
                if (scalar @{$print_calls} == 1) {
                    if (
                        $print_calls->[0] eq 'print-list' or
                        $print_calls->[0] eq 'print-list-stderr'
                    ) {
                    # add_to_used_lib_subs($print_calls->[0]);
                    $c_line = __emit_list_based_print_write($stref,$f,$line,$info, $unit,$advance);
                    # say "UXNTAL SINGLE WRITE: $c_line $advance";
                     } elsif ($print_calls->[0] eq 'device-write') {
                        my $unitvar_decl = getDecl($stref,$f,$unit);
                        if (exists $unitvar_decl->{'Val'}) {
                            my $unitvar_val = $unitvar_decl->{'Val'};
                            $unitvar_val =~s/_2$//;
                            my $dev_id = $unitvar_val - $Varvara_magic_code;
                            if ($dev_id >= 0 and $dev_id < 16 ) {
                                # A Varvara call
                                my $recvar = $info->{'RecVar'};
                                my $recvar_decl = getDecl($stref,$f,$recvar);
                                if (exists $recvar_decl->{'Val'}) {
                                    my $recvar_val = $recvar_decl->{'Val'};
                                    $recvar_val =~s/_[12]$//;
                                    my $rec_Uxntal = toHex($recvar_val+$dev_id*16,1);
                                    my ($uxntal_expr_str,$word_sz) = _emit_expression_Uxntal($iolist_ast,$stref,$f,$info);
                                    my $short_mode = $word_sz == 2? '2' : '';
                                    $c_line =  "$uxntal_expr_str $rec_Uxntal DEO$short_mode";
                                    # what we want is <addr> DEI<word_sz>  STA<wordsz>
                                } else {
                                    error("REC must be a parameter: $recvar");
                                }
                            } else {
                                error("WRITE to unit $unit not supported");
                            }
                        }
                     }
                } else {
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
                # open(Screen, file='Screen', access='direct',recl=2)
                my $unit= $info->{'UnitVar'};
                if (exists $info->{'FileNameVar'}){
                    my $fn = __create_fq_varname($stref,$f,$info->{'FileNameVar'});
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
                } else { # Assuming the FileName is a string constant. If this is for Varvara devices that are NOT the file device, we do nothing
                    my $unitvar_decl = getDecl($stref,$f,$unit);

                    # die "READ is only supported with a character buffer\n$line:\n".Dumper($unitvar_decl,$recvar_decl,$decl);
                    if (exists $unitvar_decl->{'Val'}) {
                        my $unitvar_val = $unitvar_decl->{'Val'};
                        $unitvar_val =~s/_2$//;
                        my $dev_id = $unitvar_val - $Varvara_magic_code;
                        if ($dev_id < 0 or $dev_id >= 16 or $dev_id==10) { # 10 is the file device
                            error("OPEN for unit $unit ($dev_id) with constant string as file name is not yet supported");
                        } else {
                            $skip=1; # A Varvara device,
                        }
                    }
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
                if ($decl->{'Type'} eq 'character') {
                    if (exists $decl->{'Attr'} and $decl->{'Attr'}=~/len/) {
                        $len=$decl->{'Attr'}; $len=~s/^\(len=//;$len=~s/\)$//;
                    } else {
                        $len=1;
                    }

                    my $uxntal_len = toHex($len,2);
                    my $fq_cbuf = __create_fq_varname($stref,$f,$cbuf);
                    my $iostat = __create_fq_varname($stref,$f,$info->{'IOStat'});
                    $c_line = "$uxntal_len .File/length DEO2\n"
                    . ";$fq_cbuf .File/read DEO2\n"
                    . ";$rec LDA2 INC2 ;$rec STA2\n"
                    . ".File/success DEI2 #0001 SUB2 ;$iostat STA2";
                } else {
                    # If the READ call has a unit of $Varvara_magic_code then it's a Varvara call
                    my $unitvar = $info->{'UnitVar'};
                    my $unitvar_decl = getDecl($stref,$f,$unitvar);

                    # die "READ is only supported with a character buffer\n$line:\n".Dumper($unitvar_decl,$recvar_decl,$decl);
                    if (exists $unitvar_decl->{'Val'}) {
                        my $unitvar_val = $unitvar_decl->{'Val'};
                        $unitvar_val =~s/_2$//;
                        my $dev_id = $unitvar_val - $Varvara_magic_code;
                        if ($dev_id >= 0 and $dev_id < 16 ) {
                            # A Varvara call
                            my $recvar = $info->{'RecVar'};
                            my $recvar_decl = getDecl($stref,$f,$recvar);
                            if (exists $recvar_decl->{'Val'}) {
                                 my $recvar_val = $recvar_decl->{'Val'};
                                $recvar_val =~s/_[12]$//;
                                my $rec_Uxntal = toHex($recvar_val+ $dev_id*16,1);
                                my $word_sz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$cbuf};
                                my $short_mode = $word_sz == 2? '2' : '';
                                my $lhs_var_Uxntal =  __var_access($stref,$f,$cbuf);
                                $c_line =  "$rec_Uxntal DEI$short_mode $lhs_var_Uxntal STA$short_mode";
                                # what we want is <addr> DEI<word_sz>  STA<wordsz>
                            } else {
                                error("REC must be a parameter: $recvar");
                            }
                        } else {
                            error("READ on unit $unitvar not supported");
                        }
                    }
                }
            } else {
                todo( 'IOCall '.Dumper( $info->{'IOCall'}{'Args'}{'AST'})."\nIOList ".Dumper($info->{'IOList'}{'AST'}),1);
            }
            if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
                $c_line = _emit_if_without_then_Uxntal($stref,$f,$info,$c_line);
            }
        }
        elsif (exists $info->{'If'} and not exists $info->{'IfThen'} ) {
            if (exists $info->{'Goto'}) {
                $c_line = ';&'.__shorten_fq_name($f.'_'.$info->{'Goto'}{'Label'}).' JMP2';
            }
            elsif (exists $info->{'Exit'}) {
                $c_line = ';&'.__shorten_fq_name($f.'_'.$info->{'Exit'}{'ConstructName'}).' JMP2';
            }
            else {
                croak "If without Then, not assignment, goto or call: $line";
            }
            my $indent = $info->{'Indent'};
            my $branch_id = $info->{'LineID'};
            my $cond_expr_ast=$info->{'Cond'}{'AST'};
            my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
            $c_line = ' '."$cond_expr #00 EQU ;&$branch$branch_id JCN2\n" . $c_line;
            $c_line .= ' '."&$branch$branch_id"; #$indent.
        }
        elsif (exists $info->{'IfThen'} and not exists $info->{'ElseIf'} ) {
            # carp 'COND AST:',Dumper $info->{'Cond'}{'AST'};
            # say "EX-CASE: $line => If IfId = $id" if $f eq 'decodeTokenStr';
            $pass_state->{'IfBranchId'} = $id;
            push @{$pass_state->{'IfStack'}},$id;
            $pass_state->{'IfId'}=$id;
            push @{$pass_state->{'BranchStack'}},$id;
            ($c_line, my $skip_branch) = _emit_ifthen_Uxntal($stref, $f, $info, $id);
            # if ($pass_state->{'SkipBranch'}[0]==0){
            #     $pass_state->{'SkipBranch'}=[$skip_branch,$id];
            # }
            # say 'IF:',Dumper $pass_state->{'SkipBranch'};
        } elsif (exists $info->{'ElseIf'} ) {

            # say "EX-CASE: $line => ElseIf IfId=$id" if $f eq 'decodeTokenStr';
            ($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
            # if ($pass_state->{'IfId'} == $pass_state->{'SkipBranch'}[1]){
            #     if ($pass_state->{'SkipBranch'}[0]==1) {
            #         $pass_state->{'SkipBranch'}[0]=0;
            #         $c_line = "( $c_line ) ( ELSE IF: SKIP 1 ) ";
            #     }
            #     elsif ($pass_state->{'SkipBranch'}[0]==2) {
            #         $pass_state->{'SkipBranch'}[0]=3;
            #         $c_line = "( $c_line ) ( ELSE IF: SKIP 2 ) ";
            #     }
            # }
            # say 'ELSE of ELSE IF:',Dumper $pass_state->{'SkipBranch'},$branch_id,$pass_state->{'IfStack'},$pass_state->{'IfId'};
            my ($c_line_if, $skip_branch) = _emit_ifthen_Uxntal($stref, $f, $info, $branch_id);
            $c_line .= $c_line_if;
            push @{$pass_state->{'BranchStack'}},$branch_id;
            # $pass_state->{'SkipBranch'}=[$skip_branch,$pass_state->{'IfId'}];
            # say 'IF of ELSE IF:',Dumper $pass_state->{'SkipBranch'};
        } elsif (exists $info->{'Else'} ) {
            ($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
            # if ($pass_state->{'IfId'} == $pass_state->{'SkipBranch'}[1]){
            #     if ($pass_state->{'SkipBranch'}[0]==1) {
            #         $pass_state->{'SkipBranch'}[0]=0;
            #         $c_line = "( $c_line ) ( ELSE: SKIP 1 ) ";
            #         }
            #     elsif ($pass_state->{'SkipBranch'}[0]==2) {
            #         $pass_state->{'SkipBranch'}[0]=3;
            #         $c_line = "( $c_line ) ( ELSE: SKIP 2 ) ";
            #         }
            # }
            # say 'ELSE:',Dumper $pass_state->{'SkipBranch'},$branch_id,$pass_state->{'IfStack'},$pass_state->{'IfId'},$pass_state->{'BranchStack'};
            # say "EX-CASE: $line => Else IfId=$id" if $f eq 'decodeTokenStr';
            $c_line .= "&$branch$branch_id";
            push @{$pass_state->{'BranchStack'}},$branch_id;
        } elsif (exists $info->{'EndIf'} ) {
            my $branch_id = pop @{$pass_state->{'BranchStack'}};
            # if ($branch_id == $pass_state->{'SkipBranch'}[1]){
            #     if ($pass_state->{'SkipBranch'}[0]==3) {$pass_state->{'SkipBranch'}[0]=4}
            # }
            # say 'END IF:',Dumper $pass_state->{'SkipBranch'},$pass_state->{'BranchStack'},$pass_state->{'IfId'};
            my $if_id = $pass_state->{'IfId'};
            $c_line = ';&'.$cond.'_'.$end.$if_id.' JMP2 '."\n"
            .'&'.$branch.$branch_id.'_'.$end."\n".' &'.$cond.'_'.$end.$if_id;
            pop @{$pass_state->{'IfStack'}};
            $pass_state->{'IfId'}=$pass_state->{'IfStack'}[-1];
        }
        elsif ( exists $info->{'EndDo'} ) {
                my $do_tup = pop @{$pass_state->{'DoStack'}};
                if ($do_tup->[-1] eq 'Do') {
                    # croak Dumper $f,$annline,$do_tup;
                    my ($do_id, $do_iter, $do_step) = @{$do_tup};
                    my $inc = $do_step == 1 ? 'INC2' : toHex($do_step,2). ($do_step>0 ? ' ADD2' : ' SUB2');
                    my $dec = $do_step == 1 ? '#0001 SUB2' : toHex($do_step,2). ($do_step<0 ? ' ADD2' : ' SUB2');
                    # This says, INC and then compare, if it is not equal, loop again
                    # But fortran says compare then INC
                    $c_line = ";$do_iter LDA2 $inc OVR2 OVR2 NEQ2 ".';&'.$loop.'_'.$f.'_'.$do_id.' JCN2 '."\n;$do_iter LDA2 $inc ;$do_iter STA2\n".
                    '&'.$loop.'_'.$end.'_'.$f."_$do_id POP2 POP2\n";
                } else { # while
                    my ($do_id, $do_while_cond) = @{$do_tup};
                    ($c_line,my $word_sz) =  _emit_expression_Uxntal($do_while_cond,$stref, $f, $info);
                    $c_line .= "\n".';&'.$while_loop.'_'.$f.'_'.$do_id.' JCN2';
                }
                if ( exists $info->{'EndDo'}{'ConstructName'} ) {
                    $c_line .= "\n".'&'.__shorten_fq_name($f.'_'.$info->{'EndDo'}{'ConstructName'})
                }
        }
        elsif ( exists $info->{'EndProgram'} ) {
            # carp '<',$pass_state->{'Subroutine'}{'IsMain'} ,'>';
            $info->{'Indent'} = '' ;
            $c_line = $use_stack ? '!pop-frame' : 'POP2r';
            if (  $pass_state->{'Subroutine'}{'IsMain'} ne '' ) {
                $c_line .= ' exit ' ; # I'd rather not have this if it is already there, but it's just a few redundant bytes
            }
            $c_line .= ' BRK ( MAIN ) ' ;
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
            if ($omit_comments) {
                $skip=1;
            } else {
                $c_line = '( '.$line.' )';
            }
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
            $c_line = ';&'.__shorten_fq_name($f.'_'.$info->{'Goto'}{'Label'}).' JMP2';
        }
        elsif (exists $info->{'Exit'}) {
            $c_line = ';&'.__shorten_fq_name($f.'_'.$info->{'Exit'}{'ConstructName'}).' JMP2';
        }
        elsif (exists $info->{'Continue'}) {
            $c_line='( continue )';
        }
        elsif (exists $info->{'Common'}) {
            $c_line='';
        }
        if (exists $info->{'Label'} ) {
            $c_line='&'.__shorten_fq_name( $f.'_'.$info->{'Label'}). "\n".$c_line;
            # if (not exists $info->{'Continue'}) { die "Labels can only occur on `continue` lines: $line => $c_line\n"; }
        }
        if (exists $info->{'Data'} ) {
            for my $def (@{$info->{'DataDefs'}}) {
                my $nlist = $def->{'NListAST'}[1];
                my $fq_nlist = __create_fq_varname($stref,$f,$nlist );
                my $word_sz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$nlist};
                my $clist_Uxntal;
                if ($def->{'CListAST'}[0] == 27) {
                    shift @{$def->{'CListAST'}};
                    $clist_Uxntal = join(' ', map { toRawHex($_->[1],$word_sz) } @{$def->{'CListAST'}});
                } else {
                    todo( "DATA to Uxntal, case 2",1);
                }
                # (my $clist,my $word_sz) = _emit_expression_Uxntal( $def->{'CListAST'},$stref,$f,$info);
                $c_line = '@'.$fq_nlist.' '.$clist_Uxntal;
                push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}},$c_line;
                $skip=1;
            }
        }
        chomp $c_line;
        $skip_comment=1;
        push @{$pass_state->{'Subroutine'}{'TranslatedCode'}},"( ____ $line )" unless $skip_comment or $line=~/^\s*$/;
        # say "LINE $line: ", Dumper $pass_state->{'SkipBranch'};
        # if ($pass_state->{'SkipBranch'}[0] == 1 or $pass_state->{'SkipBranch'}[0] == 3
        # or $pass_state->{'SkipBranch'}[0] == 4){
        #     if ($pass_state->{'SkipBranch'}[0] == 4) {
        #         $pass_state->{'SkipBranch'}[0] = 0;
        #     }
        #     # $skip=1;
        #     say "SKIPPING BRANCH CODE: $line => $c_line";
        #     $c_line = " ( $c_line ) ( SKIP BRANCH $line ) ";
        # } else {
        #     $c_line = "$c_line ( KEEP $line ) ";
        # }
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
            'HasExitOrStop' => 0,
            'TranslatedCode'=>[],
            'ArgDecls'=>[],
            'ArrayStringInits'=>[],
            'LocalVars'=> {'Set' =>{}, 'List' => [] },
            # 'LocalVarDecls' =>[],
            # 'DoIterators' => {'Set' =>{}, 'List' => [] },
            'ReadArgs' => [],
            'Sig' => '',
        },
        'IfStack'=>[],'IfId' =>0,
        'BranchStack'=>[],'IfBranchId' =>0,
        # 'SkipBranch' => [0,0],
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
        @{$sub_uxntal_code->{'ArrayStringInits'}},
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

} # END of translate_sub_to_Uxntal

sub _handle_function_pointers($stref,$f) {
    my $Sf = $stref->{'Subroutines'}{$f};

    for my $var (@{$Sf->{'AllVarsAndPars'}{'List'}}) {
        next if $var =~/__PH\d+__/; # FIXME: hack!
        if (exists $stref->{'Subroutines'}{$var}) {
            if (exists $stref->{'Subroutines'}{$var}{'Pointee'}) {
                my $pointed_sub = $stref->{'Subroutines'}{$var}{'Pointee'};
                $stref = translate_sub_to_Uxntal($stref,$pointed_sub)
            }
        }
    }
    return $stref;
}
sub _get_word_sizes($stref,$f){
    my $Sf = $stref->{'Subroutines'}{$f};

    for my $var (@{$Sf->{'AllVarsAndPars'}{'List'}}) {
        next if $var =~/__PH\d+__/; # FIXME: hack!
        # my $subset = in_nested_set($Sf,'Vars',$var);
        # if ($subset eq '') {
        #     croak "$f $var";
        # }
        # my $decl = get_var_record_from_set($Sf->{$subset},$var);
        my $decl = getDecl($stref,$f,$var);
        my $word_sz=0;
        my $type = $decl->{'Type'};
        # croak "$f: VAR? ".Dumper($var,$decl) if $var eq 'Assignment';
        if ($type eq 'integer') {
            my $kind = $decl->{'Attr'};
            $kind=~s/kind\s*=\s*//;
            $kind=~s/^\s*\(\s*//;
            $kind=~s/\s*\)\s*$//;
            if( $kind eq '' ) { # ignore this for 'kind' as it is not a var, usually
                if ($var ne 'kind'){
                    warn "default kind for $var in $f";
                    $kind=4;
                } else {
                    $kind=2;
                }
            } else {
                $kind*=1;
            }
            if ($kind>2 and $var ne 'kind') { # ignore this for 'kind' as it is not a var, usually
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
            die "Supported types are integer, character, string and logical: $var in $f is $type\nLINE ??";
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
#     If the var is locally declared (and therefore allocated) we do a string copy
#     If the var is an arg, we simply copy the address
# an assignment of a string var to another string var (no indexing)
#     if it is a local, we do a string copy
#     if it is an arg, it's by reference
# an assignment of a array var to another array
#    if it is an arg, it's by reference
#    if it is a local, we do an array copy I think
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
    if (not defined $word_sz) {
        croak "NO WORD SIZE for $var in $f";
    }
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
                # What would it take to support this?
                # It makes little sense on its own.
                # Either it is an assignment or an argument of some call
                # An assignment would be a memcpy
                # An argument of a call would depend on the call
                # It could be a pointer offset
            } elsif ($idx_expr_type == 0) {
                # the array or string itself, likely as argument to a function
                $uxntal_code =  "$var_access";
                $word_sz = 2; # because this is an address
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
            if (exists $stref->{'Subroutines'}{$var}) {
                if (exists $stref->{'Subroutines'}{$var}{'Pointee'}) {
                    $var_access = ';'.$stref->{'Subroutines'}{$var}{'Pointee'};
                    # croak "VAR $var is a subroutine pointer to $var_access";
                    # Means we need to emit $stref->{'Subroutines'}{$var}{'Pointee'}
                    # $stref = translate_sub_to_Uxntal( $stref, $stref->{'Subroutines'}{$var}{'Pointee'});
                }
                $uxntal_code =  $var_access;
            } else {
                $uxntal_code =  "$var_access LDA$short_mode";
            }
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

    my ($lhs_var,$idxs,$idx_expr_type) = __unpack_var_access_ast($lhs_ast);
    my $Sf = $stref->{'Subroutines'}{$f};
    my $word_sz= $Sf->{'WordSizes'}{$lhs_var};
    my $short_mode = $word_sz == 2 ? '2' : '';
    my $uxntal_code = '';
    # my $use_stack = __use_stack($stref,$f);
    my $lhs_var_access = __var_access($stref,$f,$lhs_var);
    if  (is_array($stref,$f,$lhs_var)) {
        if  ($idx_expr_type == 1) { # array(i) = rhs_expr
            my $lhs_idx_offset = __get_array_index_offset($stref,$f,$lhs_var);
            my $lhs_idx_offset_Uxntal =  toHex($lhs_idx_offset,2);
            my $lhs_idx_offset_expr = $lhs_idx_offset==0? '' : $lhs_idx_offset_Uxntal.' SUB2';
            my ($rhs_expr_Uxntal, $rhs_word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
            if ($rhs_word_sz!=$word_sz){
                croak "LHS and RHS word sizes don't match: $word_sz <> $rhs_word_sz for assignment to $lhs_var in $f";
            }
            my ($idx,$idx_word_sz) = _emit_expression_Uxntal($idxs,$stref,$f,$info);
            my $idx_expr = defined $idx ? ($idx eq $lhs_idx_offset_Uxntal) ? '' : "$idx $lhs_idx_offset_expr".( $short_mode ? ' #0002 MUL2 ': '') .' ADD2 ' : '';
            $uxntal_code = "$rhs_expr_Uxntal  $lhs_var_access $idx_expr STA$short_mode"; # index, load the value
        } elsif  ($idx_expr_type == 3) { # array(i,j) = rhs_expr
            # multi-dim arrays, in principle this should work for 1, 2, 3 and even more dimensions
            my ($rhs_expr_Uxntal, $rhs_word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
            if ($rhs_word_sz!=$word_sz){
                croak "LHS and RHS word sizes don't match: $word_sz <> $rhs_word_sz for assignment to $lhs_var in $f";
            }
            my $lhs_idx_offsets_dims = __get_array_index_offsets_dims($stref,$f,$lhs_var);
            # The index expressions are $idxs, which will start with a comma.
            my @index_asts = @{$idxs};
            shift @index_asts;
            # my $n_dims = scalar @index_asts;
            # if ($n_dims>2) {
            #     error("Only 1_D and 2-D arrays are supported: $lhs_var in $f is $n_dims-D");
            # }
            my $idx_exprs_Uxntal=[];
            for my $index_ast (@index_asts) {
                my ($idx_expr_Uxntal, $idx_word_sz) = _emit_expression_Uxntal($index_ast,$stref,$f,$info);
                push @{$idx_exprs_Uxntal},$idx_expr_Uxntal;
            }
            my $lin_idx_Uxntal_expr = _multi_dim_array_access_to_Uxntal($idx_exprs_Uxntal,$lhs_idx_offsets_dims, $stref,$f,$info);
            my $idx_expr = $lin_idx_Uxntal_expr.( $short_mode ? ' #0002 MUL2 ': '');
            $uxntal_code = "$rhs_expr_Uxntal  $lhs_var_access $idx_expr STA$short_mode"; # index, load the value

            # If we ignore slices, all we need is the correct indexing:
            # array(i,j) => array + (i-i_offset) +(j-j_offset)*i_sz
        } elsif  ($idx_expr_type == 0) { # array = rhs_expr
            my $decl = getDecl($stref,$f,$lhs_var);
            # It looks like ModuleVars are *copied* per function, not linked.
            # So I need to get the actual decl from the module
            my $dim = exists $decl->{'ConstDim'}
                ? __array_size($decl->{'ConstDim'})
                : __array_size($decl->{'Dim'});
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
                # my $decl = get_var_record_from_set($Sf->{'Vars'},$lhs_var);
                my $decl = getDecl($stref,$f,$lhs_var);
                if (is_character($stref,$f,$lhs_var) ) { # Array of characters
                # If so, we set every elt to that string
                    my $dim = exists $decl->{'ConstDim'}
                        ? __array_size($decl->{'ConstDim'})
                        : __array_size($decl->{'Dim'});
                    # my $dim =  __array_size($decl->{'Dim'});
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
                } elsif (is_string($stref,$f,$lhs_var) ) { # Array of strings
                    todo( 'ASSIGNMENT TO ARRAY OF STRINGS',1);
                } else {
                    error("RHS is string, LHS is array");
                }
            } elsif ($rhs_ast->[0] >= 29) { # the RHS is a constant
                if ($rhs_ast->[0]==29) { # integer, check type and kind of LHS.
                    my $mkind = is_integer($stref,$f,$lhs_var);
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
                    todo('ASSIGNMENT TO ARRAY OF LOGICALS',1);
                    # integer, check type and kind of LHS.
                    if ( is_logical($stref,$f,$lhs_var) ) {
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
                elsif ($rhs_ast->[0] ==32) { # character constant, I think this is unused
                    # croak "CHARACTER assignment to ARRAY ".Dumper($lhs_ast,$rhs_ast);
                    (my $char_expr_Uxntal,my $rhs_word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
                    my $ref = \$rhs_ast; $ref=~s/REF...//;$ref=~s/\)//;
                    my $iter="iter$ref";
            # The range must be the original Fortran one: we correct for the offset in the var access
                    my $idx_offset = __get_array_index_offset($stref,$f,$lhs_var);
                    my $idx_offset_Uxntal =  toHex($idx_offset,2);
                    my $idx_offset_expr = $idx_offset==0
                        ? ''
                            : $idx_offset==1
                                ? 'INC2'
                                : $idx_offset_Uxntal.' ADD2';

                    # transforming the array into an index access mighr be best
                    my $decl = getDecl($stref,$f,$lhs_var);
                    # carp Dumper($decl);
                    my $array_length = exists $decl->{'ConstDim'}
                    ? __array_size($decl->{'ConstDim'})
                    : __array_size($decl->{'Dim'});
                    # my $elt_iter = [10,$elt->[1],[36,'LIT2 &'.$iter.' $2']];
                    # my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt_iter,$stref, $f, $info);
                    # my $elt_0 = [10,$elt->[1],[29,'0']];
                    # my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt_0);
                    $uxntal_code = '{ ( iter ) '.$char_expr_Uxntal.' ROT ROT '.$lhs_var_access.' ADD2 STA  JMP2r } STH2r '.toHex($array_length-1,2)." #0000 range-map-short ( assign char to array )";
                    # croak $uxntal_code ;
                }
                else {
                    error('Only integer and logical are supported on the RHS of an array assignment');
                }
            } elsif ($rhs_ast->[0] == 32) {
                todo("_var_access_assign($f): character constant",1);
            } elsif ($rhs_ast->[0] == 1) {
                # A function call, need to check the type
                # LHS is an array. Need to check the type.
                # Then get the type of the function as in _emit_print_from_ast
                my $fname =  $rhs_ast->[1];
                my $rhs_type = exists $F95_intrinsic_function_sigs{$fname}
                ? $F95_intrinsic_function_sigs{$fname}[-1]
                : $stref->{'Subroutines'}{$fname}{'Signature'}{'ReturnType'};
                my $rhs_type_attr = $stref->{'Subroutines'}{$fname}{'Signature'}{'ReturnTypeAttr'} // '';
                if ($rhs_type eq 'character(*)' ) {
                    $rhs_type = 'character';
                    $rhs_type_attr ='(*)';
                }
                my $lhs_var_decl = getDecl($stref,$f,$lhs_var);
                my $lhs_type = $lhs_var_decl->{'Type'};
                # I am assuming that the RHS can only return a scalar
                # So LHS is an array of T and RHS is T
                # So we simply assign the RHS to the first elt of the LHS

                my $dim = exists $lhs_var_decl->{'ConstDim'}
                    ? __array_size($lhs_var_decl->{'ConstDim'})
                    : __array_size($lhs_var_decl->{'Dim'});
                # my $array_length = $dim;
                my ($rhs_expr_Uxntal, $word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
                if ($word_sz==1) { # byte array
                    $uxntal_code = "{ ( iter ) $rhs_expr_Uxntal ROT ROT $lhs_var_access ADD2 STA JMP2r } STH2r ".toHex($dim-1,2).' #0000 range-map-short';
                } else {
                    todo("_var_access_assign($f): " . Dumper($lhs_type,$rhs_type,$rhs_type_attr,$rhs_expr_Uxntal,$lhs_var_access,$rhs_ast),1);
                }
            } else {
                my ($rhs_var,$rhs_idxs,$rhs_idx_expr_type) = __unpack_var_access_ast($rhs_ast);
                my $rhs_var_access = __var_access($stref,$f,$rhs_var);
                if (is_array($stref,$f,$rhs_var)) { # RHS is a full, unindexed array
                    # if the rhs is also an array we need an array copy
                    # This is a range-map
                    if ($rhs_idx_expr_type==0) {
                        $uxntal_code = "{ ( iter ) ".
                            ( $word_sz==2 ? '#0002 MUL2' : '')
                            ." DUP2 $rhs_var_access ADD2 LDA$short_mode " .
                            ( $short_mode eq '2' ? 'SWP2' : 'ROT ROT' ). ' '
                            . "$lhs_var_access ADD2 STA$short_mode JMP2r } STH2r ".
                            toHex($array_length-1,2)
                            . ' #0000 range-map-short ( ARRAY COPY ) ';
                            add_to_used_lib_subs('range-map-short');
                    } elsif ($rhs_idx_expr_type==2) { # RHS is a slice

                        my ($rhs_idx_expr_b,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs->[1], $stref, $f,$info);
                        (my $rhs_idx_expr_e,$idx_word_sz) = _emit_expression_Uxntal($rhs_idxs->[2], $stref, $f,$info);
                        my $rhs_len = __calc_len($rhs_idx_expr_b,$rhs_idx_expr_e);
                        $uxntal_code = "{ ( iter ) ".
                            ( $word_sz==2 ? '#0002 MUL2' : '')
                            ." DUP2 $rhs_var_access ADD2 $rhs_idx_expr_b ADD2 LDA$short_mode " .
                            ( $short_mode eq '2' ? 'SWP2' : 'ROT ROT' ). ' '
                            . "$lhs_var_access ADD2
                            STA$short_mode JMP2r } STH2r $rhs_len ".
                            toHex($array_length-1,2). ' min '
                            . ' #0000 range-map-short ( ARRAY SLICE COPY ) ';
                            add_to_used_lib_subs('range-map-short');
                            add_to_used_lib_subs('min');
                    } else {
                    # if not, it is an error
                        error("LHS is an array but RHS isn't");
                    }
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
    } elsif  (is_string($stref,$f,$lhs_var) ) {
        $uxntal_code =  __copy_substr($stref, $f, $info, $lhs_ast, $rhs_ast)
    } else { # v = <anything not a string>
    # carp Dumper($rhs_ast) if $f eq 'calcNumConst';
        my ($rhs_expr_Uxntal, $word_sz) = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
        $uxntal_code = "$rhs_expr_Uxntal $lhs_var_access STA$short_mode ( scalar )";
    }
    return $uxntal_code;
} # END of _var_access_assign()

sub __is_write_arg($stref,$f,$var) {
    # my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var) ;
    my $decl = getDecl($stref,$f,$var);
    my $iodir = exists $decl->{'IODir'} ? $decl->{'IODir'} : 'Unknown';
    my $uxntal_write_arg = ($iodir eq 'out' or $iodir eq 'inout') ? 1 : 0 ;
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
    # croak("<$var>",$uxntal_write_arg,is_arg($stref,$f,$var)) if $var eq 'context' and $f eq 'updateContext';
    return
        (
            $use_stack
            ? __stack_access($stref,$f,$var)
            : ';'. __create_fq_varname($stref,$f,$var)
        )
        .
        (
            (is_arg($stref,$f,$var) and (is_array_or_string($stref,$f,$var) or $uxntal_write_arg))
            ? ' LDA2 ' # passed by reference
            : '' # not passed
        );
} # END of __var_access

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
                    for my $idx_ast (@{$idxs}[1 .. scalar @{$idxs} -1 ] ) {
                        # my $idx_ast = $idxs->[$ii];
                        if ($idx_ast->[0] == 12) {
                            error('Multi-dimensional arrays with slices are not supported: '.emit_expr_from_ast($ast),0,'ERROR_UNSUPPORTED');
                        }
                    }
                }
            } else {
                error('Invalid array access: '.emit_expr_from_ast($ast),0,'ERROR_INVALID');
            }
        } elsif ($ast->[0] == 2) {
            if (scalar @{$ast} != 2) {
                error('Invalid scalar access: '.emit_expr_from_ast($ast),0,'ERROR_INVALID');
            }
        } else {
            error('Variable being accessed must be an array or scalar: '.emit_expr_from_ast($ast),0,'ERROR_INVALID');
        }
        return ($var,$idxs,$idx_expr_type);
    } else {
        croak Dumper($ast);
        error('AST must be a list: '.Dumper($ast),0,'ERROR_INVALID');
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

    my $lhs_var_decl = getDecl($stref,$f,$lhs_var);
    # if it's allocatable, we need to set the length to that of the RHS
    my $lhs_is_allocatable = is_allocatable($lhs_var_decl);
    # from to len strncpy => from to from to len strncpy => from to => from LDA2 to STA2
    my $set_LHS_str_len_part_1 = $lhs_is_allocatable ? ' OVR2 OVR2' : '';
    my $set_LHS_str_len_part_2 = $lhs_is_allocatable ? ' SWP2 LDA2 SWP2 STA2' : '';
    if ($rhs_ast->[0] == 34 or $rhs_ast->[0] == 1 or $rhs_ast->[0] == 13) {
        # string literal
        # or function returning a string or char,
        # or concat //
        my $lhs_var_access = __var_access($stref,$f,$lhs_var);
        my $rhs_Uxntal_expr = '';
        if ($rhs_ast->[0] == 1 or $rhs_ast->[0] == 13) {
            ($rhs_Uxntal_expr, my $rhs_word_sz) = _emit_expression_Uxntal($rhs_ast, $stref, $f,$info)
        } elsif ($rhs_ast->[0] == 34) {
            $rhs_Uxntal_expr = __substitute_PlaceHolders_Uxntal($rhs_ast->[1],$info,0) # 0 means always as string
        } else {
            croak "PROBLEM: ".Dumper($rhs_ast);
        }
        if ($lhs_idx_expr_type == 2) { # slice on LHS, literal or function call on RHS
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
                my $lhs_idx_expr =  ($lhs_idx_expr_b eq '#0001') ? '#0002' : "$lhs_idx_expr_b INC2 ";
                $uxntal_code = "$rhs_Uxntal_expr #0002 ADD2 LDA $lhs_var_access $lhs_idx_expr ADD2 STA ( WV20240723: WRONG? ) ";
            } else { # It is not possible to tell at compile time if these are compatible.
                # So to avoid overwriting, we use the LHS slice
                $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access $lhs_idx_expr_b #0001 SUB2 ADD2 ( WV20240723: WRONG? ) ".
                __calc_len($lhs_idx_expr_e, $lhs_idx_expr_b).' strncpy';
                add_to_used_lib_subs('strncpy');
            }
        } else { # This is either a character assignment or a string copy
            # The LHS is str= (idx_expr_type = 0) or array(i)= (idx_expr_type = 1); the latter means an array of characters
            # <string-literal> ;lhs_str <$len> strncpy
            # we need the length of LHS and RHS.
            my $decl = getDecl($stref,$f,$lhs_var);
            if($decl->{'Attr'}!~/len/) {
                # a single character; we assume len=1 means a string of length 1
                $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access STA";
            } else {
                # Problem is that the RHS can be an expression
                # Something like str // "str" // fstr()
                todo('This becomes rather complicated so I will only deal with constant strings');
# So if we have str trim, then trim can't return anything meaningful; if we have str ladjust, it should return the length of the arg.
# In fact, if we have trim on the RHS, this should be a special case. Probably same for any function returning an allocatable string
# trimmed_str to_str trimmed_str_len to_str_len min
                my $lhs_len = __get_len_from_Attr($decl);
                my $rhs_len = $rhs_ast->[0] == 34
                    ? length($info->{'PlaceHolders'}{$rhs_ast->[1]})-2 # -2 for the quotes
                    : $rhs_ast->[0] == 1
                        ? __get_len_from_RetVal($stref,$rhs_ast->[1])
                        : $lhs_len; # a hack, TODO, it means we need to get the length of all strings being concatenated
                todo('we need to get the length of all strings being concatenated');
                # # This works only if there is only one function call
                # if (exists $info->{'FunctionCalls'} and
                # scalar @{$info->{'FunctionCalls'}}==1) {
                #     my $fname = $info->{'FunctionCalls'}[0]{'Name'};
                #     $rhs_len = $stref->{'Subroutines'}{$fname}{'RefactoredCode'}[0][1]{'Signature'}{'ReturnTypeAttr'};
                #     $rhs_len = __get_val_str_from_len_Attr($rhs_len);
                # }
                # if ($rhs_len == -1) { $rhs_len = 64; }
                if ($rhs_len == -2) {
                    # Means the RHS is actually a character
                    $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access #0002 ADD2 STA";
                    if ($lhs_is_allocatable) {
                        $uxntal_code .= " $lhs_var_access #0001 STA2";
                    }
                    $uxntal_code .=  ' ( COPY CHAR ) ';
                } elsif ($rhs_len == -1) {
                    # This means we should get the length and calc the min at run time
                    my $lhs_Uxntal_len = toHex($lhs_len,2);
                    $uxntal_code = "$rhs_Uxntal_expr $lhs_var_access $set_LHS_str_len_part_1 OVR2 LDA2 $lhs_Uxntal_len min strncpy $set_LHS_str_len_part_2 ( DYNAMIC LEN )";
                    add_to_used_lib_subs('min');
                } else {
                    my $len = toHex(min($lhs_len,$rhs_len),2);
                    $uxntal_code = $len eq '#0000'
                    ? "{ 0000 } STH2r $lhs_var_access $set_LHS_str_len_part_1 #0000 strncpy $set_LHS_str_len_part_2"
                    : "$rhs_Uxntal_expr $lhs_var_access $set_LHS_str_len_part_1 $len strncpy $set_LHS_str_len_part_2 ( STATIC LEN )";
                }
                add_to_used_lib_subs('strncpy');
            }
        }
    } else { # RHS is not a literal or expression
        my ($rhs_var,$rhs_idxs,$rhs_idx_expr_type) = __unpack_var_access_ast($rhs_ast);
        my $lhs_var_access = __var_access($stref,$f,$lhs_var);
        my $rhs_var_access = __var_access($stref,$f,$rhs_var);
        if ($lhs_idx_expr_type == 2 and $rhs_idx_expr_type == 2) {
            # LHS and RHS both are slices
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
                $uxntal_code = "$rhs_var_access $rhs_idx_expr_b #0001 SUB2 ADD2 $lhs_var_access $lhs_idx_expr_b #0001 SUB2 ADD2 ( WRONG? ) $set_LHS_str_len_part_1 ".
                __calc_len($lhs_idx_expr_e,$lhs_idx_expr_b). ' strncpy '.$set_LHS_str_len_part_2;
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
                $uxntal_code = "$rhs_var_access $lhs_var_access $lhs_idx_expr_b #0001 SUB2 ADD2 ( WV20240723: WRONG? ) $set_LHS_str_len_part_1 ".
                __calc_len($lhs_idx_expr_e, $lhs_idx_expr_b).' strncpy '.$set_LHS_str_len_part_2;
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
                todo( 'Function on RHS of strncpy: '. Dumper($sig),1);
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
                $uxntal_code = "$rhs_var_access $rhs_idx_expr_b ADD2 $lhs_var_access $set_LHS_str_len_part_1 ".
                __calc_len($rhs_idx_expr_e, $rhs_idx_expr_b)." $lhs_var_access LDA2 min strncpy $set_LHS_str_len_part_2  ( 0/2 )";
                add_to_used_lib_subs('min');
                add_to_used_lib_subs('strncpy');
            }
        } elsif ($lhs_idx_expr_type == 0 and $rhs_idx_expr_type == 0) { # no indexing on either side
            # s_lhs = s_rhs
            # I am assuming the LHS is a string
            # The RHS could be a char or a string
            if ($rhs_ast->[0] == 2 and is_string($stref,$f,$rhs_var) ) {
                # if a string, copy as much of the RHS into the LHS as will fit
                $uxntal_code = "$rhs_var_access $lhs_var_access $set_LHS_str_len_part_1 $rhs_var_access LDA2 $lhs_var_access LDA2 min strncpy $set_LHS_str_len_part_2";
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
            # Special case: RHS is array index expression.
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
                todo( 'Array of strings',1);
            }

        } else {
            # say $lhs_idx_expr_type,$rhs_idx_expr_type ;
            error("Unsupported index expression in __copy_substr($f) : $lhs_idx_expr_type , $rhs_idx_expr_type ".Dumper($lhs_ast,$rhs_ast),0,'ERROR');
        }
    }
    return $uxntal_code.' ( COPY SUBSTR )';

} # END of __copy_substr

sub __get_len_from_RetVal($stref,$fname) {
    if (exists $F95_intrinsic_function_sigs{$fname}) {
        if ($F95_intrinsic_function_sigs{$fname}[-1] eq 'character(*)') {
            # easiest is to do this dynamically
            return -1
        }
        elsif ($F95_intrinsic_function_sigs{$fname}[-1] eq 'character') {
            return -2; # a character, not a 1-character string. This would be achar, char
        }
        else {
            croak "Intrinsic function $fname does not return a character or a string";
        }
    } else {
        my $sig = $stref->{'Subroutines'}{$fname}{'Signature'};
        if (not exists $sig->{'ReturnType'}) {
            carp $fname,Dumper $sig;
            return -1; # means handle separately
        }
        if ($sig->{'ReturnType'} eq 'character') {
            if (exists $sig->{'ReturnTypeAttr'} and $sig->{'ReturnTypeAttr'} ne '' ) {
                my $len = $sig->{'ReturnTypeAttr'};
                $len=~s/^\(len=//;$len=~s/\)$//;
                if ($len eq ':' or $len eq '*') {
                    # error("Function $fname should not return an allocatable or assumed-size string");
                    warning("Function $fname should not returns an ".($len eq ':' ? 'allocatable' : 'assumed-size')." string",2);
                    return -1; # means handle separately
                }
                return $len;
            } else {
                croak "Function $fname should returns a character, not a string";
                return -2; # for a character
            }
        } else {
            error("Function $fname should return a string");
        }
    }
}

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
    croak $f ,$var, is_array_or_string($stref,$f,$var) if $var eq 'isArray' and $f eq 'lookupNamedConstant';
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
                # my $dim =  __array_size($decl->{'Dim'});
                my $dim = exists $decl->{'ConstDim'}
                    ? __array_size($decl->{'ConstDim'})
                    : __array_size($decl->{'Dim'}) ;
                $nbytes= $dim*$word_sz+2; # 2 bytes for size field
                my $init_array = toHex($dim,2).' .fp LDZ2 '.toHex($offset,2). ' ADD2 STA2' ."\n";
                $init_array.= __create_array_zeroing(
                    '.fp LDZ2 '.toHex($offset,2). ' ADD2',
                    $dim,
                    $word_sz
                );
                $array_string_init=$init_array;
            }
            elsif (is_string($stref,$f,$var)) {
                my $len = __get_len_from_Attr($decl);
                $nbytes = $len+2; # 2 bytes for the len field
                my $init_string = toHex($len,2).' .fp LDZ2 '.toHex($offset,2). ' ADD2 STA2'."\n";
                $init_string.= __create_string_zeroing(
                    '.fp LDZ2 '.toHex($offset,2). ' ADD2',
                    $len
                );
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

    my $subset = in_restricted_nested_set( $Sf, 'Vars', $var_name ,
    {   'ExGlobArgs' => 1,
        'UndeclaredCommonVars' => 1,
        'DeclaredCommonVars' => 1,
        'ModuleVars' => 1,
        'ModuleParameters' =>1
    }
    );
    if ($subset ) {
        return __shorten_fq_name($fq_varname);
    }
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
                ($stref, my $global_var_decl, my $alloc_sz)= _emit_var_decl_Uxntal($stref,$mod_name,$info,$var_name);
                # HACKY!
                if ( $global_var_decl=~/JMP2r/) { # this is a parameter, should go in Macros }
                    if (not exists $stref->{'Uxntal'}{'Macros'}{'Set'}{$fq_varname}) {
                        $stref->{'Uxntal'}{'Macros'}{'Set'}{$fq_varname} = $fq_varname;
                        push @{$stref->{'Uxntal'}{'Macros'}{'List'}},$global_var_decl ;
                    }
                } else {
                    my $start_address = $stref->{'Uxntal'}{'Globals'}{'totalMemUsage'}+2;
                    $stref->{'Uxntal'}{'Globals'}{'totalMemUsage'}+=$alloc_sz;
                    # say "GLOB: $fq_varname $alloc_sz ".$stref->{'Uxntal'}{'Globals'}{'totalMemUsage'};
                    push @{$stref->{'Uxntal'}{'Globals'}{'List'}},$global_var_decl .' ( '.toRawHex($start_address,2).' ) ';
                }
            } else {
                # say "ALREADY ALLOCATED: $fq_varname";
                $stref->{'Uxntal'}{'Globals'}{'Set'}{$fq_varname} = 1;
            }
        }
    }

    return __shorten_fq_name($fq_varname);
} # END of __create_fq_varname

# The problem with this is that it does not work with staging:
# There is no guarantee that the variables occur in the same order.
# So instead, we need a hashing mechanism
# We could hash to a hex string of 4 chars, that should be enough
# Suppose we roll our own
# Sum 8 bytes into a short, turn into a hex, concatenate
# I think I should check for collisions and throw an error if there is any
sub __shorten_hash($fq_varname){
    $fq_varname=~s/unktal//;
    my $hexconcat=0;

    for my $i ( 0 .. (length($fq_varname) >>3)) {
        my $chunk = substr($fq_varname,$i*8,8);
        next if $chunk eq '';
        my @bytes  = split('',$chunk);
        my $bytesum=0;my $bytexor=256;
        my $ii=1;
        for my $byte (@bytes) {
            $bytesum = $bytesum + ord($byte)*$ii;
            $ii++;
        }
        $hexconcat = $hexconcat . sprintf("%x",$bytesum);#^ $bytesum;
    }
    if (exists $short_names_check{$hexconcat}) {
        error("Short name for $fq_varname collides with that for " . $short_names_check{$hexconcat} .', only fix is to rename one of them',0,'ERROR_COLLISION');
    } else {
        $short_names_check{$hexconcat} = $fq_varname;
    }
    return $hexconcat;
}

sub __shorten_fq_name ($fq_varname) {
    # Somehow BROKEN, probably because I missed some
    if ($shorten_var_names){
        if (not exists $fqns{$fq_varname}) {
            my $short_name = 'fq' . __shorten_hash($fq_varname);
            # "$fqp$fqn_counter";
            $fqns{$fq_varname} = $short_name;
            $fq_varname = $short_name;
            # $fqn_counter++;
        } else {
            $fq_varname = $fqns{$fq_varname}
        }
    }
    return $fq_varname;
}
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
                die "Supported types are integer, character, string and logical: $var in $f is $type\nLINE: $line   ";
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
                    ($stref,my $uxntal_res_decl,my $alloc_sz) = _emit_var_decl_Uxntal ($stref,$f,$info,$result_var);
                    unshift @{$uxntal_arg_decls},$uxntal_res_decl;
                } else {
                    unshift @{$uxntal_arg_decls},$uxntal_arg_decl;
                }
            }
        }

        my $rline = '@'.$name;
        my $isMain = 0;
        if (exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'}==1
        ) {
            $isMain = 1;
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
    # carp Dumper($f,$arg, $word_sz, $isArrayOrString);
    my $short_mode = __nBytes($word_sz, $isArrayOrString) == 1 ? '' : '2';
    # croak "$f $arg: $word_sz != $uxntal_size" if $word_sz != $uxntal_size;
    my $uxntal_write_arg = $iodir eq 'out' or $iodir eq 'inout' ? 1 : 0 ;
    my $fq_name = __shorten_fq_name($name.'_'.$arg);
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
    # What this means is that a call to a function that is used as an arg should have a strncpy
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
    my $initial_value = $decl->{'InitialValue'} // '';
    # croak Dumper $initial_value if $var eq 'dvdIcn';
    my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;

    my $const = '';
    my $val='';
    my $alloc_sz=0;
    if (defined $decl->{'Parameter'}) {
		# carp "VAL: ".Dumper($decl);
        $val = $decl->{'Val'};
        my $val_str = $val;
        if ($val=~/[\'\"'](.+?)[\'\"]/) {
            my $str = $1;
            $val_str = '"'.$str;
            $alloc_sz=length($str)
        }
        elsif ($val=~/^\d+(?:_[1248])?$/) {
			# carp 'HERE';
            my $sz=2;
            if ($val=~s/_([1248])$//) { $sz=$1}
            $val_str = toHex($val,$sz);
            $alloc_sz=2;
        }
        elsif (exists $decl->{'AST'}) {
            my $ast = $decl->{'AST'};
            ($val_str,$alloc_sz) = _emit_expression_Uxntal($ast,$stref, $f, $info);
        } else {
            croak "ParsedParDecl without AST, FIXME!";
        }
        # Define parameter as macro
        # my $par_decl_str = '%'.$f.'_'.$var.' { '. $val_str .' }';
        # Better: define parameter as function
        my $fq_parname = __create_fq_varname($stref,$f,$var);
        my $par_decl_str = '@'.$fq_parname.' '. $val_str .' JMP2r';
        return ($stref,$par_decl_str,$alloc_sz);
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
                ? __array_size($decl->{'ConstDim'})
                : __array_size($decl->{'Dim'})
            : 1;
        my $ftype = $decl->{'Type'};
        my $strlen=0;
        if ($ftype eq 'character') {
            if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
                $strlen = __get_len_from_Attr( $decl);
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
        my $fq_varname = __create_fq_varname($stref,$f,$var);
        if (($ftype eq 'character') and ($strlen >1)) {
            my $len = toRawHex($strlen,2);
            my $padding = $len;
            $padding =~s/^0+//;
            my $c_var_decl = '@'.$fq_varname.' '.$len.' $'. $padding;
            return ($stref,$c_var_decl,$padding);
        } else {
            my $c_var_decl = '@'.$fq_varname.' ';
            # $initial_value = '';
            if (ref($initial_value) eq 'ARRAY') {
                my $word_sz = $Sf->{'WordSizes'}{$var};
                my $clist_Uxntal;
                if ($initial_value->[0] == 27) {
                    shift @{$initial_value};
                    $clist_Uxntal = join(' ', map { toRawHex($_->[1],$word_sz) } @{$initial_value});
                    $c_var_decl.=$clist_Uxntal;
                } else {
                    todo( "Initial value is array but not comma-sep list",1);
                }
            }
            elsif ($initial_value eq '') {
                my $padding = toRawHex($sz*$dim,2);
                $padding =~s/^0+//;
                $c_var_decl.='$'. $padding;
                $alloc_sz=$sz*$dim;
            } else {
                if ($initial_value =~/^\d+/ ) {
                    $initial_value =~s/\_[1248]\s*$//;
                    my $hex_val = toRawHex($initial_value,$sz);
                    $c_var_decl .= "$hex_val " x $dim;
                    # my $padding = toRawHex($sz*$dim,2);
                    # $padding =~s/^0+//;
                    # $c_var_decl.='$'. $padding;
                    $alloc_sz=$sz*$dim;
                } elsif ($initial_value eq '.true.') {
                    $c_var_decl .= '01 ' x $dim;
                    $alloc_sz=$dim;
                } elsif ($initial_value eq '.false.') {
                    $c_var_decl .= '00 ' x $dim;
                    $alloc_sz=$dim;
                } elsif ($initial_value =~/achar\(\s*(\w+)\s*\)/) {
                    my $val = $1;
                    my $hex_val = toRawHex($val,1);
                    $c_var_decl .= "$hex_val " x $dim;
                    $alloc_sz=$dim;
                } else {
                    my $initParDecl = getDecl($stref,$f,$initial_value);
                    if (defined $initParDecl and exists $initParDecl->{'Val'}) {
                        my $hex_val = toRawHex($initParDecl->{'Val'},$sz);
                        $alloc_sz=$sz;
                        $c_var_decl .= "$hex_val ";
                        # croak $c_var_decl;
                    } else {
                        croak "Unsupported initial value: $initial_value for $var ".Dumper($initParDecl);
                    }
                }
                # say "DECL: $initial_value => $c_var_decl";
            }
            return ($stref,$c_var_decl,$alloc_sz);
        }
    }
} # END of _emit_var_decl_Uxntal


sub _emit_assignment_Uxntal ($stref, $f, $info, $pass_state){
    my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};
    my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
    my $rline = _var_access_assign($stref,$f,$info,$lhs_ast,$rhs_ast);
    return ($rline,$pass_state);
} # END of _emit_assignment_Uxntal

sub _emit_if_without_then_Uxntal($stref,$f,$info,$c_line) {
    my $cc_line = $c_line;
    my $indent = $info->{'Indent'};
    my $branch_id = $info->{'LineID'};
    my $cond_expr_ast=$info->{'Cond'}{'AST'};
    my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
    if ($cond_expr eq '#00') { # so we have if 0==0 jump to end, which means we skip the statement entirely
        return '( Skipped statement because IF cond is always false )';
    } elsif ($cond_expr =~/^\#/) { # a num constant but not zero
        return '( IF cond is always true, removed )'."\n".$cc_line;
    } else {
        # I don't think that an if without then could ever be more than 256 bytes.
        # But I can't be sure so why take chances
        todo('Calculate the bytes and decide based on that.');
        my $rel_ok=0;
        if ($rel_ok) {
            $cc_line = "\n$cond_expr #00 EQU ,&$branch$branch_id JCN\n" . $cc_line;
        } else {
            $cc_line = "\n$cond_expr #00 EQU ;&$branch$branch_id JCN2\n" . $cc_line;
        }
        $cc_line .= "\n&$branch$branch_id";
    }
    return $cc_line;
}

sub _emit_ifthen_Uxntal ($stref, $f, $info, $branch_id){
    my $cond_expr_ast=$info->{'Cond'}{'AST'};
    my ($cond_expr,$word_sz) = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
    my $cond_is_const = __eval_Uxntal_cond_expr($cond_expr); # returns [bool, bool] where the first bool says const or not, the second if the const is true or false
    todo('If we want to do this right, we should actually skip the block entirely. We need some state for this.');
=pod
What we need is some state that says $skip_branch = 0 (do nothing) | 1 (top) | 2 (bottom)
# right at the end
if ($pass_state->{'SkipBranch'}==1 or $pass_state->{'SkipBranch'}==3) {skip all lines}

if (exists 'IfThen') { returns $pass_state->{'SkipBranch'} }
if (exists $info->{'Else'}) {
    if ($pass_state->{'SkipBranch'}==1) {$pass_state->{'SkipBranch'}=0}
    elsif ($pass_state->{'SkipBranch'}==2) {$pass_state->{'SkipBranch'}=3}
}
if (exists $info->{'EndIf'}) {
    if ($pass_state->{'SkipBranch'}==3) {$pass_state->{'SkipBranch'}=0}
}

=cut
# croak "<$cond_expr> => ",Dumper $cond_is_const;
    my $rline = "$cond_expr ;&$branch$branch_id JCN2\n" .
                ";&$branch${branch_id}_$end JMP2\n" .
                "&$branch$branch_id";
    if ( not $cond_is_const->[0] ) {
        return ($rline,0);
    } elsif ($cond_is_const->[1]) { # const and true, so always do the top branch
        # my $rline = "$cond_expr ;&$branch$branch_id JCN2\n" .
        #             ";&$branch${branch_id}_$end JMP2\n" .
        #         "&$branch$branch_id";
        # return '';
        return ($rline,2);
    } else { # const and false, so always skip the top branch
        # todo( 'IF-THEN const and false, so always skip the top branch',1);
        return ($rline,1);
    }
}

# returns [bool, bool] where the first bool says const or not, the second if the const is true or false
sub __eval_Uxntal_cond_expr($cond_expr) {
    todo( 'IF-THEN __eval_Uxntal_cond_expr',);
    if ($cond_expr=~/^\#(\d+)/) {
        my $val=hex($1);
        if ($val==0) {
            return [1,0];
        } else {
            return [1,1];
        }
    } else {
        return [0,0];
    }
}
sub _emit_ifbranch_end_Uxntal ($id, $state){
    # my $branch_id = $state->{'IfBranchId'};
    my $branch_id = pop @{$state->{'BranchStack'}};
    my $if_id = $state->{'IfId'};
    my $r_line = ';&'.$cond.'_'.$end.$if_id." JMP2 \n";
    $r_line .= "&$branch${branch_id}_$end\n";
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
            if ($name eq 'int' ) { # just remove it
                # [1,'int',[',', $arg, $sz]]
                # For 'char' this means we ignore the 'kind' and assume ASCII
                my $word_sz = 2;
                if ($args->[0] == 27) {
                    if ($args->[2][0]==9) {
                        $word_sz=$args->[2][2][1];
                    }
                    elsif ($args->[2][0]==29) {
                        $word_sz=$args->[2][1];
                    }
                }

                my $uxn_ast = $args->[0] == 27  ? $args->[1] : $args;
                (my $uxntal_expr, my $word_sz_expr) =  _emit_expression_Uxntal($uxn_ast, $stref, $f,$info);
                # carp $word_sz.' => '.$uxntal_expr. ' '.$word_sz_expr;
                if ($word_sz==2) {
                    if ($word_sz_expr==2) {
                        return ($uxntal_expr,2);
                    } elsif ($word_sz_expr==1) { # byte to short
                        return ($uxntal_expr .' #00 SWP ',2);
                    } else {
                        croak "Unsupported kind=$word_sz_expr in int() for $uxntal_expr";
                    }
                }
                elsif ($word_sz==1) {
                    if ($word_sz_expr == 2  and $uxntal_expr !~/^\#\w{2}$/ ) {
                        # short to byte
                        return ($uxntal_expr. ' NIP ',1);
                    } else {
                        return ($uxntal_expr,1);
                    }
                }
                else {
                    croak "Unsupported kind=$word_sz in int() for $uxntal_expr";
                }
            }
            elsif ( $name eq 'achar' or $name eq 'char') { # just remove it
                # For 'char' this means we ignore the 'kind' and assume ASCII
                my $uxn_ast = $args->[0] == 27  ? $args->[1] : $args;
                (my $uxntal_expr, my $word_sz) =  _emit_expression_Uxntal($uxn_ast, $stref, $f,$info);
                # If the expression is an integer literal, I need to reduce it
                return ($uxntal_expr.( $word_sz ==2 ?' NIP ':''),1);
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
                    todo( "ishft works only with shorts",1) if $word_sz==1;
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
            elsif ($opcode == 32 ) {
                if (length($exp)==3 and ord(substr($exp,0,0))==0 and ord(substr($exp,0,1))==39 and ord(substr($exp,0,2))==39) {
                    return ('#00',1);
                } else {
                    croak "<$exp> ",length($exp),ord(substr($exp,0,0)), ord(substr($exp,0,1)) , ord(substr($exp,0,2));
                    return ('LIT "'.$exp,1);
                }
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
                    if ($v =~/^\#(\w{2,4})$/) {
                        my $mv = toHex(-hex($1),$word_sz);
                        return ($mv,$word_sz);
                    } else {
                        return ('#'.('00' x $word_sz)." $v SUB$short_mode",$word_sz);
                    }
                } else {
                    return ($v, $word_sz);
                }
            }
            (my $opcode, my $lexp, my $rexp) =@{$ast};
            # Uxn does not have pow or mod so these are library functions
            if ($opcode == 8) { # eq '^' pow
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
                    error( "Kinds for arguments to ".$sigils[$opcode]." must be the identical: $l_word_sz <> $r_word_sz for ".emit_expr_from_ast($ast)." in $f",0,'ERROR_KIND_MISMATCH');
                }
                my $short_mode =  $l_word_sz == 2 ? '2' : '';
                # Because LTH and GTH are for unsigned ints, we need special functions for the inequalities
                if ($opcode >= 17 and $opcode <= 20) { # <, >, <= or >=
                    add_to_used_lib_subs($sigils[$opcode].$short_mode);
                }
                elsif ($opcode == 5 or $opcode == 6) {
                    add_to_used_lib_subs($sigils[$opcode].$short_mode);
                }

                    # if ($opcode == 19 or $opcode == 20) { # FIXME I guess?
                #     $short_mode = 2;
                # }
                my $word_sz = ($opcode >=15 && $opcode<=26) ? 1 : $l_word_sz;

                # Ideally, the _emit_expression_Uxntal should return the word size of the expression
                return ("$lv $rv  ". $sigils[$opcode].$short_mode, $word_sz ); # FIXME, needs refining
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
        elsif ($opcode==0) { # parens, just remove it
            return _emit_expression_Uxntal($ast->[1], $stref, $f, $info);
        } else{
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
    my $orig_str = $expr_str;
    if ($expr_str=~/__PH/ and exists $info->{'PlaceHolders'}) {
        # croak $expr_str.Dumper($info->{'PlaceHolders'})
        # We probably want to refrain from prepending the opening quote
        # until we have replaced all quotes
        while ($expr_str =~ /(__PH\d+__)/) {
            my $ph=$1;
            my $ph_str = $info->{'PlaceHolders'}{$ph};
            # say "PH STR<$ph_str>";# if $ph_str=~/\"\'\"/;
            $ph_str=~s/[\'\"]$//; # remove closing quotes
            $ph_str=~s/^[\']/\"/; # make opening quote " FIXME: not OK for "'" ?
            $expr_str=~s/$ph/$ph_str/;
        }
        my $str_len = length($expr_str)-1;
        if ($str_len > 127 ) {
            error('Maximum string length is 96 characters',0,'ERROR_INVALID');
        }
        my $len_Uxntal = toRawHex($str_len,2);
        # say "EXPR STR:<$expr_str>" if $len_Uxntal eq '0033';
        if ($len_Uxntal eq '0001' and $expr_str eq '""') {
            $expr_str = '{ 0001 22 }';
        }
        elsif ($len_Uxntal eq '0001' and $isChar) {
            # croak $expr_str,' => ',substr($expr_str,1,1),' => ',ord(substr($expr_str,1,1)) if $expr_str=~/\)/;
            $expr_str = toHex(ord(substr($expr_str,1,1)),1);
        # } elsif ($len_Uxntal eq '0001' and $expr_str eq '""') {
        #     $expr_str = "{ $len_Uxntal 22 } STH2r";
        # } elsif ( $expr_str =~/\"\(\s/ ) {
        #     $expr_str =~s/\"\(\s/28 20/;
        #     $expr_str = "{ $len_Uxntal $expr_str } STH2r";
        # } elsif ( $expr_str =~/\"\($/ ) {
        #     $expr_str =~s/\"\(/28/;
        #     $expr_str = "{ $len_Uxntal $expr_str } STH2r";
        # } elsif ( $expr_str =~/\"\)\s/ ) { croak "<$expr_str>";
        #     $expr_str =~s/\"\)\s/29 20/;
        #     $expr_str = "{ $len_Uxntal $expr_str } STH2r";
        # } elsif ( $expr_str =~/\"\)/ ) { croak "<$expr_str>";
        #     $expr_str =~s/\"\)/29/;
        #     $expr_str = "{ $len_Uxntal $expr_str } STH2r";
        } elsif ($len_Uxntal eq '0000') { # empty string is a string!
            $expr_str = '#00'; #"{ 0000 } STH2r"; #  '#00'; #
        } else {
            # replace double quote as character by its ascii code. FIXME
            # replace space and nl by their ascii code
            # ' ' => ' 20 "'
            # $expr_str =~s/\s+\"\s+/ 22 /g;
            # croak "<$len_Uxntal> <$expr_str>" if  $expr_str=~/\"\s/;
            $expr_str =~s/\s/ 20 \"/g;
            $expr_str =~s/20\s+\"\s+/20 /g;
            $expr_str =~s/\n/ 0a \"/g;
            $expr_str =~s/\"\s*$//;
            $expr_str =~s/^\"\s+//; # remove opening quote if first char was \s or \n
            # double quote followed by space should be removed
            $expr_str =~s/\s+\"\s+/ /g;
            # say "EXPR STR 2:<$expr_str>" if $len_Uxntal eq '0033';
# croak "<$len_Uxntal> <$expr_str>" if  $expr_str=~/20\s*20\s*20\s*20\s+\"token:/;
#FIXME: this should not split in the middle of a hex code!
            if ($str_len > 48 ) {
                my $nchars = 49;
                my $i = $nchars-1;
                while ($i>0 and substr($expr_str,$i,1) ne ' ') {
                    --$i;
                }
                $nchars = $i==0? 49:$i+1;
                my $str_part_1 = substr($expr_str,0,$nchars);
                my $str_part_2 = substr($expr_str,$nchars);
                $str_part_2 =~s/^\s+\"?//;
                if ($str_part_2 !~/^\"/) {
                    $str_part_2 = ' "'.$str_part_2 ;
                } else {
                    $str_part_2 = ' '.$str_part_2 ;
                }
                $expr_str = $str_part_1 . $str_part_2;
            }
            # say "EXPR STR 3:<$expr_str>" if $len_Uxntal eq '0033';
            # croak "<$expr_str> from <$orig_str>, ".Dumper($info->{'PlaceHolders'}) if $expr_str =~/reconstructTypeNameExpr:/;
            $expr_str = "{ $len_Uxntal $expr_str } STH2r";
        }
    }

    my @chunks_chars_to_ascii=();
    my @chunks = split(/\s+/,$expr_str);
    for my $chunk (@chunks) {
        if (substr($chunk,0,1) eq '"' and length($chunk)==2) {
            my $chunk_ascii = toRawHex(ord(substr($chunk,1,1)),1);
            push @chunks_chars_to_ascii, $chunk_ascii;
        } else {
            push @chunks_chars_to_ascii, $chunk;
        }
    }
    $expr_str = join(' ',@chunks_chars_to_ascii);
    # if  ($expr_str=~/Binder\ 20/) {
    #     die "FINAL EXPR<$expr_str>";
    # } else {
    #     say "FINAL EXPR<$expr_str>";
    # }
    return $expr_str;
} # END of __substitute_PlaceHolders


#### #### #### #### END OF C TRANSLATION CODE #### #### #### ####

sub _emit_subroutine_call_expr_Uxntal($stref,$f,$line,$info){
    my @call_arg_expr_strs_Uxntal=();
    my $subname = $info->{'SubroutineCall'}{'Name'};
    # This is only for local subroutines, so handle the others here
    if (exists $info->{'SubroutineCall'}{'IsExternal'}) {
        if ($subname eq 'exit' or $subname eq 'stop') { # I might change this so that exit() actually exits
        croak 'FIXME: I think stop is not handled like a call' if $subname eq 'stop';
            add_to_used_lib_subs('exit');
            return 'exit BRK';
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
            todo('This could be e.g. str(ib:ie), in which case it is a substring');
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
    my $short_mode=''; # We need this for generic intrinsics
    if (exists $F95_intrinsic_function_sigs{$subname}) {
        # my $intent = 'in';
        # So if it is an integer, we assume it is kind=2
        my $is_generic = 0;
        if ($F95_intrinsic_function_sigs{$subname}[-1] eq 'logical'
        or $F95_intrinsic_function_sigs{$subname}[-1] eq 'character') {
            $word_sz=1;
        }
        elsif ($F95_intrinsic_function_sigs{$subname}[-1] eq 'a') {
            $is_generic=1;
        }

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
                and not $F95_intrinsic_function_sigs{$subname}[0][$idx-1] eq 'kind'
                ) { # skip kind=... argument as we don't use it anyway
                    my $call_arg_expr_str =
                    ($call_arg_ast->[0] == 2 or $call_arg_ast->[0] == 10 or $call_arg_ast->[0] > 28)
                    ? $call_arg_ast->[1] : '';
                    # I think this is generic
                    my ($uxntal_expr,$word_sz) = __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$call_arg_ast,$idx,'in');
                    if ($is_generic and $idx==1) {
                        $short_mode = $word_sz ==2 ? '2' : '';
                    }
                    push @call_arg_expr_strs_Uxntal, $uxntal_expr;
                }
            }
        }
        # croak $word_sz,$short_mode,Dumper($args) if $subname eq 'pow';
        add_to_used_lib_subs($subname.$short_mode);
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
                    for my $sig_arg (@{$Ssubname->{'RefactoredArgs'}{'List'}}){
                        my $call_arg_expr_str = $argmap->{$sig_arg} // $sig_arg;
                        $idx++; # So starts at 1, because 0 is the sigil
                        my $intent = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
                        my ($uxntal_expr,$word_sz) = __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$ast,$idx,$intent);
                        push @call_arg_expr_strs_Uxntal, $uxntal_expr;
                    }
                last;
            }
        }
    }
    return (join(" ", @call_arg_expr_strs_Uxntal, $subname.$short_mode),$word_sz);

} # END of _emit_function_call_expr_Uxntal

# Returns the call arg Uxntal expression and its word size
sub __emit_call_arg_Uxntal_expr($stref,$f,$info,$subname,$call_arg_expr_str,$ast_from_info,$idx,$intent){
    my $Sf = $stref->{'Subroutines'}{$f};
    my $call_arg_decl = getDecl($stref,$f,$call_arg_expr_str);

    my $isParam = ((defined $call_arg_decl) && (exists $call_arg_decl->{'Parameter'})) ? 1 : 0;
    my $arg_is_not_string = 0;
    my $arg_is_intrinsic_call = 0;

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

    my $isConstOrExpr = exists $call_info->{'Args'}{'Set'}{$call_arg_expr_str}
        ? (($call_info->{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' )
        or ($call_info->{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr')
        or $isParam)
            ? 1
            : 0
        : $ast_from_info->[0] >= 29 # try via AST
            ? 1 : 0;
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
        todo('This could be e.g. str(ib:ie), in which case it is a substring');
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
        'logical'          => 1,
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
	# croak Dumper($n,$sz)
    if ($n =~ /_\d$/) {
        $n=~s/_(\d)$//; # strip _2
        my $word_sz=$1;
        if ($word_sz!=$sz) {
            croak "toHex: word size $word_sz <> hex sz $sz";
        }
    }
    my $szx2 = $sz*2;
    if ($n<0) {
        $n=2**(8*$sz)+$n;
        # $n=(2*($sz*8))-$n;
    }
    return sprintf("#%0${szx2}x",$n);
}
sub toRawHex($n,$sz){
	croak if $n eq '1_2';
    my $szx2 = $sz*2;
	$n=~s/_\d$//; # strip _2
    carp 'len is *' if $n eq '*';
    if ($n<0) {
        $n=2**(8*$sz)+$n;
        # $n=(2*($sz*8))-$n;
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
        '  ;&'.$substr.$id.' ADD2 STA'  . "\n" .
        '  JMP2r'  . "\n" .
        '} STH2r '.$ceb.' '.$cbb.' range-map'  . "\n" .
        '{ '.toRawHex($len,2).' &'.$substr.$id.' $'.toRawHex($len,1).' } STH2r'; # string with a 2-byte length field
    }
} # END of __gen_substr

sub isStrCmp($ast, $stref, $f,$info){
    if ($ast->[0] >=15 && $ast->[0]<=26 ) { # '==', '/=', '<', '>', '<=', '>=', '.not.', '.and.', '.or.', '.xor.', '.eqv.', '.neqv.'
    # TODO:  '.eqv.', '.neqv.'
        # it is a comparison; are the args strings?
        my $lhs_name = $ast->[1][0] == 10 ? $ast->[1][1] : '';
        my $rhs_name = $ast->[2][0] == 10 ? $ast->[2][1] : '';
        # If it is a literal string, it could still be a single character. In that case, it depends on the other side if it is treated as a string or not.
        my $lhs_is_str = $ast->[1][0] == 34
            ? length($info->{'PlaceHolders'}{$ast->[1][1]})==3 ? 0 : 1
            : 0;
        my $rhs_is_str = $ast->[2][0] == 34
        ? length($info->{'PlaceHolders'}{$ast->[2][1]})==3 ? 0 : 1
        : 0;
        if (not $lhs_is_str) {
            if ($lhs_name ne '') {
                $lhs_is_str = is_string($stref,$f,$lhs_name)
            }
        }
        if (not $rhs_is_str) {
            if ($rhs_name ne '') {
                $rhs_is_str = is_string($stref,$f,$rhs_name)
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
    my @lines_Uxntal = ();
    for my $elt ( @{$list_to_print} ) {
        my $line_Uxntal = '';
        my $ref = \$elt; $ref=~s/REF...//;$ref=~s/\)//;
        my $iter="iter$ref";
        # An array as arg is caught in _emit_print_from_ast so I should handle the slice there as well
        my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt);
        # croak("HANDLE ARRAY SLICE HERE!");
        my $var_name = $elt->[1];

        if ($print_fn_Uxntal eq 'print-array') {
            # The range must be the original Fortran one: we correct for the offset in the var access
            my $idx_offset = __get_array_index_offset($stref,$f,$var_name);
            my $idx_offset_Uxntal =  toHex($idx_offset,2);
            my $idx_offset_expr = $idx_offset==0
                ? ''
                    : $idx_offset==1
                        ? 'INC2'
                        : $idx_offset_Uxntal.' ADD2';

            # transforming the array into an index access mighr be best
            my $decl = getDecl($stref,$f,$var_name);

            my $array_length = exists $decl->{'ConstDim'}
            ? __array_size($decl->{'ConstDim'})
            : __array_size($decl->{'Dim'});
            my $elt_iter = [10,$elt->[1],[36,'LIT2 &'.$iter.' $2']];
            my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt_iter,$stref, $f, $info);
            my $elt_0 = [10,$elt->[1],[29,'0']];
            my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt_0);
            if ($print_fn_Uxntal eq 'print-char') {
                $print_fn_Uxntal = '#18 DEO';
            }
            elsif ($print_fn_Uxntal eq 'print-char-stderr') {
                $print_fn_Uxntal = '#19 DEO';
            }
            $line_Uxntal = '{ ( iter ) ,&'.$iter.' STR2 '.$arg_to_print_Uxntal.' '.$print_fn_Uxntal.' JMP2r } STH2r '.toHex($array_length-1,2)." $idx_offset_expr #0000 $idx_offset_expr range-map-short ( print-array )";
        }
        elsif ($print_fn_Uxntal eq 'print-array-slice') {
            # The range must be the original Fortran one: we correct for the offset in the var access
            my ($b,$word_sz_b) = _emit_expression_Uxntal($elt->[2][1],$stref, $f, $info);
            my ($e,$word_sz_e) = _emit_expression_Uxntal($elt->[2][2],$stref, $f, $info);
            $elt = [10,$elt->[1],[36,'LIT2 &'.$iter.' $2']];
            my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt,$stref, $f, $info);
            my $elt_0 = [10,$elt->[1],[29,'0']];
            my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt_0);
            if ($print_fn_Uxntal eq 'print-char') {
                $print_fn_Uxntal = '#18 DEO';
            }
            elsif ($print_fn_Uxntal eq 'print-char-stderr') {
                $print_fn_Uxntal = '#19 DEO';
            }
            $line_Uxntal = '{ ( iter ) ,&'.$iter.' STR2 '.$arg_to_print_Uxntal.' '.$print_fn_Uxntal." #20 $port DEO JMP2r } STH2r $e $b range-map-short ( print-array-slice )";
        } elsif ($print_fn_Uxntal eq 'print-implicit-do') {
            $line_Uxntal = __implicit_do_in_print($elt,$stref,$f,$info,$line,$unit);
        } else {
            my ($arg_to_print_Uxntal,$word_sz) = _emit_expression_Uxntal($elt,$stref, $f, $info);
            todo('feels like a HACK');
            if (substr($print_fn_Uxntal,0,10) eq 'print-char' and $elt->[0] == 2) {
                my ($uxntal_var_access, $word_sz) = _var_access_read($stref,$f,$info,$elt);
                croak "$uxntal_var_access: word size is $word_sz" if $word_sz !=1;
                $arg_to_print_Uxntal = $uxntal_var_access. ' LDA';
            }
            # If a string is a single char, we treat it as a char, so we must print a char
            if (substr($print_fn_Uxntal,0,12) eq 'print-string' and $arg_to_print_Uxntal=~/(:?^\s*\#[0-9a-f]+\s*$|LDA\s*$)/ ) { #
                $print_fn_Uxntal = "$port DEO";
            }
            $line_Uxntal .= "$arg_to_print_Uxntal $print_fn_Uxntal #20 $port DEO ( , )";
        }
        if ($print_fn_Uxntal=~/array|implicit-do/) {
            add_to_used_lib_subs('range-map-short');
        } else{
            add_to_used_lib_subs($print_fn_Uxntal) unless $print_fn_Uxntal=~/\#/;
        }
        push @lines_Uxntal, $line_Uxntal;
    } # For all elements in the list-based print
    my $line_Uxntal = join("\n",@lines_Uxntal);
    if ($advance eq 'yes') {
        if ($unit eq 'STDOUT') {
            $line_Uxntal .= ' #0a #18 DEO'."\n";
        }
        elsif ($unit eq 'STDERR') {
            $line_Uxntal .= ' #0a #19 DEO'."\n";
        }
    } else {
        if ($unit eq 'STDOUT') {
            $line_Uxntal .= ' #20 #18 DEO'."\n";
        }
        elsif ($unit eq 'STDERR') {
            $line_Uxntal .= ' #20 #19 DEO'."\n";
        }
    }

    return $line_Uxntal;

} # END of _emit_list_print_Uxntal

# returns the print function to be used: print-char, print-int etc
sub _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt){
    my $Sf = $stref->{'Subroutines'}{$f};
    my $suffix = $unit eq 'STDERR' ? '-stderr' : '';

    my $code = $elt->[0];
    if ($code == 2 or $code == 10) { # A scalar, but can be an unindexed string or array
        my $var_name = $elt->[1];
        my $decl = getDecl($stref,$f,$var_name);
        my $type = $decl->{'Type'};
        if ($code == 2 and exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') {
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
                my $len = __get_len_from_Attr($decl);
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
            # We assume that the length field will be set correctly
            return 'print-string'.$suffix;
        } else {
            if (exists $F95_intrinsic_function_sigs{$fname}) {
                _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt->[2]);
            } else {
                error("Unsupported type in print statement in $fname: ".$return_type.'('.$return_type_attr.') in <'.$line.'>'.Dumper($stref->{'Subroutines'}{$fname}{'Signature'}));
            }
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
        todo("Printing of ".$sigils[$code]."\n",1);
    }
    elsif ($code>=15 and $code<=26) {
        return 'print-bool'.$suffix;
    }
    elsif ($code==13) {
        # I guess this should be a print-string of the string returned by the concatenation operation
        todo("Printing of string concatenation expression\n",1);
    }
    elsif ($code==0) {
        # This could be an implicit do. If it is a comma-list and the snd elt is an assignment
        if ($elt->[1][0] == 27 and $elt->[1][2][0] == 9) {
            return 'print-implicit-do';
            # Let's assume we have the correct print expression from $elt->[1][1];
            my $print_expr = $elt->[1][1];
            my ($print_expr_Uxntal,$word_sz) = _emit_expression_Uxntal($print_expr,$stref, $f, $info);
            my $print_call = _emit_print_from_ast($stref,$f,$line,$info,$unit,$print_expr);
            # then what we need is a range-map over the range.
            my $range_start = $elt->[1][2][2];
            (my $range_start_Uxntal,$word_sz) = _emit_expression_Uxntal($range_start,$stref, $f, $info);
            my $range_end = $elt->[1][3];
            (my $range_end_Uxntal,$word_sz) = _emit_expression_Uxntal($range_end,$stref, $f, $info);
            my $range_iter = $elt->[1][2][1];
            my $range_iter_Uxntal = __var_access($stref,$f,$range_iter->[1]);

            my $uxntal_code = "{ $range_iter_Uxntal STA2 $print_expr_Uxntal $print_call JMP2r } STH2r $range_end_Uxntal $range_start_Uxntal range-map-short";
            croak $uxntal_code;
        } else {
            error('Unsupported type in print statement: '.$sigils[$code].Dumper($elt));
        }
    }
    else {
        error('Unsupported type in print statement: '.$sigils[$code].Dumper($elt));
    }
} # END of _emit_print_from_ast

sub __implicit_do_in_print($elt,$stref,$f,$info,$line,$unit) {
    my $port = ($unit eq 'STDERR') ? '#19' : '#18';
    # Let's assume we have the correct print expression from $elt->[1][1];
    my $print_expr = $elt->[1][1];
    my ($print_expr_Uxntal,$word_sz) = _emit_expression_Uxntal($print_expr,$stref, $f, $info);
    my $print_call = _emit_print_from_ast($stref,$f,$line,$info,$unit,$print_expr);
    # then what we need is a range-map over the range.
    my $range_start = $elt->[1][2][2];
    (my $range_start_Uxntal,$word_sz) = _emit_expression_Uxntal($range_start,$stref, $f, $info);
    my $range_end = $elt->[1][3];
    (my $range_end_Uxntal,$word_sz) = _emit_expression_Uxntal($range_end,$stref, $f, $info);
    my $range_iter = $elt->[1][2][1];
    my $range_iter_Uxntal = __var_access($stref,$f,$range_iter->[1]);

    my $uxntal_line = "{ $range_iter_Uxntal STA2 $print_expr_Uxntal $print_call #20 $port DEO JMP2r } STH2r $range_end_Uxntal $range_start_Uxntal range-map-short";
    return $uxntal_line;
}


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
# carp Dumper $call_args_ast,$iolist_ast;
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
    my $other_attrs = {};
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
            if (@{$attr}) {
                if ($attr->[0] eq 'fmt') {
                    ($print_calls,$offsets) = __parse_fmt($attr->[1],$stref,$f,$info);
                }
                elsif ($attr->[0] eq 'unit') {
                    $unit = $attr->[1];
                }
                elsif ($attr->[0] eq 'advance') {
                    $advance=$attr->[1];
                }
                elsif ($attr->[0] eq 'rec') {
                    $other_attrs->{'Rec'}=$attr->[1];
                } else {
                    error("Unsupported WRITE call syntax: ".Dumper($info));
                }
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
        my $unitvar_decl = getDecl($stref,$f,$unit);
        # carp Dumper $unit,$unitvar_decl;
        my $unitvar_val = $unitvar_decl->{'Val'} // '';
        my $is_device_write=0;
        if ($unitvar_val ne '') {
            $unitvar_val =~s/_2$//;
            my $dev_id = $unitvar_val - $Varvara_magic_code;
            if ($dev_id >= 0 and $dev_id < 16 ) {
                $print_calls = ['device-write'];
                $is_device_write=1;
            }
        }
        if (not $is_device_write ) {
        # memwrite-string assumes the target is a string
        # memwrite-char, memwrite-int, memwrite-hex assume the target is an array
        # The use case is for strings so to be clear I should probably call them strwrite instead of memwrite.
            $print_calls = [map {$_=~s/print/strwrite/;$_} @{$print_calls}];
            map { add_to_used_lib_subs( $_ ) } @{$print_calls};
        }
    }
# suppose I return print-array-slice
    return ($print_calls, $offsets, $unit, $advance, $other_attrs);
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
        return []
    }
    elsif ($tag == 34) {
        # 34: PlaceHolder, this is the string with the format (`fmt=` is removed)
        my $fmt_str = $info->{'PlaceHolders'}{$arg_val};
        $fmt_str=~s/^[\"\']\(//;
        $fmt_str=~s/\)[\'\"]$//;
        return ['fmt',$fmt_str];
    }
    elsif ($tag == 9) {
        # 9: =, check what is next, it should be [2,$attr]
        # Most common $attr is advance; the value will be a PlaceHolder

        if (ref($arg_val) eq 'ARRAY' and $arg_val->[0] == 2) {
            my $attr = $arg_val->[1];
            if ($attr eq 'advance' or $attr eq 'rec') {
                my $attr_val = $arg->[2];
                if ($attr_val->[0] == 34) {
                    my $attr_val_str =  $info->{'PlaceHolders'}{$attr_val->[1]};
                    $attr_val_str=~s/^[\"\']//;
                    $attr_val_str=~s/[\"\']$//;
                    return [ $attr,$attr_val_str];
                }
                elsif ($attr_val->[0] == 2) {
                    return [ $attr,$attr_val->[1]];
                }
                if ($attr_val->[0] == 29) {
                    return [ $attr,$attr_val->[1]];
                }
            }
        }
        return [];
    }
    elsif ($tag == 2) {
        # must be a variable
        my $unit_var =     $arg_val;
        return ['unit',$unit_var];
    } else {
        croak "Unknown arg type in $f: ".Dumper($arg);
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
                        # set it totally ad hoc to 8
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
    }
} # END of __get_type_len_from_AST


sub __get_val_str_from_len_Attr($len) {
        $len=~s/len=//;
        $len=~s/^\(//;
        $len=~s/\)$//;
        if ($len eq ':' or $len eq '*') {
            $len = 64; # AD HOC
        }
        return $len;
}
sub __get_len_from_Attr($decl){
    if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
        my $len = $decl->{'Attr'};
        return __get_val_str_from_len_Attr($len)
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

# returns the offsets and dimensions for each index
sub  __get_array_index_offsets_dims($stref,$f,$var){
    my $decl=getDecl($stref,$f,$var);
    my @dims=();
    if (exists $decl->{'ConstDim'} and scalar $decl->{'ConstDim'} > 0) {
        @dims=@{$decl->{'ConstDim'}};
    }
    elsif (exists $decl->{'Dim'} and scalar $decl->{'Dim'} > 0) {
           @dims=@{$decl->{'Dim'}};
    } else {
        croak "Decl has no Dim: ".Dumper($decl);
    }
    my $offsets_dims=[];
    for my $ijk (@dims) {
        my $offset =$ijk->[0];
        my $dim = $ijk->[1]-$ijk->[0]+1;
        push @{$offsets_dims},[$offset,$dim];
    }
    return $offsets_dims;
} # END of __get_array_index_offset


sub __emit_list_based_print_write($stref,$f,$line,$info,$unit, $advance){
    my $port = $unit eq 'STDERR' ? '#19' : '#18';

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
        $c_line = _emit_list_print_Uxntal($stref,$f,$line,$info,$unit, $advance,\@list_to_print);

	} else {
		my $fmt_ast = $ast->[2][1];
		if ($fmt_ast->[0]==29) {
			error("Unsupported: PRINT with label arg: $line",0,'ERROR');
		}
		my $print_fmt = __analyse_write_call_arg($stref,$f,$info,$fmt_ast,0);
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
		$c_line .= " #0a $port DEO" if $advance eq 'yes';
	}

    return $c_line;

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

    my $sub_or_mod = (exists $stref->{'Modules'}{$f} and exists $stref->{'Modules'}{$f}{'Status'})
        ? 'Modules'
        : 'Subroutines';
    my $Sf =  $stref->{$sub_or_mod}{$f};

    my $subset = in_restricted_nested_set( $Sf, 'Vars', $var ,
        {   'ExGlobArgs' => 1,
            'UndeclaredCommonVars' => 1,
            'DeclaredCommonVars' => 1,
            'UndeclaredOrigLocalVars' => 1
        }
    );
    my $decl;
    if ($subset eq '') {
        warning( "No local decl for $var in Vars for $sub_or_mod $f, looking in modules",2);
    } else {
        $decl = get_var_record_from_set($Sf->{'Vars'},$var);
    }
    my $module_name = '';
    if(defined $decl){ # If there is a declaration, look at parent module
        $module_name = exists $decl->{'ModuleName'}
        ? $decl->{'ModuleName'}
        : exists $decl->{'ParentModule'}
        ? $decl->{'ParentModule'}
        : $f;
    }
    # Module var decl records are copied into the state of the subroutines that use them
    # before constant folding is done. So we need to get the originals instead.
    my $mdecl;
    if( $subset eq 'ModuleVars') {
        $mdecl = $stref->{'Modules'}{$module_name}{'ModuleVars'}{'Set'}{$var};
    }

    if (not defined $decl and not defined $mdecl) {
        if (exists $stref->{'Subroutines'}{$f}{'InModule'}) {
            my $module_name = $stref->{'Subroutines'}{$f}{'InModule'};
            my $Mf = $stref->{'Modules'}{$module_name};
            my $decl = get_var_record_from_set($stref->{'Modules'}{$module_name}{'Vars'},$var);
            if (defined $decl) {
                return $decl;
            } else {
                croak "Could not find a declaration for $var in $f or used modules";
            }
        }
    } elsif (not defined $decl) {
        $decl = $mdecl;
    }

    return $decl;
}
# ----------------------------------------------------------------------------------------------------

sub __array_size($dims){
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

sub __array_bounds($dims){
# carp Dumper $dims;
    my $array_bounds=[];
    for my $dim (@{$dims}) {
        my $lb=$dim->[0];
        my $ub=$dim->[1];
        my $dim_size = eval("$ub-$lb+1");
        push @{$array_bounds}, [$lb,$dim_size];
    }
    return $array_bounds;
}

# returns the linear index, but needs to be combined with $word_sz
sub _multi_dim_array_access_to_Uxntal($index_exprs,$array_bounds, $stref,$f,$info) {
my ($i_expr,$j_expr) = @{$index_exprs};
    my ($i_bounds,$j_bounds) = @{$array_bounds};
    my ($i_lb,$i_rng)=@{$i_bounds};
    my ($j_lb,$j_rng)=@{$j_bounds};
    my ($i_rng_expr,$word_sz) = _emit_expression_Uxntal([29,$i_rng],$stref,$f,$info);
    (my $i_lb_expr,$word_sz) = _emit_expression_Uxntal([29,$i_lb],$stref,$f,$info);
    (my $j_lb_expr,$word_sz) = _emit_expression_Uxntal([29,$j_lb],$stref,$f,$info);
    # say multi_dim_to_Uxntal_lin_idx([$i_expr],[$i_lb_expr],['#0001',$i_rng_expr]);
    my $lin_idx_expr = __multi_dim_to_Uxntal_lin_idx($index_exprs,[$i_lb_expr,$j_lb_expr],['#0001',$i_rng_expr,]);
    return $lin_idx_expr;
    # return "$j_expr $j_lb_expr SUB2 $i_rng_expr MUL2 $i_expr ADD2 $i_lb_expr SUB2";
}

sub __multi_dim_to_Uxntal_lin_idx($index_exprs,$lb_exprs,$range_exprs) {
    # croak Dumper ($index_exprs,$lb_exprs,$range_exprs);
    my @adjusted_indices = map { $_->[0].' '. $_->[1].' SUB2' } @{zip($index_exprs,$lb_exprs)};
    my @lin_idx_terms=();
    my $idx_cnt=0;
    for my $ijk (@adjusted_indices){
        $idx_cnt++;
        # say "IDX CNT: $idx_cnt";
        my $lin_idx_term = $ijk;
        my $rng_cnt=0;
        for my $rng_expr (@{$range_exprs}) {
            # 1 0 => ok
            # 1 1 => jmp
            # 2 0 => ok
            # 2 1 => ok
            # 2 2 => jmp
            # say "IDX CNT: $idx_cnt, RNG CNT: $rng_cnt";
            if ($rng_cnt < $idx_cnt) {
                $lin_idx_term.=" $rng_expr MUL2" unless $rng_expr eq '#0001';
                # say "LIN IDX: $lin_idx_term"
            }
            $rng_cnt++;
            # last if $rng_cnt == $idx_cnt;
        }
        push @lin_idx_terms,$lin_idx_term;
    }
    my $lin_idx = join(' ', @lin_idx_terms);
    $lin_idx .= ' ADD2' x (scalar(@lin_idx_terms)-1); # 1-D, nothing; 2-D, 1; 3-D, 2
    return $lin_idx
}

sub __is_operator($opcode) {
    return
    (($opcode > 2  and $opcode < 9 ) or
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
                if (not exists $F95_intrinsic_functions{$csf} and
                    not exists $stref->{'ExternalSubroutines'}{$csf} ) {
                    say "RECURSE into SUB $csf" if $V;
                    $stref = do_passes_recdescent($stref,$csf,$pass_sequence,$seen);
                }
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

    my $Sf = $stref->{'Subroutines'}{$f};

    for my $var (@{$Sf->{'AllVarsAndPars'}{'List'}}) {
        next if $var =~/__PH\d+__/; # FIXME: hack!
        if (exists $stref->{'Subroutines'}{$var}) {
            if (exists $stref->{'Subroutines'}{$var}{'Pointee'}) {
                my $pointed_sub = $stref->{'Subroutines'}{$var}{'Pointee'};
                $stref = do_passes_recdescent($stref,$pointed_sub,$pass_sequence,$seen);
            }
        }
    }

    return $stref;
} # END of do_passes_recdescent

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

J3/22-007r1(Draft Fortran 2023)
15.5.2.4 Argument association
NOTE 2
Fortran argument association is usually similar to call by reference and call by value-result. If the VALUE attribute is specified, the effect is as if the actual argument were assigned to a temporary variable, and that variable were then argument associated with the dummy argument. Subsequent changes to the value or definition status of the dummy argument do not affect the actual argument. The actual mechanism by which this happens is determined by the processor.

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

sub __create_string_zeroing($str,$len) {
    add_to_used_lib_subs('range-map-short');
    return "{ ( iter ) #00 ROT ROT $str ADD2 STA JMP2r } STH2r ".toHex($len+1,2).' #0002 range-map-short';
}

sub __create_array_zeroing($arr,$sz,$word_sz) {
    if ($word_sz==1) {
        __create_byte_array_zeroing($arr,$sz)
    } elsif ($word_sz==2) {
        __create_short_array_zeroing($arr,$sz)
    } else {croak "__create_array_zeroing: word size $word_sz not supported" }
}
sub __create_byte_array_zeroing($str,$len) {
    add_to_used_lib_subs('range-map-short');
    return "{ ( iter ) #00 ROT ROT $str ADD2 STA JMP2r } STH2r ".toHex($len-1,2).' #0000 range-map-short';
}

sub __create_short_array_zeroing($str,$len) {
    add_to_used_lib_subs('range-map-short');
    return "{ ( iter ) #0000 SWP2 #0002 MUL2 $str ADD2 STA2 JMP2r } STH2r ".toHex($len-1,2).' #0000 range-map-short';
}
sub _gen_array_string_inits($stref,$f,$var,$pass_state) {
    my $uxntal_array_string_init = '';
    my $decl = getDecl($stref,$f,$var);
    my $fq_var = __create_fq_varname($stref,$f,$var);

    if (is_array($stref,$f,$var)) {
        my $word_sz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$var};
        my $sz = exists $decl->{'ConstDim'}
        ? __array_size($decl->{'ConstDim'})
        : __array_size($decl->{'Dim'}) ;
        $uxntal_array_string_init = __create_array_zeroing(";$fq_var",$sz,$word_sz);
    }
    elsif (is_string($stref,$f,$var)) {
        my $len = __get_len_from_Attr($decl);
        $uxntal_array_string_init = __create_string_zeroing(";$fq_var",$len);
    }

    push @{$pass_state->{'Subroutine'}{'ArrayStringInits'}},$uxntal_array_string_init unless $uxntal_array_string_init eq '';
    return $pass_state;
}


sub _remove_redundant_labels($uxntal_source_lines) {
    my %used_labels = ();
    my $processed_uxntal_source_lines=[];
    my $parent_label='NONE';
    my @new_source_lines=();

    for my $line (@{$uxntal_source_lines}) {
        my @chunks = split(/\n/,$line);
        @new_source_lines=(@new_source_lines,@chunks);
    }

    for my $line (@new_source_lines) {
        if ($line=~/^\s*\@([\-\w]+)/) { # assuming only ever one per line
            $parent_label=$1;
            $used_labels{$parent_label}={};
        }

        my @line_chunks=split(/\s+/,$line);
        for my $line_chunk (@line_chunks) {
            if ($line_chunk=~/^([\!\?\,\;])\&([\-\w]+)$/) {
                my $label =$2; my $mode = $1;
                $used_labels{$parent_label}{$label}=$mode;
            } elsif ($line_chunk=~/^([\;\.])([\-\w]+)\/([\-\w]+)/ ) {
                my $mode=$1; my $explicit_parent_label = $2; my $label=$3;
                $used_labels{$explicit_parent_label}{$label}=$mode;
            }
        }
    }
    $parent_label='NONE';
    for my $line (@new_source_lines) {
        my $new_line=$line;
        if ($line=~/\@([\-\w]+)/) {
            $parent_label=$1;
        }
        my @line_chunks=split(/\s+/,$line);
        my @new_line_chunks=();
        for my $line_chunk (@line_chunks) {
            my $new_line_chunk=$line_chunk;
            if ($line_chunk=~/^\&([\-\w]+)$/) {
                my $label =$1;
                if (not exists $used_labels{$parent_label}{$label}) {
                    $new_line_chunk=~s/\&$label//g;
                }
            }
            push @new_line_chunks, $new_line_chunk
        }
        $new_line=join(' ',@new_line_chunks);
        croak $line if $new_line eq '6';
        push @{$processed_uxntal_source_lines},$new_line;
    }

    return $processed_uxntal_source_lines;
} # END of _remove_redundant_labels


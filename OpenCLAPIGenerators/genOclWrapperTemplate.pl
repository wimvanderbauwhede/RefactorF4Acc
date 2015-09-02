#!/usr/bin/perl
# This is the cleaned-up version of generate_OpenCL_wrapper_from_ACC_pragmas_V2.pl
=info

Usage:

In the OpenCL folder, run

  ./genOclWrapperTemplate <(relative) path to main program with KernelWrapper pragma>
  
This script takes a Fortran-95 main program with annotations of the form

 !$ACC KernelWrapper(LES_kernel_wrapper)
 ...
 !$ACC End KernelWrapper
 
around a set of subroutines (and later maybe even some intermediate code, though not yet) 
and generates:

1. A new main program with a call to the wrapper subroutine.
2. The F95 template for the wrapper subroutine, with pragmas around the kernel subroutine calls.
3. The F95 stub for the kernel.

Status:

* Need to extend this to work with code between subroutine calls (not urgent TODO for me).
* The current approach generates a single kernel stub for all subroutines together. It would be better initially to have a kernel stub per subroutine; ideally I'd want to generate a case-based kernel from these subkernels. TODO.

Difference with prepare_kernel_port.pl:

The `prepare_kernel_port.pl` script does three things:

1. Copy the C code generated with F2C_ACC into Kernels and rename to .cl. Later, it will also clean up the C code so that it's valid OpenCL. TODO
2. Create a F95 OpenCL wrapper template and put it in WrapperTemplates, which is the same as this script is supposed to do. 
3. Create a F95 kernel stub an put it in KernelStubs, which is the same as this script is supposed to do.

prepare_kernel_port.pl does not parse the code though, it uses a few regexes to find the module begin/end and subroutine calls

So I should merge these two!

=cut   
use strict;
use warnings; 
use 5.010;
use F95VarDeclParser qw( parse_F95_var_decl );
use F95Normaliser qw( normalise_F95_src );

use Cwd;
use Data::Dumper;
$Data::Dumper::Indent=1;#0;
$Data::Dumper::Terse =1;
our $VV= 1;
die 'Please run this script in the Fortran source folder and provide the relative path to the main program.
Sources will be generated in ../OpenCL 
' unless @ARGV;
our $src_templ= $ARGV[0];# // '../RefactoredSources/main_acc.f95';
my @wds=split('/', $src_templ);
if (@wds>1) {
    pop @wds;
} 
our $cwd= cwd();
our $srcdir = (@wds) ? join('/', @wds) : '.';
if (not -d '../OpenCL') {
    mkdir '../OpenCL';
    mkdir '../OpenCL/KernelStubs';
    mkdir '../OpenCL/WrapperTemplates';
}
our $src_gen = $src_templ;
$src_gen=~s/\.f95/_ocl.f95/;
#-------------------------------------------------------------------------------- 
#-------------------------------------------------------------------------------- 
#-------------------------------------------------------------------------------- 

sub get_C_type {
    (my $type, my $wordsz)=@_;

    if ($wordsz==4) {
        if ($type eq 'real') {
            return 'float';
        } elsif ($type eq 'integer') {
            return 'int';
        }
    }
    elsif ($wordsz==8) {
        if ($type eq 'real') {
            return 'double';
        } elsif ($type eq 'integer') {
            return 'long';
        }
    } 
    else {
        if ($type eq 'character') {
            return 'char';
        } else {
            return $type;
        }
    }
} # END of get_C_type();

# For every sub we find, we must return all kernels. So we must have a record for this
# Also, for convenience, we need to label each line with the block to which it belongs.
# We need a list of all blocks in order end then a map of block name to lines of code:
# $src->{BlockList}
# $src->{Blocks}
sub parse_F95_src {
    (my $src_name)=@_;
    open my $IN, '<', $src_name or die "$src_name: $!";
    my @orig_lines=<$IN>;
    close $IN;
    my $src_lines = normalise_F95_src(\@orig_lines);

    my $in_sub=0;
    my $in_kernel=0;
    my $default_name=0;
    my $var_lines=[];
    my $par_lines=[];
    my $src={
        BlockList =>[], 
        Blocks =>{}
    };
    my $subs={};
    my $current_sub='';
    my $current_kernel_wrapper='';
    my $cnt=0;
    my $current_block='_MAIN_0';
    push @{ $src->{BlockList} },$current_block;
    $src->{Blocks}{$current_block}=[];

    for my $line (@{$src_lines}) {
        push @{  $src->{Blocks}{$current_block} },$line;
		next if $line=~/^\s*$/;
		next if ($line=~/^\s*[*!]/ || ($line=~/^C/i)) && $line !~/^\s*!\s*\$/; # We only support !$ACC, not c,C or *

        $line=~/^\s*(subroutine|program)\s+(\w+)/ && do {
            $in_sub=1;
            $cnt++;
            $current_sub=$2;
#            die "BOOM! $current_sub";
            push @{ $src->{BlockList} },$current_sub;
            my $sig_line = pop  @{  $src->{Blocks}{$current_block} };
            $current_block=$current_sub;
            $src->{Blocks}{$current_block}=[$sig_line];
            $subs->{$current_sub}={};
            next;
        };    

        $in_sub && $line=~/^\s*end\s+(subroutine|program)/ && do {
            $in_sub=0;
            @{$subs->{$current_sub}{VarLines}}=@{$var_lines};
            @{$subs->{$current_sub}{ParLines}}=@{$par_lines};
            $current_sub='';
            $var_lines=[];
            $par_lines=[];
            $current_block='_MAIN_'.$cnt;
            push @{ $src->{BlockList} },$current_block;
            $src->{Blocks}{$current_block}=[];
            next;
        };    
        $line=~/::/ && do { 
            if($line=~/\Wparameter\W/ ) {
            push @{$par_lines}, $line;
            } else {
            push @{$var_lines}, $line;
            }
            next;
        };
        $line=~/^\s+call\s+(\w+)\s*(.+)/ && do { 
            my $called_sub=$1;
            my $called_sub_args_str=$2;
            $subs->{$current_sub}{CalledSubs}{$called_sub}{ArgStr}=$called_sub_args_str;
        };
        $line=~/^\s*\!\s*\$ACC\s+KernelWrapper\s*$/i && do {
            $in_kernel=1;
            $default_name=1;
#            push @{$subs->{$current_sub}{KernelWrapperNames} }, $current_kernel_wrapper;
#            $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{Name}=$current_kernel_wrapper;
           next;
        };
        $line=~/^\s*\!\s*\$ACC\s+KernelWrapper\s*\((\w+)\)/i && do {
            $in_kernel=1;
            $default_name=0;
            $current_kernel_wrapper=$1;
            push @{$subs->{$current_sub}{KernelWrapperNames} }, $current_kernel_wrapper;
            $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{Name}=$current_kernel_wrapper;
           next;
        };
        $line=~/^\s*\!\s*\$ACC\s+End\s+Kernel/i && do {
            $in_kernel=0;
            $current_kernel_wrapper='';
			next;
        };
        if ($in_kernel==1) {
           if( $line=~/^\s+call\s+(\w+)\s*(.+)/) {
            my $kernel_sub = $1;
            my $args_str = $2;
            
            
            if ($default_name==1) {
                $current_kernel_wrapper = $kernel_sub.'_wrapper';
            push @{$subs->{$current_sub}{KernelWrapperNames} }, $current_kernel_wrapper;
            $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{Name}=$current_kernel_wrapper;
                
            }
            $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{SubCalls}{$kernel_sub}{ArgStr}=$args_str;
           }
            push @{ $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{Lines}},$line;
        }
        $line=~/^\s*use\s(\w+)/ && do {
            my $module_name = $1;
            push @{  $subs->{$current_sub}{Modules} }, $module_name;
        };
#        if($in_sub==1) {
#            push @{$subs->{$current_sub}{SrcLines}},$line;
#        } else {
#            push @{$subs->{'_MAIN_'.$cnt}{SrcLines}},$line;
#        }
    }
        if(  $in_sub ) {
            @{$subs->{$current_sub}{VarLines}}=@{$var_lines};
            @{$subs->{$current_sub}{ParLines}}=@{$par_lines};
        }      
        return ($subs,$src);
} # END of parse_F95_src

#-------------------------------------------------------------------------------- 
# Code for parsing the argument declarations
our $vv=0;
sub parse_arg_decls {
    (my $var_lines, my $kernel_args)=@_;
    say '=' x 80 if $vv;
    my $all = defined $kernel_args? 0 : 1; # FIXME: a better way is to pass in a function to do the comparison
        my %ocl_args=();
    my @arg_names=();
    my $ocl_arg_names=[];
    my $ocl_const_arg_names=[];

    for my $str (@{$var_lines}) {
        say "\n>>> <$str>\n" if $vv;
        my $pt = parse_F95_var_decl($str);
        print Dumper($pt),"\n" if $vv;
        my $type = $pt->{TypeTup}{Type};
        my $wordsz = $pt->{TypeTup}{Kind};
        my $ndims = exists $pt->{Attributes} ? scalar @{ $pt->{Attributes}{Dim} } : 0 ;
        if ($ndims==1 && $pt->{Attributes}{Dim}[0]!~/:/ && $pt->{Attributes}{Dim}[0] eq '0') {
            $ndims=0;
        }
        my @var_names=@{ $pt->{Vars} };
        @arg_names=(@arg_names, @var_names);
        my $argmode =  $ndims==0 ? 'Const' : $pt->{AccPragma}{AccVal};
        if ($argmode eq 'ReadWrite') {
# check intent
            if (exists $pt->{Intent} ) {
                my $intent = $pt->{Intent};
                if ($intent ne 'InOut') {
                    $argmode = ($intent eq 'In') ? 'Read' : 'Write' ;
                }
            } 
        } 
         if (not exists $pt->{Intent} ) {
             $pt->{Intent} = 'InOut';
         } else {
              $pt->{Intent} = ucfirst $pt->{Intent};

         }
# Now I overload ArgMode to indicate if a value is const. Simply, any scalar is a const. 
        say "$type,$wordsz,$ndims ",@var_names, " $argmode" if $vv;
        
        for my $arg_name (@var_names) {                
            if (not defined $arg_name) { die Dumper $str, $pt };
            if ($all or exists $kernel_args->{$arg_name}) {
                if ($argmode eq 'Const') {
                    push @{$ocl_const_arg_names}, $arg_name;
                } else {
                    push @{$ocl_arg_names}, $arg_name;
                }
                $ocl_args{$arg_name}{WordSize} = $wordsz;
                $ocl_args{$arg_name}{Type} = lc($type);
                my $ctype = get_C_type(lc($type),$wordsz);
                $ocl_args{$arg_name}{CType} = $ctype;
                $ocl_args{$arg_name}{Intent}=  $pt->{Intent};
                $ocl_args{$arg_name}{ArgMode} = $argmode;
                $ocl_args{$arg_name}{Dim} = $pt->{Attributes}{Dim};#$ndims;
                $ocl_args{$arg_name}{ArgName}=$arg_name;
            }
        }
        
    } # for
    return (\%ocl_args,$ocl_arg_names,$ocl_const_arg_names);
} # end parse_arg_decls()
#-------------------------------------------------------------------------------- 
# TODO: In general this is complicated, because the args can be expressions, array slices etc.
# We assume they are all nice simple var names for now
sub get_called_sub_args { (my $argstr)=@_;
    say "ARGSTR: $argstr" if $VV;
    $argstr=~s/^\(\s*//;
    $argstr=~s/\s*\)$//;    
    my @args=split(/\s*,\s*/, $argstr);
    my %argtable = map {$_ => 1 } @args;
    return ({  %argtable },[ @args]);
}
#-------------------------------------------------------------------------------- 
#
# The 'main program' can be a module with a list of subroutines. For each of these subroutines we need to do this substitution: 
#   add the use statement, 
#   replace the pragma by the subroutine call. 
# And in fact, each subroutine can have several of these pragmas.
# So we have $subs ->{$current_sub}{KernelWrappers}{$current_wrapper}{WrapperSubName} and {WrapperArgs} to replace the pragma
# and we have {WrapperModuleName} for the use module statement
# So, to make this easy, we need to split up the main code into blocks, each block belonging to a subroutine or to the main program    
# 
sub generate_acc_main { 
    (my $src, my $subs) = @_;
    my $gen_src_lines=[];
# For every block that is a subroutine, do stuff; for the other blocks, just produce the lines
# We can test by name but that is of course weak
    my $skip=0;
    # So first, add the extra modules
    my @blocks = @{ $src->{BlockList}};
    for my $block (@blocks) {
        if ($block =~/_MAIN_/) {
            $gen_src_lines= [@{$gen_src_lines},@{$src->{Blocks}{$block}}];
        } else {
            # do proper processing
            my $current_sub = $block;
            my $prev_line='';
            for my $line (@{$src->{Blocks}{$current_sub} }) {                
                next if $line=~/^\s*$/;
                next if ($line=~/^\s*[*!]/ || ($line=~/^C/i)) && $line !~/^\s*!\s*\$/; # We only support !$ACC, not c,C or *

                if ($line!~/^\s*use\s\w+/ && $prev_line=~/^\s*use\s\w+/) {
# add use declarations for all wrappers in this sub
                    my @use_decls=();
                    for my $cwname (@{$subs->{$current_sub}{KernelWrapperNames}}) {
                        my $module_name = $subs->{$current_sub}{KernelWrappers}{$cwname}{WrapperModuleName};
                        push @use_decls, "! Wrapper module ";
                        push @use_decls, "    use $module_name";
                    }
                    $gen_src_lines= [@{$gen_src_lines},@use_decls];
                } elsif ( $line=~/^\s*\!\s*\$ACC\s+KernelWrapper\s*\((\w+)\)/i ) {
                    my $cwname=$1;
# Create the subroutine call for this wrapper; make sure to skip all lines inside the pragam
                        my $sub_name = $subs->{$current_sub}{KernelWrappers}{$cwname}{WrapperSubName};
                        my $sub_args= $subs->{$current_sub}{KernelWrappers}{$cwname}{WrapperArgs};
                        my @wrapper_call_lines= (
                                "! Wrapper call",
                                "    call $sub_name ( &",
                                @{$sub_args},
                                '    )',
                           );
                        $gen_src_lines= [@{$gen_src_lines},@wrapper_call_lines];
                    $skip=1;
                } elsif ( $line=~/^\s*\!\s*\$ACC\s+End\s+KernelWrapper/i ) {
                    $skip=0;
                } elsif ($skip==0) {
                        $gen_src_lines= [@{$gen_src_lines},$line];
                }

                $prev_line=$line;
            }
        }
    }
    return $gen_src_lines;
}
# The wrapper is contained in a module based on the name of the wrapper 
# In the first stage we generate module_$wrapper_name, in the second stage module_$kernel_name
sub generate_acc_wrapper { (my $wrapper_info, my $stage)=@_;
# The wrapper is contained in a module based on the name of the wrapper 
    my $wrapper_name =  $wrapper_info->{Name};    
    my $kernel_name = $wrapper_name;
# If the wrapper name contains '_wrapper', remove it
    if ($kernel_name=~/_wrapper/) {
        $kernel_name=~s/_wrapper//;
    }
# If the wrapper name does not already contain _kernel, add it    
    if ($kernel_name!~/_kernel/) {
        $kernel_name.='_kernel';
    }
    my $module_name =  'module_'.($stage==1 ? $wrapper_name : $kernel_name);
    my $sub_name = $stage==1 ? $wrapper_name : $kernel_name;
# now the use-modules lines
    my @use_modules=();
    if ($stage==1) {
         @use_modules=("    use module_$kernel_name" );
    } else {
    for my $called_sub (keys %{ $wrapper_info->{SubCalls} }) {
        say "! CALLED SUB: $called_sub" if $VV;
#        say Dumper( $wrapper_info->{SubCalls}{$called_sub} );
        my $used_module =  $wrapper_info->{SubCalls}{$called_sub}{Module};
        if ($used_module=~/^\s*$/) {die $called_sub."\n".Dumper($wrapper_info->{SubCalls}{$called_sub}); }
        push @use_modules, '    use '.$used_module;
    }
    }
    my $wrapper_arg_names = $wrapper_info->{Args}{Names};
    my @grouped_args=();
    my $argstr='        ';
    for my $arg (@{ $wrapper_arg_names }) {
        $argstr.= "$arg, ";
        if (length($argstr)>75) {
#            $argstr=~s/,\s$/ \&/;
            push  @grouped_args, $argstr.'&';
            $argstr='        ';
        }
    }
    if (@grouped_args) {
        $grouped_args[-1]=~s/,\s\&/ \&/;
    } else {
        $argstr=~s/\,\s*$/ &/;
        @grouped_args=($argstr);
    }
#    say 'GROUPED ARGS:'.Dumper(@grouped_args);
     my @decls=();
    for my $wrapper_arg_name (@{ $wrapper_arg_names }) {
        my $wrapper_arg_decl =  $wrapper_info->{Args}{Decls}{$wrapper_arg_name};
#        say "DECL:",$wrapper_arg_name ,'=>',Dumper $wrapper_arg_decl;
            push @decls, '    '.gen_F95_type_decl( $wrapper_arg_decl);
    }


    my @subroutine_body = do {
        if ($stage==1) {
            (
                    '    !$ACC Kernel('.$kernel_name.')',
        "    call $kernel_name ( &",
         @grouped_args,
        '    )',
        '    !$ACC End Kernel',
            )
        } else {
            @{ $wrapper_info->{Lines} }
        }    
    };
    my $gen_src_lines = [
        "module $module_name",
        "    contains",
        "    subroutine $sub_name ( &",
        @grouped_args,
        '    )',
        '',
        @use_modules,
        '',
        '    implicit none',
        '',
        @decls,
        '',
        @subroutine_body,
        "    end subroutine $sub_name",
        "end module $module_name"
            ];
#    die join("\n", @{$gen_src_lines});
#       die;
    if ($stage==1) {
        $wrapper_info->{WrapperCode} = $gen_src_lines;
        $wrapper_info->{WrapperArgs} = [@grouped_args];
        $wrapper_info->{WrapperSubName}= $sub_name;
        $wrapper_info->{WrapperModuleName}= $module_name;
    } else {
        $wrapper_info->{KernelPrecursorCode} = $gen_src_lines;
        $wrapper_info->{KernelFileName}=$kernel_name;
    }
    return $wrapper_info;
} # END of generate_acc_wrapper()

sub gen_F95_type_decl { (my $decl)=@_;
#    say "DECL: ".Dumper($decl);
    my $kind_len= $decl->{WordSize};
    if ($decl->{Type} eq 'character') {
        $kind_len = "(len=$kind_len)";
    } else {
        $kind_len="(kind=$kind_len)";
    }
    my $type = $decl->{Type}.$kind_len;
    my $dim = $decl->{'ArgMode'} eq 'Const' ? '' : 'dimension('.join(',', @{ $decl->{Dim} }).')';
    my $intent = ($decl->{Intent} eq 'InOut') ? '' : 'intent('.$decl->{Intent}.')';
    my @decl_attrs = grep {$_ ne ''} ($dim,$intent);
 @decl_attrs = ($type,  @decl_attrs);
    my $decl_str = join(', ',@decl_attrs).' :: '.$decl->{ArgName};
    return $decl_str;
}
#-------------------------------------------------------------------------------- 

# Find the sources, check the module name and find all subs in each source.
sub find_modules { 
    chdir $srcdir;
    my @all_sources=glob('*.f95'); # FIXME: WEAK! Assumes all sources are in a single folder. Need an approach similar to rf4a
        my $all_subs_modules={}; # for every sub, its module   
        for my $src ( @all_sources ) {
            my $subs_in_module = get_subs_in_module($src); # for every sub, list the module name
                for my $sub (keys %{$subs_in_module}) {
                    my $module=$subs_in_module->{$sub};
#                    say "SUB $sub => MODULE $module";
                    $all_subs_modules->{$sub}=$module;
                }
        }
    chdir $cwd;
#        die;
    return $all_subs_modules;   
} # END of find_modules()

#-------------------------------------------------------------------------------- 
sub get_subs_in_module { (my $src)=@_;
    my $subs_in_module={};
    open my $SRC,'<',$src or die "$src: $!";
    my $current_module='';
    for my $line (<$SRC>) {
        
        $line=~/^\s*$/ && next;
        $line=~/^\s*!/ && next;
        $line = lc($line);
        $line=~/^\s*module\s+(\w+)/ && do {
            $current_module=$1;
            next;
        };
        $line=~/^\s*subroutine\s+(\w+)/ && do {
            my $current_sub=$1;
            $subs_in_module->{$current_sub}=$current_module;
#            say "$current_sub => $current_module";
            next;
        };
    }
    close $SRC;
    return $subs_in_module;
} # END of get_subs_in_module()

# -----------------------------------------------------------------------------
# This union is obtained by removing duplicates from @b. It is a bit slower but preserves the order
sub ordered_union { 
    ( my $aref, my $bref ) = @_;
#    croak("ordered_union()") unless (defined $aref and defined $bref);   
    if (not defined $aref) {
    	return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    
	    my @us = @{$aref};
	    my %as = map { $_ => 1 } @{$aref};
	    for my $elt ( @{$bref} ) {
	        if ( not exists $as{$elt} ) {
	            push @us, $elt;
	        }
	    }
	    return \@us;
    }
}    # END of ordered_union()

sub show { (my $lines)=@_;
    map {say $_} @{$lines};
}

sub generate_file {
    (my $lines, my $filename)=@_;
    open my $OUT, '>',$filename;
    map {say $OUT $_} @{$lines};
    close $OUT;
};
###############################
=info
Read the source and get the subroutine records:
For each subroutine or program, find all KernelWrappers, plus all VarLines and ParLines
$subname => {
        VarLines => [String],
        Parlines=> [String],

        KernelWrappers => {$kname => {
                SubCalls => { String => String } $calledsubname => $subargsstr
        }},
}

It might be best to also have a list of all used modules, so we know where to go and look for the called subroutines

These modules will need to be removed from the main sub, unless they contains subs that are used outside the wrapper pragma, and put into the wrapper sub
=cut

sub main {
    (my $subs, my $src) = parse_F95_src($src_templ);
#    die Dumper($src);
# Find modules for called subs in wrapper and outside. Make list of modules that occur in wrapper, and others that occur in main 
    my $all_subs_modules = find_modules();
#die Dumper( $all_subs_modules );
# Analyse called sub arguments for every called sub in wrapper. For each of the variables, add the declaration to the wrapper. 
    for my $current_sub (keys %{$subs}) {
        say "SUB:$current_sub" if $VV;
# Actually, at this point we know the called subs, so we can add the modules to them
        for my $called_sub ( keys %{ $subs->{$current_sub}{CalledSubs} } ){
         
            $subs->{$current_sub}{CalledSubs}{$called_sub}{Module}=$all_subs_modules->{$called_sub};
        }
        my $var_lines = $subs->{$current_sub}{VarLines};
        for my $cwname (@{$subs->{$current_sub}{KernelWrapperNames}}) {
            say "! KERNEL WRAPPER:$cwname" if $VV;
            my $wrapper_arg_names=[];
            my $wrapper_args={Decls =>{}, Names=>[]};
            for my $called_sub ( keys %{ $subs->{$current_sub}{KernelWrappers}{$cwname}{SubCalls} } ){
                my $arg_str= $subs->{$current_sub}{KernelWrappers}{$cwname}{SubCalls}{$called_sub}{ArgStr};
                (my $called_sub_args_tbl,my $called_sub_args_lst) = get_called_sub_args($arg_str );

                $subs->{$current_sub}{KernelWrappers}{$cwname}{SubCalls}{$called_sub}{Args} = $called_sub_args_tbl;
                $subs->{$current_sub}{KernelWrappers}{$cwname}{SubCalls}{$called_sub}{Module} = $all_subs_modules->{$called_sub};
                (my $called_sub_arg_decls,my $arg_names, my $const_arg_names) = parse_arg_decls($var_lines, $called_sub_args_tbl);
# FIXME: as there can be multiple calls, we must merge the obtained args into wrapper args. 
                $wrapper_args->{Names} = ordered_union($wrapper_args->{Names},$called_sub_args_lst);#[@{$arg_names},@{$const_arg_names}]);
                $wrapper_args->{Decls} = { %{ $wrapper_args->{Decls} }, %{ $called_sub_arg_decls } };
# for every called sub, find its module and add it to the list in KernelWrappers
            }

            $subs->{$current_sub}{KernelWrappers}{$cwname}{Args} = $wrapper_args,;
#            say "WRAPPER ARGSTR: ".join(',', @{  $subs->{$current_sub}{KernelWrappers}{$cwname}{Args}{Names} }) if $VV;
        }

    }
# At this point, we can create the wrappers. If the wrapper only contains sub calls, we create a single kernel, otherwise separate kernels.
# So, the wrapper sub gets the union of all arguments of all called subs
# It also gets a Kernel pragma, or a list of them
    for my $current_sub (keys %{$subs}) {
        say "! SUB:$current_sub" if $VV;
        for my $cwname (@{$subs->{$current_sub}{KernelWrapperNames}}){
            say "! WRAPPER: $cwname" if $VV;
            my $wrapper_info=$subs->{$current_sub}{KernelWrappers}{$cwname};
            $wrapper_info = generate_acc_wrapper($wrapper_info,1);
            my $ocl_wrapper_src_lines = $wrapper_info->{WrapperCode};
            show($ocl_wrapper_src_lines);
            generate_file($ocl_wrapper_src_lines, "../OpenCL/WrapperTemplates/${cwname}_TEMPL_V2.f95");
            $wrapper_info  = generate_acc_wrapper($wrapper_info,2);
            
            my $ocl_kernel_precursor_src_lines = $wrapper_info->{KernelPrecursorCode};
            my $kname=$wrapper_info->{KernelFileName};
            show($ocl_kernel_precursor_src_lines);
            generate_file($ocl_kernel_precursor_src_lines, "../OpenCL/KernelStubs/$kname.f95");
            $subs->{$current_sub}{KernelWrappers}{$cwname}=$wrapper_info;
# We then need to add the module file for the wrapper to the main module list
            push @{ $subs->{$current_sub}{Modules} }, 'module_'.$cwname;
#            die;
        }        
    }

# At that point we can create the main program, with the revised module list and the call to the wrapper sub
# The absolute cheapest way is of course simply to add the extra module and replace the code from the pragma by the wrapper subroutine call
# But anyhow, we need at the very least to detect where to put this extra use statement, and the pragma, so we need a minimal parse. 
# Also, we need easy access to the subcall lines from  the second pass. So I think I should put these lines into %subs, by returning $wrapper_info


    my $ocl_main_src_lines = generate_acc_main($src, $subs);
    print "\n\n! GENERATED MAIN $src_gen from $src_templ\n\n";
    show($ocl_main_src_lines);
    generate_file($ocl_main_src_lines, $src_gen); 
}

main();

#!/usr/bin/perl
use strict;
use warnings; 
use 5.010;
use F95ArgDeclParser qw( parse_F95_arg_decl );
use F95Normaliser qw( normalise_F95_src );

use Data::Dumper;
$Data::Dumper::Indent=1;#0;
$Data::Dumper::Terse =1;
our $VV= 0;

our $src_templ= $ARGV[0] // 'main.f95';
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
} # END of get_C_type();

# For every sub we find, we must return all kernels. So we must have a record for this
sub parse_F95_src {
    (my $src)=@_;
    open my $IN, '<', $src or die "$src: $!";
    my @orig_lines=<$IN>;
    close $IN;
    my $src_lines = normalise_F95_src(\@orig_lines);

    my $in_sub=0;
    my $in_kernel=0;
    my $var_lines=[];
    my $par_lines=[];
    my $subs={};
    my $current_sub='';
    my $current_kernel_wrapper='';

    for my $line (@{$src_lines}) {
		next if $line=~/^\s*$/;
		next if ($line=~/^\s*[*!]/ || ($line=~/^C/i)) && $line !~/^\s*!\s*\$/; # We only support !$ACC, not c,C or *

        $line=~/^\s+(subroutine|program)\s+(\w+)/ && do {
            $in_sub=1;
            $current_sub=$1;
            $subs->{$current_sub}={};
            next;
        };    

        $in_sub && $line=~/^\s+end\s+(subroutine|program)/ && do {
            $in_sub=0;
            @{$subs->{$current_sub}{VarLines}}=@{$var_lines};
            @{$subs->{$current_sub}{ParLines}}=@{$par_lines};
            $current_sub='';
            $var_lines=[];
            $par_lines=[];
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
        
        $line=~/^\s*\!\s*\$ACC\s+KernelWrapper\s*\((\w+)\)/i && do {
            $in_kernel=1;
            $current_kernel_wrapper=$1;
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
            $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{SubCalls}{$kernel_sub}{ArgStr}=$args_str;
           }
            push @{ $subs->{$current_sub}{KernelWrappers}{$current_kernel_wrapper}{Lines}},$line;
        }
        $line=~/^\s+use\s(\w+)/ && do {
            my $module_name = $1;
            push @{  $subs->{$current_sub}{Modules} }, $module_name;
        };
    }
      if(  $in_sub ) {
            @{$subs->{$current_sub}{VarLines}}=@{$var_lines};
            @{$subs->{$current_sub}{ParLines}}=@{$par_lines};
        }      
    return ($src_lines,$subs);
} # END of parse_F95_src

#-------------------------------------------------------------------------------- 
# Code for parsing the argument declarations
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
        my $pt = parse_F95_arg_decl($str);
        print Dumper($pt),"\n" if $vv;
        my $type = $pt->{TypeTup}{Type};
        my $wordsz = $pt->{TypeTup}{Kind};
        my $ndims = scalar @{ $pt->{Dim} };
        if ($ndims==1 && $pt->{Dim}[0]!~/:/ && $pt->{Dim}[0] ==0) {
            $ndims=0;
        }
        my @var_names=@{ $pt->{Args} };
        @arg_names=(@arg_names, @var_names);
        my $argmode =  $ndims==0 ? 'Const' : $pt->{AccPragma}{AccVal};
        if ($argmode eq 'ReadWrite') {
# check intent
            if (exists $pt->{Intent}) {
                my $intent = $pt->{Intent};
                if ($intent ne 'InOut') {
                    $argmode = ($intent eq 'In') ? 'Read' : 'Write' ;
                }
            }
        } 

# Now I overload ArgMode to indicate if a value is const. Simply, any scalar is a const. 
        say "$type,$wordsz,$ndims ",@var_names, " $argmode" if $vv;
        for my $arg_name (@var_names) {                
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

                $ocl_args{$arg_name}{ArgMode} = $argmode;
                $ocl_args{$arg_name}{Dim} = $ndims;
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
    return {  %argtable };
}
#-------------------------------------------------------------------------------- 
sub generate_ocl_wrapper { (my $subs)=@_;
    my $gen_src_lines=[];
    return $gen_src_lines;
} # END of generate_OclWrapper_code()
#-------------------------------------------------------------------------------- 

# Find the sources, check the module name and find all subs in each source.
sub find_modules { (my $subs)=@_;
    my @all_sources=glob('*.f95'); # FIXME: WEAK! Assumes all sources are in a single folder. Need an approach similar to rf4a
        my $all_subs_modules={}; # for every sub, its module   
        for my $src ( @all_sources ) {
            my $subs_in_module = get_subs_in_module($src); # for every sub, list the module name
                for my $sub (keys %{$subs_in_module}) {
                    my $module=$subs_in_module->{$sub};
                    $all_subs_modules->{$sub}=$module;
                }
        }
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
        $line=~/^\s+module\s+(\w+)/ && do {
            $current_module=$1;
            next;
        };
        $line=~/^\s+subroutine\s+(\w+)/ && do {
            my $current_sub=$1;
            $subs_in_module->{$current_sub}=$current_module;
            next;
        };
    }
    close $SRC;
    return $subs_in_module;
} # END of get_subs_in_module()

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
    (my $src_lines,my $subs) = parse_F95_src($src_templ);
# Find modules for called subs in wrapper and outside. Make list of modules that occur in wrapper, and others that occur in main 
    my $all_subs_modules = find_modules($subs);

# Analyse called sub arguments for every called sub in wrapper. For each of the variables, add the declaration to the wrapper. 
    for my $current_sub (keys %{$subs}) {
        say "SUB:$current_sub" if $VV;
# Actually, at this point we know the called subs, so we can add the modules to them
        for my $called_sub ( keys %{ $subs->{$current_sub}{CalledSubs} } ){
             $subs->{$current_sub}{CalledSubs}{$called_sub}{Module}=$all_subs_modules->{$called_sub};
        }
        my $var_lines = $subs->{$current_sub}{VarLines};
        for my $ckname (keys %{$subs->{$current_sub}{KernelWrappers}}) {
            say "KERNEL WRAPPER:$ckname" if $VV;
            for my $called_sub ( keys %{ $subs->{$current_sub}{KernelWrappers}{$ckname}{SubCalls} } ){
                my $arg_str= $subs->{$current_sub}{KernelWrappers}{$ckname}{SubCalls}{$called_sub}{ArgStr};
                my $called_sub_args = get_called_sub_args($arg_str );
                $subs->{$current_sub}{KernelWrappers}{$ckname}{SubCalls}{$called_sub}{Args} = $called_sub_args;
                $subs->{$current_sub}{KernelWrappers}{$ckname}{SubCalls}{$called_sub}{Module} = $all_subs_modules->{$called_sub};
                (my $called_sub_arg_decls,my $arg_names, my $const_arg_names) = parse_arg_decls($var_lines, $called_sub_args);
# FIXME: as there can be multiple calls, we must merge the obtained args into wrapper args. 
                $subs->{$current_sub}{KernelWrappers}{$ckname}{Args}=merge_args($subs->{$current_sub}{KernelWrappers}{$ckname}{Args},$called_sub_arg_decls,$arg_names,$const_arg_names);
# for every called sub, find its module and add it to the list in KernelWrappers
            }
        }
    }
# At this point, we can create the wrapper. If the wrapper only contains sub calls, we create a single kernel, otherwise separate kernels.
# So, the wrapper sub gets the union of all arguments of all called subs
# It also gets a Kernel pragma, or a list of them
    my $ocl_wrapper_src_lines = generate_ocl_wrapper($subs);
    map {say $_} @{$ocl_wrapper_src_lines};
# We then need to add the module file for the wrapper to the main module list
# At that point we can create the main program, with the revised module list and the call to the wrapper sub
    my $ocl_main_src_lines = generate_ocl_main($src_lines, $subs);
    map {say $_} @{$ocl_main_src_lines};
}



main();

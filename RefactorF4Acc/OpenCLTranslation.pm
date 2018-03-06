package RefactorF4Acc::OpenCLTranslation;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::OpenCLTranslation::ISA = qw(Exporter);

@RefactorF4Acc::OpenCLTranslation::EXPORT_OK = qw(
  &translate_to_OpenCL
);
# Actually, $stref is not used!
sub translate_to_OpenCL {
    ( my $stref, my $mod_name, my $kernel_name, my $macro_src, my $stand_alone, my $consts ) = @_;
    
    if (not $stand_alone) {
 
		    my $retval = _preprocess( $stref, $mod_name );
		    ( $stref, my $prep_src_lines, my $can_be_consts ) = @{$retval};
		    my $f_src = $mod_name.'_ocl.f95';
	    if (defined $macro_src and $macro_src ne 'NO_MACROS') {		    
		    _run_cpp (  $f_src,  $prep_src_lines, $macro_src, $stand_alone );
	    }
		    _generate_C($mod_name, $f_src, {'Consts' => $can_be_consts, 'Locals'=>{}}, $kernel_name);
#	    } else {
#	    	die "Sorry, you must specify a macro source unless you use -S";
#	    }
    } else {
    	my $f_src=$mod_name.'.f95';
		my %locals = _preprocess_standalone( $f_src);
		my $f_src_fix=$mod_name.'.f95.FIX';		
		_run_cpp (  $f_src_fix,  [], $macro_src,  $stand_alone);    	    	
		_generate_C($mod_name, $f_src_fix, {'Locals' =>\%locals, 'Consts' =>$consts }, $kernel_name);
    }
    return $stref;
}    # END of translate_to_OpenCL()

#  -----------------------------------------------------------------------------
=pod

To test: gfortran-mp-4.9 -c -Wall -ffree-form -ffree-line-length-0

We need to inline all subroutines called from the kernel subroutine. Also, in general a module
can contain several subroutines, so we should provide the name of the kernel subroutine as well as the 
module name.
Then, we need an inventory of all subroutines called from inside the kernel, via CalledSubs
We also need to know what subroutines are contained in a module. 
From Modules->Source we can easily obtain the module for each source;
From Subroutines->Source we can easily obtain the source for a subroutine. Thus we get all modules that need to be inlined; the others can actually be omitted!
This is of course very similar to the call tree. 
So what we need is get the call tree information for the current module and inline all the called subroutines.
This is of course a bit weak, it can only work if the subroutine is part of an inlineable module, otherwise the global variables will not be visible. But in that case it can't work as a kernel anyway.
So we need to test if the module to which a sub belongs is inlineable.

The call tree information at the moment is the subroutine and its source
So let the routine create_call_graph() return a table of subroutine => source and let's take it from there.

So now we know how to find all subs to be inlined and also if their parent modules allow inlining of subs. So what I need to do is find all subs to be inlined,
then test if the module has 'InlineableSubs'=1
=cut

#  -----------------------------------------------------------------------------
sub _preprocess {
    ( my $stref, my $mod_name ) = @_;
    my $refactored_annlines     = [];
    
    my $can_be_consts = {};
    my $sub_table ={};
    my $emit_contains = 1;
    get_subs_to_be_inlined ($stref, $mod_name,$sub_table );
	my $annlines = get_annotated_sourcelines($stref,$mod_name);
	my $case_var='';
	my $first_case=1;
    for my $annline ( @{ $annlines } ) {
        ( my $line, my $info ) = @{$annline};
        say $line;
#        next if _skip_IO($info);
#        next if _skip_return($info);

		# Replace select/case by if/then
		if ($line=~/select\s+case/) { croak Dumper($annline); }
		if (exists $info->{'Select'})  {
			 $case_var =$info->{'CaseVar'};
			 } elsif (exists $info->{'CaseDefault'})  {
				my $indent=$line;
				$indent=~s/case.+$//;
				$line = $indent.'else';	 	
			 } elsif (exists $info->{'Case'})  {
			my $maybe_else= ($first_case==1) ? '' : 'else ';
			my $indent=$line;
			$indent=~s/case.+$//;
			my $cond_str="$case_var == ";
			if (scalar @{$info->{'CaseVals'}}==1) {
				$cond_str.=$info->{'CaseVals'}[0];
			} else {
				my @conds=();
				for my $case_val ( @{$info->{'CaseVals'}} ) {
					push @conds, $cond_str.$case_val;
				}
				$cond_str = join(' .or. ',@conds);
			}			
			$line= $indent.$maybe_else.'if ('.$cond_str.') then';
		}			 
		if (exists $info->{'EndSelect'})  {
			$line=~s/select/if/;	 
		}	 
# We need to check if a variable can be a scalar constant. The rule we use is: it is a scalar and the intent is In

        if ( exists $info->{'ParsedVarDecl'}
            and lc($info->{'ParsedVarDecl'}{'Attributes'}{'Intent'}) eq 'in'
            and $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}->[0] eq '0' )
        {
            for my $var_name ( @{ $info->{'ParsedVarDecl'}{'Vars'} } ) {
                $can_be_consts->{$var_name} = 1;
            }
            
        }
# If a module is marked as Inlineable the inline it. The rule for this is defined in _can_be_inlined() in Inventory
        if (    exists $info->{'Use'} ) {
            my $inlined_mod_name = $info->{'Use'}{'Name'};  
           if ( $stref->{'Modules'}{$inlined_mod_name}{'Inlineable'} == 1) { # OK, this module is going to be inlined. So I must emit a 'contains' here, but only once.
           if ($emit_contains) {
               push @{$refactored_annlines},['    contains',{'Contains'=>1}];
               $emit_contains=0;
           }
# FIXME: if the next used module is not going to be inlined, should it be moved up?            
            my $mod_lines = _inline_module( $stref, $inlined_mod_name );
            $refactored_annlines = [ @{$refactored_annlines}, @{$mod_lines} ];
            next;
           }
           
           if ($stref->{'Modules'}{$inlined_mod_name}{'InlineableSubs'} == 1) {
            if ($emit_contains) {
               push @{$refactored_annlines},['    contains',{'Contains'=>1}];
               $emit_contains=0;
           }
            
            my $sub_lines = _inline_subs( $stref, $inlined_mod_name,$sub_table); 
            $refactored_annlines = [ @{$refactored_annlines}, @{$sub_lines} ];
            next;
            
            } 

        }
        
        push @{$refactored_annlines}, $annline unless exists $info->{'Comments'};
    }
    
    my $refactored_lines     = [];
    push @{$refactored_annlines}, ['',{'Blank'=>{}}];
    
    my $idx=0;
    for  (0 .. @{$refactored_annlines}-1 ) {
        if ($idx > @{$refactored_annlines}-1) {last}
         my $annline=$refactored_annlines->[$idx];
        ( my $line, my $info ) = @{$annline};
        
        #FIXME: this is WEAK! To do it proper we need to do this iteratively until there are no changes anymore.
        # Also, for simplicity I removed the comments but it would be nicer to keep them.
        my $next_annline = $refactored_annlines->[$idx+1];
        
        if (defined $next_annline) {
        (my $next_line, my $next_info ) = @{$next_annline};
        if (exists $info->{'If'} and exists $next_info->{'EndIf'}) {            
            $idx+=2;
            next;
        }
        if (exists $info->{'Do'} and exists $next_info->{'EndDo'}) {            
            $idx+=2;
            next;
        }
        
        } 
       if (not  _skip_IO($info) and not
        _skip_return($info) ) { 
        
        push @{$refactored_lines}, $line;
        
        }
        $idx++;
     }
    return [ $stref, $refactored_lines, $can_be_consts ];
} # END of _preprocess()
#  -----------------------------------------------------------------------------
sub _preprocess_standalone {
    ( my $f_src ) = @_;    
    my %locals=();
       open my $SRC,'<',$f_src;
       open my $SRC_FIX,'>',"$f_src.FIX";
	my $case_var='';
	my $first_case=1;
	while(my $line=<$SRC>) {        
#        say $line;
		# Replace select/case by if/then
		if ($line=~/(\w+)\s+\!\s*\$ACC\s+MemSpace\s+local/) {
			my $local=$1;
			$locals{$local}=1;
#			say "Found local $local";
		}
		if ($line=~/select\s+case\s*\(\s*(\w+)\s*\)/) {   
			 $case_var =$1;
			 next;
		} elsif ($line=~/case\s+default/)  { 
				my $indent=$line;
				$indent=~s/case.+$//;
				$line = $indent.'else';
				croak $line;	 	
		} elsif ($line=~/case\s*\(\s*(.+)\s*\)/)  { 
			 	my $case_val_str=$1; 
			my $maybe_else= ($first_case==1) ? '' : 'else '; 
			if ($first_case==1) {$first_case=0;}
			my $indent=$line;
			$indent=~s/case.+$//;
			my $cond_str="$case_var == ";
			
			
			if ($case_val_str!~/,/) {
				$cond_str.=$case_val_str;
			} else {
				my @conds=();
				my @case_vals=split(/\s*,\s*/,$case_val_str);
				for my $case_val (@case_vals ) {
					push @conds, $cond_str.$case_val;
				}
				$cond_str = join(' .or. ',@conds);
			}			
			$line= $indent.$maybe_else.'if ('.$cond_str.') then'."\n";
			
		}			 
		if ($line=~/end\s+select/)  { 
			$line=~s/select/if/;
				 
		}
#		print $line;
		print $SRC_FIX $line;	
	} 
	close $SRC;
	close $SRC_FIX;
	return %locals;
} # END of _preprocess_standalone()
#  -----------------------------------------------------------------------------
sub _inline_module {
    ( my $stref, my $mod_name ) = @_;
    my $mod_lines = [];
    my $annlines = get_annotated_sourcelines($stref,$mod_name);
    for my $annline ( @{ $annlines } ) {
        ( my $line, my $info ) = @{$annline};
        if (    exists $info->{'Use'}
            and exists $info->{'Use'}{'Inlineable'} )
        {
            my $inlined_mod_name = $info->{'Use'}{'Name'};
            my $nested_mod_lines = _inline_module( $stref, $inlined_mod_name );
            $mod_lines = [ @{$mod_lines}, @{$nested_mod_lines} ];
            next;
        } else {
            if (   exists $info->{'ParsedVarDecl'}
                or exists $info->{'ParsedParDecl'} )
            {
                push @{$mod_lines}, $annline;
            }
        }
    }
    return $mod_lines;
} # END of _inline_module()
#  -----------------------------------------------------------------------------
# So we inline all subs in a module? No, only the ones that are called and their dependencies, i.e. the call graph
sub _inline_subs {
    ( my $stref, my $mod_name, my $sub_table) = @_;
    
    # For a given module
    # - get all subroutines that are also in $sub_table, and inline them;
    # - Get all used modules and do the same
    my $subs_in_module =  $stref->{'Modules'}{$mod_name}{'Subroutines'};
    
    my $sub_lines = []; 
    for my $sub (keys %{$subs_in_module}) {
        if (exists $sub_table->{$sub}) {
            my $annlines = get_annotated_sourcelines($stref,$sub);
            for my $annline (@{ $annlines }) {
                ( my $line, my $info ) = @{$annline};
        if (    exists $info->{'Use'}
            and exists $info->{'Use'}{'Inlineable'} )
        {
            my $inlined_mod_name = $info->{'Use'}{'Name'};
            my $nested_mod_lines = _inline_module( $stref, $inlined_mod_name );
            $sub_lines = [ @{$sub_lines}, @{$nested_mod_lines} ];
            next;
        } else {                
            if (exists $info->{'EndModule'}) { next; } # FIXME! This should be done when extracting the subroutines! 
                push @{$sub_lines}, $annline;
        }
            }
        }
    }
    
    my $used_modules =  $stref->{'Modules'}{$mod_name}{'Uses'};
    
    for my $used_mod (keys %{$used_modules}) {
        if( $stref->{'Modules'}{$used_mod}{'InlineableSubs'} == 1) {
            print "MODULE $used_mod has maybe SUBS TO BE INLINED\n";
            $sub_lines = [_inline_subs($stref, $used_mod, $sub_table), @{$sub_lines}];
        };
    }
    
    return $sub_lines;
} # END of _inline_subs()
#  -----------------------------------------------------------------------------
#  -----------------------------------------------------------------------------
sub _run_cpp {
    ( my $f_src, my $src_lines, my $macro_src, my $stand_alone ) = @_;

if (not $stand_alone) {
    open my $SRC, '>', $f_src;
    for my $line ( @{$src_lines} ) {
        say $SRC $line;
    }
    close $SRC;
}

    if ( not defined $macro_src ) {
        $macro_src = $f_src;
        $macro_src =~ s/\.f95.*$/.h/;
    }

    my @undefined_macros = ();
    my @defined_macros   = ();
    if ( -e $macro_src ) {
        open my $MACROS, '<', $macro_src;
        while ( my $line = <$MACROS> ) {
            next unless $line =~ /^\s*\#/;
            $line =~ /\#define\s+(.+)\s*$/ && do {
                my $pair = $1;
                $pair=~s/\s+/ /g;
                $pair=~s/\s/=/;
                push @defined_macros, $pair;
            };
            $line =~ /\undef\s+(.+)\s*$/ && do {
                push @undefined_macros, $1;
            };
        }
        close $MACROS;
    }

    my $macros = join( ' ', map { "-D$_" } @defined_macros );
    $macros .= ' ' . join( ' ', map { "-U$_" } @undefined_macros );

    if ( not -d 'PostCPP' ) {
        mkdir 'PostCPP';
    }

    say "cpp -P $macros $f_src > PostCPP/$f_src";
    system("cpp -P $macros $f_src > PostCPP/$f_src");

} # END of _run_cpp()

#  -----------------------------------------------------------------------------
sub _generate_C { (my $mod_name, my $src, my $state, my $kernel_name) = @_;
    chdir 'PostCPP';
    system('cp ../*.f95 .');
    open my $FML, '>', 'Fortran_Module_Lookup.txt';
    say $FML "$mod_name $src";
    close $FML;
    my $F2C_HOME=$ENV{F2C_HOME};    
    say "\n$F2C_HOME/bin/F2C-ACC --Free --Generate=C $src";
    
    system("$F2C_HOME/bin/F2C-ACC --Free --Generate=C $src");
#    system("cp $F2C_HOME/include/ftocmacros.h .");      
     my $csrc=$src;
     $csrc=~s/\.f95.*/.c/;
     
    _fix_F2C_ACC_translation($csrc, $state,$kernel_name);
    if (-e $csrc ) {
    	system("cp $csrc ../${csrc}l");
    }
    # TODO 
    # After running F2C_ACC we need to do some cleaning-up:
    # remove the includes/macros: OK
    # Fix the signatures for constants: OK 
    # Replace goto with break
    # function names have trailing underscore, remove
    # add __kernel etc.
    # Other bugs like '--' instead of '+' 

} # END of _generate_C()

#  -----------------------------------------------------------------------------

sub get_subs_to_be_inlined { ( my $stref, my $subname, my $sub_table ) = @_;

    push @{ $stref->{'CallStack'} }, $subname;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 
    for my $entry ( @{ $stref->{'CallTree'}{ $subname } } ) {
        if (exists $subs{$entry}) {
        	print "Found LOOP for $entry\n";
    	   last;
        }

	    	my $src = _get_source($entry,$stref);
	    	$sub_table->{$entry}=$src;
	    	
    }
    pop  @{ $stref->{'CallStack'} };	         
}
# -----------------------------------------------------------------------------

sub _get_source {
	(my $f, my $stref ) = @_;
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $src         = $stref->{$sub_or_func}{$f}{'Source'};
    if (not defined $src) {
    	$src='<unknown source>';
    }
  
	return $src;
}
# We skip any lines that perform IO
sub _skip_IO { (my $info)=@_;
        exists $info->{'Open'} or
        exists $info->{'Print'} or
        exists $info->{'Write'} or
        exists $info->{'Read'} or
        exists $info->{'Close'};
}
# Also skip return statements
sub _skip_return { (my $info)=@_;        

        exists $info->{'Return'};
}
# -----------------------------------------------------------------------------
sub _fix_F2C_ACC_translation { (my $csrc, my $state, my $kernel_name)=@_;
        my $can_be_consts = $state->{'Consts'};
    my $locals = $state->{'Locals'};
    
        if (-e $csrc) {
    rename $csrc, "$csrc.TO_FIX";
       open my $SRC,'<',"$csrc.TO_FIX";
       
       my %sub_names=();
    my @ocl_src_lines=();
    my $null_check=0;
    while(my $line=<$SRC>) {
# remove includes
	if ($line=~/^\s*\#include.+ftocmacros.h/) {
		my @ftocmacros_lines = __gen_ftocmacros_lines();
		for my $line (@ftocmacros_lines ) {
			push @ocl_src_lines, $line;
		}
		next;
	}
    next if $line=~/^\s*\#/;
    next if $line=~/float\s+CLK_(?:GLOB|LOC)AL_MEM_FENCE/;
    next if $line=~/int\s+nth/;
    next if $line=~/int\s+nunits/;
# F2C_ACC has a bug that causes expressions with '--' etc to be generated. Fix that.        
        while ( $line=~/(([\+-]+\d+){2,})/) {
            my $orig_expr=$1;
            my $raw_expr= $1;
            $raw_expr=~s/--/+/g;
            $raw_expr=~s/-\+/-/g;
            $raw_expr=~s/\+-/-/g;
            $raw_expr=~s/\+\+/+/g;
            my $val=eval($raw_expr);
            my $sval=($val<0) ? $val : '+'.$val;
            $orig_expr=~s/\+/\\+/g;
            $line=~s/$orig_expr/$sval/;
        }
        # FIXME: WEAK: should do this until no more matches
        $line=~s/\bpowf\(/pow(/;
        $line=~s/\babs\(/fabs(/;
        $line=~s/MAX\(/max(/;
        $line=~s/MIN\(/min(/;
# F2C_ACC for some reason creates subroutine names with a trailing underscore, fix that:
        $line=~/^(\s*)void\s+(\w+)\((.+)$/ && do {  $line = '// '.$line; };
                $line=~/^(\s*)void\s+(\w+?)_ \((.+)$/ && do {
                    my $sub_name = $2;
                    $sub_names{$sub_name}=[];
                    my $nline = "$1void $sub_name($3";
                    $line = $nline;
                }; 
        $line=~/^(\s*)void\s+$kernel_name\((.+?\{)$/ && do {  
            $line = $1.'__kernel void '.$kernel_name.'('.$2; }; # FIXME: must be the subroutine with the right name!
# malloc needs to become static array
        #  float *local_rhsav_array = (float*) malloc((64)*sizeof(float));
        $line=~/malloc/ && do {
        	$line=~s/\*//;
        	$line=~s/..sizeof.+$/];/;
        	$line=~s/=.+malloc../[/;        	
        };    
# delete calls to free()
$line=~/^\s*free\s*\(/ && do {next;};        
# remove any checks for NULL
		
		$line=~/NULL/ && do {
			$null_check=1;
			next;		
		};
		if ($null_check==1) {
			if ($line=~/^\s+\}\s*$/) {
			$null_check=0;
			}
			next;									
		}
		
# Fix OpenCL API call syntax

$line=~/(get_local_size|get_local_id|get_group_id|get_num_groups|get_group_size|get_global_id)\s*\(\s*(\w+)\s*,\s*(\d+)\s*\)/ && do {
	$line = '    '.$2.' = '.$1.'('.$3.');'."\n";
};
#  get_local_id( local_id,0 );
#  get_group_id( group_id,0 );
#  get_num_groups( num_groups,0 );
#  get_group_size( group_size,0 );
#  get_global_id( global_id,0 );

# barrier fix: force upper case
	$line=~/(CLK_(GLOBAL|LOCAL)_MEM_FENCE)/i && do {
		my $flag=$1;
		my $ucflag=uc($flag);
		$line=~s/$flag/$ucflag/;
	};
	$line=~/(nth)/i && do { # very AD-HOC!
		my $flag=$1;
		my $ucflag=uc($flag);
		$line=~s/$flag/$ucflag/g;
	};
	$line=~/(nunits)/i && do { # very AD-HOC!
		my $flag=$1;
		my $ucflag=uc($flag);
		$line=~s/$flag/$ucflag/g;
	};	
# Replace goto with break:
    	$line=~/(goto\s+C__\d+)/ && do {
        	my $goto = $1;
        	$line=~s/$goto/break/;
    	};     
    	$line=~/\d+\s+continue/ && ($line="\n");
    	push @ocl_src_lines, $line;
    	
	} # END of loop over src lines
    close $SRC;

    my %consts=();       
    my @ext_vars=();
    my @ocl_src_lines_tf1=();
    
    for my $line (@ocl_src_lines) {
    	
        # Split sub name and args in declarations
        my $tline=$line;
#        $tline=~s/\s+//g;

        $tline=~/(\w+)\s*\(\s*((?:\w+,)+\w+)\s*\)\s*;/ && do { # <subname> ( <...> ); 
          my $sub_name = $1;
          my $argstr=$2;
          
          my @args=split(/,/,$argstr);
          $sub_names{$sub_name} = [@args]; 
        };
        $tline=~/(\w+)\s*\(\s*(\w+)\s*\)\s*;/ && do { # <subname> ( <...> ); 
          my $sub_name = $1;
          my $argstr=$2;
#          say "$sub_name $argstr";           
          $sub_names{$sub_name} = [$argstr]; 
        };        
        $line=~/extern\s+(\w+)\s+(.+)\s*;\s*$/ && do {
        	$line=~s/extern\s+//; # HACK? 
        };
        $line=~/^\s*(\w+)(?:\s+\w+)?\s+(\w+)\s*\[/ && do { #HACKY: I assume only local statically defined arrays can be __local, and also that they are not unsigned int etc. weak!
        	my $type=$1;
        	my $maybe_local=$2;
        	if (exists $locals->{$maybe_local}) {
#        		say "LOCAL $type $maybe_local";
				$line=~s/$type/__local $type/;
#				say $line;	
        	}
        };
#        $line=~/extern\s+(\w+)\s+(.+)\s*;\s*$/ && do {
#            my $type=$1;
#            my $ext_varstr = $2;
#            $ext_varstr=~s/\*//g;
#            @ext_vars=(@ext_vars, map { ["const $type ",$_] } split(/\s*,\s*/,$ext_varstr));
#           next; 
#        };

#        $line=~/^\s*(\w+)\s+(\w+)\s*=\s*\*H_(\w+);$/ && do {
#            my $type=$1;
#            my $const_varstr = $2;
#            $consts{ 'H_'.${const_varstr} }=$const_varstr;
#            next;
#        };

    # Here we check for scalar constants that are parameters
    $line=~/^(\s*)(\w+)\s+(\w+)\s*=\s*(\-?\d*\.?\d*F?);$/ && do { # FIXME: only works for integers and simple floats, no x.yEz notation
    my $ws=$1;
            my $type=$2;
            my $const_varstr = $3;
            my $val=$4;
            $line = $ws.'const '.$type.' '.$const_varstr.' = '.$val.';'."\n";
    };
    # Here we check for scalar constants that are arguments    
        $line=~/^\s*(\w+)\s+(\w+)\s*=\s*\*(\w+)__G;$/ && do {
            my $type=$1;
            my $const_varstr = $2;
            if( exists $can_be_consts->{$const_varstr}) {
                $consts{ ${const_varstr}.'__G'}=$const_varstr;
                next;
            } else {
               warn "NOT A CONST, KEEP ".${const_varstr}.'__G'; # was die()
            }
        };
        push @ocl_src_lines_tf1, $line;
    }
    

     my @ocl_src_lines_tf2=();
# An extra complication is that the arguments for the functions called from the kernel must be in the same memory space as the kernel arguments.
# That is quite difficult. I need to see how the functions are called, if any of the args is a global, and if so, change the corresponding argument.

	my %global_args=(); 
    for my $line ( @ocl_src_lines_tf1 ) {
        $line=~/void.+\{/ && do {
            my $argstr = $line;
            (my $pre,my $args_post)=split(/\(/,$argstr);
            (my $args, my $post) = split(/\)/,$args_post);
            my @args=split(/\s*,\s*/,$args);
            
            my $new_arg_str='';
            my $idx=0;
            for my $arg (@args) {
                my $argn=$arg;
                (my $argt,  $argn)=split(/\s\*/,$arg);
                if (exists $consts{$argn}) {
                     $new_arg_str .= 'const '.$argt. ' '. $consts{$argn}.',';
                } else {
                    if ($line=~/__kernel/) {
                     $new_arg_str .= '__global '.$argt. ' *'. $argn.',';
                     $global_args{$argn}=$argt;
                    } else {
                        # What we should do here is check if the argument is an argument of the kernel                         
                        $new_arg_str .= '__MAYBE__'.$idx.' '.$argt. ' *'. $argn.',';
                    }
                }
                $idx++;
            }
            $new_arg_str=~s/,$//;
            my $new_kline = $pre.'('.$new_arg_str.')'.$post;
             push @ocl_src_lines_tf2, $new_kline;
             next;
        };
        push @ocl_src_lines_tf2, $line;
    }
    
    my @ocl_src_lines_tf3=();
    for my $line ( @ocl_src_lines_tf2 ) {
        $line=~/void.(\w+).+__MAYBE__/ && do {
        	
            my $sub_name=$1;
            my $sub_args = $sub_names{$sub_name}; # sub args from call
            my $idx=0;
            for my $sub_arg (@{$sub_args}) {
            	
                if (exists $global_args{$sub_arg}) {
                    $line=~s/__MAYBE__$idx/__global/;                    
                } elsif (exists $locals->{$sub_arg}) {
#                	say "LOCAL $sub_arg!";
                    $line=~s/__MAYBE__$idx/__local/;                       
                } else {
                    $line=~s/__MAYBE__$idx//;    
                }  
                    $idx++;
            }             
            
        };
        push @ocl_src_lines_tf3, $line;
    }
    
    say 'GENERATE FIXED KERNEL SRC' if $V; 

    open my $FIXED_SRC,'>',$csrc;
    for my $line (@ocl_src_lines_tf3) {
        print $FIXED_SRC $line;
    }    
    close $FIXED_SRC;
       
    } else {
        warn "There is no $csrc\n";
    }
 
} # END if _fix_F2C_ACC_translation()

# -----------------------------------------------------------------------------
sub __gen_ftocmacros_lines {
	my $ftoc_str ='
inline unsigned int FTNREF3D(
                int ix, int jx, int kx,
                        unsigned int iz,unsigned int jz,
                                int i_lb, int j_lb, int k_lb
                                        ) {
        return (iz*jz*(kx-k_lb)+iz*(jx-j_lb)+ix-i_lb);
}

inline unsigned int FTNREF2D(
                int ix, int jx,
                        unsigned int iz,
                                int i_lb, int j_lb
                                        ) {
	return (iz)*(jx-(j_lb))+ix-i_lb;        
}

inline unsigned int FTNREF3D0(
                int ix, int jx, int kx,
                        unsigned int iz,unsigned int jz
                                ) {
        return iz*jz*kx+iz*jx+ix ;
}

inline unsigned int FTNREF1D(int ix,int i_lb) {
            return ix-i_lb;
}


// These functions take the lower and upper bounds, rather than the range and the lower bound
inline unsigned int FTNREF3Du(int ix,int jx,int kx,unsigned int i_ub,unsigned int j_ub,int i_lb,int j_lb,int k_lb) {
    return (i_ub - i_lb + 1)*(j_ub - j_lb + 1)*(kx - k_lb)+(i_ub - i_lb + 1)*(jx - j_lb)+(ix - i_lb);
}
// For lower bounds all 0
inline unsigned int FTNREF3Du0(int ix,int jx,int kx,unsigned int i_ub,unsigned int j_ub) {
    return (i_ub + 1)*(j_ub + 1)*kx+(i_ub + 1)*jx+ix;
}
';

	return 	map { "$_\n"} split(/\n/,$ftoc_str);
}
# -----------------------------------------------------------------------------

1;

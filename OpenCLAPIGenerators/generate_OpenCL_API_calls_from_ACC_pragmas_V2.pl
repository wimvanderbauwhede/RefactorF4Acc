#!/usr/bin/perl
use strict;
use warnings; 
use 5.010;
use F95ArgDeclParser;

use Data::Dumper;
$Data::Dumper::Indent=1;#0;
$Data::Dumper::Terse =1;

use Getopt::Std;
our $VV= 0;
our $vv=0;
our $kernel_path='../OpenCL';
main();

=head1 How to use this script?

- Create a template for the Fortran OpenCL wrapper routine.
This is a module that contains a routine with exactly the same signature as the original routine.

    module module_${NAME}_ocl_wrapper
        use module_LES_conversions
        use module_${NAME} ! the original module
    contains

      subroutine ${NAME}_ocl_wrapper(km,jm,im,p,ro,dxs,u,dt,f,dys,v,g,dzs,w,h)
          use common_sn 

          implicit none

           ! Type declarations
        
           ! Any other code here, typically to transform between the types of the arguments
           ! of the wrapper and those of the kernel
           ! e.g. call convert_to_uvw(u,v,w,uvw)

It contains a call to the actual routine that does the work, wrapped in an OpenACC-style pragma, the Kernel attribute 

I typically use the original name. The script then looks for a module with name
${NAME}_kernel.f95, which should contain a stub for a subroutine called ${NAME}_kernel or whatever the $ACC Kernel attribute is.

    !$ACC Kernel(${NAME}_kernel), GlobalRange($globalRange), LocalRange($localRange) 
            call ${NAME}(arg1, arg2, ...)
    !$ACC End Kernel

           ! Any other code here, typically to transform between the types of the arguments
           ! of the wrapper and those of the kernel
           ! e.g. call convert_from_fgh(fgh,f,g,h)

        end subroutine ${NAME}_ocl_wrapper
    end module  ${NAME}_ocl_wrapper


=head1 Sequence of actions:

 1/ detect arguments and argmodes, make a list of arguments

 2/ detect entry for new declarations for buffers and sizes; generate code and insert there

 3/ detect entry for API calls; generate code and insert there

* I should incorporate this into rf4a 
* In fact, although I should probably stick to the OpenACC standard. However, instead I'm defining these:

!$ACC Arguments
...
!$ACC End Arguments

!$ACC ArgMode [Read|Write|ReadWrite]

!$ACC 

=cut


sub gen_OpenCL_API_calls {
    (my $ocl_args_r, my $arg_names_r, my $const_arg_names_r,my $src_lines_r) = @_;
    my %ocl_args=%{$ocl_args_r};
    my @arg_names = @{$arg_names_r};
    my @const_arg_names = @{$const_arg_names_r};
    my @src_lines=@{$src_lines_r};
    my @gen_src_lines=();
#    push @gen_src_lines,  "!!! This code was generated on ".scalar( localtime())." from $src_templ using $0";
#    push @gen_src_lines,  "!!! DON'T EDIT !!! Edit $src_templ instead, and regenerate.";
    for my $line (@src_lines) {
        push @gen_src_lines,  $line unless $line=~/^\s*\!\s*\$ACC/;
        if ($line=~/^\s*\!\s*\$ACC\s+BufDecls/i) {
            push @gen_src_lines,  '! OpenCL buffer declarations';
            for my $arg_name ( @arg_names) {
                my $str = "integer(8) :: ${arg_name}_buf";
                push @gen_src_lines,   $str;
            }
        }
        if ($line=~/^\s*\!\s*\$ACC\s+SizeDecls/i) {
            push @gen_src_lines,   '! OpenCL buffer size declarations';
            for my $arg_name ( @arg_names) {
                my $dim = $ocl_args{$arg_name}{Dim};
                my $str = "integer, dimension($dim):: ${arg_name}_sz";
                push @gen_src_lines,   $str;
            }
        }

        if ($line=~/^\s*\!\s*\$ACC\s+MakeSizes/i) {
            push @gen_src_lines,   '! OpenCL buffer sizes';
            for my $arg_name ( @arg_names) {
				my $VVstr= "print *, '${arg_name}_sz: ',${arg_name}_sz ";
                my $str = "${arg_name}_sz = shape($arg_name)";
                push @gen_src_lines,   $str;
				push @gen_src_lines,   $VVstr if $VV;
            }
        }

        if ($line=~/^\s*\!\s*\$ACC\s+MakeBuffers/i) {
            push @gen_src_lines,   '! Create OpenCL buffers';
            for my $arg_name ( @arg_names) {
                my $dim = $ocl_args{$arg_name}{Dim};
                my $argmode = $ocl_args{$arg_name}{ArgMode};
                my $ctype = ucfirst( $ocl_args{$arg_name}{CType} );
                my $VVstr = "print *, '$arg_name'";                
                my $m_arg_name = $argmode eq 'Write' ? '' : ",$arg_name";
                my $str = "call oclMake${dim}D${ctype}Array${argmode}Buffer(${arg_name}_buf,${arg_name}_sz $m_arg_name)";
#say  $str;
                push @gen_src_lines,   $VVstr if $VV;
                push @gen_src_lines,   $str;
            }
        }

        if ($line=~/^\s*\!\s*\$ACC\s+SetArgs/i) {
            push @gen_src_lines,   '! Set OpenCL argument order';
#            my $argpos=0;
            my @ordered_arg_names = ();
            for my $arg_name ( @arg_names) {
                my $argpos = $ocl_args{$arg_name}{ArgPos};
                $ordered_arg_names[$argpos] = $arg_name;
            }
            for my $arg_name ( @ordered_arg_names) {
                next unless defined $arg_name; # this skips the const args
                my $argpos = $ocl_args{$arg_name}{ArgPos};
                my $ctype = ucfirst( $ocl_args{$arg_name}{CType} );
				my $VVstr = "print *, ' ${arg_name}_buf: ', $argpos";
                my $str = "call oclSet${ctype}ArrayArg($argpos, ${arg_name}_buf )";
                push @gen_src_lines,   $VVstr if $VV;
                push @gen_src_lines,   $str;
#                $argpos++;
            }
            my @ordered_const_arg_names = ();# @const_arg_names;
            for my $arg_name ( @const_arg_names) {
                my $argpos = $ocl_args{$arg_name}{ArgPos};
                $ordered_const_arg_names[$argpos] = $arg_name;
                
            }
            
            for my $const_arg_name ( @ordered_const_arg_names) {
                                if ($const_arg_name) {
                my $argpos = $ocl_args{$const_arg_name}{ArgPos};
                my $ctype = ucfirst( $ocl_args{$const_arg_name}{CType} );
				my $VVstr = "print *, ' $const_arg_name: ', $argpos";
                my $str = "call oclSet${ctype}ConstArg($argpos, $const_arg_name )";
                push @gen_src_lines,   $VVstr if $VV;
                push @gen_src_lines,   $str;
#                $argpos++;
                                }
            }

#            $argpos=0;
            for my $arg_name ( @arg_names) {
                my $ctype = lc( $ocl_args{$arg_name}{CType} );
                my $dim = $ocl_args{$arg_name}{Dim};
                $dim = ($dim == 1) ? ''  : $dim;
#                my $str = "__global ${ctype}$dim * ${arg_name}_buf,";
#                push @gen_src_lines,  '!',  $str;
#                $argpos++;
            }
#            for my $const_arg_name ( @const_arg_names) {
#                my $ctype = lc( $ocl_args{$const_arg_name}{CType} );
#                my $str = "const ${ctype} $const_arg_name,";
#                push @gen_src_lines,  '!',  $str;
#                $argpos++;
#            }            

        }
        if ($line=~/^\s*\!\s*\$ACC\s+WriteBuffers/i) {
            push @gen_src_lines,   '! Copy all arrays required for the full run';
            for my $arg_name ( @arg_names) {
                 my $dim = $ocl_args{$arg_name}{Dim};
                 my $ctype = ucfirst( $ocl_args{$arg_name}{CType} );
                if ($ocl_args{$arg_name}{ArgMode} ne 'Write') {
                    my $str="call oclWrite${dim}D${ctype}ArrayBuffer(${arg_name}_buf,${arg_name}_sz,$arg_name)";
                    push @gen_src_lines,   $str;
                }
            }
        }
        if ($line=~/^\s*\!\s*\$ACC\s+ReadBuffers/i) {
            push @gen_src_lines,   '! Read back Read and ReadWrite arrays';
            for my $arg_name ( @arg_names) {
                 my $dim = $ocl_args{$arg_name}{Dim};
                 my $ctype = ucfirst( $ocl_args{$arg_name}{CType} );
                if ($ocl_args{$arg_name}{ArgMode} ne 'Read') {
                    my $str="call oclRead${dim}D${ctype}ArrayBuffer(${arg_name}_buf,${arg_name}_sz,$arg_name)";
                    push @gen_src_lines,   $str;
                }
            }
        }
    }
    return [@gen_src_lines];
} # END of gen_OpenCL_API_calls()

sub get_c_type {
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

} # END of get_c_type()

=head1 Datastructures

=head2 Datastructure for kernels and subroutines

For every sub we find, we must return all kernels. So we must have a record for this

  $subs = {
    $current_sub => {
        VarLines=>$var_lines,
        ParLines=>$par_lines,
        Kernels =>{
          $current_kernel =>{
            GlobalRange=>$grange;
            LocalRange=>$lrange;
            SubName => $kernel_sub
            SubArgs => $args_str
        }, 
          ...
    }, 
        ...
  };    

=cut
# This is a very simple regex-based parser for 
#   - subroutine declarations and calls, 
#   - parameter declarations 
#   - $ACC Kernel/End Kernel pragmas
# It's used to parse both the wrapper module template and the kernel stub

sub parse_F90_src {
    (my $src)=@_;
    open my $IN, '<', $src or die "$src: $!. Did you create a stub .f95 for the kernel?";
    my @orig_lines=<$IN>;
    close $IN;
    my $src_lines = normalise_F90_src(\@orig_lines);

    my $in_sub=0;
    my $in_kernel=0;
    my $var_lines=[];
    my $par_lines=[];
    my $subs={};
    my $current_sub='';
    my $current_kernel='';

    for my $line (@{$src_lines}) {
		next if $line=~/^\s*$/;
		next if ($line=~/^\s*[*!]/ || ($line=~/^C/i)) && $line !~/^\s*!\s*\$/; # We only support !$ACC, not c,C or *

        $line=~/^\s+subroutine\s+(\w+)/ && do {
            $in_sub=1;
            $current_sub=$1;
            $subs->{$current_sub}={};
            next;
        };    

        $in_sub && $line=~/^\s+end\s+subroutine/ && do {
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
        
        $line=~/^\s*\!\s*\$ACC\s+Kernel\s*\((\w+)\)/i && do {
            $in_kernel=1;
            $current_kernel=$1;
            if ($line=~/GlobalRange\s*\((.+?)\)/) {
                my $grange=$1;
                $subs->{$current_sub}{Kernels}{$current_kernel}{GlobalRange}=$grange;
            } else {
                $subs->{$current_sub}{Kernels}{$current_kernel}{GlobalRange}='1';
            }
            if ($line=~/LocalRange\s*\((.+?)\)/) {
                my $lrange=$1;
                $subs->{$current_sub}{Kernels}{$current_kernel}{LocalRange}=$lrange;
            } else {
                $subs->{$current_sub}{Kernels}{$current_kernel}{LocalRange}='1';
            }
            next;
        };
        $line=~/^\s*\!\s*\$ACC\s+End\s+Kernel/i && do {
            $in_kernel=0;
            $current_kernel='';
			next;
        };
        if ($in_kernel==1 && $line=~/^\s+call\s+(\w+)\s*(.+)/) {
            my $kernel_sub = $1;
            my $args_str = $2;
            $subs->{$current_sub}{Kernels}{$current_kernel}{SubName}=$kernel_sub;
            $subs->{$current_sub}{Kernels}{$current_kernel}{SubArgs}=$args_str;
        }
    }
      if(  $in_sub ) {
            @{$subs->{$current_sub}{VarLines}}=@{$var_lines};
            @{$subs->{$current_sub}{ParLines}}=@{$par_lines};
        }      
    return ($src_lines,$subs);
}  # END of parse_F90_src()

###############################################################################
# Code for parsing the argument declarations
=head2 OpenCL Kernel Arguments

The call to `parse_arg_decls($var_lines,$kernel_args)` returns a table `%ocl_args` 
and two lists, one with the 'normal' (i.e. pointer) arguments, and one with the constant arguments.
The table has following structure

    %ocl_args =(
        $arg_name => {
            WordSize => $wordsz,
            Type => lc($type),
			CType => $ctype,          
            ArgMode => $argmode,
			Dim => $ndims,
            ArgPos => $arg_pos
        },
        ...        
    );

=cut
sub parse_arg_decls {
    (my $var_lines, my $kernel_args)=@_;
#    local $vv=1;
    say '=' x 80 if $vv;
    my $all = defined $kernel_args? 0 : 1;
    my %ocl_args=();
    my @arg_names=();
     my $ocl_arg_names=[];
     my $ocl_const_arg_names=[];

	for my $str (@{$var_lines}) {
		say "\n>>> <$str>\n" if $vv;
#		say STDERR "\n>>> <$str>\n";

		my $pt = parse_F95_arg_decl($str);
		print Dumper($pt),"\n" if $vv;
		my $type = $pt->{TypeTup}{Type};
		my $wordsz = $pt->{TypeTup}{Kind};
		my $ndims = scalar @{ $pt->{Dim} };
        if ($ndims==1 && $pt->{Dim}[0]!~/:/ && $pt->{Dim}[0] eq '0') {
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
#say STDERR "<$arg_name>";                
#                if (not defined $arg_name) {say STDERR Dumper($pt); 
#                    say STDERR Dumper(@var_names);
#                }
            if ($all or exists $kernel_args->{$arg_name}) {
                   if ($argmode eq 'Const') {
                push @{$ocl_const_arg_names}, $arg_name;
                } else {
                push @{$ocl_arg_names}, $arg_name;
                }
                $ocl_args{$arg_name}{WordSize} = $wordsz;
			$ocl_args{$arg_name}{Type} = lc($type);
			my $ctype = get_c_type(lc($type),$wordsz);
			$ocl_args{$arg_name}{CType} = $ctype;
            
			$ocl_args{$arg_name}{ArgMode} = $argmode;
			$ocl_args{$arg_name}{Dim} = $ndims;
            $ocl_args{$arg_name}{ArgPos} = $kernel_args->{$arg_name};
            }
		}
	} # for
	return (\%ocl_args,$ocl_arg_names,$ocl_const_arg_names);
} # end parse_arg_decls()
#--------------------------------------------------------------------------------
sub normalise_F90_src {(my $orig_lines)=@_;

                my $in_cont              = 0;
                my $joinedline='';
                my @comments_stack       = ();
                my $joined_lines=[];
				for my $line (@{$orig_lines}) {		
                    chomp $line;
                    if (not isCommentOrBlank($line) && $line=~/;/) {

                        my $tline = $line;
                        my $nline = '';
                        my $i     = 0;
                        my %phs   = ();
                        while ( $tline =~ /(\'.+?\')/ ) {
                            $phs{"__PH${i}__"} = $1;
                            $tline =~ s/(\'.+?\')/__PH${i}__/;
                            $i++;
                        }
                        if ( $tline =~ /;/ ) {
                            my @tlines = split( /\s*;\s*/, $tline ) ;
                            my @nlines=();
                            for my $nline (@tlines) {                
                                for my $phk ( keys %phs ) {
                                    $nline =~ s/$phk/$phs{$phk}/;
                                }
                                push @nlines, $nline;
                            }
                            $line = pop @nlines;
                            for my $tline (@nlines) {
                                push @{$joined_lines}, $tline;
                            }
                        } else {
                            for my $phk ( keys %phs ) {
                                $tline =~ s/$phk/$phs{$phk}/;
                            }
                            $line = $tline;
                        }
                    }
					if ($in_cont==0) {
					    if ( isCont( $line ) ) {
#                            die "CONT:$line";
						   $in_cont=1;
					       $joinedline .= removeCont( $line );	
					    } else {
					        # emit line
					        if ( $line ne '' ) {
					            push @{$joined_lines}, $line;
					        }	
					    }
					} else { # inside continuation line
						if ( isCont( $line ) ) {
						   $joinedline .= removeCont( $line );
						} elsif ( isCommentOrBlank($line) ) {
					        push @comments_stack, $line;
						} else {
							# In cont but line is not cont => end of cont line => 
                            # I still call removeCont to clean up the line
						   $joinedline .= removeCont( $line );                            
							# emit comments;
					        for my $commentline (@comments_stack) {
                                push @{$joined_lines}, $commentline;
					        }                                        
					        @comments_stack       = ();
							# emit joined line
					        if ( $joinedline ne '' ) {
					            push @{$joined_lines}, $joinedline;
					        }   
							$joinedline='';
							$in_cont=0;
						}	
					}
				}
                return $joined_lines;
} # END of normalise_F90_src()
 # -----------------------------------------------------------------------------
	sub isCont {
		( my $line ) = @_;
		my $is_cont = 0;
			if ( $line =~ /^\s*\&/ or $line=~/&\s*$/) {
				$is_cont = 1;
			}		
		return $is_cont;
	} # END of isCont


 # -----------------------------------------------------------------------------
	sub isCommentOrBlank {
		( my $line ) = @_;

		# Detect comments & blank lines
		if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
			return 1;
		} elsif ( $line =~ /^\s*$/ ) {
			return 1;
		}
		return 0;
	} # END of isCommentOrBlank
 # -----------------------------------------------------------------------------
	sub removeCont {
		( my $line ) = @_;
		chomp $line;
		if ( isCommentOrBlank($line) ) {
			return '';
		}
        if ( $line =~ /^\s*\&/ ) {
            $line =~ s/^\s*\&\s*/ /;
        }
        if ( $line =~ /\&\s*$/ ) {
            $line =~ s/\&\s*$//;
        }
# I think I should remove the whitespace at the start of the line
#		$line=~s/^\s+// unless $line;
		if ( $line =~ /.\!.*$/ ) {    # FIXME: trailing comments are discarded!
			my $tline = $line;
			my $nline = '';
			my $i     = 0;
			my %phs   = ();
			while ( $tline =~ /(\'.+?\')/ ) {
				$phs{"__PH${i}__"} = $1;
				$tline =~ s/(\'.+?\')/__PH${i}__/;
				$i++;
			}
			if ( $tline =~ /\!.*$/ ) {
				$nline = ( split( /\!/, $tline ) )[0];
				for my $phk ( keys %phs ) {
					$nline =~ s/$phk/$phs{$phk}/;
				}
				$line = $nline;
			} else {
				for my $phk ( keys %phs ) {
					$tline =~ s/$phk/$phs{$phk}/;
				}
				$line = $tline;
			}
		}
		return $line;
	} # END of removeCont()
#-------------------------------------------------------------------------------- 
# TODO: In general this is complicated, because the args can be expressions, array slices etc.
# So we'd need a proper parser
# We assume they are all nice simple var names for now

=head2 Kernel Arguments

The call to `get_kernel_args($argstr)` returns a map `%argtable`,

    %argtable=( $arg_name => $arg_pos, ... );
    
=cut

sub get_kernel_args { (my $argstr)=@_;
    say "ARGSTR: $argstr" if $VV;
    $argstr=~s/^\(\s*//;
    $argstr=~s/\s*\)$//;    
    my @args=split(/\s*,\s*/, $argstr);
    my $arg_pos=0;
    my %argtable = map {$_ => $arg_pos++ } @args;
    return {  %argtable };
} # END of get_kernel_args()
#-------------------------------------------------------------------------------- 
# Parse the kernel stub, and find for every argument its Intent, and update OclArgs
sub get_intent_from_kernel_sub { (my $ksub_name, my $ocl_args) =@_;
    my $ksub_path = $ksub_name.'_kernel.f95';
    (my $src_lines,my $subs) = parse_F90_src($ksub_path);
#die "SUBS: ".Dumper($subs);
    (my $subname, my $record) = each %{$subs}; # TODO: Assuming there is only 1 sub in the source file! WEAK!
        my $var_lines = $record->{VarLines};
    (my $kernel_args,my $arg_names)  = parse_arg_decls($var_lines);
    my $arg_pos=0;
    for my $arg_name (@{$arg_names}) {
        if (exists $ocl_args->{$arg_name}) {
        $ocl_args->{$arg_name}{ArgMode} = $kernel_args->{$arg_name}{ArgMode};                
        } else {
            say "WARNING: declared kernel argument $arg_name does not match any in called argument names.\n";
            # Try to match by position
             for my $ocl_arg_name (keys %{$ocl_args}) {
                 if ($ocl_args->{$ocl_arg_name}{ArgPos} == $arg_pos) {
                 if (not exists $kernel_args->{$ocl_arg_name}) {
                    $ocl_args->{$ocl_arg_name}{ArgMode} = $kernel_args->{$arg_name}{ArgMode};                
                 } else {
                     say "WARNING: declared kernel argument $arg_name in position $arg_pos would overwrite argument $ocl_arg_name!\n";
                 }
                 }
             }
        }
        $arg_pos++;
    }    
    return $ocl_args;
} # END of get_intent_from_kernel_sub()

#-------------------------------------------------------------------------------- 
=info_FIXME
The code generated based on the $in_kernel flag starts with declarations, these should go after the other declarations!
So, a better approach is to first insert the pragma's etc, then to run the generator on the result

Now, in general this should work on multiple kernel calls. In practice it means the buffers for each
of these need to be declared upfront. 

Maybe a cheap way is to insert the BufDecl pragma but use it as a hook, and collect all buf decls for all kernels.

=cut
sub generate_OclWrapper_code { (my $src_lines, my $subs)=@_;
    my $gen_src_lines_without_ocl_decls=[];
    my $gen_src_lines=[];
    my $in_kernel=0;
    my $in_sub=0;
    my $after_var_decls=0;
    my $current_sub='';
    my $current_kernel='';
    my %gen_ocl_api_decl_lines=();
    my $gen_src_ocl_api_decl_lines=[];
    for my $line (@{$src_lines}) {
# We can push all existing lines except the kernel part

         if ( $line=~/^\s*\!\s*\$ACC\s+Kernel\s*\((\w+)\)/i ) {
            $in_kernel=1;
            $current_kernel=$1;
            next;
        } elsif ($in_kernel) {
            $line=~/^\s+call\s+/ && do {
            my $cline = $line;
            $cline=~s/^\s+call/! call/;
            # here generate all that code
            my $ws='';
            $line=~/^(\s+)/ && do { $ws.=$1; };
            my $global_range = $subs->{$current_sub}{Kernels}{$current_kernel}{GlobalRange};
            my $local_range = $subs->{$current_sub}{Kernels}{$current_kernel}{LocalRange};
# Rather than generating this code, it makes more sense to call the corresponding code generators!
            my $ocl_kernel_api_decl_lines = [
                    '',
                    '!$ACC BufDecls',
                    '!$ACC SizeDecls',
                ];
            my $ocl_kernel_api_lines_OLD = [
                    'srclen = len(srcstr)',
                    'klen = len(kstr)',
                    '',
                    'call oclInit(srcstr,srclen,kstr,klen)'
                        ];
            my $ocl_kernel_api_lines = [
                    '',
                    'call oclInit(srcstr,kstr)',
                    'call oclGetMaxComputeUnits(nunits)',
                    '',
                    '!$ACC MakeSizes',
                    '',
                    '!$ACC MakeBuffers',
                    '',
                    '!$ACC SetArgs',
                    '',
                    '!$ACC WriteBuffers',
                    '',
                    $cline,
                    "call runOcl($global_range,$local_range)",
                    '',
                    '!$ACC ReadBuffers', 
                    ''
                    ];
                
                    (my $ocl_args,my $arg_names,my $const_arg_names)= @{$subs->{$current_sub}{Kernels}{$current_kernel}{OclArgs}};

                    my $gen_ocl_kernel_api_decl_lines = gen_OpenCL_API_calls ( $ocl_args,$arg_names,$const_arg_names, $ocl_kernel_api_decl_lines);
                    my $gen_ocl_kernel_api_lines = gen_OpenCL_API_calls ( $ocl_args,$arg_names,$const_arg_names, $ocl_kernel_api_lines);

                 for my $ocl_kernel_api_decl_line (@{$gen_ocl_kernel_api_decl_lines}) {
                     if (not exists $gen_ocl_api_decl_lines{$ocl_kernel_api_decl_line}) {
                        $gen_ocl_api_decl_lines{$ocl_kernel_api_decl_line}=1;
                        push @{$gen_src_ocl_api_decl_lines},$ws.$ocl_kernel_api_decl_line;

                     }                
                 }

                 for my $ocl_kernel_api_line (@{$gen_ocl_kernel_api_lines}) {
                                         push  @{$gen_src_lines_without_ocl_decls}, $ws.$ocl_kernel_api_line ;
                 }
            
            };
            $line=~/^\s*\!\s*\$ACC\s+End\s+Kernel/i && do {
                $in_kernel=0;
                $current_kernel='';
            };
            next;
        } else {        
              push @{$gen_src_lines_without_ocl_decls}, $line;
# Immediately after the subroutine which wraps the subroutine call marked as Kernel:
#	'use OclWrapper'  
              if ($line=~/^\s+subroutine\s+(\w+)/) {
                  $current_sub=$1;
                  my $ws='    ';
                  $line=~/^(\s+)/ && do {
                    $ws.=$1;
                  };
                  push @{$gen_src_lines_without_ocl_decls}, $ws.'use oclWrapper';
              }

# Immediately after the existing declarations:
              if ($line=~/::/) {
#                    my $pt = parse_F95_arg_decl($line);
#                    my @var_names=@{ $pt->{Args} };
                    if ($line eq $subs->{$current_sub}{VarLines}[-1]) {
                        my $ws='';
                        $line=~/^(\s+)/ && do { $ws.=$1; };
                        my @kernel_names = keys %{$subs->{$current_sub}{Kernels}}; # FIXME: only one kernel per sub supported!
                            if (scalar @kernel_names >1) {
                                die "Sorry, only one kernel pragma per wrapper subroutine is supported.\n";
                            }
                        my $kernel_name = shift @kernel_names;
#FIXME: the path to the kernel is ad-hoc!
                        my @ocl_decl_lines =(
                                '',
                                '! OpenCL-specific declarations',
                                'integer :: nunits',
                                'integer :: srclen, klen',
                                'character(len=*), parameter :: srcstr="'.$kernel_path.'/'.$kernel_name.'.cl"',
                                'character(len=*), parameter :: kstr="'.$kernel_name.'"',
                                '!This is a hook to insert the actual buffer declarations!',
                                '!$ACC BufDecls',
                                ''
                                );
                        for my $ocl_decl_line (@ocl_decl_lines) {
                            push  @{$gen_src_lines_without_ocl_decls}, $ws.$ocl_decl_line ;
                        }
                    }
              }
        }

    }
    for my $gen_src_line (@{$gen_src_lines_without_ocl_decls}) {
        if ($gen_src_line =~/\!\$ACC\s+BufDecls/) { 
            for my $ocl_decl_line (@{$gen_src_ocl_api_decl_lines}){
                push @{$gen_src_lines}, $ocl_decl_line;
            }
        } else {
            push @{$gen_src_lines}, $gen_src_line;
        }
    }

    return $gen_src_lines;
} # END of generate_OclWrapper_code()

###############################
## Read the source and get the subroutine records:
#$subname => {
#        VarLines => [String],
#        Parlines=> [String],
#
#        Kernels => {$kname => {
#                GlobalRange => String,
#                LocalRange => String,
#                SubName => String,
#                SubArgs => String,
#        }},
#}
sub main {

my %opts=();
getopts('hvo', \%opts);

if ($opts{'h'}) { 
        die "
            Please specify a template module file (V2)
            To overwrite any existing modules, use -o
            For verbose output, use -v
            ";
}
    
if($opts{'v'}) {
    $VV=1;
    $vv=1;
}
my $overwrite=0;
if ($opts{'o'}) {
    $overwrite=1;
}
    our $src_templ= $ARGV[0] // 'module_velFG_ocl_TEMPL_V2.f95';    
    our $src_gen = $src_templ;
    $src_gen=~s/_TEMPL_V2//;

    (my $src_lines,my $subs) = parse_F90_src($src_templ);

# For each of the subroutine records, get the kernel arguments, and identify the corresponding variable declarations
# We need to generate OclWrapper calls for every kernel in every subroutine, separately.
# So we need to replace the !$ACC Kernel pragma with this chunk of code. 
# So we first generate that code, put it into %subs,  and then do another pass and substitute it.
    for my $csub (keys %{$subs}) { 
        say "SUB:$csub" if $VV;
        my $var_lines = $subs->{$csub}{VarLines};
        for my $ckname (keys %{$subs->{$csub}{Kernels}}) {
            say "KERNEL:$ckname" if $VV;
            my $kernel_args = get_kernel_args( $subs->{$csub}{Kernels}{$ckname}{SubArgs} );
            (my $ocl_args,my $arg_names, my $const_arg_names) = parse_arg_decls($var_lines, $kernel_args);
# This is fine, at this stage we have all kernel arguments. 
# Assuming that the kernel subroutine has the Intent field present, we can use that to get the directions of the arguments
            $ocl_args = get_intent_from_kernel_sub( $subs->{$csub}{Kernels}{$ckname}{SubName}, $ocl_args );        
            $subs->{$csub}{Kernels}{$ckname}{OclArgs}=[$ocl_args,$arg_names,$const_arg_names];
# Now we have the intent. If the kernel sub were simple, and consisted only of a single, possible nested, loop, we could derive the globalrange as well.        
# But for now, let's just use a range of 1        

        }
    }
    my $gen_src_lines = generate_OclWrapper_code($src_lines,$subs);
if ($overwrite) {
    open my $GENSRC,'>',$src_gen or die $!;
    map {say $GENSRC $_} @{$gen_src_lines};
    close $GENSRC;
} else {
    map {say $_} @{$gen_src_lines};
}
} # END of main()


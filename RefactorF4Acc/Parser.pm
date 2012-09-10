package RefactorF4Acc::Parser;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallGraph qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common
  qw( format_f95_var_decl format_f77_var_decl );
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::CTranslation qw( add_to_C_build_sources );

#
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Parser::ISA = qw(Exporter);

@RefactorF4Acc::Parser::EXPORT_OK = qw(
  &parse_fortran_src
  &parse_vardecl
);

# -----------------------------------------------------------------------------
# parse_fortran_src() only parses the source to build the call tree, nothing else
# We don't need to parse the includes nor the functions at this stage.
# All that should happen in a separate pass. But we do it here anyway
sub parse_fortran_src {
	( my $f, my $stref ) = @_;
#    local $V=1;	
	print "parse_fortran_src(): PARSING $f\n " if $V;
	
	# 1. Read the source and do some minimal processsing
	$stref = read_fortran_src( $f, $stref );#
	print "DONE read_fortran_src_better( $f )\n" if $V;
	
	my $sub_or_func = sub_func_or_incl( $f, $stref );
	print "SRC TYPE: $sub_or_func\n" if $V;
	if ($sub_or_func ne 'ExternalSubroutines') {
	my $Sf          = $stref->{$sub_or_func}{$f};
	my $is_incl     = exists $stref->{'IncludeFiles'}{$f} ? 1 : 0;

# Set 'RefactorGlobals' to 0, we only refactor the globals for subs that are kernel targets and their dependencies
	if ( not exists $Sf->{'RefactorGlobals'} ) {
		$Sf->{'RefactorGlobals'} = 0;
	}

# 2. Parse the type declarations in the source, create a per-target table Vars and a per-line VarDecl list and other context-free stuff
	$stref = analyse_lines( $f, $stref );

	# 3. Parse includes
	$stref = parse_includes( $f, $stref );
	if ( not $is_incl ) {
		if ( $stref->{$sub_or_func}{$f}{'HasBlocks'} == 1 ) {					
			$stref = separate_blocks( $f, $stref );
		}
        # Recursive descent via subroutine calls
		$stref = parse_subroutine_and_function_calls( $f, $stref );
		$stref->{$sub_or_func}{$f}{'Status'} = $PARSED;
		print "DONE PARSING $sub_or_func $f\n" if $V;		
	} else {    # includes

# 4. For includes, parse common blocks and parameters, create $stref->{'Commons'}
		$stref = get_commons_params_from_includes( $f, $stref );
		$stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;
	}

#	if ( $f eq 'includecom' ) {

		#    $Data::Dumper::Indent=1;
		#    warn "END of parse_fortran_src( $f )\n-------\n";
		#    warn Dumper($stref->{'Subroutines'}{$f}{'AnnLines'} );
		#    warn "-------\n";
#		die;
#	}
}
	#    $stref=create_annotated_lines($stref,$f);
	print "LEAVING parse_fortran_src( $f ) with Status $stref->{$sub_or_func}{$f}{'Status'}\n" if $V; 
	return $stref;
}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------

# Create a table of all variables declared in the target, and a list of all the var names occuring on each line.
# We record the type of the var and whether it's a scalar or array, because we need that information for translation to C.
# Also check if the variable happens to be a function. If that is the case, mark that function as 'Called'; if we have not yet parsed its source, do it now.
sub analyse_lines {
	( my $f, my $stref ) = @_;
	my $sub_func_incl = sub_func_or_incl( $f, $stref );
	my $Sf            = $stref->{$sub_func_incl}{$f};
	my $srcref        = $Sf->{'AnnLines'};
	if ( defined $srcref ) {
		print "\nVAR DECLS in $f:\n" if $V;
		my %vars       = ();
		my $first      = 1;
		my $is_vardecl = 0;
		my $type       = 'NONE';
		my $varlst     = '';
		my $indent     = '';
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $attr = '';
			my $line = $srcref->[$index][0];
			
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s+/ ) {
				next;
			}

	   # FIXME Trailing comments are ignored!
	   #            if ( $line =~ /^\!\s/ ) {
	   #                $stref->{$sub_func_incl}{$f}{'Info'}
	   #                  ->[$index]{'TrailingComments'} = {};
	   #                next;
	   #            }

			if ( $line =~ /implicit\s+none/ ) {
				$info->{'ImplicitNone'} = 1;
				$Sf->{'ImplicitNone'}   = $index;
				
			} elsif ( $line =~ /^\d*\s+(else\s+if)/ ) {
				$info->{'ElseIf'} = 1;
				
			} elsif ( $line =~
/^\d*\s+(if|else|select|case|read|write|print|open|close|return|stop)\s*\(/
			  )
			{				
				$info->{ ucfirst($1) } = 1;
			} elsif ( $line =~ /^\d*\s+do\b/ ) {
				
				$info->{'Do'} = 1;
			} elsif ( $line !~ /\bparameter\b/ && $line =~ /[\w\)]\s*=\s*[^=]/ )
			{				
				$info->{'Assignment'} = 1;
			}

		 # Actual variable declaration line
		 # FIXME: in principle every type can be followed by '*<number>' or *(*)
		 # So we have

			elsif ( $line =~
#			/(logical|integer|real|double\s*precision|character)\s+(.+)\s*$/
            /\b(logical|integer|real|double\s*precision|character)\s+([^\*]?.*)\s*$/
				or $line =~
#            /((?:logical|integer|real|double\s*precision|character)\*(?:\d+|\(\*\)))\s+(.+)\s*$/				
            /\b((?:logical|integer|real|double\s*precision|character)\s*\*(?:\d+|\(\*\)))\s+(.+)\s*$/
			  )
			{
				$type   = $1;
				$varlst = $2;
				# Now an ad hoc fix for spaces between the type and the asterisk. FIXME! I should just write a better FSM!
				if ($line=~/\w+\s+(\*\s*(\d+|\(\s*\*\s*\)))/) { # FIXME: I assume after the asterisk there MUST be an integer constant
				    my $len=$1;
					$type.=$len;
					$varlst=~s/^\S+\s+//;
				}  
				
				$type =~ /\*/ && do {
					( $type, $attr ) = split( /\*/, $type );
					if ( $attr eq '(' ) { $attr = '*' }
				};
				$indent = $line;
				$indent =~ s/\S.*$//;
				$is_vardecl = 1;
			} elsif ( $line =~ /^\s*(.*)\s*::\s*(.*?)\s*$/ )
			{    #F95 declaration, no need for refactoring

				#			     $Sf->{'FStyle'}='F95';
				$type   = $1;
				$varlst = $2;
				$indent = $line;
				$indent =~ s/\S.*$//;

			 # But this could be a parameter declaration, with an assignment ...
#               if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+)\s*=\s*(.+?)\s*$/ )
                if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ )
				{    # F95-style parameters

					#				    $Sf->{'FStyle'}='F95';
					my $parliststr = $1;										
					my @partups    = split( /\s*,\s*/, $parliststr );
					my %pvars      =
					  map { split( /\s*=\s*/, $_ ) }
					  @partups;    # Perl::Critic, EYHO
					if ( not exists $Sf->{'Parameters'} ) {
						$Sf->{'Parameters'} = {};
					}
					my $pars = [];
					my @pvarl = map { s/\s*=.+//; $_ } @partups;
					for my $var (@pvarl) {
						if ( not defined $vars{$var} ) {
							print
"WARNING: PARAMETER $var not declared in $f (F95-style)\n"
							  if $W;
						} else {
							$Sf->{'Parameters'}{$var} = {
								'Type' => $type,
								'Var'  => $vars{$var},
								'Val'  => $pvars{$var}
							};
							push @{$pars}, $var;
						}
					}
					$info->{'Parameter'} = $pars;
					if ( not exists $Sf->{'Parameters'}{'OrderedList'} ) {
						$Sf->{'Parameters'}{'OrderedList'} = [];
					}
					@{ $Sf->{'Parameters'}{'OrderedList'} } =
					  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @{$pars} );
				}
				$is_vardecl = 1;
			} elsif ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ )
			{    # F77-style parameters
				my $parliststr = $1;
				$indent = $line;
				$indent =~ s/\S.*$//;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my $pars = [];
				for my $var (@pvarl) {

					if ( not defined $vars{$var} ) {
						print "WARNING: PARAMETER $var not declared in $f, trying to infer type\n" if $W;
						if (exists $pvars{$var}) {
							
                          my $val=$pvars{$var};
                          if ($val=~/[0-9eE\.\+\-]/) {
                          	my $type='Unknown';
                          if ($val=~/\./ or $val=~/e/i or $val=~/\//) {
                          	$type = 'real'; # FIXME: could be double!
                          } else {
                          	$type = 'integer';
                          }
                            $Sf->{'Parameters'}{$var} = {
                            'Type' => $type,
                            'Var'  => $var,
                            'Val'  => $val                            
                            };
                           print "WARNING: PARAMETER $var infered type: $type $var = $val\n" if $W; 
                            push @{$pars}, $var;
                          
                          } else {
                          	print "WARNING: PARAMETER $var has NON_NUMERIC val $pvars{$var} in $f\n"
                          if $W;
                          }
						}  
					} else {
						$Sf->{'Parameters'}{$var} = {
							'Type' => 'Unknown',
							'Var'  => $vars{$var},
							'Val'  => $pvars{$var}
						};
						push @{$pars}, $var;
					}
				}
				$info->{'Parameter'} = $pars;
				if ( not exists $Sf->{'Parameters'}{'OrderedList'} ) {
					$Sf->{'Parameters'}{'OrderedList'} = [];
				}
				@{ $Sf->{'Parameters'}{'OrderedList'} } =
				  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @{$pars} );
			}    # match var decls, parameter statements F77/F95

			if ($is_vardecl) {
				$is_vardecl = 0;

				#				my $tvarlst = $varlst;
				my $T =
				  0;  #($f eq 'particles_main_loop' && $varlst=~/drydep/) ? 1:0;
				my $pvars = parse_vardecl( $varlst, $T );

				#                if ($f eq 'read_ncwrfout_1realfield') {
				#	               print Dumper($pvars);
				#                }
				my @varnames = ();
				for my $var ( keys %{$pvars} ) {
					if ( $var eq '' ) { croak "<$line> in $f" }
					my $tvar = $var;
					$vars{$tvar}{'Type'}  = $type;
					$vars{$tvar}{'Shape'} = $pvars->{$var}{'Shape'};
					$vars{$tvar}{'Kind'}  = $pvars->{$var}{'Kind'};
					if ( not exists $pvars->{$var}{'Attr'} ) {
						if ($attr) {
							if ( $type =~ /character/ ) {
								$vars{$tvar}{'Attr'} = '(len=' . $attr . ')';
							} else {
								$vars{$tvar}{'Attr'} = '(kind=' . $attr . ')';
							}
						} else {
							$vars{$tvar}{'Attr'} = '';
						}
					} else {
						if ( $type =~ /character/ ) {
							$vars{$tvar}{'Attr'} =
							  '(len=' . $pvars->{$var}{'Attr'} . ')';
						} else {
							$vars{$tvar}{'Attr'} =
							  '(kind=' . $pvars->{$var}{'Attr'} . ')';
						}
					}

					# Take IODir from INTENT
					if ( $type =~ /\bintent\s*\(\s*(\w+)\s*\)/ ) {
						my $iodir = $1;
						$iodir = ucfirst($iodir);
						if ( $iodir eq 'Inout' ) {
							$iodir = 'InOut';
						}
						$vars{$tvar}{'IODir'} = $iodir;
					}

					#                    $var =~ s/;/,/g;
					$vars{$tvar}{'Decl'} = "        $type $var";

					# TODO: this should maybe not be a textual representation
					# make it [$type,$var] ?
					$vars{$tvar}{'Indent'} = $indent;

					if ( exists $stref->{'Functions'}{$tvar} and $tvar ne $f) { # FIXME: NO RECURSION!

						$stref->{'Functions'}{$tvar}{'Called'} = 1;
						$stref->{'Functions'}{$tvar}{'Callers'}{$f}++;
						if (
							not
							exists $stref->{'Functions'}{$tvar}{'AnnLines'} )
						{
							$stref = parse_fortran_src( $tvar, $stref );
						}
					}
					push @varnames, $tvar;
				}    # loop over all vars declared on a single line

				print "\tVARS <$line>: ", join( ',', @varnames ), "\n" if $V;
				$info->{'VarDecl'} = \@varnames;
				if ($first) {
					$first = 0;
					$info->{'ExGlobVarDecls'} = {};
				}
			}
			$srcref->[$index] = [ $line, $info ];
		}    # Loop over lines
		$stref->{$sub_func_incl}{$f}{'Vars'} = \%vars;
	}

	#           die "FIXME: shapes not correct!";
	return $stref;
}    # END of analyse_lines()

# -----------------------------------------------------------------------------
# For every 'include' statement in a subroutine
# the filename is entered in 'Includes' and in Info->[$index]{'Include'}
# If the include was not yet read, do it now.
sub parse_includes {
	( my $f, my $stref ) = @_;
#	local $V=1;
	
	my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
    print "PARSING INCLUDES for $f ($sub_or_func_or_inc)\n" if $V;
	my $srcref       = $Sf->{'AnnLines'};
	my $last_inc_idx = 0;
	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];
		if ( $line =~ /^\!\s/ ) {
			next;
		}

		if ( $line =~ /^\s*include\s+\'(\w+)\'/ ) {
			my $name = $1;
			print "FOUND include $name in $f\n" if $V;
			$Sf->{'Includes'}{$name} = $index;
			if (
			 exists $Sf->{'Translate'} 
            and exists $stref->{'IncludeFiles'}{$name}
			and not exists $stref->{'IncludeFiles'}{$name}{'Translate'}
			) {
			     $stref->{'IncludeFiles'}{$name}{'Translate'} = $Sf->{'Translate'};
			     if( $Sf->{'Translate'} eq 'C') {
                    $stref = add_to_C_build_sources( $name, $stref );
                } else {
                    croak '!$acc translate ('.$f.') '.$Sf->{'Translate'}.": Only C translation through F2C_ACC is currently supported.\n";
                }
			}
			$last_inc_idx = $index;

			#            $Sf->{'Info'}->[$index]{'Include'}{'Name'} = $name;
			$info->{'Include'} = {};
			$info->{'Include'}{'Name'} = $name;
			if ( $stref->{'IncludeFiles'}{$name}{'Status'} == $UNREAD ) {
				print $line, "\n" if $V;

				# Initial guess for Root. OK? FIXME?
				$stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
				$stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
				$stref = parse_fortran_src( $name, $stref );
			} else {
				print $line, " already processed\n" if $V;
			}
		}
		$srcref->[$index] = [ $line, $info ];
	}

	# tag the next line after the last include
	
	$last_inc_idx++;
#	while ($srcref->[$last_inc_idx][0] =~/^\s*$/) {
#		$last_inc_idx++;
#	}
	$srcref->[$last_inc_idx][1]{'ExtraIncludesHook'} = 1;
#	print '<'.$srcref->[$last_inc_idx][0].">\n";
#	print '<'.Dumper($srcref->[$last_inc_idx][1]).">\n";
#	die if $f eq 'timemanager';
	return $stref;
}    # END of parse_includes()

# -----------------------------------------------------------------------------

sub detect_blocks {
	( my $stref, my $s ) = @_;
	print "CHECKING BLOCKS in $s\n" if $V;
	my $sub_func_incl = sub_func_or_incl( $s, $stref );
	die "$sub_func_incl $s ".$stref->{$sub_func_incl}{$s}{'HasBlocks'}  if $s eq 'timemanager';
	$stref->{$sub_func_incl}{$s}{'HasBlocks'} = 0;
	my $srcref = $stref->{$sub_func_incl}{$s}{'AnnLines'};
	for my $annline ( @{$srcref} ) {
		my $line = $annline->[0];
		if ( $line =~ /^\!\s/ ) {

# I'd like to use the OpenACC compliant pragma !$acc kernels , !$acc end kernels
# but OpenACC does not allow to provide a name
# so I propose my own tag: !$acc subroutine name, !$acc end subroutine
			if (   $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
				or $line =~ /^\!\s*\$acc\ssubroutine\s(\w+)/i )
			{
				$stref->{$sub_func_incl}{$s}{'HasBlocks'} = 1;
				my $tgt = uc( substr( $sub_func_incl, 0, 3 ) );
				print "$tgt $s HAS BLOCK: $1\n" if $V;
				last;
			}
		}
	}

	return $stref;
}    # END of detect_blocks()

# -----------------------------------------------------------------------------

=pod

=begin markdown

### Factoring out code blocks into subroutines



=end markdown

=cut

sub separate_blocks {
	( my $f, my $stref ) = @_;

#    die "separate_blocks(): FIXME: we need to add in the locals from the parent subroutine as locals in the new subroutine!";
	my $sub_or_func = sub_func_or_incl( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};
	my $srcref      = $Sf->{'AnnLines'};

	# All local variables in the parent subroutine
	my %vars = %{ $Sf->{'Vars'} };
	$Data::Dumper::Indent = 2;

	#warn "USING VARS FROM PARENT $f HERE!\n";
	#warn Dumper($Sf->{'Vars'}{'drydeposit'});
	# Occurence
	my %occs = ();

	# A map of every block in the parent
	my %blocks   = ();
	my $in_block = 0;

	# Initial settings
	my $block = 'OUTER';
	$blocks{'OUTER'} = { 'AnnLines' => [] };

	#   my $block_idx = 0;

# 1. Process every line in $f, scan for blocks marked with pragmas.
# What this does is to separate the code into blocks (%blocks) and keep track of the line numbers
# The lines with the pragmas occur both in OUTER and the block

	#TODO: replace by sub
	#    (my $stref, my $blocksref) = separate_into_blocks($stref,$f);

	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];
		
		if (   $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
			or $line =~ /^\!\s*\$acc\s+subroutine\s(\w+)/i )
		{
			$in_block = 1;
			$block    = $1;
			print "FOUND BLOCK $block\n" if $V;

#            # Enter the name of the block in the metadata for the line
#            $Sf->{'Info'}[$index]{'RefactoredSubroutineCall'}{'Name'} = $block;
#            $Sf->{'Info'}[$index]{'SubroutineCall'}{'Name'} = $block;
#            delete $Sf->{'Info'}[$index]{'Comments'};
#            $Sf->{'Info'}[$index]{'BeginBlock'}{'Name'} = $block;

			# Enter the name of the block in the metadata for the line
			$info->{'RefactoredSubroutineCall'}{'Name'} = $block;
			$info->{'SubroutineCall'}{'Name'}           = $block;
			delete $info->{'Comments'};
			$info->{'BeginBlock'}{'Name'} = $block;

			# Push the line with the pragma onto the list of 'OUTER' lines
			push @{ $blocks{'OUTER'}{'AnnLines'} },
			  [ "! *** Refactored code into $block ***", {} ];

		   # Push the line with the pragma onto the list of lines for the block,
		   # to be replaced by function signature
			push @{ $blocks{$block}{'AnnLines'} },
			  [
				"! *** Original code from $f starts here ***",
				{ 'RefactoredSubroutineCall' => { 'Name' => $block } }
			  ];

		  #            # Add the name and index to %blocks
		  #            push @{ $blocks{$block}{'Info'} },
		  #              { 'RefactoredSubroutineCall' => { 'Name' => $block } };
			$blocks{$block}{'BeginBlockIdx'} = $index;
			next;
		}
		if (   $line =~ /^\!\s+END\sSUBROUTINE\s(\w+)/
			or $line =~ /^\!\s*\$acc\s+end\ssubroutine\s(\w+)/i )
		{
			$in_block = 0;
			$block    = $1;

			# Push end-of-block pragma onto 'OUTER'
			push @{ $blocks{'OUTER'}{'AnnLines'} }, [ $line, {} ];

			# Push 'end' onto the list of lines for the block,
			push @{ $blocks{$block}{'AnnLines'} }, [ '      end', $info ];

		  # Add info to %blocks.
		  #            push @{ $blocks{$block}{'Info'} }, $Sf->{'Info'}[$index];
		  #            $Sf->{'Info'}[$index]{'EndBlock'}{'Name'} = $block;
			$info->{'EndBlock'}{'Name'} = $block;
			$blocks{$block}{'EndBlockIdx'} = $index;
			next;
		}
		if ($in_block) {

			# Push the line onto the list of lines for the block
			push @{ $blocks{$block}{'AnnLines'} }, [ $line, $info ];

			# and the index onto Info in %blocks and $Sf
			#            push @{ $blocks{$block}{'Info'} }, $info;
			$info->{'InBlock'}{'Name'} = $block;
		} else {

			# Other lines go onto 'OUTER'
			push @{ $blocks{'OUTER'}{'AnnLines'} }, [ $line, $info ];
		}
		$srcref->[$index] = [ $line, $info ];
	}    # loop over annlines

# 2. For all non-OUTER blocks, create an entry for the new subroutine in 'Subroutines'
# Based on the content of %blocks
# TODO: $stref=create_new_subroutine_entries($blocksref,$stref)
	for my $block ( keys %blocks ) {
		die "EMPTY block name $block" if $block eq '';
		next if $block eq 'OUTER';
		if (not exists $stref->{'Subroutines'}{$block} ) {
		  $stref->{'Subroutines'}{$block} = {};
		  $stref->{'Subroutines'}{$block}{'Source'} = $Sf->{'Source'};
		} elsif (exists $stref->{'Subroutines'}{$block}{'Translate'} ) {
			if( $stref->{'Subroutines'}{$block}{'Translate'} eq 'C') {
				$stref->{'Subroutines'}{$block}{'Source'} = "./$block.f95";
                 $stref = add_to_C_build_sources( $block, $stref );
            } else {
                croak '!$acc translate ('.$block.') '.$stref->{'Subroutines'}{$block}{'Translate'}.": Only C translation through F2C_ACC is currently supported.\n";
            }
		}
		my $Sblock = $stref->{'Subroutines'}{$block};
		$Sblock->{'AnnLines'} = $blocks{$block}{'AnnLines'};
#if (exists $Sblock->{'Translate'} ) {die $block;}
		#        $Sblock->{'Info'}  = $blocks{$block}{'Info'};
#		$Sblock->{'Source'}          = $Sf->{'Source'};
		$stref->{'SourceContains'}{$Sf->{'Source'}}{$block} = 'Subroutines';
		$Sblock->{'RefactorGlobals'} = 1;
		if ( $Sf->{'RefactorGlobals'} == 0 ) {
			$Sf->{'RefactorGlobals'} = 2;
		} else {
			die 'BOOM!';
		}
	}

# 3. Identify which vars are used
#   - in both => these become function arguments
#   - only in "outer" => do nothing for those
#   - only in "inner" => can be removed from outer variable declarations
#
# Find all vars used in each block, starting with the outer block
# It is best to loop over all vars per line per block, because we can remove the encountered vars
# TODO: my $occsref = determine_new_subroutine_arguments($blocksref,$varsref,$linesref);

	for my $block ( keys %blocks ) {

		my @annlines = @{ $blocks{$block}{'AnnLines'} };
		my %tvars = %vars;    # Hurray for pass-by-value!
		print "\nVARS in $block:\n\n" if $V;
		for my $annline (@annlines) {
			my $tline = $annline->[0];
			$tline =~ s/\'.+?\'//;
			for my $var ( sort keys %tvars ) {
				if ( $tline =~ /\b$var\b/ ) {    # or $tline =~ /\W$var\s*$/ ) {
					print "FOUND $var\n" if $V;
					$occs{$block}{$var} = $var;
					delete $tvars{$var};
				}
			}
		}
	}

	# 4. Construct the subroutine signatures
	# TODO: $stref = construct_new_subroutine_signatures();
	# TODO: see if this can be separated into shorter subs
	#	local $V=1;
	my %args = ();
	for my $block ( keys %blocks ) {
		next if $block eq 'OUTER';
		my $Sblock = $stref->{'Subroutines'}{$block};
		print "\nARGS for BLOCK $block:\n" if $V;

		# Collect args for new subroutine
		for my $var ( sort keys %{ $occs{$block} } ) {
			if ( exists $occs{'OUTER'}{$var} ) {
				print "$var\n" if $V;
				push @{ $args{$block} }, $var;
			}
			$Sblock->{'Vars'}{$var} =
			  $vars{$var
			  }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
		}
		$Sblock->{'Args'} = $args{$block};

		# Create Signature and corresponding Decls
		my $sixspaces = ' ' x 6;
		my $sig       = $sixspaces . 'subroutine ' . $block . '(';
		my $decls     = [];
		for my $argv ( @{ $args{$block} } ) {
			$sig .= "$argv,";

			#			my $decl = $vars{$argv}{'Decl'};
#			print '<',$f,$Sf->{'FStyle'},">\n";
			my $decl =
			  ( $Sf->{'FStyle'} eq 'F77' )
			  ? format_f77_var_decl( $Sf->{'Vars'}, $argv )
			  : format_f95_var_decl( $Sf->{'Vars'}, $argv );

#			if ($f eq 'timemanager' && $block eq 'particles_main_loop' && $decl=~/drydeposit/) {
#				print "DECL: $decl\n";
#				print "VARS: ".Dumper( $Sf->{'Vars'}{$argv});
#			}
			push @{$decls}, $sixspaces . $decl;    # Why do we need this anyway?
			$Sf->{'Vars'}{$argv}{'Decl'} = $sixspaces . $decl;
		}
		$sig =~ s/\,$/)/s;
		$Sblock->{'Sig'}   = $sig;
		$Sblock->{'Decls'} = $decls;

		# Add variable declarations and info to line
		my $sigline = shift @{ $Sblock->{'AnnLines'} };
		for my $argv ( @{ $args{$block} } ) {
			my $decl = $Sf->{'Vars'}{$argv}{'Decl'};
			unshift @{ $Sblock->{'AnnLines'} },
			  [ $decl, { 'VarDecl' => [$argv] } ];
		}
		unshift @{ $Sblock->{'AnnLines'} }, $sigline;

	 # Now also add include statements and the actual sig to the line
	 #        croak Dumper($Sblock->{'AnnLines'});
	 #        my $fl = shift @{ $Sblock->{'Info'} }; # remove comment, keep line
		my $fal = $Sblock->{'AnnLines'}[0][1];    # remove comment, keep line
		$Sblock->{'AnnLines'}[0][1] = {};
		for my $inc ( keys %{ $Sf->{'Includes'} } ) {
			$Sblock->{'Includes'}{$inc} = 1;
			unshift @{ $Sblock->{'AnnLines'} },
			  [ "      include '$inc'", { 'Include' => { 'Name' => $inc } } ]
			  ;                                   # add new lines at the front

#            unshift @{ $Sblock->{'Info'} }, { 'Include' => { 'Name' => $inc } };
			$Sblock->{'Includes'}{$inc} = 1;
		}
		unshift @{ $Sblock->{'AnnLines'} },
		  [ $sig, {} ];                           # add a line but not a comment
		  # And finally, in the original source, replace the blocks by calls to the new subs

		#        print "\n-----\n".Dumper($srcref)."\n-----";
		for my $tindex ( 0 .. scalar( @{$srcref} ) - 1 ) {
			if ( $tindex == $blocks{$block}{'BeginBlockIdx'} ) {
				$sig =~ s/subroutine/call/;
				$srcref->[$tindex][0] = $sig;
			} elsif ( $tindex > $blocks{$block}{'BeginBlockIdx'}
				and $tindex <= $blocks{$block}{'EndBlockIdx'} )
			{
				$srcref->[$tindex][0] = '';
				$srcref->[$tindex][1]{'Deleted'} = 1;
			}
		}

#        unshift @{ $Sblock->{'Info'} }, $fl; # put the comment back at the front, no change to the lines
		$Sblock->{'AnnLines'}[0][1] = $fal;

		#print "YES! GENERATED DECLS ARE WRONG!!!\n";
		if ($V) {
			print $sig, "\n";
			print join( "\n", @{$decls} ), "\n";
		}
		$Sblock->{'Status'} = $READ;

	}

#	warn "Vars are CORRECT AT END OF separate_blocks( $f ):\n-----\n";
#	warn Dumper($stref->{'Subroutines'}{'particles_main_loop'}{'Vars'}{'drydeposit'});
#	warn "-----\n";
#	croak "BOOM!" if $f eq 'timemanager';

	return $stref;
}    # END of separate_blocks()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

sub parse_subroutine_and_function_calls {
	( my $f, my $stref ) = @_;
	print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;
	my $pnid        = $stref->{'NId'};
	my $sub_or_func = sub_func_or_incl( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};

	# For C translation and call tree generation
	# TODO: $translate is obsolete! 
	if ( $translate == $GO
		|| ( $call_tree_only && ( $gen_sub || $main_tree ) ) )
	{

		if ( $translate == $GO ) {
			$stref = add_to_C_build_sources( $f, $stref );
		}
	}
	if (exists $Sf->{'Translate'} ) {
		
		if( $Sf->{'Translate'} eq 'C') {
			     $stref = add_to_C_build_sources( $f, $stref );
		} else {
			croak '!$acc translate ('.$f.') '.$Sf->{'Translate'}.": Only C translation through F2C_ACC is currently supported.\n";
		}
	}
	my $srcref = $Sf->{'AnnLines'};

	#   croak Dumper( $srcref) if $f=~/timemanager/;
	if ( defined $srcref ) {

		#        my %called_subs         = ();
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			next if $line =~ /^\!\s/;

	  # Subroutine calls. Surprisingly, these even occur in functions! *shudder*
            if ( $line =~ /call\s+(\w+)\s*\((.*)\)/ || $line =~ /call\s+(\w+)\s*$/ ) # WV23JUL2012
#			if ( $line =~ /call\s(\w+)\((.*)\)/ || $line =~ /call\s(\w+)\s*$/ )            
			{
#				die if $line=~/advance/;
				my $name = $1;
				$stref = add_to_call_tree( $name, $stref, $f );
				my $Sname = $stref->{'Subroutines'}{$name};
                if ( exists $Sf->{'Translate'}
                and not exists $Sname->{'Translate'}
                 ) {
                	$Sname->{'Translate'} = $Sf->{'Translate'}  
                }
				$stref->{'NId'}++;
				my $nid = $stref->{'NId'};
				push @{ $stref->{'Nodes'}{$pnid}{'Children'} }, $nid;
				$stref->{'Nodes'}{$nid} = {
					'Parent'     => $pnid,
					'Children'   => [],
					'Subroutine' => $name
				};

				my $argstr = $2 || '';
				if ( $argstr =~ /^\s*$/ ) {
					$argstr = '';
				}

				$Sname->{'Called'} = 1;
				$Sname->{'Callers'}{$f}++;

#               if ($Sf->{'RefactorGlobals'} == 2) {
#               warn "NAME: $f => $name,".(exists $Sname->{'RefactorGlobals'}? $Sname->{'RefactorGlobals'} : 'UNDEF')."\n" if $f eq 'timemanager';
#               }
				if ( $Sf->{'RefactorGlobals'} == 1 ) {
					print "SUB $name NEEDS GLOBALS REFACTORING\n" if $V;
					$Sname->{'RefactorGlobals'} = 1;
				}

				#                $called_subs{$name} = $name;
				$info->{'SubroutineCall'}{'Args'} = $argstr;
				my $tvarlst = $argstr;

				# replace , by ; in array indices and nested function calls
				if ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
					while ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
						my $chunk  = $1;
						my $chunkr = $chunk;
						$chunkr =~ s/,/;/g;
						my $pos = index( $tvarlst, $chunk );
						substr( $tvarlst, $pos, length($chunk), $chunkr );
					}
				}

				my @tvars = split( /\s*\,\s*/, $tvarlst );

				#               my $p       = '';
				my @argvars = ();
				for my $var (@tvars) {
					$var =~ s/^\s+//;
					$var =~ s/\s+$//;
					$var =~ s/;/,/g;
					push @argvars, $var;
				}

				$info->{'SubroutineCall'}{'Args'} = \@argvars;
				$info->{'SubroutineCall'}{'Name'} = $name;

				if ( defined $Sname
					and not exists $Sf->{'CalledSubs'}{$name} )
				{
					$Sf->{'CalledSubs'}{$name} = 1;
					if (   not exists $Sname->{'Status'}
						or $Sname->{'Status'} < $PARSED
						or $gen_sub )
					{
						print "\tFOUND SUBROUTINE CALL $name in $f\n" if $V;
						$stref = parse_fortran_src( $name, $stref );
					}
				}
			}

			# Maybe Function calls
			if (   $line !~ /function\s/
				&& $line !~ /subroutine\s/
				&& $line =~ /(\w+)\(/ )
			{
				my @chunks = ();
				my $cline  = $line;
				while ( $cline =~ /(\w+)\(/ ) {
					if ( $line !~ /call\s+$1/ ) {
						push @chunks, $1;
						$cline =~ s/$1\(//;
					} else {
						$cline =~ s/call\s+\w+\(//;
					}
				}
				for my $chunk (@chunks) {
					if (
						exists $stref->{'Functions'}{$chunk}

					   # This means it's the first call to function $chunk in $f
						and not exists $Sf->{'CalledFunctions'}{$chunk}
					  )
					{
						$Sf->{'CalledFunctions'}{$chunk} = 1;
						print "FOUND FUNCTION CALL $chunk in $f\n" if $V;
						if ( $chunk eq $f ) {							
							show($srcref); 
							die $line 
						}
						$stref->{'Functions'}{$chunk}{'Called'} = 1;

# We need to parse the function to detect called functions inside it, unless that has been done
						if (   not exists $stref->{'Functions'}{$chunk}
							or not
							exists $stref->{'Functions'}{$chunk}{'Status'}
							or $stref->{'Functions'}{$chunk}{'Status'} <
							$PARSED )
						{
							$stref = parse_fortran_src( $chunk, $stref );
						} else {
							$stref = add_to_call_tree( $chunk, $stref, $f );
						}
						
                if ( exists $Sf->{'Translate'}
                and not exists $stref->{'Functions'}{$chunk}{'Translate'}
                 ) {
                    $stref->{'Functions'}{$chunk}{'Translate'} = $Sf->{'Translate'};  
                }
						
						
					}
				}
			}

			$srcref->[$index] = [ $line, $info ];
		}    # loop over all annlines

		#        $Sf->{'CalledSubs'}=\%called_subs;
	}
	return $stref;
}    # END of parse_subroutine_and_function_calls()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

sub get_commons_params_from_includes {
	( my $f, my $stref ) = @_;
	my $Sf     = $stref->{'IncludeFiles'}{$f};
	my $srcref = $Sf->{'AnnLines'};

	if ( defined $srcref ) {

		$Sf->{'Parameters'} = {};
		$Sf->{'Parameters'}{'OrderedList'} = [];

		my %vars = %{ $stref->{'IncludeFiles'}{$f}{'Vars'} };

		if ( exists $vars{''} ) { croak "EMPTY VAR! in $f" }
		my $has_pars    = 0;
		my $has_commons = 0;

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s/ ) {
				next;
			}

			if ( $line =~ /^\s*common\s+\/\s*[\w\d]+\s*\/\s+(.+)$/ ) {
				my $commonlst = $1;
				$has_commons = 1;
				my @tcommons = split( /\s*\,\s*/, $commonlst );
				for my $var (@tcommons) {
					if ( not defined $vars{$var} ) {
						print "WARNING: common <", $var, "> is not in {'IncludeFiles'}{$f}{'Vars'}\n" if $W;
					} else {
						print $var, "\t", $vars{$var}{'Type'}, "\n"
						  if $V;

						$stref->{'IncludeFiles'}{$f}{'Commons'}{$var} =
						  $vars{$var};
					}
				}
				$srcref->[$index][1]{'Common'} = {};
			}

			if ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ ) {

				my $parliststr = $1;

				#                warn "PARAM:$parliststr\n";
				$has_pars = 1;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) }
				  @partups;    # Perl::Critic, EYHO # s/\s*=.+//; $_

				#                warn Dumper(%pvars);
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my @pars = ();
				for my $var (@pvarl) {
					if ( not defined $vars{$var} ) {
						print "WARNING: PARAMETER $var not declared in $f\n"
						  if $W;
					} else {
						$Sf->{'Parameters'}{$var} = {
							'Type' => 'Unknown',
							'Var'  => $vars{$var},
							'Val'  => $pvars{$var}
						};
						push @pars, $var;

						#                         print "PAR: $var\n" ;
					}
				}
				@{ $Sf->{'Parameters'}{'OrderedList'} } =
				  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @pars );

#                print "PARLIST: ",join(',',@{ $Sf->{'Parameters'}{'OrderedList'} }),"\n";
				$srcref->[$index][1]{'Parameter'} = [@pars];
			} elsif ( $line =~ /,\s*parameter\s*.*?::\s*(\w+)\s*=\s*(.+?)\s*$/ )
			{    # F95-style parameters
				my $type = $line;
				$type =~ s/^\s+//;
				$type =~ s/\s*\:\:.*$//;
				my $parliststr = $1;
				$has_pars = 1;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my @pars  = ();

				for my $var (@pvarl) {
					if ( not defined $vars{$var} ) {
						print
"WARNING: PARAMETER $var not declared in $f (F95-style)\n"
						  if $W;
					} else {
						$Sf->{'Parameters'}{$var} = {
							'Type' => $type,
							'Var'  => $vars{$var},
							'Val'  => $pvars{$var}
						};
						push @pars, $var;
					}
				}
				@{ $Sf->{'Parameters'}{'OrderedList'} } =
				  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @pars );
				$srcref->[$index][1]{'Parameter'} = {};

			}

			$srcref->[$index] = [ $line, $info ];
		}    # loop over annlines

		if ($V) {
			print "\nCOMMONS for $f:\n\n";
			for my $v ( sort keys %{ $Sf->{'Commons'} } ) {
				print $v, "\n";
			}
		}

		# FIXME!
		# An include file should basically only contain parameters and commons.
		# If it contains commons, we should remove them!
		if ( $has_commons && $has_pars ) {
			die
"The include file $f contains both parameters and commons, this is not yet supported.\n";
		} elsif ($has_commons) {
			$Sf->{'InclType'} = 'Common';
		} elsif ($has_pars) {
			$Sf->{'InclType'} = 'Parameter';
		} else {
			$Sf->{'InclType'} = 'None';
		}
		for my $var ( keys %vars ) {
			if (
				( $has_pars and not exists( $Sf->{'Parameters'}{$var} ) )
				or ( $has_commons
					and not exists( $Sf->{'Commons'}{$var} ) )
			  )
			{
				for my $annline ( @{ $Sf->{'AnnLines'} } ) {
					next
					  if $annline->[0] eq ''
					  or exists $annline->[1]{'Comments'};
					if ( $annline->[0] =~ /$var/ ) {
						warn "PROBLEM WITH $var on next line\n";
					}
					warn $annline->[0], "\n";

				}

				#                warn Dumper( $Sf->{'AnnLines'} );
				croak
"The include $f contains a variable <$var> that is neither a parameter nor a common variable, this is not supported\n";
			}
		}
	}

#    die if $f eq 'includepar';
#    croak Dumper($stref->{'IncludeFiles'}{$f}{'Commons'}{'memind'}) if $f eq 'includecom'; #OK here
	return $stref;
}    # END of get_commons_params_from_includes()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
#sub pushAnnLine {
#	(my $stref, my $f, my $srctype,my $line, my $free_form)=@_;
#	my $pline = procLine( $line, $free_form );
#	
#    if ( exists $pline->[1]{'SubroutineSig'} ) {
#    	$stref->{$srctype}{$f}{'Status'} = $READ;
#        $srctype='Subroutines';
##        print "FOUND SUB $f\n";        
#        $f=$pline->[1]{'SubroutineSig'};      
#        $stref->{$srctype}{$f}{'AnnLines'}=[];                          
#    } elsif (exists $pline->[1]{'FunctionSig'} ) {
#    	$stref->{$srctype}{$f}{'Status'} = $READ;
#        $srctype='Functions';        
#        $f=$pline->[1]{'FunctionSig'};
##        print "FOUND FUNC $f\n";
#        $stref->{$srctype}{$f}{'AnnLines'}=[];
#    }
#    push @{ $stref->{$srctype}{$f}{'AnnLines'} }, $pline;
#    print "PUSH: {$srctype}{$f}{'AnnLines'} $pline->[0]\n" if $V;
##    print "NOW IN $f\n";
#	return ($stref,$f,$srctype);	
#} # pushAnnLine()
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
#sub isCont {
#	( my $line, my $free_form ) = @_;
#	my $is_cont = 0;
#	if ( $free_form == 0 ) {
#		if ( $line =~ /^\ {5}[^0\s]/ )
#		{    # continuation line. Continuation character can be anything!
#			$is_cont = 1;
#		} elsif ( $line =~ /^\&/ ) {
#			$is_cont = 1;
#		} elsif ( $line =~ /^\t[1-9]/ ) {
#			$is_cont = 1;
#		}
#	} else {
#		if ( $line =~ /^\s*\&/ ) {
#			$is_cont = 1;
#		}
#	}
#	return $is_cont;
#}
## -----------------------------------------------------------------------------
#sub removeCont {
#	( my $line, my $free_form ) = @_;
#    chomp $line;
#    if (isCommentOrBlank($line) ) {
#    	return '';
#    } 
#	if ( $free_form == 0 ) {
#		if ( $line =~ /^\ {5}[^0\s]/ )
#		{    # continuation line. Continuation character can be anything!
#			$line =~ s/^\s{5}.\s*/ /;
#		} elsif ( $line =~ /^\&/ ) {
#			$line =~ s/^\&\t*/ /;
#		} elsif ( $line =~ /^\t[1-9]/ ) {
#			$line =~ s/^\t[0-9]/ /;
#		}
#	} else {
#		if ( $line =~ /^\s*\&/ ) {
#			$line =~ s/^\s*\&\s*/ /;
#		}
#	}
#	if ( $line =~ /.\!.*$/ ) {    # FIXME: trailing comments are discarded!
#		my $tline = $line;
#		my $nline = '';
#		my $i     = 0;
#		my %phs   = ();
#		while ( $tline =~ /(\'.+?\')/ ) {
#			$phs{"__PH${i}__"} = $1;
#			$tline =~ s/(\'.+?\')/__PH${i}__/;
#			$i++;
#		}
#		if ( $tline =~ /\!.*$/ ) {
#			$nline = ( split( /\!/, $tline ) )[0];
#			for my $phk ( keys %phs ) {
#				$nline =~ s/$phk/$phs{$phk}/;
#			}
#			$line = $nline;
#		} else {
#			for my $phk ( keys %phs ) {
#                $tline =~ s/$phk/$phs{$phk}/;
#            }
#			$line=$tline;
#		}		
#	}
#	return $line;
#}


# -----------------------------------------------------------------------------
=pod
 What we do is:
 - reformat lines with labels
 - replace strings
 - detect and standardise comments
 - add metadata
=cut
#
#sub procLine {
#	( my $line, my $free_form ) = @_;
#
#	chomp $line;
#	my $info = {};
#
#	# Detect and standardise comments
#	if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
#		$line =~ s/^\s*[CcDd\*\!]/! /;
#		$info->{'Comments'} = 1;
#	} elsif ( $line =~ /.\!.*$/ ) {    # FIXME: trailing comments are discarded!
#		my $tline = $line;
#		my $nline = '';
#		my $i     = 0;
#		my %phs   = ();
#		while ( $tline =~ /(\'.+?\')/ ) {
#			$phs{"__PH${i}__"} = $1;
#			$tline =~ s/(\'.+?\')/__PH${i}__/;
#			$i++;
#		}
#        my $cline = $line;
#        $cline =~ s/^.+?\!//;    # FIXME: not quite correct
#
#		if ( $tline =~ /\!.*$/ ) {
#			$nline = ( split( /\!/, $tline ) )[0];
#			for my $phk ( keys %phs ) {
#				$nline =~ s/$phk/$phs{$phk}/;
#			}
#			$line=$nline;
#		} else {
#			for my $phk ( keys %phs ) {
#                $tline =~ s/$phk/$phs{$phk}/;
#            }
#            $line=$tline;
#		}		
#		$info->{'TrailingComment'} = $cline;
#	} else {
#		my $sixspaces = ' ' x 6;
#		$line =~ s/^\t/$sixspaces/;
#		$line =~ /^(\d+)\t/ && do {
#			my $label  = $1;
#			my $ndig   = length($label);
#			my $indent = ' ' x ( 6 - $ndig );
#			my $str    = $label . $indent;
#			$line =~ s/^(\d+)\t/$str/;
#			$info->{'Label'} = $label;
#		};
#		$line =~ /^(\d+)\s+/ && do {
#			my $label = $1;
#			$info->{'Label'} = $label;
#			my $ndig   = length($label);
#			my $indent = ' ' x ( 6 - $ndig );
#			my $str    = $label . $indent;
#			$line =~ s/^(\d+)\s+/$str/;
#		};
#	}
#	;
#	if ( substr( $line, 0, 2 ) ne '! ' ) {
#		if ( $line =~ /^\s+include\s+\'(\w+)\'/i ) {
#			$info->{'Includes'} = $1;
#			$line =~ s/\bINCLUDE\b/include/;
#			
#			
#		} elsif (  $line!~/\'/ && $line =~
#                    /\b(program|recursive\s+subroutine|subroutine|function)\s+(\w+)/i )
#                {
#                    my $keyword = lc($1);
#                    my $name = lc($2);
#                    die "procLine(): No name for $keyword " if $name eq '';
#                    if ( $keyword eq 'function' ) {                        
#                        $info-> { 'FunctionSig'} = $name;
#                    } else {                        
#                        $info ->{ 'SubroutineSig'} = $name ;                        
#                    }            
#                    $line=lc($line);
#		} else {
#
#			# replace string constants by placeholders
#			my $phs_ref = {};
#			my $ct=0;
#			while ( $line =~ /(\'.*?\')/ ) {
#				my $strconst = $1;
#				my $ph       = '__PH' . $ct . '__';
#				$phs_ref->{$ph} = $strconst;
#				$line =~ s/\'.*?\'/$ph/;
#				$ct++;
#			}
#			my $lcline =
#			  ( substr( $line, 0, 2 ) eq '! ' )
#			  ? $line
#			  : lc($line);
#			$lcline =~ s/__ph(\d+)__/__PH$1__/g;
#			$line = $lcline;
#			$info->{'PlaceHolders'} = $phs_ref unless (keys %{$phs_ref} == 0);
#		}
#	}
#	return [ $line, $info ];
#} # procLine()

# -----------------------------------------------------------------------------
#sub isCommentOrBlank {
#	( my $line ) = @_;
#
#	# Detect comments & blank lines
#	if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
#		return 1;
#	} elsif ( $line =~ /^\s*$/ ) {
#		return 1;
#	}
#	return 0;
#}

# -----------------------------------------------------------------------------
# Proper FSM parser for F77 variable declarations (apart from the type)
sub parse_vardecl {
	( my $varlst, my $T ) = @_;

	print "VARLST: <$varlst>\n" if $T;

	# parse varlst into this hash
	my $vars = {};

	#  We need following states:
	my (
		$do_nothing,     # 0
		$read_var,       # 1
		$store_var,      # 2
		$found_len,      # 3
		$read_len,       # 4
		$store_len,      # 5
		$found_shape,    # 6
		$read_shape,     # 7
		$store_shape     # 8
	) = 0 .. 8;

	my @states = qw(
	  do_nothing
	  read_var
	  store_var
	  found_len
	  read_len
	  store_len
	  found_shape
	  read_shape
	  store_shape
	);

	# initial state
	my $st = $do_nothing;

	# inside read_shape, we need a parenthesis counter:
	my $nest_count = 0;

	my $var   = '';
	my $pvar  = '';
	my $shape = '';
	my $len   = '';
	my $pc    = '';

	for my $c ( split( '', $varlst ) ) {

		my $pst = $st;    # previous state, for testing only

#### The transitions are:

		if ( $st == $do_nothing ) {
			if ( $c =~ /[a-z]/ ) { $st = $read_var }
			elsif ( $c eq '*' ) { $st = $read_len; next; }
			elsif ( $c eq '(' ) { $st = $found_shape; $nest_count = 0 }
		} elsif ( $st == $read_var && $c =~ /\W/ ) {
			$st = $store_var;
		} elsif ( $st == $store_var ) {
			if ( $pc eq '*' ) {
				$st = $read_len;
			} elsif ( $pc eq '(' ) {
				$st         = $read_shape;
				$nest_count = 0;
			} elsif ( $c eq '(' ) {
				$st         = $found_shape;
				$nest_count = 0;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $read_len && $c =~ /[\s,]/ ) {
			$st = $store_len;
		} elsif ( $st == $store_len ) {
			if ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $found_len ) {
			$st = $read_len;
		} elsif ( $st == $found_shape ) {
			if ( $c eq ')' ) {
				$st = $store_shape;
			} else {
				$st = $read_shape;
			}
		} elsif ( $st == $read_shape && $nest_count <= 0 && $c eq ')' ) {
			$st = $store_shape;
		} elsif ( $st == $store_shape ) {
			if ( $c eq '*' ) {
				$st = $found_len;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		}
		print
" PC: $pc; C:$c; NC: $nest_count; ST: $states[$st]; PST: $states[$pst]\n"
		  if $T;

##### The actions are:
		if    ( $st == $read_var ) { $var .= $c }
		elsif ( $st == $read_len ) { $len .= $c }

		#    elsif ($st==$found_shape) {$shape.=$c;}
		elsif ( $st == $read_shape ) {
			$shape .= $c;
			if    ( $c eq '(' ) { $nest_count++; }
			elsif ( $c eq ')' ) { $nest_count--; }
		} elsif ( $st == $store_var ) {
			print "VAR:[$var]\n" if $T;
			if ( $var eq '' ) { croak $varlst }
			$vars->{$var}{'Kind'}  = 'Scalar';
			$vars->{$var}{'Shape'} = [];
			$pvar                  = $var;
			$var                   = '';
		} elsif ( $st == $store_len ) {
			print "LEN: {$len}\n" if $T;
			$vars->{$pvar}{'Attr'} = $len;
			$len = '';
		} elsif ( $st == $store_shape ) {
			print "SHAPE: <$shape>\n" if $T;
			$shape =~ s/^\s+//;
			$shape =~ s/\s+$//;
			my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
			my @shape = ();
			for my $range (@ranges) {
				if ( $range =~ /:/ ) {
					push @shape, split( /:/, $range );
				} else {
					push @shape, ( '1', $range );
				}
			}
			$vars->{$pvar}{'Shape'} = [@shape];
			$vars->{$pvar}{'Kind'}  = 'Array';
			$shape                  = '';
		}
		$pc = $c;

	}
	if ($T) {
		print "VAR: $var\n";
		print "PVAR: $var\n";
		print "SHAPE: $shape\n";
		print "LEN: $len\n";
		print "STATE: $states[$st]\n";
	}
#### Pending actions on end of string

	if ( $st == $read_var && $var ne '' ) {
		$vars->{$var} = { 'Shape' => [], 'Kind' => 'Scalar' };
	} elsif ( $st == $read_len && $pvar ne '' ) {
		$vars->{$pvar}{'Attr'} = $len;
	} elsif ( $st == $read_shape && $pvar ne '' ) {
		$shape =~ s/^\s+//;
		$shape =~ s/\s+$//;
		my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
		my @shape = ();
		for my $range (@ranges) {
			if ( $range =~ /:/ ) {
				push @shape, split( /:/, $range );
			} else {
				push @shape, ( '1', $range );
			}
		}
		$vars->{$pvar}{'Shape'} = [@shape];
		$vars->{$pvar}{'Kind'}  = 'Array';
	}

	return $vars;
}

package RefactorF4Acc::Utils;
use v5.10;
use POSIX;
use RefactorF4Acc::Config;
use RefactorF4Acc::F95SpecWords qw( %F95_intrinsic_function_sigs );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Utils::ISA = qw(Exporter);

@RefactorF4Acc::Utils::EXPORT = qw(
    &sub_func_incl_mod
    &show_annlines
    &pp_annlines
    &pp_info
    &write_out
    &get_maybe_args_globs
    &type_via_implicits
    &module_has
    &module_has_only
    &module_has_also
    &generate_docs
    &show_status
    &in_nested_set
    &get_vars_from_set
    &merge_subsets
    &get_var_record_from_set
    &add_var_decl_to_set
    &remove_var_decl_from_set
    &get_kv_for_all_elts_in_set
    &append_to_set
    &find_keys_for_value
    &comment
    &numeric
    $BLANK_LINE
    &annotate
    &add_ann_to_info
    &alias_ordered_set
    &remove_vars_from_ordered_set
    &get_module_name_from_source
    &get_kernel_and_module_names
    &get_block_id
    &is_array_decl
    &is_arg
    &is_array
    &is_string
    &is_array_or_string
    &is_character
    &is_param
    &warning
    &error
    &coderef_to_subname
    &toLower
    &tabToFixed
);



our $BLANK_LINE = ['',{'Blank'=>1,'Ref'=>1}];

sub get_kernel_and_module_names {
    my ($kernel_src, $superkernel) = @_;

    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    # say 'NAMES:',Dumper grep {/subroutine/} @src_lines;
    my @kernel_sub_names    = map {/^\s*subroutine\s+(\w+)/; $1} grep { /^\s*subroutine\s+\w+/ } @src_lines;
    my $kernel_sub_name='NO_NAME';
    if (defined $superkernel) {
            ($kernel_sub_name) = grep {/superkernel/} @kernel_sub_names;
    } else {
            ($kernel_sub_name) = grep {!/superkernel/} @kernel_sub_names;
    }
    say "KERNEL SUB NAME: <$kernel_sub_name>" if $V;
    my ($kernel_module_name) = map { /^\s*module\s+(\w+)/; $1 } grep {/^\s*module\s+\w+/} @src_lines;
    say "KERNEL MODULE NAME: <$kernel_module_name>" if $V;
    return ($kernel_sub_name, $kernel_module_name);
} # END of get_kernel_and_module_names


sub get_module_name_from_source { (my $stref,my $fp) = @_;
	if (exists $stref->{'SourceFiles'}{$fp}{'SourceType'} and $stref->{'SourceFiles'}{$fp}{'SourceType'} eq 'Modules') {
	   return $stref->{'SourceFiles'}{$fp}{'ModuleName'};
	} else {
		return $fp;
	}
}
# This is a utility function to create references for one set to another.
# now we can say e.g.  alias_ordered_set($stref,$f, 'RefactoredArgs','DeclaredOrigArgs')
sub alias_ordered_set { (my $stref,my $f,my $alias,my $orig) = @_;
	$stref->{'Subroutines'}{$f}{$alias}{'Set'}=$stref->{'Subroutines'}{$f}{$orig}{'Set'};
	$stref->{'Subroutines'}{$f}{$alias}{'List'}=$stref->{'Subroutines'}{$f}{$orig}{'List'};
    # This is so far only used for RefactoredArgs
    $stref->{'Subroutines'}{$f}{'Has'.$alias} = 1;
	return $stref;
}
# $vars_to_remove is an array ref; $ordered_set a ref to a Set,List combo
sub remove_vars_from_ordered_set { (my $ordered_set, my $vars_to_remove)=@_;

	for my $var (@{$vars_to_remove}) {
        # say "DBG: Deleting $var from ordered set ";# if $DBG;
		delete $ordered_set->{'Set'}{$var};
	}
	$ordered_set->{'List'}  = [ grep {exists $ordered_set->{'Set'}{$_}} @{ $ordered_set->{'List'} } ];
	return $ordered_set;
} # END of remove_var_from_ordered_set

sub annotate { (my $f, my $ann, my $nframes)=@_;
croak "Code unit is not defined in annotate()" if not defined $f;
    my $n = defined $nframes ? $nframes : 1;
    (my $package, my $filename, my $line, my $subroutine, my @rest) = caller($n);
    $subroutine=~s/RefactorF4Acc:://;
    return $subroutine.'('.$f.') '.(defined $nframes? $line.' ' : '').$ann;
}

sub add_ann_to_info { my ($info, $f, $ann, $nframes)=@_;
    my $n = defined $nframes ? $nframes : 1;
    (my $package, my $filename, my $line, my $subroutine, my @rest) = caller($n);
    $subroutine=~s/RefactorF4Acc:://;
    push @{$info->{'Ann'}}, $subroutine.'('.$f.') '.(defined $nframes? $line.' ' : '').$ann;
    return $info;
}

sub comment { (my $comment)=@_;
	if  (ref($comment) eq 'ARRAY') {
		(my $line, my $info) = @{$comment};
		return ['! '.$line, {%{$info},'Comments'=>1,'Ref'=>1}];
	} else {
	   return ['! '.$comment, {'Comments'=>1,'Ref'=>1}];
	}
}

sub numeric  ($$) { $_[0] <=> $_[1]; }

sub sub_func_incl_mod {
    ( my $f, my $stref ) = @_;
    local $DBG=1;
    if (not defined $stref) {croak "arg not defined sub_func_incl_mod" }
    croak join(' ; ', caller )  if $DBG and $stref!~/0x/;
    croak if $DBG and not defined $f;
    if ( exists $stref->{'Subroutines'}{$f} ) {
        if (not  exists $stref->{'Modules'}{$f} ) {
            return 'Subroutines';
        } elsif (exists $stref->{'Subroutines'}{$f}{'Source'}) {
                return 'Subroutines';
        } elsif (exists $stref->{'Modules'}{$f}{'Source'}) {
            return 'Modules';
        }
#    } elsif ( exists $stref->{'Functions'}{$f} ) {
#        return 'Functions';
    } elsif ( exists $stref->{'IncludeFiles'}{$f} ) {
        return 'IncludeFiles';
    } elsif ( exists $stref->{'Modules'}{$f} ) { # So we only say it's a module if it is nothing else.
        return 'Modules';
    } elsif ( exists $stref->{'SourceFiles'}{$f} ) { # So we only say it's a module if it is nothing else.
        if (exists $stref->{'SourceFiles'}{$f}{'SourceType'} and $stref->{'SourceFiles'}{$f}{'SourceType'} eq 'Modules') {
        	return 'Modules';
        } else {
            return 'SourceFiles';
        }
    } else {
#        #print Dumper($stref);
#        #croak "No entry for $f in the state\n";
        # Assuming it's a C function
#WV23JUL
        return 'ExternalSubroutines';
    }
}
# -----------------------------------------------------------------------------
sub write_out { my ($src_str, $out_path)=@_;
    my $out_path_=$out_path;
    if (not defined $out_path ) {
        if ( $Config{'CUSTOM_PASS_OUTPUT_PATH'} eq '') {
            die "Either provide the output path as 2nd arg, or via CUSTOM_PASS_OUTPUT_PATH";
        } else {
            $out_path_= $Config{'CUSTOM_PASS_OUTPUT_PATH'};
        }
    }
    if ($out_path_ eq 'STDOUT') {
        say $src_str;
    } else {
        open my $OUT, '>', $out_path_ or die $!.': '.$out_path_;
        print $OUT $src_str;
        close $OUT;
    }
}
# -----------------------------------------------------------------------------
sub show_annlines {
    (my $annlines, my $with_info)=@_;
    for my $annline (@{ $annlines }) {
        if(ref($annline->[0]) eq 'ARRAY') {
            die "NOT A STRING: ".Dumper($annline->[0]);
        } else {
            print $annline->[0];
            if($with_info) {
                print "  ! <";
                for my $k (sort keys %{ $annline->[1] }) {
                    next if $k eq 'Indent';
                    if ($k eq 'Ann') {
                        print  $k.'=>'."\n\t! ".join("\n\t! ",@{$annline->[1]{$k}})."\n  !  ";
                    }
                    elsif ( not ref( $annline->[1]{$k} ) and defined $annline->[1]{$k} and $annline->[1]{$k} ne '') {
                        print  $k.'=>'.$annline->[1]{$k}.';';
                    }  else {
                        print "$k;"
                    }
                }
                print ">\n";
            } else { print "\n";

            }
        }
    }
}
 # -----------------------------------------------------------------------------
sub pp_annlines {
    (my $annlines, my $with_info)=@_;
    my @pp_annlines=();
    for my $annline (@{ $annlines }) {
        if(ref($annline->[0]) eq 'ARRAY') {
            die "NOT A STRING: ".Dumper($annline->[0]);
        } else {
            my $pp_annline = $annline->[0];
            if($with_info) {
#             ? "\t<";#.join(';',keys %{ $annline->[1] }).'>' : '');
                $pp_annline.= "  ! <";
                for my $k (keys %{ $annline->[1] }) {
                    if ( not ref( $annline->[1]{$k} ) ) {
                        $pp_annline.=  $k.'=>'.$annline->[1]{$k}.';';
                    }  else {
                        $pp_annline.= "$k;"
                    }
                }
                $pp_annline.= ">";

            }
            push @pp_annlines,$pp_annline;
        }
    }
    return \@pp_annlines;
}
# -----------------------------------------------------------------------------
sub pp_info { my ($info, $full) = @_;
    local $Data::Dumper::Indent = 0;
    local $Data::Dumper::Terse  = 1;
    my $pp_info='';
    for my $k (keys %{ $info }) {
        if ( not ref( $info->{$k} ) ) {
            $pp_info.=  $k.'=>'.$info->{$k}.';';
        }  else {
            if ($full){
                $pp_info.=  $k.'=>'.Dumper($info->{$k}).';';
            } else {
                $pp_info.= "$k;"
            }
        }
    }
    return $pp_info;
}
sub toLower { (my $str) = @_;
    if ($Config{'PRESERVE_CASE'}) { return $str } else { return lc($str) }
}

# -----------------------------------------------------------------------------
sub tabToFixed{ (my $line) = @_;

# Tab-Format

# The tab-format source lines are defined as follows: 

#     A tab in any of columns 1 through 6, or an ampersand in column 1, establishes the line as a tab-format source line.
        # This should really be done in the SrcReader!
#     If the tab is the first nonblank character, the text following the tab is scanned as if it started in column 7.
    my $cols1to6 = substr($line,0,6);
    my $tline = $line;
    if ($cols1to6 =~/^\t\D/) {
    #   =>replace tab by 6 spaces
        $cols1to6 = ' ' x 6;
        $tline=~s/^\t//; $tline = $cols1to6 . $tline;
    }
#  A comment indicator or a statement number can precede the tab.
    elsif ($cols1to6 =~/^[cC\*]\t/) {
        # => change to C followed by 5 spaces
        $cols1to6 = 'C'.(' ' x 5);
        $tline=~s/^[cC\*]\t//; $tline = $cols1to6 . $tline; 
    }
    elsif ($cols1to6 =~ /^(\s*\d+)\t/) { # The space is not following the spec
        #   => change to $1 followed by 6 - len($1) spaces
        my $label =$1;
        $cols1to6 = $label . (' ' x (6 - length($label)));
        $tline=~s/^\s*\d+\t//; $tline = $cols1to6 . $tline;
    }
#     Continuation lines are identified by an ampersand (&) in column 1, or a nonzero digit after the first tab.
    elsif ($cols1to6 =~ /^(?:\&|\t[1-9])/ ) {
        # => change to & in column 6
        $cols1to6 = (' ' x 5) . '&';
        $tline=~s/^(?:\&|\t[1-9])//; $tline = $cols1to6 . $tline;
    }
    
    # $line = $tline;
    return ($tline, $cols1to6);
}
# -----------------------------------------------------------------------------
sub get_maybe_args_globs {
    ( my $stref, my $f ) = @_;
    my $Sf         = $stref->{'Subroutines'}{$f};
    my @globs      = ();
    my %maybe_args = ();
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        if ( defined $Sf->{'Globals'}{$inc} and defined $Sf->{'Globals'}{$inc}{'List'} and scalar @{defined $Sf->{'Globals'}{$inc}{'List'}} > 0 ) {
            @globs = ( @globs, @{ $Sf->{'Globals'}{$inc}{'List'} } );
        }
        if ( defined $stref->{'IncludeFiles'}{$inc}{'Vars'} ) {
            %maybe_args =
              ( %maybe_args, %{ $stref->{'IncludeFiles'}{$inc}{'Vars'} } );
        }
    }
    %maybe_args = ( %{ $Sf->{'Vars'} }, %maybe_args );
    my %globals = map { $_ => 1 } @globs;
    return ( \%maybe_args, \%globals );
}
# -----------------------------------------------------------------------------
sub type_via_implicits { (my $stref, my $f, my $var)=@_;
if ($DBG and not defined $var or $var eq '') {croak "VAR not defined!"}
    my $sub_func_incl = sub_func_incl_mod( $f, $stref );
    my $type ='Unknown';
    my $array_or_scalar ='Unknown';

	my $attr='Unknown';
    if (exists $stref->{'Implicits'}{$f}{lc(substr($var,0,1))} ) {
        print "INFO: VAR <", $var, "> typed via Implicits for $f\n" if $I;
        my $type_kind_attr = $stref->{'Implicits'}{$f}{lc(substr($var,0,1))};
        ($type, $array_or_scalar, $attr)=@{$type_kind_attr};
    }
    if ($type eq 'Unknown') {
        print "INFO: Common <", $var, "> has no rule in {'Implicits'}{$f}, typing via Fortran defaults\n" if $I;
        # In the absence of an implicit statement, a program unit is treated as if it had a host with the declaration
        #  implicit integer (i-n), real (a-h, o-z)
        if ($var=~/^[i-nI-N]/) { #
            return ('integer', 'Scalar',  '');
        } else {
            return ('real', 'Scalar',  '');
        }
    }
    return ($type, $array_or_scalar, $attr);
} # END of type_via_implicits()

# -----------------------------------------------------------------------------
# Returns true if the module contains all items in the  $mod_has_lst
sub module_has { (my $stref, my $mod_name, my $mod_has_lst) = @_;

    my @mod_keys = keys %{ $stref->{'Modules'}{$mod_name} };
    my %mod_has = map { {$_ => 1 } } @mod_keys;
    for my $k (@{$mod_has_lst} ) {
        if (not exists $mod_has{$k}) {
            return 0;
        }
    }
    return 1;
}
# -----------------------------------------------------------------------------
# Returns true if the module contains only items in the $mod_only list, at least one of them
sub module_has_only { (my $stref, my $mod_name, my $mod_only) = @_;
#print "\nMODULE $mod_name INLINEABLE?\n";

#    print 'MOD_KEYS:'."\n".Dumper(keys %{ $stref->{'Modules'}{$mod_name} });
my %mod_has=();
for my $k ( keys %{ $stref->{'Modules'}{$mod_name} } ) {
    $mod_has{$k}=$stref->{'Modules'}{$mod_name}{$k};
}

#'TypeDecls' => {},'Uses' => {'params_common_sn' => {}},'Source' => './common_sn.f95'
    for my $k (@{$mod_only},'Status','Source','FStyle','FreeForm','HasBlocks','Inlineable','InlineableSubs','TabFormat', 'ModType' ) {
#        print "INL: ONLY: $k\n";
        if (exists $mod_has{$k}) {
            delete $mod_has{$k};
        }
    }
#    print Dumper($mod_has{ModType});
#print 'INL MOD_HAS:'.Dumper(sort keys %mod_has)."\n";
#    die $mod_name if $mod_name=~/common/;
    if (scalar(keys( %mod_has )) > 0 ) {
#    	print 'NOT INLINEABLE MOD: '.$mod_name."\n";
    	return 0;

    } else {
#        print 'MAYBE INLINEABLE MOD: '.$mod_name."\n";
        return 1; }
}

sub module_has_also { (my $stref, my $mod_name, my $mod_only) = @_;
    my %mod_has=();
    for my $k ( keys %{ $stref->{'Modules'}{$mod_name} } ) {
        $mod_has{$k}=$stref->{'Modules'}{$mod_name}{$k};
    }
    for my $k (@{$mod_only},'Status','Source','FStyle','FreeForm','HasBlocks','Inlineable','InlineableSubs','TabFormat', 'ModType' ) {
        if (exists $mod_has{$k}) {
            delete $mod_has{$k};
        }
    }
    return join(', ',sort keys( %mod_has ))
} # END of module_has_also


# -----------------------------------------------------------------------------

# FIXME: this routine is now broken as it relied on all docs being in the main script
sub generate_docs {
    my $scriptsrc = $0;
    my $src       = $scriptsrc;
    $src =~ s/\.pl//;
    $src =~ s/^.*\///;
    my $markdownsrc = $src . '.markdown';
    open my $PL, '<', $scriptsrc;
    open my $MD, '>', $markdownsrc;
    my $md = 0;

    while (<$PL>) {
        /^=begin\s+markdown/ && do {
            $md = 1;
            next;
        };
        /^=end\s+markdown/ && do {
            $md = 0;
            next;
        };

        if ( $md == 1 ) {
            my $el = $_;
            $el =~ s/#TODO.*$//;
            while ( $el =~ /\|(\$\w+)\|/ ) {
                my $var  = $1;    # so this is a '$' and then some \w's
                my $evar = '';
                eval("\$evar= $var");

                #               warn $var, '=', $evar;
                my $svar = "\\|\\$var\\|";
                $el =~ s/$svar/$evar/;
            }
            print $MD $el;
        }
    }
    close $PL;
    close $MD;
    my $tex_src_in = $src . '_in.tex';
    system("pandoc -f markdown -t latex $markdownsrc > $tex_src_in ");

    my $tex_src_out = $src . '.tex';

    open my $TEXIN,  '<', $tex_src_in;
    open my $TEXOUT, '>', $tex_src_out;
    print $TEXOUT <<'ENDH';
\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{textcomp}

%%  Latex generated from POD in document /Users/wim/SoC_Research/FLEXPART/flx_wrf2/OpenCL-port/tools/refactor_block_subroutine.pod
%%  Using the perl module Pod::LaTeX
%%  Converted on Sun Nov 13 23:38:44 2011


\usepackage{makeidx}
\makeindex


\begin{document}

\tableofcontents

ENDH

    my $code = 0;
    while (<$TEXIN>) {
        /verbatim/ && do {
            $code = 1 - $code;
        };
        print $TEXOUT $_;
        if ($code) {

            #           print $TEXOUT "\n";
        }
    }
    close $TEXIN;
    print $TEXOUT '\printindex' . "\n";
    print $TEXOUT '\end{document}' . "\n";
    close $TEXOUT;

    #   system("pdflatex $tex_src_out");
    #   my @exts = qw(
    #     _in.tex
    #     .toc
    #     .log
    #     .idx
    #     .aux
    #   );
    #   map { unlink $src . $_ } @exts;

}
sub show_status {
    (my $st)=@_;
    my @status_str = ( 'UNREAD', 'INVENTORIED', 'READ', 'PARSED', 'FROM_BLOCK', 'C_SOURCE','FILE_NOT_FOUND' );
    return $status_str[$st];
}
# Test if a var is an element of a nested set. Returns the innermost set
sub in_nested_set { (my $set, my $set_key, my $var)=@_;

	croak 'Undefined var in call to in_nested_set()' if $DBG and not defined $var;
    if (exists $set->{$set_key}{'Subsets'} ) {
        for my $subset (keys %{  $set->{$set_key}{'Subsets'} } ) {
            my $retval = in_nested_set($set->{$set_key}{'Subsets'},$subset, $var);
            # As soon as we have found a match we return it.
            if ($retval ne '') {
            	return $retval;
            }
        }
    } elsif (exists $set->{$set_key}{'Set'}) {
    	# There are no Subsets but there is a Set
        if (exists $set->{$set_key}{'Set'}{$var}) {
        	return $set_key; # This returns to the caller, does not end the recursion
        } else {
        	return ''; # This returns to the caller, does not end the recursion
        }
    } else {
        return '';
    }
} # END of in_nested_set

# For a set with subsets, this gets the var records from all subsets
# returns a set
#our $indent=1;
sub get_vars_from_set { (my $set)=@_;
    my $vars={};
     if (exists $set->{'Subsets'} ) {
        for my $subset (keys %{  $set->{'Subsets'} } ) {
            my $vars_ref= get_vars_from_set($set->{'Subsets'}{$subset});
            $vars = { %{$vars}, %{$vars_ref} };
        }
    } elsif (exists $set->{'Set'}) {
        $vars = $set->{'Set'}  ;
    }
    return $vars;
}
# $stref->{'Modules'}{$mod}{'Parameters'}{'Subsets'}
sub merge_subsets { my ($subsets) = @_;
    my $merged_set = {};

    for my $subset (sort keys %{$subsets}) {
        if (scalar keys %{$subsets->{$subset}} == 1 and exists $subsets->{$subset}{'Subsets'}) {
            my ($merged_sset, $merged_slist) = merge_subsets($subsets->{$subset}{'Subsets'});
            $merged_set = {%{$merged_set}, %{$merged_sset}}
        } else {
            $merged_set = {%{$merged_set}, %{$subsets->{$subset}{'Set'}}}
        }
    }
    my $merged_list = [sort keys %{$merged_set}];
    return ($merged_set, $merged_list);
}

# set is by name here
sub add_var_decl_to_set { (my $Sf, my $set, my $var, my $decl)=@_;
	if (not exists 	$Sf->{$set}{'Set'}{$var}) {
		push @{$Sf->{$set}{'List'}}, $var;
    	$Sf->{$set}{'Set'}{$var}=$decl;
	}
	return $Sf;
} # END of add_var_decl_to_set

# set is by name here
sub remove_var_decl_from_set { (my $Sf, my $set, my $var)=@_;
	my @var_list=();
	if (exists 	$Sf->{$set}{'Set'}{$var}) {
		delete $Sf->{$set}{'Set'}{$var};
		@var_list = grep {$_ ne $var} @{$Sf->{$set}{'List'}};
		$Sf->{$set}{'List'}=[@var_list];
	}
	return $Sf;
} # END of add_var_decl_to_set


# Returns undef if the var rec is not there
sub get_var_record_from_set { (my $set, my $var)=@_;
    croak if not defined $var;
    my %vars=();
     if (exists $set->{'Subsets'} ) {
        for my $subset (keys %{  $set->{'Subsets'} } ) {
            my $vars_ref= get_vars_from_set($set->{'Subsets'}{$subset});
            if (exists $vars_ref->{$var}) {
            # say "get_var_record_from_set: SUBSET $subset for $var: ".Dumper($vars_ref->{$var}) ;
            # %vars = ( %vars, %{$vars_ref} );
            %vars =  %{$vars_ref} ;
            }
        }
    } elsif (exists $set->{'Set'}) {

        return $set->{'Set'}{$var} ;
    }
    return $vars{$var};
}

# For every key in a hash $set, get the hash that is its value, and in that has kind the kv pair for the key $k
# Typical use is e.g. get_kv_for_all_elts_in_set( $stref->{Subroutines},'IncludeFiles' ) or
# get_kv_for_all_elts_in_set( $stref->{'IncludeFiles'},'Root')

sub get_kv_for_all_elts_in_set {
	(my $set, my $k) =@_;
	my $results={};
	for my $elt (keys %{$set}) {
		if (exists $set->{$elt}{$k} ) {
			my $v = $set->{$elt}{$k};
			$results->{$elt}=$v;
		}
	}
	return $results;
}
# This expects a ref to { 'Set' => ...} for $set1 and either { 'Set' => ...} or { 'Subsets' => ...} for $set2
sub append_to_set { (my $set1, my $set2) = @_;
	# Flatten the set
	my $all_subsets_set2 = get_vars_from_set($set2);
	$set1->{'Set'} = { %{$set1->{'Set'}}, %{$all_subsets_set2} };
	$set1->{'List'} = [ sort keys %{ $set1->{'Set'} } ]; # WV: this destroys the order, but does it matter?
	return $set1;
}

sub find_keys_for_value { my ($map,$value) = @_;
# Minimal case: the value can match more than one key
# {s1=>c1,s2=>c1}
    my $keys=[];
    for my $key (sort keys %{$map}) {
        if ($map->{$key} eq "$value") {
            push @{$keys},$key;
        }
    }

    return $keys;
}

sub warning { my ($msg, $lev) = @_;
    if (not defined $lev) {$lev=0};
    return if ($WARNING_LEVEL==0 or $WARNING_LEVEL<$lev);
    if (not exists $messages->{'WARNING'}{$msg}) {
        $messages->{'WARNING'}{$msg}=1;
        if ($WARNING_LEVEL<=3) {
            say "WARNING: $msg"
        } else {
            carp "WARNING: $msg"
        }
    }
}

sub error { (my $str, my $dbg, my $extra_info)=@_;
    $extra_info//='NONE';
    my %type_errors = (
        'EQUVALENCE' => $Config{'STRICT_EQUIVALENCE_CHECKS'},
        'COMMON' => $Config{'STRICT_COMMONS_CHECKS'},
        'NONE' => 1
    );
    my $error_type = exists $type_errors{$extra_info} ? 'TYPE ERROR' : 'ERROR';
    if ((not exists $Config{'IGNORE_ERRORS'} or $Config{'IGNORE_ERRORS'}==0) and ($type_errors{$extra_info} or $extra_info=~/ERROR/i)) {
        if (defined $dbg and $dbg>0 or $DBG) {
            croak("$error_type: $str");
        } else {
            die "$error_type: $str\n";
        }
    } else {
        warning("IGNORED $error_type: $str");
    }
}

sub get_block_id { my ($block, $block_id) = @_;
    my $line_id = $block->{'LineID'};
    push @{$block_id},$line_id;
    my $in_block = $block->{'InBlock'};
    if (scalar keys %{$in_block} == 0) {
        return $block_id;
    } else {
        get_block_id($in_block,$block_id);
    }
}

sub is_array_decl { (my $info)=@_;
# carp Dumper $info->{'ParsedVarDecl'};
	return (exists $info->{'ParsedVarDecl'}
	&& exists $info->{'ParsedVarDecl'}{'Attributes'}
	&& exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}
	&& scalar @{$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}} >0)
	# because parse_F95_var_decl() returns Scalars as Dim => [0]
	&& $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}[0].'' ne '0';
}

sub coderef_to_subname { my ($coderef) = @_;
    use B qw(svref_2object);
    my $cv = svref_2object ( $coderef );
    my $gv = $cv->GV;
    return $gv->NAME;
}

sub is_arg {my ($stref,$f,$var) =@_;
    my $Sf = $stref->{'Subroutines'}{$f};
    if ($Sf->{'Program'}) { return 0 } else {
        return in_nested_set($Sf,'DeclaredOrigArgs',$var) eq 'DeclaredOrigArgs' ? 1 : 0;
    }
	# if ( in_nested_set($stref->{'Subroutines'}{$f},'Args',$var)) {
	# 	return 1;
	# } else {
	# 	return 0;
	# }
}
sub is_array { my ($stref,$f,$var) = @_;
    # For array index, string index of function call
    if ($var=~/\w+\s*\(/) {
        $var=~s/\s*\(.+$//;
    }
    my $Sf=$stref->{'Subroutines'}{$f};
	my $decl =  get_var_record_from_set($Sf->{'Vars'},$var) ;
    my $isArray = 0;
    if ( defined $decl) {
        $isArray = $decl->{'ArrayOrScalar'} eq 'Array';
    }
    return $isArray;
}
sub is_string { my ($stref,$f,$var) = @_;
    # For array index, string index of function call
    if ($var=~/\w+\s*\(/) {
        $var=~s/\s*\(.+$//;
    }
    my $Sf=$stref->{'Subroutines'}{$f};
	my $decl =  get_var_record_from_set($Sf->{'Vars'},$var) ;
    if (not defined $decl) { 
        # This could still be a string due to concatenation; it could also be a function returning a string
        # We ignore functions returning an array or array concatenation
        my $isString=0;
        if (exists $stref->{'Subroutines'}{$var}) {
            my $type =  $stref->{'Subroutines'}{$var}{'Signature'}{'ReturnType'} // '';
            my $attr = $stref->{'Subroutines'}{$var}{'Signature'}{'ReturnTypeAttr'} // '';
            if ($type eq 'character' && $attr=~/len=\d+/) {
                $isString=1;
            }
        }
        elsif (exists $F95_intrinsic_function_sigs{$var}) {
            if ($F95_intrinsic_function_sigs{$var}[1] eq 'character(*)') {
                $isString=1;
            }
        }
        elsif ($var =~/\/\//) {
            $isString=1;
        }
        # carp 'HERE1: <'.$isString.'>';
        return $isString;
    } else {
        my $ftype = $decl->{'Type'};
        my $fkind = $decl->{'Attr'};
        my $isString = ($decl->{'Type'} eq 'character' and (exists $decl->{'Attr'} and ($decl->{'Attr'} !~/len\s*=\s*1\)/))) ? 1 : 0;
        # carp 'HERE2: <'.$isString.'>'.Dumper($decl);
        return $isString;
    }
}
sub is_character { my ($stref,$f,$var) = @_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var) ;
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	my $isChar = ($decl->{'Type'} eq 'character' and (not exists $decl->{'Attr'} or ($decl->{'Attr'} =~/len\s*=\s*1\)/)));
    return $isChar;
}
sub is_array_or_string { my ($stref,$f,$var) = @_;
    # For array index, string index of function call
    if ($var=~/\w+\s*\(/) {
        $var=~s/\s*\(.+$//;
    }
    my $Sf=$stref->{'Subroutines'}{$f};
	my $decl =  get_var_record_from_set($Sf->{'Vars'},$var) ;
    if (not defined $decl) { 
        # This could still be a string due to concatenation; it could also be a function returning a string
        # We ignore functions returning an array or array concatenation
        my $isString=0;
        if (exists $stref->{'Subroutines'}{$var}) {
            my $type =  $stref->{'Subroutines'}{$var}{'Signature'}{'ReturnType'} // '';
            my $attr = $stref->{'Subroutines'}{$var}{'Signature'}{'ReturnTypeAttr'} // '';
            if ($type eq 'character' && $attr=~/len=\d+/) {
                $isString=1;
            }
        }
        elsif (exists $F95_intrinsic_function_sigs{$var}) {
            if ($F95_intrinsic_function_sigs{$var}[1] eq 'character(*)') {
                $isString=1;
            }
            return $isString;
        }
        elsif ($var =~/\/\//) {
            $isString=1;
        }
        return $isString;
    } else {
        my $ftype = $decl->{'Type'};
        my $fkind = $decl->{'Attr'};
        my $isArray = $decl->{'ArrayOrScalar'} eq 'Array';
        my $isString = ($decl->{'Type'} eq 'character' and (exists $decl->{'Attr'} and ($decl->{'Attr'} ne '' and $decl->{'Attr'} !~/len\s*=\s*1\)/)));
        # It could still be a character if only a single elt is accessed.
        # But that gets us into the difference between a character and a string of length 1
        return ($isArray or $isString);
    }
}

sub is_param { my ($stref,$f,$var) = @_;
    my $var_decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var) ;
	return (((defined $var_decl) and (exists $var_decl->{'Parameter'})) ? 1 : 0);
}

1;

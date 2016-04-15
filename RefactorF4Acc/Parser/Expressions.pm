package RefactorF4Acc::Parser::Expressions;
use v5.16;
use RefactorF4Acc::Config;

#
#   (c) 2010-2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 1;

use Math::Expression::Evaluator::Parser; 

use Exporter;

@RefactorF4Acc::Parser::Expressions::ISA = qw(Exporter);

@RefactorF4Acc::Parser::Expressions::EXPORT_OK = qw(
  &parse_expression
  &emit_expression
);

my $DBG=0;
=pod
[wim@workai RefactorF4Acc]$ perl -e 'use Data::Dumper;use Math::Expression::Evaluator::Parser; print Dumper(Math::Expression::Evaluator::Parser::parse("f(a,12.3,b(2,2.3e-4+v))",{}))'
$VAR1 = [
          '&',
          'f',
          [
            '$',
            'a'
          ],
          '12.3',
          [
            '&',
            'b',
            '2',
            [
              '+',
              '2.3e-4',
              [
                '$',
                'v'
              ]
            ]
          ]
        ];
=cut         
sub parse_expression { (my $exp, my $info, my $stref, my $f)=@_;
    my $ast = Math::Expression::Evaluator::Parser::parse($exp, {});
#    say Dumper($ast);
    ( $stref, $f, $info, $ast) =	_walk_ast($stref,$f,$info,$ast, sub {});
#    say Dumper($ast);
$info->{'ExpressionAST'}=$ast;
return ( $stref, $info)
}

sub _walk_ast { (my $stref, my $f, my $info, my $ast, my $ast_node_action)=@_;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
#		print "IDX: $idx => "; say Dumper ($ast); say $entry;
		if (ref($entry) eq 'ARRAY') {
			( $stref,  $f,  $info, my $entry) = _walk_ast($stref,$f,$info, $entry, $ast_node_action);
			$ast->[$idx] = $entry;
		} else {
			if ($entry eq '&') {
				say 'Found function'  if $DBG;
				my $mvar = $ast->[$idx+1];
#				say $mvar;
#				say Dumper($stref->{'Subroutines'}{$f});
				if (not exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{$mvar}) {
    		# change & to @
    				$ast->[$idx]='@';
    				say "Found array $mvar" if $DBG;
				}    	
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
				say "Found scalar $mvar" if $DBG;
				
			} elsif ($entry eq '@') {
				my $mvar = $ast->[$idx+1];
				say "Found array $mvar" if $DBG;
			} else {
#				say $entry;
			}
		}		
	}
	return ($stref,$f,$info, $ast);	
}

sub emit_expression {(my $ast, my $expr_str)=@_;
	my @expr_chunks=();
	my $skip=0;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			 my $nest_expr_str = emit_expression( $entry, '');
#			 say "NEST:$nest_expr_str ";
			push @expr_chunks, $nest_expr_str;
		} else {
			
			if ($entry eq '&') {
				my $mvar = $ast->[$idx+1];
				$expr_str.=$mvar.'(';
				$skip=1;
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
				push @expr_chunks,$mvar;
				$skip=1;				
			} elsif ($entry eq '@') {
				my $mvar = $ast->[$idx+1];				
				$expr_str.=$mvar.'(';
				$skip=1;
#			} elsif ($entry =~/^\W/) {
#				my $mvar = $ast->[$idx+1];				
#				$expr_str.=$mvar.'(';
#				$skip=1;				
			} elsif (
				$ast->[$idx-1]!~/^[\&\@\$]/
			) {
#				say "ENTRY:$entry SKIP: $skip";
				push @expr_chunks,$entry;
				$skip=0;
			}
		}				
	}
	if ($ast->[0] eq '&' or $ast->[0] eq '@') {
	$expr_str.=join(',',@expr_chunks);
	$expr_str.=')'; 
	} elsif ($ast->[0] ne '$' and $ast->[0] =~ /\W/) {
		my $t1 = (ref($ast->[1]) eq 'ARRAY') ? emit_expression( $ast->[1], '') : $ast->[1];
		my $t2 = (ref($ast->[2]) eq 'ARRAY') ? emit_expression( $ast->[2], '') : $ast->[2];
		$expr_str.=$t1.$ast->[0].$t2;
	} else {
		$expr_str.=join(';',@expr_chunks);
	}
	return $expr_str;	
	
}
1;
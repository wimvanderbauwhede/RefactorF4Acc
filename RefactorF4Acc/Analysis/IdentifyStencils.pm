
=info
Pass to determine stencils in map/reduce subroutines
Because of their nature we don't even need to analyse loops: the loop variables and bounds have already been determined.
So, for every line we check
If it is an assignment, a subroutine call or a condition in and If or Case, we go on
If assignment, we separate LHS and RHS
If subcall, we separate In/Out/InOut
If cond, it is a read expression

In each of these we get the AST and hunt for arrays. This is easy but would be easier if we had an 'everywhere' or 'everything' function

We have `get_args_vars_from_expression` and `get_vars_from_expression` and we can grep these for arrays

=cut

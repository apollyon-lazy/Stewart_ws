function [NX_intersect_X, is_empty] = i_newton_step(f,f_prime,X)
% [NX_intersect_X, is_empty] = i_newton_step(f,f_prime,X)
%  returns the result of a single step of the interval Newton
%  method for a single variable, as defined in (8.8) of
%  the text, using X as initial interval.  The string f should
%  be the name of an "m" file for evaluating the function,
%  while the string "f_prime" should be the name of an  "m"
%  file for evaluating the derivative of f.  The flag "is_empty"
%  is set to "0" if the intersection is non-empty, and is set
%  to "1" if the intersection is empty.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

midX = infsup(mid(X),mid(X));
NX = midX - feval(f,midX) / feval(f_prime,X);
NX_intersect_X = intersect(NX,X);
is_empty = isempty_(NX_intersect_X);

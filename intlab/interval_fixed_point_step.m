function new_X = interval_fixed_point_step(f,X)
% X_star = interval_fixed_point_step(f,X)
% returns the result of a step of interval
% fixed point iteration
% X_{k+1} = intersect(X_k, f(X_k))  as explained
% in section 6.3.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

new_X = intersect(X,feval(f,X));



function [X_limit,N] = interval_fixed_point_limit(f,X)
% [X_limit,N] = interval_fixed_point_convergence(f,X) returns
% the limit of fixed point iteration X_{k+1} = f(X_k) as
% explained in Section 6.3, and returns the number of iterations
% required in N.  If one or both of the bounds of X_limit is NaN,
% then the limit is the empty set.
old_X = infsup(-Inf,Inf);

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

N = 0;
while (old_X ~= X) & ~( isnan(inf(X)) | isnan(sup(X)) )
    N = N+1;
    old_X = X;
    X = interval_fixed_point_step(f,X);
end
X_limit = X;

function S_N = integral_sum(X,f,N)
% Y = S_N = integral_sum(X,f,N)
% computes the sum defined in (9.8) of the text.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

strfun = fcnchk(f);

% First form the N subintervals --
h = (midrad(sup(X),0)-midrad(inf(X),0))/midrad(N,0);
% h represents w(X_i) as in (9.7) of the text.
% The computations above and below should be done with intervals
% so roundoff error is taken into account.
xi = midrad(inf(X),0);
x1 = xi;
for i=1:N
    xip1 = x1 + i*h;
    Xs(i) = infsup(inf(xi),sup(xip1));
    xi = xip1;
end

% Now compute the sum --
S_N = feval(strfun,Xs(1));
if N > 1
    for i=2:N
        S_N = S_N + feval(strfun,Xs(i));
    end
end
S_N = S_N * h;

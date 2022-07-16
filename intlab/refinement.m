function Y = refinement(X,f,N)
% Y = refinement(X,f,N)
% computes a uniform refinement of the interval X with N
% subintervals, to compute an interval enclosure for
% the range of the interval function f (passed as a
% character string).  See Section 6.2 of "Introduction
% to Interval Analysis" by Moore, Cloud, and Kearfott.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

% First form the N subintervals --
h = (sup(X)-inf(X))/N;
xi=inf(X);
x1=xi;
for i=1:N
   % This is more accurate for large N than
   % xip1 = xi + h
    xip1 = x1 + i*h;
    Xs(i) =infsup(xi,xip1);
   % Do it this way so there are no "cracks" due
   % to roundoff error --
    xi=xip1;
end
% Redefine the upper bound to eliminate roundoff
% error problems --
Xs(N) = infsup(inf(Xs(N)),sup(X));

% Now compute the extension by computing the natural
% extensions over the subintervals and taking the union --
Y = feval(f,Xs(1));
if N>1
    for i=2:N
        Y = hull(Y,feval(f,Xs(i)));
    end
end

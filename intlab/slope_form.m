function Fs = slope_form(f,X,y)
% Fs = slope_form(f,X,y) returns the value for the
% slope form for f evaluated over the interval X,
% with center y, as explained in Section 6.4 and
% in the references. Note that, if X and y have more
% than one coordinate, they must be represented as
% row vectors.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.


Xs = slopeinit(y,X);
fy = feval(f,y);
S = feval(f,Xs);
Y = X-y;
Fs = fy + S.s * Y';

function Fmv = mean_value_form(f,X)
% Fmv = mean_value_form(f,X) returns the value for the
% mean value form for f evaluated over the interval X,
% as explained in Section 6.4. If X has more
% than one coordinate, it must be represented as a
% row vector.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

m = mid(X);
Xg = gradientinit(X);
fm = feval(f,m);
DFX = feval(f,Xg);
Xminusm = X-m;
Fmv = fm + DFX.dx * Xminusm';

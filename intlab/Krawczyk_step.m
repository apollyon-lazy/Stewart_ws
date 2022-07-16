function [KX] = Krawczyk_step(X,y,f)
% [KX] = Krawczyk_step(X,y,f) returns the image of X
% from a step of the Krawczyk method, with base point y, where
% the function is programmed in the function whose name is in
% the string f.  There is no need to program the Jacobian matrix,
% since the "gradient" automatic differentiation toolbox,
% distributed with INTLAB, is used.  It is the user's
% responsibility to ensure that X is an interval column vector,
% that y is a non-interval column vector contained in X, and
% that f is the desired function in an "m" file that returns
% a column vector.


% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

% First compute f(y) using interval arithmetic to bound
% roundoff error --
n=length(X);
iy = midrad(y,0);
fy = feval(f,iy);

% Now compute F'(X) and the preconditioning matrix Y --
Xg = gradientinit(X);
FXg = feval(f,Xg);

Y = inv(mid(FXg.dx));

% Finally, compute the actual Krawczyk step --
KX = y - Y*fy + (eye(n,n) - Y*FXg.dx) * (X - y);

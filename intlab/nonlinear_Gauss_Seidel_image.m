function [NX,error_occurred] = nonlinear_Gauss_Seidel_image(X,y,f)
% [NX,error_occurred] = nonlinear_Gauss_Seidel_image(X,y,f)
% returns the image of X from a single sweep of the nonlinear
% Gauss--Seidel method, with base point y, where
% the function is programmed in the function whose name is in
% the string f.  If error_occurred = 1, no image NX is returned;
% otherwise, error_occurred = 0 is returned.
% There is no need to program the Jacobian matrix,
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
n = length(X);
iy = midrad(y,0);
fy = feval(f,iy);

% Now compute F'(X) and the preconditioning matrix Y --
Xg = gradientinit(X);
FXg = feval(f,Xg);

% Compute the initial V --
V = X-y;
% Now, do the Gauss--Seidel sweep to find V --
[new_V,is_empty,error_occurred] = Gauss_Seidel_image(FXg.dx, -fy, V);

NX = y+new_V;

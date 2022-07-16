function [X] = finite_convergence_example()
% Implements the computations for the finite convergence
% example in Chapter 6 of Moore / Kearfott / Cloud

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

format long;
intvalinit('Display_');
X = infsup(1,2);
X_new = infsup(-Inf,Inf);
i=0;
while (X_new ~= X)
    i=i+1;
    X = intersect(X,X_new);
    X_new = 1+ X/3;
end
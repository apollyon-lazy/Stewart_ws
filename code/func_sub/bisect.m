function [X1,X2] = bisect(X)
% [X1,X2] = bisect(X) implements bisection of a box, as defined
% in Step 4 of Algorithm 6.1 in Moore / Kearfott / Cloud.
% X is the box to be bisected, while X1 and X2 are the results
% of the bisection.  It is assumed that X is a column vector,
% and the returned X1 and X2 are column vectors.
X1 = X;
X2 = X;
n = size(X,1);
max_rad = 0;
ind_max = 0;
for i=1:n
    r = rad(X(i));
    if (r > max_rad) 
        max_rad = r;
        ind_max = i;
    end
end
midpt = mid(X(ind_max));
X1(ind_max) = infsup(inf(X1(ind_max)),midpt);
X2(ind_max) = infsup(midpt,sup(X2(ind_max)));

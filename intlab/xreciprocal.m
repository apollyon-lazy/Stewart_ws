function [Y1,Y2,two] = xreciprocal(X)
%[Y1,Y2,two] = xreciprocal(X) returns the extended reciprocal
% of X defined by the three cases above Exercise 8.5 in the
% text.  The return value two is set to 0 if only one interval
% is returned, and is set to 1 if two intervals are returned.
% If X does not contain zero, the result of ordinary
% interval division is returned in Y1, and two is set to 0.
% In the case inf(X) = sup(X) = 0, avoided in the text,
% two is set to 1, and two empty intervals  are returned.
% (INTLAB represents an empty interval as infsup(NaN,NaN) )
% In cases where there is only one interval, Y2 is set
% to INTLAB's representation of the empty interval.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

if (inf(X) > 0) | (sup(X) < 0) % do ordinary interval division
    two=0;
    Y1 = 1/X;
    Y2 = infsup(NaN,NaN);
elseif (inf(X)==0) & (sup(X) > 0) % Case 1 of the text --
    two=0;
    lower_bound = infsup(1,1) / infsup(sup(X),sup(X));
    Y1 = infsup(inf(lower_bound),Inf);
    Y2 = infsup(NaN,NaN);
elseif (inf(X)<0) & (sup(X) > 0) % Case 2 of the text --
    two=1;
    upper_bound = infsup(1,1) / infsup(inf(X),inf(X));
    Y1=infsup(-Inf,sup(upper_bound));
    lower_bound = infsup(1,1) / infsup(sup(X),sup(X));
    Y2 = infsup(inf(lower_bound),Inf);
elseif (inf(X) < 0) & (sup(X) == 0) % Case 3 of the text --
    two = 0;
    upper_bound = infsup(1,1) / infsup(inf(X),inf(X));
    Y1=infsup(-Inf,sup(upper_bound));
    Y2 = infsup(NaN,NaN);
else % This is the case where X=0, not covered in the text --
    two =1;
    Y1 = infsup(NaN,NaN);
    Y2 = infsup(NaN,NaN);
end



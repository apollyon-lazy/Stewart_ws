function  I = interval_poly_integral(X,A)
% I = interval_poly_integral(X,A) returns the interval integral
% over the interval X of the polynomial with interval coefficients
% given by A(1) + A(2) x + ... + A(q+1) x^q, using the
% formulas given in Section 8.2 of the text by Moore, Kearfott,
% and Cloud.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

q = length(A)-1;
a = inf(X);
b = sup(X);
ia = midrad(a,0);
ib = midrad(b,0);
if ( (a >=0) & (b >=0) ) | ( (a <=0) & (b <=0) )
    I = midrad(0,0);
    for i=1:q+1;
        I = I + A(i)*(ib^i - ia^i)/midrad(i,0);
    end
else
    I = midrad(0,0);
    for i=1:q+1;
        if mod(i,2)
            T_i = A(i)*(ib^i-ia^i)/midrad(i,0);
        else
            lb = ( midrad(inf(A(i)),0) * ib^i...
                  -midrad(sup(A(i)),0) * ia^i )...
                  / midrad(i,0)
            ub = ( midrad(sup(A(i)),0) * ib^i ...
                  -midrad(inf(A(i)),0) * ia^i ) ...
                  / midrad(i,0)
            T_i = infsup(inf(lb),sup(ub));
        end
        I = I + T_i;
    end
end



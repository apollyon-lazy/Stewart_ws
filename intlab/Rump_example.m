function [Intf]= Rump_example(ndigits)
% This evaluates f for Example 1.2 (Rump's counterexample)
% ndigits is the number of digits precision to be used.
% The output Intf is an interval obtained using that many
% digits of precision.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

longinit('WithErrorTerm');
longprecision(ndigits);
a = long(77617.0);
b = long(33096.0);
b2 = b*b;
b4 = b2*b2;
b6 = b2*b4;
b8 = b4*b4;
a2=a*a;
f = long(333.75)* b6 + a2*(long(11)* a2*b2 - b6...
    - long(121)*b4 - 2) + long(5.5)*b8 + a/(long(2)* b);
Intf = long2intval(f);
end
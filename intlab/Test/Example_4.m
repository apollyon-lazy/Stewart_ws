%% INTLAB note: sqr sqrt
% sqr 是区间的平方 sqrt是区间的开方

clear;
clc;
x=infsup(-1,2);
z=infsup(-1,1);

y1=x+2;

y2=x*x;
y3=x/2;

y4=x^2;
y5=sqr(x);
y6=sqrt(x);
y7=sqrt(z);

display(y1);
display(y2);
display(y3);
display(y4);
display(y5);
display(y6);
display(y7);
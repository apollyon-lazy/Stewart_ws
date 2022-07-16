%% INTLAB note: > < >= <=
clear;
clc;
a=[1,2,3,4];
b=[4,3,2,1];
x=[infsup(0,2),infsup(2,4);infsup(0,4),infsup(1,3)];
y=[infsup(-2,-1),infsup(2,4);infsup(0,4),infsup(1,3)];
g=x>y;
% display(g);
% display(diam(x));
% display(diam(y));
% display(diam(x)>diam(y));
%% INTLAB note: ininteval
f=isintval(x);
display(f);
f=isintval(a);
display(f);
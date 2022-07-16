%% INTLAB note: inf sup in in0
% inf 提取区间的下界
% sup 提取区间的上界
% in(x,y) 当x在y中时返回1
% in0(x,y) 当x完全在y中时返回1
%% MATLAB note: intersect
clear;
clc;
x=infsup(2,4);
y1=infsup(0,3);
y2=infsup(2,3);
y3=infsup(2.1,3);
y4=infsup(0,2);
y5=infsup(0,1.9);

a=inf(x);
b=sup(x);
disp(a);
disp(b);

f1=in0(x,y1)
f2=in0(y1,x)
f3=in0(x,y2)
f42=in(y2,x)
f41=in0(y2,x)
f5=in0(y3,x)

g1=intersect(x,y1);
g2=intersect(x,y2);
g3=intersect(x,y3);
g4=intersect(x,y4);
g5=intersect(x,y5);

display(g1);
display(g2);
display(g3);
display(g4);
display(g5);


r1=isempty(g4);
r2=isempty(g5);
display(r1);
display(r2);
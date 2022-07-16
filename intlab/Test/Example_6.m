%% INTLAB code: isnan

clear;
clc;
x=infsup(2,4);
y1=infsup(0,3);
y2=infsup(2,3);
y3=infsup(2.1,3);
y4=infsup(0,2);
y5=infsup(0,1.9);

% g1=intersect(x,y1);
% g2=intersect(x,y2);
% g3=intersect(x,y3);
% g4=intersect(x,y4);
% g5=intersect(x,y5);

d1=[x,x,x,x,x];
d2=[y1,y2,y3,y4,y5];
d3=intersect(d1,d2);
d4=isnan(d3);
d5=in(d2,d1);

display(d3);
display(d4);
display(d5);

% r1=isnan(g4);
% r2=isnan(g5);
% display(r1);
% display(r2);
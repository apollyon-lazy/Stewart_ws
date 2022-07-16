%% INTLAB note: diam norm
% intval vector and matirx
% diam 求解区间向量或矩阵的宽度
% norm 默认求取区间矩阵的1范数

A = [ infsup(1800,2200) -infsup(900,1100)
     -infsup(900,1100)   infsup(1800,2200)];
display(A);
x = [infsup(2,4);infsup(-1,1)];
b = [midrad(10,0);midrad(-5,0)];
y1 = 2*x;
y2 = x.^2;
y3 = [x(1)^2,x(1) - x(2)^2];
y4 =norm(x);
y5 =norm(x,2);
display(y1);
display(y2);
display(y3);
disp(y4);
disp(y5);

val = A*x - b;
display(val);
d=diam(val);
display(d);
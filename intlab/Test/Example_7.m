%% INTLAB note: bisect
% bisect 只能够二分区间向量或矩阵的第一个元素
% rad 区间半径
% mid 区间中点
clear;
clc;
x = infsup(2,4);
y = [infsup(3,5),infsup(-1,1)];
z = [infsup(3,5);infsup(-1,1)];
[x1,x2]=bisect(x);
[y1,y2]=bisect(y);
[z1,z2]=bisect(z);
display(rad(x));
display(rad(y));
display(mid(x));
display(mid(y));
display(x1);
display(x2);
display(y1);
display(y2);
display(z1);
display(z2);

% 如果W本身是还未定义维度的空矩阵，赋值行列时就会报错 
% W=[
%     [infsup(-10,10),infsup(-20,0),infsup(100,120)]',...
%     [infsup(-10,10),infsup(-40,-20),infsup(100,120)]',...
%     [infsup(-10,10),infsup(-60,-40),infsup(100,120)]'...
%   ];

b=[infsup(-10,10),infsup(-80,-60),infsup(100,120)]';
W=[b];
display(W);
W(:,1)=[];
display(W);
W(:,end+1)=b;
W(:,end+1)=b;
display(W);

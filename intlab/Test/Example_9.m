%% INTLAB note:plot
clear;
clc;

% 三个立方框
x=[infsup(-2,2),infsup(3,4),infsup(7,8)]';
y=[infsup(-2,2),infsup(3,4),infsup(7,8)]';
z=[infsup(-2,2),infsup(3,4),infsup(7,8)]';

% 一个立方框
x=infsup(2,4);
y=infsup(0,3);
z=infsup(2,3);
for i=1:length(x)
    x1 = x(i).inf;  x2 = x(i).sup;
    y1 = y(i).inf;  y2 = y(i).sup;
    z1 = z(i).inf;  z2 = z(i).sup;

    % 8个顶点分别为：
    % 与(0,0,0)相邻的4个顶点
    % 与(a,b,c)相邻的4个顶点
    V = [x1 y1 z1;...
        x2 y1 z1;...
        x1 y2 z1;...
        x1 y1 z2;...
        x2 y2 z2;...
         x1 y2 z2;...
         x2 y1 z2;...
         x2 y2 z1];
    % 6个面
    % 以(x1,y1,x3)为顶点的三个面
    % 以(x2,y2,z2)为顶点的三个面
    F = [1,2,7,4;...
        1 3 6 4;...
        1 2 8 3;...
         5 8 3 6;...
         5 7 2 8;...
         5 6 4 7];

    patch('Faces',F,'Vertices',V,'FaceColor','none',...
          'LineWidth',1.5,'EdgeColor','red');
end
view(30,30);







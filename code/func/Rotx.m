function [Rx] = Rotx(thx)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
Rx = [1     0           0;
     0      cos(thx)    -sin(thx);
     0      sin(thx)    cos(thx)];
end


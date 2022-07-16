function [Rz] = Rotz(thz)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
Rz=[cos(thz)      -sin(thz)   0;
     sin(thz)       cos(thz)    0;
     0              0           1];
end


function [Rx] = Rotx(thx)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Rx = [1     0           0;
     0      cos(thx)    -sin(thx);
     0      sin(thx)    cos(thx)];
end


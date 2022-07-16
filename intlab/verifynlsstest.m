function [y] = verifynlsstest(x)
y = [x(1)^2 - x(2)^2 + 1,2*x(1)*x(2)];
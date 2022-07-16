%% Matlab三种拟合方法
% % 多项式拟合
% x1 = [0.4 0.6 1.0 1.5 2.0 3.0 4.0];
% y1 = [964.92 478.00 232.64 233.33 113.04 109.12 54.80 ];
% x2 = [0.4 0.6 1.0 1.5 2.0 3.0 4.0];
% y2 = [979.95 437.63 219.08 216.07  108.56 107.57 551.15 ];
% P= polyfit(x1, y1, 3)   %三阶多项式拟合
% xi=0:0.2:5;  
% yi= polyval(P, xi);  %求对应y值
% plot(xi,yi,x1,y1,'r*');

% 万能拟合函数拟合、cftool拟合
clear
clc   %清除工作空间
syms x;

%公共参数设置
xx=[0.4 0.6 1.0 1.5 2.0 3.0 4.0]';   %这里设置已知自变量向量(列向量)
yy = [964.92 478.00 232.64 233.33 113.04 109.12 54.80 ]';  %对应因变量(列向量)
startPos = [1,1,1];   %设置系数的起始搜索点
%使用fit函数拟合的
%设置参数
f = 'a*x^b+c';  %设置需要拟合的函数形式
funType=fittype(f,'independent','x',...
'coefficients',{'a','b','c'});  %在independent后面设置自变量,在coefficients后面设置待定系数（多个值用{}括起来）
%使用nlinfit函数进行拟合的
%设置参数
f1 = @(coef,x)coef(1)*x.^coef(2)+coef(3);  %设置需要拟合的函数(内联函数形式)

%后面的代码不用改
%fit拟合相关代码
% opt=fitoptions(funType);
% set(opt,'StartPoint',startPos);
% cfun=fit(xx,yy,funType,opt)   %命令行显示结果
% plot(cfun,'r',xx,yy,'*')
plot(xx,yy,'*')

%nlinfit拟合相关代码
coef=nlinfit(xx,yy,f1,startPos);
disp('nlinfit拟合后的系数矩阵为：');
disp(coef);

hold on;
xmax = max(xx);
xmin = min(xx);
xnum = 2*length(xx)+50;
x = linspace(xmin,xmax,xnum);
y = f1(coef,x);
plot(x,y,'b');

legend('原始数据','nlinfit拟合')

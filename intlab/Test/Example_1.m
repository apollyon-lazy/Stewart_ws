%% MATLAB note: echo,diary,format
% echo on % 命令行中会显示正在执行的代码
% diary off % 保存命令行中所有输入命令到一个txt文件
% format % 命令行显示数字时 short保留四位小数 long保留15位小数

%% INTLAB version bug
% 带有区间的语句不能用无分号结尾会报错

%% INTLAB note: infsup,intvalinit,'DisplayInfsup',hull,rigorinfsup
% infsup 创建一个上下界表示法的区间
% intvalinit 更改显示模式 'DisplayInfsup' 上下界显示法
% hull rigorinfsup

format short
intvalinit('DisplayInfsup');
g0 = infsup(1.32710e20,1.32715e20);     % m^3 / s^2
g1 = hull(intval('1.32710e20'),intval('1.32715e20'));  % m^3 / s^2
g2 = rigorinfsup('1.32710e20','1.32715e20');
g4 = infsup(-20,-10);
display(g0);
display(g1);
display(g2);
display(g4);

V0=infsup(2.929e4,3.029e4);           % m / s
M=infsup(2.066e11,2.493e11);           % m
E=infsup(1.470e11,1.521e11);           % m
display(2 *g0 * M);                    % m^4 / s^2
display(M+E);
C=M+E;
disp(C);
display(E * (M+E))
wide_result = 2*g0*M / (E*(M+E));       % m^2 / s^2
wide_V = sqrt(wide_result) - V0;      % m / s
narrow_V = sqrt(2*g0/(E*(1+E/M))) - V0; % m / s
format long
display(narrow_V);


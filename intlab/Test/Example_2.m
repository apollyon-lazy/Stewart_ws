%% INTLAB note: midrad 'DisplayMidrad' 'Display_'
% midrad 用中点表示法创建一个区间
% 'DisplayMidrad' 中点半径法显示区间
% 'Display_' 有效数字或不确定表示法 最后一位数字在一个单位内正确

Ohms = 100;
R = midrad(Ohms,0.1*Ohms);
display(R);s

intvalinit('DisplayMidrad')
thin = midrad(1,0);
display(thin);

intvalinit('Display_')
a1=infsup(1.11,1.12);
a2=infsup(1.1,1.5);
a3=infsup(1.11,1.13);
a4=infsup(1.1111111,1.1111112);
display(a1);
display(a2);
display(a3);
display(a4);

format long;
b1=infsup(1.11,1.12);
b2=infsup(1.11111,1.11113);
b3=infsup(2,4);
display(b1);
display(b2);
display(b3);

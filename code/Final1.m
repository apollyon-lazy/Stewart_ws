%% 绘制区间层叠图
clear;
clc;

folder = fileparts(which(mfilename));

Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*34/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm] Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

Init.x = [-60,60];
Init.y = [-60,60];
Init.z = [60,160];
Init.z_step = 20;
Init.orient = [0,0,0]';
Init.epsilon = [1.5,1.5,1.5]';

[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);

tic;
[W_b,W_in] = IAlayers(Init,Geometry,attach_P,attach_B,vec_dir);
toc;
T = toc;
figure;
plotlayer(W_b,'g',0.3);
plotlayer(W_in,'r',1);
% plotlayer(W_out,'b',0.3);

fprintf('Computation finished!\n');
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['T = ',num2str(T),'s'];
title(str1,'Color','blue');
savefig([folder,'\images\draw_ws.fig']);
% save([folder,'\Data.mat'],'T','pointm','folder','theta_step','z_step','theta','z','cnt_st');
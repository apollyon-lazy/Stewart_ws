%% 绘制极坐标边界图
clear;
clc;
tic;
folder = fileparts(which(mfilename));

Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*34/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm] Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

Init.rho = [0,100];                 %[mm] Search polar radius range
Init.z = [40,150];                  %[mm] Search height range
Init.theta_step = pi/64;            %[rad] Search polar angle step
Init.rho_step = 10;                 %[rad] Search polar radius step
Init.z_step = 1;                    %[mm] Search height step
Init.orient = [0,0,0]';             %[rad] constant-orientation     
Init.epsilon = 0.1;                 %[mm] Accuracy threshold

[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);
[point,cnt_st] = PSlayer(Init,Geometry,attach_P,attach_B,vec_dir);
[V] = DrawPS(Init,point,cnt_st);

toc;
T = toc;
fprintf('Computation finished!\n');
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['Volumn = ',num2str(V*1e-6),'m3'];
str2=['T = ',num2str(T),'s'];
title(str1,str2,'Color','blue');
savefig([folder,'\images\draw_ws.fig']);
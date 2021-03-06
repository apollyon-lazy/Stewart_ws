%% 绘制运动平台简图
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

[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);
DrawSGP(Geometry,attach_P,attach_B,vec_dir);
savefig([folder,'\images\draw_ws.fig']);

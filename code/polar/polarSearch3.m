clear;
clc;



%% Initial geometry parameters
Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*35/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm] Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

%% Initial process parameter
Init.orient = [0,0,0]';             %[rad] initial orientation 
Init.trans = [0,0,60]';             %[rad] initial position

Init.rho = [0,pi/3];                 %[mm] Search polar radius range
Init.rho_step = Init.rho(2)/10;     %[rad] Search polar radius step
Init.alpha_step = pi/64;            %[rad] Search polar angle step

Init.epsilon = Init.rho(2)/1000;    %[mm] Accuracy threshold

%% Main process 
tic;

% Calculate geometry parameter
[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);
% Calculate dof plane
% [point,cnt_st] = plane_xy(Init,Geometry,attach_P,attach_B,vec_dir);
% [point,cnt_st] = plane_xz(Init,Geometry,attach_P,attach_B,vec_dir);
% [point,cnt_st] = plane_yz(Init,Geometry,attach_P,attach_B,vec_dir);
% [point,cnt_st] = plane_thetaphi(Init,Geometry,attach_P,attach_B,vec_dir);
% [point,cnt_st] = plane_thetapsi(Init,Geometry,attach_P,attach_B,vec_dir);
[point,cnt_st] = plane_phipsi(Init,Geometry,attach_P,attach_B,vec_dir);
% [point,cnt_st] = plane_xtheta(Init,Geometry,attach_P,attach_B,vec_dir);

toc;T = toc;
fprintf('Calculation finished!\n');

%% Post-processing 
% draw_xy(Init,point,cnt_st);
temp = drawPlane(Init,point,cnt_st);
temp = rad2deg(temp);
scatter(temp(1,:),temp(2,:),'filled'); 
grid on;
xlabel('theta');ylabel('phi'); % 有改动
str1=['  T =',num2str(T),'s'];
title(str1,'Color','blue');
% savefig('.\fig\draw.fig');
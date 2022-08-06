clear;
clc;

tic;

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
Init.orient = [0,0,0]';             %[rad] constant-orientation 
Init.trans = [0,0,60]';             %[rad] constant-position 

Init.rho = [0,100];                 %[mm] Search polar radius range
% Init.h = [-pi/6,pi/6];            %[mm] Search height range

Init.alpha_step = pi/64;            %[rad] Search polar angle step
% Init.h_step = pi/128;             %[mm] Search height step
Init.rho_step = Init.rho(2)/10;     %[rad] Search polar radius step
Init.epsilon = Init.rho(2)/1000;    %[mm] Accuracy threshold

%% Main process 
% Calculate geometry parameter
[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);
% Calculate dof plane
[point,cnt_st] = polarPlanes(Init,Geometry,attach_P,attach_B,vec_dir);

toc;
T = toc;
fprintf('Calculation finished!\n');

%% Post-processing 
drawPlanes(Init,point,cnt_st);
grid on;
xlabel('X');ylabel('Y');
str1=['  T =',num2str(T),'s'];
title(str1,'Color','blue');
% savefig('.\fig\draw.fig');
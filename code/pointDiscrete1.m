clear;
clc;
tic;
folder = fileparts(which(mfilename));

Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*35/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm]Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

Init.x = [-60,60];
Init.y = [-60,60];
Init.z = [60,140];
Init.x_step = 4;
Init.y_step = 4;
Init.z_step = 20;
Init.orient = [0,0,0]';

[attach_P,attach_B,vec_dir] = Stewartparam(Geometry);
point = BSlayer(Init,Geometry,attach_P,attach_B,vec_dir);
scatter3(point(1,:),point(2,:),point(3,:),'filled'); 

toc;
T = toc;
fprintf('Computation finished!\n');
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['T = ',num2str(T),'s'];
title(str1,'Color','blue');
% savefig([folder,'\images\draw_ws.fig']);
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
% Init.trans = [0,0,60]';           %[rad] constant-position 

Init.h = [40,150];                  %[mm] Search height range
Init.rho = [0,100];                 %[mm] Search polar radius range

Init.alpha_step = pi/64;            %[rad] Search polar angle step
Init.h_step = 1;                    %[mm] Search height step
Init.rho_step = Init.rho(2)/10;     %[rad] Search polar radius step
Init.epsilon = Init.rho(2)/1000;    %[mm] Accuracy threshold

%% Main process 
% Calculate geometry parameter
Geometry = Stewartparams(Geometry);
% Calculate Constant-position workspace
[point,cnt_st] = polarConstOri(Init,Geometry);

toc;
T = toc;
fprintf('Calculation finished!\n');

%% Post-processing 
temp = calculate(Init,point);
% temp = rad2deg(temp);
scatter3(temp(1,:),temp(2,:),temp(3,:),'.'); 
[V] = Volumn(Init,point,cnt_st);
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['Volumn = ',num2str(V*1e-6)];
str2=['  T =',num2str(T),'s'];
title([str1,str2],'Color','blue');
% savefig('.\fig\draw.fig');
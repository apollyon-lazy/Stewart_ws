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

Init.mode = [4,6];

if sum(Init.mode>3)
    Init.rho = [0,pi/3];            %[mm] Search polar radius range
else
    Init.rho = [0,100]; 
end

Init.rho_step = Init.rho(2)/10;     %[rad] Search polar radius step
Init.alpha_step = pi/64;            %[rad] Search polar angle step

Init.epsilon = Init.rho(2)/1000;    %[mm] Accuracy threshold


% 修改 mode 变量 mode(1)代表横轴 mode(2)代表纵轴 1-6分别对应六个自由度
% 修改 rho 变量 位移自由度和角度自由度的搜索边界是不一样的

%% Main process 
tic;

% Calculate geometry parameter
Geometry = Stewartparams(Geometry);
% Calculate dof plane
[point,cnt_st] = polarPlane(Init,Geometry);

% toc; 
T = toc;
fprintf('Calculation finished!\n');

%% Post-processing 

alpha_step = Init.alpha_step;
alpha = alpha_step:alpha_step:2*pi;
n = 1;
temp = zeros(2,sum(sum(point~=0)));
for j = 1:size(point,2)
    for i = 1:size(point,1)
        if point(i,j) > 0
            temp(:,n) = [point(i,j)*cos(alpha(j)),point(i,j)*sin(alpha(j))]';
            n = n + 1;
        end
    end
end

if sum(Init.mode>3)
    temp = rad2deg(temp);
end

scatter(temp(1,:),temp(2,:),'filled'); 
grid on;
labels = {'x','y','z',"tehta",'phi','psi'};
xlabel(labels(Init.mode(1)));ylabel(labels(Init.mode(2))); 
str1=['  T =',num2str(T),'s'];
title(str1,'Color','blue');

% savefig('.\fig\draw.fig');
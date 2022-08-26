close all;
clear;
clc;

%% Initial geometry parameters
Geometry.alpha_P = 0.0625 * 2;         %[rad] the degree between the points of the platform
Geometry.alpha_B = 0.1828 * 2;         %[rad] the degree between the points of the base
Geometry.r_B = 1.65;                   %[mm] Radius of the circumcircle of the base
Geometry.r_P = 1.6;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height = [0,0,2.45]';   %[mm] the origin position of the center of platform

Geometry.length = [2.081,3.331];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

%% Initial process parameter
Init.orient = [0,0,0]';             %[rad] initial orientation 
Init.trans = Geometry.origin_height;             %[rad] initial position

Init.mode = [3,6];

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

%% Sub-function
function [point,cnt_st] = polarPlane(Init,Geom)

    orient = Init.orient;
    trans = Init.trans;
    mode = Init.mode;

    rho_max = Init.rho(2);
    rho_step = Init.rho_step;
    alpha_step = Init.alpha_step;
    
    epsilon = Init.epsilon;
    
    length_max = Geom.length(2);
    length_min = Geom.length(1);
    angle_P = Geom.angle_P(2);
    angle_B = Geom.angle_B(2);
    attach_P = Geom.attach_P;
    attach_B = Geom.attach_B;
    vec_dir = Geom.vec_dir;

%-------------------------------------
    alpha = alpha_step : alpha_step : 2*pi;
    a2=length(alpha);
    
    point = zeros(1,a2);
    [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,orient,attach_P,attach_B,vec_dir);
    cnt_st = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
    for j=1:a2
        drho = rho_step;
        rho = drho;
        cnt_last = cnt_st;
        num_rho = 1; % 每个方位边界点的个数
        
        while(rho <= rho_max)
            delt = zeros(1,6)';
            delt(mode(1)) = rho*cos(alpha(j));
            delt(mode(2)) = rho*sin(alpha(j));
            [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans+delt(1:3),orient+delt(4:6),attach_P,attach_B,vec_dir); 
            cnt = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);             
            if xor(cnt,cnt_last)  
                if (drho <= epsilon)
                    cnt_last = cnt;
                    drho = rho_step;
                    point(num_rho,j) = rho; % 每个方位的极坐标rho值 
                    num_rho = num_rho +1;
                    % fprintf('temp = [%f,%f,%f]\n',rho*cos(theta(j)),rho*sin(theta(j)),z(k));
                else
                    rho = rho - drho;
                    drho = 0.5 * drho;
                end
            end
            rho = rho + drho;

        end
    end

end

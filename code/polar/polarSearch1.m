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

%% Subs-function
function [point,cnt_st] = polarConstOri(Init,Geom)

    orient = Init.orient;
    % trans = Init.trans
    
    h_min = Init.h(1);
    h_max = Init.h(2);
    rho_max = Init.rho(2);
    h_step = Init.h_step;
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
    
%-----------------------------------------------    
    h = h_min : h_step : h_max;
    alpha = alpha_step : alpha_step : 2*pi;
    a3=length(h);
    a2=length(alpha);
    
    point = zeros(1,a2,a3);
    cnt_st = zeros(1,a3);
    for k=1:a3
        [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP([0,0,h(k)]',orient,attach_P,attach_B,vec_dir);
        cnt_st(k) = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
        for j=1:a2
            drho = rho_step;
            rho = drho;
            cnt_last = cnt_st(k);
            num_rho = 1; % 每一层每个方位边界点的个数
            
            while(rho <= rho_max)    
                trans = [rho*cos(alpha(j)),rho*sin(alpha(j)),h(k)]';
                [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,orient,attach_P,attach_B,vec_dir); 
                cnt = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);             
                if xor(cnt,cnt_last)  
                    if (drho <= epsilon)
                        cnt_last = cnt;
                        drho = rho_step;
                        point(num_rho,j,k) = rho; % 记录每一层每个方位的极坐标rho值 
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

end

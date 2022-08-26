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
Init.phi = [-pi/6,pi/6];
Init.theta = [-pi/6,pi/6];
Init.psi = [-pi/6,pi/6];
Init.theta_step = pi/81;
Init.phi_step = pi/81;
Init.psi_step = pi/81;

Init.trans = [0,0,60]';             %[rad] constant-orientation 
% Init.orient = [0,0,0]';           %[rad] constant-position 

%% Main process 
% Calculate geometry parameter
Geometry = Stewartparams(Geometry);
% Calculate Constant-position workspace
point = pointConstPos(Init,Geometry);

toc;
T = toc;
fprintf('Calculation finished!\n');

%% Post-processing 
pointd = rad2deg(point);
scatter3(pointd(1,:),pointd(2,:),pointd(3,:),'.'); 
grid on;
view(30,30);
xlabel('theta');ylabel('phi');zlabel('psi');
title(['T = ',num2str(T),'s'],'Color','blue');
% savefig('.\fig\draw.fig');

%% Sub-function
% Draw constant-position workspace
function [point] = pointConstPos(Init,Geom)
    
    theta_min = Init.theta(1);
    theta_max = Init.theta(2);
    phi_min = Init.phi(1);
    phi_max = Init.phi(2);
    psi_min = Init.psi(1);
    psi_max = Init.psi(2);

    phi_step = Init.phi_step;
    theta_step = Init.theta_step;
    psi_step = Init.psi_step;

    % orient = Init.orient;
    trans = Init.trans;

    length_max = Geom.length(2);
    length_min = Geom.length(1);
    angle_P = Geom.angle_P(2);
    angle_B = Geom.angle_B(2);
    attach_P = Geom.attach_P;
    attach_B = Geom.attach_B;
    vec_dir = Geom.vec_dir;
%------------------------------------------
    phi = phi_min : phi_step : phi_max;
    theta = theta_min : theta_step : theta_max;
    psi = psi_min : psi_step : psi_max;
    
    a1=length(theta);
    a2=length(phi);
    a3=length(psi);
    w_s=cell(a1,a2,a3);
    Occugrid=zeros(a1,a2,a3,"logical");
    point =zeros(3,1);

    for i=1:a1
        for j=1:a2
            for k=1:a3
                w_s{i,j,k}=[theta(i);phi(j);psi(k)];
            end  
        end
    end
   
    for k=1:a3              % psi
        for i=1:a1          % theta
            for j=1:a2      % phi
                orient=w_s{i,j,k};
                    [~,Arm_Length,Arm_angle_B,Arm_angle_P]=IK_SGP(trans,orient,attach_P,attach_B,vec_dir);
                    cnt=whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
                    if cnt>=1      
                        Occugrid(i,j,k)=1;
                    end
                fprintf('i=%dj=%dk=%d\n',i,j,k);
            end
        end
    end

    M=1;
    for i=1:size(Occugrid,1)
        for j=1:size(Occugrid,2)
            for k=1:size(Occugrid,3)
                if (Occugrid(i,j,k)==1)
                    point(:,M)=w_s{i,j,k};
                    M=M+1;
                end
            end
        end
    end
    
end
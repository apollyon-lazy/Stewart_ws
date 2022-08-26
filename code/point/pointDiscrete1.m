clear;
clc;

tic;
%% Initial geometry parameters
Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*35/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm]Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

%% Initial process parameter
Init.x = [-60,60];
Init.y = [-60,60];
Init.z = [60,140];
Init.x_step = 4;
Init.y_step = 4;
Init.z_step = 20;

% Init.trans = [0,0,60]';
Init.orient = [0,0,0]';

%% Main process 

% Calculate geometry parameter
Geometry = Stewartparams(Geometry);
% Calculate Constant-orientation workspace
point = pointConstOri(Init,Geometry);

toc;
T = toc;
fprintf('Calculation finished!\n');
%% Post-processing 

scatter3(point(1,:),point(2,:),point(3,:),'filled'); 
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['T = ',num2str(T),'s'];
title(str1,'Color','blue');
% savefig('.\fig\draw.fig');

%% Sub-function
% Draw constant-orientation workspace
function [point] = pointConstOri(Init,Geom)
    
    x_min = Init.x(1);
    x_max = Init.x(2);
    y_min = Init.y(1);
    y_max = Init.y(2);
    z_min = Init.z(1);
    z_max = Init.z(2);

    x_step = Init.x_step;
    y_step = Init.y_step;
    z_step = Init.z_step;

    orient = Init.orient;
    % trans = Init.trans;

    length_max = Geom.length(2);
    length_min = Geom.length(1);
    angle_P = Geom.angle_P(2);
    angle_B = Geom.angle_B(2);
    attach_P = Geom.attach_P;
    attach_B = Geom.attach_B;
    vec_dir = Geom.vec_dir;
%------------------------------------
    x = x_min : x_step : x_max;
    y = y_min : y_step : y_max;
    z = z_min : z_step : z_max;

    a1=length(x);
    a2=length(y);
    a3=length(z);
    w_s=cell(a1,a2,a3);
    Occugrid=zeros(a1,a2,a3,"logical");
    point =zeros(3,1);

    for i=1:a1
        for j=1:a2
            for k=1:a3
                w_s{i,j,k}=[x(i);y(j);z(k)];
            end  
        end
    end
   
    figure;
    for k=1:a3              % Z
        for i=1:a1          % X
            for j=1:a2      % Y
                trans=w_s{i,j,k};
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




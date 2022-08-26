close all;
clear;
clc;
tic;

%% Init geometry parameter
Geometry.alpha_P=pi*45/180;         %[rad] the degree between the points of the platform
Geometry.alpha_B=pi*34/180;         %[rad] the degree between the points of the base
Geometry.r_B=136;                   %[mm] Radius of the circumcircle of the base
Geometry.r_P=79;                    %[mm] Radius of the circumcircle of the platform
Geometry.origin_height=[0,0,60]';   %[mm] the origin position of the center of platform

Geometry.length = [80,160];         %[mm] length of the arm      
Geometry.angle_P = [0,pi/3];        %[rad] Max angle of the platform joint          
Geometry.angle_B = [0,pi/6];        %[rad] Max angle of the base joint

%% Init process parameter 
Init.x = [-80,80];
Init.y = [-80,80];
Init.z = [60,140];
Init.orient = [0,0,0]';
Init.epsilon = [4,4,4]';

%% main process 
Geometry = Stewartparams(Geometry);
[W_in,W_b]= IAspace(Init,Geometry);
toc;
T = toc;

%% Post-processing

% Volumn
V1 = 0;
V2 = 0;
for i=1:size(W_in,2)
    V1 = V1 + prod(diam(W_in(:,i)));
end
for i=1:size(W_b,2)
    V2 = V2 + prod(diam(W_b(:,i)));
end
V = V1 + 0.5*V2;  

% Draw
plotspace(W_in(1,:),W_in(2,:),W_in(3,:));
xlabel('x');ylabel('y');zlabel('z');
fprintf('Plot finished!\n');

% Setting
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['Volumn = ',num2str(V*1e-6),'m^{3}'];
str2=['T = ',num2str(T),' s'];
title(str1,str2,'Color','blue');

%% Sub-function
function [W_in,W_b] = IAspace(Init,Geom)
    
    x_min = Init.x(1);
    x_max = Init.x(2);
    y_min = Init.y(1);
    y_max = Init.y(2);
    z_min = Init.z(1);
    z_max = Init.z(2);
    orient = Init.orient;
    epsilon = Init.epsilon;
    
    attach_P = Geom.attach_P;
    attach_B = Geom.attach_B;
    vec_dir = Geom.vec_dir;

    length = infsup(Geom.length(1),Geom.length(2));
    angle_P = infsup(Geom.angle_P(1),Geom.angle_P(2));
    angle_B = infsup(Geom.angle_B(1),Geom.angle_B(2));

    length_6 = [length,length,length,length,length,length];
    angle_P6 = [angle_P,angle_P,angle_P,angle_P,angle_P,angle_P];
    angle_B6 = [angle_B,angle_B,angle_B,angle_B,angle_B,angle_B];

% -----------------------------------------------------------
    W=[infsup(x_min,x_max),infsup(y_min,y_max),infsup(z_min,z_max)]';
    W_in=W(:,1);
    % W_out=W(:,1);
    W_b=W(:,1);
    num = 1;
    while isempty(W) == 0
        bc(:,1)=W(:,1); 
        W(:,1)=[];
        
        [~,Arm_length,Arm_angle_B,Arm_angle_P]=IK_SGP(bc(:,1),orient,attach_P,attach_B,vec_dir);
        
        cnt1 = prod(in(Arm_length,length_6));  
        cnt2 = sum(isnan(intersect(Arm_length,length_6)));
        cnt3 = sum(diam(bc(:,1)) > epsilon(:,1));
    
        cnt4 = prod(in(Arm_angle_B,angle_B6));
        cnt5 = prod(in(Arm_angle_P,angle_P6));
        cnt6 = sum(isnan(intersect(Arm_angle_B,angle_B6)));
        cnt7 = sum(isnan(intersect(Arm_angle_P,angle_P6)));
        
        if cnt1*cnt4*cnt5                        
             W_in(:,end+1)=bc(:,1);     
        elseif cnt2 || cnt6 || cnt7    
             % W_out(:,end+1)=bc(:,1);
        elseif cnt3             
            [X1,X2]=bisect(bc(:,1));
            W(:,end+1)=X1;
            W(:,end+1)=X2;
            fprintf('num = %d\n',num);
            num = num +1;
        else
            W_b(:,end+1)=bc(:,1);
        end
    
    end
    W_in(:,1)=[];
    % W_out(:,1)=[];
    W_b(:,1)=[];

    hold on;
end

function plotspace(x,y,z)
% ------------------------
% Input: 
%   x,y,z   interval vector 
% -------------------------
    for i=1:length(x)
        x1 = x(i).inf;  x2 = x(i).sup;
        y1 = y(i).inf;  y2 = y(i).sup;
        z1 = z(i).inf;  z2 = z(i).sup;
    
        % 8个顶点分别为：
        % 与(0,0,0)相邻的4个顶点
        % 与(a,b,c)相邻的4个顶点
        V = [x1 y1 z1;...
            x2 y1 z1;...
            x1 y2 z1;...
            x1 y1 z2;...
            x2 y2 z2;...
             x1 y2 z2;...
             x2 y1 z2;...
             x2 y2 z1];
        % 6个面
        % 以(x1,y1,x3)为顶点的三个面
        % 以(x2,y2,z2)为顶点的三个面
        F = [1,2,7,4;...
            1 3 6 4;...
            1 2 8 3;...
             5 8 3 6;...
             5 7 2 8;...
             5 6 4 7];
    
        patch('Faces',F,'Vertices',V,'FaceColor','white',...
              'LineWidth',0.5,'EdgeColor','black');
    end
    view(30,30);
    grid on;
end
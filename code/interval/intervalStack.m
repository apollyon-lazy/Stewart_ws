close all;
clear;
clc;

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
Init.x = [-60,60];
Init.y = [-60,60];
Init.z = [60,160];
Init.z_step = 20;
Init.orient = [0,0,0]';
Init.epsilon = [1.5,1.5,1.5]';

%% main process
tic;
Geometry = Stewartparams(Geometry);
[W_b,W_in] = IAlayers(Init,Geometry);
T = toc;

%% Post-processing
% figure;
plotlayer(W_b,'g',0.3);
plotlayer(W_in,'r',1);
% plotlayer(W_out,'b',0.3);

fprintf('Computation finished!\n');
grid on;
view(30,30);
xlabel('x');ylabel('y');zlabel('z');
str1=['T = ',num2str(T),'s'];
title(str1,'Color','blue');
% savefig([folder,'\images\draw_ws.fig']);

%% Sub-function
% --------------------------------------
% Draw 
% Input:
%   Init(Struct): process parameter 
%   Geom(Struct): geometry parameter
% Output:
%   W_bs(3*n interval): interval boundary
%   W_ins(3*n interval): interval inside
% --------------------------------------
function [W_bs,W_ins] = IAlayers(Init,Geom)
    
    x_min = Init.x(1);
    x_max = Init.x(2);
    y_min = Init.y(1);
    y_max = Init.y(2);
    z_min = Init.z(1);
    z_max = Init.z(2);
    z_step = Init.z_step;
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

    
    W_ins = [];
    W_bs = [];
    for z = z_min:z_step:z_max
        fprintf('z = %f\n',z);
        W_in = [];  
        W_out = []; 
        W_b = [];
        W=[infsup(x_min,x_max),infsup(y_min,y_max),infsup(z,z)]';
        num = 0;  % 代表二分过程次数
        while isempty(W) == 0
            for i = 1:size(W,2)
                [~,Arm_length,Arm_angle_B,Arm_angle_P]=IK_SGP(W(:,i),orient,attach_P,attach_B,vec_dir);
                cnt1 = prod(in(Arm_length,length_6));  
                cnt2 = sum(isnan(intersect(Arm_length,length_6)));
                cnt4 = prod(in(Arm_angle_B,angle_B6));
                cnt5 = prod(in(Arm_angle_P,angle_P6));
                cnt6 = sum(isnan(intersect(Arm_angle_B,angle_B6)));
                cnt7 = sum(isnan(intersect(Arm_angle_P,angle_P6)));               
                if cnt1*cnt4*cnt5                        
                     W_in = [W_in,W(:,i)];     
                elseif cnt2 || cnt6 || cnt7    
                     W_out = [W_out,W(:,i)];
                else
                     W_b = [W_b,W(:,i)];
                end
            end
            W = [];
            for i = 1:size(W_b,2)
                if sum(diam(W_b(:,i)) > epsilon(:,1))
                    num = num + 1;
                    fprintf('num = %d\n',num);
                    for j = 1:size(W_b,2)
                        [X1,X2] = bisect(W_b(:,j));
                        W = [W,X1];
                        W = [W,X2];
                    end
                    W_b = [];
                    break;
                end
            end
        end
        W_ins = [W_ins,W_in];
        W_bs = [W_bs,W_b];

    end
end


function []=plotlayer(w,co,len)
    if nargin == 2
        co = 'k';
    end
    if nargin == 1
        co = 'k';
        len = '1';
    end
    for i=1:size(w,2)
        x = w(1,i);
        y = w(2,i);
        z = w(3,i);
        xx = [x.inf x.sup x.sup x.inf x.inf];
        yy = [y.inf y.inf y.sup y.sup y.inf];
        zz = [z.inf z.inf z.inf z.inf z.inf];
        plot3(xx,yy,zz,"Color",co,"LineWidth",len);
        hold on;
    end
end
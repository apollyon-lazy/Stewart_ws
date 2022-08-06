clear;
clc;
tic;
Stewartparam;
Occugrid=0;
b1=0;b2=0;b3=0;b4=0;b5=0;b6=0;b7=0;
z_min=length_min-origin_height(3);
z_max=length_max-origin_height(3);
x_min=-length_max;
x_max=length_max;
y_min=-length_max;
y_max=length_max;
m=(x_max-x_min)/10+1;
n=(y_max-y_min)/10+1;
l=(z_max-z_min)/10+1;
trans=[-100 ;100 ;0];
orient=[0 ,0, 0];
[Arm,Arm_Length,Arm_angle_B,Arm_angle_P]=Calculate(trans,orient,origin_height,attach_P,attach_B,vec_dir);
[distance] = caculate_distance(Arm,attach_B);
arm_max=max(max(Arm_Length));
arm_min=min(min(Arm_Length));
max_angle_P=max(max(Arm_angle_P));
min_angle_P=min(min(Arm_angle_P));
max_angle_B=max(max(Arm_angle_B));
min_angle_B=min(min(Arm_angle_B));
min_distance=min(min(distance));
% if (arm_max<=length_max)&&(arm_min>=length_min)&&(max_angle_P<=angle_P)...
%                     &&(min_angle_P>=-angle_P)&&(max_angle_B<=angle_B)&&(min_angle_B>=-angle_B)...
%                     &&(min_distance>=d_threhold)
%end
if (arm_max<=length_max)
    b1=1;
end
if (arm_min>=length_min)
    b2=1;
end
if (max_angle_P<=angle_P)
    b3=1;
end
if (min_angle_P>=-angle_P)
    b4=1;
end
if (max_angle_B<=angle_B)
    b5=1;
end
if (min_angle_B>=-angle_B)
    b6=1;
end
%                     &&(min_distance>=d_threhold)
b=b1*b2*b3*b4*b5*b6;
if b==1
Occugrid=1;
end
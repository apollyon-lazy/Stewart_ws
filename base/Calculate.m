function [Arm,Arm_Length,Arm_angle_B,Arm_angle_P] = Calculate(trans,orient,origin_height,attach_P,attach_B,vec_dir)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
R_BP=Rotz(orient(3))*Roty(orient(2))*Rotx(orient(1));
T_BP=trans+origin_height;
for i=1:6
    %Vector direction is Base to Platform
    Arm(:,i)=T_BP+R_BP*attach_P(:,i)-attach_B(:,i);
    Arm_Length(i)=norm(Arm(:,i));
    temp_1=R_BP*Arm(:,i)/norm(R_BP*Arm(:,i));
    temp_2=Arm(:,i)/ Arm_Length(i);
    Arm_angle_P(:,i)=acos(dot(temp_1,vec_dir(:,i))/norm(vec_dir(:,i)));
    Arm_angle_B(:,i)=acos(dot(temp_2,vec_dir(:,i))/norm(vec_dir(:,i)));
end


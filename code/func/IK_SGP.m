%% calculate the arm parameter 
function [Arm,Arm_length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,orient,attach_P,attach_B,vec_dir)
    % x y z分别对应俯仰 滚转 偏航
    % theta phi psi 分别对应俯仰 滚转 偏航
    R_BP=Rotz(orient(3))*Roty(orient(2))*Rotx(orient(1));
    T_BP=trans;
    norms=@(x)sqrt(x(1)^2+x(2)^2+x(3)^2);
    for i=1:6
        Arm(:,i)=T_BP+R_BP*attach_P(:,i)-attach_B(:,i);
        Arm_length(i)=norms(Arm(:,i));
        temp_1=R_BP*Arm(:,i)/norms(R_BP*Arm(:,i));
        temp_2=Arm(:,i)/ Arm_length(i);
        Arm_angle_P(:,i)=acoss(dot(temp_1,vec_dir(:,i))/norm(vec_dir(:,i)));
        Arm_angle_B(:,i)=acoss(dot(temp_2,vec_dir(:,i))/norm(vec_dir(:,i)));
    end
end


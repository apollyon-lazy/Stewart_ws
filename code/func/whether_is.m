%% determine whether the position belongs to workspace
function [cnt] = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B)
    cnt=0;
    arm_max=max(max(Arm_Length));
    arm_min=min(min(Arm_Length));
    max_angle_P=max(max(Arm_angle_P));
    min_angle_P=min(min(Arm_angle_P));
    max_angle_B=max(max(Arm_angle_B));
    min_angle_B=min(min(Arm_angle_B));
    %min_distance=min(min(distance));
    if (arm_max<=length_max)&&(arm_min>=length_min)&&(max_angle_P<=angle_P)...
        &&(min_angle_P>=-angle_P)&&(max_angle_B<=angle_B)&&(min_angle_B>=-angle_B)
    cnt=1;
    end
end


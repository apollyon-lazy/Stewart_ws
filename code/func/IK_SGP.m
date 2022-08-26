%% calculate the arm parameter 
function [Arm,Arm_length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,orient,attach_P,attach_B,vec_dir)
    % 机体坐标系
    % x(纵轴)横滚 phi(roll)
    % y(横轴)俯仰 theta(pitch)
    % z(立轴)偏航 psi(yaw)
    % 固定坐标系
    % x和y轴互换
    % 这里是固定坐标系下的 俯仰-横滚-偏航 欧拉角
    R_BP=Rotz(orient(3))*Roty(orient(2))*Rotx(orient(1));
    T_BP=trans;
    norms=@(x)sqrt(x(1)^2+x(2)^2+x(3)^2);
%     Arm = zeros(3,6);
%     Arm_length = zeros(1,6);
%     Arm_angle_B = zeros(1,6);
%     Arm_angle_P = zeros(1,6);
    for i=1:6
        Arm(:,i)=T_BP+R_BP*attach_P(:,i)-attach_B(:,i);
        Arm_length(i)=norms(Arm(:,i));
        temp_1=R_BP*Arm(:,i)/norms(R_BP*Arm(:,i));
        temp_2=Arm(:,i)/ Arm_length(i);
        Arm_angle_P(:,i)=acoss(dot(temp_1,vec_dir(:,i))/norm(vec_dir(:,i)));
        Arm_angle_B(:,i)=acoss(dot(temp_2,vec_dir(:,i))/norm(vec_dir(:,i)));
    end
end

function [Rx] = Rotx(thx)
Rx = [1     0           0;
     0      cos(thx)    -sin(thx);
     0      sin(thx)    cos(thx)];
end

function [Ry] = Roty(thy)
Ry=[cos(thy)      0   sin(thy);
     0              1          0;
     -sin(thy)      0   cos(thy)];
end

function [Rz] = Rotz(thz)
Rz=[cos(thz)      -sin(thz)   0;
     sin(thz)       cos(thz)    0;
     0              0           1];
end

function y = acoss(x)
    if isintval(x)
        a = acos(inf(x)); % 下界
        b = acos(sup(x)); % 上界
        if ~isreal(a)
            a = acos(-1);
        end
        if ~isreal(b)
            b = 0;
        end
    y = infsup(b,a);
    else
        y = acos(x);
    end
end



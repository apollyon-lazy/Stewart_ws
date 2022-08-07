function [point,cnt_st] = planePlane(Init,Geom)

    orient = Init.orient;
    trans = Init.trans;
    mode = Init.mode;

    rho_max = Init.rho(2);
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

%-------------------------------------
    alpha = alpha_step : alpha_step : 2*pi;
    a2=length(alpha);
    
    point = zeros(1,a2);
    [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,orient,attach_P,attach_B,vec_dir);
    cnt_st = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
    for j=1:a2
        drho = rho_step;
        rho = drho;
        cnt_last = cnt_st;
        num_rho = 1; % 每个方位边界点的个数
        
        while(rho <= rho_max)
            delt = zeros(1,6)';
            delt(mode(1)) = rho*cos(alpha(j));
            delt(mode(2)) = rho*sin(alpha(j));
            [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans+delt(1:3),orient+delt(4:6),attach_P,attach_B,vec_dir); 
            cnt = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);             
            if xor(cnt,cnt_last)  
                if (drho <= epsilon)
                    cnt_last = cnt;
                    drho = rho_step;
                    point(num_rho,j) = rho; % 每个方位的极坐标rho值 
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

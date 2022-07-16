function [point,cnt_st] = PSlayer(Init,Constr,attach_P,attach_B,vec_dir)
    z_min = Init.z(1);
    z_max = Init.z(2);
    rho_max = Init.rho(2);
    z_step = Init.z_step;
    rho_step = Init.rho_step;
    theta_step = Init.theta_step;
    orient = Init.orient;
    epsilon = Init.epsilon;

    length_max = Constr.length(2);
    length_min = Constr.length(1);
    angle_P = Constr.angle_P(2);
    angle_B = Constr.angle_B(2);

    z=z_min:z_step:z_max;
    theta = theta_step:theta_step:2*pi;
    a3=length(z);
    a2=length(theta);
    
    point = zeros(1,a2,a3);
    cnt_st = zeros(1,a3);
    for k=1:a3
        [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP([0,0,z(k)]',orient,attach_P,attach_B,vec_dir);
        cnt_st(k) = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
        for j=1:a2
            drho = rho_step;
            rho = drho;
            cnt_last = cnt_st(k);
            num_rho = 1; % 每一层每个方位边界点的个数
            
            while(rho <= rho_max)    
                trans = [rho*cos(theta(j)),rho*sin(theta(j)),z(k)]';
                [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,orient,attach_P,attach_B,vec_dir); 
                cnt = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);             
                if xor(cnt,cnt_last)  
                    if (drho <= epsilon)
                        cnt_last = cnt;
                        drho = rho_step;
                        point(num_rho,j,k) = rho; % 记录每一层每个方位的极坐标rho值 
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
end

function [point,cnt_st] = polarConstPos(Init,Geom)

    % orient = Init.orient;
    trans = Init.trans;

    h_min = Init.h(1);
    h_max = Init.h(2);
    rho_max = Init.rho(2);
    h_step = Init.h_step;
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
    
%----------------------------------------    
    h = h_min : h_step : h_max;
    alpha = alpha_step : alpha_step : 2*pi;
    a3=length(h);
    a2=length(alpha);
    
    point = zeros(1,a2,a3);
    cnt_st = zeros(1,a3);
    for k=1:a3
        [~,Arm_Length,Arm_angle_B,Arm_angle_P] = IK_SGP(trans,[0,0,h(k)]',attach_P,attach_B,vec_dir);
        cnt_st(k) = whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
        for j=1:a2
            drho = rho_step;
            rho = drho;
            cnt_last = cnt_st(k);
            num_rho = 1; % 每一层每个方位边界点的个数
            
            while(rho <= rho_max)    
                orient = [rho*cos(alpha(j)),rho*sin(alpha(j)),h(k)]';
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

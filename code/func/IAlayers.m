function [W_bs,W_ins] = IAlayers(Init,Constr,attach_P,attach_B,vec_dir)
    
    x_min = Init.x(1);
    x_max = Init.x(2);
    y_min = Init.y(1);
    y_max = Init.y(2);
    z_min = Init.z(1);
    z_max = Init.z(2);
    z_step = Init.z_step;
    orient = Init.orient;
    epsilon = Init.epsilon;

    length = infsup(Constr.length(1),Constr.length(2));
    angle_P = infsup(Constr.angle_P(1),Constr.angle_P(2));
    angle_B = infsup(Constr.angle_B(1),Constr.angle_B(2));

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

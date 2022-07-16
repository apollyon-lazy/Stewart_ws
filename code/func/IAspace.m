function [W_in,W_b] = IAspace(Init,Constr,attach_P,attach_B,vec_dir)
    
    x_min = Init.x(1);
    x_max = Init.x(2);
    y_min = Init.y(1);
    y_max = Init.y(2);
    z_min = Init.z(1);
    z_max = Init.z(2);
    orient = Init.orient;
    epsilon = Init.epsilon;

    length = infsup(Constr.length(1),Constr.length(2));
    angle_P = infsup(Constr.angle_P(1),Constr.angle_P(2));
    angle_B = infsup(Constr.angle_B(1),Constr.angle_B(2));

    length_6 = [length,length,length,length,length,length];
    angle_P6 = [angle_P,angle_P,angle_P,angle_P,angle_P,angle_P];
    angle_B6 = [angle_B,angle_B,angle_B,angle_B,angle_B,angle_B];

    W=[infsup(x_min,x_max),infsup(y_min,y_max),infsup(z_min,z_max)]';
    W_in=W(:,1);
    W_out=W(:,1);
    W_b=W(:,1);
    num = 1;
    while isempty(W) == 0
        bc(:,1)=W(:,1); 
        W(:,1)=[];
        
        [~,Arm_length,Arm_angle_B,Arm_angle_P]=IK_SGP(bc(:,1),orient,attach_P,attach_B,vec_dir);
        
        cnt1 = prod(in(Arm_length,length_6));  
        cnt2 = sum(isnan(intersect(Arm_length,length_6)));
        cnt3 = sum(diam(bc(:,1)) > epsilon(:,1));
    
        cnt4 = prod(in(Arm_angle_B,angle_B6));
        cnt5 = prod(in(Arm_angle_P,angle_P6));
        cnt6 = sum(isnan(intersect(Arm_angle_B,angle_B6)));
        cnt7 = sum(isnan(intersect(Arm_angle_P,angle_P6)));
        
        if cnt1*cnt4*cnt5                        
             W_in(:,end+1)=bc(:,1);     
        elseif cnt2 || cnt6 || cnt7    
             W_out(:,end+1)=bc(:,1);
        elseif cnt3             
            [X1,X2]=bisect(bc(:,1));
            W(:,end+1)=X1;
            W(:,end+1)=X2;
            fprintf('num = %d\n',num);
            num = num +1;
        else
            W_b(:,end+1)=bc(:,1);
        end
    
    end
    W_in(:,1)=[];
    W_out(:,1)=[];
    W_b(:,1)=[];

    hold on;
end
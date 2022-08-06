function [point] = pointConstOri(Init,Constr,attach_P,attach_B,vec_dir)
    
    x_min = Init.x(1);
    x_max = Init.x(2);
    y_min = Init.y(1);
    y_max = Init.y(2);
    z_min = Init.z(1);
    z_max = Init.z(2);
    x_step = Init.x_step;
    y_step = Init.y_step;
    z_step = Init.z_step;
    orient = Init.orient;

    length_max = Constr.length(2);
    length_min = Constr.length(1);
    angle_P = Constr.angle_P(2);
    angle_B = Constr.angle_B(2);

    x = x_min : x_step : x_max;
    y = y_min : y_step : y_max;
    z = z_min : z_step : z_max;
    a1=length(x);
    a2=length(y);
    a3=length(z);
    w_s=cell(a1,a2,a3);
    Occugrid=zeros(a1,a2,a3,"logical");
    point =zeros(3,1);
    for i=1:a1
        for j=1:a2
            for k=1:a3
                w_s{i,j,k}=[x(i);y(j);z(k)];
            end  
        end
    end
   

    figure;
    for k=1:a3              % Z
        for i=1:a1          % X
            for j=1:a2      % Y
                trans=w_s{i,j,k};
                    [~,Arm_Length,Arm_angle_B,Arm_angle_P]=IK_SGP(trans,orient,attach_P,attach_B,vec_dir);
                    cnt=whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
                    if cnt>=1      
                        Occugrid(i,j,k)=1;
                    end
                fprintf('i=%dj=%dk=%d\n',i,j,k);
            end
        end
    end

    M=1;
    for i=1:size(Occugrid,1)
        for j=1:size(Occugrid,2)
            for k=1:size(Occugrid,3)
                if (Occugrid(i,j,k)==1)
                    point(:,M)=w_s{i,j,k};
                    M=M+1;
                end
            end
        end
    end
    
end

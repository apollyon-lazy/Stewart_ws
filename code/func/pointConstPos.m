function [point] = pointConstPos(Init,Constr,attach_P,attach_B,vec_dir)
    
    theta_min = Init.theta(1);
    theta_max = Init.theta(2);
    phi_min = Init.phi(1);
    phi_max = Init.phi(2);
    psi_min = Init.psi(1);
    psi_max = Init.psi(2);

    phi_step = Init.phi_step;
    theta_step = Init.theta_step;
    psi_step = Init.psi_step;
    % orient = Init.orient;
    trans = Init.trans;

    length_max = Constr.length(2);
    length_min = Constr.length(1);
    angle_P = Constr.angle_P(2);
    angle_B = Constr.angle_B(2);

    phi = phi_min : phi_step : phi_max;
    theta = theta_min : theta_step : theta_max;
    psi = psi_min : psi_step : psi_max;
    
    a1=length(theta);
    a2=length(phi);
    a3=length(psi);
    w_s=cell(a1,a2,a3);
    Occugrid=zeros(a1,a2,a3,"logical");
    point =zeros(3,1);

    for i=1:a1
        for j=1:a2
            for k=1:a3
                w_s{i,j,k}=[theta(i);phi(j);psi(k)];
            end  
        end
    end
   


    for k=1:a3              % psi
        for i=1:a1          % theta
            for j=1:a2      % phi
                orient=w_s{i,j,k};
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

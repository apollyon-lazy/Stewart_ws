function [V] = DrawPS(Init,point,cnt_st)
    z_max = Init.z(2);
    z_min = Init.z(1);
    z_step = Init.z_step;
    theta_step = Init.theta_step;

    z = z_min:z_step:z_max;
    theta = theta_step:theta_step:2*pi;

    figure;
    temp=zeros(3,1);
    for k = 1:size(point,3)
        for j = 1:size(point,2)
            for i = 1:size(point,1)
                if point(i,j,k)>0
                    temp(:,end+1) = [point(i,j,k)*cos(theta(j)),point(i,j,k)*sin(theta(j)),z(k)]';
                end
            end
        end
    end
    temp(:,1)=[];
    scatter3(temp(1,:),temp(2,:),temp(3,:),'.'); 
    xlabel('x');ylabel('y');zlabel('z');
    
    V = 0;
    for k=1:size(point,3)
        if cnt_st(k) 
            for j=1:size(point,2)
                for i=1:2:size(point,1)
                    V = V + 0.5*theta_step*z_step*point(i,j,k)^2;
                end
                for i=2:2:size(point,1)
                    V = V - 0.5*theta_step*z_step*point(i,j,k)^2;
                end
            end
        else
            for j=1:size(point,2)
                for i=1:2:size(point,1)
                    V = V - 0.5*theta_step*z_step*point(i,j,k)^2;
                end
                for i=2:2:size(point,1)
                    V = V + 0.5*theta_step*z_step*point(i,j,k)^2;
                end
            end
        end
    end
    fprintf('Volumn = %f m3\n',V*1e-6);
end
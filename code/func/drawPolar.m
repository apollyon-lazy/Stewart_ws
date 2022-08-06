function [V] = drawPolar(Init,point,cnt_st)
    h_max = Init.h(2);
    h_min = Init.h(1);
    h_step = Init.h_step;
    alpha_step = Init.alpha_step;

    z = h_min:h_step:h_max;
    theta = alpha_step:alpha_step:2*pi;

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
    
    V = 0;
    for k=1:size(point,3)
        if cnt_st(k) 
            for j=1:size(point,2)
                for i=1:2:size(point,1)
                    V = V + 0.5*alpha_step*h_step*point(i,j,k)^2;
                end
                for i=2:2:size(point,1)
                    V = V - 0.5*alpha_step*h_step*point(i,j,k)^2;
                end
            end
        else
            for j=1:size(point,2)
                for i=1:2:size(point,1)
                    V = V - 0.5*alpha_step*h_step*point(i,j,k)^2;
                end
                for i=2:2:size(point,1)
                    V = V + 0.5*alpha_step*h_step*point(i,j,k)^2;
                end
            end
        end
    end
    % fprintf('Volumn = %f m3\n',V*1e-6);
end
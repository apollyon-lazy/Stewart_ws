function [temp] = calculate(Init,point)

    h_max = Init.h(2);
    h_min = Init.h(1);
    h_step = Init.h_step;
    alpha_step = Init.alpha_step;

%----------------------------------------   
    z = h_min:h_step:h_max;
    alpha = alpha_step:alpha_step:2*pi;

    n = 1;
    temp=zeros(3,sum(sum(sum(point~=0))));
    for k = 1:size(point,3)
        for j = 1:size(point,2)
            for i = 1:size(point,1)
                if point(i,j,k)>0
                    temp(:,n) = [point(i,j,k)*cos(alpha(j)),point(i,j,k)*sin(alpha(j)),z(k)]';
                    n = n + 1;
                end
            end
        end
    end

end
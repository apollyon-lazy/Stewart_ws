function [V] = drawPlanes(Init,point,cnt_st)

    alpha_step = Init.alpha_step;
    alpha = alpha_step:alpha_step:2*pi;

    n = 1;
    temp = zeros(2,sum(sum(point~=0)));
    for j = 1:size(point,2)
        for i = 1:size(point,1)
            if point(i,j) > 0
                temp(:,n) = [point(i,j)*cos(alpha(j)),point(i,j)*sin(alpha(j))]';
                n = n + 1;
            end
        end
    end
    temp(:,1)=[];

    scatter(temp(1,:),temp(2,:),'filled'); 
    
    % fprintf('Volumn = %f m3\n',V*1e-6);
end
function [V] = Volumn(Init,point,cnt_st)
    
    h_step = Init.h_step;
    alpha_step = Init.alpha_step;
    
%-------------------------------------------
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
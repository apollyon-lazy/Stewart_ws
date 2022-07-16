function [sum] = DrawIA(W_in,W_b)
    plotspace(W_in(1,:),W_in(2,:),W_in(3,:));
    xlabel('x');ylabel('y');zlabel('z');
    fprintf('Plot finished!\n');
    sum1 = 0;
    sum2 = 0;
    for i=1:size(W_in,2)
        sum1 = sum1 + prod(diam(W_in(:,i)));
    end
    for i=1:size(W_b,2)
        sum2 = sum2 + prod(diam(W_b(:,i)));
    end
    sum = sum1 + 0.5*sum2;  % [cm3] IA volumn calculation
end
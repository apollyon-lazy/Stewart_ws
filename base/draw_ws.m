figure;
M=1;
for i=1:m
    for j=1:n
        for k=1:l
            if (Occugrid(i,j,k)==1)
                temp=w_s{i,j,k};
                temp_x(M)=temp(1,:);
                temp_y(M)=temp(2,:);
                temp_z(M)=temp(3,:)+400;
                M=M+1;
            end
        end
    end
end
scatter3(temp_x,temp_y,temp_z,'filled'); 
xlim([-400 400]);
ylim([-400 400]);
zlim([200 600]);
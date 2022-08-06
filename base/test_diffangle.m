clear;
clc;
tic;
Stewartparam;
z_min=length_min-origin_height(3);
z_max=length_max-origin_height(3);
x_min=-length_max;
x_max=length_max;
y_min=-length_max;
y_max=length_max;
m=(x_max-x_min)/10+1;
n=(y_max-y_min)/10+1;
l=(z_max-z_min)/10+1;
w_s=cell(m,n,l);
orient=[pi/8,pi/8,pi/8];
for i=1:m
    for j=1:n
        for k=1:l
            w_s{i,j,k}=[x_min+10*(i-1);y_min+10*(j-1);z_min+10*(k-1)];
        end  
    end
end
Occugrid=zeros(size(w_s,1),size(w_s,2),size(w_s,3));
for k=1:size(w_s,3)
    for i=1:size(w_s,1)
        for j=1:size(w_s,2)
            trans=w_s{i,j,k};
            [Arm,Arm_Length,Arm_angle_B,Arm_angle_P]=Calculate(trans,orient,origin_height,attach_P,attach_B,vec_dir);
            [distance] = caculate_distance(Arm,attach_B);
            arm_max=max(max(Arm_Length));
            arm_min=min(min(Arm_Length));
            max_angle_P=max(max(Arm_angle_P));
            min_angle_P=min(min(Arm_angle_P));
            max_angle_B=max(max(Arm_angle_B));
            min_angle_B=min(min(Arm_angle_B));
            min_distance=min(min(distance));
            if (arm_max<=length_max)&&(arm_min>=length_min)&&(max_angle_P<=angle_P)...
                    &&(min_angle_P>=-angle_P)&&(max_angle_B<=angle_B)&&(min_angle_B>=-angle_B)...
                    %&&(min_distance>=d_threhold)
                Occugrid(i,j,k)=1;
            end
        end
    end
end
toc;



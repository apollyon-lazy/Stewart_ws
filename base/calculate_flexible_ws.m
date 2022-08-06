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
for i=1:m
    for j=1:n
        for k=1:l
            w_s{i,j,k}=[x_min+10*(i-1);y_min+10*(j-1);z_min+10*(k-1)];
        end  
    end
end
Occugrid=zeros(size(w_s,1),size(w_s,2),size(w_s,3));
angle_blanking=pi/8;
pitch_angle=[pitch_min:angle_blanking:pitch_max];
yaw_angle=[yaw_min:angle_blanking:yaw_max];
roll_angle=[roll_min:angle_blanking:roll_max];
angle_distri=cell(size(pitch_angle,2),size(yaw_angle,2),size(roll_angle,2));
for a1=1:size(pitch_angle,2)
    for a2=1:size(yaw_angle,2)
        for a3=1:size(roll_angle,2)
            angle_distri{a1,a2,a3}=[pitch_angle(a1);yaw_angle(a2);roll_angle(a3)];
        end
    end
end
sum_angle=size(pitch_angle,2)*size(yaw_angle,2)*size(roll_angle,2);
for k=1:size(w_s,3)
    for i=1:size(w_s,1)
        for j=1:size(w_s,2)
            trans=w_s{i,j,k};
            count=zeros(1,sum_angle);
            parfor num=1:sum_angle
                %orient=angle_distri(num);  
                orient=cell2mat(angle_distri(num));  
                [Arm,Arm_Length,Arm_angle_B,Arm_angle_P]=Calculate(trans,orient,origin_height,attach_P,attach_B,vec_dir);
            %[distance] = caculate_distance(Arm,attach_B);
                cnt=whether_is(Arm_Length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
                if cnt==1
                    count(num)=1;
                end
            end
            SUM_COUNT=sum(sum(count));
            if SUM_COUNT>=30
                Occugrid(i,j,k)=1;
            end
            fprintf('i=%d',i);
            fprintf('j=%d',j);
            fprintf('k=%d',k);
            fprintf('\n');
            %&&(min_distance>=d_threhold)
        end
    end
end

toc;



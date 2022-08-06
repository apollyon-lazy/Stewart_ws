function [distance] = caculate_distance(Arm,attach_B)
%carculate whether the arms will be disturbed each other
Attach_rP=Arm;
s=1;
for i=1:5
    k=i+1;
    for j=k:6
%         B_ix=attach_B(1,i);B_iy=attach_B(2,i);B_iz=attach_B(3,i);
%         Q_ix=Attach_rP(1,i);Q_iy=Attach_rP(2,i); Q_iz=Attach_rP(3,i);
%         B_jx=attach_B(1,j);B_jy=attach_B(2,j);B_jz=attach_B(3,j);
%         Q_jx=Attach_rP(1,j);Q_jy=Attach_rP(2,j); Q_jz=Attach_rP(3,j);
%         Q1=[B_jx-B_ix,B_jy-B_iy,B_jz-B_iz;...
%             Q_ix-B_ix,Q_iy-B_iy,Q_iz-B_iz;...
%             Q_jx-B_jx,Q_jy-B_jy,Q_jz-B_jz];
%         Q2=[Q_iy-B_iy , Q_iz-B_iz;...
%             Q_jy-B_jy , Q_jz-B_jz];
%         Q3=[Q_iz-B_iz,Q_ix-B_ix;...
%             Q_jz-B_jz,Q_jx-B_jx];
%         Q4=[Q_ix-B_ix,Q_iy-B_iy;...
%             Q_jx-B_jx,Q_jy-B_jy];
%         distance(s)=det(Q1)/(det(Q2)^2+det(Q3)^2+det(Q4)^2);
        MN=attach_B(:,j)-attach_B(:,i) ;
        s1=Attach_rP(:,j)/norm(Attach_rP(:,j));
        s2=Attach_rP(:,i)/norm(Attach_rP(:,i));
        c1=cross(s1,s2);
        distance(1,s)=abs(dot(c1, MN))/norm(c1);
        b_i=attach_B(:,i);p_i=Attach_rP(:,i)+attach_B(:,i);
        b_j=attach_B(:,j);p_j=Attach_rP(:,j)+attach_B(:,j);
        n_ij=c1/norm(c1);delta_i=p_i-b_i;delta_j=p_j-b_j;
        m_i=cross(n_ij,delta_j);m_j=cross(n_ij,delta_i);
        c_i=b_i+(p_i-b_i)*abs(dot(b_j-b_i,m)/dot(p_i-b_i,m));
        c_j=b_j+(p_j-b_j)*abs(dot(b_i-b_j,m)/dot(p_j-b_j,m));
        d_i=norm(cross((p_i-b_j),Attach_rP(:,j)))/norm(Attach_rP(:,j));
        d_j=norm(cross((p_j-b_i),Attach_rP(:,i)))/norm(Attach_rP(:,i));
        distance(2,s)=min(d_i,d_j);
        s=s+1;
    end
end

end


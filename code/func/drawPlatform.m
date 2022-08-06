function cnt = DrawSGP(G,attach_P,attach_B,vec_dir)
    
    figure;
    origin_height = G.origin_height;
    length_max = G.length(2);
    length_min = G.length(1);
    angle_P = G.angle_P(2);
    angle_B = G.angle_B(2);

    trans = zeros(3,1);     %[mm] The vector which describes the wanted translational movement of the platform [x, y, z]
    orient = zeros(3,1);    %[rad] the vector describe the Euler angle [ phi, theta, psi]
    trans = trans + origin_height;
    [Arm,Arm_length,Arm_angle_B,Arm_angle_P]=IK_SGP(trans,orient,attach_P,attach_B,vec_dir);
    cnt = whether_is(Arm_length,Arm_angle_P,Arm_angle_B,length_max,length_min,angle_P,angle_B);
    fill3(attach_B(1,:),attach_B(2,:),attach_B(3,:),'-');
    hold on;
    grid on;
    new_attachP=Arm+attach_B;
    fill3(new_attachP(1,:),new_attachP(2,:),new_attachP(3,:),'-g');
    rotate3d on;
    for i=1:6
        line([attach_B(1,i) new_attachP(1,i)],... 
             [attach_B(2,i) new_attachP(2,i)],...
             [attach_B(3,i) new_attachP(3,i)],...
             'Color','b','LineWidth',2);
    end
    
    str1=[ 'Trans = [', num2str(trans(1)), '  ', num2str(trans(2)), '  ', num2str(trans(3)), ']' ];

    str2=[ 'Orient = [', num2str(orient(1)), '  ', num2str(orient(2)), '  ', num2str(orient(3)), ']' ];

    str3=[ 'Arm\_length = [',...
            num2str(Arm_length(1)), '  ', num2str(Arm_length(2)), '  ',...
            num2str(Arm_length(3)), '  ',num2str(Arm_length(4)), '  ',...
            num2str(Arm_length(5)), '  ',num2str(Arm_length(6)), ']' ...
         ];
    str4=[ 'max\_angle\_B = ', num2str(max(Arm_angle_B)), '  ', num2str(angle_B) ]; 
    str5=[ 'max\_angle\_P = ', num2str(max(Arm_angle_P)), '  ', num2str(angle_P) ];
    title({[str1,str2];str3},{str4;str5},'Color','blue');
    text(0,0,origin_height(3),num2str(cnt),"FontSize",20);

end
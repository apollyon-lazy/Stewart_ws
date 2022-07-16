function []=plotlayer(w,co,len)
    if nargin == 2
        co = 'k';
    end
    if nargin == 1
        co = 'k';
        len = '1';
    end
    for i=1:size(w,2)
        x = w(1,i);
        y = w(2,i);
        z = w(3,i);
        xx = [x.inf x.sup x.sup x.inf x.inf];
        yy = [y.inf y.inf y.sup y.sup y.inf];
        zz = [z.inf z.inf z.inf z.inf z.inf];
        plot3(xx,yy,zz,"Color",co,"LineWidth",len);
        hold on;
    end
end
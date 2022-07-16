function plot_list(list,i1,i2,caption,colors)
% plot_list(list,i1,i2,colors) produces a two-dimensional plot
% in the two-dimensional subspace given by the indices
% i1 and i2.  If the boxes are one-dimensional, then
% i2 should equal zero.  If colors is not equal to 0, then plot_list
% plots the list boxes in red, green, and blue cyclically
% changing colors; otherwise, plot_list plots the boxes in black.

% Ralph Baker Kearfott, 2008/06/14 -- for the
% Moore / Kearfott /  Cloud book.

nboxes = 0;
i = list(1).next;
while(i)
    nboxes = nboxes + 1;
    if(~i2)
        xlower(nboxes) = inf(list(i).value(1));
        ylower(nboxes) = 0;
        xupper(nboxes) = sup(list(i).value(1));
        yupper(nboxes) = 0;
    else
        xlower(nboxes) = inf(list(i).value(i1));
        ylower(nboxes) = inf(list(i).value(i2));
        xupper(nboxes) = sup(list(i).value(i1));
        yupper(nboxes) = sup(list(i).value(i2));
    end
    i = list(i).next;
end

xlim('manual');
ylim('manual');
minx = min(xlower);
maxx = max(xupper);
miny = min(ylower);
maxy = max(yupper);
xlim([minx,maxx]);
if (~i2)
    ylim([-.01,.01]);
else
   ylim([miny,maxy]);
end
if colors
    c(1) = 'r';
    c(2) = 'g';
    c(3) = 'b';
else
    c(1) = 'k';
    c(2) = 'k';
    c(3) = 'k';
end
for i=1:nboxes
    ic = mod(i,3)+1;
    p1 = [xlower(i),ylower(i)];
    p2 = [xlower(i),yupper(i)];
    p3 = [xupper(i),yupper(i)];
    p4 = [xupper(i),ylower(i)];
    plotpts([p1;p2;p3;p4;p1],c(ic));
    hold on;
end
xlim([minx,maxx]);
if (~i2)
    ylim([-.01,.01]);
else
   ylim([miny,maxy]);
end
title(caption);
hold off;



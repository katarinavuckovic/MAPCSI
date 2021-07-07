function [img] = show_bus(img)
color = 'black';
linewidth = 1;
%bus 1
p1 = [275 235];
p2 = [335 235];
p3 = [335 225];
p4 = [275 225];
plot([p1(1),p2(1)],[p1(2),p2(2)],'Color',color,'LineWidth',linewidth);
plot([p1(1),p4(1)],[p1(2),p4(2)],'Color',color,'LineWidth',linewidth);
plot([p3(1),p2(1)],[p3(2),p2(2)],'Color',color,'LineWidth',linewidth);
plot([p3(1),p4(1)],[p3(2),p4(2)],'Color',color,'LineWidth',linewidth);
%bus 2
p1 = [430 235];
p2 = [490 235];
p3 = [490 225];
p4 = [430 225];
plot([p1(1),p2(1)],[p1(2),p2(2)],'Color',color,'LineWidth',linewidth);
plot([p1(1),p4(1)],[p1(2),p4(2)],'Color',color,'LineWidth',linewidth);
plot([p3(1),p2(1)],[p3(2),p2(2)],'Color',color,'LineWidth',linewidth);
plot([p3(1),p4(1)],[p3(2),p4(2)],'Color',color,'LineWidth',linewidth);

end


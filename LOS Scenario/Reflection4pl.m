function [img,lines,pline]=Reflection4pl(img, thetaD ,power,delay)
p = power;
pline = []; %power of everyline
de = delay;
lines=[];
%convering Theta to radians
theta = degtorad(thetaD);
%these angles do not have  reflection surface
cLOS = 'red'; %line of site color
c1R = 'blue'; % 1st reflection
c2R = 'yellow'; % 2nd reflection
noReflection = [8 9 10 157 158 159 160 170 171 0 180];
%Base station Location
x0 = 343;
y0 = 267;
plot(x0, y0, 'b*', 'LineWidth', 2, 'MarkerSize', 5);
t = strcat(num2str(x0),',',num2str(y0));
p1 = [y0,x0];
for i = 1: length (theta)
    t1 = strcat(num2str(thetaD(i)),', ', num2str(p(i),'%.2f'),', ',num2str(de(i),'%.2f'))
    if (ismember(thetaD(i), thetaD(1:(i-1)))==0)
        if(thetaD(i)<30)
            %Incident Wave
            d = 270;
            xi = x0-d;
            yi = y0-d*tan(theta(i));
            p2 = [yi,xi];
            plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',cLOS,'LineWidth',1);
            newline = [p1,p2];
            lines = [lines;newline];
            pline = [pline;p(i)];
            %reflected
            if ~ismember(thetaD(i), noReflection)
                xr = xi+abs(yi-177)/tan(theta(i));
                yr = 177;
                p3 = [yr, xr];
                plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
                newline = [p2,p3];
                lines = [lines;newline];
                pline = [pline;p(i)];
                %display angle
                t = strcat(num2str(thetaD(i)));
               % text(p2(2)-25,p2(1),t,'Color','r','FontSize',8);
                if ismember(thetaD(i),[12,13])
                    %2nd reflected wave
                    xr2 = xr+abs(yi-177)/tan(theta(i));
                    yr2 = yi;
                    p4 = [yr2, xr2];
                    plot([p3(2),p4(2)],[p3(1),p4(1)],'Color',c2R,'LineWidth',1);
                    newline = [p3,p4];
                    lines = [lines;newline];
                    pline = [pline;p(i)];
                end
                
            end
        elseif(thetaD(i)<=147)
            %Incident Wave
            d = 90;
            xi = x0-d./tan(theta(i));
            yi = y0-d;
            p2 = [yi,xi];
            plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',cLOS,'LineWidth',1);
            newline = [p1,p2];
            lines = [lines;newline];
            pline = [pline;p(i)];
            if ~ismember(thetaD(i), noReflection)
                %Reflected Wave
                xr = xi-d./tan(theta(i));
                yr = 275;
                p3 = [yr, xr];
                plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
                newline = [p2,p3];
                lines = [lines;newline];
                pline = [pline;p(i)];
                %display angle
                %2nd Reflected Wave
                if((thetaD(i)>44&&thetaD(i)<66)||(thetaD(i)>79&&thetaD(i)<106)||(thetaD(i)>118&&thetaD(i)<138))
                    %ranges for the angles are determined experimentally by trial and
                    %error and are specific the figure
                    d = 90;% determined experimentally and only valid for BW1.
                    xr2 = xr-d./tan(theta(i));
                    yr2 = yi; %determined experimentally
                    p4 = [yr2, xr2];
                    plot([p3(2),p4(2)],[p3(1),p4(1)],'Color',c2R,'LineWidth',1);
                    newline = [p3,p4];
                    lines = [lines;newline];
                    pline = [pline;p(i)];
                    %display angle
                end
            end
            t = strcat(num2str(thetaD(i)));
          %  text(p2(2),p2(1)-15,t,'Color','r','FontSize',8);
            
        else
            %Incident Wave
            theta(i) = 2*pi() - theta(i);
            d = 285;
            xi = x0+d;
            yi = y0-d*tan(theta(i));
            p2 = [yi,xi];
            plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',cLOS,'LineWidth',1);
            newline = [p1,p2];
            lines = [lines;newline];
            pline = [pline;p(i)];
            if ~ismember(thetaD(i), noReflection)
                xr = xi-abs(yi-177)/tan(theta(i));
                yr = 177;
                p3 = [yr, xr];
                plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
                newline = [p2,p3];
                lines = [lines;newline];
                pline = [pline;p(i)];
                %display angle
                t = strcat(num2str(thetaD(i)));
          %      text(p2(2)-15,p2(1),t,'Color','r','FontSize',8);
            end
            %display angle
            t = strcat(num2str(thetaD(i)));
         %   text(p2(2),p2(1),t,'Color','r','FontSize',8);
        end
    end
end
end


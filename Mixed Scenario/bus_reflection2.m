function [img,lines] = bus_reflection2(img,thetaD)
lines = [];
%base station position
x0 = 343;
y0 = 267;
p1 = [y0,x0];
%convering Theta to radians
theta = degtorad(thetaD);
c1R= 'b';
c2R = 'yellow';
for i = 1: length (theta)
    %Calculating Incident and Reflected points
    
    t1 = strcat(num2str(thetaD(i)));%
    %ploting the incident and reflected waves
    if (ismember(thetaD(i), thetaD(1:(i-1)))==0)
        if(thetaD(i)>=24 && thetaD(i)<=75)
            %Bottom Bus L
            %Incident Wave
            d = 32;
            xi = x0-d./tan(theta(i));
            yi = y0-d;
            %Reflected Wave
            d = 40;
            xr = xi-d./tan(theta(i));
            yr = yi+d;    
%             %incident wave
             p2 = [yi,xi];
            %reflected wave
            p3 = [yr, xr];
            plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
            newline = [p2,p3];
            lines = [lines;newline];
            %Reflected Wave (2nd reflection)
            if(thetaD(i)<=40 || thetaD(i)>=65)
                d  = 90;
                xr2= xr-d./tan(theta(i));
                yr2 = yr-d;
                p4 = [yr2, xr2];
                plot([p3(2),p4(2)],[p3(1),p4(1)],'Color',c2R,'LineWidth',1);
                newline = [p3,p4];
            lines = [lines;newline];
                %display angle
                t = strcat(num2str(thetaD(i)));
            end
        end
        if(thetaD(i)>=75 && thetaD(i)<=80)
            %R side Bus L
%             %Incident Wave
            d = 8;
            xi = x0-d;
            yi = y0-d*tan(theta(i));
            p2 = [yi,xi];
%             plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',ray_color,'LineWidth',1);
            %reflected wave
            xr = xi + abs(yi-177)/tan(theta(i));
            yr = 177;
            p3 = [yr, xr];
            plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
            newline = [p2,p3];
            lines = [lines;newline];
            % 2nd reflected wave
            xr2 = xr + abs(yi-177)/tan(theta(i));
            yr2 = yi;
            p4 = [yr2, xr2];
            plot([p3(2),p4(2)],[p3(1),p4(1)],'Color',c2R,'LineWidth',1);
            newline = [p3,p4];
            lines = [lines;newline];
            %display angle
            t = strcat(num2str(thetaD(i)));
            % text(p2(2)-25,p2(1),t,'Color','b','FontSize',8);
        end
        if(thetaD(i)>=154 && thetaD(i)<160)
            %L side bus R
%             %Incident Wave
            d = 87;
            xi = x0+d;
            yi = y0+d*tan(theta(i));
            p2 = [yi,xi];
%             plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','r','LineWidth',1);
            %Reflected Wave
            theta(i) = 2*pi() - theta(i);
            xr = xi - abs(yi-177)/tan(theta(i));
            yr = 177;
            p3 = [yr, xr];
            plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
            newline = [p2,p3];
            lines = [lines;newline];
            %2nd Reflected Wave
            xr2 = xr - abs(yi-177)/tan(theta(i));
            yr2 = yi;
            p4 = [yr2, xr2];
            plot([p3(2),p4(2)],[p3(1),p4(1)],'Color',c2R,'LineWidth',1);
            newline = [p3,p4];
            lines = [lines;newline];
            %display angle
            t = strcat(num2str(thetaD(i)));
            %      text(p2(2),p2(1),t,'Color','b','FontSize',8);
        end
        if(thetaD(i)>160 && thetaD(i)<168)
            %Bottom Bus R
            %Incident Wave
            d = 32;
            xi = x0-d./tan(theta(i));
            yi = y0-d;
            %Reflected Wave
            d = 40;
            xr = xi-d./tan(theta(i));
            yr = y0;
%             %incident wave
           p2 = [yi,xi];
%             plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',ray_color,'LineWidth',1);
            %reflected wave
            p3 = [yr, xr];
            plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
            newline = [p2,p3];
            lines = [lines;newline];
        end
        if((thetaD(i)>63 && thetaD(i)<90)||(thetaD(i)>124 && thetaD(i)<138))
            %Top L bus and Top R bus
            %Incident Wave
            d = 90;
            xi = x0-d./tan(theta(i));
            yi = y0-d;
            %Reflected Wave
            d=42;
            xr = xi-d./tan(theta(i));
            yr = y0-d;
            %2ns Reflected Wave
            xr2 = xr-d./tan(theta(i));
            yr2 = yr-d;
            %incident wave
            p2 = [yi,xi];
%             plot([p1(2),p2(2)],[p1(1),p2(1)],'Color',ray_color,'LineWidth',1);
            %reflected wave
            p3 = [yr, xr];
            plot([p2(2),p3(2)],[p2(1),p3(1)],'Color',c1R,'LineWidth',1);
            newline = [p2,p3];
            lines = [lines;newline];
            % 2nd reflection
            p4 = [yr2, xr2];
            plot([p3(2),p4(2)],[p3(1),p4(1)],'Color',c2R,'LineWidth',1);
            newline = [p3,p4];
            lines = [lines;newline];
            %display angle
            t = strcat(num2str(thetaD(i)));
            %    text(p2(2),p2(1),t,'Color','b','FontSize',8);
        end
        %
        %
    end
    
end
end


function [img,loc] = user_location(temp,img)
        %user location
        d = str2num(extractBefore(temp,'_'));
        p = str2num(extractAfter(temp,'_'));
        n = d/0.08979;
        % X coordinate
        x0 = 140;
        x = x0 + n*0.4;
        % Y cood
      
        switch p
            case 11
                y = 193;
            case 10.5
                y = 196;
            case 10
                y = 199;
            case 9.5
                y = 202;
            case 9
                y = 205;
            otherwise
                disp('error')
        end
        loc = [x,y];
      
     plot(x,y,'m+','MarkerSize',15, 'LineWidth', 2);

end


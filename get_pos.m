function [pos_x,pos_y,pos_z] = get_pos(x,y,intensity,imagesize)


halfsize = imagesize/2;

% x is the column number in the image

% y is the row number in the image

dis = sqrt((x - halfsize) * (x - halfsize) + (y - halfsize) * (y - halfsize));

if dis > halfsize
    pos_x = 0;
    pos_y = 0;
    pos_z = 0;
    return;
end

theta =  90 * (dis)/halfsize ;

% turn to rad
theta = theta * pi/180;

% if x~= halfsize
%     phi = atan((halfsize-y)/(x-halfsize));
% end
% 
% if x == halfsize && y < halfsize
%     phi = 90 * pi/180;
% end
% 
% if x == halfsize && y > halfsize
%     phi = 270 * pi/180;
% end
% 
% if x == halfsize && y == halfsize
%     phi = 0;
% end

phi = 0;

if (x - halfsize) ~= 0
        phi = abs(atan((halfsize - y)/(x - halfsize)) * 180/pi );
end

if x == halfsize
    if y<halfsize
        phi = 90;
    end
    
    if y>halfsize 
        phi = 270;
    end
end

if y > halfsize && x > halfsize
    phi = 360 - phi;
end

if y >= halfsize && x < halfsize
    phi = 180 + phi;
end

if y < halfsize && x < halfsize
    phi = 180 - phi;
end

phi = phi * pi/180;


pos_x = sin(theta) * cos(phi) * intensity;
pos_y = sin(theta) * sin(phi) * intensity;
pos_z = cos(theta) * intensity;

end
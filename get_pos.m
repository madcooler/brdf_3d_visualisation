function [pos_x,pos_y,pos_z] = get_pos(x,y,intensity,imagesize)


halfsize = imagesize/2;

% x is the column number in the image

% y is the row number in the image

dis = sqrt((x - halfsize) * (x - halfsize) + (y - halfsize) * (y - halfsize));

theta = 90 * (dis)/halfsize ;

% turn to rad
theta = theta * pi/180;

phi = atan((halfsize-y)/(x-halfsize));

pos_x = sin(theta) * cos(phi) * intensity;
pos_y = sin(theta) * sin(phi) * intensity;
pos_z = cos(theta) * intensity;

end
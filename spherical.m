function [vec] = spherical(theta,phi)

MATH_DEG_TO_RAD = 3.141592631/180;

p = phi   * MATH_DEG_TO_RAD;
t = theta * MATH_DEG_TO_RAD;

z = cos(t);
x = cos(p) * sin(t);
y = sin(p) * sin(t);

vec = [x,y,z];

end
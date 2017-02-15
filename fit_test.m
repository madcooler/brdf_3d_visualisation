function fit_test

% rng default
% x1 = linspace(0,3);
% y1 = 1.4*x1.^2 + 0.05*randn(size(x1));
% 
% sigma = 4;

re = lsqnonlin(@BRDF_diff,0.001);

rzlt = myfit(x1,y1,sigma)


function rzlt = myfit(a,y,sigma)


fun=@(b) b * a.^2 - y;


result = lsqnonlin(fun,sigma)



function F = fff(b)

rng default
x = linspace(0,3);
y = 1.4*x.^2 + 0.05*randn(size(x));

F = b * x.^2 - y;

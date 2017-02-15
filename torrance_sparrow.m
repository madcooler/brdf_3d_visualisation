function [brdf] = torrance_sparrow(in_vec,out_vec,roughness,eta,k)

MATH_DEG_TO_RAD = 3.141592631/180;


normal = [0,0,1];

half_vec = ( in_vec + out_vec )/2;

half_vec = half_vec / norm(half_vec);

%  dot(i,n)
cos_theta_i = dot(normal,in_vec);

%  dot(o,n)
cos_theta_o = dot(normal,out_vec);

theta_o = acos(cos_theta_o);

% mn is Dot(m,n) micro_normal and macro_normal
mn = dot(normal,half_vec);

theta_h = acos(mn);

theta_fresnel = acos(dot(in_vec,half_vec));

F = new_fresnel( 1 , 0, eta , k, theta_fresnel );

%  GGX normal distribution
D = roughness * roughness * sign(mn) / (pi * cos(theta_h)^4 * (roughness^2+ tan(theta_h)^2)^2 );

%  GGX shadowing function
G = sign((cos(theta_h) / cos_theta_o)) * 2 / ( 1 + sqrt(1 + roughness^2 * tan(theta_o)^2));



brdf = F * G * D / (4 * cos_theta_i * cos_theta_o);

end
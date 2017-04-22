function [brdf] = blinn_phong(in_vec,out_vec,ks,roughness)


MATH_DEG_TO_RAD = 3.141592631/180;


normal = [0,0,1];

half_vec = ( in_vec + out_vec )/2;

half_vec = half_vec / norm(half_vec);

% mn is Dot(m,n) micro_normal and macro_normal
mn = dot(normal,half_vec);


theta_fresnel = acos(dot(in_vec,half_vec));

F = new_fresnel( 1 , 0, 1.5 , 0, theta_fresnel );



%  dot(i,n)
cos_theta_i = dot(normal,in_vec);

%  dot(o,n)
cos_theta_o = dot(normal,out_vec);

theta_o = acos(cos_theta_o);
theta_h = acos(mn);
%  GGX shadowing function
G = sign((cos(theta_h) / cos_theta_o)) * 2 / ( 1 + sqrt(1 + roughness^2 * tan(theta_o)^2));




brdf = (1-G)* F * mn^(20/roughness);

end
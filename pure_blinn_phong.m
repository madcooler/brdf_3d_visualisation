function [brdf] = pure_blinn_phong(in_vec,out_vec,ks,alpha)


MATH_DEG_TO_RAD = 3.141592631/180;


normal = [0,0,1];

half_vec = ( in_vec + out_vec )/2;

half_vec = half_vec / norm(half_vec);

% mn is Dot(m,n) micro_normal and macro_normal
mn = dot(normal,half_vec);


brdf = ks * mn^(alpha);

end
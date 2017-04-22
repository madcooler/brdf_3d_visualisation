function [ x,y,z,albedo ] = extract_visualisation_hemi_data( file )
%VISUALISE_HEMI_DATA Summary of this function goes here
%   Detailed explanation goes here

%   3D plot of standard imp output xxx.hemi_data.txt

data = load(file);

out_x = data(:,1);
out_y = data(:,2);
out_z = data(:,3);

cos_brdf = data(:,7);

out_x = reshape(out_x,361,91);
out_y = reshape(out_y,361,91);
out_z = reshape(out_z,361,91);
cos_brdf = reshape(cos_brdf,361,91);

out_x = out_x';
out_y = out_y';
out_z = out_z';
cos_brdf = cos_brdf';
brdf = cos_brdf./out_z;

x = zeros(91,361);
y = zeros(91,361);
z = zeros(91,361);

albedo = 0;

MATH_DEG_TO_RAD = 0.01745329251994329576923690768488612713443;

rad2 = MATH_DEG_TO_RAD * MATH_DEG_TO_RAD;

for i = 1 : 91
    
    for j = 1 : 361
        
        sin_theta = sqrt( 1 - out_z(i,j) * out_z(i,j));
        
        % solid angle
        dw = rad2 * (sin_theta);
        
        x(i,j) = out_x(i,j) * brdf(i,j);
        y(i,j) = out_y(i,j) * brdf(i,j);
        z(i,j) = out_z(i,j) * brdf(i,j);
        
        if(j<361 && i < 91)
            albedo = albedo + cos_brdf(i,j) * dw;
        end
    end
end

% albedo
% mesh(x,y,z);

end


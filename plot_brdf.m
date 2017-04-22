function plot_brdf


theta = 0:90;
phi   = 0:360;


in_vec = spherical(60,180);

roughness = 0.15;

x = zeros(91,361);
y = zeros(91,361);
z = zeros(91,361);

for i = 1 : 91
    for j = 1 : 361
        
        reflection{i,j} = spherical(theta(i),phi(j));
        
%         brdf(i,j) = torrance_sparrow(in_vec,reflection{i,j},roughness, 1.5, 0 );
        
        brdf(i,j) = pure_blinn_phong(in_vec,reflection{i,j},0.000000632, 5.88 );
        
        x(i,j) = reflection{i,j}(1) * brdf(i,j);
        y(i,j) = reflection{i,j}(2) * brdf(i,j);
        z(i,j) = reflection{i,j}(3) * brdf(i,j);
         
    end
end

% export_as_alta_data('blinn_r30.alta',in_vec,reflection,brdf);

% visualise the brdf lobe
mesh(x,y,z);

% r = linspace(0,2*pi,361);
% s = linspace(0,pi/2,91);
% [u v] = meshgrid(r,s);
% x = v.*cos(u);
% y = v.*sin(u);
% z = zeros(91,361);
% 
% 
% origin=brdf;
% figure,surf(x,y,z,origin);
% h = surf(x,y,z,origin);
% set(h,'edgecolor','none') 
% h=title('Stokes Parameter S0');
% set(h,'Fontsize',20); 
% cb=colorbar;
% set(cb,'Fontsize',20); 
% temp1=caxis;
% view(2);


end
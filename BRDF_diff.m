function F = BRDF_diff(par)

% torrance sparrow model data

theta = 0:90;
phi   = 0:360;

in_vec = spherical(40,180);

roughness = 0.15;

x = zeros(91,361);
y = zeros(91,361);
z = zeros(91,361);

for i = 1 : 91
    for j = 1 : 361
        
        reflection{i,j} = spherical(theta(i),phi(j));
        
        brdf(i,j) = torrance_sparrow(in_vec,reflection{i,j},roughness, 1.5, 0 );
        
        x(i,j) = reflection{i,j}(1) * brdf(i,j);
        y(i,j) = reflection{i,j}(2) * brdf(i,j);
        z(i,j) = reflection{i,j}(3) * brdf(i,j);
         
    end
end



% eric multi scattering data
load('m_ia80_data.txt')

data=m_ia80_data;

totalPhoton = 100000000;
imagesize = 512;

theta = data(:,3);
phi   = data(:,4);

ti = data(:,5)/totalPhoton;

hemispherical_data = zeros(91,361);

for k = 1 : length(theta)
   index_x = uint16(theta(k)) +1;
   index_y = uint16(phi(k))   +1;
   
  
   if(index_y == 361)
%        index_y;
       index_y = index_y - 360;
   end
   
   hemispherical_data(index_x,index_y) = hemispherical_data(index_x,index_y) + ti (k);
end

hemispherical_data(:,361) = hemispherical_data(:,1);

xx = zeros(91,361);
yy = zeros(91,361);
zz = zeros(91,361);

for i = 1 : 91
    for j = 1 : 361
        
        reflection{i,j} = spherical(i-1,j-1);
        
%         xx(i,j) = reflection{i,j}(1) ;
%         yy(i,j) = reflection{i,j}(2) ;
%         zz(i,j) = reflection{i,j}(3) ;
        
        xx(i,j) = reflection{i,j}(1) * hemispherical_data(i,j);
        yy(i,j) = reflection{i,j}(2) * hemispherical_data(i,j);
        zz(i,j) = reflection{i,j}(3) * hemispherical_data(i,j);
         
    end
end




model = z;
data = zz;

fit_par = 5.788218960348925e-05;
par_x = x * fit_par ;
par_y = y * fit_par ;
parmodel = model * fit_par;

% xx = xx - 0.000005 ;

mesh(par_x,par_y,parmodel)
hold on;
mesh(xx,yy,data);

reshape(model,1,91*361);

reshape(data,1,91*361);

%  difference

F = par * model - data;

end
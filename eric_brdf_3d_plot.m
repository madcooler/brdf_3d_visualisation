function brdf_3d_plot

src='../die15_ggx/die1.5_r80/mul_scattering/';
totalPhoton = 1000000000;
%             1000000000
% % src='../die15/die1.5_r20/single_scattering/';
% % totalPhoton = 100000000;
% 
% src='../beckmann_test/die1.5_r50/single_scattering/';
% totalPhoton = 100000000;
% 
% src='../gold/gold_r80/mul_scattering/';
% totalPhoton = 1000000000;
% 
% src='../die/die1.5_r80/mul_scattering/';
% totalPhoton = 100000000000;
% % 
% % src='../energy_conservation_test/';
% % totalPhoton = 10000000;
% % 
% src='../die_test/';
% totalPhoton = 100000000;

file_str='m_ia80_data'

file=[src,file_str,'.txt']

data = load(file);

imagesize = 512;

% x and y pos in image

% x is the column num in the image
% y is the row num in the image

x = data(:,1);
y = data(:,2);

theta = data(:,3);
phi   = data(:,4);

% total intensity
ti = data(:,5)/totalPhoton;

theta_in_rad = theta * pi /180;

cos_theta = cos(theta_in_rad);

sin_theta = abs(sin(theta_in_rad));

total_intensity = ti ;

total_intensity = total_intensity( ~ isnan(total_intensity));

sum(total_intensity)

% turn cos weighted brdf into brdf value
brdf = ti./cos_theta;

% 
% [non_zero_pos]=find(ti~=0);
% energy=ti(ti~=0);
% 
% energy = zeros(length(non_zero_pos),1);
% th = zeros(length(non_zero_pos),1);
% ph = zeros(length(non_zero_pos),1);
% 
% for k = 1 : length(non_zero_pos)
%     th(k) = theta(non_zero_pos(k));
%     ph(k) = phi(non_zero_pos(k));
% end

% 
% hemispherical_data = zeros(181,721);
% 
% for k = 1 : length(theta)
%    index_x = uint16(theta(k)*2) +1;
%    index_y = uint16(phi(k)*2)   +1;
%    
%   
%    if(index_y == 721)
% %        index_y;
%        index_y = index_y - 720;
%    end
%    
%    hemispherical_data(index_x,index_y) = hemispherical_data(index_x,index_y) + ti (k);
% end
% 
% % hemispherical_data(:,721) = hemispherical_data(:,1);
% 
% xx = zeros(181,721);
% yy = zeros(181,721);
% zz = zeros(181,721);
% 
% for i = 1 : 181
%     for j = 1 : 721
%         
%         reflection{i,j} = spherical((i-1)/2,(j-1)/2);
%         
% %         xx(i,j) = reflection{i,j}(1) ;
% %         yy(i,j) = reflection{i,j}(2) ;
% %         zz(i,j) = reflection{i,j}(3) ;
%         
%         xx(i,j) = reflection{i,j}(1) * hemispherical_data(i,j);
%         yy(i,j) = reflection{i,j}(2) * hemispherical_data(i,j);
%         zz(i,j) = reflection{i,j}(3) * hemispherical_data(i,j);
%          
%     end
% end
% 
% figure;
% mesh(xx,yy,zz);

% f = fit( [x, y], ti, 'poly45');
%  plot(f);

%  plot(f, [x,y], ti)

% fitdata = f(x,y);

% how many y for each x pos
ysize = 1;
for ysize = 1:length(y);
    if(y(ysize)~= y(ysize+1))
        break;
    end
end

% x pos number
st = length(x)/ysize;

x = reshape(x,st,ysize);
y = reshape(y,st,ysize);
brdf = reshape(brdf,st,ysize);

% fitdata = reshape(fitdata,st,ysize); 

height = length(x(:,1));
width  = length(x(1,:));


for i = 1:width
    for j = 1: height
       [px(i,j),py(i,j),pz(i,j)] = get_pos(x(i,j),y(i,j),brdf(i,j),imagesize);
%        [spx(i,j),spy(i,j),spz(i,j)] = get_pos(x(i,j),y(i,j),fitdata(i,j),imagesize);
    end
end


% f2 = fit([px,py],pz,'poly34')
%  plot(f2);

figure;
plot(brdf(:,256));
cross_file=[src,file_str,'_cross_sec.png']
saveas(gcf,cross_file);


figure1 = figure;
% Create axes
axes1 = axes('Parent',figure1);
view(axes1,[-9.5 40]);
grid(axes1,'on');
hold(axes1,'on');

% Create mesh
mesh(px,py,pz,'Parent',axes1);
plot_file=[src,file_str,'_3d.png']
% saveas(gcf,plot_file);
% plot line

% slice = round(height/2)+5;
% 
% plot_Line(px(:,slice),pz(:,slice),ppx(:,slice),ppz(:,slice),line_plot,channel)
% 
% % saveas(gcf,line_plot);
% 
% diff=abs(pz(:,slice)-ppz(:,slice))./pz(:,slice)*100;
% diff_size=length(diff);
% for k=1:diff_size
%     if(diff(k)>20)
%         diff(k)=0;
%     end
% end
% figure1=figure
% plot(diff);
% saveas(gcf,diffmag);
% 
% step = 2;
% count = ceil(width/step);
% sx=zeros(1,count);
% spx=zeros(1,count);
% sz=zeros(1,count);
% spz=zeros(1,count);
% 
% for i = 1:width
%     index = ceil(i/step);
%     sx(1,index)= sx(1,index)+ px(i,slice)/step; 
%     spx(1,index)= spx(1,index)+ ppx(i,slice)/step; 
%     sz(1,index)  = sz(1,index) + pz(i,slice)/step;
%     spz(1,index) = spz(1,index)+ ppz(i,slice)/step;
% end



% diff=abs(sz-spz)./sz*100;
% diff_size=length(diff);
% for k=1:diff_size
%     if(diff(k)>20)
%         diff(k)=0;
%     end
% end
% figure3=figure
% plot(diff);
% saveas(gcf,diffmag);

 
%  plot_Line(sx(:),sz(:),spx(:),spz(:),scaled_line,channel)
% diff=abs(sz(:)-spz(:))./sz(:)*100;
% figure2=figure
% plot(diff);

% saveas(gcf,scaled_line);

% 3d plot
% hold on;

%createfigure2(px,py,pz,ppx,ppy,ppz,channel);

%set (gcf,'Position',[500,500,650,500], 'color','w');
%saveas(gcf,threeD_plot);
end
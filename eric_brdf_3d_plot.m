function brdf_3d_plot

% load('diff_mag_400.txt')
load('m_ia80_data.txt')
% diff_mag = diff_mag_400;
% load('BRDF_Data.txt')
data=m_ia80_data;

totalPhoton = 100000000;
imagesize = 512;

% x and y pos in image

% x is the column num in the image
% y is the row num in the image

x = data(:,1);
y = data(:,2);

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

subplot(121)
mesh(xx,yy,zz);

f = fit( [x, y], ti, 'poly45');
%  plot(f);

%  plot(f, [x,y], ti)

fitdata = f(x,y);

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
ti = reshape(ti,st,ysize);

fitdata = reshape(fitdata,st,ysize); 

height = length(x(:,1));
width  = length(x(1,:));


for i = 1:width
    for j = 1: height
       [px(i,j),py(i,j),pz(i,j)] = get_pos(x(i,j),y(i,j),ti(i,j),imagesize);
%        [spx(i,j),spy(i,j),spz(i,j)] = get_pos(x(i,j),y(i,j),fitdata(i,j),imagesize);
    end
end


% f2 = fit([px,py],pz,'poly34')
%  plot(f2);

subplot(122)
mesh(px,py,pz);
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
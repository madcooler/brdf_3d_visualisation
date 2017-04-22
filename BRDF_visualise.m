function BRDF_visualise(roughness,scattering)

roughness_str = int2str(roughness*100);

par_folder = ['../die15_ggx/die1.5_r',roughness_str,'/'];


folder = [par_folder,scattering,'/'];

all_scattering_folder = [par_folder,'all_scattering','/'];

in_angle = [0:10:80];

figure1 = figure('Color',[1 1 1]);

for i = 1: length(in_angle)
    
    file_name = [folder,'m_ia',int2str(in_angle(i)),'_hemi_data.txt'];
    
    all_scattering_file = [all_scattering_folder,'m_ia',int2str(in_angle(i)),'_hemi_data.txt'];
    
    [x,y,z,albedo] = extract_visualisation_hemi_data(file_name);
    
    [x1,y1,z1,albedo_all] = extract_visualisation_hemi_data(all_scattering_file);
    
    subplot_handle = subplot(3,3,i,'Parent',figure1);
    view(subplot_handle,[-5.5 42])
    grid(subplot_handle,'on');
    hold(subplot_handle,'on');
    
    mesh(x,y,z,'Parent',subplot_handle);

    str = sprintf('ia = %d, albedo %f, weight = %f%%',in_angle(i),albedo, 100 * albedo/albedo_all);
    title(str,'FontSize',15);

end

set (gcf,'Position',[200,200,1550,1400], 'color','w');
% 
% png_str = [folder,'compare_rough_',roughness_str,'_tangent_plane_',int2str(tangent_plane)];

snam='new_no_blank'; % note: NO extension...
s=hgexport('readstyle',snam);
s.Format = 'png'; %define your png format
% hgexport(gcf,png_str,s);
% 
str2 = '../die15_ggx/3d_visualisation/';

str2 = [str2,'die15_rough',roughness_str,'_',scattering];
hgexport(gcf,str2,s);

end
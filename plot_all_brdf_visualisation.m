function plot_all_brdf_vialusation

scattering_event ='mul_scattering';

% scattering(2) ='mul_scattering'

% scattering ='single_scattering'

roughness = [0.8:-0.1:0.1];

% roughness = [0.1:-0.1:0.1];
% tangent_plane = [0:10:0];

for i = 1: length(roughness)
    BRDF_visualise(roughness(i),scattering_event)
end
    

end
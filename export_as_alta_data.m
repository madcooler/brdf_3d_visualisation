function export_as_alta_data(str,in_vec,reflection,brdf)

file = fopen(str,'w');

fprintf(file,'#DIM 6 1\n');
fprintf(file,'#PARAM_IN  CARTESIAN\n');
fprintf(file,'#PARAM_OUT INV_STERADIAN\n');


width       = length(reflection(:,1));
height      = length(reflection(1,:));

for i = 1:width
    for j = 1: height
        
        fprintf(file,'%f %f %f %f %f %f %f ',reflection{i,j},in_vec);
        fprintf(file,'%.30f',brdf(i,j));
        fprintf(file,'\n');

    end
end
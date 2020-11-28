close all;
clear;

main_dir = '../';
load([main_dir 'GenerateExpData/DiLiGenTName.mat']);
method_label = {'LS96', 'LS40', 'IK12Paper', '96IRLS', 'IK14Paper', 'SH14Paper', 'GO10Paper', 'HA15', 'HU17'};
dir_ground = [main_dir 'data/DiLiGenT/ExpData/ExpData/'];
errors_map = zeros(18,11);
for method_id = 1:9
    method_name= method_label{method_id};
    dir1 = [main_dir 'data/DiLiGenT/results/' method_name '/'];
    dir2 = [main_dir 'TIP_real/temp' method_name '/'];
    disp(method_name);
    for obj_id = 6:6
        load([dir_ground num2str(obj_id) '.mat']);
        load([dir1 num2str(obj_id) '.mat']);
        errors_map(method_id*2-1, obj_id) = mean(real(acos(sum((N_est.*N),2)) * 180 / pi));
        load([dir2 num2str(obj_id) '.mat']);
        errors_map(method_id*2, obj_id) = mean(real(acos(sum((N_est.*N),2)) * 180 / pi));
    end
    errors_map(method_id*2-1, obj_id+1) = mean(errors_map(method_id*2-1, 1:obj_id));
    errors_map(method_id*2, obj_id+1) = mean(errors_map(method_id*2, 1:obj_id));
    disp(num2str(errors_map(method_id*2-1,:)));
    disp(num2str(errors_map(method_id*2,:)))
end


clear

load('./GenerateExpData/DiLiGenTName.mat');

inputdir_mask = './data/DiLiGenT/ExpData/ExpData/';
inputdir_est = '../DiLiGenT/estNormalNonLambert/';
inputdir_gt = '../DiLiGenT/pmsData/';

comparedMethod = 'CVPR14IKehata';

for i = 1:10
    dataname = DiLiGenTName{i};
    
    file1 = [inputdir_mask num2str(i) '.mat'];
    file2 = [inputdir_est dataname 'PNG_Normal_' comparedMethod '.mat'];
    file3 = [inputdir_gt dataname 'PNG/Normal_gt.mat'];
    
    load(file1);
    m = find(mask(:)==1);
    [h, w] = size(mask);
    load(file2);
    n_est = reshape(Normal_est, [h*w, 3]);
    n_est = n_est(m,:);
    load(file3);
    n_gt = reshape(Normal_gt, [h*w, 3]);
    n_gt = n_gt(m,:);
    
    
    disp(i)
    errorM = mean(real(acos(sum((n_est.*n_gt),2))) * 180/ pi)
    
end
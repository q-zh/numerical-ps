clear;close all; clc;
load DiLiGenTName.mat;
inputDir1='../data/DiLiGenT/ExpData/ExpData';
inputDir2='../data/DiLiGenT/DiLiGenT/estNormalNonLambert';
outputDir='../data/DiLiGenT/results';

for j=1:9
    switch j
        case 1
            methodName='ACCV10Wu';
            outputDirF=[outputDir '/WU10Paper'];
        case 2
            methodName='CVPR08Alldrin';
            outputDirF=[outputDir '/AL08Paper'];
        case 3
            methodName='CVPR10Higo';
            outputDirF=[outputDir '/HI10Paper'];
        case 4
            methodName='CVPR12Ikehata';
            outputDirF=[outputDir '/IK12Paper'];
        case 5
            methodName='CVPR12Shi';
            outputDirF=[outputDir '/SH14Paper'];
        case 6
            methodName='CVPR14Ikehata';
            outputDirF=[outputDir '/IK14Paper'];
        case 7
            methodName='ECCV12Shi';
            outputDirF=[outputDir '/SH12Paper'];
        case 8
            methodName='ICCV05Goldman';
            outputDirF=[outputDir '/GO10Paper'];
        case 9
            methodName='l2';
            outputDirF=[outputDir '/LSPaper'];
    end
    mkdir(outputDirF);
    
    for i=1:10
        Normal_est=[];
        Normal_L2=[];
        nameFile=[DiLiGenTName{i,1} 'PNG_Normal_' methodName '.mat'];
        load([inputDir1 '/' num2str(i) '.mat']);
        load([inputDir2 '/' nameFile]);
        if j==9
            Normal_est=Normal_L2;
        end
        N_est=reshape(Normal_est,[size(mask,1)*size(mask,2), 3]);
        N_est=N_est(find(mask==1),:);
        save([outputDirF '/' num2str(i) '.mat'], 'N_est');
    end
    disp(num2str(j));
end
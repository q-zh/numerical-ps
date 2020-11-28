para.method=5;


para.iter_num=10;
para.data_num=10;
para.iter_num_r=1;
mainDir = '../data/DiLiGenT';
inputDir1=[mainDir '/ExpData/ExpData'];
para.threshold=10;
inputDir2=[mainDir '/Profile/Profile96'];
if para.method==2 || para.method==3 || para.method==6 || para.method==7 || para.method==8 || para.method==9
    inputDir2=[mainDir '/Profile/ProfileShi40'];
end

switch para.method
    case 1
        para.method_label='LS96';%%%
        para.threshold=100;
    case 2
        para.method_label='SH14Paper';
    case 3
        para.method_label='IK14Paper';
    case 4
        para.method_label='96IRLS';
        para.threshold=100;
    case 5
        para.method_label='IK12Paper';
        para.threshold=100;
    case 6
        para.method_label='LS40';
    case 7
        para.method_label='HA15';
    case 8
        para.method_label='HU17';
    case 9
        para.method_label='GO10Paper';
end
    
inputDir3=[mainDir '/results/' para.method_label];
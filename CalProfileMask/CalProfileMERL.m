clear;close all;clc;
Tlow=25;
para.isNoise=0;
para.miu=10;
para.lambda=5;
shadowTH=1e-6;%1e-6
minPixelNum=10;
epsilon=1e-10;
IsSameAsShi=0;


inputDir='../data/MERL/ExpData/ExpDataMixed';
outputDir=['../data/MERL/Profile/ProfileMixed' num2str(Tlow)];
if para.isNoise==1
    inputDir=[inputDir '_' num2str(para.miu) '_' num2str(para.lambda)];
    outputDir=[outputDir '_' num2str(para.miu) '_' num2str(para.lambda)];
end
mkdir(outputDir);

tic
for i=1:100
    id=i;
    load([inputDir '/' num2str(i) '.mat']);
    pixelNum=size(I,2);
    profilePixelNum=Tlow;
    PM=M;
    for j=1:size(I,1)
        validPixelNum=sum(M(j,:));
        if validPixelNum<=profilePixelNum
            PM(j,:)=(M(j,:)>0.5);
        else
            profileI=I(j,:);
            profileI(find(M(j,:)==0))=999;
            [tProfileI, tIndex]=sort(profileI,'ascend');
            PM(j,:)=(1<0);
            PM(j,tIndex(1:profilePixelNum))=1>0;
        end
    end
    %PM=I>shadowTH;
    PM=logical(PM);
    save([outputDir '/' num2str(i) '.mat'], 'PM');
    disp(num2str(i));
end

toc
clear;close all;clc;
Tlow=40;

Thigh=60;
para.isNoise=0;
para.miu=10;
para.lambda=5;
shadowTH=1e-6;%1e-6
minPixelNum=10;
epsilon=1e-10;
IsSameAsShi=0;


inputDir='../data/MERL/ExpData/ExpData';
outputDir=['../data/MERL/Profile/Profile' num2str(Tlow) '_' num2str(Thigh)];
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
    PM1=M;
    for j=1:size(I,1)
        validPixelNum=sum(M(j,:));
        if validPixelNum<=profilePixelNum
            PM1(j,:)=(M(j,:)>0.5);
        else
            profileI=I(j,:);
            profileI(find(M(j,:)==0))=999;
            [tProfileI, tIndex]=sort(profileI,'ascend');
            PM1(j,:)=(1<0);
            PM1(j,tIndex(1:profilePixelNum))=1>0;
        end
    end
    %PM=I>shadowTH;
    
    profilePixelNum=Thigh;
    PM2=M;
    for j=1:size(I,1)
        validPixelNum=sum(M(j,:));
        if validPixelNum<=profilePixelNum
            PM2(j,:)=(M(j,:)>0.5);
        else
            profileI=I(j,:);
            profileI(find(M(j,:)==0))=999;
            [tProfileI, tIndex]=sort(profileI,'ascend');
            PM2(j,:)=(1<0);
            PM2(j,tIndex(1:profilePixelNum))=1>0;
        end
    end
    
    PM=PM2-PM1;
    for j=1:size(PM,1)
        if sum(PM(j,:))<minPixelNum
            PM(j,:)=PM2(j,:);
        end
    end
    
    
    PM=logical(PM);
    save([outputDir '/' num2str(i) '.mat'], 'PM');
    disp(num2str(i));
    
    
    
end

toc
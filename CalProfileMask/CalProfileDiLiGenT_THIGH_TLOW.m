clear;close all;
Tlow=40;
Thigh=60;
minPixelNum=10;
epsilon=1e-10;
IsSameAsShi=0;

inputDir='../data/DiLiGenT/ExpData/ExpData';
outputDir='../data/DiLiGenT/Profile/Profile';
if IsSameAsShi==1
    outputDir=[outputDir 'Shi'];
end
outputDir=[outputDir num2str(Tlow) '_' num2str(Thigh)];
mkdir(outputDir);


for i=1:10
    id=i;
    load([inputDir '/' num2str(i) '.mat']);
    
    if Tlow==96
        PM1=(I>-999);
    else
        pixelNum=size(I,2);
        profilePixelNum=Tlow;
        M=I>shadowTH;
        PM1=M;
        for j=1:size(I,1)
            validPixelNum=sum(M(j,:));
            if IsSameAsShi==1
                if validPixelNum<minPixelNum
                    profileI=I(j,:);
                    [tProfileI, tIndex]=sort(profileI,'ascend');
                    PM1(j,:)=1<0;
                    PM1(j,tIndex(1:minPixelNum-1))=1>0;
                    profileI(profileI<epsilon)=epsilon;
                    I(j,:)=profileI;
                elseif validPixelNum<=profilePixelNum
                    PM1(j,:)=(M(j,:)==1);
                else
                    profileI=I(j,:);
                    profileI(find(M(j,:)==0))=999;
                    [tProfileI, tIndex]=sort(profileI,'ascend');
                    PM1(j,:)=(1<0);
                    PM1(j,tIndex(1:profilePixelNum))=1>0;
                end
                
            else
                if validPixelNum<minPixelNum
                    profileI=I(j,:);
                    [tProfileI, tIndex]=sort(profileI,'descend');
                    PM1(j,:)=1<0;
                    PM1(j,tIndex(1:minPixelNum))=1>0;
                elseif validPixelNum<=profilePixelNum
                    PM1(j,:)=(M(j,:)==1);
                else
                    profileI=I(j,:);
                    profileI(find(M(j,:)==0))=999;
                    [tProfileI, tIndex]=sort(profileI,'ascend');
                    PM1(j,:)=(1<0);
                    PM1(j,tIndex(1:profilePixelNum))=1>0;
                end
            end
        end
    end
    
    
    if Thigh==96
        PM2=(I>-999);
    else
        pixelNum=size(I,2);
        profilePixelNum=Thigh;
        M=I>shadowTH;
        PM2=M;
        for j=1:size(I,1)
            validPixelNum=sum(M(j,:));
            if IsSameAsShi==1
                if validPixelNum<minPixelNum
                    profileI=I(j,:);
                    [tProfileI, tIndex]=sort(profileI,'ascend');
                    PM2(j,:)=1<0;
                    PM2(j,tIndex(1:minPixelNum-1))=1>0;
                    profileI(profileI<epsilon)=epsilon;
                    I(j,:)=profileI;
                elseif validPixelNum<=profilePixelNum
                    PM2(j,:)=(M(j,:)==1);
                else
                    profileI=I(j,:);
                    profileI(find(M(j,:)==0))=999;
                    [tProfileI, tIndex]=sort(profileI,'ascend');
                    PM2(j,:)=(1<0);
                    PM2(j,tIndex(1:profilePixelNum))=1>0;
                end
                
            else
                if validPixelNum<minPixelNum
                    profileI=I(j,:);
                    [tProfileI, tIndex]=sort(profileI,'descend');
                    PM2(j,:)=1<0;
                    PM2(j,tIndex(1:minPixelNum))=1>0;
                elseif validPixelNum<=profilePixelNum
                    PM2(j,:)=(M(j,:)==1);
                else
                    profileI=I(j,:);
                    profileI(find(M(j,:)==0))=999;
                    [tProfileI, tIndex]=sort(profileI,'ascend');
                    PM2(j,:)=(1<0);
                    PM2(j,tIndex(1:profilePixelNum))=1>0;
                end
            end
        end
    end
    PM=logical(PM2-PM1);
    for j=1:size(PM,1)
        if sum(PM(j,:))<minPixelNum
            PM(j,:)=PM2(j,:);
        end
    end
    save([outputDir '/' num2str(i) '.mat'], 'PM', 'I');
    disp(num2str(i));
end

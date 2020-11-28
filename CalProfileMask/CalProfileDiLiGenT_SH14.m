clear;close all;
Tlow=40;
minPixelNum=10;
epsilon=1e-10;

inputDir='../data/DiLiGenT/ExpData/ExpData';
outputDir='../data/DiLiGenT/Profile/ProfileSH14';
mkdir(outputDir);

for i=1:10
    id=i;
    load([inputDir '/' num2str(i) '.mat']);
    PM=(1<-1);
    
    for j=1:size(I,1)
        tI = I(j,:);
        [y, y_id] = sort(tI, 'ascend');
        y_id_sel = y_id(y > shadowTH);
        
        if length(y_id_sel) > Tlow
            y_id_sel = y_id_sel(1 : Tlow);
        end
        
        PM(j, y_id_sel) = 1>0;
        validPixelNum=sum(PM(j,:));
        
        if validPixelNum<minPixelNum
            PM(j,:)=1<0;
            
            [tProfileI, tIndex]=sort(tI,'ascend');
            PM(j,tIndex(1:minPixelNum-1))=1>0;
            profileI = tI;
            profileI(tI<epsilon)=epsilon;
            I(j,:)=profileI;
        end
    end
    save([outputDir '/' num2str(i) '.mat'], 'PM', 'I');
    disp(num2str(i));
end




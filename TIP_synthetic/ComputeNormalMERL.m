function ComputeNormalMERL(id)
loadPara;
load ../L.mat;
%%

mainDir = '../data/MERL';
inputDir1=[mainDir '/ExpData/ExpData'];
inputDir2=[mainDir '/Profile/Profile' num2str(para.Tlow)];
inputDir3=[mainDir '/results/' para.method_label];
LT=L';
load([inputDir1 '/' num2str(id) '.mat']);
load([inputDir2 '/' num2str(id) '.mat']);
load([inputDir3 '/' num2str(id) '.mat']);
%%
n_gt=N;
n_pre=N_est;
[p,k] = size(I);
N_est=zeros(p,3);
errorM=zeros(p,para.iter_num);
for j=1:p
    tI=I(j,PM(j,:));
    tL=LT(:,PM(j,:));
    nt=n_pre(j,:);
    
   




    for i_i=1:para.iter_num
        nc=UpdateNormal(tI,tL,nt,para,1);
        if real(acos(dot(nc, nt))) * 180 / pi < 1e-10
            errorM(j,i_i:end)=real(acos(sum((nc.*n_gt(j,:)),2))) * 180/ pi;
            break;
        end
        errorM(j,i_i)=real(acos(sum((nc.*n_gt(j,:)),2))) * 180/ pi;
        nt=nc;
    end
    N_est(j,:)=nc;
end

%%
errorM=errorM';
e_original=mean(real(acos(sum((n_pre.*n_gt),2)) * 180 / pi));
e_ours=mean(real(acos(sum((N_est.*n_gt),2)) * 180 / pi));
error=mean(errorM,2);
save(['./' ['temp' para.method_label] '/' num2str(id) '.mat'], 'e_ours', 'e_original', 'N_est', 'error','errorM');
disp([ num2str(id) ':' num2str(e_original) ' ' num2str(e_ours)]);
end
%%
clear;close all;%clc;
loadPara;
disp('--------------');
disp(['method: ' num2str(para.method_label)]);
disp(['iter number: ' num2str(para.iter_num)]);
disp('--------------');
%%
mkdir(['temp' para.method_label]);
tic
parfor i=1:para.data_num
    ComputeNormalMERL(i);
end
toc

%%
e_original_all=zeros(para.data_num,para.iter_num);
e_ours_all=zeros(para.data_num,para.iter_num);
for i=1:100
    load(['./' ['temp' para.method_label] '/' num2str(i) '.mat']);
    e_original_all(i,1:end)=e_original;
    e_ours_all(i,:)=error';
end
%%
disp('--------------');
for i=1:para.iter_num
    percent=size(find(e_original_all(:,i)>e_ours_all(:,i)),1);
    disp([ num2str(i), ':  ' num2str(percent) ' ' num2str(mean(e_original_all(:,i))) ' ' num2str(mean(e_ours_all(:,i))) ]);
end
e_original_all=e_original_all';
e_ours_all=e_ours_all';
disp('--------------');
%%
disp(['method: ' num2str(para.method_label)]);
disp(['iter number: ' num2str(para.iter_num)]);
disp('--------------');
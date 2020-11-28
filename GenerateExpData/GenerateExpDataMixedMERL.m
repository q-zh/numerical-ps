close all; clear all; clc;


inputDir='../data/MERL/ExpData/ExpData';
outputDir='../data/MERL/ExpData/ExpDataMixed';
mkdir(outputDir);

data_num=100;
index_mixed_data=zeros(data_num,100);
for i=1:data_num
    
    disp(num2str(i));
    index_mixed_data(i,:)=randperm(100);
    data_I=zeros(1620,100);
    data_M=zeros(1620,100);
    data_R=zeros(1620,100);
    

    load([inputDir '/' num2str(index_mixed_data(i,1)) '.mat']);
    data_I(:,1:50)=I(:,1:50);
    data_M(:,1:50)=M(:,1:50);
    data_R(:,1:50)=R(:,1:50);
    load([inputDir '/' num2str(index_mixed_data(i,2)) '.mat']);
    data_I(:,51:100)=I(:,51:100);
    data_M(:,51:100)=M(:,51:100);
    data_R(:,51:100)=R(:,51:100);
    
    
    I=data_I;
    M=data_M;
    R=data_R;
    
    save([outputDir '/' num2str(i) '.mat'], 'I', 'M', 'N', 'R');
    
end
    save([outputDir '/index_mixed_data.mat'], 'index_mixed_data');
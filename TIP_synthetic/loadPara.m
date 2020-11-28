para.method=1;
para.iter_num=20;

para.data_num=100;
para.Tlow=100;
para.isLamber=1;
if para.method==1
    para.method_label='LS100';
    para.Tlow=100;
    para.iter_num_r=1;
elseif para.method==2
    para.method_label='SH14';
    para.Tlow=25;
    para.isLamber=1;
    para.iter_num_r=10;%10
elseif para.method==3
    para.method_label='100CVR_2_4_1';
    para.iter_num_r=1;
elseif para.method==4
    para.method_label='100SBL';
    para.iter_num_r=1;
elseif para.method==5
    para.method_label='100IRLS';
    para.iter_num_r=1;
end
    

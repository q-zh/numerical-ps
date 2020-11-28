close all; clear all; clc;
load MERLName.mat;
load ../L.mat;

inputDir='../data/MERL/MERL';
outputDir='../data/MERL/ExpData/ExpData';
mkdir(outputDir);

View=[0,0,1];
shadowTH=1e-6;
N = [];
for theta_n_d = 2 : 2 : 90
    for phi_n_d = 10 : 10 : 360

        theta_n = theta_n_d * pi / 180;
        phi_n = phi_n_d * pi / 180;

        nx = cos(theta_n) * cos(phi_n);
        ny = cos(theta_n) * sin(phi_n);
        nz = sin(theta_n);

        n = [nx, ny, nz];
        N = [N; n];
    end
end

for i=1:100
    id = i;
    brdfDataName = [inputDir '/' MERLName{id,1} '.binary'];
    Rho_All=[];
    I=[];
    
    for j=1:size(L,1)
        l_id= j;
        normals=N;
        Light =L(l_id,:); Light = Light / norm(Light);
        brdf4D = NLV2angle(normals,Light,View);
        brdfVal = mean(BRDFReadMatHD(brdf4D, brdfDataName), 2);
        Rho_All(:, j) = brdfVal;
        Rho_All(Rho_All < 0) = 0;
        I(:,j)=N*L(j,:)'.*Rho_All(:,j);
    end
    M=I>shadowTH;
    R=Rho_All;
    save([outputDir '/' num2str(id) '.mat'], 'I', 'M', 'R','N');
    disp(num2str(id));
end
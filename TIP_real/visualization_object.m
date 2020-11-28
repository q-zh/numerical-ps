function main()
close all;
clear;
for id =6:6
   % id = 2;
    
    main_dir = '../';
    load([main_dir 'GenerateExpData/DiLiGenTName.mat']);
    method_label = {'LS96', 'LS40', 'IK12Paper', '96IRLS', 'IK14Paper', 'SH14Paper', 'GO10Paper', 'HA15', 'HU17'};
    maxArray = [8,15,15,15,50,20,50,20,20,50];
    dir_ground = [main_dir 'data/DiLiGenT/ExpData/ExpData/'];
    errors_map = zeros(18,1);
    object_name = DiLiGenTName{id};
    
    load([dir_ground num2str(id) '.mat']);
    [x1, x2, y1, y2] = find_rect(mask, 10);
    N0 = reshape_normal_map(N, mask);
    N0 = N0(x1:x2, y1:y2, :);
    M = mask(x1:x2, y1:y2);
    disp(num2str((x2-x1)/(y2-y1)*2));
    disp(num2str((x2-x1)/(y2-y1)));
    for method_id = 1:9
        method_name= method_label{method_id};
        dir1 = [main_dir 'data/DiLiGenT/results/' method_name '/'];
        dir2 = [main_dir 'TIP_real/temp' method_name '/'];
        
        
        
        load([dir1 num2str(id) '.mat']);
        N1 = reshape_normal_map(N_est, mask);
        N1 = N1(x1:x2, y1:y2, :);
        errors_map(method_id*2-1, 1) = mean(real(acos(sum((N_est.*N),2)) * 180 / pi));
        
        load([dir2 num2str(id) '.mat']);
        N2 = reshape_normal_map(N_est, mask);
        N2 = N2(x1:x2, y1:y2, :);
        errors_map(method_id*2, 1) = mean(real(acos(sum((N_est.*N),2)) * 180 / pi));
        
        ShowNormal(N2,M, [num2str(id) '_' num2str(method_id) '-' method_name '-normal-output']);
        ShowNormal(N1,M, [num2str(id) '_' num2str(method_id) '-' method_name '-normal-input']);
        ShowError(N2, N0, M, maxArray(id),  [num2str(id) '_' num2str(method_id) '-' method_name '-er-output']);
        ShowError(N1, N0, M, maxArray(id),  [num2str(id) '_' num2str(method_id) '-' method_name '-er-input']);
    end
    
    %disp(num2str(errors_map));
    
    ShowNormal(N0,M, [num2str(id) '-ground']);
    disp([num2str(x2-x1), '  ', num2str(y2-y1)]);
    %close all ;
end
end

function [up, down, left, right] = find_rect(mask, internal)
for i=1:size(mask,1)
    k=mask(i,:);
    a=sum(k);
    if a>0
        break;
    end
end

up=i-internal;
for i=size(mask,1):-1:1
    k=mask(i,:);
    a=sum(k);
    if a>0
        break;
    end
end

down=i+internal;

for j=size(mask,2):-1:1
    k=mask(:,j);
    a=sum(k);
    if a>0
        break;
    end
end
right=j+internal;

for j=1:size(mask,2)
    k=mask(:,j);
    a=sum(k);
    if a>0
        break;
    end
end
left=j-internal;
%
% center=round([(up+down)/2,(left+right)/2]);
% up=center(1)-l;
% down=center(1)+l;
% left=center(2)-w;
% right=center(2)+w;
end

function ShowNormal( normal, mask, t )
[n,m,k]=size(normal);
if nargin==1
    mask=ones(n,m);
end

normal=normal.*repmat(mask,[1,1,3]);
normal = normal-1+repmat(mask,[1,1,3]);
a=uint8((normal+1)*128);
a(find(a==1))=0;
figure;
f = imagesc(a); title(t);
axis off;
saveas(f,t,'png');
end

function n_out = reshape_normal_map(n_in, mask, flag)
[n, m] = size(mask);
mn = mask(:)==1;
if nargin==2
    k = size(n_in, 2);
    n_out = zeros(n*m, k);
    n_out(mask(:)==1,:) = n_in;
    n_out = reshape(n_out, [n,m,k]);
else
    k = size(n_in, 3);
    n_in = reshape(n_in, [n*m, k]);
    n_out = n_in(mn,:);
end
end

function ShowError(N1, N2, mask, max_t, t_t)

t_n1 = reshape_normal_map(N1, mask, 1);
t_n2 = reshape_normal_map(N2, mask, 1);

error_map = real(acos(sum(t_n1.*t_n2,2)))*180/pi;
error_map(error_map>max_t) = max_t;
error_map=error_map./max_t;
error_map = reshape_normal_map(error_map, mask);
%error_map = repmat(error_map, [1,1,3]);
figure;
% m_map = colormap('jet');
% m_map(2:end, :) = m_map(1:end-1,:);
% m_map(1,:) = 0;
load mycolormap;
f = imagesc(error_map);
colormap(mycolormap);
%colorbar;
%set(gca, 'Fontname', 'Arial','FontSize',50);
title(t_t);
axis off;
saveas(f,t_t,'png');
end

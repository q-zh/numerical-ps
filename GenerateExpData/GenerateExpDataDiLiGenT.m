clear;close all;
load DiLiGenTName.mat;
inputDir='../data/DiLiGenT/DiLiGenT/pmsData';
outputDir='../data/DiLiGenT/ExpData/ExpData';
mkdir(outputDir);

percTH = 0.1;

for i=1:10
    dataName = [DiLiGenTName{i,1}, 'PNG'];
    datadir = [ inputDir '/' dataName];
    bitdepth = 16;
    gamma = 1;
    resize = 1;
    data = load_datadir_re(datadir, bitdepth, resize, gamma);
    load([datadir '/Normal_gt.mat']);
    
    L = data.s;
    f = size(L, 1);
    [height, width, color] = size(data.mask);
    if color == 1
        mask = double(data.mask./255);
    else
        mask = double(rgb2gray(data.mask)./255);
    end
    m = find(mask == 1);
    p = length(m);
    
    Nt=reshape(Normal_gt, [height*width, 3]);
    N=Nt(m,:);
    I = zeros(p, f);
    for j = 1 : f
        img = data.imgs{j};
        img = rgb2gray(img);
        img = img(m);
        I(:, j) = img;
    end
    
    shadowTHall = zeros(f, 1);
    for j = 1 : f
        I0 = I(:, j);
        [sortVal, sortId] = sort(I0, 'ascend');
        shadowTHall(j) = sortVal(round(length(m) * percTH));
    end
    shadowTH = median(shadowTHall);
    
    save([ outputDir '/' num2str(i) '.mat'], 'L', 'I', 'mask', 'N', 'shadowTH');
    disp(num2str(i));
end
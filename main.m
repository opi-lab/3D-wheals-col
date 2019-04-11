%% Diameter estimation Algorithm
%--------------------------------------------------------------------------------------
% The input to the work-flow is the 3-D surface of the patient's forearm S.  
% As the wheals are spread out over the global curvature of the forearm, 
% a Global Surface Removalstage is carried out to obtain Sp and isolating 
% the wheals. Sp includes bumps due to the wheals but also due to skin structural
% changes caused by pores, follicles, wrinkles, and hair. Therefore, we detect wheals
% from Sp and extract $N$ surface patches referred to as Sp_w_i, where i = {1,2,...,N}. 
% For each surface Sp_w_i, we set the origin at the center of mass to obtain Spp_w_i by
% means of Principal Component Analysis (PCA). Finally, we employ a Super-Gaussian model
% for diameter estimation. $D = [d_1,d_2,...,d_N]$ and $f$ denote the measured diameters
% and the fitted surfaces, respectively.

% http://opilab.utb.edu.co/

% This code is part of research work done by Jesus Pineda Castro. 
% Universidad Tecnológica de Bolívar , Cartagena, Colombia.
%--------------------------------------------------------------------------------------
clear; clc; close all;

% add to path
addpath image_pyramid\
addpath super_gaussian\
addpath 3D-P\
addpath C:\Python27\

% Load data
num = '2'; cam = '1';
load(['mat/data'...
    ,num,'_R3D.mat']);
if strcmp(cam,'2')
    S.Z = ZZ2.*Indix2;
    S.X = XX2.*Indix2;
    S.Y = YY2.*Indix2;
    CC = CC2;
else
    S.Z = ZZ.*Indix;
    S.X = XX.*Indix;
    S.Y = YY.*Indix;
end

% get ROI
figure(1),imagesc(S.Z),axis image,axis off,colorbar
[S.Z, rec] = imcrop;
X = imcrop(S.X,rec);
Y = imcrop(S.Y,rec);

% Global surface removal
levels = 7;
pyr = genPyr(S,'lap',levels); % the Laplacian pyramx
Sp = gsr(S,pyr,levels,[1 2 7]);

% Display results
Mask = nan(size(Sp.Z)); Mask(30:end-70,30:end-30) = 1;
figure(3),imagesc(Sp.Z.*Mask),axis image off; colorbar

% Wheal detection (Python call!)


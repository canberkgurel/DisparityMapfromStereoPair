% ENPM673 Midterm Q4 Part a. SSD and Window-based Stereo Matching
% Canberk Suat Gurel 115595972
clc; clearvars; close all;

I1 = imread('tsukuba_l.png');
I2 = imread('tsukuba_r.png');

dispmap_L = SSD(I1, I2, 7, 20);
dispmap_R = SSD(I2, I1, 7, 20);

% Normalization of the disparity maps
normalizedIm_L = uint8(255*mat2gray(dispmap_L));
normalizedIm_R = uint8(255*mat2gray(dispmap_R));

% Display Results
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1), imshow(normalizedIm_L);
title('Disparity Map (from left to right)')
set(gca,'fontsize',18);
impixelinfo;
subplot(1,2,2), imshow(normalizedIm_R);
title('Disparity Map (from right to left)')
set(gca,'fontsize',18);
impixelinfo;

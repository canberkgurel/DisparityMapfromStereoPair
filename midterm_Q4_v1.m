% ENPM673 Midterm Q4 Generation of the Disparity Map using cross correlation
% Canberk Suat Gurel 115595972

clear all; close all; clc

% Constants
CCsize=20;      % size of cross-correlation template
Hlimit = 50;    % disparity horizontal search limit
Vlimit = 8;     % disparity vertical search limit

% Read and display the stereo images
I1 = imread('tsukuba_l.png');
I2 = imread('tsukuba_r.png');
figure(1), imshow(I1, []), title('Left image');
figure(2), imshow(I2, []), title('Right image');

% Calculate disparity at a set of discrete points
Xsize = CCsize+Hlimit; 
Ysize = CCsize+Vlimit;
Xborder = Xsize+1;
Yborder = Ysize+1;

NUMpts = 0;     % Number of found disparity points

for X=Xborder:CCsize:size(I1,2)-Xborder
    for Y=Yborder:CCsize:size(I1,1)-Yborder
        
        % Extract a template from the left image centered at X, Y
        figure(1), hold on, plot(X, Y, 'rd'),hold off;
        
        T = imcrop(I1, [X-CCsize Y-CCsize 2*CCsize 2*CCsize]);
        
        % Search for match in the right image, in a region centered at X, Y
        % and of dimensions Vlimit wide by Hlimit high
        Im_R = imcrop(I2, [X-Xsize Y-Ysize 2*Xsize 2*Ysize]);
        
        % The correlation score image is the size of Im_R, expanded by CCsize 
        % in each direction
        CCscores = normxcorr2(T,Im_R);

        % Get the location of the peak in the correlation score image
        [max_score, maxindex] = max(CCscores(:));
        [Ypeak, Xpeak] = ind2sub(size(CCscores),maxindex);
        
        % If score too low, ignore this point
        if (max_score < 0.8)     
            continue;   
        end
       
        % These are the coordinates of the peak in the search image
        Xpeak = Xpeak - CCsize; Ypeak = Ypeak - CCsize;
                
        % These are the coordinates in the full sized right image
        Xpeak = Xpeak + (X-Xsize); Ypeak = Ypeak + (Y-Ysize);
        figure(2), hold on, plot(Xpeak, Ypeak, 'rd'),hold off;
        
        % Save the point in a list, along with its disparity (left-right)
        NUMpts = NUMpts+1;
        Xpt(NUMpts) = X; Ypt(NUMpts) = Y;
        Dpt(NUMpts) = Xpeak-X;        % Disparity = xright-xleft
    end
end

% Display the result %
figure('units','normalized','outerposition',[0 0 1 1]);
scatter3(Xpt, Ypt, Dpt, 1000, Dpt, 'Marker','.');
grid on, grid minor; zlim([-15 0]);
title('Disparity Map of the Stereo Pair')
xlabel('X Axis'),ylabel('Y Axis'),zlabel('Disparity');
font=18; set(gca,'fontsize',font);
colormap(winter(5)); c = colorbar;
c.Label.String = 'Disparity';
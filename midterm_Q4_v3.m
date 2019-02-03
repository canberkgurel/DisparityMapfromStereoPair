% ENPM673 Midterm Q4 Part b. Disparity Map from Block Matching with Dynamic Programming
% Canberk Suat Gurel 115595972

clc; clear all; close all; clearvars;

% Read images
I1 = imread('tsukuba_l.png'); I1 = single(I1);
I2 = imread('tsukuba_r.png'); I2 = single(I2);

nRowsLeft = size(I1, 1);
hBlockSize = 3;
dispRange = 14;    % Manually Tuned
dispMap = zeros(size(I1), 'single');
finf = 1e3;
dispCost = finf*ones(size(I1,2), 2*dispRange + 1, 'single');
dispPenalty = 0.5;
waitBar = waitbar(0,'Loading...');

% Scan over all rows
for m = 1:nRowsLeft
    dispCost(:) = finf;
    % Set min/max row bounds for image block.
    minRow = max(1,m-hBlockSize);
    maxRow = min(nRowsLeft,m+hBlockSize);
    % Scan over all columns
    for n = 1:size(I1,2)
        minCol = max(1,n-hBlockSize);
        maxCol = min(size(I1,2),n+hBlockSize);
        % Compute disparity bounds.
        mind = max( -dispRange, 1-minCol );
        maxd = min( dispRange, size(I1,2)-maxCol );
        % Compute and save all matching costs.
        for d = mind:maxd
            dispCost(n,d+dispRange+1)=sum(sum(abs(I1(minRow:maxRow,(minCol:maxCol)+d)-I2(minRow:maxRow,minCol:maxCol))));
        end
    end
    
    % Process scan line disparity costs with dynamic programming.
    optIndices = zeros(size(dispCost), 'single');
    cp = dispCost(end,:);
    for j=size(dispCost,1)-1:-1:1
        % False infinity for this level
        cfinf = (size(dispCost,1) - j + 1)*finf;
        % Construct matrix for finding optimal move for each column individually.
        [v,ix] = min([cfinf cfinf cp(1:end-4)+3*dispPenalty;
            cfinf cp(1:end-3)+2*dispPenalty;
            cp(1:end-2)+dispPenalty;
            cp(2:end-1);
            cp(3:end)+dispPenalty;
            cp(4:end)+2*dispPenalty cfinf;
            cp(5:end)+3*dispPenalty cfinf cfinf],[],1);
        cp = [cfinf dispCost(j,2:end-1)+v cfinf];
        % Record optimal routes.
        optIndices(j,2:end-1) = (2:size(dispCost,2)-1) + (ix - 4);
    end
    % Recover optimal route.
    [~,ix] = min(cp);
    dispMap(m,1) = ix;
    for k=1:size(dispMap,2)-1
        dispMap(m,k+1) = optIndices(k, max(1, min(size(optIndices,2), round(dispMap(m,k)))));
    end
    waitbar(m/nRowsLeft, waitBar);
end
close(waitBar);
dispMap = dispMap - dispRange - 1;

% Display Results
figure; imshow(dispMap,[]);
axis image; impixelinfo; caxis([0 dispRange]);
title('Disparity Map'); set(gca,'fontsize',12);

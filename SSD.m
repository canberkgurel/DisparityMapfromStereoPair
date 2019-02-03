function [dispMap] = SSD(I1, I2, W, dispMax)

%This function finds the Sum Of Square Differences of 2 given images I1 and I2. 

    I1 = im2double(I1);
    I2 = im2double(I2);
    [size_r, size_c] = size(I1);
    dispMap=zeros(size_r, size_c);
    win = (W-1) / 2;
    I1 = padarray(I1, [win, win + dispMax], 'both');
    I2 = padarray(I2, [win, win + dispMax], 'both');
    
    % Initialize progress bar
    hWaitBar = waitbar(0, 'Loading...');
    
    for r = win + 1 : 1 : win + size_r 
        
        for c = win + dispMax + 1 : 1 : win + dispMax + size_c
            prevSSD = 65532;
            best = 0;
            for dispRange = -dispMax : 1 : dispMax
                im1win = I1(r - win : r + win, c + dispRange - win : c + win + dispRange);
                im2win = I2(r - win : r + win, c - win : c + win);
                [ssd, ~] = sumsqr(im2win - im1win);
                if (prevSSD > ssd)
                    prevSSD = ssd;
                    best = dispRange;
                end
            end
            dispMap(r - win,c - win - dispMax) = best;
        end
        waitbar(r/(win + size_r),hWaitBar);
    end
end
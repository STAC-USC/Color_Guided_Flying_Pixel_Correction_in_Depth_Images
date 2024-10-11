% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to calculate sum of absolute differences metric for every pixel
%                                                         within depth map.
%
% Inputs:
%       depthImg - Low resolution depth map with dimension M x N
%       windowSize - ws x ws square window around every pixel for sad
%                                                         calculation
%
% Outputs:
%       sadMatrix - Matrix of scores s for all depth pixels 
%
function [sadMatrix] = calculate_sad_matrix(depthImg, windowSize)
% Get dimensions
[rows, cols] = size(depthImg);

% Calculate the sum of absolute differences
sadMatrix = size(depthImg);
pad = floor(windowSize / 2);
for i=1:rows
    for j=1:cols
        rowMin = max(1, i - pad);
        rowMax = min(rows, i + pad);
        colMin = max(1, j - pad);
        colMax = min(cols, j + pad);
        window = depthImg(rowMin:rowMax, colMin:colMax);
        sadValue = sum(abs(window - depthImg(i,j)), 'all');
        sadMatrix(i, j) = sadValue;
    end
        
end

end
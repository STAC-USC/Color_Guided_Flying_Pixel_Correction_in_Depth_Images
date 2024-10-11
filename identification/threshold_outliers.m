% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function ot threshold SAD scores and classify flying pixels
%
% Inputs:
%       sadMatrix - Matrix of scores s for all depth pixels 
%       threshold - % of top SAD scores to classify as flying pixels
%
% Outputs:
%       flyingPixels - Top tau % of SAD scores classified as FPs
%
function [flyingPixels, count] = threshold_outliers(sadMatrix, threshold)
% get percentage threshold
[r, c] = size(sadMatrix);
k = ceil(threshold * (r*c));

% get outliers
[outliers, outlierIndices] = maxk(sadMatrix(:), k);
flyingPixels = false(size(sadMatrix));
flyingPixels(outlierIndices) = true;
count = size(outliers, 1);
end
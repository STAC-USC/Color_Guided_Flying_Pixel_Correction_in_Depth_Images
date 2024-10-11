% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to perform flying pixel correction on depth image.
%
% Inputs:
%       enclosedPoints - set of "good" neihborhood points to use for
%                                                       optimization
%       rgbImg - Downsampled RGB image with resolution M x N             
%       rgbImgNative - High resolution RGB image with dimension 6M x 6N
%       outliers - set of identified flying pixels to be corrected
%
% Outputs:
%       newDepth - newly estimated position of flying pixel from
%                                          optimization function 
%
function newDepth = optimize_depth_value(enclosedPoints, rgbBlocks, fpBlock, fpCoord)
% get unit vector in direction of line
principalVector = fpCoord / norm(fpCoord);

DE = zeros(size(enclosedPoints, 1), 1);

% get differences
for i=1:size(enclosedPoints, 1)
    block = rgbBlocks(i).data;
    % DE(i) = mean(sum((block - fpBlock).^2, 2),1);
    DE(i) = mean(sqrt(sum((block - fpBlock).^2, 2)), 1);
end

% get dim
% rows = size(meanRgbBlocks, 1);

% find difference between
% meanFpBlock = repmat(meanFpBlock, rows, 1);

% get  sqaured L2 norm - check this line
% DE = sum((meanFpBlock - meanRgbBlocks).^2, 2);
DE = DE.^2;
DE = DE / max(DE, [], 'all');

variance = 0.1;

% weight
score = exp(-DE / (2 * (variance)^2));

% cost function - ensures against division by zero
t = -sum(score .* ((fpCoord - enclosedPoints) * principalVector')) / sum(score, "all") + 0.01;

% new coordinate of flying pixel
newDepth = fpCoord + principalVector*t;
end
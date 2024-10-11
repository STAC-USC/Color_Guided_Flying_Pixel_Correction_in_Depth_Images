% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to perform flying pixel correction on depth image.
%
% Inputs:
%       depthImg - Low resolution depth map with dimension M x N           
%       rgbImgNative - High resolution RGB image with dimension 6M x 6N
%       depthIndex - linear index of flying pixel in depth map
%
% Outputs:
%       block - 6 x 6 from high resolution RGB image corresponding to
%                                           singular depth pixel
%
function block = get_block(depthImg, rgbImgNative, depthIndex) 
% assume depth index is subscripts
% get dimensions
[rowsColor, colsColor, ~] = size(rgbImgNative);
[rowsDepth, colsDepth] = size(depthImg);

% find scale factor
rowScale = rowsColor / rowsDepth;
colScale = colsColor / colsDepth;

% Get indices to extract block
startRow = rowScale * (depthIndex(1) - 1) + 1;
startCol = colScale * (depthIndex(2) - 1) + 1;

% extract block
block = rgbImgNative(startRow:(startRow + rowScale-1), startCol:(startCol + colScale-1), :);
end
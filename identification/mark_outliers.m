% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to highlight flying pixels in low-resolution RGB image.
%
% Inputs:
%       rgbImg - Downsampled RGB image with dimension M x N 
%       outliers - set of identified flying pixels
%
% Outputs:
%       markedOutliers - RGB image with flying pixels marked as red
%
function [markedOutliers] = mark_outliers(outliers, rgbImg)
% Split channels and mark outliers as red
red = rgbImg(:, :, 1);
green = rgbImg(:, :, 2);
blue = rgbImg(:, :, 3);

red(outliers) = 255;
green(outliers) = 0;
blue(outliers) = 0;

rgbImg(:, :, 1) = red;
rgbImg(:, :, 2) = green;
rgbImg(:, :, 3)= blue;

markedOutliers = uint8(rgbImg);

end
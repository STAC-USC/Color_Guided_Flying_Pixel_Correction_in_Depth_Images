% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to perform flying pixel (FP) correction on depth image.
%
% Inputs:
%       depthImg - Low resolution depth map with dimension M x N
%       rgbImg - Downsampled RGB image with dimension M x N             
%       rgbImgNative - High resolution RGB image with dimension 6M x 6N
%       outliers - Set of identified flying pixels to be corrected
%
% Outputs:
%       correctedDepthImg - M x N depth map with flying pixel correction
%                                                               applied
function correctedDepthImg = fov_correction(depthImg, rgbImg, rgbImgNative, outliers)

addpath('fov');
addpath('identification');
addpath('pointclouds');
addpath('util');
addpath('optimization');

correctedDepthImg = depthImg;
[r, c] = size(depthImg);
origin = [0,0,0];

% identify flying pixels - done
outliers = reshape(outliers, [r*c 1]);
outlierIndices = find(outliers);

% retrieve 3d coordinates for each pixel - done 
ptCloud = get_point_cloud(depthImg, rgbImg);
points = ptCloud.Location;
points = reshape(points, [r*c  3]);

% calculate per pixel field of view
scale = 10;
[fovX, fovY] = get_pixel_fov(depthImg, scale);

% apply correction to flying pixels
for i=1:length(outlierIndices)
    index = outlierIndices(i, 1);
    flyingPixel = points(index, :);

    % skip flying pixels at the origin
    if isequal(flyingPixel, origin) 
        continue
    end

    % find fov around this flying pixel
    [~, lineLeft, lineRight, lineUp, lineDown] = get_line_equations(flyingPixel, fovX, fovY);
    enclosedPoints = check_enclosed_points(points, lineLeft, lineRight, lineUp, lineDown);

    % remove flying pixels in fov
    intersection = bitand(enclosedPoints, outliers);
    nonFps = bitxor(enclosedPoints, intersection);
    validPoints = points(nonFps, :);

    % visualize - optional
    % fpRgb = rgbImgCopy(index, :);
    % rgbImgCopy = reshape(rgbImg, [r*c 3]);
    % validRgb = rgbImgCopy(exclusivePoints, :);
    % visualize_fov(flyingPixel, fpRgb, validPoints, validRgb, lineLeft, lineRight, lineUp, lineDown);

    % normalize for visual
    numEnclosedPts = size(validPoints, 1);

    if numEnclosedPts < 1
        continue;
    end

    % get fp block
    [subi, subj] = ind2sub([r, c], index);
    fpIndex = [subi, subj];

    % get flying pixel block - in color
    fpBlock = get_block(depthImg, rgbImgNative, fpIndex);
    [r2, c2, ~] = size(fpBlock);
    fpBlock = reshape(fpBlock, [r2*c2 3]);

    % get mean rgb value of fp block
    % meanFpBlock = mean(fpBlock, 1);
    % meanRgbBlocks = zeros(numEnclosedPts, 3);

    % get indices
    depthIndices = find_indices(depthImg, nonFps);
    rgbBlocks(numEnclosedPts) = struct('data', []);

    % get color blocks for pixels
    for j=1:numEnclosedPts
        rgbBlock = get_block(depthImg, rgbImgNative, depthIndices(j, :));
        rgbBlock = reshape(rgbBlock, [r2*c2 3]);
        % meanRgbBlocks(j, :) = mean(rgbBlock, 1);
        rgbBlocks(j).data = rgbBlock;
    end

    % correct the position of flying pixel
    correctedPoint = optimize_depth_value(validPoints, rgbBlocks, fpBlock, flyingPixel);
    % correctedPoint = optimize_depth_value_old(validPoints, meanRgbBlocks, meanFpBlock, flyingPixel);
    disp(correctedPoint);

    % disregard if corrected to origin
    if isequal(correctedPoint, origin)
        correctedPoint = flyingPixel;
    end

    % disregard if corrected to NaN
    if isnan(correctedPoint)
        correctedPoint = flyingPixel;
    end

    % update values
    correctedDepthImg(subi, subj) = correctedPoint(3);
    clear rgbBlocks;
end
end
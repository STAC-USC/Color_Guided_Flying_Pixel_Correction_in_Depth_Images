% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to perform flying pixel correction on depth image.
%
% Inputs:
%       depthImg - Low resolution depth map with dimension M x N
%       exclusivePoints - set of all non-FPs within pixel field of view
%
% Outputs:
%       indices - linear indices (i,j) of all non-FPs within pixel field of view 

function indices = find_indices(depthImg, exclusivePoints)
% Grab dimensions
[rows, cols] = size(depthImg);

% Find linear indices of exclusivePoints
linearIndices = find(exclusivePoints);
indices = zeros(length(linearIndices), 2);

% Convert linear indices to subscript indices
[indices(:,1), indices(:,2)] = ind2sub([rows, cols], linearIndices);
end

% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to construct pixel field of view around a given flying pixel
%
% Inputs:
%       points - [MxN, 3] matrix with (x,y,z) coordinates of all points
%       [lineLeft, lineRight, lineUp, lineDown] - lines used to construct pixel FoV 
%       
% Outputs:
%       enclosedPoints - Points within scene enclosed by pixel FoV
%
function enclosedPoints = check_enclosed_points(points, lineLeft, lineRight, lineUp, lineDown)
% Get normals
normalLeftDown = cross(lineLeft, lineDown);
normalLeftUp = cross(lineLeft, lineUp);
normalRightUp = cross(lineUp, lineRight);
normalRightDown = cross(lineRight, lineDown);

% centroid always lies within polygon
centroid = (lineLeft + lineDown + lineUp + lineRight) / 4;
centroidProducts = [dot(normalLeftDown, centroid), dot(normalLeftUp, centroid), dot(normalRightUp, centroid), dot(normalRightDown, centroid)];
normals = [normalLeftDown', normalLeftUp', normalRightUp', normalRightDown'];

% take inner product with points
innerProducts = points * normals;
checkSign = innerProducts .* centroidProducts;

% get all positive rows - denoting same sign
enclosedPoints = all(checkSign > 0, 2);
end
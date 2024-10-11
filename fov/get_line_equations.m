% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to construct pixel field of view around a given flying pixel
%
% Inputs:
%       flyingPixel - FP to construct pixel-FoV neighborhood around
%       pixelFovX - Pixel field of view in X direction (radians)
%       pixelFovY - Pixel field of view in Y direction (radians) 
%
% Outputs:
%       principalLine - Line of sight between camera and flying pixel
%       [lineLeft, lineRight, lineUp, lineDown] - lines used to construct pixel FoV 
%
function [principalLine, lineLeft, lineRight, lineUp, lineDown] = get_line_equations(flyingPixel, pixelFovX, pixelFovY)
% Assume the camera is at the origin and flyingPixel is nx3
principalLine = flyingPixel;

thetaX = pixelFovX / 2;
thetaY = pixelFovY / 2;

% magnitude of principal line
magnitude = norm(flyingPixel);

% return shifts in each direction 
deltaX = [magnitude * tan(thetaX), 0, 0];
deltaY = [0, magnitude * tan(thetaY), 0];

lineLeft = flyingPixel - deltaX;
lineRight = flyingPixel + deltaX;
lineUp = flyingPixel + deltaY;
lineDown = flyingPixel - deltaY;
end
% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function highlight flying pixels in low-resolution RGB image.
%
% Inputs:
%       depthImg - Low resolution depth map with dimension M x N
%       scale - Magnitude that pixel FoV is scaled along each axis 
%
% Outputs:
%       pixelFovX - Pixel field of view in X direction (radians)
%       pixelFovY - Pixel field of view in Y direction (radians)  
%
function [pixelFovX, pixelFovY] = get_pixel_fov(depthImg, scale)
% intrinsics given by camera
fovAngleY=33;
fovAngleX=44;
[y, x] = size(depthImg);
pixelFovX = (fovAngleX) / x;
pixelFovY = (fovAngleY) / y;
pixelFovX = scale * deg2rad(pixelFovX);
pixelFovY = scale * deg2rad(pixelFovY);
end
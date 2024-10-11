% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to convert depth map to point cloud.
%
% Inputs:
%       depthImg - Low resolution depth map with dimension M x N
%       rgbImg - Downsampled RGB image with dimension M x N  
%
% Outputs:
%       pointCloud- 3D data with MxN points and (x,y,z,r,g,b) vector at
%                                                           every point
%
function pointCloud = get_point_cloud(depthImg, rgbImg)
% Generate point cloud from data
[intrinsics, scaleFactor] = get_camera_intrinsics(depthImg);
pointCloud = pcfromdepth(depthImg, scaleFactor, intrinsics, 'ColorImage', rgbImg);
end
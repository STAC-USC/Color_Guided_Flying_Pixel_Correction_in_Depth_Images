% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Define paths and correction for dataset. Identification of flying pixels
%                               is performed

addpath('identification\');
addpath('pointclouds');

% Define scene
scene = 'Office\6m'; 

depthDir = ['path\to\directory\' scene '\zmap_png\'];
rgbDir = ['path\to\directory\' scene '\rgb_jpg\'];
% nativeRgbDir = ['path\to\directory\' scene '\rgb_jpg_native'];

% Use this path for Office Scene
nativeRgbDir = ['path\to\directory\' scene '\rgb_jpg'];

disp(['RGB directory: ' rgbDir]);
disp(['Depth directory: ' depthDir]);
disp(['High-Res Rgb Directory: ' nativeRgbDir]);

% List of images
rgbFiles = dir(fullfile(rgbDir, '*.jpg'));
depthFiles = dir(fullfile(depthDir, '*.png')); 
nativeRgbFiles = dir(fullfile(nativeRgbDir, '*.jpg'));

% Create directories to save results
cloudDir = ['path\to\directory\' scene] ;

if ~exist(cloudDir, 'dir')
    mkdir(cloudDir)
end

% Iterate through image pairs
for j = 1:length(nativeRgbFiles)

    % Load images
    rgbFile = fullfile(rgbFiles(j).folder, rgbFiles(j).name);
    depthFile = fullfile(depthFiles(j).folder, depthFiles(j).name);
    rgbNativeFile = fullfile(nativeRgbFiles(j).folder, nativeRgbFiles(j).name);
    
    depthImg = double(imread(depthFile));
    rgbImg = double(imread(rgbFile));
    rgbImgNative = double(imread(rgbNativeFile));

    % identify outliers
    sadMatrix = calculate_sad_matrix(depthImg, 5);
    [outliers, count] = threshold_outliers(sadMatrix, 0.05);

    % correct flying pixels
    correctedImg = fov_correction(depthImg, rgbImg, rgbImgNative, outliers);

    % save pointcloud
    rgbImg = uint8(rgbImg);
    corrCloud = get_point_cloud(correctedImg, rgbImg);
    nameCloud = sprintf("oyla_%d.ply", j-1);
    pcwrite(corrCloud, fullfile(cloudDir, nameCloud));
end
% Color-Guided Flying Pixel Correction in Depth Images
% IEEE. Multimedia and Signal Processing Workshop
% Author: Ekamresh Vasudevan, University of Southern California
% Function to construct pixel field of view around a given flying pixel
%
% Inputs:
%       flyingPixel - FP to construct pixel-FoV neighborhood around
%       [lineLeft, lineRight, lineUp, lineDown] - lines used to construct pixel FoV 
%       enclosedPoints - Points within scene enclosed by pixel FoV
%       enclosedRgb - Corresponding RGB values of points enclosed
%       
% Outputs:
%        
%
function visualize_fov(flyingPixel, fpRgb, enclosedPoints, enclosedRgb, lineLeft, lineRight, lineUp, lineDown)
origin = [0,0,0];

% normalize for visual
enclosedRgb = double(enclosedRgb(:, :)) / 255;
minZ = min(enclosedPoints(:,3));
maxZ = max(enclosedPoints(:, 3));

unitLeft = lineLeft / norm(lineLeft);
unitRight = lineRight / norm(lineRight);
unitUp = lineUp / norm(lineUp);
unitDown = lineDown / norm(lineDown);

unitLeft = unitLeft * maxZ;
unitRight = unitRight * maxZ;
unitDown = unitDown * maxZ;
unitUp = unitUp * maxZ;

% plot lines for verification
lineL = [origin; unitLeft];
lineR = [origin; unitRight];
lineU = [origin; unitUp];
lineD = [origin; unitDown];
unitP = (principalLine / norm(principalLine)) * maxZ;
lineP = [origin; unitP];

% visualize
scatter3(enclosedPoints(:, 1), enclosedPoints(:, 2), enclosedPoints(:, 3), 10, enclosedRgb, 'filled');
hold on;
plot3(flyingPixel(1), flyingPixel(2), flyingPixel(3), 30, fpRgb, 'filled');
axis equal;
xlabel('x axis');
ylabel('y axis');
zlim([minZ, maxZ])
plot3(lineL(:, 1), lineL(:, 2), lineL(:, 3));
plot3(lineR(:, 1), lineR(:, 2), lineR(:, 3));
plot3(lineU(:, 1), lineU(:, 2), lineU(:, 3));
plot3(lineD(:, 1), lineD(:, 2), lineD(:, 3));
plot3(lineP(:, 1), lineP(:, 2), lineP(:, 3));
end
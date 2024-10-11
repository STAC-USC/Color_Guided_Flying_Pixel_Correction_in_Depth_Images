function enclosedPoints = check_enclosed_points_new(points, lineLeft, lineRight, lineUp, lineDown)
% get spherical coordinates of field of view lines
[az_l, ~, ~] = cart2sph(lineLeft);
[az_r, ~, ~] = cart2sph(lineRight);
[~, el_u, ~] = cart2sph(lineUp);
[~, el_d, ~] = cart2sph(lineDown);

% convert all points to spherical
[az_points, el_points, r_points] = cart2sph(points);

% get all points that fall within each range
az_candidates = 


end
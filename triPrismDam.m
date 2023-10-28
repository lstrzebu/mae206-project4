function [m, W, V] = triPrismDam(h, w, d, gamma, g)
% Calculates mass and weight of a dam having a triangular prismatic shape
%   Detailed explanation goes here

V = 0.5*h*w*d; % anonymous function for volume of triangular prism dam
% V = V_2(h, w, d); % calculate triangular prism volume

W = V*gamma; % calculate weight

m = W/g; % calculate mass

end
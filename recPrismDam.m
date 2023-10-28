function [m, W, V] = recPrismDam(h, w, d, gamma, g)
% Calculates mass and weight of a dam having a rectangular prismatic shape
%   Detailed explanation goes here

V = h*w*d; % anonymous function for volume of rectangular prism dam
% V = V_1(h, w, d); % calculate rectangular prism volume

W = V*gamma; % calculate weight

m = W/g; % calculate mass

end



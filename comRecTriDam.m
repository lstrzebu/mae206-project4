function [m, W, V] = comRecTriDam(h, w, d, gamma, g, h_tri, w_tri)
% Calculates mass and weight of a dam having a composite rectangular and triangular prismatic shape
%   Detailed explanation goes here

V = (h*w + 0.5*h_tri*w_tri)*d; % calculate volume of composite rectangular and triangular prism 

W = V*gamma; % calculate weight

m = W/g; % calculate mass

% V = V_3(h, w, d, h_tri, w_tri); % calculate volume

end
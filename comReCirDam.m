function [m, W, V] = comReCirDam(h, w, d, gamma, g, r)
% Calculates mass and weight of a dam having a composite rectangular and (negatively) circular prismatic shape
%   Detailed explanation goes here

V = (h*w + (r^2)*(1 - pi/4))*d; % calculate volume of composite rectangular and triangular prism dam
% V = V_4(h, w, d, varargin{1}); % calculate volume

W = V*gamma; % calculate weight

m = W/g; % calculate mass

end
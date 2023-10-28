function [m, W, V] = daMassWeightVol(h, w, d, shape, specWeight, g, varargin)
% Calculates mass and weight for a given dam shape
% INPUTs
%   - h: total height of dam (ft)
%   - w: width of main portion of dam (ft), usually the base of a rectangle or triangle 
%   - d: numerical value for depth into page (ft)
%   - shape: an integer from 1-4 indicating the shape of the dam:
%   rectangular prism, triangular prism, composite rectangular +
%   triangular, or composite rectangular - circular
%   - specWeight: the specific weight of the concrete used (lb/ft^3)
%   - g: gravitational acceleration (ft/s^2)
%   - varargin: a numerical vector containing the base and height of
%   an additional triangle (Shape 3) and the radius of the negative circle
%   (Shape 4) (ft)
% RETURNs
%   - m: the dam's mass (slugs)
%   - W: the dam's weight (lb_f)
%   - V: the dam's volume (ft^3)


% % initialize anonymous functions
% damWeight = @(V, specWeight) specWeight*V; % anonymous function for weight of a dam of any shape
% daMass = @(W, g) W/g; % anonymous function for mass of a dam of any shape

switch shape

    case 1 % shape is rectangular

        [m, W, V] = recPrismDam(h, w, d, specWeight, g); % calculate mass, weight and vol
    case 2 % shape is triangular

        [m, W, V] = triPrismDam(h, w, d, specWeight, g); % calculate mass, weight and vol

    case 3 % shape is composite rectangular and triangular; varargin expected to be a numerical vector containing base and height of triangle
        
        [m, W, V] = comRecTriDam(h, w, d, specWeight, g, varargin{2}, varargin{1}); % calculate mass, weight and vol

    case 4 % shape is composite rectangular and (negative) circular; varargin expected to be circle radius

        [m, W, V] = comReCirDam(h, w, d, specWeight, g, varargin{3}); % calculate mass, weight and vol
end


end
function [xbar, ybar, components] = equivalentPressureOutside(shape, waterHeight, siltHeight, h, w, d, varargin)
% Calculates mass and weight for a given dam shape
% INPUTs
%   - shape: an integer from 1-4 indicating the shape of the dam:
%   rectangular prism, triangular prism, composite rectangular +
%   triangular, or composite rectangular - circular
%   - waterHeight: height of water ABOVE that of silt (ft)
%   - siltHeight: height of silt forming sediment beneath water (ft)
%   - w: width of larger portion of dam, whether rectangular or triangular
%   (ft)
%   - h: total height of larger portion of dam (ft)
%   - w: width of main portion of dam (ft), usually the base of a rectangle or triangle
%   - d: numerical value for depth into page (ft)
%   - varargin:  a numerical vector containing the base and height of
%   an additional triangle (Shape 3) and the radius of the negative circle
%   (Shape 4) (ft)
% RETURNs
%   - xbar: a double or double array indicating x-coordinate(s) of
%   equivalent point load (ft)
%   - xbar: a double or double array indicating y-coordinate(s) of
%   equivalent point load (ft)
%   - components: a double array featuring the x- and y-components of the
%   equivalent point load (lbf)


switch shape

    case 1 % shape is rectangular

        [xbar, ybar, components] = loadIntenCentRect(waterHeight, siltHeight, w, h, d); % call function for Shape 1

    case 2 % shape is triangular

        [xbar, ybar, components] = loadIntenCentTri(waterHeight, siltHeight, w, h, d); % call function for Shape 2

    case 3 % shape is composite rectangular and triangular; varargin expected to be a numerical vector containing base and height of triangle

        [FH, ybar, FV, xbar] = DamTriForces(waterHeight, siltHeight, w, varargin{1}, varargin{2}, d); % call function for Shape 3
        % FH, PH, FV, PV
        % componentX, componentXposition, componentY, componentYposition
        components = [FH FV]; % concatenate
%         xbar = PV; % x-coordinates for x- and y-components of equivalent pressure
%         ybar = [PH(2) PH(2)]; % y-coordinates for x- and y-components of equivalent pressure
% 

    case 4 % shape is composite rectangular and (negative) circular; varargin expected to be circle radius

        %         [componentX, componentXposition, componentY, componentYposition] = DamCircleForces2(waterHeight, siltHeight, w, varargin{3}, d); % call function for Shape 4
        %         components = [componentX componentY]; % concatenate
        %         xbar = [componentXposition(1) componentYposition(1)]; % x-coordinates for x- and y-components of equivalent pressure
        %         ybar = [componentXposition(2) componentYposition(2)]; % y-coordinates for x- and y-components of equivalent pressure

end


end
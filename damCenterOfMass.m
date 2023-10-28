function centroid = damCenterOfMass(shape, h, w, varargin)
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

        centroid = rectangleCentroid(w, h); % call function for Shape 1

    case 2 % shape is triangular

        centroid = triangleCentroid(w, h); % call function for Shape 2

    case 3 % shape is composite rectangular and triangular; varargin expected to be a numerical vector containing base and height of triangle
        
        centroid = rectangleAndTriangleCentroid(w, varargin{1}, h, varargin{2}); % call function for Shape 3

    case 4 % shape is composite rectangular and (negative) circular; varargin expected to be circle radius

        centroid = CirCentroid2(w, h, varargin{3}); % call function for Shape 4
       
end

end
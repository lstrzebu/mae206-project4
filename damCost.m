function [price, varargout] = damCost(V, concreteType)
% Calculates the cost of a particularly shaped concrete dam 
% INPUTs
%   - h: total height of dam (ft)
%   - w: width of main portion of dam (ft), usually the base of a rectangle or triangle 
%   - d: numerical value for depth into page (ft)
%   - shape: an integer from 1-4 indicating the shape of the dam:
%   rectangular prism, triangular prism, composite rectangular +
%   triangular, or composite rectangular - circular
%   - gamma: the specific weight of the concrete used (lb/ft^3)
%   - g: gravitational acceleration (ft/s^2)
%   - varargin: either a numerical vector containing the base and height of
%   an additional triangle (Shape 3) or the radius of the negative circle
%   (Shape 4) (ft)
% RETURNs
%   - price: the price of the dam in USD
%   - varargout: the specific weight of the concrete used (lb/ft^3)

% initialize concrete types and prices
switch concreteType
    case 1 % light concrete

        priceRatio = 5; % $5/ft^3
        varargout{1} = 120; % light concrete's specific weight in lb/ft^3

    case 2 % standard concrete

        priceRatio = 6; % $6/ft^3
        varargout{1} = 150; % standard concrete's specific weight in lb/ft^3

    case 3 % heavy concrete

        priceRatio = 15; % $15/ft^3
        varargout{1} = 250; % heavy concrete's specific weight in lb/ft^3

end

price = V*priceRatio; % calculate price


end
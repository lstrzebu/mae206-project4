function [xbar,ybar,components] = loadIntenCentRect(waterDepth,siltDepth,varargin)
% Finds the centroid of the load intensity diagram for the rectangular dam.
%
% INPUTS:
%   waterDepth - Depth of the water
%   siltDepth - Depth of the silt (independent of water's depth, if there
%   are 2 ft of silt, put in 2)
%   varargin - Put in the width, height, and depth into the page of the dam in that order.
%
% OUTPUTS:
%   xbar - x coordinate of the centroid of the load intensity diagram
%   ybar - y coordinate of the centroid of the load intensity diagram
%   varargout - The x component and the y component of the equivalent point load in that order.

% setup constants
gammaW = 62.4; %gamma of water
gammaS = 135; %gamma of silt

% get base, height, and depth
b = varargin{1};
h = varargin{2};
d = varargin{3};

% individual centroid of the water
xbarWater = b + (1/3)*gammaW*waterDepth;
ybarWater = siltDepth + (1/3)*waterDepth;
areaWater = (1/2)*waterDepth*gammaW*waterDepth;

% centroid of the triangle and rectangle that make up the composite body of
% the load intensity diagram for silt
siltTop = gammaW*waterDepth;
siltBottom = (gammaW*waterDepth)+(gammaS*siltDepth);
areaTrapezoid = (1/2)*(siltTop+siltBottom)*siltDepth; % area of the trapezoid

yArect = siltDepth/2; % rectangle part of trapezoid
xArect = b+(1/2*gammaW*waterDepth);
yATri = siltDepth/3; % triangle part of trapezoid
xATri = b+(gammaW*waterDepth)+((1/3)*(gammaS*siltDepth));

% individual centroid of the silt
xbarSilt = (xATri+xArect)/areaTrapezoid;
ybarSilt = (yATri+yArect)/areaTrapezoid;

% finds the centroid of the load intensity diagram and the magnitude of the
% equivalent point load, outputs these values
xbar = (xbarWater*areaWater+xbarSilt*areaTrapezoid)/(areaTrapezoid+areaWater); %x-coord centroid
ybar = (ybarWater*areaWater+ybarSilt*areaTrapezoid)/(areaTrapezoid+areaWater); %y-coord centroid
% varargout{1} = areaWater*d+areaTrapezoid*d; %horizontal comp. magnitude of eq. point load
% varargout{2} = 0; %vertical comp. magnitude of eq. point load

components = [areaWater*d+areaTrapezoid*d, 0];

end

function [xbar, ybar,components] = loadIntenCentTri(waterDepth,siltDepth,varargin)
% Finds the centroid of the load intensity diagram for the triangular dam.
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

areaRect = siltDepth*(gammaW*waterDepth);
areaTri = (1/2)*siltDepth*(gammaS*siltDepth);
yArect = (siltDepth/2)*areaRect; % rectangle part of trapezoid
xArect = (b+(1/2*gammaW*waterDepth))*areaRect;
yATri = (siltDepth/3)*areaTri; % triangle part of trapezoid
xATri = (b+(gammaW*waterDepth)+((1/3)*(gammaS*siltDepth)))*areaTri;

% individual centroid of the silt
xbarSilt = (xATri+xArect)/areaTrapezoid;
ybarSilt = (yATri+yArect)/areaTrapezoid;

% find the weight of the water and the weight of the silt on the dam
volumeW = (1/2)*(siltDepth*(b/h)+(siltDepth+waterDepth)*(b/h))*waterDepth*d;
volumeS = (1/2)*(siltDepth)*((b/h)*siltDepth)*d;
weightW = gammaW*volumeW;
weightS = gammaS*volumeS;

% finds the centroid of the load intensity diagram and the magnitude of the
% equivalent point load, outputs these values
% xbarH = (xbarWater*areaWater+xbarSilt*areaTrapezoid)/(areaTrapezoid+areaWater);
ybar = (ybarWater*areaWater+ybarSilt*areaTrapezoid)/(areaTrapezoid+areaWater);
xbar = b-((b/h)*ybar);
% ybarV = ybarH;
% varargout{1} = areaTrapezoid*d+areaWater*d;
% varargout{2} = weightW+weightS;

components = [areaTrapezoid*d+areaWater*d, weightW + weightS];

end

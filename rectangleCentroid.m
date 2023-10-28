function [rectangleCentroid] = rectangleCentroid(baseRectangle, heightRectangle)
% function [rectangleCentroid] = rectangleCentroid(baseRectangle, heightRectangle, depth)

xBar = baseRectangle/2;
yBar = heightRectangle/2;
% zBar = depth/2;
% rectangleCentroid = [xBar yBar zBar]
rectangleCentroid = [xBar yBar];
end
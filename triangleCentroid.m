function [triangleCentroid] = triangleCentroid(baseTriangle, heightTriangle)
% function [triangleCentroid] = triangleCentroid(baseTriangle, heightTriangle, depth)

xBar = baseTriangle/3;
yBar = heightTriangle/3;
% zBar = depth/2;
% triangleCentroid = [xBar yBar zBar]

triangleCentroid = [xBar yBar];

end
function [rectangleAndTriangleCentroid] = rectangleAndTriangleCentroid(baseRectangle, baseTriangle, heightRectangle, heightTriangle)

% function [rectangleAndTriangleCentroid] = rectangleAndTriangleCentroid(baseRectangle, baseTriangle, heightRectangle, heightTriangle, depth)

xRec = baseRectangle/2;
yRec = heightRectangle/2;
areaRec = baseRectangle*heightRectangle;

xTri = baseRectangle + baseTriangle/3;
yTri = heightTriangle/3;
areaTri = .5*baseTriangle*heightTriangle;

xBar = (xRec*areaRec + xTri*areaTri)/(areaRec + areaTri);
yBar = (yRec*areaRec + yTri*areaTri)/(areaRec + areaTri);
% zBar = depth/2;
% 
% rectangleAndTriangleCentroid = [xBar yBar zBar]

rectangleAndTriangleCentroid = [xBar yBar];

end
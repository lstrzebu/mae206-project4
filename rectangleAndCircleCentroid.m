function [rectangleAndCircle] = rectangleAndCircleCentroid(baseRectangle,heightRectangle, radius)
% function [rectangleAndCircle] = rectangleAndCircleCentroid(baseRectangle,heightRectangle, radius, depth)

xRec = baseRectangle/2;
yRec = heightRectangle/2;
areaRec = baseRectangle*heightRectangle;

xSquare = baseRectangle + radius/2;
ySquare = radius/2;
areaSquare = radius^2;

xQuarter = baseRectangle + radius - (pi*radius^4)/16;
yQuarter = radius - (pi*radius^4)/16;
areaQuarter = .25*pi*radius^2;

xBar = (xRec*areaRec + xSquare*areaSquare - xQuarter*areaQuarter)/(areaRec + areaSquare - areaQuarter);
yBar = (yRec*areaRec + ySquare*areaSquare - yQuarter*areaQuarter)/(areaRec + areaSquare - areaQuarter);
% zBar = depth/2;

% rectangleAndCircle = [xBar yBar zBar]
rectangleAndCircle = [xBar yBar];
end
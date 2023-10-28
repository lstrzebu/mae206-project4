function [Xbar, Ybar] = CirCentroid2(height, width, radius)
%Finds the centroid of the circular dam.

%INPUTS: Total dam height, Rectangle portion width, Radius
%OUTPUT: Centroidal Cordinates of the Dam


%area and centroid of the big rectangle
reArea = height*width;
reXbar = width/2;
reYbar = height/2;

%area and centroid of the small square
sqArea = radius*radius;
sqXbar = width + (radius/2);
sqYbar = radius/2;

%area and centroid of the circular hole
cirArea = -(pi*(radius.^2))/4;
cirXbar = (width+radius) - ((4*radius)/(3*pi));
cirYbar = (radius) - ((4*radius)/(3*pi));

%calculating the final centroid and Area
TotalArea = reArea+sqArea+cirArea;
Xbar = (reArea*reXbar + sqArea*sqXbar + cirArea*cirXbar)/TotalArea;
Ybar = (reArea*reYbar + sqArea*sqYbar + cirArea*cirYbar)/TotalArea;

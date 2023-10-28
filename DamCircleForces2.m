function [FH, PH, FV, PV] = DamCircleForces(heightWater, heightSilt, width, radius, depth)
% function [FH, PH, FV, PV] = DamCircleForces(heightWater, heightSilt, height, width, radius, depth)

%INPUT: Dimensions of the dam, pretty self explanatory, code doesn't work
%currently if r>heightSilt. heightWater is the not the total height to the
%top of the water but from the top of the silt.

%OUTPUT FH, PH, FV, PV. FH and FV are the magnitude of the vertical and
%horizontal forces and PH, and PV are where they act

%constant specific Weights
specWeightWater = 62.4;
specWeightSilt = 135;

%Calculating the horizontal Water Pressure
FHwaterTri = (.5*(specWeightWater*heightWater)*heightWater)*depth;
WaterTriYbar = (heightWater/3) + heightSilt;

%What is this for???
%FHwaterSq = specWeightWater*heightWater*heightSilt;
%WaterSqYbarH = heightSilt/2;

%Calculating the Horizontal Silt Pressure
FHsilt = .5*(specWeightSilt*heightWater+specWeightSilt*(heightWater+heightSilt))*heightSilt*depth; % Volume of trapezoid fixed
SiltYbar = heightSilt/3; % This needs to be the centroid of a trapezoid shape (needs to be changed) because the silt load intensity diagram comes out to a trapezoid
AreaH = FHsilt+FHwaterTri+FHwaterSq;
FH = AreaH*depth;
PH = [width, ((FHwaterSq*WaterSqYbarH)+(FHwaterTri*WaterTriYbar)+(FHsilt*SiltYbar))/AreaH, depth/2];

%splits into parts depending on the relationship between the radius and
%height of the silt.

if radius <= heightSilt 
FVwater = specWeightWater*heightWater*radius;
WaterSqXbarV = width + (radius/2);

FVsiltSq = specWeightSilt*(heightSilt-radius)*radius;
FVsiltCir = specWeightSilt*pi()*(radius)^2;

SiltSqXbar = width + (radius/2);
SiltCirXbar = (width+radius) - ((4*radius)/(3*pi()));

AreaV = FVsiltCir+FVsiltSq+FVwater;

Xbar = ((FVwater*WaterSqXbarV)+(FVsiltSq*SiltSqXbar)+(FVsiltCir*SiltCirXbar))/AreaV;
Ybar = sqrt((radius^2)-((Xbar-width)^2));
FV = AreaV*depth;
PV = [Xbar, Ybar, depth/2];

else
%This is where we need to add the code for when the water and silt are that
%weird split circular shape.
end
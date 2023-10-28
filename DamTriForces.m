function [FH, PH, FV, PV] = DamTriForces(heightWater, heightSilt, width, Triwidth, Triheight, depth)

%INPUT: Dimensions of the dam, pretty self explanatory Tri width and Tri
%height are both just the width and height of the triangle
%
% OUTTPUT FH, PH, FV, PV. FH and FV are the magnitude of the vertical and
%horizontal forces and PH, and PV are where they act

%constant specific Weights
specWeightWater = 62.4;
specWeightSilt = 135;

%Calculating the horizontal Water Pressure
FHwaterTri = .5*specWeightWater*(heightWater^2);
WaterTriYbar = (heightWater/3) + heightSilt;

FHwaterSq = specWeightWater*heightWater*heightSilt;
WaterSqYbarH = heightSilt/2;

%Calculating the Horizontal Silt Pressure
FHsilt = .5*specWeightSilt*(heightSilt^2);
SiltYbar = heightSilt/3;
AreaH = FHsilt+FHwaterTri+FHwaterSq;
FH = AreaH*depth;
% PH = [width, ((FHwaterSq*WaterSqYbarH)+(FHwaterTri*WaterTriYbar)+(FHsilt*SiltYbar))/AreaH, depth/2];
PH = ((FHwaterSq*WaterSqYbarH)+(FHwaterTri*WaterTriYbar)+(FHsilt*SiltYbar))/AreaH;

%Calculating Veritcal Water & Silt Pressure
%case 1 is when the silt is higher than the triangle

%this is an anonymous function that spits out the distance from the
%right side of the triangle at the current height
widthfunct = @(y) (Triwidth/Triheight)*y;

if heightSilt >= Triheight
    FVwater = Triwidth*heightWater*specWeightWater*depth;
    FVsiltSq = Triwidth*(heightSilt-Triheight)*specWeightSilt*depth;
    FVsiltTri  = .5*Triwidth*Triheight*specWeightSilt*depth;
    waterXbar = width + Triwidth/2;
    siltSqXbar = width + Triwidth/2;
    siltTriXbar = width + Triwidth - (Triwidth/3);

    FV = FVwater + FVsiltSq + FVsiltTri;
    PV = ((FVwater*waterXbar) + (FVsiltSq*siltSqXbar) + (FVsiltTri*siltTriXbar))/FV;
    %     PV = [xbar, Triheight-((Triheight/Triwidth)*(xbar-width))];
    %     FV = FV*depth;


else
    %Case 2 is when the triangle is higher than the water
    if Triheight >= (heightWater + heightSilt)

        %calculates the force downward due to all 3 shapes
        FVsilt = (.5*heightSilt*widthfunct(heightSilt)*specWeightSilt);
        FVwaterSq = (heightWater*widthfunct(heightSilt)*specWeightWater);
        FVwaterTri = .5*heightWater*(widthfunct(heightWater+heightSilt)-widthfunct(heightSilt))*specWeightWater;

        %sums the forces, and finds the centroids using the formulas for
        %baisc shapes
        FV = FVsilt + FVwaterSq + FVwaterTri;
        siltXbar = width + Triwidth - widthfunct(heightSilt)/3;
        waterSqXbar = width + Triwidth - widthfunct(heightSilt)/2;
        waterTriXbar = width + Triwidth - (widthfunct(heightWater+heightSilt)-widthfunct(heightSilt))/3;

        %Calculates the overall centroid
        PV = (FVsilt*siltXbar + FVwaterSq*waterSqXbar + FVwaterTri*waterTriXbar)/FV;
        %         Y = (Xbar-width)*(Triwidth/Triheight);
        %         PV = [Xbar, Y];
        FV = FV*depth;


    else
        %this case occurs when the silt height is less than the triangle height

        %Calculating all the vertical water pressures
        FVwaterSqTop = Triwidth*(heightWater-(Triheight-heightSilt))*specWeightWater*depth;
        FVWaterSqBot = widthfunct(heightSilt)*specWeightWater*(Triheight-heightSilt)*depth;
        FVWaterTri = .5*(Triheight-heightSilt)*specWeightWater*(Triwidth-widthfunct(heightSilt))*depth;
        FVSilt = .5*specWeightSilt*widthfunct(heightSilt)*heightSilt*depth;

        %Calculates the centroids of the individual shapes
        WaterSqTopXbar = width + Triwidth/2;
        WaterSqBotXbar = width + Triwidth - widthfunct(heightSilt)/2;
        WaterTriXbar = width + ((Triwidth-widthfunct(heightSilt)))*(2/3);
        SiltXbar = width + Triwidth - widthfunct(heightSilt)/3;

        FV = FVwaterSqTop+FVWaterSqBot+FVWaterTri+FVSilt;
        PV = (FVwaterSqTop*WaterSqTopXbar + FVWaterSqBot*WaterSqBotXbar + WaterTriXbar*FVWaterTri + FVSilt*SiltXbar)/FV;
        %         Ybar = (Xbar-width)*(Triwidth/Triheight);
        %         PV = [Xbar, Ybar];
        %         FV = FV*depth;
    end
end




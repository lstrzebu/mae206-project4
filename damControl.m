% MAE 206 Project 4 Main Script
% Liam Trzebunia-Niebies
% April 4, 2023

clear;clc; close all;

%% Dam Shape, Mass and Weight


d_page = 40; % depth into page = 40 ft (constant)
waterHeight = 20;
siltHeight = 10;
rhog_water = 62.4; % lb/ft^3
rhog_silt = 135; % lb/ft^3
g = 32.2; % gravitational acceleration (ft/s^2)
% h_tri = 20;
% w_tri = 20;
r = 0;
% shape = 3;
% h_tri = 13;

%% Metrics

outputFile = fopen('damSimulations.csv', 'w');
fprintf(outputFile, 'Shape, b (ft), d (ft), Cost (USD), Concrete, Weight, xbar, ybar, Horizontal Pressure Outside Dam, Vertical Pressure Outside Dam, x-coordinate of Pressure Outside Dam, y-coordinate of Pressure Outside Dam, Horizontal Pressure Inside Dam\n'); % output file header
% after cost:
% , Weight, xbar, ybar, Horizontal Pressure Outside Dam, Vertical Pressure Outside Dam, x-coordinate of Pressure Outside Dam, y-coordinate of Pressure Outside Dam

concreteTypes = ["Light" "Standard" "Heavy"];

% initialize counters
numIterations = 0;
numCostFails = 0;
numSlipTipFails = 0;

% h = 33;

h_tri = 11.5;
w_tri = 13.55;
shape = 2;
w = 25;
concrete = 2;

for h = 31:35
    %
    for w = 20:5:40
%         %
%         %         %         for r = 1:10:10
%         %
%         for h_tri = 5:5:30
%             %
%             for w_tri = 5:5:30
%                 %
%                 for shape = 1:3
%                     %
                    for concrete = 1:3

                        numIterations = numIterations + 1; % update counter
                        % preallocate structure arrays for speed
                        %             cost = struct('light', cell(1, length(shapeType)), 'standard', cell(1, length(shapeType)), 'heavy', cell(1, length(shapeType)));
                        %             specWeight = struct('light', cell(1, length(shapeType)), 'standard', cell(1, length(shapeType)), 'heavy', cell(1, length(shapeType)));
                        %             m = struct('light', cell(1, length(shapeType)), 'standard', cell(1, length(shapeType)), 'heavy', cell(1, length(shapeType)));
                        %             W = struct('light', cell(1, length(shapeType)), 'standard', cell(1, length(shapeType)), 'heavy', cell(1, length(shapeType)));
                        %                     switch shape
                        %
                        %                         case {1, 2}
                        % determine metrics for rectangular prismatic dam
                        [~, ~, V] = daMassWeightVol(h, w, d_page, shape, 0, 0, w_tri, h_tri, r); % obtain volume of rectangular prismatic dam

                        % obtain costs of dam construction for light, standard & heavy
                        % concrete
                        [cost, specWeight] = damCost(V, concrete);
                        %             [costStandard, specWeight(shapeType).standard, ~] = damCost(V1, 2);
                        %             [costHeavy, specWeight(shapeType).heavy, ~] = damCost(V1, 3);

                        if cost <= 1000000 % if solution is valid
                            % obtain mass and weight of dam for force modeling
                            [~, W, ~] = daMassWeightVol(h, w, d_page, shape, specWeight, g, w_tri, h_tri, r);
                            %             [mStandard, WStandard, ~] = daMassWeightVol(h, w, d_page, shapeType, specWeight(shapeType).standard, g);
                            %             [mHeavy, WHeavy, ~] = daMassWeightVol(h, w, d_page, shapeType, specWeight(shapeType).heavy, g);

                            massCenter = damCenterOfMass(shape, h, w, w_tri, h_tri, r); % obtain center of mass at which weight acts

                            % fluid pressures
                            [P_out_xcoord, P_out_ycoord, P_out] = equivalentPressureOutside(shape, waterHeight, siltHeight, h, w, d_page, w_tri, h_tri, r); % obtain equivalent pressure from water + silt buildup outside dam
                            [P_in, P_in_ycoord] = horizontalForce(rhog_water, 5, d_page); % obtain equivalent pressure from 5 ft of water inside page

                            if ~slip(W, 0.5, P_out(1), P_in) && ~tip(W, massCenter(1), P_out(1), P_out_ycoord, P_out(2), P_out_xcoord, P_in, P_in_ycoord) % if solution continues to be correct

                                fprintf(outputFile, '%d, %f, %f, %f, %s, %f, %f, %f, %f, %f, %f, %f, %f \n', shape, h, w, cost, concreteTypes(concrete), W, massCenter(1), massCenter(2), P_out(1), P_out(2), P_out_xcoord, P_out_ycoord, P_in);
                                % after cost: W, massCenter(1), massCenter(2), P_out(1), P_out(2), P_out_xcoord, P_out_ycoord
                                % corresponding:  %f, %f, %f, %f, %f, %f, %f
                                fprintf('Solution %d valid\n', numIterations);

                            else
                                numSlipTipFails = numSlipTipFails + 1;
                                fprintf('Solution %d failed slip or tip criteria \n', numIterations);

                            end

                        else
                            numCostFails = numCostFails + 1;
                            fprintf('Solution %d failed cost criterion\n', numIterations);

                        end
                        %
                        %                         case 3
                        %
                        %                         case 4
                        %
                        %                     end

                    end
% 
%                 end
% 
%             end
% 
%         end
% 
    end

end

        % end

        fprintf(outputFile, '%d iterations failed cost criterion \n%d iterations failed slipping or tipping conditions', numCostFails, numSlipTipFails);

        fclose('all');

        % % determine metrics for triangular prismatic dam
        % [m2, W2, V2] = daMassWeightVol(h, w, d_page, 2, gamma, g);
        % cost(2).light = damCost(V2, 1);
        % cost(2).standard = damCost(V2, 2);
        % cost(2).heavy = damCost(V2, 3);
        %
        % % determine metrics for composite rectangular and triangular prismatic dam
        % [m3, W3, V3] = daMassWeightVol(h, w, d_page, 3, gamma, g, w_tri, h_tri);
        % cost(3).light = damCost(V3, 1);
        % cost(3).standard = damCost(V3, 2);
        % cost(3).heavy = damCost(V3, 3);
        %
        % % determine metrics for rectangular and (negative) circular prismatic dam
        % [m4, W4, V4] = daMassWeightVol(h, w, d_page, 4, gamma, g, r);
        % cost(4).light = damCost(V4, 1);
        % cost(4).standard = damCost(V4, 2);
        % cost(4).heavy = damCost(V4, 3);

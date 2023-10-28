function willTip = tip(W, xbar, P_outside_horizontal, p_y_outside, P_outside_vertical, p_x_outside, P_inside, p_y_inside)
% 2D free body analysis for a dam threatening to tip due to fluid pressure
% from water and silt buildup. Axes centered at bottom left corner of
% shape.
%
% INPUTs
%   - W: the weight of the dam (acting at xbar, ybar) as a force in
%   lbs
%   - ybar: the y-coordinate (ft) of the dam's centroid, i.e. the y-coordinate
%   where the weight acts
%   - P: the magnitude of the equivalent load due to water and silt fluid
%   pressure (in lbs). Note there is NO y-component of fluid pressure
%   because of the rectangle shape
%   - p_x: the x-COORDINATE of the pressure, that is, where Px acts (ft)
%   - p_y: the y-COORDINATE of the pressure, that is, where Px acts (ft)
%   - h: total height of rectangular dam (ft)
%   - w: width of rectangular dam (ft)
% RETURNs
%   - willTip: a logical value indicating whether the model predicts the
%   dam will tip

% setup equilibrium equation for moments around the origin
syms P 
M = 0 == p_y_outside*P - p_x_outside*P_outside_vertical - xbar*W - p_y_inside*P_inside; 
tippingPoint = solve(M, P); % solve for P necessary to tip

% compare solutions
if P_outside_horizontal < double(tippingPoint) 
    willTip = false;
else
    willTip = true;
end


end
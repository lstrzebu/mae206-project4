function willSlip = slip(W, mu, P_outside, P_inside)
% Acts as a 2D free body analysis for a dam slipping due to fluid pressure 
% from water and silt build-up
%
% axes centered at bottom left corner of shape
%
% INPUTs
%   - mu: coefficient of static friction
%   - W: the weight of the dam (acting at xbar, ybar) as a force in
%   lbs
%   - P_outside: the magnitude of the equivalent load due to water and silt fluid
%   pressure OUTSIDE the dam (in lbs). Note there is NO y-component of fluid pressure
%   because of the rectangle shape
%   - P_inside: the magnitude of the equivalent pressure 
% RETURNs
%   - willSlip: a logical value indicating whether the model predicts the
%   current dam will slip


N = W; % sum of forces in y
F = mu*N; % slipping assumption
P_slip = F + P_inside; % sum of forces in x

% compare existing fluid pressure with fluid pressure necessary for
% slipping
if P_outside < P_slip
    willSlip = false;
else
    willSlip = true;
end




end
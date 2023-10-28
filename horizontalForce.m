function [force,forceheight] = horizontalForce(pg, h, z)

%pg - will be 62.4 for US units, or 9810 for the european homies out there,
%(9.81 * 1000 = 9810)
% force is the magnitude of the force given a height and depth of water
% force height is the location of the point force found above, which will
% be 1/3 from the bottom of the triangle (h *(.333))

force = .5*pg*h^2*z;
forceheight = h/3;

end
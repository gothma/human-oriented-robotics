%% --------------------------------------------------------------
% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal, Kai Arras
%% --------------------------------------------------------------

function K = rbfkernel( xi,xj,sigma )
%RBFKERNEL Simple RBF kernel
% Input:
% 	xi, yi - elements
% 	sigma - width of the rbf kernel
% Output:
% 	K - computed kernel value

if sigma <= 0,
  error(message('Sigma must be greater than 0'));
else
  K = exp(-norm(xi - xj,2)^2 / (2*sigma^2));
end;
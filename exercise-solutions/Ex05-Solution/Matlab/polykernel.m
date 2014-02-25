%% --------------------------------------------------------------
% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal, Kai Arras
%% --------------------------------------------------------------

function K = polykernel( xi,xj,order )
%POLYKERNEL Polynomial kernel
% Input:
% 	xi, yi - elements
%	order - polynomial order
% Output:
% 	K - computed kernel value

% make default order 3
if order < 3,
  order = 3;
end

K = xi'*xj;

for i = 2:order,
  K = K.* (1 + (xi'*xj));
end

end


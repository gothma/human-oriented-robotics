%% --------------------------------------------------------------
% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal, Kai Arras
%% --------------------------------------------------------------

function K = linearkernel( xi, xj )
%LINEARKERNEL Simple linear kernel
% Input:
% 	xi, yi - elements
% Output:
% 	K - computed kernel value

K = xi' * xj;

end


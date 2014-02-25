% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal

% Script to test the vectorized and efficient way to compute different
% norms of a query point to a dataset (typically the training set) of points

clear;
dim = 20;
n = 31;

% Euclidian distance
q = zeros(1,dim);
yvec = (0:n-1)-(n-1)/2;
data = [ones(n,1) yvec' ones(n,dim-2)];

l2normdistances = calcl2norm(data,q)
l1normdistances = calcl1norm(data,q)
linfnormdistances = calclinfnorm(data,q)
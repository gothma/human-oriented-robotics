function distances = calcl2norm(data,point)
% This is the fastest Matlab code that I know for calculating Euclidean distances between
% a test point and all points in a training set. It is fast because it uses the identity
% (a-b)2 =a2-2ab+b2 to avoid copying data. 
%     input: n x m data matrix, n x 1 single point
%    output: column vector of distances
% Charles Elkan, elkan@cs.ucsd.edu, Jan 2011

distances = sum(data.^2, 2) - 2*data*point' + point*point';
distances = sqrt(distances);
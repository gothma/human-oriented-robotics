function distances = calclinfnorm(data,point)
%     input: n x m data matrix, n x 1 single point
%    output: column vector of distances

distances = max(abs(data - ones(size(data,1),1)*point),[],2);
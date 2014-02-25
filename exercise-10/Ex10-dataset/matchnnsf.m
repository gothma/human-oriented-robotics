function [tracks,obs] = matchnnsf(tracks,obs,ALPHA)

ntracks = length(tracks);
nobs = length(obs);

% Compute the Mahalanobis distance matrix D
D = zeros(ntracks,nobs);


nmatch = 0;
terminated = false;
while ~terminated,
  % Iteratively find minimum distance in D

  % test if it is smaller than the gating threshold, if yes mark the pairing
  % as matched, if not terminate
  
  % Remove row and column from D

end;
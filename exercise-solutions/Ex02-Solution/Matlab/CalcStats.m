% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Timm Linder



%% 2.4 (a) Manual computation of statistics
means_manual = sum(data,1) ./ size(data,1)

means_matrix = repmat(means_manual, size(data,1), 1); % to calculate central moments
vars_manual = sum((data - means_matrix).^2, 1) ./ size(data,1)
stddevs_manual = sqrt(vars_manual)

third_central_moment_manual = sum((data - means_matrix).^3, 1) ./ size(data,1) % ./ stddevs_manual.^3   % must normalize to get standard moment!
fourth_central_moment_manual = sum((data - means_matrix).^4, 1) ./ size(data,1) % ./ stddevs_manual.^4   % must normalize to get standard moment!


%% 2.4 (b) Verifying statistics with Matlab built in tools

means = mean(data,1)
vars = var(data,1)
stddevs = std(data,1)

third_central_moment = moment(data,3,1)
fourth_central_moment = moment(data,4,1)

% These are the standardized (normalized) moments:
skews = skewness(data,1,1)
kurts = kurtosis(data,1,1)
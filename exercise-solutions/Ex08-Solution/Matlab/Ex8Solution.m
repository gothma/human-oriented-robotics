% Human-Oriented Robotics Course
% Social Robotics Lab, University of Freiburg, Kai Arras
% (c) SRL, 2014
% Exercise 8: Hidden Markov Model

clc; clear;

% Random seed (change in Ex8.1 + Ex8.2)
RNDSEED = 15;
% Sequence length K
NOBSERVATIONS = 100;    
% Note the coloring of the states: 1: blue, 2: green, 3: red

% Set seed and define some variables
rand('twister',RNDSEED);
nobs = NOBSERVATIONS;  % alias for better code readability
nstates = 3;


%% HMM Parameters
% Transition matrix A : syntax (i,j) means from state i to state j
% Observation matrix E: syntax (i,j) means prob. that symbol j is observed in state i
A = [0.97  0.02  0.01;
    0.03  0.95  0.02;
    0.025  0.025  0.95];
E = [0.7  0.2  0.1;
     0.1  0.8  0.1;
     0.1  0.1  0.6];
% Priors: uniform priors over states
priors = 1/nstates*ones(nstates,1);

% Generate a random state and observation sequence given the HMM parameters 
[obs, states] = hmmgenerate(nobs,A,E);


%% --- Exercise 8.1: Forward-backward algorithm
% Forward pass
alpha = zeros(nstates,nobs+1);
alpha(:,1) = priors;
for i = 2:nobs+1,
  % Recursive filtering equation
  Ed = diag(E(:,obs(i-1)));
  alphai = Ed * A' * alpha(:,i-1);
  % Normalization
  alpha(:,i) = alphai ./ sum(alphai);
end;

% Backward pass
x = zeros(nstates,nobs+1);
beta = zeros(nstates,nobs+1);
beta(:,end) = ones(nstates,1);
for i = nobs+1:-1:2,
  % Multiplication and normalization
  xi = alpha(:,i) .* beta(:,i);
  x(:,i) = xi ./ sum(xi);
  % Recursive smoothing equation
  Ed = diag(E(:,obs(i-1)));
  beta(:,i-1) = A * Ed * beta(:,i);
end;


%% --- Exercise 8.2: Viterbi Algorithm

% Initializations
mu    = zeros(nstates,nobs);  % probabilites of most likely path so far
smax  = zeros(nstates,nobs);  % states of most likely path so far
mu(:,1) = diag(E(:,obs(1))) * priors; 
% Main loop
for i = 2:nobs,
  Ed = diag(E(:,obs(i)));
  [m, smax(:,i)] = max(A'*diag(mu(:,i-1)),[],2);
  mu(:,i) = Ed * m;
end;
% Reconstruct most likely sequence
xstar = zeros(1,nobs);
[m, smaxlast] = max(mu(:,end));
xstar(end) = smaxlast;
simax = smaxlast;
for i = nobs:-1:2,
  simaxpre = smax(simax,i);
  xstar(i-1) = simaxpre;
  simax = simaxpre;
end;


%% Plot
% Coloring of states: 1: blue, 2: green, 3: red
figure(1); clf;

subplot(4,1,1); hold on;
colormap(flipud(eye(3))); caxis([1 3]);
scatter(1:length(states),ones(size(states)),20,states,'filled');
title('Ground truth states');
daspect([1 0.5 1]); axis off;

subplot(4,1,2); hold on;
colormap(flipud(eye(3))); caxis([1 3]);
scatter(1:length(obs),ones(size(obs)),20,obs,'filled');
title('Observed labels');
daspect([1 0.5 1]); axis off;

subplot(4,1,3); box on; hold on;
colormap(flipud(eye(3))); caxis([1 3]);
plot(1:nobs,alpha(:,2:end),'.-');
title('Filtered probabilities');

subplot(4,1,4); box on; hold on;
colormap(flipud(eye(3))); caxis([1 3]);
plot(1:nobs,x(:,2:end),'.-');
title('Smoothed probabilities');


figure(2); clf;

subplot(3,1,1); hold on;
colormap(flipud(eye(3))); caxis([1 3]);
scatter(1:length(states),ones(size(states)),20,states,'filled');
title('Ground truth states');
daspect([1 0.5 1]); axis off;

subplot(3,1,2); hold on;
colormap(flipud(eye(3))); caxis([1 3]);
scatter(1:length(obs),ones(size(obs)),20,obs,'filled');
title('Observed labels');
daspect([1 0.5 1]); axis off;

subplot(3,1,3); hold on;
colormap(flipud(eye(3))); caxis([1 3]);
scatter(1:length(xstar),ones(size(xstar)),20,xstar,'filled');
title('Most probable state sequence');
daspect([1 0.5 1]); axis off;



% Human-Oriented Robotics Course
% Social Robotics Lab, University of Freiburg, Kai Arras
% (c) SRL, 2014
% Exercise 8: Hidden Markov Model

clc; clear;

% Random seed (change in Ex8.1c + 8.2c)
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
     0.1  0.3  0.6];
% Priors: uniform priors over states
priors = 1/nstates*ones(nstates,1);

% Generate a random state and observation sequence given the HMM parameters 
[obs, states] = hmmgenerate(nobs,A,E);


%% --- Exercise 8.1: Forward-backward algorithm
% Forward pass

alpha = zeros(nstates,nobs+1);
%
%
% Fill in your code...
%
%

% Backward pass

x = zeros(nstates,nobs+1);
beta = zeros(nstates,nobs+1);
%
%
% Fill in your code...
%
%



%% --- Exercise 8.2: Viterbi Algorithm

mu   = zeros(nstates,nobs);  % probabilites of most likely path so far
smax = zeros(nstates,nobs);  % states of most likely path so far

% Initialize mu for the first observation, taking priors and observation matrix into account
mu(:,1) = % fill in here...

% Now iterate over the sequence of observations k=2,...,nobs
% In each step, calculate mu and maximize for the most likely predecessor state for every state

%
% Fill in your code...
%


% Reconstruct most likely sequence
xstar = zeros(1,nobs);

% Iterate backwards over smax to reconstruct xstar,
% starting with the most likely state at the end of the sequence

%
% Fill in your code...
%





%% --- Plotting ---

% For plotting, copy your results to the following variables
alpha = ... ;    % alpha probability distributions from forward pass (note: plotted for i = 2...nobs+1)
x     = ... ;    % smoothed probability distributions (note: plotted for i = 2...nobs+1)
xstar = ... ;    % most likely path determined using the Viterbi Algorithm
% Remember the coloring of states: 1: blue, 2: green, 3: red

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



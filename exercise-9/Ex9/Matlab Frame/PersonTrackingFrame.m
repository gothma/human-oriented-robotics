% Human Oriented Robotics WS13/14
% Exercise 9: Temporal Reasoning: Kalman Filter
% v.1.0, Jan 2012, Kai Arras, SRL Freiburg
% v.1.1, Jan 2014, Billy Okal, SRL Freiburg

clear all; clc;

C0 = diag([0.1 0.1 0.1 0.1]);
Q = diag([0.01 0.01 0.1 0.1]);


% Exercise 9.1: Getting started, plot observation sequence

% Read in log file
if exist('datatracks.mat','file'),
  load('datatracks');
else
  disp('Error: data set file not found!');
  break;
end;

% Plot observation sequence
figure(1); clf; box on; hold on; axis equal;

% Your code...









%% Main loop

% Your code...



% Your code...
% for k = 1:....
 
  % Exercise 9.2: Filter initialization (Hint: use an 'initialized' flag)
  % Your code...

  % Exercise 9.3: Motion Model
  % Your code...

  % Get observation at time k
  % Your code...

  % Exercise 9.4: Measurement Model
  % Your code...

  % Compute v,S and perform gating test
  % Your code...

  % Exercise 9.5: Kalman filter
  % Your code...
  
  % Store state histories
  % Your code...
 
% end;



%% Plot histories

figure(2); clf;
% Your code...




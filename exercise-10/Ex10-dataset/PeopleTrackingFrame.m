% Human Oriented Robotics WS13/14
% Exercise 10: Temporal Reasoning:Data Association and Multi-Target Tracking
% 
% v.1.0, Jan 2012, Kai Arras, SRL Freiburg
% v.1.1,Jan 2014, Luigi Palmieri, SRL Freiburg

clear all; clc;

P0 = diag([0.01 0.01 0.1 0.1]);
Q = diag([0.001 0.001 0.1 0.1]);
H = [1 0 0 0; 0 1 0 0];
ALPHA = 0.99;


%% --------------------------------------------------------------------- %
% Exercise 10.1: Getting Started, Plot Observations Sequences
% ---------------------------------------------------------------------- %

% Read in log file
if exist('dataobs3.mat','file'),
  load('dataobs3');
else
  disp('Error: data set file not found!');
  break;
end;

% Plot all tracks
% Your code...




%% --------------------------------------------------------------------- %
% Exercise 10.2: Main loop
% ---------------------------------------------------------------------- %


% Your code...
%for istep = ...
 
  % 1. Predict all states and measurements
  % Your code...
  
  % 2. Get valid observations in current step
  % Your code...
  
  % 3. Match observations with tracks using the NNSF
  %if (ntracks > 0) && (nobs > 0),
  %  [tracks,obs] = matchnnsf(tracks,obs,ALPHA);
  %end;

  % Update tracks 
  % Your code...

  % Initialize new tracks with non-matched observations
  % Your code...
  
  % Update track histories
  % Your code...
  
%end;



%% Plot histories

% Your code...


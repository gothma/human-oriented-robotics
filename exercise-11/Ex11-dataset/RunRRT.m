%% Basic RRT algorithm
% This script demonstrates the basic funcionalities of RRT for a wheeled
% nonholonomic differential drive robot. Motion primivites are used as extend
% function, they are generated using the ODE command.
% The kinematics is described in the script unicyclekinematics.m
% v.1.0, Feb 2014, Luigi Palmieri, Social Robotic Lab Freiburg
%
% The tree is an array of struct with vertices defined as follows:
%   v.id    -- ID of the vertex
%   v.pid   -- parent ID
%   v.pose  -- Pose of the vertex
%   v.edgeq -- edge where to save intermediate configurations
%   v.edgeu -- edge where to save intermediate controls u

clear all; clc;
% Add librobotics to your path
addpath('... your path .../librobotics');

% Set random seed
rng(11,'twister');

% Parameters
ROBOTRADIUS = 0.2;          % Radius (not diameter!) of circular robot in [m]
LIMITS = [0 5 0 5 0 2*pi];  % lower and upper limits of C-space in [m,m,rad]
GOALRADIUS = 0.3;           % radius of the goal region in [m]
DT = 0.2;                   % Delta time for integration of primitives
MOTIONPRIMITIVES = [1 0.0; 1 2; 1 -2];   % (v,omega)-control pairs

% Initial and goal configurations
qinit = [2; 1; 0];   % initial pose
qgoal = [0.8; 1.6; 0];   % goal pose


% ----------------------------------------------- %
% Exercise 11.1: Plot environment
% ----------------------------------------------- %
figure(1); clf; hold on; box on; axis equal;
axis([LIMITS(1)-0.5 LIMITS(2)+0.5 LIMITS(3)-0.5 LIMITS(4)+0.5]);

% Your code...

% plot initial pose and goal region
% Your code...


% ----------------------------------------------- %
% Exercise 11.2: RRT Steps
% ----------------------------------------------- %

% 11.2.a) Initialize tree with qinit
% Your code...


% Main loop
% Your code...

  % 11.2.b) Sample new configuration and check collision
  qrand = sampleconfiguration(LIMITS);
  
  checkcollision(qrand,ROBOTRADIUS,obstacles),

    % 11.2.c) Find nearest vertex
    qnear = findnearestvertex(tau,qrand);
    
    % 11.2.d) Extend and check collisions on the edge
    qnew = extend(qnear,qrand,MOTIONPRIMITIVES,DT);
    
      checkedgecollision(qnew,ROBOTRADIUS,obstacles),
      
      % Save qnew in the tree
      % Your code...
      
      % Plot the new edge
      % Your code...

      drawnow;
      
      % 11.2.e) Check if goal reached
      % Your code...

% end main loop 

% 11.2.e) Extract path and controls
% Your code...


% ----------------------------------------------- %
% 11.3 Plot path and velocities
% ----------------------------------------------- %
     
% Your code...
  
figure(2); clf;
  
% Your code...




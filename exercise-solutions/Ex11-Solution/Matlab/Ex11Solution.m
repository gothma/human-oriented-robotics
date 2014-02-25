% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Luigi Palmieri and Kai O. Arras
% This script demonstrates the basic funcionalities of RRT for a wheeled
% nonholonomic differential drive robot. Motion primivites are used as extend
% function, they are generated using the ODE command.
% The kinematics is described in the script unicyclekinematics.m
% The tree is an array of struct with vertices defined as follows:
%   v.id    -- ID of the vertex
%   v.pid   -- parent ID
%   v.pose  -- Pose of the vertex
%   v.edgeq -- edge where to save intermediate configurations
%   v.edgeu -- edge where to save intermediate controls u

clear all; clc;
addpath('~/SRL/research/lib/librobotics');

% Set random seed
rng(9,'twister');

% Parameters
ROBOTRADIUS = 0.2;          % Radius (not diameter!) of circular robot in [m]
LIMITS = [0 5 0 5 0 2*pi];  % lower and upper limits of C-space in [m,m,rad]
GOALRADIUS = 0.3;           % radius of the goal region in [m]
DT = 0.1;                   % Delta time for integration of primitives
MOTIONPRIMITIVES = [1 0.0; 1 -3; 1 3];   % (v,omega)-control pairs

% Initial and goal configurations
qinit = [2; 1; 0];   % initial pose
qgoal = [0.8; 1.6; 0];   % goal pose


% ----------------------------------------------- %
% Exercise 11.1: Plot environment
% ----------------------------------------------- %
figure(1); clf; hold on; box on; axis equal;
axis([LIMITS(1)-0.5 LIMITS(2)+0.5 LIMITS(3)-0.5 LIMITS(4)+0.5]);

obstacles = load('environment.txt');
nobs = size(obstacles,1);

angles = linspace(0,2*pi,100);
for i = 1:nobs,
  x = obstacles(i,1) + obstacles(i,3)*cos(angles);
  y = obstacles(i,2) + obstacles(i,3)*sin(angles);
  fill(x,y,[.4 .4 .4],'EdgeColor','none');
end;

% plot initial and goal poses
drawrobot(qinit,'k',1,2*ROBOTRADIUS,2*ROBOTRADIUS);
drawellipse(qgoal,GOALRADIUS,GOALRADIUS,'g');


% ----------------------------------------------- %
% Exercise 11.2: RRT Steps
% ----------------------------------------------- %

% 11.2.a) Initialize tree with qinit
tau(1).id = 1;
tau(1).pose = qinit;
tau(1).edgeq = [];
tau(1).edgeu = [];
tau(1).pid = 0;
nvertices = 1;

% Main loop
goalfound = false;
while ~goalfound,
  
  % 11.2.b) Sample new configuration and check collision
  qrand = sampleconfiguration(LIMITS);
  
  if ~checkcollision(qrand,ROBOTRADIUS,obstacles),
    hrand = plot(qrand(1),qrand(2),'r+','MarkerSize',16);
    
    % 11.2.c) Find nearest vertex
    qnear = findnearestvertex(tau,qrand);
    hnear = plot(qnear.pose(1),qnear.pose(2),'m.','MarkerSize',25);
    
    % 11.2.d) Extend and check collisions on the edge
    qnew = extend(qnear,qrand,MOTIONPRIMITIVES,DT);
    hedge = plot(qnew.edgeq(:,1),qnew.edgeq(:,2),'-','LineWidth',2);
    
    if ~checkedgecollision(qnew,ROBOTRADIUS,obstacles),
      
      % Save qnew in the tree
      nvertices = nvertices + 1;
      tau(nvertices).id = nvertices;
      tau(nvertices).pose = qnew.pose;
      tau(nvertices).edgeq = qnew.edgeq;
      tau(nvertices).edgeu = qnew.edgeu;
      tau(nvertices).pid = qnew.pid;
      
      % Plot the new edge
      plot(qnew.edgeq(:,1),qnew.edgeq(:,2),'-','LineWidth',2);
      drawnow;
      
      % 11.2.e) Check if goal reached
      if norm(qnew.pose(1:2)-qgoal(1:2)) < GOALRADIUS,
        disp('Goal reached!!!')
        goalfound = true;
      end
     
    else
      set(hedge,'Color','r');
    end;
    drawnow;
    delete([hrand hnear]);
    if exist('hedge','var'), delete(hedge); end;
  end; % if checkcollision
end; % while

% 11.2.e) Extract path and controls
[p,u] = extractpath(qnew,tau);


% ----------------------------------------------- %
% 11.3 Plot path and velocities
% ----------------------------------------------- %
if goalfound,
  npoints = size(p,1);
  for i = 1:20:npoints
    drawrobot(p(i,:),[0.7 0.2 0],1,2*ROBOTRADIUS,2*ROBOTRADIUS);
  end
  
  figure(2); clf;
  nc = size(u,1);
  
  subplot(2,1,1); plot(1:nc,u(:,1),'.-');
  axis([1 nc min(u(:,1))-0.2 max(u(:,1))+0.2]);
  title('translational robot velocity v');
  
  subplot(2,1,2); plot(1:nc,u(:,2),'.-');
  axis([1 nc min(u(:,2))-0.2 max(u(:,2))+0.2]);
  title('angular robot velocity omega');
end;

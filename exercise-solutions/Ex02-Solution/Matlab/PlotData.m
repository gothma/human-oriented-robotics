% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Timm Linder



%% 2.4 (c) (d-e)

% Optionally but safe: clear global variables
clear xrange bins;

% Define x range and histogram bins
NBINS = 100;   % vary number of bins here
xrange = linspace(-5,20,NBINS); 
bins = histc(data,xrange,1);

% Normalize and verify
for i = 1:size(data,2),
  bins(:,i) = bins(:,i) ./ sum(bins(:,i),1); 
end
sum(bins,1)

% Plot data
figure(1); clf;
stylestr = '.-';
plot(xrange,bins(:,1),stylestr,xrange,bins(:,2),stylestr,...
  xrange,bins(:,3),stylestr,xrange,bins(:,4),stylestr,...
  xrange,bins(:,5),stylestr)
legend('data1', 'data2', 'data3', 'data4', 'data5');
axis tight;

% Plot columns 3 and 4 into separate windows using the bar command
figure(2); clf;
bar(xrange,bins(:,4));
axis tight;

figure(3); clf;
bar(xrange,bins(:,3));
axis tight;
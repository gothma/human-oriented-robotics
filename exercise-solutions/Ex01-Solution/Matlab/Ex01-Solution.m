% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: koa

% ---------------- %
% Exercise 1.1     %
% ---------------- %

%addpath('... your path .../librobotics');


% ---------------- %
% Exercise 1.2     %
% ---------------- %

%1.2.a
a = [1 2 3 4 5]
b = [0; 1; 3; 6; 10]
a'
b'
cumsum(a)
diff(b)

%1.2.b
%a*a
% Explanation:
% Inner dimension mismatch. Doesn't work in linear algebra, doesn't work in Matlab
a.*a
a.^3
a*b
M = b*a

%1.2.c
whos

%1.2.d
M(2,:)
M(:,4)
M([1 3 5],3:end)

%1.2.e
inv(M)
% Explanations:
% - the row space of M is spanned by linearly dependent vectors OR
% - compute det(M) and verify that the determinant of a singular matrix is zero

%1.2.f
M(M>9) = -1

%1.2.g
size(a)
size(b)
size(M)
size(M,1)
size(M,2)
ones(size(M))
randn(size(M))


% ---------------- %
% Exercise 1.3     %
% ---------------- %

%1.3.a & 1.3.c
x = linspace(-4,4,200);
figure(1); clf;
plot(x,sin(x),'-',x,cos(x),'--',x,atan(x),'-.',x,x+0.3*x.^2-0.05*x.^3,':')

%1.3.b
title('function plots')
xlabel('x')
ylabel('y')
legend('sin','cos','atan','polynomial')



% ---------------- %
% Exercise 1.4     %
% ---------------- %

%1.4.a
%See function plotcircle.m

%1.4.b
%See script PlotCircleDemo.m


% ---------------- %
% Exercise 1.5     %
% ---------------- %
clear;   % Start with a clean workspace

% Define constants
MAXRANGE = 7.5;
THRESH = 0.35;
MINNPOINTS = 3;

%1.5.a Read in data
scan = load('scan.txt');
phi = scan(:,1)';
rho = scan(:,2)';

%1.5.b Delete maxrange readings
imaxrange = find(rho > MAXRANGE);
phi(imaxrange) = [];
rho(imaxrange) = [];

%1.5.a Convert to Cartesian coordinates
[x, y] = pol2cart(phi,rho);

%1.5.a Plot scan
figure(2); clf; box on;
plot(x,y,'.-');
axis equal;

%1.5.c Find break points in scan
rhodiff = diff(rho);
ifdiff = (abs(rhodiff) > THRESH);
ibreaks = find(ifdiff);

% 1.5.d
% Combine segment start and end indices into same vector,
% then pad with first and last index 
% (That's just one approach...)
isegs = sort([1 ibreaks ibreaks+1 length(x)]);

% Built segments data structure
j = 1;
for i = 1:2:length(isegs),
  ibeg = isegs(i);
  iend = isegs(i+1);
  ivec = ibeg:iend;
  %1.5.f Skip segments smaller than MINNPOINTS
  if length(ivec) > MINNPOINTS,
    segments(j).id = j;
    segments(j).is = ibeg;
    segments(j).ie = iend;
    points = [x(ivec); y(ivec)];
    segments(j).points = points;
    segments(j).xm = mean(points,2);
    j = j + 1;
  end;
end;

%1.5.e Plot segments
figure(3); clf; box on; hold on;
for i = 1:length(segments),
  plot(segments(i).points(1,:),segments(i).points(2,:),'.','MarkerSize',20,'Color',rand(3,1));
  text(segments(i).xm(1),segments(i).xm(2),int2str(segments(i).id));
end;
axis equal;
title('Segmented scan');


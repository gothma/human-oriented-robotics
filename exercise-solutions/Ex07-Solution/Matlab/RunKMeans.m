%% RunKmeans.m
% Solution to the Exercise 7 K-Means Clustering:
% - in this script you find the solution to the Exercise 7.1
% - the assignment and update steps of points 7.1.a and 7.1.b are in the
% kMeansStep.m function
% 
% - the solution to 7.2.a, we compute the J objective function (computeJ.m) 
% and plot in each iteration i


%% clear everything
clear all;

% Flag to save the frames in a directory
RECORD = 0;
RNDSEED = 0;
SEED = 132;
PTSSIZE = 50;
B = 0.1;

% Number of Clusters
INITMETHOD = 3;
K = 15;

% ----- Write preamble
disp('k-Means:');
disp('--------');

% ----- Define data set
datasetname = 'R15.txt';
%datasetname = 'five-clusters.txt';
%datasetname = 'aggregation.txt';

dataset = load(datasetname);




[n,m] = size(dataset);
disp(['Dataset: ',datasetname]);
disp(['- nsamples = ',int2str(n)]);



% ----- Determine random seed
if RNDSEED,
  rndvec = randperm(100);
  rndseed = rndvec(1);
else
  rndseed = SEED;
end;
rand('twister',rndseed);


% ----- Compute folds
ivec = randperm(n);
ivectrain = ivec(1:ceil(2*n/3));
ivectest  = ivec(ceil(2*n/3)+1:end);
trainset = dataset(ivectrain,:);
testset  = dataset(ivectest,:);

% ----- k-Means


% Trainset used to learn the Clusters
X=trainset(:,1:end-1);
% Range of the Data
Xmin=min(X);
Xmax=max(X);

[N,D] = size(X);

% Set the initial position of the centroids
clear centroids;
if INITMETHOD == 1,
  % Manual definition
  centroids=0.1*ones(K,D);
elseif INITMETHOD == 2,
  % Draw random position in feature space
  for i = 1:K
    centroids(i,:)=rand(1,D).*(Xmax-Xmin)+Xmin;
  end;
elseif INITMETHOD == 3,
  % Draw random data point from X
  icrnd = randperm(N);
  icrnd = icrnd(1:K);
  centroids = X(icrnd(1:K),:);
end;


% Plot initial centroids
figure(1); clf; hold on; box on; axis equal;
set(gca,'XTick',[],'YTick',[]);
set(gca,'Position',[0.02 0.02 0.97 0.96]);
cmap = hsv(K);

hp = scatter(X(:,1),X(:,2),PTSSIZE,'b','filled');
hc = plot(centroids(:,1),centroids(:,2),'+k','MarkerSize',18,'LineWidth',4);
avec = axis; axis([avec(1)-B avec(2)+B avec(3)-B avec(4)+B]);



% Main loop
i = 0;
j=1;
terminate = false;
estep = true;
while ~terminate,
  
  pause(0.1);
  if RECORD,
    fname = sprintf('images/kmeansFigures/frame%03d',i);
    print('-dpng','-r120',fname);
  end;
  
  if i == 0,
    delete([hp; hc]);
  elseif estep,
    delete([hp; hc; hv]);
  end; 
  
  if estep,
    % E-Step
  % Run KMeans Algorithm

    [labels,newcentroids] = kMeansStep(X,K,centroids);
  % Compute the J objective function
    J(j)=computeJ(X,K,newcentroids,labels);
 
 % plot J value over the iterations   
    figure(10),hold on, plot(j,J(j),'*r'),title('J value'), xlabel('iterations')
 % Upload end-condition
  
    delta = norm(newcentroids-centroids);
    j=j+1;
 
    figure(1)
    if K > 2,
      hv = voronoi(centroids(:,1),centroids(:,2));
      set(hv,'Color',[.3 .3 .3]); set(gca,'XTick',[],'YTick',[]);
    end
    hp = scatter(X(:,1),X(:,2),PTSSIZE,labels,'filled');
    hc = plot(centroids(:,1),centroids(:,2),'+k','MarkerSize',18,'LineWidth',4);
    estep = false;
  
  
  else
    % M-Step
    hpv = findobj(hv,'Marker','.'); hv = findobj(hv,'LineStyle','-'); delete([hc; hpv]);
    hc = plot(newcentroids(:,1),newcentroids(:,2),'+k','MarkerSize',18,'LineWidth',4);
    estep = true;
  end;
  
  
  % Check end Condition
   
  if delta <= 0,
    terminate = true;
  else
    i = i + 1;
    centroids = newcentroids;
  end;
end


% figure(1),legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Location','NW')
disp('centroid positions:')
centroids
disp('Needed steps:')
i



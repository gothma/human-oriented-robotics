%% RunKmeansjev.m
%  based on the RunKMeans.m this script plot the value of J with different
%  K's.
%



%% clear everything
clear all;
close all;

% Flag to save the frames in a directory
RECORD = 0;
RNDSEED = 0;
SEED = 123;
PTSSIZE = 50;
B = 0.1;
VISUALIZE=1;

% Number of Clusters
INITMETHOD = 3;


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
ivectrain = ivec(1:n);
trainset = dataset(ivectrain,:);

% ----- k-Means


% Trainset used to learn the Clusters
X=trainset(:,1:end-1);
% Range of the Data
Xmin=min(X);
Xmax=max(X);

[N,D] = size(X);


% set the intial and final value of K and the step to increase its value
finalK=10;
initK=3;
stepK=1;
Jsteps=1;
Kv=initK:stepK:finalK;


for K=initK:stepK:finalK

    
    j=1;
    
    
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
    if(VISUALIZE)
        figure(1); clf; hold on; box on; axis equal;
        set(gca,'XTick',[],'YTick',[]);
        set(gca,'Position',[0.02 0.02 0.97 0.96]);
        cmap = hsv(K);
        
        hp = scatter(X(:,1),X(:,2),PTSSIZE,'b','filled');
        hc = plot(centroids(:,1),centroids(:,2),'+k','MarkerSize',18,'LineWidth',4);
        avec = axis; axis([avec(1)-B avec(2)+B avec(3)-B avec(4)+B]);
    end
    
    
    
    % Main loop
    i = 0;
    
    terminate = false;
    estep = true;
    while ~terminate,
        
        pause(0.1);
        if RECORD,
            fname = sprintf('images/kmeansFigures/frame%03d',i);
            print('-dpng','-r120',fname);
        end;
        if(VISUALIZE)
            if i == 0,
                delete([hp; hc]);
            elseif estep,
                delete([hp; hc; hv]);
            end;
        end
        
        
        
        % E-Step
        if estep,
            
            % Run KMeans Algorithm
           [labels,newcentroids] = kMeansStep(X,K,centroids);
            % Compute the J objective function
           J(j)=computeJ(X,K,newcentroids,labels);
           
           
          delta = norm(newcentroids-centroids);
          j=j+1;
            
         if(VISUALIZE)
                if K >= 2,
                    hv = voronoi(centroids(:,1),centroids(:,2));
                    set(hv,'Color',[.3 .3 .3]); set(gca,'XTick',[],'YTick',[]);
                end
                                
                hp = scatter(X(:,1),X(:,2),PTSSIZE,labels,'filled');
                hc = plot(centroids(:,1),centroids(:,2),'+k','MarkerSize',18,'LineWidth',4);
         end
            estep = false;
        else
            
            % M-Step
            if(VISUALIZE)
                hpv = findobj(hv,'Marker','.'); hv = findobj(hv,'LineStyle','-'); delete([hc; hpv]);
                hc = plot(newcentroids(:,1),newcentroids(:,2),'+k','MarkerSize',18,'LineWidth',4);
            end
            
            estep = true;
        end;
        
        
        % Condition to Terminate the K-means Algorithm
        if delta <= 0,
            terminate = true;
        else
            i = i + 1;
            centroids = newcentroids;
        end;
        
    end

    
    % For each K save the last value of J
    Js(Jsteps)=J(end);
    Jsteps=Jsteps+1;
end



figure(3),hold on, box on, plot(Kv,Js,'.-'),title('J Values'),xlabel('K Value')


disp('centroid positions:')
centroids
disp('Needed steps:')
i


% question 7.2 c)
% It is an open question. J is similar to the BIC measure. Only J is
% insufficient to choose the right value of K. We can use it as a likelihood 
% estimate but then we need to add a model complexity term as it is in the
% BIC formula, see slides 38/39 on Unsupervised Learning. 
% we could rewrite the BIC as
% BIC(M|D) = J-p/2*log(N)




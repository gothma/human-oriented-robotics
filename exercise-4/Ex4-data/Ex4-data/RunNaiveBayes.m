% Script that runs and evaluates the Naive Bayes classifier
% Definition: data sets are in format x1 x2 ... xn y with label y being {-1,1}

clear;
RNDSEED = 0;

% ----- Write preamble
disp('Naive Bayes:');
disp('------------');

% ----- Define data set
datasetname = 'peopleofficedata.txt';
dataset = load(datasetname);

[n m] = size(dataset);
disp(['Dataset: ',datasetname]);
disp(['- nsamples = ',int2str(n)]);


% ----- Initialize random number generator
if RNDSEED,
  rndseed = rndvec(1);
else
  rndseed = 11;
end;
rand('twister',rndseed);


% ----- Build test / training set


% ----- Learn and classify
disp('Classifying...');
C = classifynaivebayes(trainset,testset);


% ----- Display results









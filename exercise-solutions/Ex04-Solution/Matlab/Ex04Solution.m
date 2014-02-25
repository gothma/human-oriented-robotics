%% --------------------------------------------------------------
% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal, Kai Arras
%% --------------------------------------------------------------

% Script that runs and evaluates the Naive Bayes classifier
% Definition: data sets are in format x1 x2 ... xn y with label y being {-1,1}

clear;
RESULTFILE = 0;
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

% ----- Determine random seed
if RNDSEED,
  rndvec = randperm(100);
  rndseed = rndvec(1);
else
  rndseed = 11;
end;
rand('twister',rndseed);

% ----- Compute folds
ivec = randperm(n);
ivectrain = ivec(1:ceil(2*n/3));
ivectest  = ivec(ceil(2*n/3)+1:end);
trainset = dataset(ivectrain,:);
testset  = dataset(ivectest,:);

sumpostrain = sum(trainset(:,end) ==  1);
sumnegtrain = sum(trainset(:,end) == -1);
sumpostest  = sum(testset(:,end) ==  1);
sumnegtest  = sum(testset(:,end) == -1);
if n ~= (sumpostrain+sumnegtrain+sumpostest+sumnegtest),
  disp('Warning: dataset contains unknown labels');
end;

% ----- Learn and classify
disp('Classifying...');
C = classifynaivebayes(trainset,testset);

% ----- Evaluate (using the standard metrics)
tp = C(1,1); fp = C(1,2);
fn = C(2,1); tn = C(2,2);
npos = tp + fn;
nneg = fp + tn;
tp100 = tp*100/npos;
fp100 = fp*100/nneg;
fn100 = fn*100/npos;
tn100 = tn*100/nneg;
accuracy = (tp + tn) / (npos + nneg);
errorrate = 1 - accuracy;
tprate = tp/npos;
fprate = fp/nneg;
precision = tp / (tp + fp);
recall = tp / (tp + fn);
beta = 1;
fmeasure = ((1+beta)^2 * recall * precision) / (beta^2 * recall + precision);

% ----- Display results
disp('Results');
disp(['- training set: npos = ',int2str(sumpostrain),', nneg = ',int2str(sumnegtrain)]);
disp(['- validate set: npos = ',int2str(sumpostest),', nneg = ',int2str(sumnegtest)]);
disp(['- tp = ',int2str(tp),' (',num2str(tp100,3),'%)']);
disp(['- fp = ',int2str(fp),' (',num2str(fp100,3),'%)']);
disp(['- fn = ',int2str(fn),' (',num2str(fn100,3),'%)']);
disp(['- tn = ',int2str(tn),' (',num2str(tn100,3),'%)']);
disp(['- accuracy = ',num2str(accuracy,4),', errorrate = ',num2str(errorrate,4)]);
disp(['- tprate = ',num2str(tprate,4),', fprate = ',num2str(fprate,4)]);
disp(['- precision = ',num2str(precision,4),', recall = ',num2str(recall,4)]);
disp(['- fmeasure = ',num2str(fmeasure,4)]);


% ----- Write results and parameters into file
if RESULTFILE,
  resultfilename = strcat('NaiveBayes',datestr(now,'yymmmddtHHMMSS'),'.m');
  fid = fopen(resultfilename,'w');
  fprintf(fid,'%% Naive Bayes result file\n');
  fprintf(fid,'%% -----------------------\n');
  fprintf(fid,'%% Date and time %s\n',datestr(now));
  fprintf(fid,'\n%% Classifier parameters\n');
  fprintf(fid,'datasetname = ''%s'';\n',datasetname);
  fprintf(fid,'rndseed = %d;\n',rndseed);
  fprintf(fid,'\n%% Results\n');
  fprintf(fid,'tp = %6.3f;\nfp = %6.3f;\nfn = %6.3f;\ntn = %6.3f;\n',tp,fp,fn,tn);
  fprintf(fid,'tp100 = %12.10f;\nfp100 = %12.10f;\nfn100 = %12.10f;\ntn100 = %12.10f;\n',tp100,fp100,fn100,tn100);
  fprintf(fid,'accuracy = %12.10f;\nerrorrate = %12.10f;\n',accuracy,errorrate);
  fprintf(fid,'tprate = %12.10f;\nfprate = %12.10f;\n',tprate,fprate);
  fprintf(fid,'precision = %12.10f;\nrecall = %12.10f;\nfmeasure = %12.10f;\n',precision,recall,fmeasure);
  fclose(fid);
  disp(['Results written to ',resultfilename]); disp(' ');
end;








% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal

% Script that runs and evaluates the k-NN classifier
% Definition: data sets are in format x1 x2 ... xn y with label y being {-1,1}

clear;
RESULTFILE = 0;
COMMENT = 'Regular k-NN';
RNDSEED = 0;

% ----- k-NN parameters
k = 31;
distmethod = 'l1norm';  % Options: l1norm, l2norm, linfnorm

% ----- Write preamble
disp('k-Nearest Neighbor:');
disp('-------------------');

% ----- Define data set
%datasetname = 'peopleofficedata.txt';
datasetname = 'circular.txt';
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
ivectest = ivec(ceil(2*n/3)+1:end);
trainset = dataset(ivectrain,:);
testset  = dataset(ivectest,:);

sumpostrain = sum(trainset(:,end) ==  1);
sumnegtrain = sum(trainset(:,end) == -1);
sumpostest  = sum(testset(:,end) ==  1);
sumnegtest  = sum(testset(:,end) == -1);
if n ~= (sumpostrain+sumnegtrain+sumpostest+sumnegtest),
  disp('Warning: dataset contains unknown labels');
end;

% ----- Classify
disp('Classifying...');
C = classifyknn(trainset,testset,k,distmethod);

% ----- Evaluate
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
disp(['- k = ',int2str(k)]);
disp(['- distmethod: ',distmethod]);
disp(['- training set: npos = ',int2str(sumpostrain),', nneg = ',int2str(sumnegtrain),]);
disp(['- test set    : npos = ',int2str(sumpostest),', nneg = ',int2str(sumnegtest),]);
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
  resultfilename = strcat('kNNrun',datestr(now,'yymmmddtHHMMSS'),'.m');
  fid = fopen(resultfilename,'w');
  fprintf(fid,'%% k-NN result file\n');
  fprintf(fid,'%% ----------------\n');
  fprintf(fid,'%% Date and Time %s\n',datestr(now));
  fprintf(fid,'%% Remark: %s\n',COMMENT);
  fprintf(fid,'\n%% Parameters\n');
  fprintf(fid,'datasetname = ''%s'';\n',datasetname);
  fprintf(fid,'distmethod = ''%s'';\n',distmethod);
  fprintf(fid,'k = %d;\n',k);
  fprintf(fid,'rndseed = %d;\n',rndseed);
  fprintf(fid,'\n%% Results\n');
  fprintf(fid,'tp = %d;\nfp = %d;\nfn = %d;\ntn = %d;\n',tp,fp,fn,tn);
  fprintf(fid,'tp100 = %15.12f;\nfp100 = %15.12f;\nfn100 = %15.12f;\ntn100 = %15.12f;\n',tp100,fp100,fn100,tn100);
  fprintf(fid,'accuracy = %15.12f;\nerrorrate = %15.12f;\n',accuracy,errorrate);
  fprintf(fid,'tprate = %15.12f;\nfprate = %15.12f;\n',tprate,fprate);
  fprintf(fid,'precision = %15.12f;\nrecall = %15.12f;\nfmeasure = %15.12f;\n',precision,recall,fmeasure);
  fclose(fid);
  disp(['Results written to ',resultfilename]); disp(' ');
end;








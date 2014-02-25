function [C, svmmodel] = classifysvm(trainingdata,testdata,kernel,C,varargin)

class1label =  1;
class2label = -1;

% learn SVM
figure(2);
if strcmp(kernel,'rbf') && (nargin == 5),
  sigma = varargin{1};
  svmm = svmtrain(trainingdata(:,1:end-1),trainingdata(:,end),...
    'Kernel_function','rbf','rbf_sigma',sigma,'boxconstraint',C,'autoscale',false,'showplot',false);
elseif strcmp(kernel,'linear'),
  svmm = svmtrain(trainingdata(:,1:end-1),trainingdata(:,end),...
    'Kernel_function','linear','boxconstraint',C,'autoscale',false, 'showplot',false);
elseif strcmp(kernel,'polynomial') && (nargin == 5),
  p = varargin{1};
  svmm = svmtrain(trainingdata(:,1:end-1),trainingdata(:,end),...
    'Kernel_function','polynomial','polyorder',p,'boxconstraint',C,'autoscale',false, 'showplot',false);
else
  error('Unknown kernel or wrong parameters');
end;

% Adapt data, copy into out variable
svmmodel.lambda = -abs(svmm.Alpha);  % needed to match SVM theory
svmmodel.bias = svmm.Bias;
svmmodel.supportvectorindices = svmm.SupportVectorIndices;

% test learned classifier
labels = svmclassify(svmm,testdata(:,1:end-1));

% Count fp, tp, fn, tn
tp = 0; fp = 0; fn = 0; tn = 0;
for i = 1:size(testdata, 1),
    if (labels(i) == class1label) && (testdata(i,end) == class1label),
        tp = tp + 1;
    elseif (labels(i) == class1label) && (testdata(i,end) == class2label),
        fp = fp + 1;
    elseif (labels(i) == class2label) && (testdata(i,end) == class1label),
        fn = fn + 1;
    elseif (labels(i) == class2label) && (testdata(i,end) == class2label),
        tn = tn + 1;
    else
        disp('I dont know what I am doing ')
    end;
end;

C = [tp fp; fn tn];

end
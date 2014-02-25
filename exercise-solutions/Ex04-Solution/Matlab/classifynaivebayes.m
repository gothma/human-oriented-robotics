%% --------------------------------------------------------------
% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal, Kai Arras
%% --------------------------------------------------------------

function C = classifynaivebayes(trainingdata,testdata)
% CLASSIFYNAIVEBAYES Naive Bayes Classifier (NBC)
% Input:
% 	trainingdata - x_i for all training samples
% 	testdata - y_i for all training samples
% Output:
% 	C - classification results (metrics)
%


nclasses = 2;
class1label =  1;
class2label = -1;
tp = 0; fp = 0;
fn = 0; tn = 0;

% ----- Learn classifier: MLE estimate feature distribution parameters
ivecpos = find(trainingdata(:,end) == class1label);
ivecneg = find(trainingdata(:,end) == class2label);

mu1 = mean(trainingdata(ivecpos,1:end-1),1);
var1 = std(trainingdata(ivecpos,1:end-1),0,1).^2;
mu2 = mean(trainingdata(ivecneg,1:end-1),1);
var2 = std(trainingdata(ivecneg,1:end-1),0,1).^2;

% ----- Class priors: uniform or learned
% Uniform priors
%prior1 = 1 / nclasses;
%prior2 = 1 / nclasses;
% Learning priors
ntrain = size(trainingdata,1);
prior1 = length(ivecpos) / ntrain
prior2 = length(ivecneg) / ntrain


% ------ Testing: 
n = size(testdata,1);
for i = 1:n,
  
  % Get query point
  q = testdata(i,1:end-1);

  % Compute class conditional probabilities (probability of feature value,
  % given the class) = f-dimensional vectors, where f is no. of features
  classCondProb1 = 1./sqrt(2*pi*var1).*exp((-(q-mu1).^2)./(2*var1));
  classCondProb2 = 1./sqrt(2*pi*var2).*exp((-(q-mu2).^2)./(2*var2));

  % Compute posteriors
  posterior1 = prod(classCondProb1) * prior1; 
  posterior2 = prod(classCondProb2) * prior2;
  
  % Determine label of q
  if posterior1 > posterior2,
    qlabel = class1label;
  else
    qlabel = class2label;
  end;

  % Count classification errors
  if (qlabel == class1label) && (testdata(i,end) == class1label),
    tp = tp + 1;
  elseif (qlabel == class1label) && (testdata(i,end) == class2label),
    fp = fp + 1;
  elseif (qlabel == class2label) && (testdata(i,end) == class1label),
    fn = fn + 1;
  elseif (qlabel == class2label) && (testdata(i,end) == class2label),
    tn = tn + 1;
  else
    disp('Naive Bayes classifier error. I should not be here')
  end;
    
  if mod(i,1000) == 0, disp(['- i = ',int2str(i),' of ',int2str(n)]); end;
end;
C = [tp fp; fn tn];


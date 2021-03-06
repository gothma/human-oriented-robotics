function C = classifynaivebayes(trainingdata,testdata)
% trainingdata and testdata are matrices with one training sample per row,
% one column per feature, and the class label (-1 / +1) in the last column.

% Initialization
class1label =  1;
class2label = -1;
tp = 0; fp = 0;
fn = 0; tn = 0;

trainingc1 = trainingdata(trainingdata(:,end) == class1label, 1:end-1);
trainingc2 = trainingdata(trainingdata(:,end) == class2label, 1:end-1);

% ----- Learn classifier: estimate feature distribution parameters
mu1 = mean(trainingc1); 
mu2 = mean(trainingc2);

var1 = var(trainingc1,1); 
var2 = var(trainingc2,1);

priorclass1 = size(trainingc1,1)/ size(trainingdata,1)
priorclass2 = size(trainingc2,1)/ size(trainingdata,1)


% ------ Apply classifier to testdata: 
n = size(testdata,1);
for i = 1:n,
  
  % Get query point
  q = testdata(i,1:end-1);

  % Inference
  classCondProb1 = 1 ./sqrt(2*pi*var1).*exp((-(q-mu1).^2)./(2*var1));
  classCondProb2 = 1 ./sqrt(2*pi*var2).*exp((-(q-mu2).^2)./(2*var2));
  

  % Determine label of q
  class1 = log(priorclass1) + sum(log(classCondProb1));
  class2 = log(priorclass2) + sum(log(classCondProb2));
  if (class1 > class2)
      classlabel = class1label;
  else
      classlabel = class2label;
  end

  % Count classification errors
  % (increment tp, fp, fn, tn depending on the classification result)
  groundtruth = testdata(i, end);
  
  if (classlabel == class1label)
      if (classlabel == groundtruth)
          tp = tp + 1;
      else
          fp = fp + 1;
      end
  else
      if (classlabel == groundtruth)
          tn = tn + 1;
      else
          fn = fn + 1;
      end
  end
  
    
  if mod(i,1000) == 0, disp(['- i = ',int2str(i),' of ',int2str(n)]); end;
end;

C = [tp fp; fn tn];


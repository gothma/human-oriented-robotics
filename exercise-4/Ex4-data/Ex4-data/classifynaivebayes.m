function C = classifynaivebayes(trainingdata,testdata)
% trainingdata and testdata are matrices with one training sample per row,
% one column per feature, and the class label (-1 / +1) in the last column.

% Initialization
class1label =  1;
class2label = -1;
tp = 0; fp = 0;
fn = 0; tn = 0;

% ----- Learn classifier: estimate feature distribution parameters



% ------ Apply classifier to testdata: 
n = size(testdata,1);
for i = 1:n,
  
  % Get query point
  q = testdata(i,1:end-1);

  % Inference

  % Determine label of q
  

  % Count classification errors
  % (increment tp, fp, fn, tn depending on the classification result)
    
  if mod(i,1000) == 0, disp(['- i = ',int2str(i),' of ',int2str(n)]); end;
end;

C = [tp fp; fn tn];


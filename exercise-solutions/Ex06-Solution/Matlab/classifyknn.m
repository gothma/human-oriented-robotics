function C = classifyknn(trainingdata,testdata,k,distmethod)

class1label =  1;
class2label = -1;
tp = 0; fp = 0;
fn = 0; tn = 0;


% ----- Learn kNN classifier
% there is no learning in kNN


% ----- Test kNN classifier
n = size(testdata,1);
for i = 1:n,
  
  % Get query point
  q = testdata(i,1:end-1);
  
  % Compute distances from query point to all instances
  switch distmethod,
    case 'l1norm',
      distances = calcl1norm(trainingdata(:,1:end-1),q);
    case 'l2norm',
      distances = calcl2norm(trainingdata(:,1:end-1),q);
    case 'linfnorm',
      distances = calclinfnorm(trainingdata(:,1:end-1),q);
    otherwise,
      disp('Error: unknown distance method');
  end;
  
  % Get k nearest neighbors
  [dsorted indices] = sort(distances,'ascend');
  isorted = indices(1:k);
  gtlabels = trainingdata(isorted,end);
  
  % Determine label of q
  nclass1 = sum(gtlabels == class1label);
  nclass2 = sum(gtlabels == class2label);
  if nclass1 > nclass2,
    qlabel = class1label;
  elseif nclass1 < nclass2,
    qlabel = class2label;
  else 
    disp('Warning: kNN has a tie, taking class1label');
    qlabel = class1label;
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
    disp('kNN error. I should not be here')
  end;
    
  if mod(i,1000) == 0, disp(['- i = ',int2str(i),' of ',int2str(n)]); end;
end;

C = [tp fp; fn tn];
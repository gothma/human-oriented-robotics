% Course Human-Oriented Robotics
% Social Robotics Lab
% University of Freiburg, Germany
% Lecturer: Prof. Kai Arras
% Lab Instructors: Timm Linder, Billy Okal, Luigi Palmieri
% (c) SRL 2014
% Author of this exercise: Billy Okal

% Script that runs and evaluates the SVN classifier using K-fold
% cross-validation over the k parameter and the distance function
% Definition: data sets are in format x1 x2 ... xn y with label y being {-1,1}

clear;
RESULTFILE = 0;
RNDSEED = 0;


% ----- Cross-validation parameters
K = 5;

% ----- SVM parameters ranges
cvec = [ 50 150];
sigmavec = [1 2 ];
kernelvec= {'rbf';  'linear'} %, 'rbf', 'polynomial'


% ----- Write preamble
disp('SVM CV run:');
disp('--------------------------');

% ----- Define data set
%datasetname = 'peopleofficedata.txt';
datasetname = 'circular.txt';

dataset = load(datasetname);
[n m] = size(dataset);

% ----- Determine random seed
if RNDSEED,
    rndvec = randperm(100);
    rndseed = rndvec(1);
else
    rndseed = 11;
end;
rand('twister',rndseed);

% ----- Compute folds
% Step 1: randomly permute dataset
ivecrnd = randperm(n);
dataset = dataset(ivecrnd,:);

% Step 2: compute indices to split dataset into k folds
isplits = round(linspace(1,n+1,K+1));
cind=1
% Step 3: run K rounds
for k=1:length(kernelvec)
    
    for c = cvec,
        for rbfsigma = sigmavec
            
            r = struct([]);
            for i = 1:K,
                
                disp(' ');
                disp(['Round ',int2str(i),':']);
                disp('---------');
                
                % ----- Compose training and validation data sets
                ivectrain = [1:isplits(i)-1  isplits(i+1):n];
                ivecvalid = isplits(i):isplits(i+1)-1;
                trainset = dataset(ivectrain,:);
                validset = dataset(ivecvalid,:);
                
                sumpostrain = sum(trainset(:,end) ==  1);
                sumnegtrain = sum(trainset(:,end) == -1);
                sumposvalid = sum(validset(:,end) ==  1);
                sumnegvalid = sum(validset(:,end) == -1);
                if n ~= (sumpostrain+sumnegtrain+sumposvalid+sumnegvalid),
                    disp('Warning: dataset contains unknown labels');
                end;
                
                % ----- Classify
                disp('Classifying...');
                %       C = classifyknn(trainset,validset,k,distmethods{idist});
                
                kernel=kernelvec{k};
                [C, svmmodel] = classifysvm(trainset,validset,kernel,c,rbfsigma);
                
                % ----- Evaluate, compute measures
                r(i).tp = C(1,1); r(i).fp = C(1,2);
                r(i).fn = C(2,1); r(i).tn = C(2,2);
                npos = r(i).tp + r(i).fn;
                nneg = r(i).fp + r(i).tn;
                r(i).tp100 = r(i).tp*100/npos;
                r(i).fp100 = r(i).fp*100/nneg;
                r(i).fn100 = r(i).fn*100/npos;
                r(i).tn100 = r(i).tn*100/nneg;
                r(i).accuracy = (r(i).tp + r(i).tn) / (npos + nneg);
                r(i).errorrate = 1 - r(i).accuracy;
                r(i).tprate = r(i).tp/npos;
                r(i).fprate = r(i).fp/nneg;
                r(i).precision = r(i).tp / (r(i).tp + r(i).fp);
                r(i).recall = r(i).tp / (r(i).tp + r(i).fn);
                beta = 1;
                r(i).fmeasure = ((1+beta)^2 * r(i).recall * r(i).precision) / (beta^2 * r(i).recall + r(i).precision);
                
                % ----- Display results
                disp('Results');
                disp(['- C = ',int2str(c)]);
                disp(['- Kernel = ', kernel]);
                disp(['- rbfsigma: ',int2str(rbfsigma) ]);
                disp(['- training set: npos = ',int2str(sumpostrain),', nneg = ',int2str(sumnegtrain),', indices: 1-',int2str(isplits(i)-1),' and ',int2str(isplits(i+1)),'-',int2str(n)]);
                disp(['- validate set: npos = ',int2str(sumposvalid),', nneg = ',int2str(sumnegvalid),', indices: ',int2str(isplits(i)),'-',int2str(isplits(i+1)-1)]);
                disp(['- tp = ',int2str(r(i).tp),' (',num2str(r(i).tp100,3),'%)']);
                disp(['- fp = ',int2str(r(i).fp),' (',num2str(r(i).fp100,3),'%)']);
                disp(['- fn = ',int2str(r(i).fn),' (',num2str(r(i).fn100,3),'%)']);
                disp(['- tn = ',int2str(r(i).tn),' (',num2str(r(i).tn100,3),'%)']);
                disp(['- accuracy = ',num2str(r(i).accuracy,4),', errorrate = ',num2str(r(i).errorrate,4)]);
                disp(['- tprate = ',num2str(r(i).tprate,4),', fprate = ',num2str(r(i).fprate,4)]);
                disp(['- precision = ',num2str(r(i).precision,4),', recall = ',num2str(r(i).recall,4)]);
                disp(['- fmeasure = ',num2str(r(i).fmeasure,4)]);
                
            end;
            
            % ----- Compute averages over rounds
            tp = mean([r(:).tp]);
            fp = mean([r(:).fp]);
            fn = mean([r(:).fn]);
            tn = mean([r(:).tn]);
            tp100 = mean([r(:).tp100]);
            fp100 = mean([r(:).fp100]);
            fn100 = mean([r(:).fn100]);
            tn100 = mean([r(:).tn100]);
            accuracy = mean([r(:).accuracy]);
            errorrate = mean([r(:).errorrate]);
            tprate = mean([r(:).tprate]);
            fprate = mean([r(:).fprate]);
            precision = mean([r(:).precision]);
            recall = mean([r(:).recall]);
            fmeasure = mean([r(:).fmeasure]);
            
            %-- Write the results in the tables
            
            if(strcmp(kernel,'linear'))
                
                tableAccuracyLinear(cind,rbfsigma)=accuracy;
            else
                tableAccuracyRBF(cind,rbfsigma)=accuracy;
            end
            
            % ----- Write results and parameters into file
            if RESULTFILE,
                resultfilename = strcat('kNNCV',datestr(now,'yymmmddtHHMMSS'),'.m');
                fid = fopen(resultfilename,'w');
                fprintf(fid,'%% SVN CV result file\n');
                fprintf(fid,'%% -------------------\n');
                fprintf(fid,'%% Date and time %s\n',datestr(now));
                fprintf(fid,'\n%% K-fold cross-validation\n');
                fprintf(fid,'K = %d;\n',K);
                fprintf(fid,'\n%% Classifier parameters\n');
                fprintf(fid,'datasetname = ''%s'';\n',datasetname);
                fprintf(fid,'rbfsigma = ''%s'';\n',rbfsigma);
                fprintf(fid,'C = %d;\n',c);
                fprintf(fid,'Kernel = %d;\n',kernel);
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
            
        end;
        cind=cind+1
    end;
    
end

disp('Accuracy Tables: kernelType x Stiffness Parameter x RBFKernel')
tableAccuracyLinear
tableAccuracyRBF


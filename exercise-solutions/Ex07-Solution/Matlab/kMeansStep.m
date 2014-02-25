function [assigned,newCentroid] = kMeansStep(X,K,centroids)
%  X Data, N Vectors, D size of the vectors
%  K number of clusters
%
[N D] = size(X);


% Initial centroids
if all(all(centroids==0))
    disp('kMeansStep: Generate Random Centroids')
    centroids=X(randsample(N,K),:);
    [Nc Dc]=size(centroids);
else
    % disp('Reading initial Centroids')
    [Nc Dc]=size(centroids);
end


% Assign each data point to the closest centroid
% based on Euclidian Distance
assigned=[];
for i=1:N
    d=norm(X(i,:)-centroids(1,:))^2;
    minD=d;
    indCentr=1;
    for j=2:Nc
        d2=norm(X(i,:)-centroids(j,:))^2;
        if(d2<minD)
            indCentr=j;
            minD=d2;
        end
    end
    
    % Assign i-th data point to the closest centroid
    assigned = [assigned;indCentr];
end








% Move the centroid to the center of its cluster
newCentroid=zeros(K,D);
pointsInCluster=zeros(K,1);

for i=1:length(assigned),
    newCentroid(assigned(i,:),:)=newCentroid(assigned(i,:),:)+X(i,:);
    pointsInCluster(assigned(i,:),1)=pointsInCluster(assigned(i,:),1)+1;
end

for c = 1:K,
    if pointsInCluster(c,1) ~= 0,
        newCentroid(c,:)=newCentroid(c,:)/pointsInCluster(c,1);
    else
        
        % Singleton strategy: look for closest data point in X
        corphan = newCentroid(c,:);
        dEucl = sqrt(sum((X - repmat(corphan,N,1)).^2,2));
        [dmin imin] = min(dEucl);
        newCentroid(c,:) = X(imin,:);
        assigned(imin) = c;
        %newCentroid(c,:)=rand(1,D).*(Xmax-Xmin)+Xmin;
    end;
end;








end

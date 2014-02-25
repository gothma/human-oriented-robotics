function J=computeJ(X,K,centroids,assigned)

% Compute J
J=0;
for j=1:length(assigned)
    J=J+norm(X(j,:)-centroids(assigned(j),:))^2;
end
end

function [labels, means, J] = kmeans(data, K)


N = size(data, 1);
labels = zeros(N, 1);


% Pick first means+
s = RandStream('mt19937ar','Seed',0);
oracle = randperm(s, N);
means = data(oracle <= K, :);

oldnorm = norm(means) + 1;

J = [];

while (norm(means) ~= oldnorm)
    oldnorm = norm(means);
    disp(oldnorm);
    j = 0;
    % Assign labels
    for i = 1:N
        dists = means - repmat(data(i,:), K, 1);
        dists = dists .^2;
        dists = sum(dists, 2);
        [err, l] = min(dists);
        labels(i) = l;
        j = j + sqrt(err);
    end
    
    J = [J j];
    % Calculate means
    for k = 1:K
        means(k, :) = mean(data(labels == k, :));
    end
end

end
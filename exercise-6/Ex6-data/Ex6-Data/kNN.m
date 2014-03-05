function C = kNN(data)

    % Plot data
    hold on;
    positive = data(:, 3) > 0;
    negative = data(:, 3) < 0;
    scatter(data(positive, 1), data(positive, 2), 'r');
    scatter(data(negative, 1), data(negative, 2), 'g');
    
    % Divide into testing and training
    N = size(data, 1);
    oracle = randperm(N);
    test = data(oracle < N/3, :);
    train = data(oracle >= N/3, :);
    
    tp = 0;
    tn = 0;
    fp = 0;
    fn = 0;
    
    for sample = test'
        y = getClass(train, sample(1:2), 5);
        if y > 0
            if sample(3) > 0
                tp = tp + 1;
            else
                fp = fp + 1;
            end
        else
            if sample(3) > 0
                fn = fn + 1;
            else
                tn = tn + 1;
            end
        end       
    end
    
    C = [tp fp; fn tn];
end

function class = getClass(data, query, k)
    
    % Calculate all squared distances to the query
    dists = data(:,1:2) - repmat(query', size(data, 1), 1);
    sqDists = sum(dists .^ 2, 2);
    
    % Get minimal distances
    [~, ind] = sort(sqDists);
    
    % Cast a majority vote (only works in a two class world)
    class = sign(mean(data(ind(1:k), 3)));
end
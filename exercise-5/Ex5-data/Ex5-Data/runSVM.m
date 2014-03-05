function runSVM(data, kernel, C, sigma)
    
    % Scatter plot the data
    hold on;
    positive = data(:, 3) > 0;
    negative = data(:, 3) < 0;
    scatter(data(positive, 1), data(positive, 2));
    scatter(data(negative, 1), data(negative, 2));
    
    % Divide into testing and training
    N = size(data, 1);
    oracle = randperm(N);
    test = data(oracle < N/3, :);
    train = data(oracle >= N/3, :);
    
    [confusion, svmmodel] = classifysvm(train, test, kernel, C, sigma);
    
    confusion
    
    
end
function runCrossval
    data = load('circular.txt');
    
    res = zeros(3,3);
    
    % Fold assignment of 5 folds 1:5
    folds = mod(randperm(size(data, 1)), 5) + 1;
    
    i = 0;
    j = 0;
    
    for k = [5 10 15]
        i = i + 1;
        for m = {'manhattan' 'euclidean' 'infinity'}
            j = j + 1;
            for fold = 1:5
                train = fold ~= folds;
                C = kNN(data(train, :), data(~train, :), k, m);
                res(i, j) = res(i, j) + trace(C) / sum(C(:));
            end
        end
        j = 0;
    end
    
    res = res ./ 5;
    disp(res);
end
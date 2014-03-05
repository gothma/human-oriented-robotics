function scatterlabels(data, labels, means)
    d = size(data, 2);
    
    if d > 3
        error('Data dimension not displayable')
    end
    
    if size(data, 1) ~= size(labels)
        error('Number of data samples does not match number of labels')
    end
    
    labeltypes = unique(labels);
    

    for type = labeltypes'
        group = labels == type;
        if d == 2
            scatter(data(group, 1), data(group, 2));
        elseif d == 3
            scatter3(data(group, 1), data(group, 2), data(group, 3))
        end
    end
    
    
    if nargin == 3 && d == 2
        voronoi(means(:,1), means(:,2))
    end
    
end
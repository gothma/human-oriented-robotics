data = load('five-clusters.txt');


J = [];

kmax = 20;
for k = 1:kmax
    [~, ~, j] = kmeans(data(:,1:2), k);
    J = [J j(end)];
end

plot(1:kmax, J);

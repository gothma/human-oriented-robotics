data = load('five-clusters.txt');

[l, m, j] = kmeans(data(:,1:2),6);

hold on;
scatterlabels(data(:,1:2), l, m);
figure;
plot(1:size(j,2), j);

load('Ex2-data/data/distributions.mat')

mu = sum(data) / size(data, 1);
dist = data - repmat(mu, size(data,1), 1);
sigma = sum(dist .^ 2) / (size(data, 1) - 1);
stddev = sqrt(sigma);

thirdmoment = sum(dist .^ 3) / (size(data, 1));
fourthmoment = sum(dist .^ 4) / (size(data, 1));

bins = histc(data, -5:0.25:20);
normbins = bins ./ size(data, 1);
plot(-5:0.25:20, normbins, '.-');
legend('1','2','3','4','5')



hold all;

load('Ex1-data/scan.txt');
[x, y] = pol2cart(scan(:,1), scan(:,2));
plot(x, y)

% Preprocessing

truncated = scan(:,2) > 7.5;
cleanscan = scan(~truncated,:);
[x, y] = pol2cart(cleanscan(:,1), cleanscan(:,2));
plot(x, y)

% Break points

breaks = find(abs(diff(cleanscan(:,2))) > 0.3);
scatter(x(breaks), y(breaks))

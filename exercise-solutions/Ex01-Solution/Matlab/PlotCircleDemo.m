% ---------------- %
% Exercise 1.4.b   %
% ---------------- %

figure(2); clf; hold on; axis off;
for i = 1:100,
  x = rand*10-5;
  y = rand*10-5;
  r = rand*5;
  color = rand(3,1);
  plotcircle(x,y,r,color)
end;
axis equal;
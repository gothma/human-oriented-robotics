% Exercise 4
% 1.
  
function plotcircle(x,y,r,color)

  angle = linspace(0,2*pi,100);
  xcircle = x + r*sin(angle);
  ycircle = y + r*cos(angle);
  plot(xcircle,ycircle,'LineWidth',4,'Color',color);
  
end


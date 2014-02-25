function collision = checkedgecollision(qnew,robotradius,obs)

npoints = size(qnew.edgeq,2);
for i = 1:npoints,
  
  if checkcollision(qnew.edgeq(i,1:2),robotradius,obs),
    collision = true;
    break;
  else
    collision = false;
  end;
  
end;
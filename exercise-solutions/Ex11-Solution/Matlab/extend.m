function vnew = extend(qnear,qrand,motionprimitives,dt)

% ode parameters
tspan = [0 dt]; % solve from t=0 to t=delta
q0 = qnear.pose;
dmin = Inf;

nprimitives = size(motionprimitives,1);
for i = 1:nprimitives
  
  % generate the i-th motion primitive
  v     = motionprimitives(i,1);
  omega = motionprimitives(i,2);
  [T,Q] = ode45(@(t,q) diffdrivekinematics(t,q,v,omega),tspan,q0); % solve ODE

  d = norm(Q(end,1:2)'-qrand(1:2));
  if d < dmin,
    dmin = d;
    imin = i;
  end;
end;

velnew = motionprimitives(imin,1);
omeganew = motionprimitives(imin,2);
[Tnew,Qnew] = ode45(@(t,q) diffdrivekinematics(t,q,velnew,omeganew),tspan,q0); % solve ODE

vnew.id = -1;  % to indicate that it will be set later
vnew.pose = Qnew(end,:)';
vnew.edgeq = Qnew;
vnew.edgeu = [velnew omeganew];
vnew.pid = qnear.id;



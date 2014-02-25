function K = polykernel( xi,xj,order )
%POLYKERNEL Polynomial kernel

% make default order 3
if order < 3,
  order = 3;
end

K = xi'*xj;

for i = 2:order,
  K = K.* (1 + (xi'*xj));
end

end


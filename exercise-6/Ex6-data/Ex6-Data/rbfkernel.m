function K = rbfkernel( xi,xj,sigma )
%RBFKERNEL Simple RBF kernel

if sigma <= 0,
  error(message('Sigma must be greater than 0'));
else
  K = exp(-norm(xi - xj,2)^2 / (2*sigma^2));
end;


% K = exp(-(1/(2*sigma^2))...
%     * (repmat(sqrt(sum(u.^2,2).^2),1,size(v,1))...
%     -2 * (u*v') + repmat(sqrt(sum(v.^2,2)'.^2),size(u,1),1)))

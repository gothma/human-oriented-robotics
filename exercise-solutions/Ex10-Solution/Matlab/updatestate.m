function [x,P] = updatestate(xp,Pp,v,S,H)% Compute Kalman gainK = Pp*H'*inv(S);% Update state and state covariancex = xp + K*v;P = Pp - K*H*Pp;
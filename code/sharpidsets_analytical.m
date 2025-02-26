% 1. Set DGP
alpha = 0;
beta = 2;
meanx = [.1 .4 .6 .9];
    % Calculate c for Z=0 and Z=1
cmat = [c(meanx,alpha,beta,0) c(meanx,alpha,beta,1)];
    % Calculate znorm0 = E[X|Z=0] and znorm1 = E[X|Z=1]
znorm0 = mean(meanx(1:2));
znorm1 = mean(meanx(3:4));
znorm = [znorm0 znorm1];
    % Set tmin and tmax for Z=0 and Z=1
tmin0 = min([-beta*znorm0 beta*(1-znorm0)]);
tmin1 = min([-beta*znorm1 beta*(1-znorm1)]);
tmin = [tmin0 tmin1];
tmax0 = max([-beta*znorm0 beta*(1-znorm0)]);
tmax1 = max([-beta*znorm1 beta*(1-znorm1)]); 
tmax = [tmax0 tmax1];

% 2. Fow now, test findzero function
funneg = @(t) fneg(t, alpha, beta, cmat, znorm, tmax, 0);
test = fzero(funneg, [tmin0,0]);

function y=fneg(t, alpha, beta, cmat, znorm, tmax, z)
    alpha_z = alpha + beta*znorm(z+1);
    tmax = tmax(z+1);
    c_y = cmat(2,z+1);
    y=t*(Logit(alpha_z + t) - Logit(alpha_z + tmax))-c_y*((tmax-t)/tmax);
end

function y = Logit(x)
    y = cdf('Logistic',x);
end



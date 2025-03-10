% 1. Set DGP
alpha0 = 0;
beta0 = 2;
w = [55/70 15/70];
xstarsupp = [.1 .8 .2 .9];
    % Calculate c for Z=0 and Z=1
cmat = [c(xstarsupp,w,alpha0,beta0,0) c(xstarsupp,w,alpha0,beta0,1)];
    % Calculate znorm0 = E[X|Z=0] and znorm1 = E[X|Z=1]
znorm = [w(1)*xstarsupp(1)+(1-w(1))*xstarsupp(2) w(2)*xstarsupp(3)+(1-w(2))*xstarsupp(4)];

%%


% 2. Iterate over directions in (alpha, beta) space 
thetaincrement = .01;
thetagrid = 0:thetaincrement:2*pi;
results = zeros(length(thetagrid),2);
for i=1:length(thetagrid)
    theta = thetagrid(i);
    fundist = @(r) paramboundist(r,alpha0,beta0,theta,cmat,znorm,0);
    results(i,1) = fzero(fundist, 0); % remember the .1 is ad hoc for now
    fundist = @(r) paramboundist(r,alpha0,beta0,theta,cmat,znorm,1);
    results(i,2) = fzero(fundist, 0); % remember the .1 is ad hoc for now
    disp(i);
end

%% 
% 3. Take min over Z=0 and Z=1 boundaries and plot
paramboundary = min(results,[],2);

%%
function dist = paramboundist(r, alpha0, beta0, theta, cmat, znorm, zval)
    alpha = alpha0 + abs(r)*cos(theta);
    beta = beta0 + abs(r)*sin(theta);
    % Calculate distance to edge of admissible moment set
    z=zval;
    tmin = min([-beta*znorm(z+1) beta*(1-znorm(z+1))]) ;
    tmax = max([-beta*znorm(z+1) beta*(1-znorm(z+1))]);
    alpha_z = alpha + beta*znorm(z+1);
    c_x = cmat(1,z+1);
        % Find left x-value of boundary
    funneg = @(t) fneg(t, alpha, beta, cmat, znorm, tmax, z);
    left_tval = fzero(funneg, [tmin,0]);
    left_xval = (tmax/(tmax-left_tval))*Logit(alpha_z + left_tval) - ...
            (left_tval/(tmax-left_tval))*Logit(alpha_z+tmax);
        % Find right x-value of boundary
    funpos = @(t) fpos(t, alpha, beta, cmat, znorm, tmin, z);
    right_tval = fzero(funpos, [0,tmax]);
    right_xval = (-tmin/(right_tval-tmin))*Logit(alpha_z + right_tval) + ...
             (right_tval/(right_tval - tmin))*Logit(alpha_z + tmin);
        % Horizontal distance between c and closest boundary
    dist = min([c_x-left_xval,right_xval-c_x]);
end




function y=fneg(t, alpha, beta, cmat, znorm, tmax, z)
    alpha_z = alpha + beta*znorm(z+1);
    c_y = cmat(2,z+1);
    y=t*(tmax/(tmax-t))*(Logit(alpha_z + t) - Logit(alpha_z + tmax))-beta*c_y;
end

function y = fpos(t, alpha, beta, cmat, znorm, tmin, z)
    alpha_z = alpha + beta*znorm(z+1);
    c_y = cmat(2,z+1);
    y=t*(tmin/(t-tmin))*(Logit(alpha_z+tmin)-Logit(alpha_z+t))-beta*c_y;
end

function y = Logit(x)
    y = cdf('Logistic',x);
end













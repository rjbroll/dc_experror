%% 1. Set DGP
alpha0 = 0;
beta0 = 2;
w = [.5 .5];
xstarsupp = [.1 .4 .1 .4];
    % Calculate c for Z=0 and Z=1
cmat = [c(xstarsupp,w,alpha0,beta0,0) c(xstarsupp,w,alpha0,beta0,1)];
    % Calculate znorm0 = E[X|Z=0] and znorm1 = E[X|Z=1]
znorm = [w(1)*xstarsupp(1)+(1-w(1))*xstarsupp(2) w(2)*xstarsupp(3)+(1-w(2))*xstarsupp(4)];

%% 2. Iterate over directions in (alpha, beta) space 
thetaincrement = .0001;
thetagrid = 0:thetaincrement:2*pi ;
results = zeros(length(thetagrid),1);
sharpsearchlimit=10;
for i=1:length(thetagrid)
    theta = thetagrid(i);
    disp(theta);
    if paramboundist(sharpsearchlimit,alpha0,beta0,theta,cmat,znorm) < 0
        fundist = @(r) paramboundist(r,alpha0,beta0,theta,cmat,znorm);
        results(i) = fzero(fundist, [0,sharpsearchlimit]); % remember the end value is ad hoc for now
    else
        results(i) = missing;
    end
end

%% 3. Plot
plotx = results .* cos(thetagrid') + alpha0;
ploty = results .* sin(thetagrid') + beta0;


%% 4. Odds set
oddssearchlimit = 10;
oddsresults = zeros(length(thetagrid),1);
for i = 1:length(thetagrid)
    theta=thetagrid(i);
    if odds(alpha0,beta0,oddssearchlimit,theta,w,xstarsupp) < 0
        oddsfun = @(r) odds(alpha0,beta0,r,theta,w,xstarsupp);
        oddsresults(i) = fzero(oddsfun,[0,oddssearchlimit]);
    else 
        oddsresults(i) = missing;
    end
end 


oddsplotx = oddsresults .* cos(thetagrid') + alpha0;
oddsploty = oddsresults .* sin(thetagrid') + beta0;



%% 4. Bounding set
boundsearchlimit = 10;
boundresults = zeros(length(thetagrid),1);
for i = 1:length(thetagrid)
    theta=thetagrid(i);
    if bounding(alpha0,beta0,boundsearchlimit,theta,w,xstarsupp) < 0
        boundfun = @(r) bounding(alpha0,beta0,r,theta,w,xstarsupp);
        boundresults(i) = fzero(boundfun,[0,boundsearchlimit]);
    else 
        boundresults(i) = missing;
    end
end 

boundplotx = boundresults .* cos(thetagrid') + alpha0;
boundploty = boundresults .* sin(thetagrid') + beta0;

%% plot

% scatter(boundplotx, boundploty,8)
% hold on
% scatter(oddsplotx, oddsploty,8)
scatter(plotx, ploty, 8)
% hold off


%% test


%% Functions

function dist = paramboundist(r, alpha0, beta0, theta, cmat, znorm)
    alpha = alpha0 + r*cos(theta);
    beta = beta0 + r*sin(theta);
    % Calculate distance to edge of admissible moment set
    distvec = zeros(2);
    for z=0:1
        tmin = min([-beta*znorm(z+1) beta*(1-znorm(z+1))]) ;
        tmax = max([-beta*znorm(z+1) beta*(1-znorm(z+1))]);
        alpha_z = alpha + beta*znorm(z+1);
        c_x = cmat(1,z+1);
        c_y = cmat(2,z+1);
        extremey = (tmax/(tmax-tmin))*(tmin/beta)*Logit(alpha_z + tmin) - ...
            (tmin/(tmax-tmin))*(tmax/beta)*Logit(alpha_z+tmax);
        if (min([extremey 0]) <= c_y) && (c_y <= max([extremey 0]))
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
            distvec(1,z+1) = c_x-left_xval;
            distvec(2,z+1) = right_xval-c_x;
        else 
            distvec(1,z+1) = -10;
            distvec(2,z+1) = -10;
        end
    end
    dist = min(distvec,[],"all");
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
    y = 1/(1+exp(-(x)));
end













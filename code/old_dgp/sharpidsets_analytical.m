%% 1. Set DGP
alpha0 = 0;
beta0 = 1;
agent_r2 = .6;
econ_relr2 = .27;
c_a = (1+sqrt(agent_r2))/2;
c_e = (1+sqrt(econ_relr2))/2;
w = [c_e c_e];
xstarsupp = [c_a 1-c_a 1-c_a c_a];
    % Calculate c for Z=0 and Z=1
cmat = [c(xstarsupp,w,alpha0,beta0,0) c(xstarsupp,w,alpha0,beta0,1)];
    % Calculate znorm0 = E[X|Z=0] and znorm1 = E[X|Z=1]
znorm = [w(1)*xstarsupp(1)+(1-w(1))*xstarsupp(2) w(2)*xstarsupp(3)+(1-w(2))*xstarsupp(4)];

%% 2. Iterate over directions in (alpha, beta) space 
thetaincrement = .001;
thetagrid = 0:thetaincrement:2*pi ;
results = zeros(length(thetagrid),1);
sharpsearchlimit=.1;
for i=1:length(thetagrid)
    theta = thetagrid(i);
    disp(theta);
    if paramboundist(sharpsearchlimit,alpha0,beta0,theta,cmat,znorm) < 0
        fundist = @(r) paramboundist(r,alpha0,beta0,theta,cmat,znorm);
        results(i) = fzero(fundist, [0,sharpsearchlimit]);
    else
        results(i) = missing;
    end
end

plotx = results .* cos(thetagrid') + alpha0;
ploty = results .* sin(thetagrid') + beta0;
scatter(plotx, ploty, 5,"MarkerEdgeColor","#A2142F")


%% 4. Odds set
oddssearchlimit = 1;
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

scatter(oddsplotx, oddsploty, 5)

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

scatter(boundplotx,boundploty,5)

















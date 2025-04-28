%% 1. Set DGP
alpha0 = 0;
beta0 = 1;
c_e = .65;
c_a = .8;
w = [c_e c_e];
xstarsupp = [c_a 1-c_a 1-c_a c_a];
    % Calculate c for Z=0 and Z=1
cmat = [c(xstarsupp,w,alpha0,beta0,0) c(xstarsupp,w,alpha0,beta0,1)];
    % Calculate znorm0 = E[X|Z=0] and znorm1 = E[X|Z=1]
znorm = [w(1)*xstarsupp(1)+(1-w(1))*xstarsupp(2) w(2)*xstarsupp(3)+(1-w(2))*xstarsupp(4)];

% %% test R^2 concepts with simulated data - it works!
% N=10000000;
% Xp = rand(N,1) <= xstarsupp;
% I = ceil(rand(N,1)*4);
% X = zeros(N,1);
% for i=1:N
%     X(i) = Xp(i,I(i));
% end
% % Create Z
% Z = I > 2.5;
% % Create U
% pd = makedist('Logistic',0,1);
% U = random(pd,N,1);
% % Create Xstar
% Xstar = zeros(N,1);
% for i=1:N
%     Xstar(i) = xstarsupp(I(i));
% end
% % Create Xecon
% Xecon = Z * (c_e*(1-c_a)+(1-c_e)*c_a) + (1-Z)*(c_e*c_a+(1-c_e)*(1-c_a));
% % Create Y
% Y = alpha0 + beta0*Xstar - U >= 0;
% % Create R^2s for agent and econometrician
% rsq_agent = (sum((Xstar - mean(X)).^2))/(sum((X - mean(X)).^2));
% rsq_econ = (sum((Xecon - mean(X)).^2))/(sum((X-mean(X)).^2));


%% 2. Find length of sharp ID set in beta direction, fixing alpha=alpha0 
thetagrid = [pi/2 3*pi/2] ;
results = zeros(2,1);
sharpsearchlimit=.1;
for i=1:2
    theta = thetagrid(i);
    disp(theta);
    if paramboundist(sharpsearchlimit,alpha0,beta0,theta,cmat,znorm) < 0
        fundist = @(r) paramboundist(r,alpha0,beta0,theta,cmat,znorm);
        results(i) = fzero(fundist, [0,sharpsearchlimit]);
    else
        results(i) = missing;
    end
end

%% 3. Plot
plotx = results .* cos(thetagrid') + alpha0;
ploty = results .* sin(thetagrid') + beta0;
scatter(plotx, ploty, 5,"MarkerEdgeColor","#A2142F")

%% test
disp(cos(pi));


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

% scatter(boundplotx, boundploty,5)
% hold on
% scatter(oddsplotx, oddsploty,8)
% hold on
scatter(plotx, ploty, 5,"MarkerEdgeColor","#A2142F")
% hold off


%% test
test = bounding(alpha0,beta0,0,theta,w,xstarsupp);
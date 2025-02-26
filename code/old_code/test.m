%% 1. Simulate Data

% Set seed
rng(16);

% Set true parameter values
alpha = 0;
beta = 2;

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(1000000,[.1 .4 .6 .9],alpha,beta);

%% 2. Compute Sharp ID set
% parameters
xstepsize = .1;
thetastepsize = .1;
phistepsize = .1;

% Create directional grids
thetagrid = -(pi)/2:thetastepsize:(pi)/2;
phigrid = -(pi):phistepsize:(pi);
agrid = zeros(length(thetagrid),length(phigrid),3);
for i = 1:length(thetagrid)
    for j = 1:length(phigrid)
        agrid(i,j,1) = cos(thetagrid(i))*cos(phigrid(j)); % x-coordinate
        agrid(i,j,2) = cos(thetagrid(i))*sin(phigrid(j)); % y-coordinate
        agrid(i,j,3) = sin(thetagrid(i)); % z-coordinate
    end
end


% Set up znorm and cz values for Z = 0,1
znormvec = zeros(2,1);
znormvec(1) = mean(X(Z==0));
znormvec(2) = mean(X(Z==1));
czvec = zeros(3,2);
czvec(:,1) = c(X,Y,Z,0,znormvec(1));
czvec(:,2) = c(X,Y,Z,1,znormvec(2));
znorm = znormvec(1); % fiddle here with Z=0,1
cz = czvec(:,1); % fiddle here with Z=0,1

% Create xgrid
xgrid = -znorm:xstepsize:1-znorm;

%% Run

% Plot over xgrid to get sense of shape
a = squeeze(agrid(16,26,:)); % fiddle here with direction a
sup = zeros(length(xgrid),1);
for k = 1:length(xgrid)
    sup(k) = a'*(F(znorm,xgrid(k),-.12,2.12) - cz); %fiddle here with (alphatest, betatest)
end

plot(xgrid,sup);

%% 

test2 = max(0)














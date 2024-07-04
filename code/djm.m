%%%%% Dickstein, Jeon, Morales %%%%%%

%% 1. Simulate data

% Set seed
rng(16);

% Set alpha and beta
alpha = 3;
beta = 2;

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(100000,[.1 .4 .6 .9],alpha,beta);

%% 2. Compute Odds-based ID set
alphagrid = alpha - .1:.02:alpha + .1;
betagrid = beta + .2:-.04:beta - .16;
resultsgrid_odds = zeros(length(betagrid),length(alphagrid));
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        resultsgrid_odds(i,j) = odds(X,Y,Z,alphagrid(j),betagrid(i));
    end
end

%% Heatmap of Odds-based ID set
% h=heatmap(alphagrid,betagrid,resultsgrid_odds);
% customxlabels = string(alphagrid);
% customxlabels(mod(alphagrid,.5)~=0) = ' ';
% customylabels = string(betagrid);
% customylabels(mod(betagrid,1)~=0) = ' ';
% h.XDisplayLabels = customxlabels;
% h.YDisplayLabels = customylabels;
% h.YLabel = 'beta';
% h.XLabel = 'alpha';


%% 3. Compute Bounding-based ID set

meanvec = zeros(4,1);
meanvec(1) = mean(X(Z==0 & Y==0));
meanvec(2) = mean(X(Z==1 & Y==0));
meanvec(3) = mean(X(Z==0 & Y==1));
meanvec(4) = mean(X(Z==1 & Y==1));

% Compute ID set
alphagrid = alpha - .1:.02:alpha + .1;
betagrid = beta + .2:-.04:beta - .16;
resultsgrid_bound = zeros(length(betagrid),length(alphagrid));
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        resultsgrid_bound(i,j) = bounding(X,Y,Z,alphagrid(j),betagrid(i),meanvec);
    end
end

%% Heatmap of Bounding-based ID set
% hbound=heatmap(alphagrid,betagrid,resultsgrid_bound);
% hbound.YLabel = 'beta';
% hbound.XLabel = 'alpha';

%% 4. Compute Intersection of Odds and Bounding ID sets
resultsgrid_both = zeros(length(betagrid),length(alphagrid));
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        resultsgrid_both(i,j) = resultsgrid_odds(i,j) * resultsgrid_bound(i,j);
    end
end

%% Heatmap of Intersection
hboth = heatmap(alphagrid,betagrid,resultsgrid_both);
hboth.YLabel = 'beta';
hboth.XLabel = 'alpha';






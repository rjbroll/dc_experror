%%%%% Dickstein, Jeon, Morales %%%%%%

%% 1. Simulate data

% Set seed
rng(16);

% Simulate data
[X,I,Z,U,Xstar,Y] = simdata(100000,[.1 .4 .6 .9],0,1);

%% 2. Compute Odds-based ID set
alphagrid = -1.5:.1:1.5;
betagrid = 4:-.1:-2;
resultsgrid_odds = zeros(length(betagrid),length(alphagrid));
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        resultsgrid_odds(i,j) = odds(X,Y,Z,alphagrid(j),betagrid(i));
    end
end

%% Heatmap of Odds-based ID set
h=heatmap(alphagrid,betagrid,resultsgrid_odds);
customxlabels = string(alphagrid);
customxlabels(mod(alphagrid,.5)~=0) = ' ';
customylabels = string(betagrid);
customylabels(mod(betagrid,1)~=0) = ' ';
h.XDisplayLabels = customxlabels;
h.YDisplayLabels = customylabels;
h.YLabel = 'beta';
h.XLabel = 'alpha';


%% 3. Compute Bounding-based ID set

% Simulate data - larger sample size needed for precision
[X,I,Z,U,Xstar,Y] = simdata(10000000,[.1 .4 .6 .9],0,1);

% Compute ID set
alphagrid = -.02:.01:.02;
betagrid = 1.03:-.01:.97;
resultsgrid_bound = zeros(length(betagrid),length(alphagrid));
for i = 1:length(betagrid)
    for j = 1:length(alphagrid)
        resultsgrid_bound(i,j) = bounding(X,Y,Z,alphagrid(j),betagrid(i));
    end
end

%% Heatmap of Bounding-based ID set
hbound=heatmap(alphagrid,betagrid,resultsgrid_bound);
hbound.YLabel = 'beta';
hbound.XLabel = 'alpha';





